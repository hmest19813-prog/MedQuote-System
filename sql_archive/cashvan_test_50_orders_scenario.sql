-- سيناريو تجريبي بحجم أكبر (50 طلبية) لاختبار الآلية بعد تبسيط التصميم:
-- بدون ترقيم أو طريقة دفع على الطلبية نفسها، وتفصيل الكليك حر بالتسوية فقط.
-- شغّل بعد cashvan_cleanup_test_data.sql (لتفريغ أي بيانات سابقة).
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor
-- (بعد تشغيل هجرتي period و settlement_click_items — لازمتين لهذا السيناريو).

BEGIN;

-- ===== تزويد بداية الفترة (كمية كافية لتغطية الـ50 طلبية + هامش) =====
INSERT INTO public.cashvan_stock_loads (id, rep_id, load_date, notes, total_cost) VALUES
  ('a2000000-0000-4000-8000-000000000001', '076c6381-0dd7-403c-a4a8-7c4d651bc2c1', '2026-09-21',
   'سيناريو تجريبي 50 طلبية: تزويد بداية الفترة', 1907.000);

INSERT INTO public.cashvan_stock_load_items (load_id, sort_order, item_name, quantity, unit_cost, total_cost) VALUES
  ('a2000000-0000-4000-8000-000000000001', 0, 'ستربات بيرفورما',           30, 8.000,  240.000),
  ('a2000000-0000-4000-8000-000000000001', 1, 'واخز انسولين 8',            30, 0.900,   27.000),
  ('a2000000-0000-4000-8000-000000000001', 2, 'جهاز ضغط الكتروني ساعد',    25, 30.000, 750.000),
  ('a2000000-0000-4000-8000-000000000001', 3, 'ستربات انستانت',            30, 6.500,  195.000),
  ('a2000000-0000-4000-8000-000000000001', 4, 'سرنجات انسولين',            25, 1.800,   45.000),
  ('a2000000-0000-4000-8000-000000000001', 5, 'جهاز حرارة عن بعد',         25, 12.000,  300.000),
  ('a2000000-0000-4000-8000-000000000001', 6, 'مشد ظهر',                   25, 14.000,  350.000);

-- ===== 50 طلبية موزّعة على 7 أيام (2026-09-21 → 2026-09-27)، صنف واحد لكل
-- طلبية يدور على 7 أصناف بكميات 1-4 — يكفي لاختبار الحجم والتجميع بالفترة =====
INSERT INTO public.cashvan_sales (id, rep_id, sale_date, period_from, period_to, payment_status, amount_paid, total_amount, notes)
SELECT
  ('b2000000-0000-4000-8000-' || lpad(gs::text,12,'0'))::uuid,
  '076c6381-0dd7-403c-a4a8-7c4d651bc2c1',
  '2026-09-21'::date + ((gs-1) % 7),
  '2026-09-21', '2026-09-27',
  'paid',
  ((1+(gs%4)) * (CASE gs%7 WHEN 0 THEN 12.000 WHEN 1 THEN 1.500 WHEN 2 THEN 45.000 WHEN 3 THEN 10.000 WHEN 4 THEN 3.000 WHEN 5 THEN 18.000 ELSE 22.000 END))::numeric(12,3),
  ((1+(gs%4)) * (CASE gs%7 WHEN 0 THEN 12.000 WHEN 1 THEN 1.500 WHEN 2 THEN 45.000 WHEN 3 THEN 10.000 WHEN 4 THEN 3.000 WHEN 5 THEN 18.000 ELSE 22.000 END))::numeric(12,3),
  'سيناريو تجريبي 50 طلبية — طلبية ' || gs
FROM generate_series(1,50) AS gs;

INSERT INTO public.cashvan_sale_items (sale_id, sort_order, item_name, quantity, unit_price, total_price)
SELECT
  ('b2000000-0000-4000-8000-' || lpad(gs::text,12,'0'))::uuid,
  0,
  CASE gs%7 WHEN 0 THEN 'ستربات بيرفورما' WHEN 1 THEN 'واخز انسولين 8' WHEN 2 THEN 'جهاز ضغط الكتروني ساعد'
            WHEN 3 THEN 'ستربات انستانت' WHEN 4 THEN 'سرنجات انسولين' WHEN 5 THEN 'جهاز حرارة عن بعد' ELSE 'مشد ظهر' END,
  (1+(gs%4))::numeric(10,3),
  (CASE gs%7 WHEN 0 THEN 12.000 WHEN 1 THEN 1.500 WHEN 2 THEN 45.000 WHEN 3 THEN 10.000 WHEN 4 THEN 3.000 WHEN 5 THEN 18.000 ELSE 22.000 END)::numeric(12,3),
  ((1+(gs%4)) * (CASE gs%7 WHEN 0 THEN 12.000 WHEN 1 THEN 1.500 WHEN 2 THEN 45.000 WHEN 3 THEN 10.000 WHEN 4 THEN 3.000 WHEN 5 THEN 18.000 ELSE 22.000 END))::numeric(12,3)
FROM generate_series(1,50) AS gs;

-- ===== تسوية الفترة =====
-- gross=1880 (50 طلبية) − توصيل 50×2.5=125 − مستحقات أخرى 20 = صافي 1735
-- منها كليك 148 (تفصيل حر: 2 أجهزة ضغط + 3 بيرفورما + مشد ظهر) → متوقع نقداً 1587 = المستلم (مطابق)
INSERT INTO public.cashvan_settlements
  (id, rep_id, settlement_date, method, notes, period_from, period_to,
   gross_amount, orders_count, delivery_rate, delivery_deduction, other_deductions, click_total, amount) VALUES
  ('c2000000-0000-4000-8000-000000000001', '076c6381-0dd7-403c-a4a8-7c4d651bc2c1', '2026-09-27', 'نقداً',
   'سيناريو تجريبي 50 طلبية: تسوية نهاية الفترة', '2026-09-21', '2026-09-27',
   1880.000, 50, 2.500, 125.000, 20.000, 148.000, 1587.000);

INSERT INTO public.cashvan_settlement_deductions (settlement_id, sort_order, label, amount) VALUES
  ('c2000000-0000-4000-8000-000000000001', 0, 'مصاريف وقود وصيانة الدراجة', 20.000);

INSERT INTO public.cashvan_settlement_click_payments (settlement_id, sort_order, item_name, quantity, unit_price, sale_date, amount) VALUES
  ('c2000000-0000-4000-8000-000000000001', 0, 'جهاز ضغط الكتروني ساعد', 2, 45.000, '2026-09-23', 90.000),
  ('c2000000-0000-4000-8000-000000000001', 1, 'ستربات بيرفورما',        3, 12.000, '2026-09-24', 36.000),
  ('c2000000-0000-4000-8000-000000000001', 2, 'مشد ظهر',                1, 22.000, '2026-09-26', 22.000);

COMMIT;
