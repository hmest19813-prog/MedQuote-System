-- ============================================================
-- MedQuote Pro — Discount Type Migration
-- يضيف دعم الخصم بالمبلغ الثابت بالإضافة للنسبة المئوية
-- شغّله في Supabase → SQL Editor (آمن - لا يمس البيانات الموجودة)
-- ============================================================

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS discount_type  TEXT    DEFAULT 'pct',
  ADD COLUMN IF NOT EXISTS discount_fixed NUMERIC DEFAULT 0;

-- تحقق من النتيجة
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'quotations'
  AND column_name IN ('discount_pct','discount_amt','discount_type','discount_fixed')
ORDER BY column_name;
