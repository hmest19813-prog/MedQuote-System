-- =========================================================
-- Quote/Tender "مرجع" (Reference) flag
-- علم مستقل عن الأرشفة: عرض/عطاء ممكن يكون "مرجع" وهو لسا نشط
-- أو حتى وهو مؤرشف — يظهر بتبويب "🔖 مراجع" المنفصل بكل من
-- عروض الأسعار والعطاءات، بغض النظر عن حالته أو كونه مؤرشف.
-- آمن لإعادة التشغيل بالكامل (idempotent).
-- =========================================================

ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS is_reference BOOLEAN NOT NULL DEFAULT FALSE;
ALTER TABLE public.quotations ADD COLUMN IF NOT EXISTS reference_note TEXT;

-- بأثر رجعي: العرض الوحيد المؤرشف حالياً بسبب "مرجعية لغايات التسعير"
-- (عطاء تجهيزات مختبرات العلوم - 31 مدرسة - وزارة التربية والتعليم)
-- يُعلَّم كمرجع تلقائياً وتُنقل ملاحظة الأرشفة لحقل ملاحظة المرجع.
UPDATE public.quotations
SET is_reference = true,
    reference_note = archive_note
WHERE archive_note ILIKE '%مرجع%'
  AND is_reference IS NOT TRUE;
