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
-- VIEWS
-- ============================================================

CREATE OR REPLACE VIEW public.quotation_summary AS
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

CREATE OR REPLACE VIEW public.order_summary AS
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
