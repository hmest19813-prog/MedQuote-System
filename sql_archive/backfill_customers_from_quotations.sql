-- ============================================================
-- ربط/إضافة العملاء بأثر رجعي من عروض الأسعار السابقة
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون تكرار)
-- ============================================================
-- المرحلة 1: لكل اسم عميل مختلف بعروض أسعار قديمة بدون customer_id:
--   - إذا كان فيه عميل بنفس الاسم مسبقاً بالكتالوج → يربط عروضه فيه
--   - إذا مش موجود → ينشئ عميل جديد له (بالاسم + آخر رقم هاتف متوفر
--     + اسم/هاتف عميل المتابعة "requester_name/requester_phone" من نفس العرض) ثم يربط عروضه فيه

DO $$
DECLARE
  r RECORD;
  v_customer_id UUID;
  v_code TEXT;
BEGIN
  FOR r IN (
    SELECT DISTINCT ON (lower(trim(customer_name)))
      trim(customer_name) AS customer_name,
      phone, requester_name, requester_phone
    FROM public.quotations
    WHERE customer_id IS NULL
      AND customer_name IS NOT NULL
      AND trim(customer_name) <> ''
    ORDER BY lower(trim(customer_name)), created_at DESC
  )
  LOOP
    SELECT id INTO v_customer_id
    FROM public.customers
    WHERE lower(trim(name)) = lower(r.customer_name)
    LIMIT 1;

    IF v_customer_id IS NULL THEN
      SELECT public.generate_customer_number() INTO v_code;
      INSERT INTO public.customers (name, phone, customer_code, contact1_name, contact1_phone)
      VALUES (
        r.customer_name, NULLIF(trim(r.phone), ''), v_code,
        NULLIF(trim(r.requester_name), ''), NULLIF(trim(r.requester_phone), '')
      )
      RETURNING id INTO v_customer_id;
    END IF;

    UPDATE public.quotations
    SET customer_id = v_customer_id
    WHERE customer_id IS NULL
      AND lower(trim(customer_name)) = lower(r.customer_name);
  END LOOP;
END $$;

-- المرحلة 2: تعبئة "عميل المتابعة" (الشخص المسؤول) + هاتفه لأي عميل مربوط بعروض أسعار
-- وما إله عميل متابعة مسجّل بعد — تغطي أيضاً العملاء اللي انضافوا بتشغيل سابق لهذا السكربت
-- قبل ما تنضاف هاي الخطوة، وأي عميل انضاف يدوياً بدون عميل متابعة.
UPDATE public.customers c
SET contact1_name  = COALESCE(c.contact1_name, sub.requester_name),
    contact1_phone = COALESCE(c.contact1_phone, sub.requester_phone)
FROM (
  SELECT DISTINCT ON (customer_id)
    customer_id,
    NULLIF(trim(requester_name), '')  AS requester_name,
    NULLIF(trim(requester_phone), '') AS requester_phone
  FROM public.quotations
  WHERE customer_id IS NOT NULL
    AND requester_name IS NOT NULL AND trim(requester_name) <> ''
  ORDER BY customer_id, created_at DESC
) sub
WHERE c.id = sub.customer_id
  AND (c.contact1_name IS NULL OR c.contact1_phone IS NULL);

-- تحقق من النتيجة
SELECT count(*) AS quotations_still_unlinked FROM public.quotations WHERE customer_id IS NULL;
SELECT count(*) AS customers_total FROM public.customers;
SELECT count(*) AS customers_without_contact FROM public.customers WHERE contact1_name IS NULL;
