-- إضافة شركة جديدة "نيوتن" لعروض الشركات البديلة (نسخ باسم شركة أخرى)
-- شغّله مرة واحدة على Supabase SQL Editor قبل استخدام نيوتن بالتطبيق

ALTER TABLE public.quotations
  DROP CONSTRAINT IF EXISTS quotations_issuer_company_check;

ALTER TABLE public.quotations
  ADD CONSTRAINT quotations_issuer_company_check
  CHECK (issuer_company IN ('hayat','eyad_harb','beken','newton'));
