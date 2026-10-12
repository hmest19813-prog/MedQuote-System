-- ============================================================
-- تبويب "الموظفين المرشحين" بصفحة الموارد البشرية
-- 4 مراحل: متقدم جديد / مقابلة / مقبول / مرفوض — مع تحويل المقبول لموظف
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

CREATE TABLE IF NOT EXISTS public.hr_candidates (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    full_name text NOT NULL,
    phone text,
    job_title text,
    source text,
    status text DEFAULT 'new'::text NOT NULL,
    notes text,
    rejection_reason text,
    converted_employee_id uuid,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT hr_candidates_pkey PRIMARY KEY (id),
    CONSTRAINT hr_candidates_status_check CHECK (status = ANY (ARRAY['new'::text, 'interview'::text, 'accepted'::text, 'rejected'::text])),
    CONSTRAINT hr_candidates_converted_employee_id_fkey FOREIGN KEY (converted_employee_id) REFERENCES public.hr_employees(id) ON DELETE SET NULL
);

ALTER TABLE public.hr_candidates ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS hr_candidates_policy ON public.hr_candidates;
CREATE POLICY hr_candidates_policy ON public.hr_candidates USING (true) WITH CHECK (true);

GRANT ALL ON TABLE public.hr_candidates TO anon;
GRANT ALL ON TABLE public.hr_candidates TO authenticated;
GRANT ALL ON TABLE public.hr_candidates TO service_role;
