-- ============================================================
-- MedQuote Pro — Tasks (المهام) Migration
-- شغّل في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.tasks (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  created_by   uuid        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  assigned_to  uuid        REFERENCES auth.users(id) ON DELETE SET NULL,
  title        text        NOT NULL,
  description  text        NOT NULL DEFAULT '',
  status       text        NOT NULL DEFAULT 'todo',    -- todo/in_progress/review/done
  priority     text        NOT NULL DEFAULT 'medium',  -- high/medium/low
  due_date     date,
  created_at   timestamptz DEFAULT now(),
  updated_at   timestamptz DEFAULT now()
);
ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

-- الكل يشوف
CREATE POLICY "tasks_sel" ON public.tasks FOR SELECT USING (auth.role() = 'authenticated');

-- admin/manager فقط يضيفون
CREATE POLICY "tasks_ins" ON public.tasks FOR INSERT WITH CHECK (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin','manager'))
);

-- admin/manager أو صاحب المهمة يعدّلون
CREATE POLICY "tasks_upd" ON public.tasks FOR UPDATE USING (
  auth.uid() = assigned_to OR
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin','manager'))
);

-- admin/manager فقط يحذفون
CREATE POLICY "tasks_del" ON public.tasks FOR DELETE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin','manager'))
);

ALTER PUBLICATION supabase_realtime ADD TABLE public.tasks;
ALTER TABLE public.tasks REPLICA IDENTITY FULL;

-- ============================================================
-- تعليقات المهام
-- ============================================================

CREATE TABLE IF NOT EXISTS public.task_comments (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id    uuid        NOT NULL REFERENCES public.tasks(id) ON DELETE CASCADE,
  user_id    uuid        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  body       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.task_comments ENABLE ROW LEVEL SECURITY;
CREATE POLICY "tc_sel" ON public.task_comments FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "tc_ins" ON public.task_comments FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "tc_del" ON public.task_comments FOR DELETE USING (
  auth.uid() = user_id OR
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role IN ('admin','manager'))
);
ALTER PUBLICATION supabase_realtime ADD TABLE public.task_comments;
ALTER TABLE public.task_comments REPLICA IDENTITY FULL;

-- تحقق
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public' AND table_name IN ('tasks','task_comments')
ORDER BY table_name;
