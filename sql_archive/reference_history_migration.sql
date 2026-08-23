-- =========================================================
-- Reference History Migration
-- يحفظ المراجع تلقائياً عند كل حفظ عرض
-- =========================================================

-- 1. إنشاء الجدول
CREATE TABLE IF NOT EXISTS public.reference_history (
  name         TEXT PRIMARY KEY,
  last_used_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.reference_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "reference_history_all" ON public.reference_history
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- 2. استيراد بأثر رجعي: كل المراجع الموجودة في عروض الأسعار
INSERT INTO public.reference_history (name, last_used_at)
SELECT
  reference,
  MAX(COALESCE(updated_at, created_at))
FROM public.quotations
WHERE reference IS NOT NULL AND trim(reference) != ''
GROUP BY reference
ON CONFLICT (name) DO UPDATE
  SET last_used_at = EXCLUDED.last_used_at;
