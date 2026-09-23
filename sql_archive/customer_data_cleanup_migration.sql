-- =========================================================
-- Customer Data Cleanup — دمج العملاء المكررين وربط عروض الأسعار
-- مبني على تحليل نسخة 2026-09-19، راجع قبل التشغيل على Supabase SQL Editor
-- =========================================================

-- 1) عروض باسم عميل غير صالح (نص افتراضي/غير مفهوم) — نقلها للمحذوفات (soft delete)
UPDATE public.quotations SET deleted_at = now(), delete_reason = 'اسم العميل نص غير صالح — بانتظار تحديد الاسم الصحيح يدوياً'
WHERE id IN ('3e155eba-5c80-4fef-b02f-97d65d0e3628', '38188276-140d-475e-867a-0f0f6cb563cb', 'cf8add22-0f92-40dc-a8c5-30705b7a1a1f', '088804d1-b62b-4901-aeed-6a8088ca2309', '95434668-ce79-4841-8844-ec778967671e', '1b83cee5-3de4-4a2f-a8cc-15ba0dda7f8b');

-- 2) دمج مجموعات أسماء العملاء المكررة
UPDATE public.quotations SET customer_id = '30c5f5ec-0d68-46fe-a969-36926ac21235' WHERE id IN ('c2ece74c-a5df-4ea3-9907-e54b2e5567ad');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جامعة العلوم التطبيقية الخاصة', '5609999', '0796561845', NULL, 'احمد الخطيب', '0798802031', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('4cc7ad2e-6d20-4392-9dd9-4620851b7292', '4af39c94-fe13-43a8-87a5-ac8757dddab7', 'c9e4f3b0-9a34-44b9-8526-de6755caff8a', 'c0248ce5-a9ca-4fd9-a22b-e18817c6a56e', '1ad55ca9-9c09-4fd1-8f80-a9480b292acc', 'e18481ed-b80c-4125-acea-db1db6d820b0', '9a98bb73-7115-4577-85f3-af01a3a0619f', 'c3da5e16-1222-4ff9-b431-957b0e7db0f5', '8c3c8f4d-c0d5-4d23-b512-f160fbe92c86', '2098ef47-5c13-4983-87ab-30eed5c695ab', '03709186-b676-4295-aa9c-01bca9ff864e');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('وزارة الزراعة', NULL, NULL, NULL, 'وزارة الزراعة', NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('f04060e0-adb8-4f48-a945-f8403f1b9072', 'ef369796-a146-412c-83ea-d16715073f22', 'a84a36a9-571d-4c31-a802-1060a68f56f6', '25c98b8b-390e-48f8-872e-e6ebcdcee15a', '757da481-60a2-4ba1-8690-3fe8ad4b756e', '39cc9185-b70f-4bea-8920-62ddfa18349a', '159b3eff-123c-41f5-aaa5-42ba2031307e');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جمعية خليل الرحمن /النزهة', '0795845888', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('c54c7220-b131-41cb-a654-d9fca2056792', '25cc1d3c-32c6-44e0-964f-d26ba4b5c2fc', 'df81a005-5d86-4bd2-a92e-555c33891d12', '1032638a-9a54-49ef-bf84-0adb4862a10d');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة عجلون الثانوية', NULL, NULL, NULL, 'احمد تنيرة', '0798802031', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('d9cf0468-761e-426f-bd09-2d4d10c36f8a', '26b0da4a-95b8-4436-bfee-cd8acaaa6e62', '6cbd075c-65c8-4703-9c35-9b28f5017259', 'e5a5e969-c9f3-4764-bf44-58a3b10a8818');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('الجمعية الملكية لحماية الطبيعة', NULL, NULL, NULL, 'د صخر الزعبي', '0797120226', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('066ed790-6a7b-47bc-9420-910db757f9ea', '571baab0-3fbf-45f5-a4e8-04fcbd3c9b4b', '12964bab-fe85-4d91-9280-0aedfea8324c', '177cc1f7-6a90-46a9-8aa9-4c17cbe87089');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة شكري شعشاعة الثانوية للبنين', '0799723992', NULL, NULL, 'ا.عمار هيكل', '0799723992', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('4e22ff12-fc36-47a5-bf9c-2d40f397e5a4', 'd74b5fc3-07b4-401c-b7a2-4abf9dbebdb5', '9650ab5d-6847-4ae4-8f1b-b1f67111966b');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مديرية الخدمات الطبية الملكية', NULL, NULL, NULL, 'شعبة اجامة اللوازم', '065804804', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('95edd244-8e7a-47ce-9210-d8d3595a72fb', '279fcfac-45c9-49bb-b0c6-3fbfb5d3b5de', '599134a9-9aaa-4474-b93b-7bf606c160a8');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('Raghad Shanaa', '00962772599982', NULL, NULL, 'Raghad Shanaa', '+962 7 7259 9982', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('583f98ba-792e-4c1f-bd88-17ecceb3e37e', 'e80fc972-82c8-4672-8b1d-27160696efd3', 'f5e77a87-96d4-44cb-8149-2d1d3006e2a4');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة خليل الرحمن /التاج', '0795845888', NULL, NULL, 'احمد الخطيب', '0798802031', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('67b8d73f-9905-4d9c-8bc8-4243a05bdcea', '9c917cb1-690f-4e7d-92e3-876503bf37f6', '5366d77e-fda0-45e1-986c-c07e4773076d');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة جادورا لانتاج التبغ', NULL, NULL, NULL, 'المهندس مجدي البكري', '0785022766', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('bb458bca-2b44-4d76-b06e-b10eb89a073d', '7ed0f664-ff17-40b6-8bee-b432c2546e84', '6dcfa987-3f66-43b0-a962-3ac368c25d58');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جامعة البتراء', '00962791421819', NULL, NULL, 'السيد يوسف البيك', '0791421819', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('e183c277-4b2a-4bab-9b0f-04fc495d0df0', '8393adf5-7b94-4820-b5c6-15a488a29cdf', 'b60b5b91-107a-4b7a-9b13-1d3b2077c104');
UPDATE public.quotations SET customer_id = 'a75c3c0c-7657-4be5-9db9-8879815e77ff' WHERE id IN ('deb11bf4-fad8-4379-a302-25be8454c7b3');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس جمعية خليل الرحمن /العقبة', '0795845888', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('c4c4f0ee-27ca-47f4-a4eb-7edf5f265cb1', 'ec3cdb96-c8c8-4352-bcd2-7c70cbb7855b');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس التربية الريادية الدولية', '0790946225', NULL, NULL, 'م.داليا هياجنة', '0790946225', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('8438cd49-8fe0-4dee-a74f-97c86cea39d1', 'deec024a-7bc3-4c0d-8f16-179909ca6e68');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة عين جالوت الثانوية الشاملة للبنات', '0789002509', NULL, NULL, 'مديرة المدرسة', '0789002509', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('f4d878d5-d78e-490b-84ee-d8543494331d', 'b32128c4-36fc-46fb-903b-b5eca4fa1e38');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('اكاديمية الحضارات العالمية', '0796313353', '00962788585905', NULL, 'ا.محمد ابو زيد', '0796313353', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('94e83bde-7cec-4962-b5f2-4fd48df7411f', '24504c97-7e10-45ad-aa7e-ae225bd83435');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة المنشية الثانوية للبنات', NULL, NULL, NULL, 'م. فالنتينا', '0777887390', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('43834b6d-8fc5-42c2-95d7-03230b9dcd51', 'e4fc0dc1-ca8f-403e-84d4-099ae1bb36fb');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة الرائد العربي', NULL, NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('0262ce50-2643-4639-846d-c12e46bcdeda', 'fcea37b2-0ddd-425c-ba91-27a46f3e109c');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة اكاديمية خليل الرحمن -الصويفية', NULL, NULL, NULL, 'اسم العميل عبد الله سدر', '0795845888', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('0b18917f-364f-4dc9-b0f8-114d920b2b1c', '9317a5ab-c5c2-4e82-9486-5a74386c4fa9');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس ميار الدولية', '0797866102', NULL, NULL, 'ا ايمن زريقات', '0797866102', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('69099fc0-05fa-441c-8dce-e1332bbdb35e', 'f97c4351-f57d-4c7c-9274-eab8a5cb9701');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('اكاديمية العقبة الدولية', NULL, NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('34401865-976b-412d-bcf0-a338fde7ec3a', 'd0d295db-a990-48f6-b24b-bc5238c2f1a6');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('هيام الحويطات', '0796915584', NULL, NULL, 'هيام الحويطات', '0796915584', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('197a6420-1433-41f7-ae22-69a45dea4137', '12b7b46d-6ce9-4393-a60c-7f72f9953ee4');
WITH ins AS (INSERT INTO public.customers (name, phone, alt_phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس الدرة الشريفة', '0797446169', NULL, NULL, 'يزن', '079744169', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id IN ('5a5c1693-e636-48c5-a431-32d4cfd9670f', 'aadc5689-041e-4887-bd24-5e1b07f4d401');

-- 3) عروض ظهرت مرة وحدة بس (بدون تكرار) — عميل جديد مستقل لكل وحد
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة اجيال العلم', '0787012962', NULL, 'م.روان', '0787012962', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'c80ec6ef-13a9-43b1-968c-6a4e040b48e8';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جامعة ال البيت', NULL, NULL, 'حابس مدارمة', '0777612161', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '657021af-5471-472b-9d26-832eb910cbd2';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مصنع الخميرة', '0792221816', NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '7d636c37-c439-4ec6-9020-5e11691791b2';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة روابي الاردن للمستلزمات و الاجهزة الطبية', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'e7dec721-47fa-4b65-9d98-6519600bc45d';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة زعفران لتجارة المواد الطبية والجراحية', '0785699076', NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'c02833fb-95b8-4e6b-af6d-2104455d0623';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة الكهرباء الوطنية', '0787356764', NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '50143d1a-360b-484f-8d5a-23172401aa7d';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة مياهنا /مادبا', '0772467253', NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'e35fadc5-6138-42a1-84b2-9b2063825ee7';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جمعية مؤسسة الزكاة الأمريكية', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'db3a3d6c-b5a0-455d-a33e-1d6222455860';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جمعية هيلفيتاس السويسرية HELVETAS', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '219269a5-5fdf-4a4a-ad24-5551d478bc55';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مستودع ماعين للأدوية', '00962797552611', NULL, 'نجود الدباس', '00962797552611', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'e5f27c37-4e28-4e5b-ba71-d099a712f815';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جامعة جرش الاهلية', '0778450550', NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '79f9499f-31c6-4226-91d4-6c05ba279ab8';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس ميار الدولية الثانية', '0780985646', NULL, 'ا ايمن زريقات', '0797866102', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '3f64dbea-7e03-4be7-96f6-a8c2d7792fd6';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة القيمة المتميزة للصناعات الغذائية', '0799300301', NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '4f367a05-a990-4efe-967b-bebf1407c4e8';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس المشاهير', '0782966860', NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '5a276011-0db0-40c1-ad6d-4f9971aea927';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('الشركة الاردنية لانتاج الادوية', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '7b053b6e-5c57-4498-930d-0869cfcab2fa';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('كلية الخوارزمي الجامعية', '0796230230', NULL, 'د. محمود السنيري / خلود يغمور', '0796230230', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '628f5b23-0932-41d9-9a6c-02c9430629b3';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جامعة البترا', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'd710e082-1feb-4368-b434-e33c7156cfd6';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مؤسسة الثقافة للتجهيزات الطبية', '+962799673068', NULL, 'المومني', '+962799673068', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'b0e4cf12-2307-40b2-9dcd-1adde4a533ce';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مصنع مسك لانتاج العصير', '00962789877610', NULL, 'محمد الخليلي', '00962789877610', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'bf88f283-c70a-443f-be86-41cea9e1b5b2';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة مصعب بن عمير', '0787005464', NULL, 'قيم المختبر', '0787005464', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '0fc6d27d-04b2-49f7-94b3-e7ed32dc819c';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة اكاديمية السنار الحديثة', '00962795819875', NULL, 'بتول الامين', '00962795819875', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '396ddce5-a2f6-4e5f-8005-2263d41d5e63';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('المدارس الاردنية الدولية', '0796972176', NULL, 'م. اماني', '0796972176', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '8d865c1b-7081-4faf-b0c6-2b4877aaadb4';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة المصنع الأردني', '00962791376004', NULL, 'صفاء', '+962 7 9137 6004', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'd7f1386d-114e-4a66-81b3-a459c49478d3';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة اكاديمية خليل الرحمن /الصويفية', NULL, NULL, 'اسم العميل عبد الله سدر', '0795845888', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '86519490-e343-4c62-9cf1-a0b3f9e65317';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة البوتاس العربية', NULL, NULL, 'عماد المجالي', '0795813500', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'b07f6069-f4fd-45d7-a233-08359c0930ff';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسه الجامعة', '00962796109042', NULL, 'مختبر', '796109042', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '2fd6eab6-2df9-4475-a07a-e69b84ab41b1';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس الاتحاد', '0775466577', NULL, 'سراب الشمايلة', '0775466577', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'e6a37dc5-6f77-4e54-bd0c-b4bd293b3e3a';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة حرف لإدارة العقارات ذ.م.م', '00962799409255', NULL, 'سحر', '+962 7 9940 9255', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'ebbfb6dc-5406-4201-a482-400742de32fa';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مركز الحسين للسرطان', NULL, NULL, 'هيثم ابو عفيف', '5300460 Ext 2322', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'f5ce5f76-0b41-4b8b-973f-46877d78d3e8';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة ولدورف', '0772115215', NULL, 'م.نيفين زريقات', '0772115215', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '01a38300-d2e0-48c8-9e0f-7708b1795179';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس اكاديمية الرواد الدولية', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'bd961ba0-a82d-4b44-ba8b-263406727a78';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة ضاحية الرشيد الثانوية للبنات', NULL, NULL, 'مس ريم', '0791864444', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '7e843920-8aa9-45da-9c84-14d3741e733d';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة الباب العالي', '0795160617', NULL, 'نواف', '075160617', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '8ee0a160-8a6f-453e-811b-d0a1b8f009eb';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة الصريح الثانوية الشاملة للبنات', '0786599445', NULL, 'مديرة المدرسة', '0786599445', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '825cec29-f69f-42bb-ad96-61c6b49ca94f';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة النعيمة الثانوية الشاملة للبنات', '0772656686', NULL, 'مديرة المدرسة', '0772656686', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '93d7695b-cd0a-487f-88c4-5b9be243c4d7';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جمعية الطالب المتميز', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '91a0b45c-1141-45a8-ad35-a190bac4b5b0';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة الحصن الثانوية الشاملة للبنات', '0781188438', NULL, 'مديرة المدرسة', '0781188438', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '307e346f-5d52-4c68-84cf-990db0aed937';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس اكاديمية خليل الرحمن /العقبة', '0799922303', NULL, 'م.منال', '0799922303', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '19d8c60f-8624-43ea-9381-da3d2e0a3de2';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جامعة العلوم والتكنولوجيا الأردنية', NULL, NULL, 'المشتريات', '027201000', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '17cc4de4-2421-4231-929d-c9448693e762';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('الجمعية العلمية الملكية', '0777666512', NULL, 'ا.دريد', '0777666512', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'dada94a1-4811-439f-b325-f28336ac17bf';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مصنع جنيف للشوكولاته', NULL, NULL, 'مصنع جنيف', '07 7770 8080', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'e402fbe9-1077-4529-bcdd-1c0797297a3d';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس التربية الريادية الوطني اناث', '0795678028', NULL, 'م.ديما', '0795678028', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '6e7966ee-a676-442b-939d-afb03574901e';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('فندق كراون بلازا /البتراء', '0799827270', NULL, 'شداد المدادحة', '0799827270', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '94254ee1-e220-427c-ab89-0ae0341c5504';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة الامراء  حي عدن', '0798243536', NULL, 'م. عرفت', '0798243536', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'a7adedb1-7a12-4952-8bb0-ecf9f1b201ed';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس اكسفورد الدوليه', '0797209895', NULL, 'م.نور', '0797209895', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '5d37504c-0c8d-435d-a0d2-b60e0d5b2399';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس المجد الدوليه /عين الباشا', '0780782920', NULL, 'م.مجد يوسف', '0780782920', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '0b5c8a9e-f3e6-4f62-a961-ccc200c35bb2';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جامعة عمان العربية', '0096264791400', NULL, 'جامعة عمان العربية', '0096264791400', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '4b85de2b-71f1-442f-91de-54c1cbf836a8';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مؤسسة خالد الجبريني للسلامة المهنية', '0799382211', NULL, 'مؤسسة خالد الجبريني للسلامة المهنية', '0799382211', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '26f63b62-56f2-40a6-8d21-12de54a9a430';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('الجامعة الهاشمية', NULL, NULL, 'د اسراء الضمور', '(05) 390 3333', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '23683e39-f96e-46e5-8c1c-51d26f97bc70';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('جامعة العقبة للعلوم الطبية', NULL, NULL, 'السيد محمد الكسواني', NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '89b49bc4-0135-43a2-a74b-3861ed5d8430';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مؤسسة الف زهرة لصناعة مواد التجميل', NULL, NULL, 'ابو مالك', '0781460193', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '2a5eb008-49ab-4f3f-b30b-c18fbcb14dac';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة جرينه الثانويه للبنات', '0778477018', NULL, 'نواف', '0778477018', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '665e8eab-4dac-4ab9-a6e4-5cc0f5ccde19';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة تقنيات الطاقة الحيوية', NULL, NULL, 'ماهر الجوابرة', '0790047596', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '00f29137-aa36-4890-98b1-beaf87741161';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس اكاديمية بلاد الشام', NULL, NULL, NULL, NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '89660d2f-1cdb-4018-9a69-94f75d23a2b0';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مؤسسة سلام للتوريدات الهندسية', NULL, NULL, 'المهندس فارس المغربي', NULL, public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '64d7c0f6-74ac-4fba-8b27-0b0785dad194';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة بارما للمقاولات العامة والاستثمارات الصناعيه المحدودة', '00962797622222', NULL, 'مازن', '0797622222', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '57987f7b-9170-4eff-b77a-2f1b61b05153';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('شركة الولاء للاعاشة', '0776738421', NULL, 'ا.محمد ابو عبيلة', '0779738421', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '4f3a70b3-8aa9-43f2-85f7-3e9120bf77c0';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة النظم الحديثة بنين', '0798471159', NULL, 'اماني', '0798471159', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '997f90d3-a959-40a1-a91d-a6bfeaf18197';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة الابداع التربوي', '079965701', NULL, 'حسن', '079965701', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '2bb4e5de-003b-4531-8edf-4a3dc8cbc7b4';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدارس التربية الريادية ذكور', '0795678028', NULL, 'م.ديما', '0795678028', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '17b3c12a-b93a-44f6-9087-3164b5d55feb';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة زهرة الاشرفية الخاصة', '0798228072', NULL, 'د.جهاد ابو عادي', '0798228072', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'dfdc552f-cc42-4e38-ad47-c4c4b6e85f08';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة سحاب الثانوية', '0791943029', NULL, 'قيمة المختبر', '0791943029', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '7d90739a-2fa1-4d6c-a903-52f86a54ae25';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة ابن رشد الوطنية', '0797685828', NULL, 'ا.عباس', '0797685828', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'e83bb4f1-3eda-44f6-99ca-f0cffb95ba0f';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('كلية دي لاسال الفرير', '0788561716', NULL, 'انس فودة', '0788561716', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '8a043f55-4e9b-4edf-b14b-6bcacecac1d5';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مدرسة تماضر بنت عمرو الثانوية', '0789839542', NULL, 'م.سكينة', '0789839542', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = '384bcd57-877b-4641-bc29-2c1cb2d4c101';
WITH ins AS (INSERT INTO public.customers (name, phone, address, contact1_name, contact1_phone, customer_code) VALUES ('مؤسسة الشهب', '0795970321', NULL, 'م.خالد العطي', '0795970321', public.generate_customer_number()) RETURNING id)
UPDATE public.quotations SET customer_id = (SELECT id FROM ins) WHERE id = 'e8b7d059-e8b0-45b9-8fe5-da9f6f502bfd';

-- تحقق
SELECT count(*) AS quotations_still_unlinked FROM public.quotations WHERE customer_id IS NULL AND deleted_at IS NULL;
SELECT count(*) AS customers_total FROM public.customers;

INSERT INTO public.changelog_entries (title, description) VALUES
('تنظيف بيانات العملاء', 'دمج أسماء العملاء المكررة بعروض الأسعار القديمة في سجلات عملاء موحّدة، وربط كل عروض الأسعار السابقة بسجل عميل واحد.');
