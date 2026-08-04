-- جدول أسباب الأرشفة المشترك
CREATE TABLE IF NOT EXISTS archive_reasons (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  reason text NOT NULL UNIQUE,
  last_used_at timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now()
);

ALTER TABLE archive_reasons ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated can select archive_reasons" ON archive_reasons
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "authenticated can insert archive_reasons" ON archive_reasons
  FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "authenticated can update archive_reasons" ON archive_reasons
  FOR UPDATE TO authenticated USING (true);

-- بالأثر الرجعي: استيراد الأسباب من العروض المؤرشفة
INSERT INTO archive_reasons (reason)
SELECT DISTINCT TRIM(archive_note) FROM quotations
WHERE archived = true AND archive_note IS NOT NULL AND TRIM(archive_note) != ''
ON CONFLICT (reason) DO NOTHING;

-- بالأثر الرجعي: استيراد الأسباب من الطلبات المؤرشفة
INSERT INTO archive_reasons (reason)
SELECT DISTINCT TRIM(archive_note) FROM orders
WHERE archived = true AND archive_note IS NOT NULL AND TRIM(archive_note) != ''
ON CONFLICT (reason) DO NOTHING;
