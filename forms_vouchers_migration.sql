-- =========================================================
-- Forms / Vouchers Migration
-- نماذج جاهزة: سند صرف وسند قبض
-- =========================================================

CREATE TABLE IF NOT EXISTS public.vouchers (
  id              UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  type            TEXT        NOT NULL CHECK (type IN ('payment','receipt')),
  number          TEXT        NOT NULL,
  date            DATE        NOT NULL DEFAULT CURRENT_DATE,
  amount          NUMERIC(14,3) NOT NULL DEFAULT 0,
  currency        TEXT        NOT NULL DEFAULT 'JOD',
  party           TEXT,           -- المدفوع له (صرف) / المستلَم من (قبض)
  description     TEXT,           -- البيان
  payment_method  TEXT        NOT NULL DEFAULT 'نقداً',
  reference       TEXT,           -- رقم شيك / مرجع
  prepared_by     TEXT,
  approved_by     TEXT,
  notes           TEXT,
  created_by      UUID        REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at      TIMESTAMPTZ DEFAULT NOW(),
  updated_at      TIMESTAMPTZ DEFAULT NOW(),
  archived        BOOLEAN     DEFAULT FALSE,
  archive_reason  TEXT
);

-- فهرس على النوع لتسريع الفلترة
CREATE INDEX IF NOT EXISTS vouchers_type_idx ON public.vouchers(type);

-- Trigger لتحديث updated_at تلقائياً
CREATE OR REPLACE FUNCTION update_vouchers_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END; $$;

DROP TRIGGER IF EXISTS trg_vouchers_updated_at ON public.vouchers;
CREATE TRIGGER trg_vouchers_updated_at
  BEFORE UPDATE ON public.vouchers
  FOR EACH ROW EXECUTE FUNCTION update_vouchers_updated_at();

-- RLS
ALTER TABLE public.vouchers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "vouchers_all" ON public.vouchers FOR ALL USING (auth.uid() IS NOT NULL);
