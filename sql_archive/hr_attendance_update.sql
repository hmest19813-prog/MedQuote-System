-- ============================================================
-- تحديث قيود الحضور لدعم أنواع الإجازات المتعددة
-- شغّله في Supabase → SQL Editor
-- ============================================================

ALTER TABLE public.hr_attendance
  DROP CONSTRAINT IF EXISTS hr_attendance_status_check;

ALTER TABLE public.hr_attendance
  ADD CONSTRAINT hr_attendance_status_check
  CHECK (status IN (
    'present',
    'absent',
    'late',
    'leave_annual',
    'leave_sick',
    'leave_unpaid',
    'leave_personal',
    'holiday'
  ));
