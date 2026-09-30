-- تبسيط تفصيل "المدفوع عبر كليك" بالتسوية: بدل الربط بطلبية محدّدة موجودة
-- بالنظام (sale_id)، صار بند وصفي حر (صنف + كمية + سعر + تاريخ) لتفسير الفرق
-- بالكاش المستلم فقط — بدون أي علاقة بحساب المخزون (البضاعة اتخصمت مسبقاً
-- وقت تسجيل الطلبية الأصلية بدفعة المبيعات العادية).
--
-- يُبنى على جدول cashvan_settlement_click_payments الموجود مسبقاً (كان بس
-- sale_id + amount). عمود sale_id يبقى بدون استخدام من الكود، بلا داعي لحذفه.
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.

BEGIN;

ALTER TABLE public.cashvan_settlement_click_payments
  ADD COLUMN IF NOT EXISTS item_name  text,
  ADD COLUMN IF NOT EXISTS quantity   numeric(10,3),
  ADD COLUMN IF NOT EXISTS unit_price numeric(12,3),
  ADD COLUMN IF NOT EXISTS sale_date  date;

COMMIT;
