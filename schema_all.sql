-- ================================================================
-- MedQuote Pro — Full Database Schema (All Migrations Combined)
-- مؤسسة الحياة العلمية الطبية الكيماوية
-- Generated: 2026-08-18
--
-- ⚠️  يُشغَّل مرة واحدة فقط على قاعدة بيانات جديدة نظيفة
-- ⚠️  لا تشغّله على قاعدة بيانات فيها بيانات (سيحدث تعارض)
-- ================================================================

======================================================================
-- FILE: schema_complete.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Complete Schema v2.0
-- مؤسسة الحياة العلمية الطبية الكيماوية
-- HAYAT scientific chemical medical corp.
-- Updated: May 2026
-- ✅ آمن للتشغيل على قاعدة بيانات موجودة (لا يحذف البيانات)
-- ✅ آمن للتشغيل على قاعدة بيانات جديدة (تثبيت كامل)
-- ============================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- FUNCTIONS (CREATE OR REPLACE = آمن دائماً)
-- ============================================================

-- دالة مساعدة: جلب دور المستخدم الحالي
CREATE OR REPLACE FUNCTION public.get_my_role()
RETURNS TEXT AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- دالة: توليد رقم عرض السعر
CREATE OR REPLACE FUNCTION public.generate_quotation_number()
RETURNS TEXT AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW())::INTEGER;
  next_val     INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = 0, year = current_year
    WHERE id = 'quotation' AND year < current_year;

  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'quotation'
    RETURNING current_value INTO next_val;

  RETURN 'QT-' || current_year || '-' || LPAD(next_val::TEXT, 3, '0');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- دالة: توليد رقم الطلب
CREATE OR REPLACE FUNCTION public.generate_order_number()
RETURNS TEXT AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW())::INTEGER;
  next_val     INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = 0, year = current_year
    WHERE id = 'order' AND year < current_year;

  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'order'
    RETURNING current_value INTO next_val;

  RETURN 'ORD-' || current_year || '-' || LPAD(next_val::TEXT, 3, '0');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger function: ترقيم عروض الأسعار
CREATE OR REPLACE FUNCTION public.set_quotation_number()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    NEW.number := public.generate_quotation_number();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger function: ترقيم الطلبات
CREATE OR REPLACE FUNCTION public.set_order_number()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    NEW.number := public.generate_order_number();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger function: تحديث updated_at
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger function: إنشاء profile تلقائياً عند التسجيل
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, username)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'مستخدم جديد'),
    COALESCE(NEW.raw_user_meta_data->>'username', split_part(NEW.email, '@', 1))
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================
-- TABLES (CREATE TABLE IF NOT EXISTS = لا يمس البيانات الموجودة)
-- ============================================================

-- ── profiles ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.profiles (
  id          UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  username    TEXT UNIQUE,
  full_name   TEXT NOT NULL DEFAULT 'مستخدم جديد',
  email       TEXT,
  phone       TEXT,
  role        TEXT NOT NULL DEFAULT 'employee'
                CHECK (role IN ('admin', 'manager', 'employee')),
  is_active   BOOLEAN DEFAULT true,
  avatar_url  TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- ── number_sequences ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.number_sequences (
  id            TEXT    PRIMARY KEY,
  prefix        TEXT    NOT NULL,
  current_value INTEGER NOT NULL DEFAULT 0,
  year          INTEGER NOT NULL DEFAULT EXTRACT(YEAR FROM NOW())::INTEGER
);

INSERT INTO public.number_sequences (id, prefix, current_value, year)
VALUES
  ('quotation', 'QT',  0, EXTRACT(YEAR FROM NOW())::INTEGER),
  ('order',     'ORD', 0, EXTRACT(YEAR FROM NOW())::INTEGER)
ON CONFLICT (id) DO NOTHING;

-- ── customers (جديد) ─────────────────────────────────────────
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

-- ── quotations ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.quotations (
  id             UUID    DEFAULT uuid_generate_v4() PRIMARY KEY,
  number         TEXT    UNIQUE NOT NULL,
  customer_name  TEXT    NOT NULL,
  attention      TEXT,
  phone          TEXT,
  address        TEXT,
  date           DATE    NOT NULL DEFAULT CURRENT_DATE,
  reference      TEXT,
  currency       TEXT    NOT NULL DEFAULT 'JOD',
  delivery       TEXT    DEFAULT 'PROMPT',
  subtotal       NUMERIC(12,3) DEFAULT 0,
  discount_pct   NUMERIC(5,2)  DEFAULT 5,
  discount_amt   NUMERIC(12,3) DEFAULT 0,
  grand_total    NUMERIC(12,3) DEFAULT 0,
  tax_pct        NUMERIC(5,2)  DEFAULT 16,
  tax_amt        NUMERIC(12,3) DEFAULT 0,
  nett_price     NUMERIC(12,3) DEFAULT 0,
  notes          TEXT,
  terms          TEXT,
  prepared_by    TEXT,
  status         TEXT    NOT NULL DEFAULT 'draft'
                   CHECK (status IN ('draft','sent','approved','rejected','converted','invoiced')),
  customer_id    UUID    REFERENCES public.customers(id) ON DELETE SET NULL,
  created_by     UUID    REFERENCES public.profiles(id),
  archived       BOOLEAN DEFAULT false,
  archived_at    TIMESTAMPTZ,
  created_at     TIMESTAMPTZ DEFAULT NOW(),
  updated_at     TIMESTAMPTZ DEFAULT NOW()
);

-- إضافة customer_id إن لم يكن موجوداً (للقواعد القديمة)
ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS customer_id UUID REFERENCES public.customers(id) ON DELETE SET NULL;

-- إضافة status invoiced إن لم يكن موجوداً
ALTER TABLE public.quotations DROP CONSTRAINT IF EXISTS quotations_status_check;
ALTER TABLE public.quotations ADD CONSTRAINT quotations_status_check
  CHECK (status IN ('draft','sent','approved','rejected','converted','invoiced'));

-- ── quotation_items ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.quotation_items (
  id             UUID    DEFAULT uuid_generate_v4() PRIMARY KEY,
  quotation_id   UUID    NOT NULL REFERENCES public.quotations(id) ON DELETE CASCADE,
  sort_order     INTEGER DEFAULT 0,
  item_name      TEXT    NOT NULL,
  description    TEXT,
  unit           TEXT    DEFAULT 'EACH',
  quantity       NUMERIC(10,3) NOT NULL DEFAULT 1,
  unit_price     NUMERIC(12,3) NOT NULL DEFAULT 0,
  total_price    NUMERIC(12,3) GENERATED ALWAYS AS (quantity * unit_price) STORED,
  origin         TEXT    DEFAULT 'CHINA',
  delivery       TEXT    DEFAULT 'PROMPT',
  notes          TEXT,
  created_at     TIMESTAMPTZ DEFAULT NOW()
);

-- ── orders ────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.orders (
  id               UUID    DEFAULT uuid_generate_v4() PRIMARY KEY,
  number           TEXT    UNIQUE NOT NULL,
  quotation_id     UUID    REFERENCES public.quotations(id),
  quotation_number TEXT,
  customer_name    TEXT    NOT NULL,
  currency         TEXT    DEFAULT 'JOD',
  total_amount     NUMERIC(12,3) DEFAULT 0,
  status           TEXT    NOT NULL DEFAULT 'pending'
                     CHECK (status IN ('pending','confirmed','processing','delivered','cancelled')),
  notes            TEXT,
  expected_delivery DATE,
  actual_delivery   DATE,
  created_by       UUID    REFERENCES public.profiles(id),
  archived         BOOLEAN DEFAULT false,
  archived_at      TIMESTAMPTZ,
  created_at       TIMESTAMPTZ DEFAULT NOW(),
  updated_at       TIMESTAMPTZ DEFAULT NOW()
);

-- ── order_items ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.order_items (
  id          UUID    DEFAULT uuid_generate_v4() PRIMARY KEY,
  order_id    UUID    NOT NULL REFERENCES public.orders(id) ON DELETE CASCADE,
  sort_order  INTEGER DEFAULT 0,
  item_name   TEXT    NOT NULL,
  description TEXT,
  unit        TEXT,
  quantity    NUMERIC(10,3) NOT NULL DEFAULT 1,
  unit_price  NUMERIC(12,3) NOT NULL DEFAULT 0,
  total_price NUMERIC(12,3),
  origin      TEXT,
  delivery    TEXT,
  notes       TEXT
);

-- ── activity_logs ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.activity_logs (
  id            UUID    DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id       UUID    REFERENCES public.profiles(id),
  user_name     TEXT,
  action        TEXT    NOT NULL,
  target_type   TEXT,
  target_id     UUID,
  target_number TEXT,
  metadata      JSONB,
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- ── notifications ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.notifications (
  id           UUID    DEFAULT uuid_generate_v4() PRIMARY KEY,
  recipient_id UUID    REFERENCES public.profiles(id) ON DELETE CASCADE,
  title        TEXT    NOT NULL,
  body         TEXT,
  type         TEXT    DEFAULT 'info'
                 CHECK (type IN ('info','success','warning','error')),
  is_read      BOOLEAN DEFAULT false,
  link_page    TEXT,
  link_id      UUID,
  created_at   TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- TRIGGERS (DROP IF EXISTS ثم CREATE)
-- ============================================================

DROP TRIGGER IF EXISTS trg_quotation_number     ON public.quotations;
DROP TRIGGER IF EXISTS trg_order_number         ON public.orders;
DROP TRIGGER IF EXISTS trg_quotations_updated_at ON public.quotations;
DROP TRIGGER IF EXISTS trg_orders_updated_at    ON public.orders;
DROP TRIGGER IF EXISTS trg_profiles_updated_at  ON public.profiles;
DROP TRIGGER IF EXISTS trg_customers_updated_at ON public.customers;
DROP TRIGGER IF EXISTS on_auth_user_created     ON auth.users;

CREATE TRIGGER trg_quotation_number
  BEFORE INSERT ON public.quotations
  FOR EACH ROW EXECUTE FUNCTION public.set_quotation_number();

CREATE TRIGGER trg_order_number
  BEFORE INSERT ON public.orders
  FOR EACH ROW EXECUTE FUNCTION public.set_order_number();

CREATE TRIGGER trg_quotations_updated_at
  BEFORE UPDATE ON public.quotations
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trg_orders_updated_at
  BEFORE UPDATE ON public.orders
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trg_profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE TRIGGER trg_customers_updated_at
  BEFORE UPDATE ON public.customers
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

ALTER TABLE public.profiles        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quotations      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quotation_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activity_logs   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customers       ENABLE ROW LEVEL SECURITY;

-- ── profiles ─────────────────────────────────────────────────
DROP POLICY IF EXISTS "profiles_select"     ON public.profiles;
DROP POLICY IF EXISTS "profiles_update_own" ON public.profiles;
DROP POLICY IF EXISTS "profiles_admin_all"  ON public.profiles;

CREATE POLICY "profiles_select" ON public.profiles
  FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY "profiles_update_own" ON public.profiles
  FOR UPDATE USING (id = auth.uid());

CREATE POLICY "profiles_admin_all" ON public.profiles
  FOR ALL USING (get_my_role() = 'admin');

-- ── quotations ────────────────────────────────────────────────
-- Admin/Manager يرى الكل — Employee يرى عروضه فقط
DROP POLICY IF EXISTS "quotations_all_auth" ON public.quotations;
DROP POLICY IF EXISTS "quotations_select"   ON public.quotations;
DROP POLICY IF EXISTS "quotations_insert"   ON public.quotations;
DROP POLICY IF EXISTS "quotations_update"   ON public.quotations;
DROP POLICY IF EXISTS "quotations_delete"   ON public.quotations;

CREATE POLICY "quotations_select" ON public.quotations FOR SELECT
  USING (
    created_by = auth.uid()
    OR created_by IS NULL
    OR get_my_role() IN ('admin', 'manager')
  );

CREATE POLICY "quotations_insert" ON public.quotations FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "quotations_update" ON public.quotations FOR UPDATE
  USING (
    created_by = auth.uid()
    OR created_by IS NULL
    OR get_my_role() IN ('admin', 'manager')
  );

CREATE POLICY "quotations_delete" ON public.quotations FOR DELETE
  USING (get_my_role() = 'admin');

-- ── quotation_items ───────────────────────────────────────────
-- الوصول عبر صلاحية العرض الأب
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

-- ── orders ────────────────────────────────────────────────────
-- الطلبات مشتركة بين الفريق كامل
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

-- ── notifications ─────────────────────────────────────────────
DROP POLICY IF EXISTS "notifs_own"    ON public.notifications;
DROP POLICY IF EXISTS "notifs_insert" ON public.notifications;
DROP POLICY IF EXISTS "notifs_update" ON public.notifications;

CREATE POLICY "notifs_own" ON public.notifications
  FOR SELECT USING (recipient_id = auth.uid());

CREATE POLICY "notifs_insert" ON public.notifications
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "notifs_update" ON public.notifications
  FOR UPDATE USING (recipient_id = auth.uid());

-- ── customers ─────────────────────────────────────────────────
DROP POLICY IF EXISTS "customers_all_auth" ON public.customers;

CREATE POLICY "customers_all_auth" ON public.customers
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX IF NOT EXISTS idx_q_by        ON public.quotations(created_by);
CREATE INDEX IF NOT EXISTS idx_q_status    ON public.quotations(status);
CREATE INDEX IF NOT EXISTS idx_q_date      ON public.quotations(date);
CREATE INDEX IF NOT EXISTS idx_q_customer  ON public.quotations(customer_name);
CREATE INDEX IF NOT EXISTS idx_q_archived  ON public.quotations(archived);
CREATE INDEX IF NOT EXISTS idx_q_cust_id   ON public.quotations(customer_id);
CREATE INDEX IF NOT EXISTS idx_o_by        ON public.orders(created_by);
CREATE INDEX IF NOT EXISTS idx_o_status    ON public.orders(status);
CREATE INDEX IF NOT EXISTS idx_o_qid       ON public.orders(quotation_id);
CREATE INDEX IF NOT EXISTS idx_qi_qid      ON public.quotation_items(quotation_id);
CREATE INDEX IF NOT EXISTS idx_oi_oid      ON public.order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_logs_uid    ON public.activity_logs(user_id);
CREATE INDEX IF NOT EXISTS idx_logs_at     ON public.activity_logs(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_notifs_r    ON public.notifications(recipient_id, is_read);
CREATE INDEX IF NOT EXISTS idx_cust_name   ON public.customers(name);
CREATE INDEX IF NOT EXISTS idx_cust_assign ON public.customers(assigned_to);

-- ============================================================
-- VIEWS (DROP CASCADE ثم إعادة الإنشاء)
-- ============================================================

DROP VIEW IF EXISTS public.quotation_summary CASCADE;
DROP VIEW IF EXISTS public.order_summary CASCADE;

CREATE VIEW public.quotation_summary AS
SELECT
  q.id, q.number, q.customer_name, q.date, q.status,
  q.nett_price, q.currency,
  p.full_name AS created_by_name,
  c.name      AS customer_account,
  COUNT(qi.id) AS item_count,
  q.created_at, q.archived
FROM public.quotations q
LEFT JOIN public.profiles        p  ON p.id  = q.created_by
LEFT JOIN public.customers       c  ON c.id  = q.customer_id
LEFT JOIN public.quotation_items qi ON qi.quotation_id = q.id
GROUP BY q.id, p.full_name, c.name;

CREATE VIEW public.order_summary AS
SELECT
  o.id, o.number, o.quotation_number, o.customer_name,
  o.total_amount, o.currency, o.status,
  p.full_name AS created_by_name,
  o.created_at, o.archived
FROM public.orders o
LEFT JOIN public.profiles p ON p.id = o.created_by;

-- ============================================================
-- USERS SETUP
-- ============================================================

-- إنشاء profiles للمستخدمين الموجودين في auth إن لم تكن موجودة
INSERT INTO public.profiles (id, email, full_name, username, role, is_active)
SELECT
  u.id,
  u.email,
  COALESCE(u.raw_user_meta_data->>'full_name', 'مستخدم جديد'),
  split_part(u.email, '@', 1),
  'employee',
  true
FROM auth.users u
WHERE NOT EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = u.id)
ON CONFLICT (id) DO NOTHING;

-- تحديث الأدوار والأسماء
UPDATE public.profiles SET full_name = 'Osama Alawy',    role = 'admin'    WHERE email = 'o.alawy.oa@gmail.com';
UPDATE public.profiles SET full_name = 'د. محمد جوابرة', role = 'admin', phone = '0798807000' WHERE email = 'hmest19811@gmail.com';
UPDATE public.profiles SET full_name = 'Khaled',          role = 'employee' WHERE email = 'hmest19813@gmail.com';
UPDATE public.profiles SET full_name = 'Ahlam',           role = 'employee' WHERE email = 'hmest19810@gmail.com';

-- ============================================================
-- VERIFY — نتيجة التحقق
-- ============================================================

SELECT full_name, email, role, is_active FROM public.profiles ORDER BY role DESC, full_name;

SELECT tablename, policyname, cmd FROM pg_policies
WHERE tablename IN ('quotations','quotation_items','orders','customers','activity_logs')
ORDER BY tablename, cmd;

-- ✅ Schema v2.0 جاهز

======================================================================
-- FILE: customers_setup.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Customers Module + Quotation Permissions
-- شغّل هذا في Supabase → SQL Editor
-- ============================================================

-- 1. جدول العملاء
CREATE TABLE IF NOT EXISTS public.customers (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT NOT NULL,
  phone       TEXT,
  alt_phone   TEXT,
  address     TEXT,
  website     TEXT,
  notes       TEXT,
  assigned_to UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_by  UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "customers_all_auth" ON public.customers
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- 2. ربط العميل بجدول عروض الأسعار
ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS customer_id UUID REFERENCES public.customers(id) ON DELETE SET NULL;

-- 3. تحديث صلاحيات عروض الأسعار حسب الدور
DROP POLICY IF EXISTS "quotations_all_auth" ON public.quotations;

CREATE POLICY "quotations_select" ON public.quotations
  FOR SELECT USING (
    auth.uid() IS NOT NULL AND (
      (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin', 'manager')
      OR created_by = auth.uid()
      OR created_by IS NULL
    )
  );

CREATE POLICY "quotations_insert" ON public.quotations
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "quotations_update" ON public.quotations
  FOR UPDATE USING (
    (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin', 'manager')
    OR created_by = auth.uid()
  );

CREATE POLICY "quotations_delete" ON public.quotations
  FOR DELETE USING (
    (SELECT role FROM public.profiles WHERE id = auth.uid()) IN ('admin', 'manager')
  );

-- 4. تحقق من النتيجة
SELECT tablename, policyname FROM pg_policies
WHERE tablename IN ('quotations','customers')
ORDER BY tablename, policyname;

======================================================================
-- FILE: customers_erp_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Customers ERP Migration
-- يضيف الحقول الجديدة لجدول العملاء (آمن - لا يمس البيانات الموجودة)
-- شغّله في Supabase → SQL Editor
-- ============================================================

ALTER TABLE public.customers
  ADD COLUMN IF NOT EXISTS customer_code TEXT,
  ADD COLUMN IF NOT EXISTS fax          TEXT,
  ADD COLUMN IF NOT EXISTS mobile       TEXT,
  ADD COLUMN IF NOT EXISTS email        TEXT,
  ADD COLUMN IF NOT EXISTS city         TEXT,
  ADD COLUMN IF NOT EXISTS category     TEXT,
  ADD COLUMN IF NOT EXISTS tags         TEXT,
  -- الشخص المسؤول الأول
  ADD COLUMN IF NOT EXISTS contact1_name   TEXT,
  ADD COLUMN IF NOT EXISTS contact1_title  TEXT,
  ADD COLUMN IF NOT EXISTS contact1_phone  TEXT,
  ADD COLUMN IF NOT EXISTS contact1_mobile TEXT,
  ADD COLUMN IF NOT EXISTS contact1_email  TEXT,
  ADD COLUMN IF NOT EXISTS contact1_ext    TEXT,
  ADD COLUMN IF NOT EXISTS contact1_notes  TEXT,
  -- الشخص المسؤول الثاني
  ADD COLUMN IF NOT EXISTS contact2_name   TEXT,
  ADD COLUMN IF NOT EXISTS contact2_title  TEXT,
  ADD COLUMN IF NOT EXISTS contact2_phone  TEXT,
  ADD COLUMN IF NOT EXISTS contact2_mobile TEXT,
  ADD COLUMN IF NOT EXISTS contact2_email  TEXT,
  ADD COLUMN IF NOT EXISTS contact2_ext    TEXT,
  ADD COLUMN IF NOT EXISTS contact2_notes  TEXT;

-- تحقق من النتيجة
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'customers'
ORDER BY ordinal_position;

======================================================================
-- FILE: discount_type_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Discount Type Migration
-- يضيف دعم الخصم بالمبلغ الثابت بالإضافة للنسبة المئوية
-- شغّله في Supabase → SQL Editor (آمن - لا يمس البيانات الموجودة)
-- ============================================================

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS discount_type  TEXT    DEFAULT 'pct',
  ADD COLUMN IF NOT EXISTS discount_fixed NUMERIC DEFAULT 0;

-- تحقق من النتيجة
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'quotations'
  AND column_name IN ('discount_pct','discount_amt','discount_type','discount_fixed')
ORDER BY column_name;

======================================================================
-- FILE: catalog_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Catalog Migration
-- ينشئ جدول كتالوج الأصناف (آمن - يعمل عدة مرات بدون أخطاء)
-- شغّله في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.catalog_items (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT        NOT NULL,
  description TEXT,
  unit        TEXT        DEFAULT 'EACH',
  unit_price  NUMERIC     DEFAULT 0,
  origin      TEXT        DEFAULT 'CHINA',
  delivery    TEXT        DEFAULT 'PROMPT',
  category    TEXT,
  notes       TEXT,
  is_active   BOOLEAN     DEFAULT true,
  created_by  UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.catalog_items ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "catalog_select" ON public.catalog_items;
DROP POLICY IF EXISTS "catalog_insert" ON public.catalog_items;
DROP POLICY IF EXISTS "catalog_update" ON public.catalog_items;
DROP POLICY IF EXISTS "catalog_delete" ON public.catalog_items;

-- كل المستخدمين المسجلين يرون الكتالوج
CREATE POLICY "catalog_select" ON public.catalog_items
  FOR SELECT USING (auth.uid() IS NOT NULL);

-- أي مستخدم مسجل يضيف صنف
CREATE POLICY "catalog_insert" ON public.catalog_items
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

-- صاحب الصنف أو Admin يعدّله
CREATE POLICY "catalog_update" ON public.catalog_items
  FOR UPDATE USING (
    created_by = auth.uid()
    OR get_my_role() IN ('admin', 'manager')
  );

-- Admin فقط يحذف
CREATE POLICY "catalog_delete" ON public.catalog_items
  FOR DELETE USING (get_my_role() IN ('admin', 'manager'));

-- فهرس للبحث السريع
CREATE INDEX IF NOT EXISTS catalog_items_name_idx ON public.catalog_items USING gin(to_tsvector('simple', name));

-- تحقق من النتيجة
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'catalog_items'
ORDER BY ordinal_position;

======================================================================
-- FILE: catalog_categories_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Catalog Categories Table
-- شغّله في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.catalog_categories (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT        NOT NULL UNIQUE,
  sort_order INTEGER     DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  created_by UUID        REFERENCES public.profiles(id) ON DELETE SET NULL
);

ALTER TABLE public.catalog_categories ENABLE ROW LEVEL SECURITY;

-- الكل يقرأ
CREATE POLICY "cat_select" ON public.catalog_categories
  FOR SELECT TO authenticated USING (true);

-- الأدمن فقط يضيف / يعدّل / يحذف
CREATE POLICY "cat_admin" ON public.catalog_categories
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
  );

-- إدخال الفئات الموجودة
INSERT INTO public.catalog_categories (name, sort_order) VALUES
  ('العناية بالسكري',1),('أجهزة ضغط الدم',2),('أجهزة طبية منزلية',3),
  ('المضخات الطبية',4),('أحذية طبية',5),('تجهيز عيادات',6),
  ('المستهلكات',7),('إسعافات أولية',8),('ملابس طبية ومخبرية',9),
  ('المشدات الطبية والتجميلية',10),('المجاهر',11),('أدوات زجاجية',12),
  ('أدوات بلاستيكية',13),('فحص المياه',14),('الكروماتوغرافيا',15),
  ('تجهيز مختبرات',16),('مستهلكات مخبرية',17),('الهيكل العظمي وأجزاءه',18),
  ('المجسمات التشريحية',19),('الدمى والتدريس الطبي',20),
  ('المجسمات التعليمية',21),('النباتات',22),('اللوحات التعليمية',23),
  ('غيرهم',24)
ON CONFLICT (name) DO NOTHING;

-- تحقق
SELECT name, sort_order FROM public.catalog_categories ORDER BY sort_order;

======================================================================
-- FILE: valid_until_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Valid Until Migration
-- يضيف حقل تاريخ صلاحية العرض (اختياري)
-- شغّله في Supabase → SQL Editor
-- ============================================================

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS valid_until DATE;

-- تحقق من النتيجة
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'quotations'
  AND column_name = 'valid_until';

======================================================================
-- FILE: payments_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Payments Migration
-- ينشئ جدول الدفعات لتتبع مدفوعات الفواتير
-- شغّله في Supabase → SQL Editor
-- ============================================================

CREATE TABLE IF NOT EXISTS public.payments (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  quotation_id   UUID        NOT NULL REFERENCES public.quotations(id) ON DELETE CASCADE,
  amount         NUMERIC     NOT NULL CHECK (amount > 0),
  payment_date   DATE        NOT NULL DEFAULT CURRENT_DATE,
  method         TEXT        DEFAULT 'تحويل بنكي',
  reference_no   TEXT,
  notes          TEXT,
  created_by     UUID        REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at     TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.payments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "payments_select" ON public.payments;
DROP POLICY IF EXISTS "payments_insert" ON public.payments;
DROP POLICY IF EXISTS "payments_delete" ON public.payments;

CREATE POLICY "payments_select" ON public.payments
  FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY "payments_insert" ON public.payments
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "payments_delete" ON public.payments
  FOR DELETE USING (get_my_role() IN ('admin', 'manager'));

CREATE INDEX IF NOT EXISTS payments_quotation_id_idx ON public.payments(quotation_id);

-- تحقق
SELECT column_name, data_type FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'payments'
ORDER BY ordinal_position;

======================================================================
-- FILE: notifications_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Notifications Migration (v2 - safe reset)
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- إزالة الجدول القديم إن وُجد (Supabase قد ينشئ جدول notifications افتراضياً)
DROP TABLE IF EXISTS public.notifications CASCADE;

CREATE TABLE public.notifications (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID        NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  title       TEXT        NOT NULL,
  body        TEXT,
  type        TEXT        DEFAULT 'info',
  link_type   TEXT,
  link_id     UUID,
  is_read     BOOLEAN     DEFAULT false,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "notif_select" ON public.notifications
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "notif_insert" ON public.notifications
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "notif_update" ON public.notifications
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "notif_delete" ON public.notifications
  FOR DELETE USING (auth.uid() = user_id);

CREATE INDEX notif_user_read_idx ON public.notifications(user_id, is_read);
CREATE INDEX notif_created_idx   ON public.notifications(created_at DESC);

-- تفعيل Realtime
ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications;

-- تحقق
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'notifications'
ORDER BY ordinal_position;

======================================================================
-- FILE: soft_delete_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Soft Delete + Reset Sequence Migration
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- 1) إضافة أعمدة الحذف الناعم على جدول عروض الأسعار
ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS deleted_at     TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS deleted_by     UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS delete_reason  TEXT;

-- 2) تصفير الرقم التسلسلي لعروض الأسعار
UPDATE public.number_sequences
SET current_value = 0
WHERE id = 'quotation';

-- تحقق
SELECT id, prefix, current_value, year FROM public.number_sequences;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'quotations'
  AND column_name IN ('deleted_at','deleted_by','delete_reason')
ORDER BY column_name;

======================================================================
-- FILE: customer_sequence_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Customer Auto-Number Sequence
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- 1) أضف صف تسلسل العملاء في جدول number_sequences (إن لم يكن موجوداً)
INSERT INTO public.number_sequences (id, prefix, current_value, year)
VALUES ('customer', 'C', 0, EXTRACT(YEAR FROM NOW())::INTEGER)
ON CONFLICT (id) DO NOTHING;

-- 2) دالة توليد رقم العميل التلقائي (C-0001, C-0002, ...)
CREATE OR REPLACE FUNCTION public.generate_customer_number()
RETURNS TEXT AS $$
DECLARE
  next_val INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'customer'
    RETURNING current_value INTO next_val;

  RETURN 'C-' || LPAD(next_val::TEXT, 4, '0');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3) منح صلاحية تشغيل الدالة للمستخدمين المصادق عليهم
GRANT EXECUTE ON FUNCTION public.generate_customer_number() TO authenticated;

-- 4) تحقق
SELECT * FROM public.number_sequences WHERE id = 'customer';
-- يجب أن يظهر صف بـ current_value = 0

======================================================================
-- FILE: customer_lists_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Customer Categories & Districts Tables
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- 1) جدول تصنيفات العملاء
CREATE TABLE IF NOT EXISTS public.customer_categories (
  id         UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT        NOT NULL UNIQUE,
  sort_order INTEGER     DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE public.customer_categories ENABLE ROW LEVEL SECURITY;
CREATE POLICY "cust_cat_select" ON public.customer_categories FOR SELECT TO authenticated USING (true);
CREATE POLICY "cust_cat_admin"  ON public.customer_categories FOR ALL USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);

INSERT INTO public.customer_categories (name, sort_order) VALUES
  ('مستشفى خاص',1),('مستشفى حكومي',2),('مستوصف',3),('مركز طبي',4),
  ('عيادة خاصة',5),('صيدلية',6),('مختبر طبي',7),('مركز أشعة',8),
  ('شركة توزيع طبي',9),('جهة حكومية',10),('جامعة / كلية',11),
  ('دار رعاية',12),('جمعية خيرية',13),('أخرى',14)
ON CONFLICT (name) DO NOTHING;

-- 2) جدول مناطق المحافظات
CREATE TABLE IF NOT EXISTS public.customer_districts (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  governorate TEXT        NOT NULL,
  name        TEXT        NOT NULL,
  sort_order  INTEGER     DEFAULT 0,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(governorate, name)
);
ALTER TABLE public.customer_districts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "cust_dist_select" ON public.customer_districts FOR SELECT TO authenticated USING (true);
CREATE POLICY "cust_dist_admin"  ON public.customer_districts FOR ALL USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);

INSERT INTO public.customer_districts (governorate, name, sort_order) VALUES
  ('عمان','وسط البلد',1),('عمان','الشميساني',2),('عمان','الجبيهة',3),('عمان','وادي السير',4),
  ('عمان','تلاع العلي',5),('عمان','ضاحية الحسين',6),('عمان','الرابية',7),('عمان','دابوق',8),
  ('عمان','صويلح',9),('عمان','شفا بدران',10),('عمان','طارق',11),('عمان','النزهة',12),
  ('عمان','الروضة',13),('عمان','الأشرفية',14),('عمان','ماركا',15),('عمان','أبو نصير',16),
  ('عمان','خلدا',17),('عمان','الصويفية',18),('عمان','مرج الحمام',19),('عمان','حي الأمير حمزة',20),
  ('عمان','الزهور',21),('عمان','السواقة',22),('عمان','أم أذينة',23),('عمان','سحاب',24),
  ('عمان','القويسمة',25),('عمان','ناعور',26),('عمان','الجويدة',27),
  ('إربد','مركز إربد',1),('إربد','الحصن',2),('إربد','بيت راس',3),('إربد','المزار الشمالي',4),
  ('إربد','الرمثا',5),('إربد','بني كنانة',6),('إربد','الكورة',7),('إربد','الأغوار الشمالية',8),
  ('إربد','باعون',9),('إربد','المغير',10),('إربد','طبقة فحل',11),('إربد','النعيمة',12),
  ('إربد','حي الجامعة',13),('إربد','حي البتراوي',14),('إربد','ريمون',15),
  ('الزرقاء','مركز الزرقاء',1),('الزرقاء','الرصيفة',2),('الزرقاء','الهاشمية',3),
  ('الزرقاء','الأزرق',4),('الزرقاء','ضليل',5),('الزرقاء','الزرقاء الجديدة',6),
  ('الزرقاء','حي الأمير حسن',7),('الزرقاء','حي الإسكان',8),('الزرقاء','حي النزهة',9),
  ('الزرقاء','خربة السمرا',10),('الزرقاء','بسيرا',11),('الزرقاء','حي اليرموك',12),
  ('البلقاء','السلط',1),('البلقاء','ماحص',2),('البلقاء','عين الباشا',3),('البلقاء','دير علا',4),
  ('البلقاء','الشونة الجنوبية',5),('البلقاء','الكرامة',6),('البلقاء','عيرا',7),
  ('البلقاء','وادي شعيب',8),('البلقاء','نادر',9),('البلقاء','عمواس',10),
  ('البلقاء','عراق الأمير',11),('البلقاء','الفحيص',12),
  ('المفرق','مركز المفرق',1),('المفرق','الرويشد',2),('المفرق','الزعتري',3),
  ('المفرق','بديعة',4),('المفرق','الخالدية',5),('المفرق','الحمراء',6),
  ('المفرق','أم الجمال',7),('المفرق','الصفاوي',8),('المفرق','رحاب',9),
  ('الكرك','مركز الكرك',1),('الكرك','الغور الكركي',2),('الكرك','المزار الجنوبي',3),
  ('الكرك','القصر',4),('الكرك','الربة',5),('الكرك','عي',6),('الكرك','فقوع',7),
  ('الكرك','المؤتة',8),('الكرك','القطرانة',9),('الكرك','العراق',10),
  ('مادبا','مركز مادبا',1),('مادبا','ذيبان',2),('مادبا','ليجون',3),
  ('مادبا','جرف الدراويش',4),('مادبا','النصيب',5),('مادبا','المليح',6),
  ('مادبا','طبان',7),('مادبا','أم الرصاص',8),
  ('جرش','مركز جرش',1),('جرش','برما',2),('جرش','سوف',3),
  ('جرش','صخرة',4),('جرش','كفر راجب',5),('جرش','المصطبة',6),
  ('عجلون','مركز عجلون',1),('عجلون','كفرنجة',2),('عجلون','عنجرة',3),
  ('عجلون','عرجان',4),('عجلون','راجب',5),('عجلون','حلاوة',6),('عجلون','سوفا',7),
  ('العقبة','مركز العقبة',1),('العقبة','القويرة',2),('العقبة','رم',3),
  ('العقبة','الشيدية',4),('العقبة','حي الورود',5),('العقبة','حي الشلالة',6),
  ('العقبة','حي البلد',7),('العقبة','الخريبة',8),('العقبة','المدينة الصناعية',9),
  ('الطفيلة','مركز الطفيلة',1),('الطفيلة','بصيرا',2),('الطفيلة','الحسا',3),
  ('الطفيلة','قادس',4),('الطفيلة','العين البيضا',5),('الطفيلة','صير',6),
  ('معان','مركز معان',1),('معان','البتراء',2),('معان','وادي موسى',3),
  ('معان','الشوبك',4),('معان','غران',5),('معان','الجفر',6),('معان','الحميمة',7)
ON CONFLICT (governorate, name) DO NOTHING;

-- تحقق
SELECT governorate, COUNT(*) FROM public.customer_districts GROUP BY governorate ORDER BY governorate;
SELECT COUNT(*) FROM public.customer_categories;

======================================================================
-- FILE: contact_fields_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Contact Fields Migration
-- يضيف حقول الكنية والموبايل الثانوي للشخصين المسؤولين
-- شغّله في Supabase → SQL Editor
-- ============================================================

ALTER TABLE public.customers
  ADD COLUMN IF NOT EXISTS contact1_last_name TEXT,
  ADD COLUMN IF NOT EXISTS contact1_mobile2   TEXT,
  ADD COLUMN IF NOT EXISTS contact2_last_name TEXT,
  ADD COLUMN IF NOT EXISTS contact2_mobile2   TEXT;

-- تحقق
SELECT column_name FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'customers'
  AND column_name LIKE 'contact%'
ORDER BY column_name;

======================================================================
-- FILE: permissions_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — الصلاحيات + تسجيل الدخول باليوزر
-- ⚠️  شغّل الـ STEP 1 أولاً، ثم الـ STEP 2 في run منفصل
-- ============================================================

-- ══════════════════════════════════════════════
-- STEP 1 — شغّله وحده أولاً
-- ══════════════════════════════════════════════

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS permissions JSONB NOT NULL DEFAULT '{}'::jsonb;


-- ══════════════════════════════════════════════
-- STEP 2 — بعد ما ينجح STEP 1، شغّل هذا
-- ══════════════════════════════════════════════

-- دالة جلب الإيميل من اسم المستخدم (لتسجيل الدخول)
CREATE OR REPLACE FUNCTION public.get_email_by_username(p_username TEXT)
RETURNS TEXT
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT email
  FROM public.profiles
  WHERE LOWER(TRIM(username)) = LOWER(TRIM(p_username))
  LIMIT 1;
$$;

GRANT EXECUTE ON FUNCTION public.get_email_by_username(TEXT) TO anon, authenticated;

-- دالة إكمال بيانات الـ profile بعد إنشاء المستخدم من JS
-- (الـ JS يعمل signUp أولاً ثم يستدعي هذه الدالة)
CREATE OR REPLACE FUNCTION public.setup_new_user_profile(
  p_user_id     UUID,
  p_email       TEXT,
  p_full_name   TEXT,
  p_username    TEXT,
  p_role        TEXT    DEFAULT 'employee',
  p_is_active   BOOLEAN DEFAULT true,
  p_permissions JSONB   DEFAULT '{}'::jsonb
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_username TEXT;
BEGIN
  v_username := NULLIF(TRIM(COALESCE(p_username, '')), '');
  IF v_username IS NULL THEN
    v_username := split_part(LOWER(TRIM(p_email)), '@', 1);
  END IF;

  INSERT INTO public.profiles (id, email, full_name, username, role, is_active, permissions)
  VALUES (p_user_id, LOWER(TRIM(p_email)), TRIM(p_full_name), v_username, p_role, p_is_active, COALESCE(p_permissions, '{}'::jsonb))
  ON CONFLICT (id) DO UPDATE SET
    full_name   = EXCLUDED.full_name,
    username    = EXCLUDED.username,
    role        = EXCLUDED.role,
    is_active   = EXCLUDED.is_active,
    permissions = EXCLUDED.permissions,
    updated_at  = NOW();
END;
$$;

GRANT EXECUTE ON FUNCTION public.setup_new_user_profile(UUID, TEXT, TEXT, TEXT, TEXT, BOOLEAN, JSONB) TO authenticated;

-- تعيين username للمستخدمين الحاليين الذين ليس لديهم username
UPDATE public.profiles
SET username = split_part(LOWER(email), '@', 1)
WHERE (username IS NULL OR username = '')
  AND email IS NOT NULL;

-- خصّص أسماء المستخدمين (أزل -- من السطر المطلوب):
-- UPDATE public.profiles SET username = 'khaled'  WHERE email = 'hmest19813@gmail.com';
-- UPDATE public.profiles SET username = 'ahlam'   WHERE email = 'hmest19810@gmail.com';
-- UPDATE public.profiles SET username = 'osama'   WHERE email = 'o.alawy.oa@gmail.com';
-- UPDATE public.profiles SET username = 'drm'     WHERE email = 'hmest19811@gmail.com';

-- تحقق
SELECT full_name, username, email, role, is_active FROM public.profiles ORDER BY role DESC, full_name;

======================================================================
-- FILE: item_tax_migration.sql

======================================================================

-- ─────────────────────────────────────────────────────────────
-- Per-item tax percentage for quotation_items
-- شغّل هذا مرة واحدة في Supabase SQL Editor
-- ─────────────────────────────────────────────────────────────

ALTER TABLE public.quotation_items
  ADD COLUMN IF NOT EXISTS tax_pct NUMERIC(5,2) DEFAULT 16;

-- البنود القديمة تأخذ 16% (النسبة الافتراضية التاريخية)
UPDATE public.quotation_items
SET tax_pct = 16
WHERE tax_pct IS NULL;

======================================================================
-- FILE: item_options_migration.sql

======================================================================

-- ─────────────────────────────────────────────────────────────
-- Multi-source options per line item
-- الصفوف التي تحمل نفس option_group هي مصادر بديلة لنفس المنتج
-- يُحتسب في المجموع الخيار الأعلى قيمة فقط ضمن كل مجموعة
-- شغّل هذا مرة واحدة في Supabase SQL Editor
-- ─────────────────────────────────────────────────────────────

ALTER TABLE public.quotation_items
  ADD COLUMN IF NOT EXISTS option_group TEXT;

======================================================================
-- FILE: layout_mode_migration.sql

======================================================================

-- ─────────────────────────────────────────────────────────────
-- نوع عرض الجدول لكل عرض سعر: مفصّل (بأعمدة الضريبة) أو مبسّط
-- true = مفصّل (سعر بدون ضريبة + الضريبة% + سعر شامل + إجمالي شامل)
-- false = مبسّط (سعر الوحدة + الإجمالي فقط — الشكل القديم)
-- شغّل هذا مرة واحدة في Supabase SQL Editor
-- ─────────────────────────────────────────────────────────────

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS detailed_layout BOOLEAN DEFAULT true;

======================================================================
-- FILE: quote_validity_migration.sql

======================================================================

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

======================================================================
-- FILE: order_items_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — الطلبات تحفظ أصنافها الخاصة (order_items)
--
-- قبل هذا التعديل كان الطلب يُنشأ بدون أصناف، والطباعة تسحب أصناف
-- العرض المصدر — فأي تعديل على الطلب كان يضيع. الآن كل طلب يملك
-- بنوده، ولذلك نحتاج عمود الضريبة لكل بند تماماً كـ quotation_items.
--
-- شغّل الملف كاملاً مرة واحدة في Supabase SQL Editor.
-- ============================================================

-- ── عمود نسبة الضريبة لكل بند ────────────────────────────────
ALTER TABLE public.order_items
  ADD COLUMN IF NOT EXISTS tax_pct NUMERIC(5,2);

-- ── تعبئة أصناف الطلبات القديمة من العرض المصدر ──────────────
--    (يتجاهل أي طلب يملك أصنافاً بالفعل، فآمن التكرار)
INSERT INTO public.order_items
  (order_id, sort_order, item_name, description, unit, quantity,
   unit_price, total_price, tax_pct, origin, delivery, notes)
SELECT o.id, qi.sort_order, qi.item_name, qi.description, qi.unit, qi.quantity,
       qi.unit_price, qi.quantity * qi.unit_price, qi.tax_pct, qi.origin, qi.delivery, qi.notes
FROM public.orders o
JOIN public.quotation_items qi ON qi.quotation_id = o.quotation_id
WHERE o.quotation_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM public.order_items oi WHERE oi.order_id = o.id);

-- ── تحقق: يجب ألا تبقى طلبات مرتبطة بعرض وبلا أصناف ──────────
SELECT o.number, o.customer_name, COUNT(oi.id) AS عدد_الأصناف
FROM public.orders o
LEFT JOIN public.order_items oi ON oi.order_id = o.id
GROUP BY o.id, o.number, o.customer_name
ORDER BY o.number;

======================================================================
-- FILE: archive_note_migration.sql

======================================================================

-- إضافة عمود سبب الأرشفة لجداول العروض والطلبات
-- شغّل هذا في Supabase SQL Editor

alter table quotations add column if not exists archive_note text;
alter table orders     add column if not exists archive_note text;

======================================================================
-- FILE: archive_reasons_migration.sql

======================================================================

-- جدول أسباب الأرشفة المشترك
CREATE TABLE IF NOT EXISTS archive_reasons (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  reason text NOT NULL UNIQUE,
  last_used_at timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now()
);

ALTER TABLE archive_reasons ENABLE ROW LEVEL SECURITY;

CREATE POLICY "authenticated can select archive_reasons" ON archive_reasons
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "authenticated can insert archive_reasons" ON archive_reasons
  FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "authenticated can update archive_reasons" ON archive_reasons
  FOR UPDATE TO authenticated USING (true);

-- بالأثر الرجعي: استيراد الأسباب من العروض المؤرشفة
INSERT INTO archive_reasons (reason)
SELECT DISTINCT TRIM(archive_note) FROM quotations
WHERE archived = true AND archive_note IS NOT NULL AND TRIM(archive_note) != ''
ON CONFLICT (reason) DO NOTHING;

-- بالأثر الرجعي: استيراد الأسباب من الطلبات المؤرشفة
INSERT INTO archive_reasons (reason)
SELECT DISTINCT TRIM(archive_note) FROM orders
WHERE archived = true AND archive_note IS NOT NULL AND TRIM(archive_note) != ''
ON CONFLICT (reason) DO NOTHING;

======================================================================
-- FILE: draft_quotes_migration.sql

======================================================================

-- =========================================================
-- Draft Quotes Migration
-- تسلسل مستقل للمسودات (2026D-NNN) + trigger اعتماد
-- =========================================================

-- 1. إضافة تسلسل المسودات
INSERT INTO public.number_sequences (id, prefix, current_value, year)
VALUES ('draft', '2026D', 0, 2026)
ON CONFLICT (id) DO NOTHING;

-- 2. دالة توليد رقم المسودة (بريفيكس ثابت 2026D بدون reset سنوي)
CREATE OR REPLACE FUNCTION public.generate_draft_number()
RETURNS TEXT AS $$
DECLARE
  next_val INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'draft'
    RETURNING current_value INTO next_val;

  RETURN '2026D-' || LPAD(next_val::TEXT, 3, '0');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. تعديل trigger INSERT: مسودة → رقم مسودة | غير ذلك → رقم رسمي
CREATE OR REPLACE FUNCTION public.set_quotation_number()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    IF NEW.status = 'draft' THEN
      NEW.number := public.generate_draft_number();
    ELSE
      NEW.number := public.generate_quotation_number();
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 4. trigger UPDATE: عند اعتماد المسودة يُخصَّص رقم رسمي في تلك اللحظة
CREATE OR REPLACE FUNCTION public.confirm_draft_quotation()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.status = 'draft' AND NEW.status != 'draft' THEN
    NEW.number := public.generate_quotation_number();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER quotation_confirm_trigger
  BEFORE UPDATE ON public.quotations
  FOR EACH ROW
  EXECUTE FUNCTION public.confirm_draft_quotation();

======================================================================
-- FILE: quote_followups_migration.sql

======================================================================

-- جدول ملاحظات متابعة العروض
CREATE TABLE IF NOT EXISTS public.quote_followups (
  id            UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
  quotation_id  UUID        NOT NULL REFERENCES public.quotations(id) ON DELETE CASCADE,
  note          TEXT        NOT NULL,
  created_by    UUID        REFERENCES public.profiles(id),
  created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- RLS
ALTER TABLE public.quote_followups ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users can manage followups" ON public.quote_followups
  FOR ALL USING (true) WITH CHECK (true);

======================================================================
-- FILE: realtime_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Realtime Migration
-- يفعّل التحديث اللحظي على جداول العروض والطلبات
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- تفعيل Realtime على جدول عروض الأسعار
ALTER PUBLICATION supabase_realtime ADD TABLE public.quotations;

-- إرسال كل الحقول عند UPDATE (ليس فقط المتغيّرة)
ALTER TABLE public.quotations REPLICA IDENTITY FULL;
ALTER TABLE public.orders REPLICA IDENTITY FULL;

-- تفعيل Realtime على جدول الطلبات
ALTER PUBLICATION supabase_realtime ADD TABLE public.orders;

-- تفعيل Realtime على جدول الإشعارات (إذا لم يكن مفعّلاً)
ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications;

-- تحقق من الجداول المفعّل عليها Realtime
SELECT schemaname, tablename
FROM pg_publication_tables
WHERE pubname = 'supabase_realtime'
  AND schemaname = 'public'
ORDER BY tablename;

======================================================================
-- FILE: hr_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — HR Module Migration
-- قسم الموارد البشرية: موظفين، حضور وغياب، كتب، رواتب
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- 1. جدول الموظفين
CREATE TABLE IF NOT EXISTS public.hr_employees (
  id           UUID         DEFAULT uuid_generate_v4() PRIMARY KEY,
  full_name    TEXT         NOT NULL,
  job_title    TEXT,
  department   TEXT,
  hire_date    DATE,
  base_salary  NUMERIC(12,2) DEFAULT 0,
  phone        TEXT,
  national_id  TEXT,
  status       TEXT         DEFAULT 'active'
               CHECK (status IN ('active', 'inactive', 'terminated')),
  notes        TEXT,
  created_at   TIMESTAMPTZ  DEFAULT NOW(),
  updated_at   TIMESTAMPTZ  DEFAULT NOW()
);

-- 2. جدول الحضور والغياب
CREATE TABLE IF NOT EXISTS public.hr_attendance (
  id           UUID         DEFAULT uuid_generate_v4() PRIMARY KEY,
  employee_id  UUID         NOT NULL REFERENCES public.hr_employees(id) ON DELETE CASCADE,
  date         DATE         NOT NULL,
  status       TEXT         NOT NULL DEFAULT 'present'
               CHECK (status IN ('present', 'absent', 'late', 'leave', 'holiday')),
  notes        TEXT,
  created_at   TIMESTAMPTZ  DEFAULT NOW(),
  UNIQUE(employee_id, date)
);

-- 3. جدول كتب الموارد البشرية
CREATE TABLE IF NOT EXISTS public.hr_letters (
  id           UUID         DEFAULT uuid_generate_v4() PRIMARY KEY,
  employee_id  UUID         REFERENCES public.hr_employees(id) ON DELETE SET NULL,
  letter_type  TEXT         NOT NULL,
  title        TEXT         NOT NULL,
  content      TEXT,
  issued_date  DATE         DEFAULT CURRENT_DATE,
  created_by   UUID         REFERENCES public.profiles(id),
  created_at   TIMESTAMPTZ  DEFAULT NOW()
);

-- 4. جدول الرواتب الشهرية
CREATE TABLE IF NOT EXISTS public.hr_salaries (
  id           UUID         DEFAULT uuid_generate_v4() PRIMARY KEY,
  employee_id  UUID         NOT NULL REFERENCES public.hr_employees(id) ON DELETE CASCADE,
  month        INT          NOT NULL CHECK (month BETWEEN 1 AND 12),
  year         INT          NOT NULL,
  base_salary  NUMERIC(12,2) DEFAULT 0,
  bonus        NUMERIC(12,2) DEFAULT 0,
  deductions   NUMERIC(12,2) DEFAULT 0,
  status       TEXT         DEFAULT 'pending' CHECK (status IN ('pending', 'paid')),
  paid_at      TIMESTAMPTZ,
  notes        TEXT,
  created_at   TIMESTAMPTZ  DEFAULT NOW(),
  UNIQUE(employee_id, month, year)
);

-- RLS Policies
ALTER TABLE public.hr_employees ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "hr_employees_policy" ON public.hr_employees;
CREATE POLICY "hr_employees_policy" ON public.hr_employees FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE public.hr_attendance ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "hr_attendance_policy" ON public.hr_attendance;
CREATE POLICY "hr_attendance_policy" ON public.hr_attendance FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE public.hr_letters ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "hr_letters_policy" ON public.hr_letters;
CREATE POLICY "hr_letters_policy" ON public.hr_letters FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE public.hr_salaries ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "hr_salaries_policy" ON public.hr_salaries;
CREATE POLICY "hr_salaries_policy" ON public.hr_salaries FOR ALL USING (true) WITH CHECK (true);

-- تحقق
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public' AND table_name LIKE 'hr_%'
ORDER BY table_name;

======================================================================
-- FILE: hr_attendance_update.sql

======================================================================

-- ============================================================
-- تحديث قيود الحضور لدعم أنواع الإجازات المتعددة
-- شغّله في Supabase → SQL Editor
-- ============================================================

ALTER TABLE public.hr_attendance
  DROP CONSTRAINT IF EXISTS hr_attendance_status_check;

ALTER TABLE public.hr_attendance
  ADD CONSTRAINT hr_attendance_status_check
  CHECK (status IN (
    'present',
    'absent',
    'late',
    'leave_annual',
    'leave_sick',
    'leave_unpaid',
    'leave_personal',
    'holiday'
  ));

======================================================================
-- FILE: orders_update.sql

======================================================================

-- إضافة حقول المسؤولين على الطلب
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS prepared_by TEXT;
ALTER TABLE public.orders ADD COLUMN IF NOT EXISTS delivered_by TEXT;

======================================================================
-- FILE: procurement_setup.sql

======================================================================

-- =================================================
-- Procurement Module Setup
-- Run this in Supabase SQL Editor
-- =================================================

-- 1. Suppliers
CREATE TABLE suppliers (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  code TEXT UNIQUE,
  name TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  address TEXT,
  city TEXT,
  country TEXT DEFAULT 'الاردن',
  contact_name TEXT,
  contact_phone TEXT,
  payment_terms INT DEFAULT 30,
  notes TEXT,
  is_active BOOLEAN DEFAULT true,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Purchase Orders
CREATE TABLE purchase_orders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  number TEXT UNIQUE,
  supplier_id UUID REFERENCES suppliers(id),
  supplier_name TEXT NOT NULL,
  date DATE DEFAULT CURRENT_DATE,
  expected_delivery DATE,
  status TEXT DEFAULT 'draft',
  currency TEXT DEFAULT 'JOD',
  subtotal NUMERIC(12,3) DEFAULT 0,
  tax_pct NUMERIC(5,2) DEFAULT 0,
  tax_amt NUMERIC(12,3) DEFAULT 0,
  total NUMERIC(12,3) DEFAULT 0,
  notes TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE purchase_order_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  po_id UUID REFERENCES purchase_orders(id) ON DELETE CASCADE,
  item_name TEXT NOT NULL,
  description TEXT,
  unit TEXT DEFAULT 'EACH',
  quantity NUMERIC(12,3) DEFAULT 1,
  unit_price NUMERIC(12,3) DEFAULT 0,
  tax_pct NUMERIC(5,2) DEFAULT 0,
  total NUMERIC(12,3) DEFAULT 0,
  sort_order INT DEFAULT 0
);

-- Auto-number trigger for POs
CREATE SEQUENCE IF NOT EXISTS po_number_seq START 1;

CREATE OR REPLACE FUNCTION next_po_number()
RETURNS TEXT LANGUAGE plpgsql AS $$
BEGIN
  RETURN 'PO-' || LPAD(nextval('po_number_seq')::TEXT, 4, '0');
END;
$$;

CREATE OR REPLACE FUNCTION set_po_number()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    NEW.number := next_po_number();
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_po_number
  BEFORE INSERT ON purchase_orders
  FOR EACH ROW EXECUTE FUNCTION set_po_number();

-- 3. Supplier Invoices
CREATE TABLE supplier_invoices (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  number TEXT,
  supplier_invoice_no TEXT,
  supplier_id UUID REFERENCES suppliers(id),
  supplier_name TEXT,
  po_id UUID REFERENCES purchase_orders(id),
  po_number TEXT,
  date DATE DEFAULT CURRENT_DATE,
  due_date DATE,
  status TEXT DEFAULT 'pending',
  currency TEXT DEFAULT 'JOD',
  total NUMERIC(12,3) DEFAULT 0,
  paid_amount NUMERIC(12,3) DEFAULT 0,
  notes TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 4. Supplier Payments
CREATE TABLE supplier_payments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  supplier_id UUID REFERENCES suppliers(id),
  invoice_id UUID REFERENCES supplier_invoices(id),
  date DATE DEFAULT CURRENT_DATE,
  amount NUMERIC(12,3) NOT NULL,
  method TEXT DEFAULT 'bank_transfer',
  reference TEXT,
  notes TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 5. Enable RLS
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchase_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchase_order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_payments ENABLE ROW LEVEL SECURITY;

-- 6. RLS Policies
CREATE POLICY "auth" ON suppliers
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "auth" ON purchase_orders
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "auth" ON purchase_order_items
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "auth" ON supplier_invoices
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "auth" ON supplier_payments
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

======================================================================
-- FILE: quote_lang_migration.sql

======================================================================

-- =========================================================
-- Quote Language Migration
-- إضافة حقل لغة العرض (عربي / إنجليزي)
-- =========================================================

ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS quote_lang TEXT DEFAULT 'ar';

COMMENT ON COLUMN public.quotations.quote_lang IS 'ar = Arabic RTL | en = English LTR';

======================================================================
-- FILE: order_customer_ref_migration.sql

======================================================================

-- =========================================================
-- Order Customer Reference Migration
-- إضافة مرجع الزبون ورقم الشراء على جدول الطلبات
-- =========================================================

ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS customer_ref TEXT,
  ADD COLUMN IF NOT EXISTS po_number    TEXT;

COMMENT ON COLUMN public.orders.customer_ref IS 'مرجع الزبون — يُعبَّأ يدوياً حسب ما يزوّده الزبون';
COMMENT ON COLUMN public.orders.po_number    IS 'رقم أمر الشراء (PO Number) الخاص بالزبون';

======================================================================
-- FILE: forms_vouchers_migration.sql

======================================================================

-- =========================================================
-- Forms / Vouchers Migration
-- نماذج جاهزة: سند صرف وسند قبض
-- =========================================================

CREATE TABLE IF NOT EXISTS public.vouchers (
  id              UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  type            TEXT        NOT NULL CHECK (type IN ('payment','receipt')),
  number          TEXT        NOT NULL,
  date            DATE        NOT NULL DEFAULT CURRENT_DATE,
  amount          NUMERIC(14,3) NOT NULL DEFAULT 0,
  currency        TEXT        NOT NULL DEFAULT 'JOD',
  party           TEXT,           -- المدفوع له (صرف) / المستلَم من (قبض)
  description     TEXT,           -- البيان
  payment_method  TEXT        NOT NULL DEFAULT 'نقداً',
  reference       TEXT,           -- رقم شيك / مرجع
  prepared_by     TEXT,
  approved_by     TEXT,
  notes           TEXT,
  created_by      UUID        REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at      TIMESTAMPTZ DEFAULT NOW(),
  updated_at      TIMESTAMPTZ DEFAULT NOW(),
  archived        BOOLEAN     DEFAULT FALSE,
  archive_reason  TEXT
);

-- فهرس على النوع لتسريع الفلترة
CREATE INDEX IF NOT EXISTS vouchers_type_idx ON public.vouchers(type);

-- Trigger لتحديث updated_at تلقائياً
CREATE OR REPLACE FUNCTION update_vouchers_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END; $$;

DROP TRIGGER IF EXISTS trg_vouchers_updated_at ON public.vouchers;
CREATE TRIGGER trg_vouchers_updated_at
  BEFORE UPDATE ON public.vouchers
  FOR EACH ROW EXECUTE FUNCTION update_vouchers_updated_at();

-- RLS
ALTER TABLE public.vouchers ENABLE ROW LEVEL SECURITY;
CREATE POLICY "vouchers_all" ON public.vouchers FOR ALL USING (auth.uid() IS NOT NULL);

======================================================================
-- FILE: orders_soft_delete_migration.sql

======================================================================

-- Soft delete columns for orders table
ALTER TABLE public.orders
  ADD COLUMN IF NOT EXISTS deleted_at    TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS deleted_by    UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS delete_reason TEXT;

======================================================================
-- FILE: requester_fields_migration.sql

======================================================================

-- Requester info fields on quotations (internal, not printed)
ALTER TABLE public.quotations
  ADD COLUMN IF NOT EXISTS requester_name   TEXT,
  ADD COLUMN IF NOT EXISTS requester_phone  TEXT,
  ADD COLUMN IF NOT EXISTS requester_phone2 TEXT;

======================================================================
-- FILE: customer_name_history_migration.sql

======================================================================

-- =========================================================
-- Customer Name History Migration
-- يحفظ أسماء العملاء تلقائياً عند كل حفظ عرض
-- =========================================================

-- 1. إنشاء الجدول
CREATE TABLE IF NOT EXISTS public.customer_name_history (
  name         TEXT PRIMARY KEY,
  last_used_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.customer_name_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "customer_name_history_all" ON public.customer_name_history
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- 2. استيراد بأثر رجعي: كل الأسماء الموجودة في عروض الأسعار
INSERT INTO public.customer_name_history (name, last_used_at)
SELECT
  customer_name,
  MAX(COALESCE(updated_at, created_at))
FROM public.quotations
WHERE customer_name IS NOT NULL AND trim(customer_name) != ''
GROUP BY customer_name
ON CONFLICT (name) DO UPDATE
  SET last_used_at = EXCLUDED.last_used_at;

======================================================================
-- FILE: reference_history_migration.sql

======================================================================

-- =========================================================
-- Reference History Migration
-- يحفظ المراجع تلقائياً عند كل حفظ عرض
-- =========================================================

-- 1. إنشاء الجدول
CREATE TABLE IF NOT EXISTS public.reference_history (
  name         TEXT PRIMARY KEY,
  last_used_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE public.reference_history ENABLE ROW LEVEL SECURITY;

CREATE POLICY "reference_history_all" ON public.reference_history
  FOR ALL USING (auth.uid() IS NOT NULL)
  WITH CHECK (auth.uid() IS NOT NULL);

-- 2. استيراد بأثر رجعي: كل المراجع الموجودة في عروض الأسعار
INSERT INTO public.reference_history (name, last_used_at)
SELECT
  reference,
  MAX(COALESCE(updated_at, created_at))
FROM public.quotations
WHERE reference IS NOT NULL AND trim(reference) != ''
GROUP BY reference
ON CONFLICT (name) DO UPDATE
  SET last_used_at = EXCLUDED.last_used_at;

======================================================================
-- FILE: archive_reasons_backfill.sql

======================================================================

-- =========================================================
-- Archive Reasons Backfill
-- استيراد بأثر رجعي لأسباب الأرشفة من الطلبيات والعروض القديمة
-- =========================================================

-- من الطلبيات
INSERT INTO public.archive_reasons (reason, last_used_at)
SELECT
  archive_note,
  MAX(COALESCE(archived_at, updated_at, created_at))
FROM public.orders
WHERE archive_note IS NOT NULL AND trim(archive_note) != ''
GROUP BY archive_note
ON CONFLICT (reason) DO UPDATE
  SET last_used_at = GREATEST(archive_reasons.last_used_at, EXCLUDED.last_used_at);

-- من العروض
INSERT INTO public.archive_reasons (reason, last_used_at)
SELECT
  archive_note,
  MAX(COALESCE(archived_at, updated_at, created_at))
FROM public.quotations
WHERE archive_note IS NOT NULL AND trim(archive_note) != ''
GROUP BY archive_note
ON CONFLICT (reason) DO UPDATE
  SET last_used_at = GREATEST(archive_reasons.last_used_at, EXCLUDED.last_used_at);

======================================================================
-- FILE: insert_quote_schools.sql

======================================================================

-- ================================================
-- إدخال عرض سعر: قسم الرعاية الصحية للمدارس
-- التاريخ: 8/8/2026 | المرجع: 5774/858
-- ================================================

DO $$
DECLARE
  v_quote_id UUID;
BEGIN

  -- 1. إدخال عرض السعر
  INSERT INTO public.quotations (
    customer_name, attention, date, reference,
    currency, delivery,
    subtotal, discount_pct, discount_amt,
    grand_total, tax_pct, tax_amt, nett_price,
    status, notes
  ) VALUES (
    'عرض سعر مخصص للمدارس',
    'قسم الرعاية الصحية',
    '2026-08-08',
    '5774/858',
    'JOD', 'PROMPT',
    1872.350, 0, 0,
    1872.350, 0, 0, 1872.350,
    'draft',
    'الأسعار شاملة الضريبة العامة على المبيعات والرسوم الجمركية'
  )
  RETURNING id INTO v_quote_id;

  -- 2. إدخال البنود
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 1, 'ميزان حرارة رقمي طبي Medical Digital Thermometer', 'Each', 2, 9.15, 'China', 'high accuracy');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 2, 'ميزان وزن الجسم مع الطول نظام قبان Digital Height and Weight Scale', 'Each', 1, 195, 'China', '');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 3, 'جهاز فحص الضغط اليدوي Manual Pressure Test Device', 'Each', 1, 15, 'China', 'aneroid');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 4, 'جهاز ضغط الرقمي digital sphygmomanometer', 'Each', 1, 19, 'China', 'wrist system');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 5, 'جهاز قياس مستوى سكر الدم Blood Glucose Meter', 'Each', 2, 15, 'Korea', 'high accuracy');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 6, 'جهاز قياس الأكسجين Pulse oximetry', 'Each', 2, 15, 'China', '');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 7, 'جهاز تبخيرة Medical Nebulizer', 'Each', 2, 29, 'China', 'F-PUFF');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 8, 'نموذج الهيكل العظمي', 'Each', 1, 35, 'China', '85 cm');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 9, 'نموذج تشريح ذو أعضاء قابلة للفك والتركيب', 'Each', 1, 110, 'India', '85 cm');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 10, 'دمية لتطبيق الإسعاف الأولي الرئوي', 'Each', 1, 690, 'China', 'anatomical');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 11, 'عربة حمل الأدوات والتجهيزات الطبية Medical trolley', 'Each', 2, 90, 'China', 'SS-415');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 12, 'ميزان حرارة رقمي Digital Thermometer', 'Each', 2, 9.15, 'China', 'SS-318');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 13, 'نموذج الفك والأسنان', 'Each', 2, 29, 'China', 'anatomical');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 14, 'جهاز قياس قوة التدفق الزفيري', 'Each', 2, 9.5, 'China', 'high accuracy');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 15, 'صندوق التخلص من الأدوات الحادة Sharps Disposal Container', 'Each', 1, 3.25, 'China', '');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 16, 'صندوق فرز النفايات الطبية Medical WasteBox', 'Set', 1, 45, 'China', '3PCS');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 17, 'سرير فحص طبي يدوي Manual Medical Examination Bed', 'Each', 2, 80, 'China', 'Medical');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 18, 'شرشف سرير Bed Sheet', 'Each', 2, 9, 'China', 'hypoallergic');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 19, 'حرام سرير Bed Blanket', 'Each', 2, 11, 'China', 'hypoallergic');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 20, 'مخدة طبية مع غطاء medical pillow with Cover', 'Each', 2, 9.25, 'China', 'hypoallergic');
  INSERT INTO public.quotation_items (quotation_id, sort_order, item_name, unit, quantity, unit_price, origin, notes)
  VALUES (v_quote_id, 21, 'ستارة', 'Each', 2, 65, 'China', 'Medical');

  RAISE NOTICE 'تم الإدخال بنجاح. رقم العرض: %', (SELECT number FROM public.quotations WHERE id = v_quote_id);

END $$;

======================================================================
-- FILE: fix_created_by.sql

======================================================================

-- إصلاح created_by للعروض التي لا تملك مُصدِراً
-- يربط العروض بصاحب الحساب hmest19813@gmail.com تلقائياً

UPDATE public.quotations
SET created_by = (
  SELECT id FROM auth.users WHERE email = 'hmest19813@gmail.com' LIMIT 1
)
WHERE created_by IS NULL;

======================================================================
-- FILE: fix_issuer_jawabra.sql

======================================================================

UPDATE public.quotations
SET created_by = (
  SELECT id FROM public.profiles WHERE full_name ILIKE '%Jawabreh%' LIMIT 1
)
WHERE number = 'QT-2026-0042';

======================================================================
-- FILE: fix_urgent.sql

======================================================================

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

======================================================================
-- FILE: chat_migration.sql

======================================================================

-- ============================================================
-- MedQuote Pro — Chat, Quote Discussions & Change Requests
-- شغّل في Supabase → SQL Editor
-- ============================================================

-- 1. شات جماعي -----------------------------------------------
CREATE TABLE IF NOT EXISTS public.chat_messages (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    uuid        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  body       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.chat_messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "chat_sel" ON public.chat_messages FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "chat_ins" ON public.chat_messages FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "chat_del" ON public.chat_messages FOR DELETE USING (auth.uid() = user_id);
ALTER PUBLICATION supabase_realtime ADD TABLE public.chat_messages;
ALTER TABLE public.chat_messages REPLICA IDENTITY FULL;

-- 2. نقاش العروض ----------------------------------------------
CREATE TABLE IF NOT EXISTS public.quote_discussions (
  id           uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  quotation_id uuid        REFERENCES public.quotations(id) ON DELETE CASCADE NOT NULL,
  user_id      uuid        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  body         text        NOT NULL,
  created_at   timestamptz DEFAULT now()
);
ALTER TABLE public.quote_discussions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "disc_sel" ON public.quote_discussions FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "disc_ins" ON public.quote_discussions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "disc_del" ON public.quote_discussions FOR DELETE USING (auth.uid() = user_id);
ALTER PUBLICATION supabase_realtime ADD TABLE public.quote_discussions;
ALTER TABLE public.quote_discussions REPLICA IDENTITY FULL;

-- 3. طلبات التعديل (مرئية للجميع، الإدارة للـ admin فقط) ------
CREATE TABLE IF NOT EXISTS public.change_requests (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id    uuid        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  title      text        NOT NULL,
  body       text        NOT NULL DEFAULT '',
  status     text        NOT NULL DEFAULT 'open',
  priority   text        NOT NULL DEFAULT 'medium',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);
ALTER TABLE public.change_requests ENABLE ROW LEVEL SECURITY;
CREATE POLICY "cr_sel" ON public.change_requests FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "cr_ins" ON public.change_requests FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "cr_upd" ON public.change_requests FOR UPDATE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);
CREATE POLICY "cr_del" ON public.change_requests FOR DELETE USING (
  EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND role = 'admin')
);

-- 4. ردود طلبات التعديل --------------------------------------
CREATE TABLE IF NOT EXISTS public.change_request_replies (
  id         uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id uuid        REFERENCES public.change_requests(id) ON DELETE CASCADE NOT NULL,
  user_id    uuid        REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  body       text        NOT NULL,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE public.change_request_replies ENABLE ROW LEVEL SECURITY;
CREATE POLICY "crr_sel" ON public.change_request_replies FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "crr_ins" ON public.change_request_replies FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "crr_del" ON public.change_request_replies FOR DELETE USING (auth.uid() = user_id);

-- تحقق من الإنشاء
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('chat_messages','quote_discussions','change_requests','change_request_replies')
ORDER BY table_name;
