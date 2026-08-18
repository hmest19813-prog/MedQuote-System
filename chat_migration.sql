-- ============================================================
-- MedQuote Pro — Chat, Quote Discussions & Change Requests
-- شغّل في Supabase → SQL Editor
-- ============================================================

-- 1. شات جماعي -----------------------------------------------
CREATE TABLE IF NOT EXISTS public.chat_messages (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    uuid        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  body       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.chat_messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "chat_sel" ON public.chat_messages FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "chat_ins" ON public.chat_messages FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "chat_del" ON public.chat_messages FOR DELETE USING (auth.uid() = user_id);
ALTER PUBLICATION supabase_realtime ADD TABLE public.chat_messages;
ALTER TABLE public.chat_messages REPLICA IDENTITY FULL;

-- 2. نقاش العروض ----------------------------------------------
CREATE TABLE IF NOT EXISTS public.quote_discussions (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  quotation_id uuid        REFERENCES public.quotations(id) ON DELETE CASCADE NOT NULL,
  user_id      uuid        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  body         text        NOT NULL,
  created_at   timestamptz DEFAULT now()
);
ALTER TABLE public.quote_discussions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "disc_sel" ON public.quote_discussions FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "disc_ins" ON public.quote_discussions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "disc_del" ON public.quote_discussions FOR DELETE USING (auth.uid() = user_id);
ALTER PUBLICATION supabase_realtime ADD TABLE public.quote_discussions;
ALTER TABLE public.quote_discussions REPLICA IDENTITY FULL;

-- 3. طلبات التعديل (مرئية للجميع، الإدارة للـ admin فقط) ------
CREATE TABLE IF NOT EXISTS public.change_requests (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    uuid        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  title      text        NOT NULL,
  body       text        NOT NULL DEFAULT '',
  status     text        NOT NULL DEFAULT 'open',
  priority   text        NOT NULL DEFAULT 'medium',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);
ALTER TABLE public.change_requests ENABLE ROW LEVEL SECURITY;
CREATE POLICY "cr_sel" ON public.change_requests FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "cr_ins" ON public.change_requests FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "cr_upd" ON public.change_requests FOR UPDATE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);
CREATE POLICY "cr_del" ON public.change_requests FOR DELETE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);

-- 4. ردود طلبات التعديل --------------------------------------
CREATE TABLE IF NOT EXISTS public.change_request_replies (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id uuid        REFERENCES public.change_requests(id) ON DELETE CASCADE NOT NULL,
  user_id    uuid        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  body       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.change_request_replies ENABLE ROW LEVEL SECURITY;
CREATE POLICY "crr_sel" ON public.change_request_replies FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "crr_ins" ON public.change_request_replies FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "crr_del" ON public.change_request_replies FOR DELETE USING (auth.uid() = user_id);

-- تحقق من الإنشاء
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('chat_messages','quote_discussions','change_requests','change_request_replies')
ORDER BY table_name;
