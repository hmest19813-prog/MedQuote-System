-- إضافة الحذف الناعم (soft delete) لجدول official_letters
-- شغّله مرة واحدة في Supabase SQL Editor قبل استخدام جدول "المحذوفات" الجديد بصفحة الكتب الرسمية.

ALTER TABLE public.official_letters
  ADD COLUMN IF NOT EXISTS deleted_at timestamp with time zone,
  ADD COLUMN IF NOT EXISTS deleted_by uuid,
  ADD COLUMN IF NOT EXISTS delete_reason text;
