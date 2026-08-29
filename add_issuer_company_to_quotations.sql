-- ميزة: نسخ عرض سعر باسم شركة أخرى (بسعر أعلى 15%/20%)
-- شغّل هذا الملف على Supabase SQL Editor مرة واحدة قبل استخدام الميزة الجديدة

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS issuer_company text NOT NULL DEFAULT 'hayat',
  ADD COLUMN IF NOT EXISTS price_markup_pct numeric(5,2),
  ADD COLUMN IF NOT EXISTS cloned_from_id uuid REFERENCES public.quotations(id) ON DELETE SET NULL;

ALTER TABLE public.quotations
  DROP CONSTRAINT IF EXISTS quotations_issuer_company_check;

ALTER TABLE public.quotations
  ADD CONSTRAINT quotations_issuer_company_check
  CHECK (issuer_company IN ('hayat','eyad_harb','beken'));
