-- ============================================================
-- تصحيح بيانات لمرة واحدة: تزويدا الجرد CVL-2026-001 و CVL-2026-002
-- (أبو طارق) لازم يكونوا أحدث سجلّين زمنياً بالنظام (created_at)
-- حتى لو تاريخهم (load_date) نفس يوم الطلبية/التسوية المتأخرة —
-- عشان حساب "المتبقي معه" (stockByRep بالكود) يعتبرهم نقطة
-- تصفير فعلية ويتجاهل كل تزويد/مبيعات أقدم منهم زمنياً.
-- لا يغيّر load_date (يضل نفس اليوم كما هو، بطلب المستخدم).
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.
-- ============================================================

BEGIN;

UPDATE public.cashvan_stock_loads
SET created_at = now()
WHERE number IN ('CVL-2026-001', 'CVL-2026-002');

COMMIT;

-- تحقق:
SELECT number, rep_id, load_date, is_stocktake, created_at
FROM public.cashvan_stock_loads
WHERE number IN ('CVL-2026-001', 'CVL-2026-002')
ORDER BY created_at;
