-- ============================================================
-- MedQuote Pro — إدارة الكيماويات (المرحلة 1)
--
-- سجل المواد الكيميائية + أحجام العبوات + قالب المواصفات (للـCOA)
-- + وثائق المادة (MSDS / COA المورد كروابط Google Drive)
-- + الوصفات (للمحاليل والكواشف المحضّرة) ومكوّناتها.
--
-- المخزون، التشغيلات، طلبات التجهيز، وإصدار الـCOA = مراحل لاحقة.
--
-- شغّله كاملاً دفعة واحدة في Supabase SQL Editor،
-- ثم شغّل chemicals_seed.sql لتعبئة المواد والوصفات.
-- ============================================================

BEGIN;

-- ══════════════════════════════════════════════
-- ترقيم المواد التلقائي CH-0001
-- ══════════════════════════════════════════════
CREATE SEQUENCE IF NOT EXISTS public.chem_material_code_seq START 1;

CREATE OR REPLACE FUNCTION public.set_chem_material_code() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.code IS NULL OR NEW.code = '' THEN
    NEW.code := 'CH-' || LPAD(nextval('public.chem_material_code_seq')::TEXT, 4, '0');
  END IF;
  NEW.updated_at := now();
  RETURN NEW;
END;
$$;

-- ══════════════════════════════════════════════
-- المواد
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.chem_materials (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    code text UNIQUE,
    name_en text NOT NULL,
    name_ar text,
    category text DEFAULT 'chemical' CHECK (category IN ('chemical','reagent','stain','indicator','media','natural','bio')),
    production_type text DEFAULT 'repack' CHECK (production_type IN ('repack','prepare')),
    cas_no text,
    formula text,
    mol_weight numeric(10,3),
    grade text,
    physical_state text CHECK (physical_state IN ('solid','liquid','gas')),
    ghs_pictograms text[] DEFAULT '{}',
    signal_word text CHECK (signal_word IN ('danger','warning')),
    hazard_statements text,
    precautionary_statements text,
    storage_conditions text,
    shelf_life_months integer,
    manufacturer text,
    supplier_id uuid REFERENCES public.suppliers(id) ON DELETE SET NULL,
    notes text,
    is_active boolean DEFAULT true,
    created_by uuid,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);
ALTER TABLE public.chem_materials OWNER TO postgres;
CREATE UNIQUE INDEX IF NOT EXISTS chem_materials_name_uidx ON public.chem_materials (lower(name_en));

DROP TRIGGER IF EXISTS trg_set_chem_material_code ON public.chem_materials;
CREATE TRIGGER trg_set_chem_material_code BEFORE INSERT OR UPDATE ON public.chem_materials
  FOR EACH ROW EXECUTE FUNCTION public.set_chem_material_code();

-- أحجام العبوات التي تُباع (500 g، 1 L ...) — ربط اختياري بصنف الكتالوج
CREATE TABLE IF NOT EXISTS public.chem_pack_sizes (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    material_id uuid NOT NULL REFERENCES public.chem_materials(id) ON DELETE CASCADE,
    size numeric(12,3) NOT NULL,
    unit text NOT NULL DEFAULT 'g' CHECK (unit IN ('g','kg','mL','L','pcs','kit')),
    container text,
    catalog_id uuid REFERENCES public.catalog_items(id) ON DELETE SET NULL,
    is_active boolean DEFAULT true,
    created_at timestamptz DEFAULT now()
);
ALTER TABLE public.chem_pack_sizes OWNER TO postgres;
CREATE INDEX IF NOT EXISTS chem_pack_sizes_material_idx ON public.chem_pack_sizes(material_id);

-- قالب المواصفات (بنود فحص الـCOA): min = ≥، max = ≤، range = بين، text = نص (Passes test / Conforms)
CREATE TABLE IF NOT EXISTS public.chem_specs (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    material_id uuid NOT NULL REFERENCES public.chem_materials(id) ON DELETE CASCADE,
    seq integer DEFAULT 0,
    parameter text NOT NULL,
    spec_type text NOT NULL DEFAULT 'min' CHECK (spec_type IN ('min','max','range','text')),
    min_value numeric,
    max_value numeric,
    text_value text,
    unit text,
    method text,
    created_at timestamptz DEFAULT now()
);
ALTER TABLE public.chem_specs OWNER TO postgres;
CREATE INDEX IF NOT EXISTS chem_specs_material_idx ON public.chem_specs(material_id);

-- وثائق المادة: روابط Google Drive (MSDS المصنّع، COA المورد، ...)
CREATE TABLE IF NOT EXISTS public.chem_documents (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    material_id uuid NOT NULL REFERENCES public.chem_materials(id) ON DELETE CASCADE,
    doc_type text NOT NULL DEFAULT 'msds' CHECK (doc_type IN ('msds','supplier_coa','tds','other')),
    title text,
    url text NOT NULL,
    version text,
    language text DEFAULT 'en' CHECK (language IN ('en','ar')),
    issue_date date,
    review_date date,
    is_current boolean DEFAULT true,
    notes text,
    created_by uuid,
    created_at timestamptz DEFAULT now()
);
ALTER TABLE public.chem_documents OWNER TO postgres;
CREATE INDEX IF NOT EXISTS chem_documents_material_idx ON public.chem_documents(material_id);

-- ══════════════════════════════════════════════
-- الوصفات (للمواد production_type = 'prepare')
-- ══════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.chem_recipes (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    material_id uuid NOT NULL REFERENCES public.chem_materials(id) ON DELETE CASCADE,
    batch_size numeric(12,3) NOT NULL DEFAULT 1000,
    batch_unit text NOT NULL DEFAULT 'mL',
    procedure text,
    source text,
    notes text,
    status text DEFAULT 'draft' CHECK (status IN ('draft','approved')),
    approved_by uuid,
    approved_at timestamptz,
    created_by uuid,
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);
ALTER TABLE public.chem_recipes OWNER TO postgres;
-- وصفة واحدة فعّالة لكل مادة
CREATE UNIQUE INDEX IF NOT EXISTS chem_recipes_material_uidx ON public.chem_recipes(material_id);

CREATE TABLE IF NOT EXISTS public.chem_recipe_items (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    recipe_id uuid NOT NULL REFERENCES public.chem_recipes(id) ON DELETE CASCADE,
    seq integer DEFAULT 0,
    material_id uuid REFERENCES public.chem_materials(id) ON DELETE SET NULL,
    item_name text,
    quantity numeric(12,4),
    unit text,
    notes text
);
ALTER TABLE public.chem_recipe_items OWNER TO postgres;
CREATE INDEX IF NOT EXISTS chem_recipe_items_recipe_idx ON public.chem_recipe_items(recipe_id);

-- ══════════════════════════════════════════════
-- RLS — صلاحية مستقلة:
--   chemicals_access (عرض) / chemicals_edit (إضافة وتعديل)
--   chemicals_delete (حذف) / chem_recipes_approve (اعتماد الوصفات)
-- ══════════════════════════════════════════════
DO $$
DECLARE t text;
BEGIN
  FOREACH t IN ARRAY ARRAY['chem_materials','chem_pack_sizes','chem_specs','chem_documents','chem_recipes','chem_recipe_items'] LOOP
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY', t);
    EXECUTE format('ALTER TABLE ONLY public.%I REPLICA IDENTITY FULL', t);

    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', t||'_select', t);
    EXECUTE format($p$CREATE POLICY %I ON public.%I FOR SELECT TO authenticated USING (
      public.get_my_role() = ANY (ARRAY['admin','manager']) OR
      (public.get_my_role() = 'employee' AND public.has_perm('chemicals_access')))$p$, t||'_select', t);

    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', t||'_insert', t);
    EXECUTE format($p$CREATE POLICY %I ON public.%I FOR INSERT TO authenticated WITH CHECK (
      public.get_my_role() = ANY (ARRAY['admin','manager']) OR
      (public.get_my_role() = 'employee' AND public.has_perm('chemicals_edit')))$p$, t||'_insert', t);

    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', t||'_update', t);
    -- معتمد الوصفات يقدر يحدّث جدول الوصفات فقط (لتغيير الحالة لـ approved)
    EXECUTE format($p$CREATE POLICY %I ON public.%I FOR UPDATE TO authenticated USING (
      public.get_my_role() = ANY (ARRAY['admin','manager']) OR
      (public.get_my_role() = 'employee' AND (public.has_perm('chemicals_edit') OR %s)))$p$,
      t||'_update', t,
      CASE WHEN t = 'chem_recipes' THEN $c$public.has_perm('chem_recipes_approve')$c$ ELSE 'false' END);

    -- حذف البنود الفرعية (عبوات/مواصفات/مكوّنات) جزء من التعديل؛ حذف المادة/الوصفة/الوثيقة يحتاج chemicals_delete
    EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', t||'_delete', t);
    IF t IN ('chem_pack_sizes','chem_specs','chem_recipe_items') THEN
      EXECUTE format($p$CREATE POLICY %I ON public.%I FOR DELETE TO authenticated USING (
        public.get_my_role() = ANY (ARRAY['admin','manager']) OR
        (public.get_my_role() = 'employee' AND public.has_perm('chemicals_edit')))$p$, t||'_delete', t);
    ELSE
      EXECUTE format($p$CREATE POLICY %I ON public.%I FOR DELETE TO authenticated USING (
        public.get_my_role() = ANY (ARRAY['admin','manager']) OR
        (public.get_my_role() = 'employee' AND public.has_perm('chemicals_delete')))$p$, t||'_delete', t);
    END IF;

    EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON public.%I TO authenticated', t);
  END LOOP;
END $$;

GRANT USAGE, SELECT ON SEQUENCE public.chem_material_code_seq TO authenticated;

-- ══════════════════════════════════════════════
-- دليل التحديثات
-- ══════════════════════════════════════════════
INSERT INTO public.changelog_entries (title, description)
SELECT '🧪 إدارة الكيماويات', 'صفحة جديدة لسجل المواد الكيميائية: رقم CAS، الصيغة، رموز الخطر GHS، شروط التخزين، أحجام العبوات، مواصفات الفحص (أساس شهادة التحليل COA)، وروابط MSDS على Google Drive. وتبويب للوصفات يحسب كميات المكوّنات لأي حجم تحضير. تحتاج صلاحية "الوصول لإدارة الكيماويات".'
WHERE NOT EXISTS (SELECT 1 FROM public.changelog_entries WHERE title = '🧪 إدارة الكيماويات');

COMMIT;

-- ══════════════════════════════════════════════
-- تحقق سريع بعد التشغيل
-- ══════════════════════════════════════════════
SELECT tablename, policyname, cmd FROM pg_policies
WHERE schemaname = 'public' AND tablename LIKE 'chem_%'
ORDER BY tablename, cmd;
