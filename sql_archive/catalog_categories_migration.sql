-- ============================================================
-- MedQuote Pro — Catalog Categories Table
-- شغّله في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.catalog_categories (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT        NOT NULL UNIQUE,
  sort_order INTEGER     DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  created_by UUID        REFERENCES public.profiles(id) ON DELETE SET NULL
);

ALTER TABLE public.catalog_categories ENABLE ROW LEVEL SECURITY;

-- الكل يقرأ
CREATE POLICY "cat_select" ON public.catalog_categories
  FOR SELECT TO authenticated USING (true);

-- الأدمن فقط يضيف / يعدّل / يحذف
CREATE POLICY "cat_admin" ON public.catalog_categories
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- إدخال الفئات الموجودة
INSERT INTO public.catalog_categories (name, sort_order) VALUES
  ('العناية بالسكري',1),('أجهزة ضغط الدم',2),('أجهزة طبية منزلية',3),
  ('المضخات الطبية',4),('أحذية طبية',5),('تجهيز عيادات',6),
  ('المستهلكات',7),('إسعافات أولية',8),('ملابس طبية ومخبرية',9),
  ('المشدات الطبية والتجميلية',10),('المجاهر',11),('أدوات زجاجية',12),
  ('أدوات بلاستيكية',13),('فحص المياه',14),('الكروماتوغرافيا',15),
  ('تجهيز مختبرات',16),('مستهلكات مخبرية',17),('الهيكل العظمي وأجزاءه',18),
  ('المجسمات التشريحية',19),('الدمى والتدريس الطبي',20),
  ('المجسمات التعليمية',21),('النباتات',22),('اللوحات التعليمية',23),
  ('غيرهم',24)
ON CONFLICT (name) DO NOTHING;

-- تحقق
SELECT name, sort_order FROM public.catalog_categories ORDER BY sort_order;
