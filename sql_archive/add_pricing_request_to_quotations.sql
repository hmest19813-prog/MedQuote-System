-- ميزة: طلب تسعير من مستخدم آخر لعرض غير مسعر (مسودة)
-- شغّل هذا الملف يدوياً على Supabase SQL Editor قبل استخدام الميزة

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS needs_pricing boolean DEFAULT false,
  ADD COLUMN IF NOT EXISTS pricing_requested_to uuid REFERENCES public.profiles(id),
  ADD COLUMN IF NOT EXISTS pricing_requested_by uuid REFERENCES public.profiles(id),
  ADD COLUMN IF NOT EXISTS pricing_requested_at timestamptz,
  ADD COLUMN IF NOT EXISTS pricing_note text;
