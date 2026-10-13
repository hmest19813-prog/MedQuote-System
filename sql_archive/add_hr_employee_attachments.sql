-- ============================================================
-- مرفقات الموظفين (عقد، هوية، شهادات...) — تبويب "الموظفين" بالموارد البشرية
-- نفس نمط add_hr_candidate_attachments.sql (جدول + Storage bucket خاص)
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

CREATE TABLE IF NOT EXISTS public.hr_employee_attachments (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  employee_id   uuid NOT NULL REFERENCES public.hr_employees(id) ON DELETE CASCADE,
  title         text NOT NULL,
  file_path     text NOT NULL,
  file_name     text,
  file_size     bigint,
  mime_type     text,
  created_by    uuid REFERENCES public.profiles(id),
  created_at    timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_hr_employee_attachments_employee ON public.hr_employee_attachments(employee_id);

ALTER TABLE public.hr_employee_attachments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS hea_select ON public.hr_employee_attachments;
CREATE POLICY hea_select ON public.hr_employee_attachments FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS hea_insert ON public.hr_employee_attachments;
CREATE POLICY hea_insert ON public.hr_employee_attachments FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_employees_edit')
  )
);

DROP POLICY IF EXISTS hea_update ON public.hr_employee_attachments;
CREATE POLICY hea_update ON public.hr_employee_attachments FOR UPDATE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_employees_edit')
);

DROP POLICY IF EXISTS hea_delete ON public.hr_employee_attachments;
CREATE POLICY hea_delete ON public.hr_employee_attachments FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_employees_edit')
);

-- ===================== Storage bucket (خاص — لا يُعرض بروابط عامة) =====================
INSERT INTO storage.buckets (id, name, public)
VALUES ('hr-employee-attachments', 'hr-employee-attachments', false)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS hea_storage_select ON storage.objects;
CREATE POLICY hea_storage_select ON storage.objects FOR SELECT USING (
  bucket_id = 'hr-employee-attachments' AND auth.uid() IS NOT NULL
);

DROP POLICY IF EXISTS hea_storage_insert ON storage.objects;
CREATE POLICY hea_storage_insert ON storage.objects FOR INSERT WITH CHECK (
  bucket_id = 'hr-employee-attachments' AND auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_employees_edit')
  )
);

DROP POLICY IF EXISTS hea_storage_delete ON storage.objects;
CREATE POLICY hea_storage_delete ON storage.objects FOR DELETE USING (
  bucket_id = 'hr-employee-attachments' AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_employees_edit')
  )
);
