-- ============================================================
-- MedQuote Pro — Customers ERP Migration
-- يضيف الحقول الجديدة لجدول العملاء (آمن - لا يمس البيانات الموجودة)
-- شغّله في Supabase → SQL Editor
-- ============================================================

ALTER TABLE public.customers
  ADD COLUMN IF NOT EXISTS customer_code TEXT,
  ADD COLUMN IF NOT EXISTS fax          TEXT,
  ADD COLUMN IF NOT EXISTS mobile       TEXT,
  ADD COLUMN IF NOT EXISTS email        TEXT,
  ADD COLUMN IF NOT EXISTS city         TEXT,
  ADD COLUMN IF NOT EXISTS category     TEXT,
  ADD COLUMN IF NOT EXISTS tags         TEXT,
  -- الشخص المسؤول الأول
  ADD COLUMN IF NOT EXISTS contact1_name   TEXT,
  ADD COLUMN IF NOT EXISTS contact1_title  TEXT,
  ADD COLUMN IF NOT EXISTS contact1_phone  TEXT,
  ADD COLUMN IF NOT EXISTS contact1_mobile TEXT,
  ADD COLUMN IF NOT EXISTS contact1_email  TEXT,
  ADD COLUMN IF NOT EXISTS contact1_ext    TEXT,
  ADD COLUMN IF NOT EXISTS contact1_notes  TEXT,
  -- الشخص المسؤول الثاني
  ADD COLUMN IF NOT EXISTS contact2_name   TEXT,
  ADD COLUMN IF NOT EXISTS contact2_title  TEXT,
  ADD COLUMN IF NOT EXISTS contact2_phone  TEXT,
  ADD COLUMN IF NOT EXISTS contact2_mobile TEXT,
  ADD COLUMN IF NOT EXISTS contact2_email  TEXT,
  ADD COLUMN IF NOT EXISTS contact2_ext    TEXT,
  ADD COLUMN IF NOT EXISTS contact2_notes  TEXT;

-- تحقق من النتيجة
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'customers'
ORDER BY ordinal_position;
