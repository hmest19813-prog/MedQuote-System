-- ملاحظة اختيارية يكتبها الموظف المسجّل للطلبية موجّهة لموظف التجهيز
ALTER TABLE public.daily_orders ADD COLUMN IF NOT EXISTS prep_note text;
