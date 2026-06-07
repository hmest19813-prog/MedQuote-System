-- ============================================================
-- MedQuote Pro — Contact Fields Migration
-- يضيف حقول الكنية والموبايل الثانوي للشخصين المسؤولين
-- شغّله في Supabase → SQL Editor
-- ============================================================

ALTER TABLE public.customers
  ADD COLUMN IF NOT EXISTS contact1_last_name TEXT,
  ADD COLUMN IF NOT EXISTS contact1_mobile2   TEXT,
  ADD COLUMN IF NOT EXISTS contact2_last_name TEXT,
  ADD COLUMN IF NOT EXISTS contact2_mobile2   TEXT;

-- تحقق
SELECT column_name FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'customers'
  AND column_name LIKE 'contact%'
ORDER BY column_name;
