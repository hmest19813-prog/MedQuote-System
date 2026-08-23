-- ============================================================
-- MedQuote Pro — Incremental Updates (يعمل فوق Schema الأصلي)
-- لا يمس الجداول أو الـ triggers أو الـ sequences الموجودة
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- ┌─────────────────────────────────────────────────────────┐
-- │  1. جدول العملاء (جديد)                                │
-- └─────────────────────────────────────────────────────────┘

CREATE TABLE IF NOT EXISTS public.customers (
  id          UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
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

-- ┌─────────────────────────────────────────────────────────┐
-- │  2. ربط العملاء بجدول عروض الأسعار                    │
-- └─────────────────────────────────────────────────────────┘

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS customer_id UUID
  REFERENCES public.customers(id) ON DELETE SET NULL;

-- ┌─────────────────────────────────────────────────────────┐
-- │  3. إصلاح RLS — استعادة الصلاحيات الصحيحة             │
-- │  (fix_urgent.sql القديم استبدلها بـ all_auth الخاطئة)  │
-- └─────────────────────────────────────────────────────────┘

-- ── quotations ──────────────────────────────────────────────
-- حذف كل الـ policies القديمة (من كلا الملفين)
DROP POLICY IF EXISTS "quotations_all_auth" ON public.quotations;
DROP POLICY IF EXISTS "quotations_select"   ON public.quotations;
DROP POLICY IF EXISTS "quotations_insert"   ON public.quotations;
DROP POLICY IF EXISTS "quotations_update"   ON public.quotations;
DROP POLICY IF EXISTS "quotations_delete"   ON public.quotations;

-- Admin/Manager يرى الكل — Employee يرى عروضه فقط
CREATE POLICY "quotations_select" ON public.quotations FOR SELECT
  USING (
    created_by = auth.uid()
    OR created_by IS NULL
    OR get_my_role() IN ('admin', 'manager')
  );

-- أي مستخدم مسجّل يستطيع الإنشاء (created_by يُضبط في الكود)
CREATE POLICY "quotations_insert" ON public.quotations FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

-- صاحب العرض أو Admin يستطيع التعديل
CREATE POLICY "quotations_update" ON public.quotations FOR UPDATE
  USING (
    created_by = auth.uid()
    OR created_by IS NULL
    OR get_my_role() IN ('admin', 'manager')
  );

-- Admin فقط يحذف
CREATE POLICY "quotations_delete" ON public.quotations FOR DELETE
  USING (get_my_role() = 'admin');

-- ── quotation_items ──────────────────────────────────────────
-- الوصول للأصناف عبر صلاحية العرض الأب
DROP POLICY IF EXISTS "qitems_all_auth" ON public.quotation_items;
DROP POLICY IF EXISTS "qitems_access"   ON public.quotation_items;

CREATE POLICY "qitems_access" ON public.quotation_items FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM public.quotations q
      WHERE q.id = quotation_id
        AND (
          q.created_by = auth.uid()
          OR q.created_by IS NULL
          OR get_my_role() IN ('admin', 'manager')
        )
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.quotations q
      WHERE q.id = quotation_id
        AND (
          q.created_by = auth.uid()
          OR q.created_by IS NULL
          OR get_my_role() IN ('admin', 'manager')
        )
    )
  );

-- ── orders ───────────────────────────────────────────────────
-- الطلبات مشتركة — كل الموظفين يشوفونها ويعدّلون حالتها
DROP POLICY IF EXISTS "orders_all_auth" ON public.orders;
DROP POLICY IF EXISTS "orders_select"   ON public.orders;
DROP POLICY IF EXISTS "orders_insert"   ON public.orders;
DROP POLICY IF EXISTS "orders_update"   ON public.orders;
DROP POLICY IF EXISTS "orders_delete"   ON public.orders;

CREATE POLICY "orders_all_auth" ON public.orders
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- ── order_items ───────────────────────────────────────────────
DROP POLICY IF EXISTS "oitems_access" ON public.order_items;

CREATE POLICY "oitems_access" ON public.order_items
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- ── activity_logs ─────────────────────────────────────────────
DROP POLICY IF EXISTS "logs_all_auth" ON public.activity_logs;
DROP POLICY IF EXISTS "logs_select"   ON public.activity_logs;
DROP POLICY IF EXISTS "logs_insert"   ON public.activity_logs;

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

UPDATE public.profiles SET full_name = 'Osama Alawy',    role = 'admin'                   WHERE email = 'o.alawy.oa@gmail.com';
UPDATE public.profiles SET full_name = 'د. محمد جوابرة', role = 'admin', phone = '0798807000' WHERE email = 'hmest19811@gmail.com';
UPDATE public.profiles SET full_name = 'Khaled',          role = 'employee'                WHERE email = 'hmest19813@gmail.com';
UPDATE public.profiles SET full_name = 'Ahlam',           role = 'employee'                WHERE email = 'hmest19810@gmail.com';

-- ┌─────────────────────────────────────────────────────────┐
-- │  5. تحقق من النتيجة                                    │
-- └─────────────────────────────────────────────────────────┘

SELECT full_name, email, role FROM public.profiles ORDER BY role DESC;

SELECT tablename, policyname, cmd FROM pg_policies
WHERE tablename IN ('quotations','quotation_items','orders','order_items','customers','activity_logs')
ORDER BY tablename, cmd;
