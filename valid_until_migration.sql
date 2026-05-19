-- ============================================================
-- MedQuote Pro — Valid Until Migration
-- يضيف حقل تاريخ صلاحية العرض (اختياري)
-- شغّله في Supabase → SQL Editor
-- ============================================================

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS valid_until DATE;

-- تحقق من النتيجة
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'quotations'
  AND column_name = 'valid_until';
