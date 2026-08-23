-- =========================================================
-- Customer Name History Migration
-- يحفظ أسماء العملاء تلقائياً عند كل حفظ عرض
-- =========================================================

-- 1. إنشاء الجدول
CREATE TABLE IF NOT EXISTS public.customer_name_history (
  name         TEXT PRIMARY KEY,
  last_used_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.customer_name_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "customer_name_history_all" ON public.customer_name_history
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- 2. استيراد بأثر رجعي: كل الأسماء الموجودة في عروض الأسعار
INSERT INTO public.customer_name_history (name, last_used_at)
SELECT
  customer_name,
  MAX(COALESCE(updated_at, created_at))
FROM public.quotations
WHERE customer_name IS NOT NULL AND trim(customer_name) != ''
GROUP BY customer_name
ON CONFLICT (name) DO UPDATE
  SET last_used_at = EXCLUDED.last_used_at;
