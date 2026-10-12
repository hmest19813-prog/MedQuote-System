-- ============================================================
-- MedQuote Pro — Chemicals: Appearance & Grade as managed lists
--
-- physical_state (صلب/سائل/غاز) و grade (نص حر) بـchem_materials
-- بيصيروا قائمتين مستقلتين قابلتين للإضافة/التعديل من مدير النظام فقط
-- (نفس مبدأ customer_categories/catalog_categories).
--
-- شغّله كاملاً دفعة واحدة في Supabase SQL Editor بعد
-- chemicals_module_migration.sql (الموديول شغّال بالفعل بالإنتاج).
-- ============================================================

BEGIN;

-- ══════════════════════════════════════════════
-- 1) جدول Appearance (شكل/حالة المادة — بودرة بيضاء، سائل عديم اللون...)
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.chem_appearance_options (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT        NOT NULL UNIQUE,
  sort_order INTEGER     DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE public.chem_appearance_options ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "chem_appearance_select" ON public.chem_appearance_options;
CREATE POLICY "chem_appearance_select" ON public.chem_appearance_options FOR SELECT TO authenticated USING (true);
DROP POLICY IF EXISTS "chem_appearance_admin" ON public.chem_appearance_options;
CREATE POLICY "chem_appearance_admin" ON public.chem_appearance_options FOR ALL USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.chem_appearance_options TO authenticated;

INSERT INTO public.chem_appearance_options (name, sort_order) VALUES
  ('Solid',1), ('Liquid',2), ('Gas',3)
ON CONFLICT (name) DO NOTHING;

-- ══════════════════════════════════════════════
-- 2) جدول Grade (AR, LR, Extra Pure...)
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.chem_grade_options (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT        NOT NULL UNIQUE,
  sort_order INTEGER     DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE public.chem_grade_options ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "chem_grade_select" ON public.chem_grade_options;
CREATE POLICY "chem_grade_select" ON public.chem_grade_options FOR SELECT TO authenticated USING (true);
DROP POLICY IF EXISTS "chem_grade_admin" ON public.chem_grade_options;
CREATE POLICY "chem_grade_admin" ON public.chem_grade_options FOR ALL USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);
GRANT SELECT, INSERT, UPDATE, DELETE ON public.chem_grade_options TO authenticated;

-- نحافظ على القيم الموجودة فعلياً بالبيانات الحية (LR, Laboratory grade) بدل ما نخسرها
INSERT INTO public.chem_grade_options (name, sort_order)
SELECT DISTINCT grade, 0 FROM public.chem_materials WHERE grade IS NOT NULL AND trim(grade) <> ''
ON CONFLICT (name) DO NOTHING;

-- ══════════════════════════════════════════════
-- 3) ربط chem_materials بالقائمتين + ترحيل البيانات + حذف الحقول القديمة
-- ══════════════════════════════════════════════
ALTER TABLE public.chem_materials ADD COLUMN IF NOT EXISTS appearance_id UUID REFERENCES public.chem_appearance_options(id) ON DELETE SET NULL;
ALTER TABLE public.chem_materials ADD COLUMN IF NOT EXISTS grade_id UUID REFERENCES public.chem_grade_options(id) ON DELETE SET NULL;

UPDATE public.chem_materials m SET appearance_id = o.id
FROM public.chem_appearance_options o
WHERE lower(o.name) = m.physical_state AND m.appearance_id IS NULL;

UPDATE public.chem_materials m SET grade_id = o.id
FROM public.chem_grade_options o
WHERE o.name = m.grade AND m.grade_id IS NULL;

ALTER TABLE public.chem_materials DROP COLUMN IF EXISTS physical_state;
ALTER TABLE public.chem_materials DROP COLUMN IF EXISTS grade;

-- ══════════════════════════════════════════════
-- دليل التحديثات
-- ══════════════════════════════════════════════
INSERT INTO public.changelog_entries (title, description)
SELECT '🧪 Appearance و Grade كقوائم بإدارة الكيماويات', 'حقلا Physical State وGrade بالمادة الكيميائية صاروا قائمتين قابلتين للإضافة والتعديل من مدير النظام، بدل قيم ثابتة. البيانات القديمة ترحّلت تلقائياً.'
WHERE NOT EXISTS (SELECT 1 FROM public.changelog_entries WHERE title = '🧪 Appearance و Grade كقوائم بإدارة الكيماويات');

COMMIT;

-- ══════════════════════════════════════════════
-- تحقق سريع بعد التشغيل
-- ══════════════════════════════════════════════
SELECT count(*) AS appearance_options FROM public.chem_appearance_options;
SELECT count(*) AS grade_options FROM public.chem_grade_options;
SELECT count(*) AS materials_missing_appearance FROM public.chem_materials WHERE appearance_id IS NULL;
