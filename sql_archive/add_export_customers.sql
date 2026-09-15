-- ============================================================
-- عملاء التصدير — EXPORT CUSTOMERS
--
-- قسم ثالث مستقل تماماً عن customers (عملاء الحياة العلمية) و
-- online_customers (عملاء الأونلاين) — لعملاء خارج الأردن. سجل
-- بيانات فقط حالياً، بدون ربط بموديول طلبات.
--
-- نفس بنية جدول customers تقريباً (بيانات شركة + مسؤولَين
-- للتواصل) لكن باستبدال المحافظة/المنطقة (خاصة بالأردن) بحقل
-- "الدولة" الحر.
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.
-- يفترض وجود public.has_perm(text) و public.get_my_role() و
-- public.update_updated_at() و public.number_sequences مسبقاً.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS public.export_customers (
  id              uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  customer_code   text UNIQUE,
  name            text NOT NULL,
  phone           text,
  alt_phone       text,
  fax             text,
  email           text,
  website         text,
  country         text,
  address         text,
  notes           text,
  category        text,
  tags            text,
  assigned_to     uuid REFERENCES public.profiles(id),
  rep_name        text,
  contact1_name text, contact1_last_name text, contact1_title text,
  contact1_phone text, contact1_mobile2 text, contact1_ext text, contact1_email text, contact1_notes text,
  contact2_name text, contact2_last_name text, contact2_title text,
  contact2_phone text, contact2_mobile2 text, contact2_ext text, contact2_email text, contact2_notes text,
  created_by      uuid REFERENCES public.profiles(id),
  created_at      timestamptz NOT NULL DEFAULT now(),
  updated_at      timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.export_customers REPLICA IDENTITY FULL;

DROP TRIGGER IF EXISTS trg_export_customers_updated_at ON public.export_customers;
CREATE TRIGGER trg_export_customers_updated_at BEFORE UPDATE ON public.export_customers
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- ── الترقيم التلقائي EX-0001 (نفس نمط customer_sequence_migration.sql) ──

INSERT INTO public.number_sequences (id, prefix, current_value, year)
VALUES ('export_customer', 'EX', 0, EXTRACT(YEAR FROM NOW())::int)
ON CONFLICT (id) DO NOTHING;

CREATE OR REPLACE FUNCTION public.generate_export_customer_number()
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  next_val INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'export_customer'
    RETURNING current_value INTO next_val;

  RETURN 'EX-' || LPAD(next_val::TEXT, 4, '0');
END;
$$;

GRANT EXECUTE ON FUNCTION public.generate_export_customer_number() TO authenticated;

-- ── الصلاحيات (RLS) — صلاحيات export_customers_* مستقلة عن customers_* ──

ALTER TABLE public.export_customers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS export_customers_select ON public.export_customers;
CREATE POLICY export_customers_select ON public.export_customers FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS export_customers_insert ON public.export_customers;
CREATE POLICY export_customers_insert ON public.export_customers FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('export_customers_create'))
  )
);

DROP POLICY IF EXISTS export_customers_update ON public.export_customers;
CREATE POLICY export_customers_update ON public.export_customers FOR UPDATE USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('export_customers_edit'))
);

DROP POLICY IF EXISTS export_customers_delete ON public.export_customers;
CREATE POLICY export_customers_delete ON public.export_customers FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('export_customers_delete'))
);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.export_customers TO authenticated;

ALTER PUBLICATION supabase_realtime ADD TABLE public.export_customers;

COMMIT;
