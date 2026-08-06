-- =================================================
-- Procurement Module Setup
-- Run this in Supabase SQL Editor
-- =================================================

-- 1. Suppliers
CREATE TABLE suppliers (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  code TEXT UNIQUE,
  name TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  address TEXT,
  city TEXT,
  country TEXT DEFAULT 'الاردن',
  contact_name TEXT,
  contact_phone TEXT,
  payment_terms INT DEFAULT 30,
  notes TEXT,
  is_active BOOLEAN DEFAULT true,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Purchase Orders
CREATE TABLE purchase_orders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  number TEXT UNIQUE,
  supplier_id UUID REFERENCES suppliers(id),
  supplier_name TEXT NOT NULL,
  date DATE DEFAULT CURRENT_DATE,
  expected_delivery DATE,
  status TEXT DEFAULT 'draft',
  currency TEXT DEFAULT 'JOD',
  subtotal NUMERIC(12,3) DEFAULT 0,
  tax_pct NUMERIC(5,2) DEFAULT 0,
  tax_amt NUMERIC(12,3) DEFAULT 0,
  total NUMERIC(12,3) DEFAULT 0,
  notes TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE purchase_order_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  po_id UUID REFERENCES purchase_orders(id) ON DELETE CASCADE,
  item_name TEXT NOT NULL,
  description TEXT,
  unit TEXT DEFAULT 'EACH',
  quantity NUMERIC(12,3) DEFAULT 1,
  unit_price NUMERIC(12,3) DEFAULT 0,
  tax_pct NUMERIC(5,2) DEFAULT 0,
  total NUMERIC(12,3) DEFAULT 0,
  sort_order INT DEFAULT 0
);

-- Auto-number trigger for POs
CREATE SEQUENCE IF NOT EXISTS po_number_seq START 1;

CREATE OR REPLACE FUNCTION next_po_number()
RETURNS TEXT LANGUAGE plpgsql AS $$
BEGIN
  RETURN 'PO-' || LPAD(nextval('po_number_seq')::TEXT, 4, '0');
END;
$$;

CREATE OR REPLACE FUNCTION set_po_number()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.number IS NULL OR NEW.number = '' THEN
    NEW.number := next_po_number();
  END IF;
  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_po_number
  BEFORE INSERT ON purchase_orders
  FOR EACH ROW EXECUTE FUNCTION set_po_number();

-- 3. Supplier Invoices
CREATE TABLE supplier_invoices (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  number TEXT,
  supplier_invoice_no TEXT,
  supplier_id UUID REFERENCES suppliers(id),
  supplier_name TEXT,
  po_id UUID REFERENCES purchase_orders(id),
  po_number TEXT,
  date DATE DEFAULT CURRENT_DATE,
  due_date DATE,
  status TEXT DEFAULT 'pending',
  currency TEXT DEFAULT 'JOD',
  total NUMERIC(12,3) DEFAULT 0,
  paid_amount NUMERIC(12,3) DEFAULT 0,
  notes TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 4. Supplier Payments
CREATE TABLE supplier_payments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  supplier_id UUID REFERENCES suppliers(id),
  invoice_id UUID REFERENCES supplier_invoices(id),
  date DATE DEFAULT CURRENT_DATE,
  amount NUMERIC(12,3) NOT NULL,
  method TEXT DEFAULT 'bank_transfer',
  reference TEXT,
  notes TEXT,
  created_by UUID REFERENCES profiles(id),
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 5. Enable RLS
ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchase_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE purchase_order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE supplier_payments ENABLE ROW LEVEL SECURITY;

-- 6. RLS Policies
CREATE POLICY "auth" ON suppliers
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "auth" ON purchase_orders
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "auth" ON purchase_order_items
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "auth" ON supplier_invoices
  FOR ALL TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "auth" ON supplier_payments
  FOR ALL TO authenticated USING (true) WITH CHECK (true);
