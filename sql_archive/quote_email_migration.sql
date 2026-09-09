-- خانة إيميل العميل الاختيارية عند إنشاء عرض السعر
ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS email TEXT;
