-- إضافة حقول المسؤولين على الطلب
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS prepared_by TEXT;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS delivered_by TEXT;
