-- ============================================================
-- ربط الكتب الرسمية (official_letters) بجدول العملاء (customers)
-- يسمح بإصدار كتاب رسمي مرتبط بعميل من صفحة العميل أو من صفحة الكتب الرسمية
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

ALTER TABLE public.official_letters
  ADD COLUMN IF NOT EXISTS customer_id uuid REFERENCES public.customers(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_official_letters_customer_id ON public.official_letters(customer_id);
