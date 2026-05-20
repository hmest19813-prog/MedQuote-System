-- ============================================================
-- MedQuote Pro — Notifications Migration
-- ينشئ جدول الإشعارات الداخلية
-- شغّله في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.notifications (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title       TEXT        NOT NULL,
  body        TEXT,
  type        TEXT        DEFAULT 'info',   -- info | success | warning | danger
  link_type   TEXT,                         -- quote | invoice | order
  link_id     UUID,
  is_read     BOOLEAN     DEFAULT false,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "notif_select" ON public.notifications;
DROP POLICY IF EXISTS "notif_insert" ON public.notifications;
DROP POLICY IF EXISTS "notif_update" ON public.notifications;
DROP POLICY IF EXISTS "notif_delete" ON public.notifications;

-- كل مستخدم يرى إشعاراته فقط
CREATE POLICY "notif_select" ON public.notifications
  FOR SELECT USING (auth.uid() = user_id);

-- أي مستخدم مسجل يستطيع إنشاء إشعار لمستخدم آخر
CREATE POLICY "notif_insert" ON public.notifications
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

-- المستخدم يعدّل إشعاراته فقط (تحديد مقروء)
CREATE POLICY "notif_update" ON public.notifications
  FOR UPDATE USING (auth.uid() = user_id);

-- المستخدم يحذف إشعاراته فقط
CREATE POLICY "notif_delete" ON public.notifications
  FOR DELETE USING (auth.uid() = user_id);

CREATE INDEX IF NOT EXISTS notif_user_read_idx ON public.notifications(user_id, is_read);
CREATE INDEX IF NOT EXISTS notif_created_idx   ON public.notifications(created_at DESC);

-- تفعيل Realtime على الجدول
ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications;

-- تحقق
SELECT column_name, data_type FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'notifications'
ORDER BY ordinal_position;
