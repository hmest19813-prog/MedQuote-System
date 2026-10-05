-- ===================== ملحقات العطاءات (كفالات / احالات / ملحقات أخرى) =====================
-- يفترض وجود public.has_perm(text) و public.get_my_role() و auth.uid() — نفس الأسس المستخدمة
-- بباقي هجرات النظام (راجع cashvan_migration.sql كمرجع لنفس النمط)

CREATE TABLE IF NOT EXISTS public.tender_attachments (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  quote_id      uuid NOT NULL REFERENCES public.quotations(id) ON DELETE CASCADE,
  category      text NOT NULL DEFAULT 'other' CHECK (category IN ('guarantee','award','other')),
  title         text NOT NULL,
  file_path     text NOT NULL,
  file_name     text,
  file_size     bigint,
  mime_type     text,
  ref_number    text,            -- رقم الكفالة / رقم كتاب الاحالة
  amount        numeric(14,3),   -- قيمة الكفالة / قيمة الاحالة
  issuer        text,            -- البنك المُصدر للكفالة / الجهة المُحيلة
  issue_date    date,
  expiry_date   date,            -- تاريخ انتهاء الكفالة — مهم للتنبيه قبل الانتهاء
  notes         text,
  created_by    uuid REFERENCES public.profiles(id),
  created_at    timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_tender_attachments_quote ON public.tender_attachments(quote_id);
CREATE INDEX IF NOT EXISTS idx_tender_attachments_expiry ON public.tender_attachments(expiry_date) WHERE expiry_date IS NOT NULL;

ALTER TABLE public.tender_attachments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS ta_select ON public.tender_attachments;
CREATE POLICY ta_select ON public.tender_attachments FOR SELECT USING (auth.uid() IS NOT NULL);

DROP POLICY IF EXISTS ta_insert ON public.tender_attachments;
CREATE POLICY ta_insert ON public.tender_attachments FOR INSERT WITH CHECK (
  auth.uid() IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.quotations q WHERE q.id = tender_attachments.quote_id AND (
      q.created_by = auth.uid() OR
      public.get_my_role() = ANY (ARRAY['admin','manager']) OR
      (public.get_my_role() = 'employee' AND public.has_perm('quotes_edit_all'))
    )
  )
);

DROP POLICY IF EXISTS ta_delete ON public.tender_attachments;
CREATE POLICY ta_delete ON public.tender_attachments FOR DELETE USING (
  public.get_my_role() = ANY (ARRAY['admin','manager']) OR
  (public.get_my_role() = 'employee' AND public.has_perm('quotes_delete'))
);

-- ===================== Storage bucket (خاص — لا يُعرض بروابط عامة) =====================
INSERT INTO storage.buckets (id, name, public)
VALUES ('tender-attachments', 'tender-attachments', false)
ON CONFLICT (id) DO NOTHING;

DROP POLICY IF EXISTS ta_storage_select ON storage.objects;
CREATE POLICY ta_storage_select ON storage.objects FOR SELECT USING (
  bucket_id = 'tender-attachments' AND auth.uid() IS NOT NULL
);

DROP POLICY IF EXISTS ta_storage_insert ON storage.objects;
CREATE POLICY ta_storage_insert ON storage.objects FOR INSERT WITH CHECK (
  bucket_id = 'tender-attachments' AND auth.uid() IS NOT NULL AND EXISTS (
    SELECT 1 FROM public.quotations q WHERE q.id::text = (storage.foldername(name))[1] AND (
      q.created_by = auth.uid() OR
      public.get_my_role() = ANY (ARRAY['admin','manager']) OR
      (public.get_my_role() = 'employee' AND public.has_perm('quotes_edit_all'))
    )
  )
);

DROP POLICY IF EXISTS ta_storage_delete ON storage.objects;
CREATE POLICY ta_storage_delete ON storage.objects FOR DELETE USING (
  bucket_id = 'tender-attachments' AND (
    public.get_my_role() = ANY (ARRAY['admin','manager']) OR
    (public.get_my_role() = 'employee' AND public.has_perm('quotes_delete'))
  )
);
