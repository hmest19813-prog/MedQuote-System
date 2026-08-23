-- ============================================================
-- MedQuote Pro — Customer Auto-Number Sequence
-- شغّله في Supabase → SQL Editor
-- ============================================================

-- 1) أضف صف تسلسل العملاء في جدول number_sequences (إن لم يكن موجوداً)
INSERT INTO public.number_sequences (id, prefix, current_value, year)
VALUES ('customer', 'C', 0, EXTRACT(YEAR FROM NOW())::INTEGER)
ON CONFLICT (id) DO NOTHING;

-- 2) دالة توليد رقم العميل التلقائي (C-0001, C-0002, ...)
CREATE OR REPLACE FUNCTION public.generate_customer_number()
RETURNS TEXT AS $$
DECLARE
  next_val INTEGER;
BEGIN
  UPDATE public.number_sequences
    SET current_value = current_value + 1
    WHERE id = 'customer'
    RETURNING current_value INTO next_val;

  RETURN 'C-' || LPAD(next_val::TEXT, 4, '0');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3) منح صلاحية تشغيل الدالة للمستخدمين المصادق عليهم
GRANT EXECUTE ON FUNCTION public.generate_customer_number() TO authenticated;

-- 4) تحقق
SELECT * FROM public.number_sequences WHERE id = 'customer';
-- يجب أن يظهر صف بـ current_value = 0
