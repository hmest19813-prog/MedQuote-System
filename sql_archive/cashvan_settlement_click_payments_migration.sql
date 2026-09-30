-- تفصيل إضافي على تسوية الكاش فان: المبلغ المستلم "نقداً" فعلياً ممكن يكون
-- أقل من الصافي المطلوب، والفرق يتفسّر بطلبيات دُفعت مباشرة "كليك" لا نقداً
-- (من ضمن نفس طلبيات الفترة) — فبنسجّلها كبنود مرتبطة بالطلبية الأصلية.
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor
-- (بعد cashvan_settlement_details_migration.sql).

BEGIN;

ALTER TABLE public.cashvan_settlements
  ADD COLUMN IF NOT EXISTS click_total numeric(12,3) NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS public.cashvan_settlement_click_payments (
  id             uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  settlement_id  uuid NOT NULL REFERENCES public.cashvan_settlements(id) ON DELETE CASCADE,
  sale_id        uuid REFERENCES public.cashvan_sales(id),
  sort_order     integer DEFAULT 0,
  amount         numeric(12,3) NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_cvscp_settlement ON public.cashvan_settlement_click_payments USING btree (settlement_id);

ALTER TABLE public.cashvan_settlement_click_payments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS cvscp_select ON public.cashvan_settlement_click_payments;
CREATE POLICY cvscp_select ON public.cashvan_settlement_click_payments FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS cvscp_write ON public.cashvan_settlement_click_payments;
CREATE POLICY cvscp_write ON public.cashvan_settlement_click_payments FOR ALL USING (
  EXISTS (SELECT 1 FROM public.cashvan_settlements t WHERE t.id = cashvan_settlement_click_payments.settlement_id AND (
    t.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit') OR public.has_perm('cashvan_delete')))
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.cashvan_settlements t WHERE t.id = cashvan_settlement_click_payments.settlement_id AND (
    t.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit') OR public.has_perm('cashvan_delete')))
  ))
);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.cashvan_settlement_click_payments TO authenticated;

COMMIT;
