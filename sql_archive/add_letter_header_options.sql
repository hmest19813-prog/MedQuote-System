-- ============================================================
-- MedQuote Pro — خيارات إضافية لطباعة الكتب الرسمية (official_letters)
-- شغّله مرة واحدة في Supabase → SQL Editor قبل استخدام الميزتين:
--
-- 1) letterhead_gap: للكتب بدون ترويسة (use_letterhead = false) —
--    يتحكم هل نترك فراغ 46mm أعلى الصفحة (مكان الترويسة على ورق
--    مطبوع مسبقاً) أو ما نترك أي فراغ ويبدأ المحتوى من أعلى الصفحة.
--    القيمة الافتراضية true = نفس السلوك القديم (فراغ محجوز دائماً).
--
-- 2) show_info_table: إظهار/إخفاء جدول بيانات الكتاب (السادة/عناية/
--    التاريخ/الموضوع/كتابنا رقم) في المعاينة والطباعة وتصدير Word.
--    القيمة الافتراضية true = نفس السلوك القديم (الجدول ظاهر دائماً).
-- ============================================================

ALTER TABLE public.official_letters
  ADD COLUMN IF NOT EXISTS letterhead_gap  BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS show_info_table BOOLEAN DEFAULT true;
