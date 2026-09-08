-- ============================================================
-- MedQuote Pro — تصنيفات وتبويبات الكتب الرسمية (letter_categories)
-- شغّله مرة واحدة في Supabase → SQL Editor قبل استخدام التصنيفات
-- الجديدة (شؤون إدارية/مالية/عطاءات/عقود واتفاقيات/شؤون تنظيمية/
-- نماذج وقوالب/أخرى) بصفحة الكتب الرسمية.
--
-- الجدول هرمي: تصنيف رئيسي (parent_id = NULL) وتحته تبويبات فرعية
-- (parent_id = معرّف التصنيف الرئيسي). الإضافة مقصورة على الأدمن،
-- والقراءة متاحة لأي مستخدم مسجّل دخول.
--
-- المعرّفات هون ثابتة (مو gen_random_uuid) عمداً — كودة الواجهة
-- (index.html) بتعتمد عليها لتحويل تصنيفات الكتب القديمة (decision،
-- circular، agreement، tenders، clearance، correspondence، communication)
-- تلقائياً للتصنيف الجديد المكافئ لها.
-- ============================================================

CREATE TABLE IF NOT EXISTS public.letter_categories (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  label      TEXT        NOT NULL,
  parent_id  UUID        REFERENCES public.letter_categories(id) ON DELETE CASCADE,
  sort_order INTEGER     DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  created_by UUID        REFERENCES public.profiles(id) ON DELETE SET NULL
);

ALTER TABLE public.letter_categories ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS letter_cat_select ON public.letter_categories;
CREATE POLICY letter_cat_select ON public.letter_categories
  FOR SELECT TO authenticated USING (true);

-- الأدمن فقط يضيف / يعدّل / يحذف تصنيفات وتبويبات
DROP POLICY IF EXISTS letter_cat_admin ON public.letter_categories;
CREATE POLICY letter_cat_admin ON public.letter_categories
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- بذر التصنيفات السبعة الأساسية وتبويباتها الفرعية (مرة واحدة فقط)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM public.letter_categories) THEN
    INSERT INTO public.letter_categories (id, label, parent_id, sort_order) VALUES
      ('00000000-0000-0000-0000-000000000001', 'شؤون إدارية',      NULL, 1),
      ('00000000-0000-0000-0000-000000000002', 'شؤون مالية',       NULL, 2),
      ('00000000-0000-0000-0000-000000000003', 'عطاءات',           NULL, 3),
      ('00000000-0000-0000-0000-000000000004', 'عقود واتفاقيات',   NULL, 4),
      ('00000000-0000-0000-0000-000000000005', 'شؤون تنظيمية',     NULL, 5),
      ('00000000-0000-0000-0000-000000000006', 'نماذج وقوالب',     NULL, 6),
      ('00000000-0000-0000-0000-000000000007', 'أخرى',             NULL, 7),

      ('00000000-0000-0000-0000-000000000011', 'قرارات',   '00000000-0000-0000-0000-000000000001', 1),
      ('00000000-0000-0000-0000-000000000012', 'تعاميم',   '00000000-0000-0000-0000-000000000001', 2),
      ('00000000-0000-0000-0000-000000000013', 'تفويض',    '00000000-0000-0000-0000-000000000001', 3),

      ('00000000-0000-0000-0000-000000000021', 'مطالبات',    '00000000-0000-0000-0000-000000000002', 1),
      ('00000000-0000-0000-0000-000000000022', 'كتب مالية',  '00000000-0000-0000-0000-000000000002', 2),

      ('00000000-0000-0000-0000-000000000031', 'عطاء',      '00000000-0000-0000-0000-000000000003', 1),
      ('00000000-0000-0000-0000-000000000032', 'استفسار',   '00000000-0000-0000-0000-000000000003', 2),

      ('00000000-0000-0000-0000-000000000041', 'عقود',            '00000000-0000-0000-0000-000000000004', 1),
      ('00000000-0000-0000-0000-000000000042', 'اتفاقيات',        '00000000-0000-0000-0000-000000000004', 2),
      ('00000000-0000-0000-0000-000000000043', 'مذكرات تفاهم',    '00000000-0000-0000-0000-000000000004', 3),

      ('00000000-0000-0000-0000-000000000051', 'تسجيل',    '00000000-0000-0000-0000-000000000005', 1),
      ('00000000-0000-0000-0000-000000000052', 'موافقات',  '00000000-0000-0000-0000-000000000005', 2);
  END IF;
END $$;

-- تحقق
SELECT c.label AS التصنيف, s.label AS التبويب, s.sort_order
FROM public.letter_categories c
LEFT JOIN public.letter_categories s ON s.parent_id = c.id
WHERE c.parent_id IS NULL
ORDER BY c.sort_order, s.sort_order;
