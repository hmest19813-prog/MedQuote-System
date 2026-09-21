-- ميزة "موافقة إضافة العملاء": العميل اللي يضيفه موظف (غير أدمن) يدخل بحالة "قيد المراجعة"
-- ولا يصير عميلاً رسمياً إلا بعد موافقة مدير النظام. شغّله مرة واحدة على Supabase SQL Editor.

ALTER TABLE public.customers
  ADD COLUMN IF NOT EXISTS approval_status TEXT NOT NULL DEFAULT 'approved',
  ADD COLUMN IF NOT EXISTS rejection_reason TEXT,
  ADD COLUMN IF NOT EXISTS reviewed_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS reviewed_at TIMESTAMPTZ;

ALTER TABLE public.customers DROP CONSTRAINT IF EXISTS customers_approval_status_check;
ALTER TABLE public.customers ADD CONSTRAINT customers_approval_status_check
  CHECK (approval_status IN ('pending','approved','rejected'));

-- كل العملاء الموجودين حالياً يُعتبرون موافَق عليهم مسبقاً
UPDATE public.customers SET approval_status = 'approved' WHERE approval_status IS NULL;

CREATE INDEX IF NOT EXISTS idx_customers_approval_status ON public.customers(approval_status);
