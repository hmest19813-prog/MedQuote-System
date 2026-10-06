-- مسودة عرض سعر: جامعة العقبة للعلوم الطبية (Aqaba Medical Sciences University)
-- مختبر الكيمياء - الفصل الأول 2026-2027
-- المصدر: الكيمياء الفصل الأول 2026-2027.pdf (Table1: Equipment and tools + Table2: Substance) — صفحتان، 40 صنف
-- بيانات الجهة: الأردن - العقبة - الشاطئ الجنوبي - الطريق الموازي
--   هاتف/فاكس: 00962778003033 — Email: Info@amsu.edu.jo — www.amsu.edu.jo
-- ملاحظة: الأسعار كلها 0 مؤقتاً (لا توجد أسعار بالملف الأصلي) — تحتاج تسعير يدوي
-- ملاحظة: الأصناف 29-39 (لابيلز، قفازات، كمامات، أدوية، شاي، صابون يد، خل، مبيّض...) مؤشّر عليها
--   بالملف الأصلي "مواد مباشرة الشراء" أو "شراء مباشر من السوق (الصيدلية)" — يُحتمل إنها مش مقصودة
--   لعرض السعر (العميل بشتريها مباشرة) — راجعها قبل الإرسال، ممكن تحتاج حذف

WITH new_quote AS (
  INSERT INTO quotations (customer_name, requester_phone, status, tax_pct)
  VALUES ('جامعة العقبة للعلوم الطبية - Aqaba Medical Sciences University', '00962778003033', 'draft', 16)
  RETURNING id
)
INSERT INTO quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, delivery, tax_pct, notes)
SELECT nq.id, v.sort_order, v.item_name, v.unit, v.quantity, 0, 'CHINA', 'PROMPT', 16, v.notes
FROM new_quote nq
CROSS JOIN (VALUES
  -- Table1: Equipment and tools
  (0,  'Burette Clamp',                         'EACH',    10,   'Polypropylene'),

  -- Table2: Substance (chemicals or biologicals)
  (1,  'Potassium Iodide',                      'G',       500,  'Solid, Commercial grade'),
  (2,  'Calcium Nitrate',                       'G',       500,  'Solid, Commercial grade'),
  (3,  'Zinc Chloride',                         'G',       500,  'Solid, Commercial grade'),
  (4,  'Benzoic acid',                          'G',       500,  'Solid, Commercial grade'),
  (5,  'O-Nitroaniline',                        'G',       250,  'Solid, Commercial grade'),
  (6,  'P-Nitroaniline',                        'G',       250,  'Solid, Commercial grade'),
  (7,  'Sodium Sulfate',                        'KG',      1,    'Solid, Commercial grade'),
  (8,  'Sodium Thiosulfate',                    'G',       500,  'Solid, Commercial grade'),
  (9,  'Phenolphthalein',                       'G',       25,   'Solid, Commercial grade'),
  (10, 'Potassium Permanganate',                'G',       250,  'Solid, Commercial grade'),
  (11, 'Lead Nitrate',                          'G',       250,  'Solid, Commercial grade'),
  (12, 'Sodium Iodide',                         'G',       500,  'Solid, Commercial grade'),
  (13, 'Barium Chloride (hydrated)',            'G',       500,  'Solid, Commercial grade'),
  (14, 'Bromothymol Blue Indicator',            'G',       10,   'Solid, Commercial grade'),
  (15, 'Fehling Solution NO 1',                 'ML',      500,  'Liquid'),
  (16, 'Fehling Solution NO 2',                 'ML',      500,  'Liquid'),
  (17, 'Phenol',                                'G',       500,  'Solid, Commercial grade'),
  (18, 'Cyclohexanol',                          'L',       1,    'Liquid, Commercial grade'),
  (19, 'Cyclohexene',                           'L',       1,    'Liquid, Commercial grade'),
  (20, 'Cyclohexane',                           'L',       1,    'Liquid, Commercial grade'),
  (21, 'Dichloromethane',                       'L',       5,    'Liquid, Commercial grade'),
  (22, 'N-Butyl alcohol',                       'L',       2.5,  'Liquid, Commercial grade'),
  (23, '2-Butyl alcohol',                       'L',       2.5,  'Liquid, Commercial grade'),
  (24, 'Tert Butyl alcohol',                    'L',       2.5,  'Liquid, Commercial grade'),
  (25, 'Acetone',                               'L',       5,    'Liquid, Commercial grade'),
  (26, 'Filter paper',                          'PACKET',  3,    'Whatman Grade 4 qualitative, diameters 27/47/50/150mm, packs of 100 circles — 3 packets from each size'),
  (27, 'Thin Layer Chromatography Capillary Tube', 'EACH', 3,    'Inner Diameter 0.12-0.70mm, Length 32-100mm'),
  (28, 'Thin Layer Chromatography Plates',      'PACKET',  2,    '20x40cm (Silica)'),
  (29, 'Labels',                                'EACH',    4,    'مواد مباشرة الشراء'),
  (30, 'Gloves (sizes S, M, XL)',               'PACKET',  2,    'Latex gloves — Two packets from each size — شراء مباشر من السوق (الصيدلية)'),
  (31, 'Mask',                                  'PACKET',  3,    '3-ply disposable mask — شراء مباشر من السوق (الصيدلية)'),
  (32, 'Paracetamol',                           'EACH',    2,    'Panadol — مواد مباشرة الشراء'),
  (33, 'Antacid',                               'EACH',    2,    'Gaviscon — مواد مباشرة الشراء'),
  (34, 'Aluminum Foil',                         'EACH',    2,    'مواد مباشرة الشراء'),
  (35, 'Parafilm',                              'EACH',    2,    'PARAFILM M, 100mm x 75m, 1 unit(s)'),
  (36, 'Tea leaves',                            'KG',      2,    'مواد مباشرة الشراء'),
  (37, 'Hand wash',                             'BOTTLE',  4,    'مواد مباشرة الشراء'),
  (38, 'Vinegar',                               'L',       2,    'مواد مباشرة الشراء'),
  (39, 'Bleach',                                'L',       2,    'مواد مباشرة الشراء')
) AS v(sort_order, item_name, unit, quantity, notes);
