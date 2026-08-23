-- ============================================================
-- MedQuote Pro — Catalog Migration
-- ينشئ جدول كتالوج الأصناف (آمن - يعمل عدة مرات بدون أخطاء)
-- شغّله في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.catalog_items (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT        NOT NULL,
  description TEXT,
  unit        TEXT        DEFAULT 'EACH',
  unit_price  NUMERIC     DEFAULT 0,
  origin      TEXT        DEFAULT 'CHINA',
  delivery    TEXT        DEFAULT 'PROMPT',
  category    TEXT,
  notes       TEXT,
  is_active   BOOLEAN     DEFAULT true,
  created_by  UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.catalog_items ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "catalog_select" ON public.catalog_items;
DROP POLICY IF EXISTS "catalog_insert" ON public.catalog_items;
DROP POLICY IF EXISTS "catalog_update" ON public.catalog_items;
DROP POLICY IF EXISTS "catalog_delete" ON public.catalog_items;

-- كل المستخدمين المسجلين يرون الكتالوج
CREATE POLICY "catalog_select" ON public.catalog_items
  FOR SELECT USING (auth.uid() IS NOT NULL);

-- أي مستخدم مسجل يضيف صنف
CREATE POLICY "catalog_insert" ON public.catalog_items
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

-- صاحب الصنف أو Admin يعدّله
CREATE POLICY "catalog_update" ON public.catalog_items
  FOR UPDATE USING (
    created_by = auth.uid()
    OR get_my_role() IN ('admin', 'manager')
  );

-- Admin فقط يحذف
CREATE POLICY "catalog_delete" ON public.catalog_items
  FOR DELETE USING (get_my_role() IN ('admin', 'manager'));

-- فهرس للبحث السريع
CREATE INDEX IF NOT EXISTS catalog_items_name_idx ON public.catalog_items USING gin(to_tsvector('simple', name));

-- تحقق من النتيجة
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'catalog_items'
ORDER BY ordinal_position;
