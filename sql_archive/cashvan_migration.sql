-- ============================================================
-- الكاش فان (محاسبة مندوب التوزيع المتجول) — CASH VAN
--
-- قسم منفصل تماماً عن orders/daily_orders. مندوب يتزوّد بالبضاعة
-- من المستودع بشكل غير دوري (تزويد)، بيبيعها لزبائن جانبيين
-- بأسعار مختلفة كل مرة (مبيعات)، وبيسلّم الكاش المحصّل للشركة
-- على دفعات (تسويات). الهدف: مطابقة البضاعة (أخذ - باع = متبقي)
-- ومطابقة الكاش (حصّل - سلّم = بعهدته) لكل مندوب.
--
-- زبائن المبيعات هون زبائن جانبيون (اسم/تلفون/عنوان اختيارية)،
-- منفصلون تماماً عن جدول customers. التسوية تتبّع داخلي فقط
-- حالياً (بدون ربط تلقائي بجدول vouchers). المرتجعات (بضاعة
-- ترجع من المندوب للمستودع) مؤجّلة لمرحلة تانية.
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.
-- يفترض وجود public.has_perm(text) و public.get_my_role() و
-- public.update_updated_at() مسبقاً.
-- ============================================================

BEGIN;

-- ── 1) الترقيم التلقائي (نفس نمط generate_daily_order_number) ──

INSERT INTO public.number_sequences (id, prefix, current_value, year)
VALUES
  ('cashvan_load',       'CVL', 0, EXTRACT(YEAR FROM NOW())::int),
  ('cashvan_sale',       'CVS', 0, EXTRACT(YEAR FROM NOW())::int),
  ('cashvan_settlement', 'CVT', 0, EXTRACT(YEAR FROM NOW())::int)
ON CONFLICT (id) DO NOTHING;

CREATE OR REPLACE FUNCTION public.generate_cashvan_number(seq_id text, seq_prefix text)
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  current_year INTEGER := EXTRACT(YEAR FROM NOW())::INTEGER;
  next_val     INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = 0, year = current_year
    WHERE id = seq_id AND year < current_year;

  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = seq_id
    RETURNING current_value INTO next_val;

  RETURN seq_prefix || '-' || current_year || '-' || LPAD(next_val::TEXT, 3, '0');
END;
$$;

CREATE OR REPLACE FUNCTION public.set_cashvan_load_number()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.number IS NULL THEN NEW.number := public.generate_cashvan_number('cashvan_load','CVL'); END IF;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.set_cashvan_sale_number()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.number IS NULL THEN NEW.number := public.generate_cashvan_number('cashvan_sale','CVS'); END IF;
  RETURN NEW;
END;
$$;

CREATE OR REPLACE FUNCTION public.set_cashvan_settlement_number()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.number IS NULL THEN NEW.number := public.generate_cashvan_number('cashvan_settlement','CVT'); END IF;
  RETURN NEW;
END;
$$;

-- ── 2) الجداول ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS public.cashvan_stock_loads (
  id          uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  number      text UNIQUE,
  rep_id      uuid NOT NULL REFERENCES public.profiles(id),
  load_date   date NOT NULL DEFAULT CURRENT_DATE,
  notes       text,
  total_cost  numeric(12,3) NOT NULL DEFAULT 0,
  created_by  uuid REFERENCES public.profiles(id),
  created_at  timestamptz DEFAULT now(),
  updated_at  timestamptz DEFAULT now()
);

ALTER TABLE public.cashvan_stock_loads REPLICA IDENTITY FULL;

CREATE TABLE IF NOT EXISTS public.cashvan_stock_load_items (
  id               uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  load_id          uuid NOT NULL REFERENCES public.cashvan_stock_loads(id) ON DELETE CASCADE,
  sort_order       integer DEFAULT 0,
  item_name        text NOT NULL,
  catalog_item_id  uuid REFERENCES public.catalog_items(id),
  unit             text DEFAULT 'EACH',
  quantity         numeric(10,3) NOT NULL DEFAULT 1,
  unit_cost        numeric(12,3) NOT NULL DEFAULT 0,
  total_cost       numeric(12,3) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS public.cashvan_sales (
  id               uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  number           text UNIQUE,
  rep_id           uuid NOT NULL REFERENCES public.profiles(id),
  sale_date        date NOT NULL DEFAULT CURRENT_DATE,
  customer_name    text,
  customer_phone   text,
  customer_address text,
  payment_status   text NOT NULL DEFAULT 'paid' CHECK (payment_status IN ('paid','partial','unpaid')),
  amount_paid      numeric(12,3) NOT NULL DEFAULT 0,
  total_amount     numeric(12,3) NOT NULL DEFAULT 0,
  notes            text,
  created_by       uuid REFERENCES public.profiles(id),
  created_at       timestamptz DEFAULT now(),
  updated_at       timestamptz DEFAULT now()
);

ALTER TABLE public.cashvan_sales REPLICA IDENTITY FULL;

CREATE TABLE IF NOT EXISTS public.cashvan_sale_items (
  id               uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  sale_id          uuid NOT NULL REFERENCES public.cashvan_sales(id) ON DELETE CASCADE,
  sort_order       integer DEFAULT 0,
  item_name        text NOT NULL,
  catalog_item_id  uuid REFERENCES public.catalog_items(id),
  unit             text DEFAULT 'EACH',
  quantity         numeric(10,3) NOT NULL DEFAULT 1,
  unit_price       numeric(12,3) NOT NULL DEFAULT 0,
  total_price      numeric(12,3) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS public.cashvan_settlements (
  id              uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  number          text UNIQUE,
  rep_id          uuid NOT NULL REFERENCES public.profiles(id),
  settlement_date date NOT NULL DEFAULT CURRENT_DATE,
  amount          numeric(12,3) NOT NULL DEFAULT 0,
  method          text NOT NULL DEFAULT 'نقداً',
  notes           text,
  created_by      uuid REFERENCES public.profiles(id),
  created_at      timestamptz DEFAULT now(),
  updated_at      timestamptz DEFAULT now()
);

ALTER TABLE public.cashvan_settlements REPLICA IDENTITY FULL;

CREATE INDEX IF NOT EXISTS idx_cvl_rep      ON public.cashvan_stock_loads USING btree (rep_id);
CREATE INDEX IF NOT EXISTS idx_cvl_date     ON public.cashvan_stock_loads USING btree (load_date);
CREATE INDEX IF NOT EXISTS idx_cvli_load    ON public.cashvan_stock_load_items USING btree (load_id);
CREATE INDEX IF NOT EXISTS idx_cvs_rep      ON public.cashvan_sales USING btree (rep_id);
CREATE INDEX IF NOT EXISTS idx_cvs_date     ON public.cashvan_sales USING btree (sale_date);
CREATE INDEX IF NOT EXISTS idx_cvsi_sale    ON public.cashvan_sale_items USING btree (sale_id);
CREATE INDEX IF NOT EXISTS idx_cvt_rep      ON public.cashvan_settlements USING btree (rep_id);
CREATE INDEX IF NOT EXISTS idx_cvt_date     ON public.cashvan_settlements USING btree (settlement_date);

DROP TRIGGER IF EXISTS trg_cashvan_load_number ON public.cashvan_stock_loads;
CREATE TRIGGER trg_cashvan_load_number BEFORE INSERT ON public.cashvan_stock_loads
  FOR EACH ROW EXECUTE FUNCTION public.set_cashvan_load_number();

DROP TRIGGER IF EXISTS trg_cashvan_loads_updated_at ON public.cashvan_stock_loads;
CREATE TRIGGER trg_cashvan_loads_updated_at BEFORE UPDATE ON public.cashvan_stock_loads
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

DROP TRIGGER IF EXISTS trg_cashvan_sale_number ON public.cashvan_sales;
CREATE TRIGGER trg_cashvan_sale_number BEFORE INSERT ON public.cashvan_sales
  FOR EACH ROW EXECUTE FUNCTION public.set_cashvan_sale_number();

DROP TRIGGER IF EXISTS trg_cashvan_sales_updated_at ON public.cashvan_sales;
CREATE TRIGGER trg_cashvan_sales_updated_at BEFORE UPDATE ON public.cashvan_sales
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

DROP TRIGGER IF EXISTS trg_cashvan_settlement_number ON public.cashvan_settlements;
CREATE TRIGGER trg_cashvan_settlement_number BEFORE INSERT ON public.cashvan_settlements
  FOR EACH ROW EXECUTE FUNCTION public.set_cashvan_settlement_number();

DROP TRIGGER IF EXISTS trg_cashvan_settlements_updated_at ON public.cashvan_settlements;
CREATE TRIGGER trg_cashvan_settlements_updated_at BEFORE UPDATE ON public.cashvan_settlements
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- ── 3) الصلاحيات (RLS) — نفس نمط daily_orders بالضبط ─────────

ALTER TABLE public.cashvan_stock_loads      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cashvan_stock_load_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cashvan_sales            ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cashvan_sale_items       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cashvan_settlements      ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS cvl_select ON public.cashvan_stock_loads;
CREATE POLICY cvl_select ON public.cashvan_stock_loads FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS cvl_insert ON public.cashvan_stock_loads;
CREATE POLICY cvl_insert ON public.cashvan_stock_loads FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('cashvan_create'))
  )
);

DROP POLICY IF EXISTS cvl_update ON public.cashvan_stock_loads;
CREATE POLICY cvl_update ON public.cashvan_stock_loads FOR UPDATE USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('cashvan_edit'))
);

DROP POLICY IF EXISTS cvl_delete ON public.cashvan_stock_loads;
CREATE POLICY cvl_delete ON public.cashvan_stock_loads FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('cashvan_delete'))
);

DROP POLICY IF EXISTS cvli_select ON public.cashvan_stock_load_items;
CREATE POLICY cvli_select ON public.cashvan_stock_load_items FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS cvli_write ON public.cashvan_stock_load_items;
CREATE POLICY cvli_write ON public.cashvan_stock_load_items FOR ALL USING (
  EXISTS (SELECT 1 FROM public.cashvan_stock_loads l WHERE l.id = cashvan_stock_load_items.load_id AND (
    l.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit') OR public.has_perm('cashvan_delete')))
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.cashvan_stock_loads l WHERE l.id = cashvan_stock_load_items.load_id AND (
    l.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit') OR public.has_perm('cashvan_delete')))
  ))
);

DROP POLICY IF EXISTS cvs_select ON public.cashvan_sales;
CREATE POLICY cvs_select ON public.cashvan_sales FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS cvs_insert ON public.cashvan_sales;
CREATE POLICY cvs_insert ON public.cashvan_sales FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('cashvan_create'))
  )
);

DROP POLICY IF EXISTS cvs_update ON public.cashvan_sales;
CREATE POLICY cvs_update ON public.cashvan_sales FOR UPDATE USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('cashvan_edit'))
);

DROP POLICY IF EXISTS cvs_delete ON public.cashvan_sales;
CREATE POLICY cvs_delete ON public.cashvan_sales FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('cashvan_delete'))
);

DROP POLICY IF EXISTS cvsi_select ON public.cashvan_sale_items;
CREATE POLICY cvsi_select ON public.cashvan_sale_items FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS cvsi_write ON public.cashvan_sale_items;
CREATE POLICY cvsi_write ON public.cashvan_sale_items FOR ALL USING (
  EXISTS (SELECT 1 FROM public.cashvan_sales s WHERE s.id = cashvan_sale_items.sale_id AND (
    s.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit') OR public.has_perm('cashvan_delete')))
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.cashvan_sales s WHERE s.id = cashvan_sale_items.sale_id AND (
    s.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('cashvan_create') OR public.has_perm('cashvan_edit') OR public.has_perm('cashvan_delete')))
  ))
);

DROP POLICY IF EXISTS cvt_select ON public.cashvan_settlements;
CREATE POLICY cvt_select ON public.cashvan_settlements FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS cvt_insert ON public.cashvan_settlements;
CREATE POLICY cvt_insert ON public.cashvan_settlements FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('cashvan_create'))
  )
);

DROP POLICY IF EXISTS cvt_update ON public.cashvan_settlements;
CREATE POLICY cvt_update ON public.cashvan_settlements FOR UPDATE USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('cashvan_edit'))
);

DROP POLICY IF EXISTS cvt_delete ON public.cashvan_settlements;
CREATE POLICY cvt_delete ON public.cashvan_settlements FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('cashvan_delete'))
);

-- ── 4) صلاحيات الوصول المباشر من العميل ──────────────────────

GRANT SELECT, INSERT, UPDATE, DELETE ON public.cashvan_stock_loads      TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.cashvan_stock_load_items TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.cashvan_sales            TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.cashvan_sale_items       TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.cashvan_settlements      TO authenticated;

-- ── 5) Realtime ────────────────────────────────────────────

ALTER PUBLICATION supabase_realtime ADD TABLE public.cashvan_stock_loads;
ALTER PUBLICATION supabase_realtime ADD TABLE public.cashvan_sales;
ALTER PUBLICATION supabase_realtime ADD TABLE public.cashvan_settlements;

-- ── 6) سجل التحديثات ──────────────────────────────────────

INSERT INTO public.changelog_entries (title, description) VALUES
  ('قسم جديد: الكاش فان', 'قسم جديد بالسايدبار "الكاش فان" لمحاسبة مندوب التوزيع المتجول: تسجيل تزويد البضاعة له من المستودع، مبيعاته لزبائن مختلفين بأسعار مختلفة، وتسويات الكاش اللي يسلّمها للشركة. نظرة عامة لكل مندوب توضح البضاعة المتبقية معه، الكاش المحصَّل غير المسوّى، وذمم الزبائن غير المحصّلة.');

COMMIT;
