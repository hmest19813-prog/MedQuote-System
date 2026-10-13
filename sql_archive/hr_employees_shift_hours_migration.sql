-- ============================================================
-- وقت دوام مرجعي لكل موظف (بداية/نهاية) — يُستخدم كقيمة افتراضية لحقلي
-- وقت الحضور/وقت المغادرة بسجل الحضور، لمنع الخربطة بين ساعات الدوام والمغادرات
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS shift_start time;
ALTER TABLE public.hr_employees ADD COLUMN IF NOT EXISTS shift_end   time;
