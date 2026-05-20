-- ============================================================
-- MedQuote Pro — Soft Delete + Reset Sequence Migration
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- 1) إضافة أعمدة الحذف الناعم على جدول عروض الأسعار
ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS deleted_at     TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS deleted_by     UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS delete_reason  TEXT;

-- 2) تصفير الرقم التسلسلي لعروض الأسعار
UPDATE public.number_sequences
SET current_value = 0
WHERE id = 'quotation';

-- تحقق
SELECT id, prefix, current_value, year FROM public.number_sequences;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'quotations'
  AND column_name IN ('deleted_at','deleted_by','delete_reason')
ORDER BY column_name;
