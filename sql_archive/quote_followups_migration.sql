-- جدول ملاحظات متابعة العروض
CREATE TABLE IF NOT EXISTS public.quote_followups (
  id            UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
  quotation_id  UUID        NOT NULL REFERENCES public.quotations(id) ON DELETE CASCADE,
  note          TEXT        NOT NULL,
  created_by    UUID        REFERENCES public.profiles(id),
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- RLS
ALTER TABLE public.quote_followups ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users can manage followups" ON public.quote_followups
  FOR ALL USING (true) WITH CHECK (true);
