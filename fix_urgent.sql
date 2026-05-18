-- ============================================================
-- MedQuote Pro — Full Setup & Fixes
-- شغّل هذا كاملاً في Supabase → SQL Editor
-- ============================================================

-- ┌─────────────────────────────────────────────────────────┐
-- │  1. إصلاحات الجدول الأساسي                             │
-- └─────────────────────────────────────────────────────────┘

-- جعل created_by nullable
ALTER TABLE public.quotations ALTER COLUMN created_by DROP NOT NULL;
ALTER TABLE public.orders     ALTER COLUMN created_by DROP NOT NULL;

-- إضافة حالة invoiced لعروض الأسعار
ALTER TABLE public.quotations DROP CONSTRAINT IF EXISTS quotations_status_check;
ALTER TABLE public.quotations ADD CONSTRAINT quotations_status_check
  CHECK (status IN ('draft','sent','approved','rejected','converted','invoiced'));

-- ┌─────────────────────────────────────────────────────────┐
-- │  2. جدول العملاء                                       │
-- └─────────────────────────────────────────────────────────┘

CREATE TABLE IF NOT EXISTS public.customers (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT        NOT NULL,
  phone       TEXT,
  alt_phone   TEXT,
  address     TEXT,
  website     TEXT,
  notes       TEXT,
  assigned_to UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_by  UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "customers_all_auth" ON public.customers;
CREATE POLICY "customers_all_auth" ON public.customers
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- ربط العملاء بعروض الأسعار
ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS customer_id UUID REFERENCES public.customers(id) ON DELETE SET NULL;

-- ┌─────────────────────────────────────────────────────────┐
-- │  3. صلاحيات RLS حسب الدور (Admin يرى الكل)            │
-- └─────────────────────────────────────────────────────────┘

-- عروض الأسعار: Admin/Manager يرى الكل — Employee يرى عروضه فقط
DROP POLICY IF EXISTS "quotations_all_auth"  ON public.quotations;
DROP POLICY IF EXISTS "quotations_select"    ON public.quotations;
DROP POLICY IF EXISTS "quotations_insert"    ON public.quotations;
DROP POLICY IF EXISTS "quotations_update"    ON public.quotations;
DROP POLICY IF EXISTS "quotations_delete"    ON public.quotations;

CREATE POLICY "quotations_select" ON public.quotations FOR SELECT
  USING (
    auth.uid() IS NOT NULL AND (
      (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin','manager')
      OR created_by = auth.uid()
      OR created_by IS NULL
    )
  );

CREATE POLICY "quotations_insert" ON public.quotations FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "quotations_update" ON public.quotations FOR UPDATE
  USING (
    (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin','manager')
    OR created_by = auth.uid()
  );

CREATE POLICY "quotations_delete" ON public.quotations FOR DELETE
  USING (
    (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin','manager')
  );

-- الطلبات والعناصر والسجلات: أي مستخدم مسجّل
DROP POLICY IF EXISTS "orders_select"  ON public.orders;
DROP POLICY IF EXISTS "orders_insert"  ON public.orders;
DROP POLICY IF EXISTS "orders_update"  ON public.orders;
DROP POLICY IF EXISTS "orders_delete"  ON public.orders;
DROP POLICY IF EXISTS "orders_all_auth" ON public.orders;

CREATE POLICY "orders_all_auth" ON public.orders
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS "qitems_access"   ON public.quotation_items;
DROP POLICY IF EXISTS "qitems_all_auth" ON public.quotation_items;

CREATE POLICY "qitems_all_auth" ON public.quotation_items
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS "logs_select"   ON public.activity_logs;
DROP POLICY IF EXISTS "logs_insert"   ON public.activity_logs;
DROP POLICY IF EXISTS "logs_all_auth" ON public.activity_logs;

CREATE POLICY "logs_all_auth" ON public.activity_logs
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- ┌─────────────────────────────────────────────────────────┐
-- │  4. تأكيد بيانات المستخدمين                            │
-- └─────────────────────────────────────────────────────────┘

INSERT INTO public.profiles (id, email, full_name, username, role, is_active)
SELECT
  u.id, u.email,
  COALESCE(u.raw_user_meta_data->>'full_name', 'مستخدم جديد'),
  split_part(u.email, '@', 1), 'employee', true
FROM auth.users u
WHERE NOT EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = u.id)
ON CONFLICT (id) DO NOTHING;

UPDATE public.profiles SET full_name = 'Osama Alawy',    role = 'admin'    WHERE email = 'o.alawy.oa@gmail.com';
UPDATE public.profiles SET full_name = 'د. محمد جوابرة', role = 'admin',   phone = '0798807000' WHERE email = 'hmest19811@gmail.com';
UPDATE public.profiles SET full_name = 'Khaled',          role = 'employee' WHERE email = 'hmest19813@gmail.com';
UPDATE public.profiles SET full_name = 'Ahlam',           role = 'employee' WHERE email = 'hmest19810@gmail.com';

-- ┌─────────────────────────────────────────────────────────┐
-- │  5. تحقق من النتيجة                                    │
-- └─────────────────────────────────────────────────────────┘

SELECT id, full_name, email, role FROM public.profiles ORDER BY role DESC;

SELECT tablename, policyname, cmd FROM pg_policies
WHERE tablename IN ('quotations','orders','quotation_items','customers','activity_logs')
ORDER BY tablename, cmd;
