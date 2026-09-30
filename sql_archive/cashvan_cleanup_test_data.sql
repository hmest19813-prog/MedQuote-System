-- تفريغ بيانات الكاش فان الحالية (كلها TEST DATA من مرحلة التطوير — تحققت من
-- ذلك بالباك أب قبل كتابة هذا الملف) تحضيراً لسيناريو تجريبي جديد كامل.
-- ما بيمس صف المندوب نفسه (أبو طارق) بجدول cashvan_external_reps.
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.

BEGIN;

-- جدول قديم من تصميم سابق لخاصية الكليك (استُبدل بحقل payment_method على
-- الطلبية نفسها) — لسا فيه صف يشير لطلبية قديمة، لازم يتفضّى قبل حذف المبيعات
-- لأن مرجعه لـsale_id بدون ON DELETE CASCADE.
DELETE FROM public.cashvan_settlement_click_payments;

DELETE FROM public.cashvan_sale_items
  WHERE sale_id IN (SELECT id FROM public.cashvan_sales);
DELETE FROM public.cashvan_sales;

DELETE FROM public.cashvan_stock_load_items
  WHERE load_id IN (SELECT id FROM public.cashvan_stock_loads);
DELETE FROM public.cashvan_stock_loads;

-- cashvan_settlement_deductions و cashvan_settlement_click_payments بيتحذفوا
-- تلقائياً (ON DELETE CASCADE) عند حذف التسوية.
DELETE FROM public.cashvan_settlements;

COMMIT;
