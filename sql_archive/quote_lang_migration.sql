-- =========================================================
-- Quote Language Migration
-- إضافة حقل لغة العرض (عربي / إنجليزي)
-- =========================================================

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS quote_lang TEXT DEFAULT 'ar';

COMMENT ON COLUMN public.quotations.quote_lang IS 'ar = Arabic RTL | en = English LTR';
