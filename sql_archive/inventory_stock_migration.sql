-- ============================================================
-- ربط أمر الشراء بإدارة الأصناف (المخزون)
-- شغّله في Supabase → SQL Editor (آمن - يعمل عدة مرات بدون أخطاء)
-- ============================================================

-- 1) ربط بند أمر الشراء بصنف كتالوج حقيقي
ALTER TABLE public.purchase_order_items
  ADD COLUMN IF NOT EXISTS catalog_id UUID REFERENCES public.catalog_items(id) ON DELETE SET NULL;

-- 2) أعمدة المخزون على الكتالوج (مشتقّة تلقائياً من سجل الحركة أدناه)
ALTER TABLE public.catalog_items
  ADD COLUMN IF NOT EXISTS qty_on_hand       NUMERIC(12,3) DEFAULT 0,
  ADD COLUMN IF NOT EXISTS last_received_at  DATE,
  ADD COLUMN IF NOT EXISTS last_received_qty NUMERIC(12,3);

-- 3) سجل حركة المخزون (كل عملية توريد من أمر شراء = سطر هنا)
CREATE TABLE IF NOT EXISTS public.stock_movements (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  catalog_id    UUID NOT NULL REFERENCES public.catalog_items(id) ON DELETE CASCADE,
  po_id         UUID REFERENCES public.purchase_orders(id) ON DELETE CASCADE,
  po_number     TEXT,
  supplier_name TEXT,
  quantity      NUMERIC(12,3) NOT NULL DEFAULT 0,
  unit          TEXT,
  unit_price    NUMERIC(12,3),
  movement_date DATE DEFAULT CURRENT_DATE,
  created_by    UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  created_at    TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS stock_movements_catalog_idx ON public.stock_movements(catalog_id);
CREATE INDEX IF NOT EXISTS stock_movements_po_idx ON public.stock_movements(po_id);

ALTER TABLE public.stock_movements ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "auth" ON public.stock_movements;
CREATE POLICY "auth" ON public.stock_movements
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

GRANT ALL ON TABLE public.stock_movements TO anon, authenticated, service_role;

-- 4) إعادة احتساب رصيد الصنف تلقائياً من سجل الحركة (trigger)
CREATE OR REPLACE FUNCTION public.recompute_catalog_stock(p_catalog_id UUID)
RETURNS VOID LANGUAGE plpgsql AS $$
DECLARE
  v_qty  NUMERIC(12,3);
  v_date DATE;
  v_last NUMERIC(12,3);
BEGIN
  SELECT COALESCE(SUM(quantity),0) INTO v_qty
  FROM public.stock_movements WHERE catalog_id = p_catalog_id;

  SELECT movement_date, quantity INTO v_date, v_last
  FROM public.stock_movements
  WHERE catalog_id = p_catalog_id
  ORDER BY movement_date DESC NULLS LAST, created_at DESC
  LIMIT 1;

  UPDATE public.catalog_items
  SET qty_on_hand = v_qty, last_received_at = v_date, last_received_qty = v_last
  WHERE id = p_catalog_id;
END;
$$;

CREATE OR REPLACE FUNCTION public.trg_stock_movements_sync()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    PERFORM public.recompute_catalog_stock(OLD.catalog_id);
    RETURN OLD;
  ELSE
    PERFORM public.recompute_catalog_stock(NEW.catalog_id);
    IF TG_OP = 'UPDATE' AND OLD.catalog_id IS DISTINCT FROM NEW.catalog_id THEN
      PERFORM public.recompute_catalog_stock(OLD.catalog_id);
    END IF;
    RETURN NEW;
  END IF;
END;
$$;

DROP TRIGGER IF EXISTS trg_stock_movements_ai ON public.stock_movements;
DROP TRIGGER IF EXISTS trg_stock_movements_au ON public.stock_movements;
DROP TRIGGER IF EXISTS trg_stock_movements_ad ON public.stock_movements;

CREATE TRIGGER trg_stock_movements_ai AFTER INSERT ON public.stock_movements
  FOR EACH ROW EXECUTE FUNCTION public.trg_stock_movements_sync();
CREATE TRIGGER trg_stock_movements_au AFTER UPDATE ON public.stock_movements
  FOR EACH ROW EXECUTE FUNCTION public.trg_stock_movements_sync();
CREATE TRIGGER trg_stock_movements_ad AFTER DELETE ON public.stock_movements
  FOR EACH ROW EXECUTE FUNCTION public.trg_stock_movements_sync();

-- 5) ربط بنود أوامر الشراء القديمة بالكتالوج (مطابقة بالاسم) وتوليد سجل حركة تاريخي لها
UPDATE public.purchase_order_items poi
SET catalog_id = ci.id
FROM public.catalog_items ci
WHERE poi.catalog_id IS NULL
  AND lower(trim(poi.item_name)) = lower(trim(ci.name));

INSERT INTO public.stock_movements (catalog_id, po_id, po_number, supplier_name, quantity, unit, unit_price, movement_date, created_by)
SELECT poi.catalog_id, poi.po_id, po.number, po.supplier_name, poi.quantity, poi.unit, poi.unit_price, po.date, po.created_by
FROM public.purchase_order_items poi
JOIN public.purchase_orders po ON po.id = poi.po_id
WHERE poi.catalog_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM public.stock_movements sm
    WHERE sm.po_id = poi.po_id AND sm.catalog_id = poi.catalog_id
  );

-- تحقق من النتيجة
SELECT c.name, c.qty_on_hand, c.last_received_at
FROM public.catalog_items c
WHERE c.qty_on_hand > 0
ORDER BY c.qty_on_hand DESC
LIMIT 20;
