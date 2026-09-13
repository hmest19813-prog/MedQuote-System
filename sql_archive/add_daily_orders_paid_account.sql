-- إضافة حقل "الحساب المستلم عليه الدفع" لطلبات اليوم المدفوعة مسبقاً
ALTER TABLE public.daily_orders ADD COLUMN IF NOT EXISTS paid_account text;
