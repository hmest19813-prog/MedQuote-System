-- ============================================================
-- MedQuote Pro — إصلاح شامل لصلاحيات الموظفين (RLS)
--
-- المشكلة: صلاحيات الموظفين بصفحة "المستخدمين" (checkboxes) كانت
-- شكلية بالواجهة فقط — قاعدة البيانات (RLS) ما كانت تتحقق منها،
-- فكانت تحظر الموظف بغض النظر عن الصلاحية (أو بالعكس، تسمح بأي
-- عملية لأي موظف مسجّل دخول بغض النظر عن الصلاحية).
--
-- هذا الملف يربط كل صلاحية checkbox فعلياً بقاعدة البيانات.
-- شغّله كاملاً دفعة واحدة في Supabase SQL Editor.
-- ============================================================

BEGIN;

-- دالة مساعدة: التحقق من صلاحية معيّنة للمستخدم الحالي المسجّل دخول
CREATE OR REPLACE FUNCTION public.has_perm(p_key text)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT COALESCE((SELECT (permissions ->> p_key)::boolean FROM public.profiles WHERE id = auth.uid()), false);
$$;

GRANT EXECUTE ON FUNCTION public.has_perm(text) TO authenticated;


-- ══════════════════════════════════════════════
-- 1) عروض الأسعار (quotations + quotation_items)
-- ══════════════════════════════════════════════

DROP POLICY IF EXISTS quotations_insert ON public.quotations;
CREATE POLICY quotations_insert ON public.quotations FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('quotes_create'))
  )
);

DROP POLICY IF EXISTS quotations_update ON public.quotations;
CREATE POLICY quotations_update ON public.quotations FOR UPDATE USING (
  created_by = auth.uid() OR created_by IS NULL OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('quotes_edit_all'))
);

DROP POLICY IF EXISTS quotations_delete ON public.quotations;
CREATE POLICY quotations_delete ON public.quotations FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('quotes_delete'))
);

DROP POLICY IF EXISTS qitems_access ON public.quotation_items;
CREATE POLICY qitems_access ON public.quotation_items USING (
  EXISTS (SELECT 1 FROM public.quotations q WHERE q.id = quotation_items.quotation_id AND (
    q.created_by = auth.uid() OR q.created_by IS NULL OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('quotes_edit_all') OR public.has_perm('quotes_delete')))
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.quotations q WHERE q.id = quotation_items.quotation_id AND (
    q.created_by = auth.uid() OR q.created_by IS NULL OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('quotes_edit_all') OR public.has_perm('quotes_delete')))
  ))
);


-- ══════════════════════════════════════════════
-- 2) الدفعات (payments)
-- ══════════════════════════════════════════════

DROP POLICY IF EXISTS payments_delete ON public.payments;
CREATE POLICY payments_delete ON public.payments FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('payments_delete'))
);


-- ══════════════════════════════════════════════
-- 3) الكتالوج (catalog_items)
-- ══════════════════════════════════════════════

DROP POLICY IF EXISTS catalog_insert ON public.catalog_items;
CREATE POLICY catalog_insert ON public.catalog_items FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('catalog_edit'))
  )
);

DROP POLICY IF EXISTS catalog_update ON public.catalog_items;
CREATE POLICY catalog_update ON public.catalog_items FOR UPDATE USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('catalog_edit'))
);

DROP POLICY IF EXISTS catalog_delete ON public.catalog_items;
CREATE POLICY catalog_delete ON public.catalog_items FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('catalog_delete'))
);


-- ══════════════════════════════════════════════
-- 4) الكتب الرسمية (official_letters)
-- ══════════════════════════════════════════════

DROP POLICY IF EXISTS letters_delete ON public.official_letters;
CREATE POLICY letters_delete ON public.official_letters FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('letters_manage'))
);

DROP POLICY IF EXISTS letters_update ON public.official_letters;
CREATE POLICY letters_update ON public.official_letters FOR UPDATE USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('letters_manage'))
);


-- ══════════════════════════════════════════════
-- 5) الطلبات (orders + order_items)
-- ══════════════════════════════════════════════

DROP POLICY IF EXISTS orders_all_auth ON public.orders;

CREATE POLICY orders_select ON public.orders FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY orders_insert ON public.orders FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('orders_create'))
  )
);

CREATE POLICY orders_update ON public.orders FOR UPDATE USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('orders_edit'))
);

CREATE POLICY orders_delete ON public.orders FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('orders_delete'))
);

DROP POLICY IF EXISTS oitems_access ON public.order_items;

CREATE POLICY oitems_select ON public.order_items FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY oitems_write ON public.order_items FOR ALL USING (
  EXISTS (SELECT 1 FROM public.orders o WHERE o.id = order_items.order_id AND (
    o.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('orders_edit') OR public.has_perm('orders_delete')))
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.orders o WHERE o.id = order_items.order_id AND (
    o.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('orders_edit') OR public.has_perm('orders_delete')))
  ))
);


-- ══════════════════════════════════════════════
-- 6) العملاء (customers)
-- ══════════════════════════════════════════════

DROP POLICY IF EXISTS customers_all_auth ON public.customers;

CREATE POLICY customers_select ON public.customers FOR SELECT USING (auth.uid() IS NOT NULL);

CREATE POLICY customers_insert ON public.customers FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('customers_create'))
  )
);

CREATE POLICY customers_update ON public.customers FOR UPDATE USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('customers_edit'))
);

CREATE POLICY customers_delete ON public.customers FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('customers_delete'))
);


-- ══════════════════════════════════════════════
-- 7) الموردون وأوامر الشراء وفواتير/دفعات الموردين
-- ══════════════════════════════════════════════

DROP POLICY IF EXISTS auth ON public.suppliers;
CREATE POLICY suppliers_select ON public.suppliers FOR SELECT TO authenticated USING (true);
CREATE POLICY suppliers_insert ON public.suppliers FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_create'))
);
CREATE POLICY suppliers_update ON public.suppliers FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_edit'))
);
CREATE POLICY suppliers_delete ON public.suppliers FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_delete'))
);

DROP POLICY IF EXISTS auth ON public.purchase_orders;
CREATE POLICY po_select ON public.purchase_orders FOR SELECT TO authenticated USING (true);
CREATE POLICY po_insert ON public.purchase_orders FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_create'))
);
CREATE POLICY po_update ON public.purchase_orders FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_edit'))
);
CREATE POLICY po_delete ON public.purchase_orders FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_delete'))
);

DROP POLICY IF EXISTS auth ON public.purchase_order_items;
CREATE POLICY po_items_select ON public.purchase_order_items FOR SELECT TO authenticated USING (true);
CREATE POLICY po_items_write ON public.purchase_order_items FOR ALL TO authenticated USING (
  EXISTS (SELECT 1 FROM public.purchase_orders po WHERE po.id = purchase_order_items.po_id AND (
    po.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('suppliers_edit') OR public.has_perm('suppliers_delete')))
  ))
) WITH CHECK (
  EXISTS (SELECT 1 FROM public.purchase_orders po WHERE po.id = purchase_order_items.po_id AND (
    po.created_by = auth.uid() OR
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND (public.has_perm('suppliers_edit') OR public.has_perm('suppliers_delete')))
  ))
);

DROP POLICY IF EXISTS auth ON public.supplier_invoices;
CREATE POLICY supplier_invoices_select ON public.supplier_invoices FOR SELECT TO authenticated USING (true);
CREATE POLICY supplier_invoices_insert ON public.supplier_invoices FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('supplier_invoices_create'))
);
CREATE POLICY supplier_invoices_update ON public.supplier_invoices FOR UPDATE TO authenticated USING (
  created_by = auth.uid() OR
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('supplier_invoices_create'))
);
CREATE POLICY supplier_invoices_delete ON public.supplier_invoices FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager'])
);

DROP POLICY IF EXISTS auth ON public.supplier_payments;
CREATE POLICY supplier_payments_select ON public.supplier_payments FOR SELECT TO authenticated USING (true);
CREATE POLICY supplier_payments_insert ON public.supplier_payments FOR INSERT TO authenticated WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('supplier_payments_create'))
);
CREATE POLICY supplier_payments_delete ON public.supplier_payments FOR DELETE TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager'])
);


-- ══════════════════════════════════════════════
-- 8) الموارد البشرية (hr_employees / hr_salaries / hr_attendance / hr_letters)
--    كانت مفتوحة بالكامل لأي مستخدم مسجّل دخول بغض النظر عن hr_access
--    (بيانات الرواتب كانت مكشوفة لأي موظف) — الآن مقيّدة بالصلاحية
-- ══════════════════════════════════════════════

DROP POLICY IF EXISTS hr_employees_policy ON public.hr_employees;
CREATE POLICY hr_employees_policy ON public.hr_employees USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('hr_access'))
) WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('hr_access'))
);

DROP POLICY IF EXISTS hr_salaries_policy ON public.hr_salaries;
CREATE POLICY hr_salaries_policy ON public.hr_salaries USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('hr_access'))
) WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('hr_access'))
);

DROP POLICY IF EXISTS hr_attendance_policy ON public.hr_attendance;
CREATE POLICY hr_attendance_policy ON public.hr_attendance USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('hr_access'))
) WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('hr_access'))
);

DROP POLICY IF EXISTS hr_letters_policy ON public.hr_letters;
CREATE POLICY hr_letters_policy ON public.hr_letters USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('hr_access'))
) WITH CHECK (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('hr_access'))
);


-- ══════════════════════════════════════════════
-- تحقق سريع بعد التشغيل
-- ══════════════════════════════════════════════
SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('quotations','quotation_items','payments','catalog_items','official_letters',
                     'orders','order_items','customers','suppliers','purchase_orders',
                     'purchase_order_items','supplier_invoices','supplier_payments',
                     'hr_employees','hr_salaries','hr_attendance','hr_letters')
ORDER BY tablename, cmd;

COMMIT;
