-- ميزة: رابط المنتج على موقع المؤسسة (يظهر كزر قابل للنقر عند الطباعة/PDF)
-- شغّل هذا الملف يدوياً على Supabase SQL Editor قبل استخدام الميزة

ALTER TABLE public.quotation_items
  ADD COLUMN IF NOT EXISTS product_url text;
