-- تفريغ بيانات الكاش فان الحالية (كلها TEST DATA من مرحلة التطوير — تحققت من
-- ذلك بالباك أب قبل كتابة هذا الملف) تحضيراً لسيناريو تجريبي جديد كامل.
-- ما بيمس صف المندوب نفسه (أبو طارق) بجدول cashvan_external_reps.
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.

BEGIN;

-- نفضّي جدول تفاصيل الكليك أولاً احتياطاً (قد يحمل مرجع sale_id قديم بدون
-- ON DELETE CASCADE من إصدار سابق للتصميم يمنع حذف المبيعات).
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
