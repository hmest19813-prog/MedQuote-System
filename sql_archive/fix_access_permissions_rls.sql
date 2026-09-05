-- ============================================================
-- MedQuote Pro — إحكام صلاحيات "الوصول للصفحة" (RLS)
--
-- المشكلة: صلاحيات مثل customers_access, catalog_access,
-- suppliers_access, orders_access, letters_access, activity_access,
-- tasks_access, change_requests_access, inbox_access كانت تتحكم فقط
-- بإظهار/إخفاء الصفحة والقائمة الجانبية بالواجهة. قاعدة البيانات
-- (RLS) كانت تسمح لأي مستخدم مسجّل دخول بقراءة الجدول كاملاً بغض
-- النظر عن الصلاحية — يعني موظف يفتح Console بالمتصفح ويستدعي
-- supabase مباشرة كان يقدر يجيب بيانات صفحة مخفية عنه بالكامل.
--
-- هذا الملف يقيّد القراءة (SELECT) بنفس صلاحية "الوصول" لكل صفحة،
-- بدون ما يلمس صلاحيات الإنشاء/التعديل/الحذف المفصّلة (مرتبطة
-- أصلاً بصلاحياتها الخاصة من fix_permissions_rls.sql).
--
-- archive_access و deleted_quotes_access لم يُلمَسا هون لأنهما
-- يتحكمان بعرض فرعي (عروض مؤرشفة/محذوفة) من نفس جدول quotations
-- اللي أصلاً محمي بصلاحية quotes_view_all/الملكية — لا داعي لقيد إضافي.
--
-- شغّله كاملاً دفعة واحدة في Supabase SQL Editor.
-- ============================================================

BEGIN;

-- ══════════════════════════════════════════════
-- العملاء (customers)
-- ══════════════════════════════════════════════
DROP POLICY IF EXISTS customers_select ON public.customers;
CREATE POLICY customers_select ON public.customers FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('customers_access'))
  )
);

-- ══════════════════════════════════════════════
-- الكتالوج (catalog_items)
-- ══════════════════════════════════════════════
DROP POLICY IF EXISTS catalog_select ON public.catalog_items;
CREATE POLICY catalog_select ON public.catalog_items FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('catalog_access'))
  )
);

-- ══════════════════════════════════════════════
-- الطلبات (orders + order_items)
-- ══════════════════════════════════════════════
DROP POLICY IF EXISTS orders_select ON public.orders;
CREATE POLICY orders_select ON public.orders FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('orders_access'))
  )
);

DROP POLICY IF EXISTS oitems_select ON public.order_items;
CREATE POLICY oitems_select ON public.order_items FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('orders_access'))
  )
);

-- ══════════════════════════════════════════════
-- الكتب الرسمية (official_letters) — مع الحفاظ على منطق is_private
-- ══════════════════════════════════════════════
DROP POLICY IF EXISTS letters_select ON public.official_letters;
CREATE POLICY letters_select ON public.official_letters FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('letters_access') AND (
      is_private IS NOT TRUE OR created_by = auth.uid()
    ))
  )
);

-- ══════════════════════════════════════════════
-- المشتريات والموردون (suppliers + purchase_orders + items + فواتير/دفعات الموردين)
-- ══════════════════════════════════════════════
DROP POLICY IF EXISTS suppliers_select ON public.suppliers;
CREATE POLICY suppliers_select ON public.suppliers FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_access'))
);

DROP POLICY IF EXISTS po_select ON public.purchase_orders;
CREATE POLICY po_select ON public.purchase_orders FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_access'))
);

DROP POLICY IF EXISTS po_items_select ON public.purchase_order_items;
CREATE POLICY po_items_select ON public.purchase_order_items FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_access'))
);

DROP POLICY IF EXISTS supplier_invoices_select ON public.supplier_invoices;
CREATE POLICY supplier_invoices_select ON public.supplier_invoices FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_access'))
);

DROP POLICY IF EXISTS supplier_payments_select ON public.supplier_payments;
CREATE POLICY supplier_payments_select ON public.supplier_payments FOR SELECT TO authenticated USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('suppliers_access'))
);

-- ══════════════════════════════════════════════
-- سجل النشاط (activity_logs) — الإدراج يبقى مفتوح (كل مستخدم يسجّل أفعاله تلقائياً)
-- ══════════════════════════════════════════════
DROP POLICY IF EXISTS logs_all_auth ON public.activity_logs;

CREATE POLICY logs_insert ON public.activity_logs FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY logs_select ON public.activity_logs FOR SELECT USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('activity_access'))
);

-- ══════════════════════════════════════════════
-- المهام (tasks + task_comments)
-- ══════════════════════════════════════════════
DROP POLICY IF EXISTS tasks_sel ON public.tasks;
CREATE POLICY tasks_sel ON public.tasks FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('tasks_access'))
  )
);

DROP POLICY IF EXISTS tc_sel ON public.task_comments;
CREATE POLICY tc_sel ON public.task_comments FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('tasks_access'))
  )
);

-- ══════════════════════════════════════════════
-- طلبات التعديل (change_requests + change_request_replies)
-- ══════════════════════════════════════════════
DROP POLICY IF EXISTS cr_sel ON public.change_requests;
CREATE POLICY cr_sel ON public.change_requests FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('change_requests_access'))
  )
);

DROP POLICY IF EXISTS crr_sel ON public.change_request_replies;
CREATE POLICY crr_sel ON public.change_request_replies FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('change_requests_access'))
  )
);

-- ══════════════════════════════════════════════
-- البريد الوارد (inbox_items)
-- ══════════════════════════════════════════════
DROP POLICY IF EXISTS inbox_sel ON public.inbox_items;
CREATE POLICY inbox_sel ON public.inbox_items FOR SELECT USING (
  auth.uid() IS NOT NULL AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('inbox_access'))
  )
);

-- ══════════════════════════════════════════════
-- تحقق سريع بعد التشغيل
-- ══════════════════════════════════════════════
SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public'
  AND tablename IN ('customers','catalog_items','orders','order_items','official_letters',
                     'suppliers','purchase_orders','purchase_order_items','supplier_invoices',
                     'supplier_payments','activity_logs','tasks','task_comments',
                     'change_requests','change_request_replies','inbox_items')
ORDER BY tablename, cmd;

COMMIT;
