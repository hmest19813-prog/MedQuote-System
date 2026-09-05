-- ============================================================
-- MedQuote Pro — موديول إدارة العقارات (المرحلة 1)
-- عقارات + وحدات + مستأجرين + عقود، بدون دفعات/مصاريف (تُبنى بمرحلة لاحقة)
--
-- الوصول مقتصر على شخصين بعينهما فقط (مو دور admin ومو صلاحية موظف عامة):
-- Dr. Mohammad U Jawabreh + Eng. Osama Alawy — عبر public.is_properties_user()
-- اللي بيتحقق من auth.uid() مباشرة (uuid كل واحد فيهم مكتوب داخل الدالة تحت).
--
-- الملف كامل قابل لإعادة التشغيل بأمان (idempotent) — لو انفّذ جزء منه سابقاً
-- (مثلاً بسبب خطأ بمنتصف الطريق) ما رح يفشل، رح يكمل من نفس النقطة.
--
-- شغّله كاملاً دفعة واحدة في Supabase SQL Editor.
-- ============================================================

BEGIN;

-- ══════════════════════════════════════════════
-- 0) pgcrypto (لازم لتشفير باسورد الموديول)
-- ══════════════════════════════════════════════
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;

-- ══════════════════════════════════════════════
-- 1) الجداول
-- ══════════════════════════════════════════════

CREATE TABLE IF NOT EXISTS public.properties (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  type text NOT NULL CHECK (type IN ('single','building')),
  address text,
  city text,
  notes text,
  created_by uuid REFERENCES public.profiles(id),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.property_units (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  property_id uuid NOT NULL REFERENCES public.properties(id) ON DELETE CASCADE,
  unit_number text,
  area numeric,
  status text NOT NULL DEFAULT 'vacant' CHECK (status IN ('vacant','occupied','maintenance')),
  notes text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.property_tenants (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name text NOT NULL,
  phone text,
  id_number text,
  email text,
  notes text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.property_contracts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  unit_id uuid NOT NULL REFERENCES public.property_units(id) ON DELETE CASCADE,
  tenant_id uuid NOT NULL REFERENCES public.property_tenants(id) ON DELETE RESTRICT,
  start_date date NOT NULL,
  end_date date NOT NULL,
  rent_amount numeric NOT NULL,
  payment_cycle text NOT NULL DEFAULT 'monthly' CHECK (payment_cycle IN ('monthly','quarterly','yearly')),
  status text NOT NULL DEFAULT 'active' CHECK (status IN ('active','expired','terminated')),
  contract_file_url text,
  created_by uuid REFERENCES public.profiles(id),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS property_units_property_id_idx ON public.property_units(property_id);
CREATE INDEX IF NOT EXISTS property_contracts_unit_id_idx ON public.property_contracts(unit_id);
CREATE INDEX IF NOT EXISTS property_contracts_tenant_id_idx ON public.property_contracts(tenant_id);

-- ══════════════════════════════════════════════
-- 2) updated_at trigger (يعيد استخدام public.update_updated_at() الموجودة)
-- ══════════════════════════════════════════════

DROP TRIGGER IF EXISTS properties_set_updated_at ON public.properties;
CREATE TRIGGER properties_set_updated_at BEFORE UPDATE ON public.properties
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
DROP TRIGGER IF EXISTS property_units_set_updated_at ON public.property_units;
CREATE TRIGGER property_units_set_updated_at BEFORE UPDATE ON public.property_units
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
DROP TRIGGER IF EXISTS property_tenants_set_updated_at ON public.property_tenants;
CREATE TRIGGER property_tenants_set_updated_at BEFORE UPDATE ON public.property_tenants
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
DROP TRIGGER IF EXISTS property_contracts_set_updated_at ON public.property_contracts;
CREATE TRIGGER property_contracts_set_updated_at BEFORE UPDATE ON public.property_contracts
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- ══════════════════════════════════════════════
-- 3) توليد وحدة تلقائية للعقار المفرد (type='single')
-- ══════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.property_create_default_unit()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.type = 'single' THEN
    INSERT INTO public.property_units (property_id) VALUES (NEW.id);
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS properties_after_insert_default_unit ON public.properties;
CREATE TRIGGER properties_after_insert_default_unit
  AFTER INSERT ON public.properties
  FOR EACH ROW EXECUTE FUNCTION public.property_create_default_unit();

-- ══════════════════════════════════════════════
-- 4) الموديول مقتصر على شخصين بعينهما فقط (مو صلاحية عامة، مو حسب الدور)
--    د. محمد جوابرة + المهندس أسامة علاوي
-- ══════════════════════════════════════════════

CREATE OR REPLACE FUNCTION public.is_properties_user()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT auth.uid() IN (
    '445bc65d-256f-48d3-9367-464a408e657b'::uuid, -- Dr. Mohammad U Jawabreh
    'ee095348-a2de-4906-a078-0e8a3f3560a9'::uuid   -- Eng. Osama Alawy
  );
$$;

GRANT EXECUTE ON FUNCTION public.is_properties_user() TO authenticated;

CREATE TABLE IF NOT EXISTS public.property_module_settings (
  id boolean PRIMARY KEY DEFAULT true CHECK (id = true),
  password_hash text,
  updated_at timestamptz DEFAULT now()
);

CREATE OR REPLACE FUNCTION public.properties_set_password(p_password text)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NOT public.is_properties_user() THEN
    RAISE EXCEPTION 'غير مصرح';
  END IF;
  IF p_password IS NULL OR length(p_password) < 4 THEN
    RAISE EXCEPTION 'الباسورد قصير جداً';
  END IF;
  INSERT INTO public.property_module_settings (id, password_hash, updated_at)
  VALUES (true, extensions.crypt(p_password, extensions.gen_salt('bf')), now())
  ON CONFLICT (id) DO UPDATE SET password_hash = EXCLUDED.password_hash, updated_at = now();
  RETURN true;
END;
$$;

GRANT EXECUTE ON FUNCTION public.properties_set_password(text) TO authenticated;

CREATE OR REPLACE FUNCTION public.properties_verify_password(p_password text)
RETURNS boolean
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_hash text;
BEGIN
  IF NOT public.is_properties_user() THEN
    RETURN false;
  END IF;
  SELECT password_hash INTO v_hash FROM public.property_module_settings WHERE id = true;
  IF v_hash IS NULL THEN
    RETURN false; -- ما تحدد باسورد بعد
  END IF;
  RETURN extensions.crypt(p_password, v_hash) = v_hash;
END;
$$;

GRANT EXECUTE ON FUNCTION public.properties_verify_password(text) TO authenticated;

-- ══════════════════════════════════════════════
-- 5) RLS — مقتصرة على is_properties_user() فقط (مو دور، مو صلاحية عامة)
-- ══════════════════════════════════════════════

ALTER TABLE public.properties ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.property_units ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.property_tenants ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.property_contracts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.property_module_settings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS properties_policy ON public.properties;
CREATE POLICY properties_policy ON public.properties USING (
  public.is_properties_user()
) WITH CHECK (
  public.is_properties_user()
);

DROP POLICY IF EXISTS property_units_policy ON public.property_units;
CREATE POLICY property_units_policy ON public.property_units USING (
  public.is_properties_user()
) WITH CHECK (
  public.is_properties_user()
);

DROP POLICY IF EXISTS property_tenants_policy ON public.property_tenants;
CREATE POLICY property_tenants_policy ON public.property_tenants USING (
  public.is_properties_user()
) WITH CHECK (
  public.is_properties_user()
);

DROP POLICY IF EXISTS property_contracts_policy ON public.property_contracts;
CREATE POLICY property_contracts_policy ON public.property_contracts USING (
  public.is_properties_user()
) WITH CHECK (
  public.is_properties_user()
);

-- ما حدا يلمس جدول الباسورد مباشرة — بس عبر الدوال الـ SECURITY DEFINER فوق
DROP POLICY IF EXISTS property_module_settings_no_direct_access ON public.property_module_settings;
CREATE POLICY property_module_settings_no_direct_access ON public.property_module_settings
  USING (false) WITH CHECK (false);

-- ══════════════════════════════════════════════
-- 6) Grants (لازم صراحة حتى مع RLS مفعّلة)
-- ══════════════════════════════════════════════

GRANT SELECT, INSERT, UPDATE, DELETE ON public.properties TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.property_units TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.property_tenants TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.property_contracts TO authenticated;
-- property_module_settings: بدون GRANT مباشر للـ authenticated — الوصول فقط عبر RPC الـ SECURITY DEFINER

-- ══════════════════════════════════════════════
-- تحقق سريع بعد التشغيل
-- ══════════════════════════════════════════════
SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('properties','property_units','property_tenants','property_contracts','property_module_settings')
ORDER BY tablename, cmd;

COMMIT;
