-- ============================================================
-- MedQuote Pro — Notifications Migration (v2 - safe reset)
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- إزالة الجدول القديم إن وُجد (Supabase قد ينشئ جدول notifications افتراضياً)
DROP TABLE IF EXISTS public.notifications CASCADE;

CREATE TABLE public.notifications (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title       TEXT        NOT NULL,
  body        TEXT,
  type        TEXT        DEFAULT 'info',
  link_type   TEXT,
  link_id     UUID,
  is_read     BOOLEAN     DEFAULT false,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "notif_select" ON public.notifications
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "notif_insert" ON public.notifications
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "notif_update" ON public.notifications
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "notif_delete" ON public.notifications
  FOR DELETE USING (auth.uid() = user_id);

CREATE INDEX notif_user_read_idx ON public.notifications(user_id, is_read);
CREATE INDEX notif_created_idx   ON public.notifications(created_at DESC);

-- تفعيل Realtime
ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications;

-- تحقق
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'notifications'
ORDER BY ordinal_position;
