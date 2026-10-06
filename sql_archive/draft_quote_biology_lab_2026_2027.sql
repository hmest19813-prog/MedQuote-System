-- مسودة عرض سعر: مختبر الأحياء - الفصل الأول 2026-2027
-- المصدر: مختبر الأحياء الفصل الأول 2026-2027.pdf (Table 1: Equipment and tools) — صفحة واحدة فقط، 4 أصناف
-- ملاحظة: اسم العميل غير موجود بملف الأحياء نفسه، لكن ملف كيمياء بنفس التاريخ من نفس القسم أكّد إنه
--   جامعة العقبة للعلوم الطبية (Aqaba Medical Sciences University) — افتراض، تأكد منه قبل الإرسال
-- ملاحظة: الأسعار كلها 0 مؤقتاً (لا توجد أسعار بالملف الأصلي) — تحتاج تسعير يدوي
-- حقل notes يحتوي المواصفات الأصلية من الجدول (Specifications / Custody-Consumer)

WITH new_quote AS (
  INSERT INTO quotations (customer_name, requester_phone, status, tax_pct)
  VALUES ('جامعة العقبة للعلوم الطبية - Aqaba Medical Sciences University', '00962778003033', 'draft', 16)
  RETURNING id
)
INSERT INTO quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, delivery, tax_pct, notes)
SELECT nq.id, v.sort_order, v.item_name, v.unit, v.quantity, 0, 'CHINA', 'PROMPT', 16, v.notes
FROM new_quote nq
CROSS JOIN (VALUES
  (0, 'Plastic Pipette aid 5ml',    'EACH', 5,   'Manual, high-grade chemical-resistant plastic (polypropylene or ABS), resistant to dilute acids and alkalis — Custody item'),
  (1, 'Plastic Pipette aid 10ml',   'EACH', 5,   'Manual, high-grade chemical-resistant plastic (polypropylene or ABS), resistant to dilute acids and alkalis — Custody item'),
  (2, 'Plastic Pipette aid 2ml',    'EACH', 5,   'Manual, high-grade chemical-resistant plastic (polypropylene or ABS), resistant to dilute acids and alkalis — Custody item'),
  (3, 'Pyrex glass test tubes',     'EACH', 100, 'Standard test tube, ~15cm length, 15mm diameter — Consumed item')
) AS v(sort_order, item_name, unit, quantity, notes);
