-- ===================== كفالات العطاءات (جدول مستقل عن tender_attachments) =====================
-- يفصل الكفالات عن الملحقات العامة (احالات/أخرى) لأنها بيانات مُهيكلة: نوع الكفالة
-- (دخول/حسن تنفيذ/صيانة) + وسيلة الكفالة (كفالة بنكية/شيك مصدق/شيك غير مصدق) + أرقام وتواريخ.
-- يستخدم نفس Storage bucket (tender-attachments) الموجود أصلاً — سياسات storage.objects
-- الحالية تكفي لأنها مبنية على مجلد quote_id بالمسار وليس على اسم الجدول.

CREATE TABLE IF NOT EXISTS public.tender_guarantees (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  quote_id        uuid NOT NULL REFERENCES public.quotations(id) ON DELETE CASCADE,
  guarantee_type  text NOT NULL CHECK (guarantee_type IN ('bid','performance','maintenance')),
  instrument      text NOT NULL CHECK (instrument IN ('bank_guarantee','certified_check','uncertified_check')),
  ref_number      text,            -- رقم الكفالة / رقم الشيك
  amount          numeric(14,3),
  bank            text,            -- البنك المُصدر / البنك المسحوب عليه الشيك
  issue_date      date,
  expiry_date     date,            -- تاريخ انتهاء الكفالة — مهم للتنبيه قبل الانتهاء
  notes           text,
  file_path       text NOT NULL,
  file_name       text,
  file_size       bigint,
  mime_type       text,
  created_by      uuid REFERENCES public.profiles(id),
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_tender_guarantees_quote  ON public.tender_guarantees(quote_id);
CREATE INDEX IF NOT EXISTS idx_tender_guarantees_expiry ON public.tender_guarantees(expiry_date) WHERE expiry_date IS NOT NULL;

ALTER TABLE public.tender_guarantees ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS tg_select ON public.tender_guarantees;
CREATE POLICY tg_select ON public.tender_guarantees FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS tg_insert ON public.tender_guarantees;
CREATE POLICY tg_insert ON public.tender_guarantees FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.quotations q WHERE q.id = tender_guarantees.quote_id AND (
      q.created_by = auth.uid() OR
      public.get_my_role() = ANY (ARRAY['admin','manager']) OR
      (public.get_my_role() = 'employee' AND public.has_perm('quotes_edit_all'))
    )
  )
);

DROP POLICY IF EXISTS tg_delete ON public.tender_guarantees;
CREATE POLICY tg_delete ON public.tender_guarantees FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('quotes_delete'))
);

-- ===================== نقل أي كفالات أُدخلت سابقاً ضمن tender_attachments (قبل الفصل) =====================
-- أفضل تخمين متاح: النوع 'bid' والوسيلة 'bank_guarantee' كافتراضي، مع نقل العنوان القديم كملاحظة
INSERT INTO public.tender_guarantees (
  quote_id, guarantee_type, instrument, ref_number, amount, bank, issue_date, expiry_date, notes,
  file_path, file_name, file_size, mime_type, created_by, created_at
)
SELECT quote_id, 'bid', 'bank_guarantee', ref_number, amount, issuer, issue_date, expiry_date, title,
       file_path, file_name, file_size, mime_type, created_by, created_at
FROM public.tender_attachments
WHERE category = 'guarantee';

DELETE FROM public.tender_attachments WHERE category = 'guarantee';

-- تضييق فئات tender_attachments لتصبح احالات/أخرى فقط بعد استقلال الكفالات بجدولها
ALTER TABLE public.tender_attachments DROP CONSTRAINT IF EXISTS tender_attachments_category_check;
ALTER TABLE public.tender_attachments ADD CONSTRAINT tender_attachments_category_check CHECK (category IN ('award','other'));
