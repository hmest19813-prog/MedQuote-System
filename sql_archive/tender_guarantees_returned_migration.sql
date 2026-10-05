-- ===================== إرجاع الكفالات (checkbox + تاريخ إرجاع) =====================
-- يضيف حقلين لتتبّع إرجاع الكفالة للعميل/الجهة بعد انتهاء الحاجة لها، لكل أنواع
-- الكفالات (بنكية/شيك مصدق/شيك غير مصدق) بلا استثناء.
-- ملاحظة: الشيك المصدق والشيك غير مصدق لا يُطلب لهما expiry_date من الواجهة
-- (الحقل اختياري أصلاً بالجدول، فلا حاجة لتعديل القيد)، فقط "الإرجاع" يُطبّق على الكل.

ALTER TABLE public.tender_guarantees
  ADD COLUMN IF NOT EXISTS returned     boolean NOT NULL DEFAULT false,
  ADD COLUMN IF NOT EXISTS return_date  date;

-- الجدول كان بدون سياسة UPDATE إطلاقاً (RLS مفعّل + سياسات select/insert/delete فقط)،
-- فتعديل "الإرجاع" من الواجهة كان سيُرفض بصمت. نضيف سياسة UPDATE بنفس منطق INSERT.
DROP POLICY IF EXISTS tg_update ON public.tender_guarantees;
CREATE POLICY tg_update ON public.tender_guarantees FOR UPDATE USING (
  auth.uid() IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.quotations q WHERE q.id = tender_guarantees.quote_id AND (
      q.created_by = auth.uid() OR
      public.get_my_role() = ANY (ARRAY['admin','manager']) OR
      (public.get_my_role() = 'employee' AND public.has_perm('quotes_edit_all'))
    )
  )
);
