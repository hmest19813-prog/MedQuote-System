-- Requester info fields on quotations (internal, not printed)
ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS requester_name   TEXT,
  ADD COLUMN IF NOT EXISTS requester_phone  TEXT,
  ADD COLUMN IF NOT EXISTS requester_phone2 TEXT;
