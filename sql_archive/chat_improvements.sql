-- ============================================================
-- MedQuote Pro — Chat Improvements Migration
-- شغّل في Supabase → SQL Editor بعد تشغيل chat_migration.sql
-- ============================================================

-- 1. السماح لصاحب الرسالة بتعديلها
ALTER TABLE public.chat_messages ADD COLUMN IF NOT EXISTS edited boolean DEFAULT false;
CREATE POLICY "chat_upd" ON public.chat_messages FOR UPDATE USING (auth.uid() = user_id);

-- 2. جدول التفاعلات (reactions)
CREATE TABLE IF NOT EXISTS public.chat_reactions (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  message_id uuid        NOT NULL REFERENCES public.chat_messages(id) ON DELETE CASCADE,
  user_id    uuid        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  emoji      text        NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(message_id, user_id, emoji)
);
ALTER TABLE public.chat_reactions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "react_sel" ON public.chat_reactions FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "react_ins" ON public.chat_reactions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "react_del" ON public.chat_reactions FOR DELETE USING (auth.uid() = user_id);
ALTER PUBLICATION supabase_realtime ADD TABLE public.chat_reactions;
ALTER TABLE public.chat_reactions REPLICA IDENTITY FULL;

-- 3. صلاحية حذف طلبات التعديل للـ admin فقط (إذا لم تُطبَّق من chat_migration.sql)
-- (هذه السياسات موجودة مسبقاً في chat_migration.sql — تجاهل الخطأ إن ظهر)

-- تحقق من النتيجة
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('chat_messages', 'chat_reactions')
ORDER BY table_name;
