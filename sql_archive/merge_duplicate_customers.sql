-- دمج العملاء المكررين: ترحيل كل البيانات المرتبطة (عروض أسعار، طلبات، كتب رسمية،
-- طلبات تجهيز كيماويات، عملاء محتملين محوّلين) من العملاء المكررين (losers) إلى
-- العميل المُعتمد (winner)، ثم حذف ناعم للمكررين (نفس نمط customers.deleted_at الموجود).
-- يُستخدم من تبويب "🧩 العملاء المكررون" بصفحة إدارة العملاء.

CREATE OR REPLACE FUNCTION public.merge_customers(
  p_winner_id uuid,
  p_loser_ids uuid[]
) RETURNS void
LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
DECLARE
  v_loser_id uuid;
  v_winner public.customers;
BEGIN
  IF NOT (public.get_my_role() = ANY (ARRAY['admin','manager']) OR public.has_perm('customers_delete')) THEN
    RAISE EXCEPTION 'ليس لديك صلاحية دمج العملاء';
  END IF;

  IF p_winner_id IS NULL OR p_loser_ids IS NULL OR array_length(p_loser_ids,1) IS NULL THEN
    RAISE EXCEPTION 'بيانات الدمج غير مكتملة';
  END IF;

  IF p_winner_id = ANY(p_loser_ids) THEN
    RAISE EXCEPTION 'العميل المعتمد لا يمكن أن يكون ضمن قائمة المكررين';
  END IF;

  SELECT * INTO v_winner FROM public.customers WHERE id = p_winner_id;
  IF v_winner.id IS NULL THEN
    RAISE EXCEPTION 'العميل المعتمد غير موجود';
  END IF;

  FOREACH v_loser_id IN ARRAY p_loser_ids LOOP
    -- إعادة ربط عروض الأسعار بالعميل المعتمد + تحديث البيانات المنسوخة (snapshot)
    UPDATE public.quotations
    SET customer_id = p_winner_id,
        customer_name = v_winner.name,
        phone = v_winner.phone,
        address = v_winner.address
    WHERE customer_id = v_loser_id;

    -- إعادة ربط الكتب الرسمية
    UPDATE public.official_letters SET customer_id = p_winner_id WHERE customer_id = v_loser_id;

    -- إعادة ربط طلبات تجهيز الكيماويات (إن وجدت)
    UPDATE public.chem_prep_orders SET customer_id = p_winner_id WHERE customer_id = v_loser_id;

    -- إعادة ربط العملاء المحتملين المحوَّلين سابقاً لهذا العميل
    UPDATE public.prospects SET customer_id = p_winner_id WHERE customer_id = v_loser_id;

    -- حذف ناعم للعميل المكرر
    UPDATE public.customers SET
      deleted_at = now(), deleted_by = auth.uid(),
      delete_reason = 'دمج تلقائي — تم ترحيل بياناته للعميل المعتمد: ' || v_winner.name
    WHERE id = v_loser_id;
  END LOOP;

  -- تحديث اسم العميل على الطلبيات (orders) المحوّلة من عروض أسعار صارت الآن تابعة للمعتمد
  UPDATE public.orders o
  SET customer_name = v_winner.name
  FROM public.quotations q
  WHERE o.quotation_id = q.id
    AND q.customer_id = p_winner_id
    AND o.customer_name IS DISTINCT FROM v_winner.name;
END;
$$;

GRANT EXECUTE ON FUNCTION public.merge_customers(uuid, uuid[]) TO authenticated;

INSERT INTO public.changelog_entries (title, description) VALUES
('تبويب العملاء المكررون', 'تبويب جديد بصفحة إدارة العملاء يرصد تلقائياً العملاء المكررين (تطابق هاتف أو اسم)، ويسمح باختيار السجل الصحيح ودمج كل العروض والطلبات والكتب الرسمية المرتبطة إليه، مع حذف ناعم للباقي.');
