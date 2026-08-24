-- =========================================================
-- Requester History Migration
-- يحفظ اسم/هاتف عميل المتابعة تلقائياً عند كل حفظ عرض
-- =========================================================

-- 1. إنشاء الجدول
CREATE TABLE IF NOT EXISTS public.requester_history (
  name          TEXT PRIMARY KEY,
  phone         TEXT,
  phone2        TEXT,
  last_used_at  TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.requester_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "requester_history_all" ON public.requester_history
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

GRANT ALL ON TABLE public.requester_history TO anon;
GRANT ALL ON TABLE public.requester_history TO authenticated;
GRANT ALL ON TABLE public.requester_history TO service_role;

-- 2. استيراد بأثر رجعي: كل عملاء المتابعة الموجودين في عروض الأسعار السابقة
-- (لكل اسم، نأخذ آخر رقم هاتف استُخدم معه)
INSERT INTO public.requester_history (name, phone, phone2, last_used_at)
SELECT DISTINCT ON (requester_name)
  requester_name,
  requester_phone,
  requester_phone2,
  COALESCE(updated_at, created_at)
FROM public.quotations
WHERE requester_name IS NOT NULL AND trim(requester_name) != ''
ORDER BY requester_name, COALESCE(updated_at, created_at) DESC
ON CONFLICT (name) DO UPDATE
  SET phone = EXCLUDED.phone,
      phone2 = EXCLUDED.phone2,
      last_used_at = EXCLUDED.last_used_at;
