-- ============================================================
-- MedQuote Pro — Inbox (البريد الوارد) Migration
-- شغّل في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.inbox_items (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id      uuid        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  from_company text        NOT NULL,
  type         text        NOT NULL DEFAULT 'other',  -- quote/order/invoice/letter/other
  title        text        NOT NULL,
  reference    text,                                   -- رقم مرجعي اختياري
  received_at  date        NOT NULL DEFAULT CURRENT_DATE,
  description  text        NOT NULL DEFAULT '',
  assigned_to  uuid        REFERENCES auth.users(id) ON DELETE SET NULL,
  status       text        NOT NULL DEFAULT 'new',    -- new/reviewed/pending/archived
  notes        text        NOT NULL DEFAULT '',
  created_at   timestamptz DEFAULT now(),
  updated_at   timestamptz DEFAULT now()
);

ALTER TABLE public.inbox_items ENABLE ROW LEVEL SECURITY;

-- كل الموظفين يقرؤون
CREATE POLICY "inbox_sel" ON public.inbox_items
  FOR SELECT USING (auth.role() = 'authenticated');

-- كل الموظفين يضيفون
CREATE POLICY "inbox_ins" ON public.inbox_items
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- صاحب البند أو الـ admin يعدّل
CREATE POLICY "inbox_upd" ON public.inbox_items
  FOR UPDATE USING (
    auth.uid() = user_id OR
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- صاحب البند أو الـ admin يحذف
CREATE POLICY "inbox_del" ON public.inbox_items
  FOR DELETE USING (
    auth.uid() = user_id OR
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- تحقق من الإنشاء
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'inbox_items'
ORDER BY ordinal_position;
