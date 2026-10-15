-- =========================================================
-- Renumber on Quote/Tender Type Change After Confirmation
-- عند تغيير نوع عرض مُعتمد (غير مسودة) بين "عرض سعر" و"عطاء محلي"
-- (من فورم التعديل العادي)، يتم تخصيص رقم جديد من التسلسل الصحيح
-- (QT أو TND) بدل الاحتفاظ بالرقم القديم من النوع السابق.
-- كما تتم مزامنة orders.quotation_number تلقائياً عند تغيّر الرقم.
-- آمن لإعادة التشغيل بالكامل (idempotent).
-- =========================================================

-- 1) تحديث trigger الاعتماد: يغطي أيضاً تبديل النوع بعد الاعتماد
--    (سابقاً كان يغطي فقط لحظة اعتماد المسودة لأول مرة)
CREATE OR REPLACE FUNCTION public.confirm_draft_quotation()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.status = 'draft' AND NEW.status != 'draft' THEN
    IF NEW.quote_type = 'tender' THEN
      NEW.number := public.generate_tender_number();
    ELSE
      NEW.number := public.generate_quotation_number();
    END IF;
  ELSIF OLD.status != 'draft' AND NEW.status != 'draft'
        AND COALESCE(NEW.quote_type,'quote') IS DISTINCT FROM COALESCE(OLD.quote_type,'quote') THEN
    IF NEW.quote_type = 'tender' THEN
      NEW.number := public.generate_tender_number();
    ELSE
      NEW.number := public.generate_quotation_number();
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2) مزامنة orders.quotation_number عند تغيّر رقم العرض/العطاء
CREATE OR REPLACE FUNCTION public.sync_order_quotation_number()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE public.orders
  SET quotation_number = NEW.number
  WHERE quotation_id = NEW.id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS quotation_number_sync_orders_trigger ON public.quotations;
CREATE TRIGGER quotation_number_sync_orders_trigger
  AFTER UPDATE ON public.quotations
  FOR EACH ROW
  WHEN (NEW.number IS DISTINCT FROM OLD.number)
  EXECUTE FUNCTION public.sync_order_quotation_number();

-- 3) تصحيح العرض QT-2026-0237 (وزارة التربية والتعليم) اللي تحوّل
--    لعطاء بدون أخذ رقم TND — يُعاد ترقيمه الآن عبر نفس تسلسل العطاءات
DO $$
DECLARE
  v_id UUID;
  v_old_number TEXT;
  v_new_number TEXT;
BEGIN
  SELECT id, number INTO v_id, v_old_number
  FROM public.quotations
  WHERE number = 'QT-2026-0237' AND quote_type = 'tender';

  IF v_id IS NOT NULL THEN
    v_new_number := public.generate_tender_number();
    UPDATE public.quotations SET number = v_new_number WHERE id = v_id;
    RAISE NOTICE 'تم ترقيم % إلى %', v_old_number, v_new_number;
  END IF;
END $$;
