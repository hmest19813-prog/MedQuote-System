-- تصحيح المسودات الثلاث اللي أنشأتها بالسكربت القديم (الأحجام كانت بحقل notes اللي ما بيظهر بالطباعة).
-- هذا السكربت بيدمج الحجم داخل اسم الصنف نفسه (مثلاً "مخبار مدرج" + "25ml" -> "مخبار مدرج (25ml)")
-- ويفضّي حقل notes بعدين. ما بيلمس أي عرض سعر ثاني ولا أي صنف معلّم "غير متوفر".
-- شغّله مرة وحدة على Supabase SQL Editor.

WITH target_quotes AS (
  SELECT DISTINCT quotation_id
  FROM quotation_items
  WHERE item_name IN ('مخبار مدرج', 'كؤوس زجاجية', 'دوارق زجاجية', 'أقماع زجاجية', 'أنابيب اختبار')
    AND notes IS NOT NULL
    AND notes <> 'UNAVAILABLE'
)
UPDATE quotation_items qi
SET item_name = qi.item_name || ' (' || qi.notes || ')',
    notes = NULL
FROM target_quotes tq
WHERE qi.quotation_id = tq.quotation_id
  AND qi.notes IS NOT NULL
  AND qi.notes <> 'UNAVAILABLE';

-- تحقق من النتيجة (لازم تبين الأصناف الـ 3 مسودات مع الأحجام مدموجة بالاسم):
SELECT q.issuer_company, qi.sort_order, qi.item_name, qi.unit, qi.quantity
FROM quotation_items qi
JOIN quotations q ON q.id = qi.quotation_id
WHERE qi.quotation_id IN (SELECT quotation_id FROM (
  SELECT DISTINCT quotation_id
  FROM quotation_items
  WHERE item_name LIKE 'مخبار مدرج%'
) x)
ORDER BY q.issuer_company, qi.sort_order;
