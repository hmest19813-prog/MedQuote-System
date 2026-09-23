-- ============================================================
-- MedQuote Pro — إدارة الكيماويات (المرحلة 3): طلبات التجهيز
--
-- المدير / مسؤول الطلبيات يصدر طلب تجهيز ويسنده للكيميائي بالمختبر.
-- الكيميائي يجهّز من التشغيلات المعتمدة (صرف = حركة issue من المخزون)،
-- ثم يُسلَّم الطلب. منفصلة تماماً عن orders / daily_orders
-- (مع عمود ربط اختياري linked_order_id للمستقبل).
--
-- يُشغَّل بعد chemicals_phase2_migration.sql. آمن لإعادة التشغيل.
-- ============================================================

BEGIN;

CREATE TABLE IF NOT EXISTS public.chem_prep_orders (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    order_no text UNIQUE,
    customer_id uuid REFERENCES public.customers(id) ON DELETE SET NULL,
    customer_name text,
    assigned_to uuid REFERENCES public.profiles(id) ON DELETE SET NULL,
    priority text NOT NULL DEFAULT 'normal' CHECK (priority IN ('normal','urgent')),
    due_date date,
    status text NOT NULL DEFAULT 'new' CHECK (status IN ('new','in_progress','ready','delivered','cancelled')),
    linked_order_id uuid REFERENCES public.orders(id) ON DELETE SET NULL,
    notes text,
    prepared_by uuid,
    prepared_at timestamptz,
    delivered_at timestamptz,
    created_by uuid DEFAULT auth.uid(),
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);
ALTER TABLE public.chem_prep_orders OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.set_chem_prep_order_no() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.order_no IS NULL OR NEW.order_no = '' THEN
    NEW.order_no := public.chem_next_number('PR-' || to_char(CURRENT_DATE,'YYMM') || '-', 3);
  END IF;
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_set_chem_prep_order_no ON public.chem_prep_orders;
CREATE TRIGGER trg_set_chem_prep_order_no BEFORE INSERT ON public.chem_prep_orders
  FOR EACH ROW EXECUTE FUNCTION public.set_chem_prep_order_no();

CREATE TABLE IF NOT EXISTS public.chem_prep_order_items (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    order_id uuid NOT NULL REFERENCES public.chem_prep_orders(id) ON DELETE CASCADE,
    seq integer DEFAULT 0,
    material_id uuid NOT NULL REFERENCES public.chem_materials(id) ON DELETE RESTRICT,
    pack_size_id uuid NOT NULL REFERENCES public.chem_pack_sizes(id) ON DELETE RESTRICT,
    qty integer NOT NULL CHECK (qty > 0),
    notes text
);
ALTER TABLE public.chem_prep_order_items OWNER TO postgres;
CREATE INDEX IF NOT EXISTS chem_prep_items_order_idx ON public.chem_prep_order_items(order_id);

-- ما انصرف فعلياً: من أي تشغيلة وكم عبوة (للتتبّع + طباعة الـCOA)
CREATE TABLE IF NOT EXISTS public.chem_prep_order_picks (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    order_id uuid NOT NULL REFERENCES public.chem_prep_orders(id) ON DELETE CASCADE,
    item_id uuid NOT NULL REFERENCES public.chem_prep_order_items(id) ON DELETE CASCADE,
    lot_id uuid NOT NULL REFERENCES public.chem_lots(id) ON DELETE RESTRICT,
    pack_size_id uuid NOT NULL REFERENCES public.chem_pack_sizes(id) ON DELETE RESTRICT,
    qty integer NOT NULL CHECK (qty > 0)
);
ALTER TABLE public.chem_prep_order_picks OWNER TO postgres;
CREATE INDEX IF NOT EXISTS chem_prep_picks_order_idx ON public.chem_prep_order_picks(order_id);
CREATE INDEX IF NOT EXISTS chem_prep_picks_lot_idx ON public.chem_prep_order_picks(lot_id);

-- حارس انتقالات الحالة: الدخول لـ ready والخروج منه (مع إرجاع المخزون) فقط عبر الـRPC،
-- والطلب المُسلَّم أو الملغى ما بيرجع
CREATE OR REPLACE FUNCTION public.chem_prep_order_guard() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE via_rpc boolean := COALESCE(current_setting('chem.prep_rpc', true), '') = '1';
BEGIN
  IF NEW.status IS DISTINCT FROM OLD.status THEN
    IF OLD.status IN ('delivered','cancelled') THEN
      RAISE EXCEPTION 'لا يمكن تغيير حالة طلب %', CASE OLD.status WHEN 'delivered' THEN 'مُسلَّم' ELSE 'ملغى' END;
    END IF;
    IF (NEW.status = 'ready' OR OLD.status = 'ready') AND NOT via_rpc AND NOT (OLD.status = 'ready' AND NEW.status = 'delivered') THEN
      RAISE EXCEPTION 'تغيير حالة التجهيز يتم من شاشة الطلب فقط';
    END IF;
    IF NEW.status = 'delivered' AND OLD.status <> 'ready' THEN
      RAISE EXCEPTION 'لا يمكن تسليم طلب قبل تجهيزه';
    END IF;
    IF NEW.status = 'delivered' THEN NEW.delivered_at := now(); END IF;
  END IF;
  NEW.updated_at := now();
  RETURN NEW;
END;
$$;
DROP TRIGGER IF EXISTS trg_chem_prep_order_guard ON public.chem_prep_orders;
CREATE TRIGGER trg_chem_prep_order_guard BEFORE UPDATE ON public.chem_prep_orders
  FOR EACH ROW EXECUTE FUNCTION public.chem_prep_order_guard();

-- ══════════════════════════════════════════════
-- RPC: تجهيز الطلب وصرفه — p_picks = [{ item_id, lot_id, qty }]
-- ══════════════════════════════════════════════
CREATE OR REPLACE FUNCTION public.chem_fulfill_prep_order(p_order uuid, p_picks jsonb) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
    AS $$
DECLARE
  v_ord public.chem_prep_orders;
  v_pk jsonb;
  v_item public.chem_prep_order_items;
  v_lot public.chem_lots;
  v_qty int;
  v_bad record;
BEGIN
  IF NOT public.chem_can('chem_orders_prepare') THEN RAISE EXCEPTION 'ليس لديك صلاحية تجهيز الطلبات'; END IF;
  SELECT * INTO v_ord FROM public.chem_prep_orders WHERE id = p_order FOR UPDATE;
  IF NOT FOUND THEN RAISE EXCEPTION 'الطلب غير موجود'; END IF;
  IF v_ord.status NOT IN ('new','in_progress') THEN RAISE EXCEPTION 'الطلب ليس بمرحلة التجهيز'; END IF;

  FOR v_pk IN SELECT * FROM jsonb_array_elements(COALESCE(p_picks,'[]'::jsonb)) LOOP
    v_qty := (v_pk->>'qty')::int;
    IF v_qty IS NULL OR v_qty <= 0 THEN CONTINUE; END IF;
    SELECT * INTO v_item FROM public.chem_prep_order_items WHERE id = (v_pk->>'item_id')::uuid AND order_id = p_order;
    IF NOT FOUND THEN RAISE EXCEPTION 'بند غير تابع لهذا الطلب'; END IF;
    SELECT * INTO v_lot FROM public.chem_lots WHERE id = (v_pk->>'lot_id')::uuid;
    IF NOT FOUND OR v_lot.material_id <> v_item.material_id THEN RAISE EXCEPTION 'التشغيلة لا تطابق مادة البند'; END IF;
    IF v_lot.status <> 'approved' THEN RAISE EXCEPTION 'التشغيلة % غير معتمدة (بدون COA معتمدة)', v_lot.lot_no; END IF;
    IF v_lot.expiry_date IS NOT NULL AND v_lot.expiry_date < CURRENT_DATE THEN RAISE EXCEPTION 'التشغيلة % منتهية الصلاحية', v_lot.lot_no; END IF;
    INSERT INTO public.chem_prep_order_picks (order_id, item_id, lot_id, pack_size_id, qty)
    VALUES (p_order, v_item.id, v_lot.id, v_item.pack_size_id, v_qty);
    INSERT INTO public.chem_stock_movements (material_id, movement_type, lot_id, pack_size_id, qty, unit, ref_type, ref_id)
    VALUES (v_item.material_id, 'issue', v_lot.id, v_item.pack_size_id, -v_qty, 'pack', 'prep_order', p_order);
  END LOOP;

  -- كل بند لازم يتجهّز بالكامل
  SELECT i.id, i.qty, COALESCE(SUM(p.qty),0) AS picked INTO v_bad
    FROM public.chem_prep_order_items i LEFT JOIN public.chem_prep_order_picks p ON p.item_id = i.id
   WHERE i.order_id = p_order GROUP BY i.id, i.qty HAVING COALESCE(SUM(p.qty),0) <> i.qty LIMIT 1;
  IF FOUND THEN RAISE EXCEPTION 'الكمية المصروفة (%) لا تساوي المطلوبة (%) لأحد البنود', v_bad.picked, v_bad.qty; END IF;

  PERFORM set_config('chem.prep_rpc', '1', true);
  UPDATE public.chem_prep_orders SET status = 'ready', prepared_by = auth.uid(), prepared_at = now(), updated_at = now()
   WHERE id = p_order;
END;
$$;
GRANT EXECUTE ON FUNCTION public.chem_fulfill_prep_order(uuid, jsonb) TO authenticated;

-- إرجاع طلب جاهز للتجهيز أو إلغاؤه: العبوات المصروفة ترجع للمخزون
CREATE OR REPLACE FUNCTION public.chem_reopen_prep_order(p_order uuid, p_to text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER SET search_path = public
    AS $$
DECLARE v_ord public.chem_prep_orders;
BEGIN
  IF p_to NOT IN ('in_progress','cancelled') THEN RAISE EXCEPTION 'حالة غير صالحة'; END IF;
  IF NOT (public.chem_can('chem_orders_create') OR public.chem_can('chem_orders_prepare')) THEN
    RAISE EXCEPTION 'ليس لديك صلاحية على طلبات التجهيز';
  END IF;
  SELECT * INTO v_ord FROM public.chem_prep_orders WHERE id = p_order FOR UPDATE;
  IF NOT FOUND THEN RAISE EXCEPTION 'الطلب غير موجود'; END IF;
  IF v_ord.status = 'delivered' THEN RAISE EXCEPTION 'الطلب مُسلَّم — لا يمكن إرجاعه أو إلغاؤه'; END IF;
  DELETE FROM public.chem_stock_movements WHERE ref_type = 'prep_order' AND ref_id = p_order;
  DELETE FROM public.chem_prep_order_picks WHERE order_id = p_order;
  PERFORM set_config('chem.prep_rpc', '1', true);
  UPDATE public.chem_prep_orders SET status = p_to, prepared_by = NULL, prepared_at = NULL, updated_at = now()
   WHERE id = p_order;
END;
$$;
GRANT EXECUTE ON FUNCTION public.chem_reopen_prep_order(uuid, text) TO authenticated;

-- ══════════════════════════════════════════════
-- RLS
--   chem_orders_create   إنشاء/تعديل طلبات التجهيز وإسنادها (المدير / مسؤول الطلبيات)
--   chem_orders_prepare  تجهيز الطلبات وصرفها من المخزون (الكيميائي)
-- ══════════════════════════════════════════════
DO $$
DECLARE t text;
BEGIN
  FOREACH t IN ARRAY ARRAY['chem_prep_orders','chem_prep_order_items','chem_prep_order_picks'] LOOP
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t);
    EXECUTE format('ALTER TABLE ONLY public.%I REPLICA IDENTITY FULL', t);
    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', t||'_select', t);
    EXECUTE format('CREATE POLICY %I ON public.%I FOR SELECT TO authenticated USING (public.chem_can(''chemicals_access''))', t||'_select', t);
    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', t||'_insert', t);
    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', t||'_update', t);
    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', t||'_delete', t);
  END LOOP;
END $$;

CREATE POLICY chem_prep_orders_insert ON public.chem_prep_orders FOR INSERT TO authenticated
  WITH CHECK (public.chem_can('chem_orders_create') AND status = 'new');
-- التعديل: منشئ الطلبات (بيانات الطلب/إلغاء قبل التجهيز)، والكيميائي (بدء التجهيز/التسليم)
-- الانتقال لـ ready لا يتم إلا عبر chem_fulfill_prep_order
CREATE POLICY chem_prep_orders_update ON public.chem_prep_orders FOR UPDATE TO authenticated
  USING (public.chem_can('chem_orders_create') OR public.chem_can('chem_orders_prepare'))
  WITH CHECK (status IN ('new','in_progress','delivered','cancelled'));
CREATE POLICY chem_prep_orders_delete ON public.chem_prep_orders FOR DELETE TO authenticated
  USING (public.chem_can('chem_orders_create') AND status IN ('new','cancelled'));

CREATE POLICY chem_prep_order_items_insert ON public.chem_prep_order_items FOR INSERT TO authenticated WITH CHECK (
  public.chem_can('chem_orders_create') AND EXISTS (SELECT 1 FROM public.chem_prep_orders o WHERE o.id = order_id AND o.status = 'new'));
CREATE POLICY chem_prep_order_items_delete ON public.chem_prep_order_items FOR DELETE TO authenticated USING (
  public.chem_can('chem_orders_create') AND EXISTS (SELECT 1 FROM public.chem_prep_orders o WHERE o.id = order_id AND o.status IN ('new','cancelled')));

GRANT SELECT, INSERT, UPDATE, DELETE ON public.chem_prep_orders, public.chem_prep_order_items TO authenticated;
GRANT SELECT ON public.chem_prep_order_picks TO authenticated;

INSERT INTO public.changelog_entries (title, description)
SELECT '📋 الكيماويات: طلبات التجهيز',
       'المدير أو مسؤول الطلبيات يصدر طلب تجهيز كيماويات ويسنده للكيميائي (يوصله إشعار). الكيميائي يجهّز من التشغيلات المعتمدة — النظام يقترح الأقرب انتهاءً ويخصم من المخزون — ثم يُسلَّم الطلب مع ورقة تسليم وشهادات التحليل COA لكل التشغيلات المصروفة بطباعة واحدة.'
WHERE NOT EXISTS (SELECT 1 FROM public.changelog_entries WHERE title = '📋 الكيماويات: طلبات التجهيز');

COMMIT;

SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public' AND tablename LIKE 'chem_prep%' ORDER BY tablename, cmd;
