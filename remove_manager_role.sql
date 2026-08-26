-- إزالة دور "مدير" (manager) نهائياً من النظام — لا يوجد مستخدمون بهذا الدور حالياً.
-- شغّله في Supabase SQL Editor بعد رفع التعديلات على index.html.

-- تأكيد أول إنه ما في حدا بدور manager (احتياط قبل تضييق الـ constraint)
SELECT id, full_name, role FROM profiles WHERE role = 'manager';
-- ^ يفترض ترجع صف صفر. لو رجّعت صفوف، وقف وغيّر دورهم يدوياً لـ admin أو employee أولاً.

ALTER TABLE public.profiles DROP CONSTRAINT IF EXISTS profiles_role_check;
ALTER TABLE public.profiles ADD CONSTRAINT profiles_role_check
  CHECK (role = ANY (ARRAY['admin'::text, 'employee'::text, 'user'::text]));
