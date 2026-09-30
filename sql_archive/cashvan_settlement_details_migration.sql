-- تفصيل أكثر لتسوية الكاش فان: صافي المبلغ المطلوب تسليمه = إجمالي فاتورة
-- فترة الطلبيات (X) ناقص الخصومات (أجور توصيل = 2.5 د.أ × عدد الطلبيات،
-- افتراضياً وقابلة للتغيير + مستحقات أخرى تُدخل يدوياً كبنود منفصلة).
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor (بعد cashvan_migration.sql).

BEGIN;

ALTER TABLE public.cashvan_settlements
  ADD COLUMN IF NOT EXISTS period_from         date,
  ADD COLUMN IF NOT EXISTS period_to           date,
  ADD COLUMN IF NOT EXISTS gross_amount        numeric(12,3) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS orders_count        integer       NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS delivery_rate       numeric(12,3) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS delivery_deduction  numeric(12,3) NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS other_deductions    numeric(12,3) NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS public.cashvan_settlement_deductions (
  id             uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  settlement_id  uuid NOT NULL REFERENCES public.cashvan_settlements(id) ON DELETE CASCADE,
  sort_order     integer DEFAULT 0,
  label          text NOT NULL,
  amount         numeric(12,3) NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_cvsd_settlement ON public.cashvan_settlement_deductions USING btree (settlement_id);

ALTER TABLE public.cashvan_settlement_deductions ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS cvsd_select ON public.cashvan_settlement_deductions;
CREATE POLICY cvsd_select ON public.cashvan_settlement_deductions FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS cvsd_write ON public.cashvan_settlement_deductions;
CREATE POLICY cvsd_write ON public.cashvan_settlement_deductions FOR ALL USING (
  EXISTS (SELECT 1 FROM public.cashvan_settlements t WHERE t.id = cashvan_settlement_deductions.settlement_id AND (
    t.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit') OR public.has_perm('cashvan_delete')))
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.cashvan_settlements t WHERE t.id = cashvan_settlement_deductions.settlement_id AND (
    t.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit') OR public.has_perm('cashvan_delete')))
  ))
);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.cashvan_settlement_deductions TO authenticated;

COMMIT;
