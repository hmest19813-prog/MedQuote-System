-- تصحيح رجعي: عرض "كلية لومينوس الجامعية" باسم إياد حرب (أُنشئ 2026-10-14) أخذ رقماً
-- من تسلسل حياة الرسمي (QT-2026-0241) بسبب غياب خاصية الرمز العشوائي حين أُنشئ.
-- بعد تفعيل الخاصية بالكود، هذا الملف يصحّح هذا العرض بعينه فقط ليأخذ رمزاً عشوائياً
-- مثل بقية عروض الشركات البديلة.
-- شغّله مرة واحدة على Supabase SQL Editor.

WITH new_code AS (
  SELECT
    (SELECT string_agg(c, '') FROM (
       SELECT substr('23456789ABCDEFGHJKLMNPQRSTUVWXYZ', (floor(random()*32)+1)::int, 1) AS c
       FROM generate_series(1,4)
     ) s1) || '-' ||
    (SELECT string_agg(c, '') FROM (
       SELECT substr('23456789ABCDEFGHJKLMNPQRSTUVWXYZ', (floor(random()*32)+1)::int, 1) AS c
       FROM generate_series(1,4)
     ) s2) AS code
)
UPDATE quotations
SET number = (SELECT code FROM new_code)
WHERE id = '447f0311-a395-4790-b3a5-705d2e1f861a'
  AND number = 'QT-2026-0241'  -- حماية إضافية: ما يلمس الصف إلا لو لسا بنفس الرقم القديم
RETURNING id, number, customer_name, issuer_company, status;
