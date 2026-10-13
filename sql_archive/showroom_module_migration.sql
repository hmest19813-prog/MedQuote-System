-- ============================================================
-- MedQuote Pro — إدارة المعارض (Showroom Management)
--
-- معرضان فعليان: عمان - العبدلي (AMM) ودمشق - الحلبوني (DAM).
-- أصناف المعرض = نفس catalog_items (نفس الاسم/السعر الأساسي)،
-- بس رصيد مخزون منفصل تماماً لكل معرض (showroom_stock_movements،
-- دفتر append-only بنفس فلسفة chem_stock_movements — ممنوع يصير
-- الرصيد سالب). التزوّد: شراء مباشر (showroom_purchases) أو تحويل
-- من المستودع الرئيسي/معرض تاني (showroom_stock_transfers، بيأثر
-- كمان على catalog_items.qty_on_hand المركزي عبر stock_movements
-- الموجود مسبقاً لو طرف التحويل هو المستودع). المبيعات ممكن تكون
-- بالدين/دفعة جزئية (showroom_sales + showroom_sale_payments).
-- دفتر المعرض (زيارات/استفسارات) وصندوق الكاش (دفتر اليومية)
-- جداول منفصلة، والصندوق بيتغذى تلقائياً من تحصيلات البيع
-- ومدفوعات الشراء الكاش.
--
-- عمليتا إنشاء البيع والتحويل تمرّان عبر RPC (create_showroom_sale/
-- create_showroom_transfer) بدل إدراج متسلسل من العميل، عشان لو
-- صنف فشل بفحص الرصيد (بيع/تحويل أكبر من المتوفر) يترجع كل شي
-- سوا (معاملة واحدة) بدل ما يضل مستند رأس بدون بنود.
--
-- شغّله كاملاً دفعة واحدة في Supabase SQL Editor.
-- ============================================================

BEGIN;

-- ══════════════════════════════════════════════
-- 1) جدول المعارض
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.showrooms (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  code             text NOT NULL UNIQUE,
  name             text NOT NULL,
  city             text,
  address          text,
  default_currency text NOT NULL DEFAULT 'JOD',
  is_active        boolean NOT NULL DEFAULT true,
  created_by       uuid REFERENCES public.profiles(id),
  created_at       timestamptz NOT NULL DEFAULT now()
);

INSERT INTO public.showrooms (code, name, city, default_currency) VALUES
  ('AMM', 'معرض عمان - العبدلي', 'عمان', 'JOD'),
  ('DAM', 'معرض دمشق - الحلبوني', 'دمشق', 'JOD')
ON CONFLICT (code) DO NOTHING;

-- ══════════════════════════════════════════════
-- 2) الترقيم التلقائي العام (كل معرض إله تسلسل مستقل لكل نوع مستند،
--    يُزرع تلقائياً بأول استخدام — معرض جديد مستقبلاً ما بيحتاج migration)
-- ══════════════════════════════════════════════
CREATE OR REPLACE FUNCTION public.generate_showroom_number(p_showroom_id uuid, p_doc_type text)
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path TO 'public'
AS $$
DECLARE
  v_code        text;
  v_seq_id      text;
  v_prefix      text;
  current_year  INTEGER := EXTRACT(YEAR FROM NOW())::INTEGER;
  next_val      INTEGER;
BEGIN
  SELECT code INTO v_code FROM public.showrooms WHERE id = p_showroom_id;
  IF v_code IS NULL THEN RAISE EXCEPTION 'معرض غير معروف'; END IF;

  v_seq_id := p_doc_type || '_' || v_code;
  v_prefix := v_code || '-' || p_doc_type;

  INSERT INTO public.number_sequences (id, prefix, current_value, year)
    VALUES (v_seq_id, v_prefix, 0, current_year)
    ON CONFLICT (id) DO NOTHING;

  UPDATE public.number_sequences SET current_value = 0, year = current_year
    WHERE id = v_seq_id AND year < current_year;

  UPDATE public.number_sequences SET current_value = current_value + 1
    WHERE id = v_seq_id
    RETURNING current_value INTO next_val;

  RETURN v_prefix || '-' || current_year || '-' || LPAD(next_val::TEXT, 3, '0');
END;
$$;

-- ══════════════════════════════════════════════
-- 3) دفتر حركات المخزون (الأساس — نفس فلسفة chem_stock_movements)
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.showroom_stock_movements (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  showroom_id  uuid NOT NULL REFERENCES public.showrooms(id),
  catalog_id   uuid NOT NULL REFERENCES public.catalog_items(id),
  movement_type text NOT NULL CHECK (movement_type IN ('purchase_in','transfer_in','transfer_out','sale_out','return_in','adjust')),
  qty          numeric(14,3) NOT NULL CHECK (qty <> 0),
  unit_cost    numeric(12,3),
  ref_type     text,
  ref_id       uuid,
  notes        text,
  created_by   uuid REFERENCES public.profiles(id),
  created_at   timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_showroom_stock_mv_item ON public.showroom_stock_movements(showroom_id, catalog_id);
CREATE INDEX IF NOT EXISTS idx_showroom_stock_mv_ref  ON public.showroom_stock_movements(ref_type, ref_id);

CREATE OR REPLACE FUNCTION public.showroom_check_balance() RETURNS trigger
LANGUAGE plpgsql AS $$
DECLARE bal numeric;
BEGIN
  IF NEW.qty < 0 THEN
    PERFORM pg_advisory_xact_lock(hashtext('showroom_stock'));
    SELECT COALESCE(SUM(qty),0) INTO bal FROM public.showroom_stock_movements
      WHERE showroom_id = NEW.showroom_id AND catalog_id = NEW.catalog_id;
    IF bal + NEW.qty < 0 THEN
      RAISE EXCEPTION 'رصيد غير كافٍ بهذا المعرض لهذا الصنف: المتاح % والمطلوب %', bal, -NEW.qty USING ERRCODE = 'P0001';
    END IF;
  END IF;
  RETURN NEW;
END;
$$;

-- ⚠️ قرار مؤقت (2026-10-13) بطلب صريح من المستخدم: القيد غير مُفعَّل حالياً —
-- مخزون المستودعات/المعارض لسا غير مجرود بدقة، فالبيع/التحويل لصنف برصيد غير
-- كافٍ مسموح حالياً (بيصير الرصيد سالب بدل ما يُرفض)، نفس سلوك stock_movements
-- المركزي أصلاً (بدون أي قيد). الدالة فوق محفوظة جاهزة — لإعادة التفعيل لاحقاً
-- (لما تنضبط الأرصدة)، فقط شغّل:
--   CREATE TRIGGER trg_showroom_check_balance BEFORE INSERT ON public.showroom_stock_movements
--     FOR EACH ROW EXECUTE FUNCTION public.showroom_check_balance();
DROP TRIGGER IF EXISTS trg_showroom_check_balance ON public.showroom_stock_movements;

CREATE OR REPLACE VIEW public.showroom_stock_balances AS
  SELECT showroom_id, catalog_id, SUM(qty) AS qty_balance
  FROM public.showroom_stock_movements
  GROUP BY showroom_id, catalog_id;

-- ══════════════════════════════════════════════
-- 3ب) الأصناف المخصصة لكل معرض — تبويب "المخزون" وشاشة نقطة البيع
--     بيعرضوا بس هاي الأصناف، مش كامل الكتالوج العام. أي حركة مخزون
--     (شراء/تحويل وارد/تسوية...) بتسجّل الصنف تلقائياً كمخصص لهذا
--     المعرض لو مش مسجّل أصلاً (upsert بدون تعارض) — + إدارة يدوية
--     من المدير (إضافة صنف قبل أي حركة فعلية، أو حذف صنف ما عاد يُباع).
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.showroom_catalog_items (
  showroom_id uuid NOT NULL REFERENCES public.showrooms(id),
  catalog_id  uuid NOT NULL REFERENCES public.catalog_items(id),
  created_by  uuid REFERENCES public.profiles(id),
  created_at  timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (showroom_id, catalog_id)
);

CREATE OR REPLACE FUNCTION public.showroom_ensure_catalog_assignment() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
BEGIN
  INSERT INTO public.showroom_catalog_items (showroom_id, catalog_id, created_by)
  VALUES (NEW.showroom_id, NEW.catalog_id, NEW.created_by)
  ON CONFLICT (showroom_id, catalog_id) DO NOTHING;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_showroom_ensure_catalog_assignment ON public.showroom_stock_movements;
CREATE TRIGGER trg_showroom_ensure_catalog_assignment AFTER INSERT ON public.showroom_stock_movements
  FOR EACH ROW EXECUTE FUNCTION public.showroom_ensure_catalog_assignment();

-- ══════════════════════════════════════════════
-- 4) الصندوق (دفتر اليومية) — يتغذى يدوياً + تلقائياً من تحصيلات
--    البيع ومدفوعات الشراء الكاش (راجع triggers أدناه)
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.showroom_cash_entries (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  showroom_id uuid NOT NULL REFERENCES public.showrooms(id),
  entry_date  date NOT NULL DEFAULT CURRENT_DATE,
  direction   text NOT NULL CHECK (direction IN ('in','out')),
  amount      numeric(12,3) NOT NULL CHECK (amount > 0),
  category    text,
  ref_type    text,
  ref_id      uuid,
  notes       text,
  created_by  uuid REFERENCES public.profiles(id),
  created_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_showroom_cash_showroom ON public.showroom_cash_entries(showroom_id);
CREATE INDEX IF NOT EXISTS idx_showroom_cash_ref ON public.showroom_cash_entries(ref_type, ref_id);

CREATE OR REPLACE VIEW public.showroom_cash_balance AS
  SELECT showroom_id,
    SUM(CASE WHEN direction = 'in' THEN amount ELSE -amount END) AS balance
  FROM public.showroom_cash_entries
  GROUP BY showroom_id;

-- ══════════════════════════════════════════════
-- 5) المشتريات (تزوّد مباشر من مورد)
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.showroom_purchases (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  showroom_id   uuid NOT NULL REFERENCES public.showrooms(id),
  number        text UNIQUE,
  supplier_id   uuid REFERENCES public.suppliers(id),
  supplier_name text,
  purchase_date date NOT NULL DEFAULT CURRENT_DATE,
  currency      text NOT NULL DEFAULT 'JOD',
  subtotal      numeric(12,3) NOT NULL DEFAULT 0,
  tax_amt       numeric(12,3) NOT NULL DEFAULT 0,
  total         numeric(12,3) NOT NULL DEFAULT 0,
  paid_amount   numeric(12,3) NOT NULL DEFAULT 0,
  notes         text,
  deleted_at    timestamptz, deleted_by uuid REFERENCES public.profiles(id), delete_reason text,
  created_by    uuid REFERENCES public.profiles(id),
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now()
);

CREATE OR REPLACE FUNCTION public.set_showroom_purchase_number() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.number IS NULL THEN NEW.number := public.generate_showroom_number(NEW.showroom_id, 'P'); END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_showroom_purchase_number ON public.showroom_purchases;
CREATE TRIGGER trg_showroom_purchase_number BEFORE INSERT ON public.showroom_purchases
  FOR EACH ROW EXECUTE FUNCTION public.set_showroom_purchase_number();

CREATE OR REPLACE FUNCTION public.showroom_purchase_cash_entry() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
BEGIN
  IF NEW.paid_amount > 0 THEN
    INSERT INTO public.showroom_cash_entries (showroom_id, entry_date, direction, amount, category, ref_type, ref_id, created_by)
    VALUES (NEW.showroom_id, NEW.purchase_date, 'out', NEW.paid_amount, 'دفع مشتريات', 'purchase', NEW.id, NEW.created_by);
  END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_showroom_purchase_cash_entry ON public.showroom_purchases;
CREATE TRIGGER trg_showroom_purchase_cash_entry AFTER INSERT ON public.showroom_purchases
  FOR EACH ROW EXECUTE FUNCTION public.showroom_purchase_cash_entry();

CREATE TABLE IF NOT EXISTS public.showroom_purchase_items (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_id uuid NOT NULL REFERENCES public.showroom_purchases(id) ON DELETE CASCADE,
  catalog_id  uuid NOT NULL REFERENCES public.catalog_items(id),
  item_name   text,
  unit        text,
  qty         numeric(14,3) NOT NULL CHECK (qty > 0),
  unit_cost   numeric(12,3) NOT NULL DEFAULT 0,
  total       numeric(12,3) NOT NULL DEFAULT 0,
  sort_order  int DEFAULT 0
);
CREATE INDEX IF NOT EXISTS idx_showroom_purchase_items_purchase ON public.showroom_purchase_items(purchase_id);

CREATE OR REPLACE FUNCTION public.showroom_purchase_item_movement() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
DECLARE v_showroom uuid;
BEGIN
  SELECT showroom_id INTO v_showroom FROM public.showroom_purchases WHERE id = NEW.purchase_id;
  INSERT INTO public.showroom_stock_movements (showroom_id, catalog_id, movement_type, qty, unit_cost, ref_type, ref_id, created_by)
  VALUES (v_showroom, NEW.catalog_id, 'purchase_in', NEW.qty, NEW.unit_cost, 'purchase', NEW.purchase_id, auth.uid());
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_showroom_purchase_item_movement ON public.showroom_purchase_items;
CREATE TRIGGER trg_showroom_purchase_item_movement AFTER INSERT ON public.showroom_purchase_items
  FOR EACH ROW EXECUTE FUNCTION public.showroom_purchase_item_movement();

-- ══════════════════════════════════════════════
-- 6) التحويلات (من/إلى المستودع الرئيسي، أو بين معرضين)
--    from/to = NULL يعني المستودع الرئيسي. التأثير على المستودع
--    الرئيسي يمر عبر stock_movements الموجود مسبقاً (نفس الجدول
--    اللي بيحدّث catalog_items.qty_on_hand تلقائياً بالفعل).
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.showroom_stock_transfers (
  id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  number           text UNIQUE,
  from_showroom_id uuid REFERENCES public.showrooms(id),
  to_showroom_id   uuid REFERENCES public.showrooms(id),
  transfer_date    date NOT NULL DEFAULT CURRENT_DATE,
  notes            text,
  created_by       uuid REFERENCES public.profiles(id),
  created_at       timestamptz NOT NULL DEFAULT now(),
  CHECK (from_showroom_id IS NOT NULL OR to_showroom_id IS NOT NULL),
  CHECK (from_showroom_id IS DISTINCT FROM to_showroom_id)
);

CREATE OR REPLACE FUNCTION public.set_showroom_transfer_number() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.number IS NULL THEN
    NEW.number := public.generate_showroom_number(COALESCE(NEW.to_showroom_id, NEW.from_showroom_id), 'T');
  END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_showroom_transfer_number ON public.showroom_stock_transfers;
CREATE TRIGGER trg_showroom_transfer_number BEFORE INSERT ON public.showroom_stock_transfers
  FOR EACH ROW EXECUTE FUNCTION public.set_showroom_transfer_number();

CREATE TABLE IF NOT EXISTS public.showroom_stock_transfer_items (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  transfer_id uuid NOT NULL REFERENCES public.showroom_stock_transfers(id) ON DELETE CASCADE,
  catalog_id  uuid NOT NULL REFERENCES public.catalog_items(id),
  qty         numeric(14,3) NOT NULL CHECK (qty > 0)
);
CREATE INDEX IF NOT EXISTS idx_showroom_transfer_items_transfer ON public.showroom_stock_transfer_items(transfer_id);

CREATE OR REPLACE FUNCTION public.showroom_transfer_item_movement() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
DECLARE v_from uuid; v_to uuid;
BEGIN
  SELECT from_showroom_id, to_showroom_id INTO v_from, v_to
    FROM public.showroom_stock_transfers WHERE id = NEW.transfer_id;

  IF v_from IS NOT NULL THEN
    INSERT INTO public.showroom_stock_movements (showroom_id, catalog_id, movement_type, qty, ref_type, ref_id, created_by)
    VALUES (v_from, NEW.catalog_id, 'transfer_out', -NEW.qty, 'transfer', NEW.transfer_id, auth.uid());
  ELSE
    INSERT INTO public.stock_movements (catalog_id, quantity, movement_date, supplier_name, created_by)
    VALUES (NEW.catalog_id, -NEW.qty, CURRENT_DATE, 'تحويل لمعرض', auth.uid());
  END IF;

  IF v_to IS NOT NULL THEN
    INSERT INTO public.showroom_stock_movements (showroom_id, catalog_id, movement_type, qty, ref_type, ref_id, created_by)
    VALUES (v_to, NEW.catalog_id, 'transfer_in', NEW.qty, 'transfer', NEW.transfer_id, auth.uid());
  ELSE
    INSERT INTO public.stock_movements (catalog_id, quantity, movement_date, supplier_name, created_by)
    VALUES (NEW.catalog_id, NEW.qty, CURRENT_DATE, 'إرجاع من معرض', auth.uid());
  END IF;

  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_showroom_transfer_item_movement ON public.showroom_stock_transfer_items;
CREATE TRIGGER trg_showroom_transfer_item_movement AFTER INSERT ON public.showroom_stock_transfer_items
  FOR EACH ROW EXECUTE FUNCTION public.showroom_transfer_item_movement();

-- ══════════════════════════════════════════════
-- 7) المبيعات (نقطة البيع) — ممكن كاش كامل/جزئي/دين
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.showroom_sales (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  showroom_id       uuid NOT NULL REFERENCES public.showrooms(id),
  number            text UNIQUE,
  sale_date         date NOT NULL DEFAULT CURRENT_DATE,
  customer_id       uuid REFERENCES public.customers(id),
  customer_name_free text,
  employee_id       uuid REFERENCES public.profiles(id),
  currency          text NOT NULL DEFAULT 'JOD',
  subtotal          numeric(12,3) NOT NULL DEFAULT 0,
  discount_amt      numeric(12,3) NOT NULL DEFAULT 0,
  tax_amt           numeric(12,3) NOT NULL DEFAULT 0,
  total             numeric(12,3) NOT NULL DEFAULT 0,
  amount_paid       numeric(12,3) NOT NULL DEFAULT 0,
  payment_status    text NOT NULL DEFAULT 'unpaid' CHECK (payment_status IN ('paid','partial','unpaid')),
  notes             text,
  deleted_at        timestamptz, deleted_by uuid REFERENCES public.profiles(id), delete_reason text,
  created_by        uuid REFERENCES public.profiles(id),
  created_at        timestamptz NOT NULL DEFAULT now(),
  updated_at        timestamptz NOT NULL DEFAULT now()
);

CREATE OR REPLACE FUNCTION public.set_showroom_sale_number() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.number IS NULL THEN NEW.number := public.generate_showroom_number(NEW.showroom_id, 'S'); END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_showroom_sale_number ON public.showroom_sales;
CREATE TRIGGER trg_showroom_sale_number BEFORE INSERT ON public.showroom_sales
  FOR EACH ROW EXECUTE FUNCTION public.set_showroom_sale_number();

CREATE TABLE IF NOT EXISTS public.showroom_sale_items (
  id         uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sale_id    uuid NOT NULL REFERENCES public.showroom_sales(id) ON DELETE CASCADE,
  catalog_id uuid NOT NULL REFERENCES public.catalog_items(id),
  item_name  text,
  unit       text,
  qty        numeric(14,3) NOT NULL CHECK (qty > 0),
  unit_price numeric(12,3) NOT NULL DEFAULT 0,
  tax_pct    numeric(5,2) NOT NULL DEFAULT 0,
  total      numeric(12,3) NOT NULL DEFAULT 0,
  sort_order int DEFAULT 0
);
CREATE INDEX IF NOT EXISTS idx_showroom_sale_items_sale ON public.showroom_sale_items(sale_id);

CREATE OR REPLACE FUNCTION public.showroom_sale_item_movement() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
DECLARE v_showroom uuid;
BEGIN
  SELECT showroom_id INTO v_showroom FROM public.showroom_sales WHERE id = NEW.sale_id;
  INSERT INTO public.showroom_stock_movements (showroom_id, catalog_id, movement_type, qty, ref_type, ref_id, created_by)
  VALUES (v_showroom, NEW.catalog_id, 'sale_out', -NEW.qty, 'sale', NEW.sale_id, auth.uid());
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_showroom_sale_item_movement ON public.showroom_sale_items;
CREATE TRIGGER trg_showroom_sale_item_movement AFTER INSERT ON public.showroom_sale_items
  FOR EACH ROW EXECUTE FUNCTION public.showroom_sale_item_movement();

-- ══════════════════════════════════════════════
-- 8) تحصيلات البيع (دفعات لاحقة على بيع بالدين)
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.showroom_sale_payments (
  id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sale_id      uuid NOT NULL REFERENCES public.showroom_sales(id) ON DELETE CASCADE,
  showroom_id  uuid NOT NULL REFERENCES public.showrooms(id),
  payment_date date NOT NULL DEFAULT CURRENT_DATE,
  amount       numeric(12,3) NOT NULL CHECK (amount > 0),
  method       text NOT NULL DEFAULT 'cash',
  reference    text,
  notes        text,
  created_by   uuid REFERENCES public.profiles(id),
  created_at   timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_showroom_sale_payments_sale ON public.showroom_sale_payments(sale_id);

CREATE OR REPLACE FUNCTION public.showroom_sale_payment_sync() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
DECLARE v_sale_id uuid; v_showroom uuid; v_total numeric; v_paid numeric; v_status text;
BEGIN
  v_sale_id := COALESCE(NEW.sale_id, OLD.sale_id);
  SELECT showroom_id, total INTO v_showroom, v_total FROM public.showroom_sales WHERE id = v_sale_id;
  SELECT COALESCE(SUM(amount),0) INTO v_paid FROM public.showroom_sale_payments WHERE sale_id = v_sale_id;
  v_status := CASE WHEN v_paid <= 0 THEN 'unpaid' WHEN v_paid >= v_total THEN 'paid' ELSE 'partial' END;
  UPDATE public.showroom_sales SET amount_paid = v_paid, payment_status = v_status WHERE id = v_sale_id;

  IF TG_OP = 'INSERT' AND NEW.method = 'cash' THEN
    INSERT INTO public.showroom_cash_entries (showroom_id, entry_date, direction, amount, category, ref_type, ref_id, created_by)
    VALUES (v_showroom, NEW.payment_date, 'in', NEW.amount, 'تحصيل بيع', 'sale_payment', NEW.id, NEW.created_by);
  ELSIF TG_OP = 'DELETE' THEN
    DELETE FROM public.showroom_cash_entries WHERE ref_type = 'sale_payment' AND ref_id = OLD.id;
  END IF;

  RETURN COALESCE(NEW, OLD);
END;
$$;
DROP TRIGGER IF EXISTS trg_showroom_sale_payment_sync ON public.showroom_sale_payments;
CREATE TRIGGER trg_showroom_sale_payment_sync AFTER INSERT OR DELETE ON public.showroom_sale_payments
  FOR EACH ROW EXECUTE FUNCTION public.showroom_sale_payment_sync();

-- ══════════════════════════════════════════════
-- 9) دفتر المعرض (زيارات/استفسارات — استقلّ عن المبيعات، بيترابط
--    اختيارياً لو الزيارة انتهت ببيع)
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.showroom_activity_log (
  id             uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  showroom_id    uuid NOT NULL REFERENCES public.showrooms(id),
  visit_at       timestamptz NOT NULL DEFAULT now(),
  activity_type  text NOT NULL DEFAULT 'inquiry' CHECK (activity_type IN ('inquiry','sale')),
  customer_name  text,
  customer_phone text,
  items_interest text,
  notes          text,
  employee_id    uuid REFERENCES public.profiles(id),
  sale_id        uuid REFERENCES public.showroom_sales(id),
  created_by     uuid REFERENCES public.profiles(id),
  created_at     timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_showroom_activity_showroom ON public.showroom_activity_log(showroom_id, visit_at);

-- ══════════════════════════════════════════════
-- 10) RPCs ذرّية (رأس + بنود بمعاملة واحدة — لو صنف فشل بفحص
--     الرصيد يترجع كل شي، ما يضل مستند رأس يتيم بدون بنود)
-- ══════════════════════════════════════════════
CREATE OR REPLACE FUNCTION public.create_showroom_sale(
  p_showroom_id uuid,
  p_items jsonb,
  p_customer_id uuid DEFAULT NULL,
  p_customer_name_free text DEFAULT NULL,
  p_employee_id uuid DEFAULT NULL,
  p_currency text DEFAULT 'JOD',
  p_discount_amt numeric DEFAULT 0,
  p_notes text DEFAULT NULL,
  p_initial_payment_amount numeric DEFAULT NULL,
  p_initial_payment_method text DEFAULT 'cash'
) RETURNS public.showroom_sales
LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
DECLARE
  v_sale     public.showroom_sales;
  v_item     jsonb;
  v_subtotal numeric := 0;
  v_tax      numeric := 0;
  v_line     numeric;
  v_sort     int := 0;
BEGIN
  IF NOT (public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_sell')) THEN
    RAISE EXCEPTION 'ليس لديك صلاحية البيع';
  END IF;
  IF p_items IS NULL OR jsonb_array_length(p_items) = 0 THEN
    RAISE EXCEPTION 'لا يوجد أصناف بالبيع';
  END IF;

  FOR v_item IN SELECT * FROM jsonb_array_elements(p_items) LOOP
    v_line := (v_item->>'qty')::numeric * (v_item->>'unit_price')::numeric;
    v_subtotal := v_subtotal + v_line;
    v_tax := v_tax + v_line * COALESCE((v_item->>'tax_pct')::numeric, 0) / 100;
  END LOOP;

  INSERT INTO public.showroom_sales
    (showroom_id, customer_id, customer_name_free, employee_id, currency, subtotal, discount_amt, tax_amt, total, notes, created_by)
  VALUES
    (p_showroom_id, p_customer_id, p_customer_name_free, p_employee_id, p_currency,
     v_subtotal, p_discount_amt, v_tax, v_subtotal - p_discount_amt + v_tax, p_notes, auth.uid())
  RETURNING * INTO v_sale;

  FOR v_item IN SELECT * FROM jsonb_array_elements(p_items) LOOP
    v_sort := v_sort + 1;
    INSERT INTO public.showroom_sale_items (sale_id, catalog_id, item_name, unit, qty, unit_price, tax_pct, total, sort_order)
    VALUES (
      v_sale.id, (v_item->>'catalog_id')::uuid, v_item->>'item_name', v_item->>'unit',
      (v_item->>'qty')::numeric, (v_item->>'unit_price')::numeric, COALESCE((v_item->>'tax_pct')::numeric, 0),
      (v_item->>'qty')::numeric * (v_item->>'unit_price')::numeric, v_sort
    );
  END LOOP;

  IF p_initial_payment_amount IS NOT NULL AND p_initial_payment_amount > 0 THEN
    INSERT INTO public.showroom_sale_payments (sale_id, showroom_id, payment_date, amount, method, created_by)
    VALUES (v_sale.id, p_showroom_id, CURRENT_DATE, p_initial_payment_amount, p_initial_payment_method, auth.uid());
  END IF;

  SELECT * INTO v_sale FROM public.showroom_sales WHERE id = v_sale.id;
  RETURN v_sale;
END;
$$;

CREATE OR REPLACE FUNCTION public.create_showroom_transfer(
  p_from_showroom_id uuid,
  p_to_showroom_id uuid,
  p_items jsonb,
  p_notes text DEFAULT NULL
) RETURNS public.showroom_stock_transfers
LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
DECLARE
  v_transfer public.showroom_stock_transfers;
  v_item     jsonb;
BEGIN
  IF NOT (public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_purchase')) THEN
    RAISE EXCEPTION 'ليس لديك صلاحية التحويل';
  END IF;
  IF p_from_showroom_id IS NULL AND p_to_showroom_id IS NULL THEN
    RAISE EXCEPTION 'لازم مصدر أو وجهة للتحويل';
  END IF;
  IF p_items IS NULL OR jsonb_array_length(p_items) = 0 THEN
    RAISE EXCEPTION 'لا يوجد أصناف بالتحويل';
  END IF;

  INSERT INTO public.showroom_stock_transfers (from_showroom_id, to_showroom_id, notes, created_by)
  VALUES (p_from_showroom_id, p_to_showroom_id, p_notes, auth.uid())
  RETURNING * INTO v_transfer;

  FOR v_item IN SELECT * FROM jsonb_array_elements(p_items) LOOP
    INSERT INTO public.showroom_stock_transfer_items (transfer_id, catalog_id, qty)
    VALUES (v_transfer.id, (v_item->>'catalog_id')::uuid, (v_item->>'qty')::numeric);
  END LOOP;

  SELECT * INTO v_transfer FROM public.showroom_stock_transfers WHERE id = v_transfer.id;
  RETURN v_transfer;
END;
$$;

-- ══════════════════════════════════════════════
-- 11) RLS — نفس نمط supply_chain_migration.sql. ملاحظة: إنشاء
--     البيع/التحويل الفعلي يمر عبر الـRPCs فوق (SECURITY DEFINER،
--     بتتجاوز RLS بعد فحص الصلاحية يدوياً بداخلها) — سياسات
--     INSERT المباشرة على showroom_sales/_items وshowroom_stock_
--     transfers/_items مقصورة على showrooms_manage عمداً (قناة
--     الإدخال العادية هي الـRPC، مش إدراج مباشر من الواجهة).
-- ══════════════════════════════════════════════
ALTER TABLE public.showrooms                      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_stock_movements        ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_catalog_items           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_cash_entries            ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_purchases               ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_purchase_items          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_stock_transfers         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_stock_transfer_items    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_sales                   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_sale_items              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_sale_payments           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.showroom_activity_log            ENABLE ROW LEVEL SECURITY;

-- showrooms
DROP POLICY IF EXISTS showrooms_select ON public.showrooms;
CREATE POLICY showrooms_select ON public.showrooms FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
);
DROP POLICY IF EXISTS showrooms_write ON public.showrooms;
CREATE POLICY showrooms_write ON public.showrooms FOR ALL TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
) WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);

-- showroom_stock_movements (قراءة فقط من العميل — كل الكتابة عبر triggers/RPCs، ما عدا تعديل يدوي للمدير)
DROP POLICY IF EXISTS showroom_stock_mv_select ON public.showroom_stock_movements;
CREATE POLICY showroom_stock_mv_select ON public.showroom_stock_movements FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
);
DROP POLICY IF EXISTS showroom_stock_mv_insert ON public.showroom_stock_movements;
CREATE POLICY showroom_stock_mv_insert ON public.showroom_stock_movements FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);

-- showroom_catalog_items (الإضافة التلقائية عبر trigger SECURITY DEFINER تتجاوز هذا أصلاً؛ هذا للإدارة اليدوية فقط)
DROP POLICY IF EXISTS showroom_catalog_items_select ON public.showroom_catalog_items;
CREATE POLICY showroom_catalog_items_select ON public.showroom_catalog_items FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
);
DROP POLICY IF EXISTS showroom_catalog_items_insert ON public.showroom_catalog_items;
CREATE POLICY showroom_catalog_items_insert ON public.showroom_catalog_items FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);
DROP POLICY IF EXISTS showroom_catalog_items_delete ON public.showroom_catalog_items;
CREATE POLICY showroom_catalog_items_delete ON public.showroom_catalog_items FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);

-- showroom_cash_entries (الإدخال اليدوي محصور بالقيود بدون ref_type؛ القيود التلقائية تدخل عبر trigger SECURITY DEFINER)
DROP POLICY IF EXISTS showroom_cash_select ON public.showroom_cash_entries;
CREATE POLICY showroom_cash_select ON public.showroom_cash_entries FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
);
DROP POLICY IF EXISTS showroom_cash_insert ON public.showroom_cash_entries;
CREATE POLICY showroom_cash_insert ON public.showroom_cash_entries FOR INSERT TO authenticated WITH CHECK (
  ref_type IS NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_cash')
  )
);
DROP POLICY IF EXISTS showroom_cash_delete ON public.showroom_cash_entries;
CREATE POLICY showroom_cash_delete ON public.showroom_cash_entries FOR DELETE TO authenticated USING (
  ref_type IS NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
  )
);

-- showroom_purchases + items (إدراج مباشر من العميل، نفس نمط POForm)
DROP POLICY IF EXISTS showroom_purchases_select ON public.showroom_purchases;
CREATE POLICY showroom_purchases_select ON public.showroom_purchases FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
);
DROP POLICY IF EXISTS showroom_purchases_insert ON public.showroom_purchases;
CREATE POLICY showroom_purchases_insert ON public.showroom_purchases FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_purchase')
);
DROP POLICY IF EXISTS showroom_purchases_update ON public.showroom_purchases;
CREATE POLICY showroom_purchases_update ON public.showroom_purchases FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);

DROP POLICY IF EXISTS showroom_purchase_items_rw ON public.showroom_purchase_items;
CREATE POLICY showroom_purchase_items_rw ON public.showroom_purchase_items FOR ALL TO authenticated USING (
  EXISTS (SELECT 1 FROM public.showroom_purchases p WHERE p.id = showroom_purchase_items.purchase_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.showroom_purchases p WHERE p.id = showroom_purchase_items.purchase_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_purchase')
  ))
);

-- showroom_stock_transfers + items (الإدخال الفعلي عبر create_showroom_transfer RPC)
DROP POLICY IF EXISTS showroom_transfers_select ON public.showroom_stock_transfers;
CREATE POLICY showroom_transfers_select ON public.showroom_stock_transfers FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
);
DROP POLICY IF EXISTS showroom_transfers_insert ON public.showroom_stock_transfers;
CREATE POLICY showroom_transfers_insert ON public.showroom_stock_transfers FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);

DROP POLICY IF EXISTS showroom_transfer_items_rw ON public.showroom_stock_transfer_items;
CREATE POLICY showroom_transfer_items_rw ON public.showroom_stock_transfer_items FOR ALL TO authenticated USING (
  EXISTS (SELECT 1 FROM public.showroom_stock_transfers t WHERE t.id = showroom_stock_transfer_items.transfer_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.showroom_stock_transfers t WHERE t.id = showroom_stock_transfer_items.transfer_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
  ))
);

-- showroom_sales + items (الإدخال الفعلي عبر create_showroom_sale RPC)
DROP POLICY IF EXISTS showroom_sales_select ON public.showroom_sales;
CREATE POLICY showroom_sales_select ON public.showroom_sales FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
);
DROP POLICY IF EXISTS showroom_sales_insert ON public.showroom_sales;
CREATE POLICY showroom_sales_insert ON public.showroom_sales FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);
DROP POLICY IF EXISTS showroom_sales_update ON public.showroom_sales;
CREATE POLICY showroom_sales_update ON public.showroom_sales FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);

DROP POLICY IF EXISTS showroom_sale_items_rw ON public.showroom_sale_items;
CREATE POLICY showroom_sale_items_rw ON public.showroom_sale_items FOR ALL TO authenticated USING (
  EXISTS (SELECT 1 FROM public.showroom_sales s WHERE s.id = showroom_sale_items.sale_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.showroom_sales s WHERE s.id = showroom_sale_items.sale_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
  ))
);

-- showroom_sale_payments (إدخال مباشر — تحصيل لاحق لا يحتاج RPC)
DROP POLICY IF EXISTS showroom_sale_payments_select ON public.showroom_sale_payments;
CREATE POLICY showroom_sale_payments_select ON public.showroom_sale_payments FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
);
DROP POLICY IF EXISTS showroom_sale_payments_insert ON public.showroom_sale_payments;
CREATE POLICY showroom_sale_payments_insert ON public.showroom_sale_payments FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  public.has_perm('showrooms_sell') OR public.has_perm('showrooms_cash')
);
DROP POLICY IF EXISTS showroom_sale_payments_delete ON public.showroom_sale_payments;
CREATE POLICY showroom_sale_payments_delete ON public.showroom_sale_payments FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);

-- showroom_activity_log
DROP POLICY IF EXISTS showroom_activity_select ON public.showroom_activity_log;
CREATE POLICY showroom_activity_select ON public.showroom_activity_log FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_access')
);
DROP POLICY IF EXISTS showroom_activity_insert ON public.showroom_activity_log;
CREATE POLICY showroom_activity_insert ON public.showroom_activity_log FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_sell')
);
DROP POLICY IF EXISTS showroom_activity_update ON public.showroom_activity_log;
CREATE POLICY showroom_activity_update ON public.showroom_activity_log FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);
DROP POLICY IF EXISTS showroom_activity_delete ON public.showroom_activity_log;
CREATE POLICY showroom_activity_delete ON public.showroom_activity_log FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('showrooms_manage')
);

-- ══════════════════════════════════════════════
-- 12) صلاحيات الوصول المباشر من العميل (Supabase client)
-- ══════════════════════════════════════════════
GRANT SELECT, INSERT, UPDATE, DELETE ON public.showrooms                   TO authenticated;
GRANT SELECT, INSERT                 ON public.showroom_stock_movements    TO authenticated;
GRANT SELECT, INSERT, DELETE         ON public.showroom_catalog_items      TO authenticated;
GRANT SELECT                         ON public.showroom_stock_balances     TO authenticated;
GRANT SELECT, INSERT, DELETE         ON public.showroom_cash_entries       TO authenticated;
GRANT SELECT                         ON public.showroom_cash_balance       TO authenticated;
GRANT SELECT, INSERT, UPDATE         ON public.showroom_purchases          TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.showroom_purchase_items     TO authenticated;
GRANT SELECT, INSERT                 ON public.showroom_stock_transfers    TO authenticated;
GRANT SELECT, INSERT                 ON public.showroom_stock_transfer_items TO authenticated;
GRANT SELECT, INSERT, UPDATE         ON public.showroom_sales              TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.showroom_sale_items         TO authenticated;
GRANT SELECT, INSERT, DELETE         ON public.showroom_sale_payments      TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.showroom_activity_log       TO authenticated;

GRANT EXECUTE ON FUNCTION public.generate_showroom_number(uuid, text)                       TO authenticated;
GRANT EXECUTE ON FUNCTION public.create_showroom_sale(uuid, jsonb, uuid, text, uuid, text, numeric, text, numeric, text) TO authenticated;
GRANT EXECUTE ON FUNCTION public.create_showroom_transfer(uuid, uuid, jsonb, text)           TO authenticated;

-- Realtime (نفس نمط باقي الجداول الحساسة بالنظام) — DO block لتجنّب خطأ
-- "relation already member of publication" لو اتشغّل الملف قبل جزئياً
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname='supabase_realtime' AND schemaname='public' AND tablename='showroom_sales') THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.showroom_sales;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname='supabase_realtime' AND schemaname='public' AND tablename='showroom_activity_log') THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.showroom_activity_log;
  END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_publication_tables WHERE pubname='supabase_realtime' AND schemaname='public' AND tablename='showroom_cash_entries') THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.showroom_cash_entries;
  END IF;
END $$;

-- ══════════════════════════════════════════════
-- 13) سجل التحديثات (idempotent — ما بيتكرر لو الملف اتشغّل أكتر من مرة)
-- ══════════════════════════════════════════════
INSERT INTO public.changelog_entries (title, description)
SELECT 'إدارة المعارض', 'قسم جديد كامل لإدارة معرضي عمان ودمشق: مخزون خاص بكل معرض، مبيعات (نقطة بيع) بالكاش أو بالدين، مشتريات، تحويلات من/إلى المستودع الرئيسي، دفتر زيارات واستفسارات، وصندوق كاش يومي.'
WHERE NOT EXISTS (SELECT 1 FROM public.changelog_entries WHERE title='إدارة المعارض');

COMMIT;

-- ══════════════════════════════════════════════
-- تحقق سريع بعد التشغيل
-- ══════════════════════════════════════════════
SELECT code, name FROM public.showrooms ORDER BY code;
SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public' AND tablename LIKE 'showroom%'
ORDER BY tablename, cmd;
