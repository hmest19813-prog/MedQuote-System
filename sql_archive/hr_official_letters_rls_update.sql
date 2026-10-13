-- ============================================================
-- كتب "موارد بشرية" الرسمية (official_letters) صارت تُدار من صفحة
-- إدارة الموارد البشرية (تبويب "الكتب الرسمية") بدل الديوان — نفس الجدول
-- ونفس تسلسل الترقيم، فقط مكان العرض انتقل. الصفحة الجديدة تتحقق من صلاحية
-- hr_access بدل letters_access، فهذا التحديث يعدّل سياسة SELECT فقط
-- حتى يقدر موظف عنده hr_access (بس مش بالضرورة letters_access) يشوف
-- كتب هذا التصنيف. شغّله في Supabase → SQL Editor (آمن - idempotent)
-- ============================================================

DROP POLICY IF EXISTS letters_select ON public.official_letters;
CREATE POLICY letters_select ON public.official_letters FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager'])
    OR (
      public.get_my_role() = 'employee'
      AND (
        public.has_perm('letters_access')
        OR (
          public.has_perm('hr_access')
          AND category IN (
            'a78b584f-552c-4015-a8cc-471a62cc49f8', -- موارد بشرية
            'f013f34b-b7cb-49d3-9c37-0bd81103a88c', -- مخالصات
            'e37195d3-d8ea-440f-8323-7972d6cf2cae', -- استقالة
            '13f2287b-8784-42f9-ac43-f48eeaef2be9', -- شهادة خبرة
            'c84eb173-c902-4881-bf53-f3740cb4ba51'  -- شهادة موظف
          )
        )
      )
      AND (is_private IS NOT TRUE OR created_by = auth.uid())
    )
  )
);
