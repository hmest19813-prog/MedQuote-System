-- =========================================================
-- Archive Reasons Backfill
-- استيراد بأثر رجعي لأسباب الأرشفة من الطلبيات والعروض القديمة
-- =========================================================

-- من الطلبيات
INSERT INTO public.archive_reasons (reason, last_used_at)
SELECT
  archive_note,
  MAX(COALESCE(archived_at, updated_at, created_at))
FROM public.orders
WHERE archive_note IS NOT NULL AND trim(archive_note) != ''
GROUP BY archive_note
ON CONFLICT (reason) DO UPDATE
  SET last_used_at = GREATEST(archive_reasons.last_used_at, EXCLUDED.last_used_at);

-- من العروض
INSERT INTO public.archive_reasons (reason, last_used_at)
SELECT
  archive_note,
  MAX(COALESCE(archived_at, updated_at, created_at))
FROM public.quotations
WHERE archive_note IS NOT NULL AND trim(archive_note) != ''
GROUP BY archive_note
ON CONFLICT (reason) DO UPDATE
  SET last_used_at = GREATEST(archive_reasons.last_used_at, EXCLUDED.last_used_at);
