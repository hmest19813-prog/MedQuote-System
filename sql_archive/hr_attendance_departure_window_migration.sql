-- ============================================================
-- المغادرة الرسمية: فترة خروج منفصلة (من - إلى) تُطرح من ساعات الدوام
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

ALTER TABLE public.hr_attendance ADD COLUMN IF NOT EXISTS departure_start time;
ALTER TABLE public.hr_attendance ADD COLUMN IF NOT EXISTS departure_end   time;
