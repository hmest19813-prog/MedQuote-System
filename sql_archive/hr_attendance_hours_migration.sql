-- ============================================================
-- تطوير الحضور والغياب: ساعات دوام (بدء/انتهاء) + حالتي مغادرة رسمية/غير رسمية
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

ALTER TABLE public.hr_attendance ADD COLUMN IF NOT EXISTS check_in  time;
ALTER TABLE public.hr_attendance ADD COLUMN IF NOT EXISTS check_out time;

ALTER TABLE public.hr_attendance DROP CONSTRAINT IF EXISTS hr_attendance_status_check;
ALTER TABLE public.hr_attendance ADD CONSTRAINT hr_attendance_status_check CHECK (
  status = ANY (ARRAY[
    'present','absent','late',
    'leave_annual','leave_sick','leave_unpaid','leave_personal',
    'departure_official','departure_unofficial',
    'holiday'
  ])
);
