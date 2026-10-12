-- ============================================================
-- تحويل حذف العملاء من حذف نهائي إلى حذف ناعم (soft delete)
-- يضيف تبويب "العملاء المحذوفون" بصفحة إدارة العملاء
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

ALTER TABLE public.customers
  ADD COLUMN IF NOT EXISTS deleted_at timestamp with time zone,
  ADD COLUMN IF NOT EXISTS deleted_by uuid REFERENCES public.profiles(id),
  ADD COLUMN IF NOT EXISTS delete_reason text;
