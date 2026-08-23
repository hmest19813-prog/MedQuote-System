-- إصلاح created_by للعروض التي لا تملك مُصدِراً
-- يربط العروض بصاحب الحساب hmest19813@gmail.com تلقائياً

UPDATE public.quotations
SET created_by = (
  SELECT id FROM auth.users WHERE email = 'hmest19813@gmail.com' LIMIT 1
)
WHERE created_by IS NULL;
