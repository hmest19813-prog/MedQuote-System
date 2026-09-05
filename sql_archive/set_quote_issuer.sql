-- تحديد "المُصدِر" (created_by) للمسودة اللي أنشأناها بسكربت draft_quote_lab_supplies.sql
-- بيربطها بحساب "Eng. Osama Alawy" بجدول profiles.

-- 1) تأكد الأول إنه الاستعلام هذا بيرجّع صف واحد ومسودتك هي فعلاً:
SELECT id, number, customer_name, status, created_by, created_at
FROM quotations
WHERE created_by IS NULL
ORDER BY created_at DESC
LIMIT 1;

-- 2) لو النتيجة فوق صحيحة (نفس العرض)، شغّل هذا التحديث:
UPDATE quotations
SET created_by = (
  SELECT id FROM profiles
  WHERE full_name ILIKE '%Osama%Alawy%' OR full_name ILIKE '%Osama%Alawi%'
  LIMIT 1
)
WHERE id = (
  SELECT id FROM quotations
  WHERE created_by IS NULL
  ORDER BY created_at DESC
  LIMIT 1
);

-- 3) تحقق من النتيجة:
SELECT q.id, q.number, q.customer_name, p.full_name AS issuer
FROM quotations q
LEFT JOIN profiles p ON p.id = q.created_by
ORDER BY q.created_at DESC
LIMIT 1;
