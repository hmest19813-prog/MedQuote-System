-- تجميع طلبيات الكاش فان بكرت واحد لكل فترة إدخال (أسبوع عادةً) بدل كرت
-- منفرد لكل طلبية. الفترة تُحدَّد يدوياً وقت الإدخال (من/إلى) وتُخزَّن على كل
-- طلبية بنفس الدفعة. sale_date يبقى كما هو (يُضبط تلقائياً = period_to) لأن
-- تسوية الفترة (cashvan_settlements) لسا بتفلتر عليه.
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.

BEGIN;

ALTER TABLE public.cashvan_sales
  ADD COLUMN IF NOT EXISTS period_from date,
  ADD COLUMN IF NOT EXISTS period_to   date;

CREATE INDEX IF NOT EXISTS idx_cashvan_sales_period ON public.cashvan_sales USING btree (rep_id, period_from, period_to);

COMMIT;
