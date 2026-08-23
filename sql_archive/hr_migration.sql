-- ============================================================
-- MedQuote Pro — HR Module Migration
-- قسم الموارد البشرية: موظفين، حضور وغياب، كتب، رواتب
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- 1. جدول الموظفين
CREATE TABLE IF NOT EXISTS public.hr_employees (
  id           UUID         DEFAULT uuid_generate_v4() PRIMARY KEY,
  full_name    TEXT         NOT NULL,
  job_title    TEXT,
  department   TEXT,
  hire_date    DATE,
  base_salary  NUMERIC(12,2) DEFAULT 0,
  phone        TEXT,
  national_id  TEXT,
  status       TEXT         DEFAULT 'active'
               CHECK (status IN ('active', 'inactive', 'terminated')),
  notes        TEXT,
  created_at   TIMESTAMPTZ  DEFAULT NOW(),
  updated_at   TIMESTAMPTZ  DEFAULT NOW()
);

-- 2. جدول الحضور والغياب
CREATE TABLE IF NOT EXISTS public.hr_attendance (
  id           UUID         DEFAULT uuid_generate_v4() PRIMARY KEY,
  employee_id  UUID         NOT NULL REFERENCES public.hr_employees(id) ON DELETE CASCADE,
  date         DATE         NOT NULL,
  status       TEXT         NOT NULL DEFAULT 'present'
               CHECK (status IN ('present', 'absent', 'late', 'leave', 'holiday')),
  notes        TEXT,
  created_at   TIMESTAMPTZ  DEFAULT NOW(),
  UNIQUE(employee_id, date)
);

-- 3. جدول كتب الموارد البشرية
CREATE TABLE IF NOT EXISTS public.hr_letters (
  id           UUID         DEFAULT uuid_generate_v4() PRIMARY KEY,
  employee_id  UUID         REFERENCES public.hr_employees(id) ON DELETE SET NULL,
  letter_type  TEXT         NOT NULL,
  title        TEXT         NOT NULL,
  content      TEXT,
  issued_date  DATE         DEFAULT CURRENT_DATE,
  created_by   UUID         REFERENCES public.profiles(id),
  created_at   TIMESTAMPTZ  DEFAULT NOW()
);

-- 4. جدول الرواتب الشهرية
CREATE TABLE IF NOT EXISTS public.hr_salaries (
  id           UUID         DEFAULT uuid_generate_v4() PRIMARY KEY,
  employee_id  UUID         NOT NULL REFERENCES public.hr_employees(id) ON DELETE CASCADE,
  month        INT          NOT NULL CHECK (month BETWEEN 1 AND 12),
  year         INT          NOT NULL,
  base_salary  NUMERIC(12,2) DEFAULT 0,
  bonus        NUMERIC(12,2) DEFAULT 0,
  deductions   NUMERIC(12,2) DEFAULT 0,
  status       TEXT         DEFAULT 'pending' CHECK (status IN ('pending', 'paid')),
  paid_at      TIMESTAMPTZ,
  notes        TEXT,
  created_at   TIMESTAMPTZ  DEFAULT NOW(),
  UNIQUE(employee_id, month, year)
);

-- RLS Policies
ALTER TABLE public.hr_employees ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "hr_employees_policy" ON public.hr_employees;
CREATE POLICY "hr_employees_policy" ON public.hr_employees FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE public.hr_attendance ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "hr_attendance_policy" ON public.hr_attendance;
CREATE POLICY "hr_attendance_policy" ON public.hr_attendance FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE public.hr_letters ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "hr_letters_policy" ON public.hr_letters;
CREATE POLICY "hr_letters_policy" ON public.hr_letters FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE public.hr_salaries ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "hr_salaries_policy" ON public.hr_salaries;
CREATE POLICY "hr_salaries_policy" ON public.hr_salaries FOR ALL USING (true) WITH CHECK (true);

-- تحقق
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public' AND table_name LIKE 'hr_%'
ORDER BY table_name;
