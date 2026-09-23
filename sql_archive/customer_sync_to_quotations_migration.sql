-- =========================================================
-- Customer -> Quotations Sync Migration
-- لما يتعدّل اسم/هاتف/عنوان عميل بصفحة العملاء، ينعكس تلقائياً
-- على كل عروض الأسعار المرتبطة فيه (customer_id) بكل الحالات
-- (مسودة/مرسل/معتمد/محوّل/فاتورة...الخ) — شغّله بـ Supabase SQL Editor
-- =========================================================

CREATE OR REPLACE FUNCTION public.sync_customer_to_quotations()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.name IS DISTINCT FROM OLD.name
     OR NEW.phone IS DISTINCT FROM OLD.phone
     OR NEW.address IS DISTINCT FROM OLD.address THEN
    UPDATE public.quotations
    SET customer_name = NEW.name,
        phone = NEW.phone,
        address = NEW.address,
        updated_at = now()
    WHERE customer_id = NEW.id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_sync_customer_to_quotations ON public.customers;

CREATE TRIGGER trg_sync_customer_to_quotations
AFTER UPDATE ON public.customers
FOR EACH ROW
EXECUTE FUNCTION public.sync_customer_to_quotations();

-- تحقق: عدد عروض الأسعار اللي بتتحدّث فوراً لو تعدّل أي عميل الآن
-- SELECT customer_id, count(*) FROM public.quotations WHERE customer_id IS NOT NULL GROUP BY customer_id;

INSERT INTO public.changelog_entries (title, description) VALUES
('مزامنة بيانات العميل مع عروض الأسعار', 'تعديل اسم أو هاتف أو عنوان العميل من صفحة العملاء بينعكس تلقائياً على كل عروض الأسعار المرتبطة فيه.');
