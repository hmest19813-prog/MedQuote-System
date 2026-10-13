-- ============================================================
-- سياسة الدوام والحضور لكل موظف (إضافة حقول على hr_employees)
-- 1) نوع التوظيف        employment_type
-- 2) نظام الدوام         work_mode
-- 3) دوام ثابت أو مرن    schedule_type
-- 4) جدول العمل الأسبوعي weekly_schedule  (jsonb — يوم بيوم: دوام؟/بداية/نهاية/استراحة)
--    + ساعات العمل المطلوبة  required_daily_hours
-- 5) قواعد الحضور: فترة السماح / آلية تسجيل الحضور / ملاحظات الإضافي والغياب
--    (صيغة احتساب الخصومات نفسها لسا معلّقة — هاي الحقول توصيف وقيم أساسية فقط)
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS employment_type       text;
ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS work_mode             text;
ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS schedule_type         text NOT NULL DEFAULT 'fixed';
ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS weekly_schedule       jsonb NOT NULL DEFAULT '{}'::jsonb;
ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS required_daily_hours numeric(5,2);
ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS grace_minutes        integer NOT NULL DEFAULT 0;
ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS attendance_method    text;
ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS overtime_notes        text;
ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS absence_notes         text;

ALTER TABLE public.hr_employees DROP CONSTRAINT IF EXISTS hr_employees_schedule_type_check;
ALTER TABLE public.hr_employees ADD CONSTRAINT hr_employees_schedule_type_check
  CHECK (schedule_type IN ('fixed','flexible'));

-- weekly_schedule shape (مفاتيح '0'..'6' = getDay() الأحد..السبت):
-- { "0": {"is_work_day": true, "start": "08:00", "end": "17:00", "break_minutes": 60}, ... }
