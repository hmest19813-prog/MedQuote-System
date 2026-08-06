-- =========================================================
-- Order Customer Reference Migration
-- إضافة مرجع الزبون ورقم الشراء على جدول الطلبات
-- =========================================================

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS customer_ref TEXT,
  ADD COLUMN IF NOT EXISTS po_number    TEXT;

COMMENT ON COLUMN public.orders.customer_ref IS 'مرجع الزبون — يُعبَّأ يدوياً حسب ما يزوّده الزبون';
COMMENT ON COLUMN public.orders.po_number    IS 'رقم أمر الشراء (PO Number) الخاص بالزبون';
