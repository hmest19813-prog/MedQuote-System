-- ================================================
-- إدخال عرض سعر: قسم الرعاية الصحية للمدارس
-- التاريخ: 8/8/2026 | المرجع: 5774/858
-- ================================================

DO $$
DECLARE
  v_quote_id UUID;
BEGIN

  -- 1. إدخال عرض السعر
  INSERT INTO public.quotations (
    customer_name, attention, date, reference,
    currency, delivery,
    subtotal, discount_pct, discount_amt,
    grand_total, tax_pct, tax_amt, nett_price,
    status, notes
  ) VALUES (
    'عرض سعر مخصص للمدارس',
    'قسم الرعاية الصحية',
    '2026-08-08',
    '5774/858',
    'JOD', 'PROMPT',
    1872.350, 0, 0,
    1872.350, 0, 0, 1872.350,
    'draft',
    'الأسعار شاملة الضريبة العامة على المبيعات والرسوم الجمركية'
  )
  RETURNING id INTO v_quote_id;

  -- 2. إدخال البنود
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 1, 'ميزان حرارة رقمي طبي Medical Digital Thermometer', 'Each', 2, 9.15, 'China', 'high accuracy');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 2, 'ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale', 'Each', 1, 195, 'China', '');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 3, 'جهاز فحص الضغط اليدوي Manual Pressure Test Device', 'Each', 1, 15, 'China', 'aneroid');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 4, 'جهاز ضغط الرقمي digital sphygmomanometer', 'Each', 1, 19, 'China', 'wrist system');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 5, 'جهاز قياس مستوى سكر الدم Blood Glucose Meter', 'Each', 2, 15, 'Korea', 'high accuracy');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 6, 'جهاز قياس الأكسجين Pulse oximetry', 'Each', 2, 15, 'China', '');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 7, 'جهاز تبخيرة Medical Nebulizer', 'Each', 2, 29, 'China', 'F-PUFF');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 8, 'نموذج الهيكل العظمي', 'Each', 1, 35, 'China', '85 cm');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 9, 'نموذج تشريح ذو أعضاء قابلة للفك والتركيب', 'Each', 1, 110, 'India', '85 cm');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 10, 'دمية لتطبيق الإسعاف الأولي الرئوي', 'Each', 1, 690, 'China', 'anatomical');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 11, 'عربة حمل الأدوات والتجهيزات الطبية Medical trolley', 'Each', 2, 90, 'China', 'SS-415');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 12, 'ميزان حرارة رقمي Digital Thermometer', 'Each', 2, 9.15, 'China', 'SS-318');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 13, 'نموذج الفك والأسنان', 'Each', 2, 29, 'China', 'anatomical');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 14, 'جهاز قياس قوة التدفق الزفيري', 'Each', 2, 9.5, 'China', 'high accuracy');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 15, 'صندوق التخلص من الأدوات الحادة Sharps Disposal Container', 'Each', 1, 3.25, 'China', '');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 16, 'صندوق فرز النفايات الطبية Medical WasteBox', 'Set', 1, 45, 'China', '3PCS');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 17, 'سرير فحص طبي يدوي Manual Medical Examination Bed', 'Each', 2, 80, 'China', 'Medical');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 18, 'شرشف سرير Bed Sheet', 'Each', 2, 9, 'China', 'hypoallergic');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 19, 'حرام سرير Bed Blanket', 'Each', 2, 11, 'China', 'hypoallergic');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 20, 'مخدة طبية مع غطاء medical pillow with Cover', 'Each', 2, 9.25, 'China', 'hypoallergic');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 21, 'ستارة', 'Each', 2, 65, 'China', 'Medical');

  RAISE NOTICE 'تم الإدخال بنجاح. رقم العرض: %', (SELECT number FROM public.quotations WHERE id = v_quote_id);

END $$;
