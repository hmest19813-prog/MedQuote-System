-- بيانات وهمية لتجربة تقرير "الكاش فان" فقط — 5 عمليات (2 تزويد + 2 بيع + 1 تسوية)
-- كل الصفوف موسومة بـ"TEST DATA" داخل notes عشان يسهل حذفها بعدين بملف
-- cashvan_test_data_cleanup.sql. شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor
-- بعد ما يكون cashvan_migration.sql منفّذ مسبقاً.
--
-- بيستخدم أول مستخدم فعّال بجدول profiles كـ"المندوب" التجريبي.

DO $$
DECLARE
  v_rep   uuid;
  v_load1 uuid;
  v_load2 uuid;
  v_sale1 uuid;
  v_sale2 uuid;
BEGIN
  SELECT id INTO v_rep FROM public.profiles WHERE is_active = true ORDER BY full_name LIMIT 1;
  IF v_rep IS NULL THEN RAISE EXCEPTION 'لا يوجد أي مستخدم فعّال بجدول profiles لاستخدامه كمندوب تجريبي'; END IF;

  -- تزويد 1: بضاعة أولية
  INSERT INTO public.cashvan_stock_loads (rep_id, load_date, notes, total_cost)
  VALUES (v_rep, CURRENT_DATE - 10, 'TEST DATA — تزويد تجريبي 1 (للحذف بعد التجربة)', 250.000)
  RETURNING id INTO v_load1;
  INSERT INTO public.cashvan_stock_load_items (load_id, sort_order, item_name, quantity, unit_cost, total_cost) VALUES
    (v_load1, 0, 'TEST - منتج أ', 50, 2.000, 100.000),
    (v_load1, 1, 'TEST - منتج ب', 30, 5.000, 150.000);

  -- تزويد 2: تكملة بعد أيام
  INSERT INTO public.cashvan_stock_loads (rep_id, load_date, notes, total_cost)
  VALUES (v_rep, CURRENT_DATE - 5, 'TEST DATA — تزويد تجريبي 2 (للحذف بعد التجربة)', 40.000)
  RETURNING id INTO v_load2;
  INSERT INTO public.cashvan_stock_load_items (load_id, sort_order, item_name, quantity, unit_cost, total_cost) VALUES
    (v_load2, 0, 'TEST - منتج أ', 20, 2.000, 40.000);

  -- بيع 1: زبون مدفوع بالكامل
  INSERT INTO public.cashvan_sales (rep_id, sale_date, customer_name, customer_phone, payment_status, amount_paid, total_amount, notes)
  VALUES (v_rep, CURRENT_DATE - 8, 'أحمد اختبار', '0790000001', 'paid', 122.500, 122.500, 'TEST DATA — بيع تجريبي 1 (للحذف بعد التجربة)')
  RETURNING id INTO v_sale1;
  INSERT INTO public.cashvan_sale_items (sale_id, sort_order, item_name, quantity, unit_price, total_price) VALUES
    (v_sale1, 0, 'TEST - منتج أ', 15, 3.500, 52.500),
    (v_sale1, 1, 'TEST - منتج ب', 10, 7.000, 70.000);

  -- بيع 2: زبون بسعر مختلف ودفع جزئي (باقي عليه 27.000)
  INSERT INTO public.cashvan_sales (rep_id, sale_date, customer_name, customer_phone, payment_status, amount_paid, total_amount, notes)
  VALUES (v_rep, CURRENT_DATE - 3, 'سامر تجربة', '0790000002', 'partial', 100.000, 127.000, 'TEST DATA — بيع تجريبي 2 (للحذف بعد التجربة)')
  RETURNING id INTO v_sale2;
  INSERT INTO public.cashvan_sale_items (sale_id, sort_order, item_name, quantity, unit_price, total_price) VALUES
    (v_sale2, 0, 'TEST - منتج أ', 25, 3.000, 75.000),
    (v_sale2, 1, 'TEST - منتج ب', 8, 6.500, 52.000);

  -- تسوية: المندوب سلّم جزءاً من الكاش المحصّل (150 من أصل 222.5 محصّل)
  INSERT INTO public.cashvan_settlements (rep_id, settlement_date, amount, method, notes)
  VALUES (v_rep, CURRENT_DATE - 1, 150.000, 'نقداً', 'TEST DATA — تسوية تجريبية (للحذف بعد التجربة)');

  RAISE NOTICE 'تم إدخال 5 عمليات تجريبية للمندوب %', v_rep;
END $$;

-- الأرقام المتوقعة بتقرير "نظرة عامة" بعد التشغيل:
--   TEST - منتج أ: تزويد 70 − مبيعات 40 = متبقي 30
--   TEST - منتج ب: تزويد 30 − مبيعات 18 = متبقي 12
--   إجمالي المبيعات: 249.500 د.أ | محصَّل: 222.500 | مسوّى: 150.000 | بعهدته: 72.500 | ذمم غير محصّلة: 27.000
