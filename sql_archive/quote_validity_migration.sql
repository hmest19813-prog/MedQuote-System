-- ============================================================
-- MedQuote Pro — إلزام مدة صلاحية العرض (30 يوماً افتراضياً)
--
-- الصلاحية نفسها تُخزَّن في profiles.permissions (JSONB) الموجود
-- أصلاً — المفتاح الجديد: quotes_validity_override
-- (يُضبط من صفحة إدارة المستخدمين، ولا يحتاج أي تعديل على الجداول).
--
-- هذا الملف لتعبئة العروض القديمة فقط. شغّله مرة واحدة.
-- ============================================================

-- العروض القديمة بلا تاريخ صلاحية: تاريخ العرض + 30 يوماً
UPDATE public.quotations
SET valid_until = (date + INTERVAL '30 days')::date
WHERE valid_until IS NULL
  AND date IS NOT NULL;

-- تحقق: يجب أن تكون النتيجة 0
SELECT COUNT(*) AS بلا_صلاحية FROM public.quotations WHERE valid_until IS NULL;

-- (اختياري) منح صلاحية تخطّي المدة لموظف معيّن — أزل التعليق وعدّل اسم المستخدم:
-- UPDATE public.profiles
-- SET permissions = permissions || '{"quotes_validity_override": true}'::jsonb,
--     updated_at  = NOW()
-- WHERE username = 'اسم_المستخدم';

-- عرض من يملك الصلاحية حالياً (المدير والمدير العام يملكونها ضمناً)
SELECT full_name, username, role,
       COALESCE((permissions->>'quotes_validity_override')::boolean, false) AS يتخطى_المدة
FROM public.profiles
ORDER BY role DESC, full_name;
