-- ─────────────────────────────────────────────────────────────
-- Per-item tax percentage for quotation_items
-- شغّل هذا مرة واحدة في Supabase SQL Editor
-- ─────────────────────────────────────────────────────────────

ALTER TABLE public.quotation_items
  ADD COLUMN IF NOT EXISTS tax_pct NUMERIC(5,2) DEFAULT 16;

-- البنود القديمة تأخذ 16% (النسبة الافتراضية التاريخية)
UPDATE public.quotation_items
SET tax_pct = 16
WHERE tax_pct IS NULL;
