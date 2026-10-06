-- ============================================================
-- MedQuote Pro — Customer Job Titles Table (المسمى الوظيفي)
-- شغّله في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.customer_job_titles (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT        NOT NULL UNIQUE,
  sort_order INTEGER     DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE public.customer_job_titles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "cust_title_select" ON public.customer_job_titles FOR SELECT TO authenticated USING (true);
CREATE POLICY "cust_title_admin"  ON public.customer_job_titles FOR ALL USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);

INSERT INTO public.customer_job_titles (name, sort_order) VALUES
  ('مدير المشتريات',1),('مسؤول المشتريات',2),('مدير مالي',3),('محاسب',4),
  ('مدير عام',5),('مدير طبي',6),('صيدلاني',7),('مشرف',8),('مدير إداري',9),
  ('سكرتير',10),('مدير المستودع',11),('ممرض/ة',12),('فني',13),('أخرى',14)
ON CONFLICT (name) DO NOTHING;

-- تحقق
SELECT COUNT(*) FROM public.customer_job_titles;
