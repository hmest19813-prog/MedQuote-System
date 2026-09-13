-- إضافة حالة "ملغية" لطلبات اليوم (مستقلة، متاحة من أي مرحلة متل مرتجع)
ALTER TABLE public.daily_orders DROP CONSTRAINT IF EXISTS daily_orders_status_check;
ALTER TABLE public.daily_orders ADD CONSTRAINT daily_orders_status_check
  CHECK (status IN ('new','preparing','with_carrier','delivered','returned','cancelled'));
