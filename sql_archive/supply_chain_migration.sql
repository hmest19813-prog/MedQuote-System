-- ============================================================
-- MedQuote Pro — سلسلة التوريد (استيراد): ملفات توريد + مراحلها
--
-- كل "ملف توريد" (supply_files) يمثل رحلة استيراد مستقلة (قد ترتبط
-- بمورد وبأمر شراء موجود، أو تكون مستقلة تماماً). عند إنشاء الملف
-- تُزرع تلقائياً 10 مراحل ثابتة (supply_file_stages) بنفس ترتيب
-- سلسلة التوريد المتفق عليها:
--   1) طلب تسعير  2) عرض سعر من المورد  3) اعتماد فاتورة المورد
--   4) الشحن (علينا/عليه)  5) تحويل الدفعة حسب الاتفاق
--   6) شحن البضاعة  7) وصول المعبر الحدودي
--   8) التخليص الجمركي: نقل لمناطق حرة وتخزين
--   9) التخليص الجمركي: مستودعاتنا عمان
--   10) التخليص الجمركي: تنازل بوالص
--
-- شغّله كاملاً دفعة واحدة في Supabase SQL Editor.
-- ============================================================

BEGIN;

-- ══════════════════════════════════════════════
-- الترقيم التلقائي SC-YYYY-NNNN
-- ══════════════════════════════════════════════
CREATE SEQUENCE IF NOT EXISTS public.supply_file_number_seq START 1;

CREATE OR REPLACE FUNCTION public.next_supply_file_number() RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN 'SC-' || to_char(CURRENT_DATE,'YYYY') || '-' || LPAD(nextval('public.supply_file_number_seq')::TEXT, 4, '0');
END;
$$;

CREATE OR REPLACE FUNCTION public.set_supply_file_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    NEW.number := public.next_supply_file_number();
  END IF;
  RETURN NEW;
END;
$$;

-- ══════════════════════════════════════════════
-- الجداول
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.supply_files (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    number text,
    supplier_id uuid REFERENCES public.suppliers(id),
    supplier_name text,
    po_id uuid REFERENCES public.purchase_orders(id),
    po_number text,
    description text,
    origin_country text,
    currency text DEFAULT 'USD',
    total_value numeric(12,3) DEFAULT 0,
    status text DEFAULT 'in_progress' CHECK (status IN ('in_progress','completed','cancelled')),
    notes text,
    created_by uuid,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);
ALTER TABLE public.supply_files OWNER TO postgres;
ALTER TABLE ONLY public.supply_files REPLICA IDENTITY FULL;

DROP TRIGGER IF EXISTS trg_set_supply_file_number ON public.supply_files;
CREATE TRIGGER trg_set_supply_file_number BEFORE INSERT ON public.supply_files
  FOR EACH ROW EXECUTE FUNCTION public.set_supply_file_number();

CREATE TABLE IF NOT EXISTS public.supply_file_stages (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    file_id uuid NOT NULL REFERENCES public.supply_files(id) ON DELETE CASCADE,
    stage_key text NOT NULL,
    seq integer NOT NULL,
    status text DEFAULT 'pending' CHECK (status IN ('pending','in_progress','done')),
    stage_date date,
    value text,
    notes text,
    updated_by uuid,
    updated_at timestamptz DEFAULT now(),
    UNIQUE(file_id, stage_key)
);
ALTER TABLE public.supply_file_stages OWNER TO postgres;
ALTER TABLE ONLY public.supply_file_stages REPLICA IDENTITY FULL;

-- ══════════════════════════════════════════════
-- RLS — نفس نمط suppliers/purchase_orders
-- (has_perm('supply_chain_access'/'supply_chain_create'/'supply_chain_edit'/'supply_chain_delete'))
-- ══════════════════════════════════════════════
ALTER TABLE public.supply_files ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.supply_file_stages ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS supply_files_select ON public.supply_files;
CREATE POLICY supply_files_select ON public.supply_files FOR SELECT TO authenticated USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('supply_chain_access'))
  )
);
DROP POLICY IF EXISTS supply_files_insert ON public.supply_files;
CREATE POLICY supply_files_insert ON public.supply_files FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('supply_chain_create'))
);
DROP POLICY IF EXISTS supply_files_update ON public.supply_files;
CREATE POLICY supply_files_update ON public.supply_files FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('supply_chain_edit'))
);
DROP POLICY IF EXISTS supply_files_delete ON public.supply_files;
CREATE POLICY supply_files_delete ON public.supply_files FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('supply_chain_delete'))
);

DROP POLICY IF EXISTS supply_stages_select ON public.supply_file_stages;
CREATE POLICY supply_stages_select ON public.supply_file_stages FOR SELECT TO authenticated USING (
  EXISTS (SELECT 1 FROM public.supply_files f WHERE f.id = supply_file_stages.file_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('supply_chain_access'))
  ))
);
DROP POLICY IF EXISTS supply_stages_write ON public.supply_file_stages;
CREATE POLICY supply_stages_write ON public.supply_file_stages FOR ALL TO authenticated USING (
  EXISTS (SELECT 1 FROM public.supply_files f WHERE f.id = supply_file_stages.file_id AND (
    f.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('supply_chain_edit') OR public.has_perm('supply_chain_create')))
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.supply_files f WHERE f.id = supply_file_stages.file_id AND (
    f.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('supply_chain_edit') OR public.has_perm('supply_chain_create')))
  ))
);

-- ══════════════════════════════════════════════
-- صلاحيات الوصول المباشر من العميل (Supabase client)
-- ══════════════════════════════════════════════
GRANT SELECT, INSERT, UPDATE, DELETE ON public.supply_files TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.supply_file_stages TO authenticated;
GRANT USAGE, SELECT ON SEQUENCE public.supply_file_number_seq TO authenticated;
GRANT EXECUTE ON FUNCTION public.next_supply_file_number() TO authenticated;

-- Realtime (اختياري لكن متبع بباقي جداول النظام الحساسة)
ALTER PUBLICATION supabase_realtime ADD TABLE public.supply_files;
ALTER PUBLICATION supabase_realtime ADD TABLE public.supply_file_stages;

COMMIT;

-- ══════════════════════════════════════════════
-- تحقق سريع بعد التشغيل
-- ══════════════════════════════════════════════
SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public' AND tablename IN ('supply_files','supply_file_stages')
ORDER BY tablename, cmd;
