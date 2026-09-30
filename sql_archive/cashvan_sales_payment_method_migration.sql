-- بدل ربط دفعات "كليك" بجدول منفصل (cashvan_settlement_click_payments) مع قائمة
-- منسدلة جامدة تحصر الاختيار بطلبيات مُدخلة مسبقاً — نضيف طريقة الدفع مباشرة
-- على كل طلبية (نقداً/كليك) وقت إدخالها بالدفعة الأسبوعية. هيك:
--   - المخزون بينخصم تلقائياً لأي طلبية بغض النظر عن طريقة الدفع (لأنها طلبية حقيقية بأصنافها).
--   - التسوية بتحسب "منها عبر كليك" تلقائياً = مجموع طلبيات الفترة يلي طريقة دفعها كليك،
--     بدون أي خطوة يدوية إضافية وقت التسوية.
-- جدول cashvan_settlement_click_payments (من الهجرة السابقة) ما عاد يُستخدم من الكود
-- الحالي، تُرك كما هو بدون حذف (ما فيه بيانات إنتاج عليه بعد).
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.

BEGIN;

ALTER TABLE public.cashvan_sales
  ADD COLUMN IF NOT EXISTS payment_method text NOT NULL DEFAULT 'نقداً';

ALTER TABLE public.cashvan_sales
  DROP CONSTRAINT IF EXISTS cashvan_sales_payment_method_check;
ALTER TABLE public.cashvan_sales
  ADD CONSTRAINT cashvan_sales_payment_method_check CHECK (payment_method = ANY (ARRAY['نقداً'::text, 'كليك'::text]));

COMMIT;
