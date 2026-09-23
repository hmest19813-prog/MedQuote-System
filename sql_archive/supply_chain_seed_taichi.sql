-- ============================================================
-- إضافة أول رحلة توريد: TAICHI HOLDINGS LIMITED (طلبية 3B - KOKEN
-- Maternity Model Type II) — من الفاتورة الأولية KKN-EGY-202602-001
-- وإشعار تحويل بنك الاتحاد بتاريخ 2026-09-13.
--
-- شغّله كاملاً دفعة واحدة في Supabase SQL Editor
-- (بعد التأكد إن supply_chain_migration.sql اشتغل مسبقاً).
-- ============================================================

BEGIN;

WITH new_file AS (
  INSERT INTO public.supply_files
    (supplier_name, description, origin_country, currency, total_value, status, notes, created_by)
  VALUES (
    'TAICHI HOLDINGS LIMITED',
    'طلبية 3B - KOKEN Brand - LM043N-CE Maternity Model Type II (الكمية 1)',
    'اليابان',
    'JPY',
    375000,
    'in_progress',
    'فاتورة أولية رقم KKN-EGY-202602-001 بتاريخ 2026/6/24. شروط EXW طوكيو. صلاحية العرض حتى 2026/8/31. الدفع 100% تحويل بنكي مقدماً، الشحن خلال أسبوعين من استلام الدفعة.',
    '445bc65d-256f-48d3-9367-464a408e657b'
  )
  RETURNING id
),
stage_defs(stage_key, seq) AS (
  VALUES
    ('rfq',0),('supplier_quote',1),('invoice_approval',2),('shipping_terms',3),
    ('payment_transfer',4),('goods_shipped',5),('border_arrival',6),
    ('customs_free_zone',7),('customs_warehouse',8),('customs_bol_waiver',9)
)
INSERT INTO public.supply_file_stages (file_id, stage_key, seq, status, stage_date, value, notes)
SELECT new_file.id, sd.stage_key, sd.seq,
  CASE sd.stage_key
    WHEN 'supplier_quote' THEN 'done'
    WHEN 'invoice_approval' THEN 'done'
    WHEN 'shipping_terms' THEN 'in_progress'
    WHEN 'payment_transfer' THEN 'done'
    ELSE 'pending'
  END,
  CASE sd.stage_key
    WHEN 'supplier_quote' THEN DATE '2026-06-24'
    WHEN 'invoice_approval' THEN DATE '2026-06-24'
    WHEN 'payment_transfer' THEN DATE '2026-09-13'
    ELSE NULL
  END,
  CASE sd.stage_key
    WHEN 'shipping_terms' THEN 'us'
    ELSE NULL
  END,
  CASE sd.stage_key
    WHEN 'supplier_quote' THEN 'فاتورة أولية (Proforma Invoice) رقم KKN-EGY-202602-001 من TAICHI HOLDINGS LIMITED، طوكيو - القيمة JPY 375,000 EXW طوكيو - صلاحية العرض حتى 2026/8/31'
    WHEN 'invoice_approval' THEN 'اعتُمدت الفاتورة الأولية وتم المباشرة بالتحويل بناءً عليها'
    WHEN 'shipping_terms' THEN 'شروط EXW طوكيو - الشحن على حسابنا (us)'
    WHEN 'payment_transfer' THEN 'تحويل عبر بنك الاتحاد من حساب مؤسسة الحياة العلمية (محمد جوابرة) إلى TAICHI HOLDINGS LIMITED عبر Sumitomo Mitsui Banking Corporation - المبلغ JPY 375,000 - إجمالي المصاريف المخصومة USD 2,466.38 (عمولة USD 14.1) - رقم مرجعي التحويل 399R201262561766'
    ELSE NULL
  END
FROM new_file, stage_defs sd;

COMMIT;

-- تحقق سريع
SELECT number, supplier_name, description, currency, total_value, status
FROM public.supply_files ORDER BY created_at DESC LIMIT 1;
