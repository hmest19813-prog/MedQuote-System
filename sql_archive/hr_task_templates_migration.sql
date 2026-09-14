-- المهام الدورية للموظفين (قوالب طباعة فاضية — بدون تتبع رقمي للإنجاز)
-- تُطبع كشيت شهري لكل موظف فيه 4 أقسام: يومية / أسبوعية / كل أسبوعين / شهرية

CREATE TABLE public.hr_task_templates (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL PRIMARY KEY,
    employee_id uuid NOT NULL REFERENCES public.hr_employees(id) ON DELETE CASCADE,
    title text NOT NULL,
    frequency text NOT NULL DEFAULT 'daily',
    notes text,
    sort_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT hr_task_templates_frequency_check CHECK ((frequency = ANY (ARRAY['daily'::text, 'weekly'::text, 'biweekly'::text, 'monthly'::text])))
);

ALTER TABLE public.hr_task_templates OWNER TO postgres;

ALTER TABLE public.hr_task_templates ENABLE ROW LEVEL SECURITY;

CREATE POLICY hr_task_templates_policy ON public.hr_task_templates USING (true) WITH CHECK (true);

GRANT ALL ON TABLE public.hr_task_templates TO anon;
GRANT ALL ON TABLE public.hr_task_templates TO authenticated;
GRANT ALL ON TABLE public.hr_task_templates TO service_role;
