-- ============================================================
-- إدارة المعارض — تقييد موظف بمعرض واحد (موظف دمشق يشوف دمشق بس،
-- موظف عمان يشوف عمان بس). مبني فوق showroom_module_migration.sql
-- (لازم يكون مُشغَّل مسبقاً). آمن للتشغيل عدة مرات.
--
-- الفكرة: عمود جديد profiles.showroom_id (nullable) — لو NULL
-- الموظف بيشوف كل المعارض (نفس السلوك القديم، توافق خلفي كامل
-- لأي موظف موجود حالياً بدون تعيين). لو مُعيَّن، كل RLS policies
-- القسم بتقيّده على هذا المعرض بس. admin/manager دايماً بدون قيد
-- (نفس نمط كل صلاحيات النظام).
-- ============================================================

BEGIN;

-- ══════════════════════════════════════════════
-- 1) عمود التعيين + الدالة المساعدة
-- ══════════════════════════════════════════════
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS showroom_id uuid REFERENCES public.showrooms(id);

CREATE OR REPLACE FUNCTION public.my_showroom_id() RETURNS uuid
LANGUAGE sql STABLE SECURITY DEFINER AS $$
  SELECT showroom_id FROM public.profiles WHERE id = auth.uid();
$$;

-- ══════════════════════════════════════════════
-- 2) تحديث RLS — إضافة فحص المعرض المخصص لفرع الموظف فقط
--    (admin/manager دايماً بدون أي قيد، بنفس الشرط الموجود مسبقاً)
-- ══════════════════════════════════════════════

-- showrooms
DROP POLICY IF EXISTS showrooms_select ON public.showrooms;
CREATE POLICY showrooms_select ON public.showrooms FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showrooms_write ON public.showrooms;
CREATE POLICY showrooms_write ON public.showrooms FOR ALL TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR id = public.my_showroom_id())
  )
) WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR id = public.my_showroom_id())
  )
);

-- showroom_stock_movements
DROP POLICY IF EXISTS showroom_stock_mv_select ON public.showroom_stock_movements;
CREATE POLICY showroom_stock_mv_select ON public.showroom_stock_movements FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_stock_mv_insert ON public.showroom_stock_movements;
CREATE POLICY showroom_stock_mv_insert ON public.showroom_stock_movements FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);

-- showroom_catalog_items
DROP POLICY IF EXISTS showroom_catalog_items_select ON public.showroom_catalog_items;
CREATE POLICY showroom_catalog_items_select ON public.showroom_catalog_items FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_catalog_items_insert ON public.showroom_catalog_items;
CREATE POLICY showroom_catalog_items_insert ON public.showroom_catalog_items FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_catalog_items_delete ON public.showroom_catalog_items;
CREATE POLICY showroom_catalog_items_delete ON public.showroom_catalog_items FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);

-- showroom_cash_entries
DROP POLICY IF EXISTS showroom_cash_select ON public.showroom_cash_entries;
CREATE POLICY showroom_cash_select ON public.showroom_cash_entries FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_cash_insert ON public.showroom_cash_entries;
CREATE POLICY showroom_cash_insert ON public.showroom_cash_entries FOR INSERT TO authenticated WITH CHECK (
  ref_type IS NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
      public.has_perm('showrooms_cash') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
    )
  )
);
DROP POLICY IF EXISTS showroom_cash_delete ON public.showroom_cash_entries;
CREATE POLICY showroom_cash_delete ON public.showroom_cash_entries FOR DELETE TO authenticated USING (
  ref_type IS NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
      public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
    )
  )
);

-- showroom_purchases + items
DROP POLICY IF EXISTS showroom_purchases_select ON public.showroom_purchases;
CREATE POLICY showroom_purchases_select ON public.showroom_purchases FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_purchases_insert ON public.showroom_purchases;
CREATE POLICY showroom_purchases_insert ON public.showroom_purchases FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_purchase') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_purchases_update ON public.showroom_purchases;
CREATE POLICY showroom_purchases_update ON public.showroom_purchases FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);

DROP POLICY IF EXISTS showroom_purchase_items_rw ON public.showroom_purchase_items;
CREATE POLICY showroom_purchase_items_rw ON public.showroom_purchase_items FOR ALL TO authenticated USING (
  EXISTS (SELECT 1 FROM public.showroom_purchases p WHERE p.id = showroom_purchase_items.purchase_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
      public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR p.showroom_id = public.my_showroom_id())
    )
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.showroom_purchases p WHERE p.id = showroom_purchase_items.purchase_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
      public.has_perm('showrooms_purchase') AND (public.my_showroom_id() IS NULL OR p.showroom_id = public.my_showroom_id())
    )
  ))
);

-- showroom_stock_transfers + items (أي من الطرفين = معرض الموظف كافٍ)
DROP POLICY IF EXISTS showroom_transfers_select ON public.showroom_stock_transfers;
CREATE POLICY showroom_transfers_select ON public.showroom_stock_transfers FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_access') AND (
      public.my_showroom_id() IS NULL OR from_showroom_id = public.my_showroom_id() OR to_showroom_id = public.my_showroom_id()
    )
  )
);
DROP POLICY IF EXISTS showroom_transfers_insert ON public.showroom_stock_transfers;
CREATE POLICY showroom_transfers_insert ON public.showroom_stock_transfers FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (
      public.my_showroom_id() IS NULL OR from_showroom_id = public.my_showroom_id() OR to_showroom_id = public.my_showroom_id()
    )
  )
);

DROP POLICY IF EXISTS showroom_transfer_items_rw ON public.showroom_stock_transfer_items;
CREATE POLICY showroom_transfer_items_rw ON public.showroom_stock_transfer_items FOR ALL TO authenticated USING (
  EXISTS (SELECT 1 FROM public.showroom_stock_transfers t WHERE t.id = showroom_stock_transfer_items.transfer_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
      public.has_perm('showrooms_access') AND (
        public.my_showroom_id() IS NULL OR t.from_showroom_id = public.my_showroom_id() OR t.to_showroom_id = public.my_showroom_id()
      )
    )
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.showroom_stock_transfers t WHERE t.id = showroom_stock_transfer_items.transfer_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
      public.has_perm('showrooms_manage') AND (
        public.my_showroom_id() IS NULL OR t.from_showroom_id = public.my_showroom_id() OR t.to_showroom_id = public.my_showroom_id()
      )
    )
  ))
);

-- showroom_sales + items
DROP POLICY IF EXISTS showroom_sales_select ON public.showroom_sales;
CREATE POLICY showroom_sales_select ON public.showroom_sales FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_sales_insert ON public.showroom_sales;
CREATE POLICY showroom_sales_insert ON public.showroom_sales FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_sales_update ON public.showroom_sales;
CREATE POLICY showroom_sales_update ON public.showroom_sales FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);

DROP POLICY IF EXISTS showroom_sale_items_rw ON public.showroom_sale_items;
CREATE POLICY showroom_sale_items_rw ON public.showroom_sale_items FOR ALL TO authenticated USING (
  EXISTS (SELECT 1 FROM public.showroom_sales s WHERE s.id = showroom_sale_items.sale_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
      public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR s.showroom_id = public.my_showroom_id())
    )
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.showroom_sales s WHERE s.id = showroom_sale_items.sale_id AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
      public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR s.showroom_id = public.my_showroom_id())
    )
  ))
);

-- showroom_sale_payments
DROP POLICY IF EXISTS showroom_sale_payments_select ON public.showroom_sale_payments;
CREATE POLICY showroom_sale_payments_select ON public.showroom_sale_payments FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_sale_payments_insert ON public.showroom_sale_payments;
CREATE POLICY showroom_sale_payments_insert ON public.showroom_sale_payments FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    (public.has_perm('showrooms_sell') OR public.has_perm('showrooms_cash'))
    AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_sale_payments_delete ON public.showroom_sale_payments;
CREATE POLICY showroom_sale_payments_delete ON public.showroom_sale_payments FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);

-- showroom_activity_log
DROP POLICY IF EXISTS showroom_activity_select ON public.showroom_activity_log;
CREATE POLICY showroom_activity_select ON public.showroom_activity_log FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_access') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_activity_insert ON public.showroom_activity_log;
CREATE POLICY showroom_activity_insert ON public.showroom_activity_log FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_sell') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_activity_update ON public.showroom_activity_log;
CREATE POLICY showroom_activity_update ON public.showroom_activity_log FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);
DROP POLICY IF EXISTS showroom_activity_delete ON public.showroom_activity_log;
CREATE POLICY showroom_activity_delete ON public.showroom_activity_log FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR (
    public.has_perm('showrooms_manage') AND (public.my_showroom_id() IS NULL OR showroom_id = public.my_showroom_id())
  )
);

-- ══════════════════════════════════════════════
-- 3) تحديث الـRPCs — نفس المنطق بالضبط + فحص المعرض المخصص إضافي
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
  IF public.get_my_role() = 'employee' AND public.my_showroom_id() IS NOT NULL AND public.my_showroom_id() <> p_showroom_id THEN
    RAISE EXCEPTION 'لا يمكنك البيع لمعرض غير معرضك المخصص';
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
  IF public.get_my_role() = 'employee' AND public.my_showroom_id() IS NOT NULL
     AND public.my_showroom_id() <> p_from_showroom_id AND public.my_showroom_id() <> p_to_showroom_id THEN
    RAISE EXCEPTION 'التحويل لازم يشمل معرضك المخصص';
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

GRANT EXECUTE ON FUNCTION public.my_showroom_id() TO authenticated;

COMMIT;

-- ══════════════════════════════════════════════
-- تحقق سريع بعد التشغيل
-- ══════════════════════════════════════════════
SELECT column_name FROM information_schema.columns WHERE table_schema='public' AND table_name='profiles' AND column_name='showroom_id';
