-- ============================================================
-- مرفقات المرشحين (السيرة الذاتية، الشهادات...) — تبويب "المرشحين" بالموارد البشرية
-- نفس نمط tender_attachments_migration.sql (جدول + Storage bucket خاص)
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

CREATE TABLE IF NOT EXISTS public.hr_candidate_attachments (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id  uuid NOT NULL REFERENCES public.hr_candidates(id) ON DELETE CASCADE,
  title         text NOT NULL,
  file_path     text NOT NULL,
  file_name     text,
  file_size     bigint,
  mime_type     text,
  created_by    uuid REFERENCES public.profiles(id),
  created_at    timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_hr_candidate_attachments_candidate ON public.hr_candidate_attachments(candidate_id);

ALTER TABLE public.hr_candidate_attachments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS hca_select ON public.hr_candidate_attachments;
CREATE POLICY hca_select ON public.hr_candidate_attachments FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS hca_insert ON public.hr_candidate_attachments;
CREATE POLICY hca_insert ON public.hr_candidate_attachments FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_candidates_edit')
  )
);

DROP POLICY IF EXISTS hca_update ON public.hr_candidate_attachments;
CREATE POLICY hca_update ON public.hr_candidate_attachments FOR UPDATE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_candidates_edit')
);

DROP POLICY IF EXISTS hca_delete ON public.hr_candidate_attachments;
CREATE POLICY hca_delete ON public.hr_candidate_attachments FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_candidates_edit')
);

-- ===================== Storage bucket (خاص — لا يُعرض بروابط عامة) =====================
INSERT INTO storage.buckets (id, name, public)
VALUES ('hr-candidate-attachments', 'hr-candidate-attachments', false)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS hca_storage_select ON storage.objects;
CREATE POLICY hca_storage_select ON storage.objects FOR SELECT USING (
  bucket_id = 'hr-candidate-attachments' AND auth.uid() IS NOT NULL
);

DROP POLICY IF EXISTS hca_storage_insert ON storage.objects;
CREATE POLICY hca_storage_insert ON storage.objects FOR INSERT WITH CHECK (
  bucket_id = 'hr-candidate-attachments' AND auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_candidates_edit')
  )
);

DROP POLICY IF EXISTS hca_storage_delete ON storage.objects;
CREATE POLICY hca_storage_delete ON storage.objects FOR DELETE USING (
  bucket_id = 'hr-candidate-attachments' AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('hr_candidates_edit')
  )
);
