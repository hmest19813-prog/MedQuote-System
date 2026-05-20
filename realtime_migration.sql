-- ============================================================
-- MedQuote Pro — Realtime Migration
-- يفعّل التحديث اللحظي على جداول العروض والطلبات
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- تفعيل Realtime على جدول عروض الأسعار
ALTER PUBLICATION supabase_realtime ADD TABLE public.quotations;

-- تفعيل Realtime على جدول الطلبات
ALTER PUBLICATION supabase_realtime ADD TABLE public.orders;

-- تفعيل Realtime على جدول الإشعارات (إذا لم يكن مفعّلاً)
ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications;

-- تحقق من الجداول المفعّل عليها Realtime
SELECT schemaname, tablename
FROM pg_publication_tables
WHERE pubname = 'supabase_realtime'
  AND schemaname = 'public'
ORDER BY tablename;
