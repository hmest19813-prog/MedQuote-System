-- ============================================================
-- MedQuote Pro — الطلبات تحفظ أصنافها الخاصة (order_items)
--
-- قبل هذا التعديل كان الطلب يُنشأ بدون أصناف، والطباعة تسحب أصناف
-- العرض المصدر — فأي تعديل على الطلب كان يضيع. الآن كل طلب يملك
-- بنوده، ولذلك نحتاج عمود الضريبة لكل بند تماماً كـ quotation_items.
--
-- شغّل الملف كاملاً مرة واحدة في Supabase SQL Editor.
-- ============================================================

-- ── عمود نسبة الضريبة لكل بند ────────────────────────────────
ALTER TABLE public.order_items
  ADD COLUMN IF NOT EXISTS tax_pct NUMERIC(5,2);

-- ── تعبئة أصناف الطلبات القديمة من العرض المصدر ──────────────
--    (يتجاهل أي طلب يملك أصنافاً بالفعل، فآمن التكرار)
INSERT INTO public.order_items
  (order_id, sort_order, item_name, description, unit, quantity,
   unit_price, total_price, tax_pct, origin, delivery, notes)
SELECT o.id, qi.sort_order, qi.item_name, qi.description, qi.unit, qi.quantity,
       qi.unit_price, qi.quantity * qi.unit_price, qi.tax_pct, qi.origin, qi.delivery, qi.notes
FROM public.orders o
JOIN public.quotation_items qi ON qi.quotation_id = o.quotation_id
WHERE o.quotation_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM public.order_items oi WHERE oi.order_id = o.id);

-- ── تحقق: يجب ألا تبقى طلبات مرتبطة بعرض وبلا أصناف ──────────
SELECT o.number, o.customer_name, COUNT(oi.id) AS عدد_الأصناف
FROM public.orders o
LEFT JOIN public.order_items oi ON oi.order_id = o.id
GROUP BY o.id, o.number, o.customer_name
ORDER BY o.number;
