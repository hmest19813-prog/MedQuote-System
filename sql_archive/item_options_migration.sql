-- ─────────────────────────────────────────────────────────────
-- Multi-source options per line item
-- الصفوف التي تحمل نفس option_group هي مصادر بديلة لنفس المنتج
-- يُحتسب في المجموع الخيار الأعلى قيمة فقط ضمن كل مجموعة
-- شغّل هذا مرة واحدة في Supabase SQL Editor
-- ─────────────────────────────────────────────────────────────

ALTER TABLE public.quotation_items
  ADD COLUMN IF NOT EXISTS option_group TEXT;
