-- ============================================================
-- الطلبات اليومية (طلبات المندوبين) — DAILY ORDERS
--
-- نظام منفصل تماماً عن جدول orders الحالي (اللي مخصص لطلبات
-- مؤسسية متحولة من عروض أسعار). هذا الجدول لطلبات الأفراد
-- اليومية عبر المندوبين (تيليسكوبات/مجاهر/شرائح سكري...) اللي
-- بتتحول لشركة نقل أو لأبو طارق (توصيل داخل عمان).
--
-- شغّل هذا الملف كاملاً دفعة واحدة في Supabase SQL Editor.
-- يفترض وجود public.has_perm(text) و public.get_my_role() و
-- public.update_updated_at() مسبقاً (من fix_permissions_rls.sql
-- وباقي الملفات الأساسية).
-- ============================================================

BEGIN;

-- ── 1) الترقيم التلقائي (نفس نمط generate_order_number) ──────

INSERT INTO public.number_sequences (id, prefix, current_value, year)
VALUES ('daily_order', 'DO', 0, EXTRACT(YEAR FROM NOW())::int)
ON CONFLICT (id) DO NOTHING;

CREATE OR REPLACE FUNCTION public.generate_daily_order_number()
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
    WHERE id = 'daily_order' AND year < current_year;

  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'daily_order'
    RETURNING current_value INTO next_val;

  RETURN 'DO-' || current_year || '-' || LPAD(next_val::TEXT, 3, '0');
END;
$$;

CREATE OR REPLACE FUNCTION public.set_daily_order_number()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.number IS NULL THEN
    NEW.number := public.generate_daily_order_number();
  END IF;
  RETURN NEW;
END;
$$;

-- ── 2) الجداول ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS public.daily_orders (
  id             uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  number         text UNIQUE,
  order_date     date NOT NULL DEFAULT CURRENT_DATE,
  customer_name  text NOT NULL,
  customer_phone text,
  region         text,
  sales_rep_id   uuid REFERENCES public.profiles(id),
  channel        text NOT NULL CHECK (channel IN ('shipping_company','abu_tarek')),
  is_express     boolean NOT NULL DEFAULT false,
  express_fee    numeric(10,3) NOT NULL DEFAULT 0,
  payment_method text NOT NULL DEFAULT 'cod' CHECK (payment_method IN ('cod','prepaid')),
  subtotal       numeric(12,3) NOT NULL DEFAULT 0,
  total_amount   numeric(12,3) NOT NULL DEFAULT 0,
  status         text NOT NULL DEFAULT 'new' CHECK (status IN ('new','preparing','with_carrier','delivered','returned')),
  prepared_by    uuid REFERENCES public.profiles(id),
  prepared_at    timestamptz,
  notes          text,
  created_by     uuid REFERENCES public.profiles(id),
  created_at     timestamptz DEFAULT now(),
  updated_at     timestamptz DEFAULT now()
);

ALTER TABLE public.daily_orders REPLICA IDENTITY FULL;

CREATE TABLE IF NOT EXISTS public.daily_order_items (
  id              uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v4(),
  daily_order_id  uuid NOT NULL REFERENCES public.daily_orders(id) ON DELETE CASCADE,
  sort_order      integer DEFAULT 0,
  item_name       text NOT NULL,
  quantity        numeric(10,3) NOT NULL DEFAULT 1,
  unit_price      numeric(12,3) NOT NULL DEFAULT 0,
  total_price     numeric(12,3) NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_do_status  ON public.daily_orders USING btree (status);
CREATE INDEX IF NOT EXISTS idx_do_date    ON public.daily_orders USING btree (order_date);
CREATE INDEX IF NOT EXISTS idx_do_rep     ON public.daily_orders USING btree (sales_rep_id);
CREATE INDEX IF NOT EXISTS idx_doi_order  ON public.daily_order_items USING btree (daily_order_id);

DROP TRIGGER IF EXISTS trg_daily_order_number ON public.daily_orders;
CREATE TRIGGER trg_daily_order_number BEFORE INSERT ON public.daily_orders
  FOR EACH ROW EXECUTE FUNCTION public.set_daily_order_number();

DROP TRIGGER IF EXISTS trg_daily_orders_updated_at ON public.daily_orders;
CREATE TRIGGER trg_daily_orders_updated_at BEFORE UPDATE ON public.daily_orders
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- ── 3) الصلاحيات (RLS) — نفس نمط orders/order_items بالضبط ──

ALTER TABLE public.daily_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_order_items ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS daily_orders_select ON public.daily_orders;
CREATE POLICY daily_orders_select ON public.daily_orders FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS daily_orders_insert ON public.daily_orders;
CREATE POLICY daily_orders_insert ON public.daily_orders FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('daily_orders_create'))
  )
);

DROP POLICY IF EXISTS daily_orders_update ON public.daily_orders;
CREATE POLICY daily_orders_update ON public.daily_orders FOR UPDATE USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('daily_orders_edit'))
);

DROP POLICY IF EXISTS daily_orders_delete ON public.daily_orders;
CREATE POLICY daily_orders_delete ON public.daily_orders FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('daily_orders_delete'))
);

DROP POLICY IF EXISTS doitems_select ON public.daily_order_items;
CREATE POLICY doitems_select ON public.daily_order_items FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS doitems_write ON public.daily_order_items;
CREATE POLICY doitems_write ON public.daily_order_items FOR ALL USING (
  EXISTS (SELECT 1 FROM public.daily_orders o WHERE o.id = daily_order_items.daily_order_id AND (
    o.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('daily_orders_create') OR public.has_perm('daily_orders_edit') OR public.has_perm('daily_orders_delete')))
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.daily_orders o WHERE o.id = daily_order_items.daily_order_id AND (
    o.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('daily_orders_create') OR public.has_perm('daily_orders_edit') OR public.has_perm('daily_orders_delete')))
  ))
);

-- ── 4) صلاحيات الوصول المباشر من العميل (جولد rule) ──────────

GRANT SELECT, INSERT, UPDATE, DELETE ON public.daily_orders      TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.daily_order_items TO authenticated;

-- ── 5) Realtime (تحسباً لاستخدام مستقبلي — الواجهة الحالية لا تشترك) ──

ALTER PUBLICATION supabase_realtime ADD TABLE public.daily_orders;

COMMIT;
