-- ============================================================
-- MedQuote Pro — Payments Migration
-- ينشئ جدول الدفعات لتتبع مدفوعات الفواتير
-- شغّله في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.payments (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  quotation_id   UUID        NOT NULL REFERENCES public.quotations(id) ON DELETE CASCADE,
  amount         NUMERIC     NOT NULL CHECK (amount > 0),
  payment_date   DATE        NOT NULL DEFAULT CURRENT_DATE,
  method         TEXT        DEFAULT 'تحويل بنكي',
  reference_no   TEXT,
  notes          TEXT,
  created_by     UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at     TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "payments_select" ON public.payments;
DROP POLICY IF EXISTS "payments_insert" ON public.payments;
DROP POLICY IF EXISTS "payments_delete" ON public.payments;

CREATE POLICY "payments_select" ON public.payments
  FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY "payments_insert" ON public.payments
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "payments_delete" ON public.payments
  FOR DELETE USING (get_my_role() IN ('admin', 'manager'));

CREATE INDEX IF NOT EXISTS payments_quotation_id_idx ON public.payments(quotation_id);

-- تحقق
SELECT column_name, data_type FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'payments'
ORDER BY ordinal_position;
