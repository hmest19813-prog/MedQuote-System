-- سيناريو تجربة كامل: أسبوع وهمي لأبو طارق بالكاش فان — من التزويد للتسوية.
-- كل الصفوف موسومة "TEST DATA" بحقل notes، فبينحذفوا كلهم بملف
-- cashvan_test_data_cleanup.sql الموجود مسبقاً (بدون تعديل عليه).
--
-- يفترض تشغيل هذه الملفات مسبقاً بنفس الترتيب:
--   cashvan_migration.sql
--   cashvan_external_reps_migration.sql   (عشان أبو طارق موجود بجدول cashvan_external_reps)
--   cashvan_settlement_details_migration.sql
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.

DO $$
DECLARE
  v_rep   uuid;
  v_load1 uuid;
  v_load2 uuid;
  v_sale1 uuid;
  v_sale2 uuid;
  v_sale3 uuid;
  v_sale4 uuid;
  v_sale5 uuid;
  v_settle uuid;
  v_gross  numeric(12,3) := 0;
  v_orders integer := 5;
  v_rate   numeric(12,3) := 2.5;
  v_delivery_ded numeric(12,3);
  v_other_ded    numeric(12,3) := 10.000;
BEGIN
  SELECT id INTO v_rep FROM public.cashvan_external_reps WHERE full_name = 'أبو طارق' LIMIT 1;
  IF v_rep IS NULL THEN
    RAISE EXCEPTION 'أبو طارق غير موجود بجدول cashvan_external_reps — شغّل cashvan_external_reps_migration.sql أولاً';
  END IF;

  -- ── تزويد 1 (بداية الأسبوع) ──────────────────────────────
  INSERT INTO public.cashvan_stock_loads (rep_id, load_date, notes)
  VALUES (v_rep, CURRENT_DATE - 6, 'TEST DATA — أسبوع وهمي: تزويد 1')
  RETURNING id INTO v_load1;
  INSERT INTO public.cashvan_stock_load_items (load_id, sort_order, item_name, quantity) VALUES
    (v_load1, 0, 'ستربات بيرفورما', 40),
    (v_load1, 1, 'واخز انسولين 5',  100),
    (v_load1, 2, 'سرنجات انسولين',  60);

  -- ── تزويد 2 (تكملة نص الأسبوع) ───────────────────────────
  INSERT INTO public.cashvan_stock_loads (rep_id, load_date, notes)
  VALUES (v_rep, CURRENT_DATE - 3, 'TEST DATA — أسبوع وهمي: تزويد 2')
  RETURNING id INTO v_load2;
  INSERT INTO public.cashvan_stock_load_items (load_id, sort_order, item_name, quantity) VALUES
    (v_load2, 0, 'ستربات بيرفورما', 20),
    (v_load2, 1, 'ستربات انستانت', 30);

  -- ── 5 طلبيات (عمليات بيع) موزّعة على الأسبوع، بعضها متعدد الأصناف ──

  INSERT INTO public.cashvan_sales (rep_id, sale_date, payment_status, amount_paid, total_amount, notes)
  VALUES (v_rep, CURRENT_DATE - 5, 'paid', 50.000, 50.000, 'TEST DATA — أسبوع وهمي: طلبية 1')
  RETURNING id INTO v_sale1;
  INSERT INTO public.cashvan_sale_items (sale_id, sort_order, item_name, quantity, unit_price, total_price) VALUES
    (v_sale1, 0, 'ستربات بيرفورما', 10, 4.000, 40.000),
    (v_sale1, 1, 'واخز انسولين 5',  20, 0.500, 10.000);

  INSERT INTO public.cashvan_sales (rep_id, sale_date, payment_status, amount_paid, total_amount, notes)
  VALUES (v_rep, CURRENT_DATE - 4, 'paid', 34.000, 34.000, 'TEST DATA — أسبوع وهمي: طلبية 2')
  RETURNING id INTO v_sale2;
  INSERT INTO public.cashvan_sale_items (sale_id, sort_order, item_name, quantity, unit_price, total_price) VALUES
    (v_sale2, 0, 'ستربات بيرفورما', 8, 4.250, 34.000);

  INSERT INTO public.cashvan_sales (rep_id, sale_date, payment_status, amount_paid, total_amount, notes)
  VALUES (v_rep, CURRENT_DATE - 3, 'paid', 53.000, 53.000, 'TEST DATA — أسبوع وهمي: طلبية 3')
  RETURNING id INTO v_sale3;
  INSERT INTO public.cashvan_sale_items (sale_id, sort_order, item_name, quantity, unit_price, total_price) VALUES
    (v_sale3, 0, 'سرنجات انسولين',  15, 1.000, 15.000),
    (v_sale3, 1, 'ستربات انستانت', 10, 3.800, 38.000);

  INSERT INTO public.cashvan_sales (rep_id, sale_date, payment_status, amount_paid, total_amount, notes)
  VALUES (v_rep, CURRENT_DATE - 2, 'paid', 15.000, 15.000, 'TEST DATA — أسبوع وهمي: طلبية 4')
  RETURNING id INTO v_sale4;
  INSERT INTO public.cashvan_sale_items (sale_id, sort_order, item_name, quantity, unit_price, total_price) VALUES
    (v_sale4, 0, 'واخز انسولين 5', 30, 0.500, 15.000);

  INSERT INTO public.cashvan_sales (rep_id, sale_date, payment_status, amount_paid, total_amount, notes)
  VALUES (v_rep, CURRENT_DATE - 1, 'paid', 55.600, 55.600, 'TEST DATA — أسبوع وهمي: طلبية 5')
  RETURNING id INTO v_sale5;
  INSERT INTO public.cashvan_sale_items (sale_id, sort_order, item_name, quantity, unit_price, total_price) VALUES
    (v_sale5, 0, 'ستربات انستانت', 12, 3.800, 45.600),
    (v_sale5, 1, 'سرنجات انسولين', 10, 1.000, 10.000);

  -- ── تسوية نهاية الأسبوع (فترة تغطي الطلبيات الخمسة) ──────
  v_gross := 50.000 + 34.000 + 53.000 + 15.000 + 55.600;          -- 207.600
  v_delivery_ded := v_orders * v_rate;                            -- 12.500

  INSERT INTO public.cashvan_settlements
    (rep_id, settlement_date, period_from, period_to, gross_amount, orders_count,
     delivery_rate, delivery_deduction, other_deductions, amount, method, notes)
  VALUES
    (v_rep, CURRENT_DATE - 1, CURRENT_DATE - 6, CURRENT_DATE - 1, v_gross, v_orders,
     v_rate, v_delivery_ded, v_other_ded, v_gross - v_delivery_ded - v_other_ded, 'نقداً',
     'TEST DATA — أسبوع وهمي: تسوية نهاية الأسبوع')
  RETURNING id INTO v_settle;

  INSERT INTO public.cashvan_settlement_deductions (settlement_id, sort_order, label, amount)
  VALUES (v_settle, 0, 'سلفة أسبوعية', v_other_ded);

  RAISE NOTICE 'تم إدخال سيناريو الأسبوع الوهمي — المندوب %، إجمالي الفاتورة %، الصافي %',
    v_rep, v_gross, (v_gross - v_delivery_ded - v_other_ded);
END $$;

-- الأرقام المتوقعة للتحقق اليدوي بعد التشغيل:
--   المتبقي مع أبو طارق: ستربات بيرفورما 42، واخز انسولين 5 = 50، سرنجات انسولين 35، ستربات انستانت 8
--   عدد الطلبيات بالأسبوع: 5 — إجمالي الفاتورة: 207.600 د.أ
--   خصم توصيل: 12.500 (5×2.5) — مستحقات أخرى: 10.000 (سلفة أسبوعية)
--   الصافي المطلوب تسليمه: 185.100 د.أ
