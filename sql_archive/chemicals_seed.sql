-- ============================================================
-- MedQuote Pro — إدارة الكيماويات: تعبئة المواد والوصفات
-- يُشغَّل بعد chemicals_module_migration.sql. آمن لإعادة التشغيل (يتخطى الموجود).
-- 242 مادة من القائمة (255 سطر بعد إزالة التكرار والمستهلكات) + 16 مادة خام مطلوبة للوصفات
-- + 31 وصفة (حالتها مسودة — تحتاج مراجعة واعتماد مسؤول المختبر)
-- أُزيلت: Template (ليس مادة)، Capillary tube (مستهلك)، Chromatography paper (مستهلك)
-- ============================================================

BEGIN;

INSERT INTO public.chem_materials (name_en, category, production_type, cas_no, formula, grade, physical_state, notes) VALUES
  ('1-Propanol', 'chemical', 'repack', '71-23-8', 'C3H8O', NULL, 'liquid', NULL),
  ('2,6-Dichlorophenolindophenol Sodium Salt (DCPIP)', 'indicator', 'repack', '620-45-1', 'C12H6Cl2NNaO2', NULL, 'solid', 'الاسم الأصلي بالقائمة: 2,6-Dichlorophenolindophenol'),
  ('Gum Arabic (Acacia)', 'natural', 'repack', '9000-01-5', NULL, NULL, 'solid', 'الاسم الأصلي بالقائمة: Acacia Gum'),
  ('Acetaldehyde', 'chemical', 'repack', '75-07-0', 'C2H4O', NULL, 'liquid', NULL),
  ('Acetic Acid', 'chemical', 'repack', '64-19-7', 'C2H4O2', NULL, 'liquid', NULL),
  ('Acetone', 'chemical', 'repack', '67-64-1', 'C3H6O', NULL, 'liquid', 'الاسم الأصلي بالقائمة: Aceton'),
  ('Acid-Fast Stain Kit (Ziehl-Neelsen)', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Acid-Fast Stain'),
  ('Activated Carbon', 'chemical', 'repack', '7440-44-0', 'C', NULL, 'solid', NULL),
  ('Alpha-Naphthol Solution 5%', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Alpha-Naphthol Solution'),
  ('Aluminium Oxide', 'chemical', 'repack', '1344-28-1', 'Al2O3', NULL, 'solid', NULL),
  ('Aluminium Potassium Sulfate Dodecahydrate (Potash Alum)', 'chemical', 'repack', '7784-24-9', 'KAl(SO4)2·12H2O', NULL, 'solid', 'دُمجت من: Aluminium Potassium Sulfate Dodecahydrate + Potassium Aluminium Sulfate'),
  ('Aluminium Hydroxide', 'chemical', 'repack', '21645-51-2', 'Al(OH)3', NULL, 'solid', NULL),
  ('Ammonia Solution', 'chemical', 'repack', '1336-21-6', 'NH4OH', NULL, 'liquid', NULL),
  ('Ammonium Oxalate Monohydrate', 'chemical', 'repack', '6009-70-7', '(NH4)2C2O4·H2O', NULL, 'solid', 'الاسم الأصلي بالقائمة: Ammonium Oxalate monohydate'),
  ('Ammonium Chloride', 'chemical', 'repack', '12125-02-9', 'NH4Cl', NULL, 'solid', NULL),
  ('Ammonium Dichromate', 'chemical', 'repack', '7789-09-5', '(NH4)2Cr2O7', NULL, 'solid', NULL),
  ('Ammonium Sulfate', 'chemical', 'repack', '7783-20-2', '(NH4)2SO4', NULL, 'solid', NULL),
  ('Ammonium Thiocyanate', 'chemical', 'repack', '1762-95-4', 'NH4SCN', NULL, 'solid', NULL),
  ('Arachis Oil (Peanut Oil)', 'natural', 'repack', '8002-03-7', NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Arachis Oil'),
  ('Ascorbic Acid', 'chemical', 'repack', '50-81-7', 'C6H8O6', 'Laboratory grade', 'solid', 'الاسم الأصلي بالقائمة: Ascorbic Acid Lab Grade'),
  ('Barium Hydroxide', 'chemical', 'repack', NULL, 'Ba(OH)2', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Barium Oxide', 'chemical', 'repack', '1304-28-5', 'BaO', NULL, 'solid', NULL),
  ('Barium Carbonate', 'chemical', 'repack', '513-77-9', 'BaCO3', NULL, 'solid', 'الاسم الأصلي بالقائمة: Barium Carbonate Dihydrate — صُحّحت: كربونات الباريوم لا يوجد منها Dihydrate'),
  ('Barium Sulfate', 'chemical', 'repack', '7727-43-7', 'BaSO4', NULL, 'solid', 'الاسم الأصلي بالقائمة: Barium Sulphate'),
  ('Barium Nitrate', 'chemical', 'repack', '10022-31-8', 'Ba(NO3)2', NULL, 'solid', NULL),
  ('Benedict''s Reagent', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Benedict’s Reagent'),
  ('Benzoic Acid', 'chemical', 'repack', '65-85-0', 'C7H6O2', NULL, 'solid', NULL),
  ('Biuret Reagent', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Bromine Water', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Buffer Solution pH 6.0', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Buffer Solution ph6'),
  ('Calcium Nitrate', 'chemical', 'repack', NULL, 'Ca(NO3)2', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Calcium Oxide', 'chemical', 'repack', '1305-78-8', 'CaO', NULL, 'solid', NULL),
  ('Cobalt(II) Chloride Hexahydrate', 'chemical', 'repack', '7791-13-1', 'CoCl2·6H2O', NULL, 'solid', 'دُمجت من: COBALT CHLORIDE HEXAHYDRATE + cobalt chloride'),
  ('Copper(I) Iodide', 'chemical', 'repack', '7681-65-4', 'CuI', NULL, 'solid', 'الاسم الأصلي بالقائمة: COPPER IODIDE'),
  ('Copper(II) Nitrate', 'chemical', 'repack', NULL, 'Cu(NO3)2', NULL, 'solid', 'الاسم الأصلي بالقائمة: COPPER NITRATE — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Cyclohexane', 'chemical', 'repack', '110-82-7', 'C6H12', NULL, 'liquid', NULL),
  ('Cadmium Oxalate Trihydrate', 'chemical', 'repack', NULL, 'CdC2O4·3H2O', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Calcium Acetate', 'chemical', 'repack', NULL, 'Ca(CH3COO)2', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Calcium Carbide', 'chemical', 'repack', '75-20-7', 'CaC2', NULL, 'solid', NULL),
  ('Calcium Carbonate Precipitated', 'chemical', 'repack', '471-34-1', 'CaCO3', NULL, 'solid', 'الاسم الأصلي بالقائمة: Calcium Carbonate, Precipitated'),
  ('Calcium Chloride Fused (Anhydrous)', 'chemical', 'repack', '10043-52-4', 'CaCl2', NULL, 'solid', 'الاسم الأصلي بالقائمة: Calcium Chloride Fused'),
  ('Calcium Lactate', 'chemical', 'repack', NULL, 'C6H10CaO6', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Calcium Metal', 'chemical', 'repack', '7440-70-2', 'Ca', NULL, 'solid', NULL),
  ('Calcium Chloride Dihydrate', 'chemical', 'repack', '10035-04-8', 'CaCl2·2H2O', NULL, 'solid', NULL),
  ('Calcium Hydroxide', 'chemical', 'repack', '1305-62-0', 'Ca(OH)2', NULL, 'solid', NULL),
  ('Capsule Stain Kit (Anthony''s)', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Capsule Stain'),
  ('Carbol Fuchsin Solution', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Carbon Tetrachloride', 'chemical', 'repack', '56-23-5', 'CCl4', NULL, 'liquid', 'الاسم الأصلي بالقائمة: Carbon Tetra Chloride'),
  ('Chloroform', 'chemical', 'repack', '67-66-3', 'CHCl3', 'Laboratory grade', 'liquid', 'الاسم الأصلي بالقائمة: Chloroform Lab Grade'),
  ('Chromium(VI) Oxide (Chromium Trioxide)', 'chemical', 'repack', '1333-82-0', 'CrO3', NULL, 'solid', 'الاسم الأصلي بالقائمة: Chromium trioxide'),
  ('Citric Acid', 'chemical', 'repack', NULL, 'C6H8O7', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Copper(II) Chloride Dihydrate', 'chemical', 'repack', '10125-13-0', 'CuCl2·2H2O', NULL, 'solid', 'الاسم الأصلي بالقائمة: Copper ll Chloride dihydrate'),
  ('Copper(II) Oxide', 'chemical', 'repack', '1317-38-0', 'CuO', NULL, 'solid', NULL),
  ('Copper(II) Sulfate Anhydrous', 'chemical', 'repack', '7758-98-7', 'CuSO4', NULL, 'solid', 'الاسم الأصلي بالقائمة: Copper(II) Sulfate Andhydrous'),
  ('Copper(II) Sulfate Pentahydrate', 'chemical', 'repack', '7758-99-8', 'CuSO4·5H2O', NULL, 'solid', NULL),
  ('Counter Stain (Safranin)', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Counter Stain'),
  ('Crystal Violet', 'stain', 'repack', '548-62-9', 'C25H30ClN3', NULL, 'solid', NULL),
  ('D-Sorbitol', 'chemical', 'repack', '50-70-4', 'C6H14O6', NULL, 'solid', NULL),
  ('Decolorizer Solution (Acetone-Alcohol)', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Decolorizer Solution'),
  ('Diethyl Ether', 'chemical', 'repack', '60-29-7', 'C4H10O', NULL, 'liquid', NULL),
  ('Emulsifying Wax', 'natural', 'repack', NULL, NULL, NULL, 'solid', NULL),
  ('Eosin Y Stain', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Ethanol Absolute', 'chemical', 'repack', '64-17-5', 'C2H5OH', 'LR', 'liquid', 'الاسم الأصلي بالقائمة: Ethanol Absolute LR'),
  ('Ethyl Acetate', 'chemical', 'repack', '141-78-6', 'C4H8O2', NULL, 'liquid', NULL),
  ('Methyl Ethyl Ketone (2-Butanone)', 'chemical', 'repack', '78-93-3', 'C4H8O', NULL, 'liquid', 'الاسم الأصلي بالقائمة: Ethyl Methyl Ketone'),
  ('Fehling''s Solution A', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: FEHLING A'),
  ('Gentian Violet', 'stain', 'repack', '548-62-9', NULL, NULL, 'solid', NULL),
  ('Glycerol', 'chemical', 'repack', '56-81-5', 'C3H8O3', NULL, 'liquid', NULL),
  ('Gram Stain Kit', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', 'دُمجت من: Gram Stain Kit + gram stain'),
  ('Gram''s Iodine', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Gram''s Iodine Stain'),
  ('Hydrogen Peroxide', 'chemical', 'repack', '7722-84-1', 'H2O2', NULL, 'liquid', NULL),
  ('India Ink', 'stain', 'repack', NULL, NULL, NULL, 'liquid', NULL),
  ('Indigo Carmine', 'stain', 'repack', '860-22-0', 'C16H8N2Na2O8S2', NULL, 'solid', 'الاسم الأصلي بالقائمة: Indigo Carmine Stain'),
  ('Iodine Crystals', 'chemical', 'repack', '7553-56-2', 'I2', NULL, 'solid', 'الاسم الأصلي بالقائمة: Iodine Crystal'),
  ('Iron(III) Nitrate', 'chemical', 'repack', NULL, 'Fe(NO3)3', NULL, 'solid', 'الاسم الأصلي بالقائمة: Iron (III) Nitrate — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Iron(III) Chloride Anhydrous', 'chemical', 'repack', '7705-08-0', 'FeCl3', NULL, 'solid', 'الاسم الأصلي بالقائمة: Iron III Chloride anhydrous'),
  ('Iron(III) Chloride Hexahydrate', 'chemical', 'repack', '10025-77-1', 'FeCl3·6H2O', NULL, 'solid', NULL),
  ('Isopropyl Alcohol', 'chemical', 'repack', '67-63-0', 'C3H8O', NULL, 'liquid', 'الاسم الأصلي بالقائمة: Iso propyl alcohol'),
  ('Kovac''s Reagent', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Lead(II) Bromide', 'chemical', 'repack', '10031-22-8', 'PbBr2', NULL, 'solid', NULL),
  ('Lead(II) Nitrate', 'chemical', 'repack', '10099-74-8', 'Pb(NO3)2', NULL, 'solid', NULL),
  ('Lead(II) Sulfate', 'chemical', 'repack', '7446-14-2', 'PbSO4', NULL, 'solid', NULL),
  ('Lithium Bromide Anhydrous', 'chemical', 'repack', '7550-35-8', 'LiBr', NULL, 'solid', NULL),
  ('Lithium Chloride', 'chemical', 'repack', '7447-41-8', 'LiCl', NULL, 'solid', NULL),
  ('Litmus Solution Blue', 'indicator', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Litmus Blue Solution'),
  ('Litmus Solution Red', 'indicator', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Litmus Red Solution'),
  ('Lugol''s Iodine', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Lugol_s Iodine'),
  ('Methyl Red', 'indicator', 'repack', '493-52-7', 'C15H15N3O2', NULL, 'solid', NULL),
  ('Magnesium Chloride', 'chemical', 'repack', NULL, 'MgCl2', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Magnesium Sulfate', 'chemical', 'repack', NULL, 'MgSO4', NULL, 'solid', 'الاسم الأصلي بالقائمة: Magnesium Sulphate — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Magnesium Nitrate', 'chemical', 'repack', NULL, 'Mg(NO3)2', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Magnesium Oxide', 'chemical', 'repack', '1309-48-4', 'MgO', NULL, 'solid', NULL),
  ('Malachite Green', 'stain', 'repack', NULL, NULL, NULL, 'solid', NULL),
  ('Marble Chips', 'chemical', 'repack', '471-34-1', 'CaCO3', NULL, 'solid', NULL),
  ('Mercury(II) Chloride', 'chemical', 'repack', '7487-94-7', 'HgCl2', NULL, 'solid', 'الاسم الأصلي بالقائمة: Mercury ll Chloride'),
  ('Methanol', 'chemical', 'repack', '67-56-1', 'CH3OH', NULL, 'liquid', NULL),
  ('Methyl Blue', 'stain', 'repack', '28983-56-4', NULL, NULL, 'solid', NULL),
  ('Millon''s Reagent', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Millons reagent'),
  ('Naphthalene', 'chemical', 'repack', '91-20-3', 'C10H8', NULL, 'solid', NULL),
  ('Nickel(II) Chloride', 'chemical', 'repack', NULL, 'NiCl2', NULL, 'solid', 'الاسم الأصلي بالقائمة: Nickel chloride — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Nitric Acid', 'chemical', 'repack', '7697-37-2', 'HNO3', NULL, 'liquid', NULL),
  ('Potassium Chromate', 'chemical', 'repack', '7789-00-6', 'K2CrO4', NULL, 'solid', NULL),
  ('Potassium Dichromate', 'chemical', 'repack', '7778-50-9', 'K2Cr2O7', NULL, 'solid', NULL),
  ('Potassium Sulfate', 'chemical', 'repack', '7778-80-5', 'K2SO4', NULL, 'solid', 'الاسم الأصلي بالقائمة: POTASSIUM SULPHATE'),
  ('Peppermint Oil', 'natural', 'repack', '8006-90-4', NULL, NULL, 'liquid', NULL),
  ('Petroleum Ether 60-80 °C', 'chemical', 'repack', '8032-32-4', NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Petroleum Ether, Boiling range 60-80'),
  ('Phenol', 'chemical', 'repack', '108-95-2', 'C6H6O', 'Laboratory grade', 'solid', 'الاسم الأصلي بالقائمة: Phenol Lab Grade'),
  ('Polyethylene Glycol (PEG)', 'chemical', 'repack', '25322-68-3', NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: PolyEthylene Glycol'),
  ('Potassium Chloride', 'chemical', 'repack', '7447-40-7', 'KCl', NULL, 'solid', NULL),
  ('Potassium Ferricyanide', 'chemical', 'repack', '13746-66-2', 'K3[Fe(CN)6]', NULL, 'solid', NULL),
  ('Potassium Hydrogen Phthalate', 'chemical', 'repack', '877-24-7', 'C8H5KO4', NULL, 'solid', NULL),
  ('Potassium Hydroxide', 'chemical', 'repack', '1310-58-3', 'KOH', NULL, 'solid', NULL),
  ('Potassium Hydroxide Solution', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Potassium Iodate', 'chemical', 'repack', '7758-05-6', 'KIO3', NULL, 'solid', NULL),
  ('Potassium Iodide', 'chemical', 'repack', '7681-11-0', 'KI', NULL, 'solid', 'دُمجت من: Potassium Iodide 1kg + Potassium Iodide 500gm'),
  ('Potassium Permanganate', 'chemical', 'repack', '7722-64-7', 'KMnO4', NULL, 'solid', NULL),
  ('Potassium Bisulfate', 'chemical', 'repack', '7646-93-7', 'KHSO4', NULL, 'solid', 'الاسم الأصلي بالقائمة: Potassium biSulphate'),
  ('Potassium Bicarbonate', 'chemical', 'repack', '298-14-6', 'KHCO3', NULL, 'solid', NULL),
  ('Potassium Carbonate', 'chemical', 'repack', '584-08-7', 'K2CO3', NULL, 'solid', NULL),
  ('Potassium Chloride Solution', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Potassium Nitrate', 'chemical', 'repack', '7757-79-1', 'KNO3', NULL, 'solid', NULL),
  ('Propylene Glycol', 'chemical', 'repack', '57-55-6', 'C3H8O2', NULL, 'liquid', NULL),
  ('Quinine Sulfate', 'chemical', 'repack', NULL, NULL, NULL, 'solid', 'الاسم الأصلي بالقائمة: Quinine sulphate'),
  ('Red Food Color', 'chemical', 'repack', NULL, NULL, NULL, 'liquid', NULL),
  ('Sabouraud Dextrose Agar (SDA)', 'media', 'repack', NULL, NULL, NULL, 'solid', 'الاسم الأصلي بالقائمة: SAB Powder'),
  ('Safranin Stain', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Salicylic Acid', 'chemical', 'repack', '69-72-7', 'C7H6O3', NULL, 'solid', NULL),
  ('Silicon Dioxide', 'chemical', 'repack', '7631-86-9', 'SiO2', NULL, 'solid', NULL),
  ('Sodium Bisulfite', 'chemical', 'repack', '7631-90-5', 'NaHSO3', NULL, 'solid', NULL),
  ('Sodium Metabisulfite', 'chemical', 'repack', '7681-57-4', 'Na2S2O5', NULL, 'solid', 'الاسم الأصلي بالقائمة: SODIUM METABISULPHITE'),
  ('Sodium Oxalate', 'chemical', 'repack', '62-76-0', 'Na2C2O4', NULL, 'solid', NULL),
  ('Trisodium Phosphate Hydrate', 'chemical', 'repack', NULL, 'Na3PO4·xH2O', NULL, 'solid', 'الاسم الأصلي بالقائمة: SODIUM PHOSPHATE TRIBASIC HYDRATE — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Sodium Thiocyanate', 'chemical', 'repack', '540-72-7', 'NaSCN', NULL, 'solid', NULL),
  ('Stearic Acid', 'chemical', 'repack', '57-11-4', 'C18H36O2', NULL, 'solid', NULL),
  ('Strontium Carbonate', 'chemical', 'repack', '1633-05-2', 'SrCO3', NULL, 'solid', NULL),
  ('Silver Metal', 'chemical', 'repack', '7440-22-4', 'Ag', NULL, 'solid', NULL),
  ('Silver Nitrate', 'chemical', 'repack', '7761-88-8', 'AgNO3', NULL, 'solid', NULL),
  ('Sodium Alginate', 'chemical', 'repack', '9005-38-3', NULL, NULL, 'solid', NULL),
  ('Sodium Carbonate Anhydrous', 'chemical', 'repack', '497-19-8', 'Na2CO3', NULL, 'solid', 'دُمجت من: Sodium Carbonate + Sodium Carbonate Anhydrous'),
  ('Sodium Chloride', 'chemical', 'repack', '7647-14-5', 'NaCl', NULL, 'solid', NULL),
  ('Trisodium Citrate', 'chemical', 'repack', NULL, 'Na3C6H5O7', NULL, 'solid', 'دُمجت من: Sodium Citrate + trisodium citrate — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Sodium Fluoride', 'chemical', 'repack', '7681-49-4', 'NaF', NULL, 'solid', 'الاسم الأصلي بالقائمة: Sodium Floride'),
  ('Sodium Hydrogen Carbonate (Sodium Bicarbonate)', 'chemical', 'repack', '144-55-8', 'NaHCO3', NULL, 'solid', 'الاسم الأصلي بالقائمة: Sodium Hydrogen Carbonate'),
  ('Sodium Hydroxide', 'chemical', 'repack', '1310-73-2', 'NaOH', NULL, 'solid', NULL),
  ('Sodium Hydroxide Solution', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Sodium Lauryl Sulfate', 'chemical', 'repack', '151-21-3', 'C12H25NaO4S', NULL, 'solid', NULL),
  ('Sodium Silicate', 'chemical', 'repack', '1344-09-8', NULL, NULL, 'liquid', NULL),
  ('Sodium Sulfate Anhydrous', 'chemical', 'repack', '7757-82-6', 'Na2SO4', NULL, 'solid', NULL),
  ('Sodium Hypochlorite Solution', 'chemical', 'repack', '7681-52-9', 'NaOCl', NULL, 'liquid', 'الاسم الأصلي بالقائمة: Sodium hypochlorite'),
  ('Sodium Polyacrylate', 'chemical', 'repack', '9003-04-7', NULL, NULL, 'solid', NULL),
  ('Sodium Thiosulfate', 'chemical', 'repack', NULL, 'Na2S2O3', NULL, 'solid', 'الاسم الأصلي بالقائمة: Sodium thiosulphate — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Spore Stain Kit (Schaeffer-Fulton)', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Spore Stain Kit'),
  ('Starch', 'chemical', 'repack', '9005-25-8', NULL, 'Laboratory grade', 'solid', 'الاسم الأصلي بالقائمة: Starch Lab Grade'),
  ('Starch Soluble', 'chemical', 'repack', '9005-84-9', NULL, NULL, 'solid', NULL),
  ('Strontium Chloride', 'chemical', 'repack', NULL, 'SrCl2', NULL, 'solid', 'دُمجت من: Strntium chloride + strontium chloride — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Strontium Nitrate', 'chemical', 'repack', '10042-76-9', 'Sr(NO3)2', NULL, 'solid', NULL),
  ('Sucrose', 'chemical', 'repack', '57-50-1', 'C12H22O11', NULL, 'solid', NULL),
  ('Sulfur', 'chemical', 'repack', '7704-34-9', 'S', NULL, 'solid', NULL),
  ('Tartaric Acid', 'chemical', 'repack', '87-69-4', 'C4H6O6', NULL, 'solid', NULL),
  ('Trypsin', 'bio', 'repack', '9002-07-7', NULL, NULL, 'solid', NULL),
  ('Toluene', 'chemical', 'repack', '108-88-3', 'C7H8', NULL, 'liquid', NULL),
  ('Gallic Acid (3,4,5-Trihydroxybenzoic Acid)', 'chemical', 'repack', NULL, 'C7H6O5', NULL, 'solid', 'الاسم الأصلي بالقائمة: Trihydroxybenzoic acid — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Tween 20 (Polysorbate 20)', 'chemical', 'repack', '9005-64-5', NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Tween 20'),
  ('Vanadium(V) Oxide', 'chemical', 'repack', '1314-62-1', 'V2O5', NULL, 'solid', 'الاسم الأصلي بالقائمة: Vanadium V Oxide'),
  ('White Vinegar', 'natural', 'repack', NULL, NULL, NULL, 'liquid', 'دُمجت من: Vinegar + white vinegar'),
  ('Voges-Proskauer Reagent (VP-B, 40% KOH)', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: Voges Proskauer reagent'),
  ('White Beeswax', 'natural', 'repack', '8012-89-3', NULL, NULL, 'solid', 'الاسم الأصلي بالقائمة: White bees wax'),
  ('Xylene', 'chemical', 'repack', '1330-20-7', 'C8H10', NULL, 'liquid', NULL),
  ('Zinc Chloride Anhydrous', 'chemical', 'repack', '7646-85-7', 'ZnCl2', NULL, 'solid', NULL),
  ('Zinc Nitrate', 'chemical', 'repack', NULL, 'Zn(NO3)2', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Zinc Granulated', 'chemical', 'repack', '7440-66-6', 'Zn', NULL, 'solid', NULL),
  ('Zinc Sulfate Heptahydrate', 'chemical', 'repack', '7446-20-0', 'ZnSO4·7H2O', NULL, 'solid', 'دُمجت من: Zinc sulphate + Zink Sulfate Heptahydrate'),
  ('Zinc Metal', 'chemical', 'repack', '7440-66-6', 'Zn', NULL, 'solid', 'الاسم الأصلي بالقائمة: Zink Metal'),
  ('Aluminium Metal', 'chemical', 'repack', '7429-90-5', 'Al', NULL, 'solid', NULL),
  ('Ammonium Nitrate', 'chemical', 'repack', '6484-52-2', 'NH4NO3', NULL, 'solid', NULL),
  ('Barium Acetate', 'chemical', 'repack', '543-80-6', 'Ba(CH3COO)2', NULL, 'solid', NULL),
  ('Barium Chloride', 'chemical', 'repack', NULL, 'BaCl2', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Bromophenol Blue', 'indicator', 'repack', '115-39-9', 'C19H10Br4O5S', NULL, 'solid', NULL),
  ('Bromothymol Blue', 'indicator', 'repack', '76-59-5', 'C27H28Br2O5S', NULL, 'solid', NULL),
  ('Almond Oil', 'natural', 'repack', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: butter almond oil — ⚠️ بالقائمة butter almond oil — تأكد: Sweet أو Bitter'),
  ('Carbomer', 'chemical', 'repack', NULL, NULL, NULL, 'solid', NULL),
  ('Castor Oil', 'natural', 'repack', '8001-79-4', NULL, NULL, 'liquid', NULL),
  ('Cetyl Alcohol', 'chemical', 'repack', '36653-82-4', 'C16H34O', NULL, 'solid', NULL),
  ('Carboxymethyl Cellulose Sodium (CMC)', 'chemical', 'repack', '9004-32-4', NULL, NULL, 'solid', 'الاسم الأصلي بالقائمة: cmc'),
  ('Coffee Oil', 'natural', 'repack', NULL, NULL, NULL, 'liquid', NULL),
  ('Congo Red', 'indicator', 'repack', '573-58-0', 'C32H22N6Na2O6S2', NULL, 'solid', NULL),
  ('Copper Filings', 'chemical', 'repack', '7440-50-8', 'Cu', NULL, 'solid', 'الاسم الأصلي بالقائمة: copper filling'),
  ('Copper(II) Hydroxide', 'chemical', 'repack', '20427-59-2', 'Cu(OH)2', NULL, 'solid', 'الاسم الأصلي بالقائمة: copper hydroxide'),
  ('Copper(II) Bromide', 'chemical', 'repack', '7789-45-9', 'CuBr2', NULL, 'solid', 'الاسم الأصلي بالقائمة: copper ll bromide'),
  ('Disodium Tetraborate (Borax)', 'chemical', 'repack', NULL, 'Na2B4O7', NULL, 'solid', 'الاسم الأصلي بالقائمة: diSodium tetra Borate — حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Fehling''s Solution B', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: fehling b'),
  ('Formalin (Formaldehyde Solution)', 'chemical', 'repack', '50-00-0', 'CH2O', NULL, 'liquid', 'الاسم الأصلي بالقائمة: formalin'),
  ('Formic Acid', 'chemical', 'repack', '64-18-6', 'CH2O2', NULL, 'liquid', NULL),
  ('Giemsa Stain', 'stain', 'repack', '51811-82-6', NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: geimsa stain'),
  ('Gelatin', 'bio', 'repack', '9000-70-8', NULL, NULL, 'solid', NULL),
  ('n-Hexane', 'chemical', 'repack', '110-54-3', 'C6H14', NULL, 'liquid', 'الاسم الأصلي بالقائمة: hexane'),
  ('1-Hexanol', 'chemical', 'repack', '111-27-3', 'C6H14O', NULL, 'liquid', 'الاسم الأصلي بالقائمة: hexanol'),
  ('Hydrochloric Acid', 'chemical', 'repack', '7647-01-0', 'HCl', NULL, 'liquid', NULL),
  ('Immersion Oil', 'natural', 'repack', NULL, NULL, NULL, 'liquid', NULL),
  ('Iron Metal', 'chemical', 'repack', '7439-89-6', 'Fe', NULL, 'solid', NULL),
  ('Lead Metal', 'chemical', 'repack', '7439-92-1', 'Pb', NULL, 'solid', NULL),
  ('Lime Water', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Magnesium Hydroxide', 'chemical', 'repack', '1309-42-8', 'Mg(OH)2', NULL, 'solid', NULL),
  ('Magnesium Metal', 'chemical', 'repack', '7439-95-4', 'Mg', NULL, 'solid', NULL),
  ('Menthol Oil', 'natural', 'repack', NULL, NULL, NULL, 'liquid', NULL),
  ('Methyl Orange', 'indicator', 'repack', '547-58-0', 'C14H14N3NaO3S', NULL, 'solid', NULL),
  ('Molisch Reagent', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', NULL),
  ('Nutrient Agar', 'media', 'repack', NULL, NULL, NULL, 'solid', NULL),
  ('Orange Peel Powder', 'natural', 'repack', NULL, NULL, NULL, 'solid', NULL),
  ('Oxalic Acid', 'chemical', 'repack', NULL, 'C2H2O4', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Paraffin Oil (Liquid Paraffin)', 'natural', 'repack', '8012-95-1', NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: paraffin oil'),
  ('Phenol Red', 'indicator', 'repack', '143-74-8', 'C19H14O5S', NULL, 'solid', NULL),
  ('Phenolphthalein', 'indicator', 'repack', '77-09-8', 'C20H14O4', NULL, 'solid', NULL),
  ('Phosphate (unspecified)', 'chemical', 'repack', NULL, NULL, NULL, 'solid', 'الاسم الأصلي بالقائمة: phosphate — ⚠️ الاسم بالقائمة غير محدد — حدّد نوع الفوسفات'),
  ('Phosphoric Acid', 'chemical', 'repack', '7664-38-2', 'H3PO4', NULL, 'liquid', NULL),
  ('Potassium Metal', 'chemical', 'repack', '7440-09-7', 'K', NULL, 'solid', 'الاسم الأصلي بالقائمة: potassium'),
  ('Potassium Thiocyanate', 'chemical', 'repack', '333-20-0', 'KSCN', NULL, 'solid', NULL),
  ('Povidone (PVP)', 'chemical', 'repack', '9003-39-8', NULL, NULL, 'solid', 'الاسم الأصلي بالقائمة: povidone'),
  ('Rosehip Oil', 'natural', 'repack', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: rose hip oil'),
  ('Rosewood Oil', 'natural', 'repack', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: rose wood oil'),
  ('Saccharin', 'chemical', 'repack', '81-07-2', 'C7H5NO3S', NULL, 'solid', NULL),
  ('Silica Gel Blue (Indicating)', 'chemical', 'repack', NULL, NULL, NULL, 'solid', 'الاسم الأصلي بالقائمة: silicagel blue'),
  ('Sodium Metal', 'chemical', 'repack', '7440-23-5', 'Na', NULL, 'solid', 'الاسم الأصلي بالقائمة: sodium'),
  ('Sodium Acetate', 'chemical', 'repack', NULL, 'CH3COONa', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Sodium Bromide', 'chemical', 'repack', '7647-15-6', 'NaBr', NULL, 'solid', NULL),
  ('Sodium Iodide', 'chemical', 'repack', '7681-82-5', 'NaI', NULL, 'solid', NULL),
  ('Sodium Nitrate', 'chemical', 'repack', '7631-99-4', 'NaNO3', NULL, 'solid', NULL),
  ('Soft Paraffin (Vaseline)', 'natural', 'repack', '8009-03-8', NULL, NULL, 'solid', 'دُمجت من: soft paraffin + vasline'),
  ('Spermaceti', 'natural', 'repack', NULL, NULL, NULL, 'solid', NULL),
  ('Strontium Oxide', 'chemical', 'repack', '1314-11-0', 'SrO', NULL, 'solid', NULL),
  ('Sudan III Solution', 'stain', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: sudan 3 solution'),
  ('Sulfamic Acid', 'chemical', 'repack', '5329-14-6', 'H3NSO3', NULL, 'solid', NULL),
  ('Sulfuric Acid', 'chemical', 'repack', '7664-93-9', 'H2SO4', NULL, 'liquid', NULL),
  ('Thymolphthalein Indicator Solution', 'indicator', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: thymolphthalein indicator'),
  ('Tollens'' Reagent', 'reagent', 'prepare', NULL, NULL, NULL, 'liquid', 'الاسم الأصلي بالقائمة: tollens reagent'),
  ('Trichloroacetic Acid', 'chemical', 'repack', '76-03-9', 'C2HCl3O2', NULL, 'solid', 'الاسم الأصلي بالقائمة: trichloro acetic acid'),
  ('Triethanolamine', 'chemical', 'repack', '102-71-6', 'C6H15NO3', NULL, 'liquid', 'الاسم الأصلي بالقائمة: triethanol amine'),
  ('Xanthan Gum', 'natural', 'repack', '11138-66-2', NULL, NULL, 'solid', NULL),
  ('XLD Agar', 'media', 'repack', NULL, NULL, NULL, 'solid', NULL),
  ('Yeast', 'bio', 'repack', NULL, NULL, NULL, 'solid', NULL),
  ('Zinc Acetate', 'chemical', 'repack', NULL, 'Zn(CH3COO)2', NULL, 'solid', 'حدّد الشكل المائي (hydrate) ورقم CAS حسب عبوة المصنّع'),
  ('Zinc Oxide', 'chemical', 'repack', '1314-13-2', 'ZnO', NULL, 'solid', NULL),
  ('Distilled Water', 'chemical', 'repack', '7732-18-5', 'H2O', NULL, 'liquid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Potassium Sodium Tartrate Tetrahydrate (Rochelle Salt)', 'chemical', 'repack', '6381-59-5', 'KNaC4H4O6·4H2O', NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('p-Dimethylaminobenzaldehyde', 'chemical', 'repack', '100-10-7', 'C9H11NO', NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Isoamyl Alcohol', 'chemical', 'repack', '123-51-3', 'C5H12O', NULL, 'liquid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('alpha-Naphthol', 'chemical', 'repack', '90-15-3', 'C10H8O', NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Basic Fuchsin', 'stain', 'repack', '632-99-5', NULL, NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Methylene Blue', 'stain', 'repack', '61-73-4', 'C16H18ClN3S', NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Safranin O', 'stain', 'repack', '477-73-6', 'C20H19ClN4', NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Eosin Y', 'stain', 'repack', '17372-87-1', 'C20H6Br4Na2O5', NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Sudan III', 'stain', 'repack', '85-86-9', 'C22H16N4O', NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Litmus', 'indicator', 'repack', '1393-92-6', NULL, NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Thymolphthalein', 'indicator', 'repack', '125-20-2', 'C28H30O4', NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Potassium Dihydrogen Phosphate', 'chemical', 'repack', '7778-77-0', 'KH2PO4', NULL, 'solid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Bromine', 'chemical', 'repack', '7726-95-6', 'Br2', NULL, 'liquid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Mercury', 'chemical', 'repack', '7439-97-6', 'Hg', NULL, 'liquid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات'),
  ('Ethanol 95%', 'chemical', 'repack', '64-17-5', 'C2H5OH', NULL, 'liquid', 'مادة خام أُضيفت لأنها مطلوبة بالوصفات')
ON CONFLICT ((lower(name_en))) DO NOTHING;

-- Benedict's Reagent
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', '1) أذب سترات الصوديوم وكربونات الصوديوم في ~800 mL ماء مقطّر دافئ مع التحريك، ثم رشّح إن لزم.
2) أذب كبريتات النحاس في ~100 mL ماء مقطّر.
3) أضف محلول النحاس ببطء مع التحريك المستمر إلى المحلول الأول.
4) أكمل الحجم إلى 1000 mL بالماء المقطّر وامزج.', 'Benedict S.R., J. Biol. Chem. 5:485 (1909) — Benedict''s qualitative reagent', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Benedict''s Reagent')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Copper(II) Sulfate Pentahydrate', 17.3::numeric, 'g', NULL),
    (1, 'Trisodium Citrate', 173::numeric, 'g', 'dihydrate'),
    (2, 'Sodium Carbonate Anhydrous', 100::numeric, 'g', NULL),
    (3, 'Distilled Water', 1000::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Benedict''s Reagent'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Fehling's Solution A
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', 'أذب كبريتات النحاس في ماء مقطّر (يمكن إضافة قطرات من حمض الكبريتيك لمنع التعكّر) وأكمل إلى 1000 mL.', 'Standard Fehling''s solution A (34.64 g CuSO4·5H2O / 500 mL) — e.g. Vogel''s Textbook of Quantitative Chemical Analysis', 'يُمزج مع المحلول B بنسبة 1:1 عند الاستعمال فقط', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Fehling''s Solution A')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Copper(II) Sulfate Pentahydrate', 69.28::numeric, 'g', NULL),
    (1, 'Distilled Water', 1000::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Fehling''s Solution A'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Fehling's Solution B
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', 'أذب ملح روشيل وهيدروكسيد الصوديوم في ماء مقطّر (التفاعل طارد للحرارة — برّد) ثم أكمل إلى 1000 mL.', 'Standard Fehling''s solution B (173 g Rochelle salt + 50 g NaOH / 500 mL) — Vogel', 'يُحفظ في عبوة بلاستيك (قلوي قوي)', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Fehling''s Solution B')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Potassium Sodium Tartrate Tetrahydrate (Rochelle Salt)', 346::numeric, 'g', NULL),
    (1, 'Sodium Hydroxide', 100::numeric, 'g', NULL),
    (2, 'Distilled Water', 1000::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Fehling''s Solution B'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Biuret Reagent
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', '1) أذب كبريتات النحاس وملح روشيل في 500 mL ماء مقطّر.
2) أضف مع التحريك 300 mL من محلول NaOH 10%.
3) أكمل الحجم إلى 1000 mL. يُحفظ في عبوة بلاستيك.', 'Gornall A.G. et al., J. Biol. Chem. 177:751 (1949)', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Biuret Reagent')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Copper(II) Sulfate Pentahydrate', 1.5::numeric, 'g', NULL),
    (1, 'Potassium Sodium Tartrate Tetrahydrate (Rochelle Salt)', 6.0::numeric, 'g', NULL),
    (2, 'Sodium Hydroxide', 30::numeric, 'g', 'على شكل 300 mL محلول 10%'),
    (3, 'Distilled Water', 1000::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Biuret Reagent'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Lugol's Iodine
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', 'أذب يوديد البوتاسيوم في ~100 mL ماء أولاً، ثم أضف اليود وحرّك حتى الذوبان التام، وأكمل إلى 1000 mL. يُحفظ في عبوة عنبرية.', 'Strong Iodine Solution (Lugol''s) 5% I2 / 10% KI — USP', 'للاختبار المدرسي للنشا يمكن تخفيفه 1:10', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Lugol''s Iodine')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Iodine Crystals', 50::numeric, 'g', NULL),
    (1, 'Potassium Iodide', 100::numeric, 'g', NULL),
    (2, 'Distilled Water', 1000::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Lugol''s Iodine'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Gram's Iodine
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 300, 'mL', 'اطحن اليود مع يوديد البوتاسيوم، أذبهما في كمية قليلة من الماء ثم أكمل إلى 300 mL. عبوة عنبرية.', 'Gram''s iodine (1 g I2, 2 g KI, 300 mL water) — standard microbiology stain protocols (e.g. ASM Gram stain protocol)', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Gram''s Iodine')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Iodine Crystals', 1::numeric, 'g', NULL),
    (1, 'Potassium Iodide', 2::numeric, 'g', NULL),
    (2, 'Distilled Water', 300::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Gram''s Iodine'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Kovac's Reagent
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'أذب p-DMAB في الكحول الأيزوأميلي (تسخين لطيف في حمام مائي إن لزم)، برّد ثم أضف حمض الهيدروكلوريك المركّز ببطء. يُحفظ في عبوة عنبرية بالثلاجة.', 'FDA Bacteriological Analytical Manual (BAM) — Reagent R38 Kovacs'' reagent', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Kovac''s Reagent')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'p-Dimethylaminobenzaldehyde', 5::numeric, 'g', NULL),
    (1, 'Isoamyl Alcohol', 75::numeric, 'mL', NULL),
    (2, 'Hydrochloric Acid', 25::numeric, 'mL', 'مركّز')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Kovac''s Reagent'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Alpha-Naphthol Solution 5%
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'أذب ألفا-نفثول في الإيثانول المطلق وأكمل إلى 100 mL. عبوة عنبرية، بالثلاجة.', 'FDA BAM — Reagent R89 Voges-Proskauer test reagents (solution 1)', 'هو نفسه VP-A', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Alpha-Naphthol Solution 5%')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'alpha-Naphthol', 5::numeric, 'g', NULL),
    (1, 'Ethanol Absolute', 100::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Alpha-Naphthol Solution 5%'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Voges-Proskauer Reagent (VP-B, 40% KOH)
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'أذب KOH في ماء مقطّر مع التبريد (طارد للحرارة) وأكمل إلى 100 mL. عبوة بلاستيك.', 'FDA BAM — Reagent R89 Voges-Proskauer test reagents (solution 2)', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Voges-Proskauer Reagent (VP-B, 40% KOH)')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Potassium Hydroxide', 40::numeric, 'g', NULL),
    (1, 'Distilled Water', 100::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Voges-Proskauer Reagent (VP-B, 40% KOH)'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Molisch Reagent
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'أذب ألفا-نفثول في الإيثانول 95% وأكمل إلى 100 mL. يُحضّر بكميات صغيرة (يتأكسد).', 'Molisch reagent: 5% α-naphthol in ethanol — standard carbohydrate test', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Molisch Reagent')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'alpha-Naphthol', 5::numeric, 'g', NULL),
    (1, 'Ethanol 95%', 100::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Molisch Reagent'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Millon's Reagent
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 60, 'mL', 'تحت خزانة الغازات: أذب الزئبق في حمض النتريك المركّز (يتصاعد NO2)، ثم خفّف بضعف حجمه من الماء المقطّر واترك ليركد وانقل الرائق.', 'Millon''s reagent: 1 part Hg in 2 parts HNO3 (w/w), diluted with 2 volumes water — classical protein test', '⚠️ شديد السمّية (زئبق) — يلزم مراجعة وإجراءات سلامة', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Millon''s Reagent')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Mercury', 10::numeric, 'g', NULL),
    (1, 'Nitric Acid', 14::numeric, 'mL', 'مركّز (~20 g)'),
    (2, 'Distilled Water', 40::numeric, 'mL', 'ضعف حجم المحلول')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Millon''s Reagent'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Tollens' Reagent
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'يُصرف كمحلول A (نترات الفضة 5%). عند الاستعمال فقط: 2 mL من A + قطرة NaOH 10% + محلول أمونيا 2% قطرة قطرة حتى يذوب الراسب.', 'Tollens'' test — standard qualitative organic analysis procedure', '⚠️ الكاشف الجاهز لا يُخزّن أبداً (يكوّن مركبات فضة متفجرة) — يُصرف كمحاليل منفصلة', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Tollens'' Reagent')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Silver Nitrate', 5::numeric, 'g', 'محلول A: 5% AgNO3'),
    (1, 'Distilled Water', 100::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Tollens'' Reagent'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Lime Water
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', 'أضف هيدروكسيد الكالسيوم للماء المقطّر، رجّ جيداً واترك ليلة ليركد، ثم رشّح أو انقل الرائق إلى عبوة محكمة (يمتص CO2 من الهواء).', 'Saturated calcium hydroxide solution (~1.7 g/L at 20 °C)', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Lime Water')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Calcium Hydroxide', 2::numeric, 'g', 'فائض للتشبّع'),
    (1, 'Distilled Water', 1000::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Lime Water'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Bromine Water
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'تحت خزانة الغازات: أضف البروم إلى الماء المقطّر ورجّ حتى التشبّع (يبقى أثر بروم غير ذائب بالقاع). عبوة عنبرية بسدادة زجاجية.', 'Saturated bromine water (~3.4 g Br2 / 100 mL at 20 °C)', '⚠️ البروم أكّال وسام الأبخرة', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Bromine Water')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Bromine', 1::numeric, 'mL', '~3.1 g'),
    (1, 'Distilled Water', 100::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Bromine Water'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Buffer Solution pH 6.0
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', 'امزج 250 mL من KH2PO4 0.2 M مع 28 mL من NaOH 0.2 M وأكمل إلى 1000 mL. تحقّق بجهاز pH واضبط إلى 6.0 ± 0.05.', 'USP — Buffer Solutions: Phosphate buffer pH 6.0 (50 mL 0.2 M KH2PO4 + 5.6 mL 0.2 M NaOH → 200 mL)', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Buffer Solution pH 6.0')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Potassium Dihydrogen Phosphate', 6.805::numeric, 'g', '250 mL من 0.2 M'),
    (1, 'Sodium Hydroxide', 0.224::numeric, 'g', '28 mL من 0.2 M'),
    (2, 'Distilled Water', 1000::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Buffer Solution pH 6.0'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Carbol Fuchsin Solution
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'أذب الفوكسين القاعدي في 10 mL إيثانول 95%. أذب الفينول في 95 mL ماء مقطّر. امزج المحلولين واتركهما يوماً ثم رشّح.', 'Ziehl-Neelsen carbol fuchsin — CDC/WHO AFB microscopy manuals', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Carbol Fuchsin Solution')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Basic Fuchsin', 0.3::numeric, 'g', NULL),
    (1, 'Ethanol 95%', 10::numeric, 'mL', NULL),
    (2, 'Phenol', 5::numeric, 'g', 'مذاب'),
    (3, 'Distilled Water', 95::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Carbol Fuchsin Solution'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Safranin Stain
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'أذب السافرانين في الإيثانول (محلول مخزون 2.5%) ثم خفّف بالماء إلى 100 mL.', 'Gram safranin counterstain (10 mL of 2.5% alcoholic stock + 90 mL water) — ASM Gram stain protocol', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Safranin Stain')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Safranin O', 0.25::numeric, 'g', NULL),
    (1, 'Ethanol 95%', 10::numeric, 'mL', NULL),
    (2, 'Distilled Water', 90::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Safranin Stain'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Counter Stain (Safranin)
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'نفس وصفة Safranin Stain.', 'Gram safranin counterstain — ASM Gram stain protocol', 'مطابقة لـ Safranin Stain — ممكن توحيدهم', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Counter Stain (Safranin)')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Safranin O', 0.25::numeric, 'g', NULL),
    (1, 'Ethanol 95%', 10::numeric, 'mL', NULL),
    (2, 'Distilled Water', 90::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Counter Stain (Safranin)'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Decolorizer Solution (Acetone-Alcohol)
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'امزج الإيثانول والأسيتون بنسبة 1:1. عبوة محكمة بعيداً عن اللهب.', 'Gram decolorizer acetone-alcohol 1:1 — ASM Gram stain protocol', 'قابل للاشتعال', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Decolorizer Solution (Acetone-Alcohol)')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Ethanol 95%', 50::numeric, 'mL', NULL),
    (1, 'Acetone', 50::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Decolorizer Solution (Acetone-Alcohol)'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Gram Stain Kit
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1, 'kit', 'تجميع: عبوة من كل محلول بنفس الحجم (مثلاً 4 × 100 mL) مع ملصق وتعليمات الاستعمال.', 'Gram stain (Hucker modification) — ASM', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Gram Stain Kit')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Crystal Violet', 1::numeric, 'عبوة', 'محلول Hucker: 2 g في 20 mL إيثانول 95% + 0.8 g أوكزالات الأمونيوم في 80 mL ماء'),
    (1, 'Gram''s Iodine', 1::numeric, 'عبوة', NULL),
    (2, 'Decolorizer Solution (Acetone-Alcohol)', 1::numeric, 'عبوة', NULL),
    (3, 'Safranin Stain', 1::numeric, 'عبوة', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Gram Stain Kit'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Acid-Fast Stain Kit (Ziehl-Neelsen)
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1, 'kit', 'تجميع: كاربول فوكسين + كحول حمضي 3% + ميثيلين بلو 0.3%.', 'Ziehl-Neelsen — WHO Laboratory Manual for AFB microscopy', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Acid-Fast Stain Kit (Ziehl-Neelsen)')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Carbol Fuchsin Solution', 1::numeric, 'عبوة', NULL),
    (1, 'Hydrochloric Acid', 3::numeric, 'mL', 'Acid-alcohol: 3 mL HCl + 97 mL إيثانول 95%'),
    (2, 'Ethanol 95%', 97::numeric, 'mL', 'لـ Acid-alcohol'),
    (3, 'Methylene Blue', 0.3::numeric, 'g', 'Counterstain 0.3% في 100 mL ماء')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Acid-Fast Stain Kit (Ziehl-Neelsen)'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Spore Stain Kit (Schaeffer-Fulton)
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1, 'kit', 'تجميع: ملكيت أخضر 5% مائي + سافرانين.', 'Schaeffer-Fulton endospore stain — ASM protocol', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Spore Stain Kit (Schaeffer-Fulton)')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Malachite Green', 5::numeric, 'g', '5% مائي في 100 mL'),
    (1, 'Distilled Water', 100::numeric, 'mL', NULL),
    (2, 'Safranin Stain', 1::numeric, 'عبوة', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Spore Stain Kit (Schaeffer-Fulton)'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Capsule Stain Kit (Anthony's)
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1, 'kit', 'تجميع: كريستال فايوليت 1% + كبريتات النحاس 20%.', 'Anthony''s capsule stain — ASM protocol', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Capsule Stain Kit (Anthony''s)')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Crystal Violet', 1::numeric, 'g', '1% مائي في 100 mL'),
    (1, 'Copper(II) Sulfate Pentahydrate', 20::numeric, 'g', '20% مائي في 100 mL'),
    (2, 'Distilled Water', 200::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Capsule Stain Kit (Anthony''s)'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Eosin Y Stain
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'أذب الإيوسين في الماء المقطّر (يمكن إضافة قطرة حمض خليك لتقوية اللون) ورشّح.', 'Eosin Y 1% aqueous — standard histology staining', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Eosin Y Stain')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Eosin Y', 1::numeric, 'g', NULL),
    (1, 'Distilled Water', 100::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Eosin Y Stain'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Sudan III Solution
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'أذب Sudan III في الإيثانول 70% (مشبّع)، اترك يومين مع الرجّ ثم رشّح.', 'Sudan III saturated in 70% ethanol — standard lipid stain', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Sudan III Solution')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Sudan III', 0.5::numeric, 'g', NULL),
    (1, 'Ethanol 95%', 70::numeric, 'mL', NULL),
    (2, 'Distilled Water', 30::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Sudan III Solution'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Litmus Solution Blue
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'اغلِ الليتموس في الماء المقطّر بضع دقائق، برّد ورشّح.', 'Litmus indicator solution — standard school laboratory preparation', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Litmus Solution Blue')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Litmus', 1::numeric, 'g', NULL),
    (1, 'Distilled Water', 100::numeric, 'mL', NULL)
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Litmus Solution Blue'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Litmus Solution Red
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'حضّر محلول الليتموس الأزرق ثم أضف HCl مخفّف قطرة قطرة حتى يتحوّل للأحمر.', 'Litmus indicator solution — standard school laboratory preparation', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Litmus Solution Red')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Litmus', 1::numeric, 'g', NULL),
    (1, 'Distilled Water', 100::numeric, 'mL', NULL),
    (2, 'Hydrochloric Acid', NULL::numeric, 'قطرات', 'مخفّف حتى اللون الأحمر')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Litmus Solution Red'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Thymolphthalein Indicator Solution
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 100, 'mL', 'أذب الثيمولفثالين في الإيثانول وأكمل إلى 100 mL.', 'Thymolphthalein solution 0.1% w/v in ethanol — BP/Ph. Eur. reagents', NULL, 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Thymolphthalein Indicator Solution')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Thymolphthalein', 0.1::numeric, 'g', NULL),
    (1, 'Ethanol 95%', 100::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Thymolphthalein Indicator Solution'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Sodium Hydroxide Solution
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', 'أذب NaOH تدريجياً في ~700 mL ماء مع التبريد، ثم أكمل إلى 1000 mL. عبوة بلاستيك.', '1 M NaOH (40.00 g/L)', 'التركيز افتراضي 1 M — عدّل حسب التركيز المطلوب', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Sodium Hydroxide Solution')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Sodium Hydroxide', 40::numeric, 'g', 'لتركيز 1 M'),
    (1, 'Distilled Water', 1000::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Sodium Hydroxide Solution'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Potassium Hydroxide Solution
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', 'أذب KOH تدريجياً في ~700 mL ماء مع التبريد، ثم أكمل إلى 1000 mL. عبوة بلاستيك.', '1 M KOH (56.11 g/L)', 'التركيز افتراضي 1 M — عدّل حسب التركيز المطلوب', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Potassium Hydroxide Solution')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Potassium Hydroxide', 56.11::numeric, 'g', 'لتركيز 1 M'),
    (1, 'Distilled Water', 1000::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Potassium Hydroxide Solution'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

-- Potassium Chloride Solution
INSERT INTO public.chem_recipes (material_id, batch_size, batch_unit, procedure, source, notes, status)
SELECT id, 1000, 'mL', 'أذب KCl في ماء مقطّر وأكمل إلى 1000 mL.', '1 M KCl (74.55 g/L)', 'التركيز افتراضي 1 M — لمحلول حفظ أقطاب pH يُستعمل 3 M (223.7 g/L)', 'draft'
FROM public.chem_materials WHERE lower(name_en) = lower('Potassium Chloride Solution')
ON CONFLICT (material_id) DO NOTHING;
INSERT INTO public.chem_recipe_items (recipe_id, seq, material_id, item_name, quantity, unit, notes)
SELECT r.id, v.seq, m.id, v.name, v.qty, v.unit, v.note
FROM (VALUES
    (0, 'Potassium Chloride', 74.55::numeric, 'g', 'لتركيز 1 M'),
    (1, 'Distilled Water', 1000::numeric, 'mL', 'إلى الحجم النهائي')
  ) AS v(seq, name, qty, unit, note)
JOIN public.chem_recipes r ON r.material_id = (SELECT id FROM public.chem_materials WHERE lower(name_en) = lower('Potassium Chloride Solution'))
LEFT JOIN public.chem_materials m ON lower(m.name_en) = lower(v.name)
WHERE NOT EXISTS (SELECT 1 FROM public.chem_recipe_items i WHERE i.recipe_id = r.id);

COMMIT;

-- تحقق
SELECT production_type, category, count(*) FROM public.chem_materials GROUP BY 1,2 ORDER BY 1,2;
SELECT count(*) AS recipes, (SELECT count(*) FROM public.chem_recipe_items) AS recipe_items,
       (SELECT count(*) FROM public.chem_recipe_items WHERE material_id IS NULL) AS unlinked_items FROM public.chem_recipes;
