-- كتاب رسمي: طلب إضافة المؤسسة إلى قوائم الموردين (نموذج عام قابل لإعادة الاستخدام)
-- مبني على الكتاب اليدوي "اضافة مؤسستنا إلى قوائم الموردين.pdf" (كتابنا رقم 322 سابقاً)
-- شغّله على Supabase SQL Editor — سيُنشئ كتاباً جديداً برقم تسلسلي جديد داخل النظام

INSERT INTO public.official_letters (
  number, recipient, attention, date, subject, category, body,
  signer_name, signer_title, use_letterhead, is_private
) VALUES (
  (SELECT COALESCE(MAX(number), 0) + 1 FROM public.official_letters),
  'الجهات المعنية',
  'دائرة المشتريات',
  CURRENT_DATE,
  'اضافة مؤسستنا الى قائمة الموردين',
  'templates',
  '<p>تحية طيبة وبعد:</p>
<p>الرجاء التكرم بإضافة رقم مؤسستنا الى قائمة الموردين لديكم، حيث أننا مستوردون ومصدرون ومتخصصون في توريد المواد المخبرية والطبية والعلمية والمجسمات التعليمية والأثاث المخبري والمواد الكيماوية المخبرية عالية النقاوة والمستهلكات الطبية (كفوف لاتكس – مريول مستهلك – غطاء رأس – غطاء حذاء – ...).</p>
<p>لتزويدكم بأفضل الأسعار المنافسة والماركات العالمية.</p>
<table style="border-collapse:collapse;width:100%;margin:18px 0;">
  <tbody>
    <tr><td style="background:#f4f6f8;font-weight:bold;border:1.5px solid #999;padding:8px 14px;width:190px;">اسم المؤسسة</td><td style="border:1.5px solid #999;padding:8px 14px;">مؤسسة الحياة العلمية الطبية الكيماوية<br>Hayat Scientific Medical &amp; Chemicals Corp.</td></tr>
    <tr><td style="background:#f4f6f8;font-weight:bold;border:1.5px solid #999;padding:8px 14px;">جهة الاتصال</td><td style="border:1.5px solid #999;padding:8px 14px;">الدكتور محمد عقاب الجوابرة – مالك المؤسسة<br>السيد نضال المجالي – مدير المبيعات</td></tr>
    <tr><td style="background:#f4f6f8;font-weight:bold;border:1.5px solid #999;padding:8px 14px;">الهاتف الخلوي</td><td style="border:1.5px solid #999;padding:8px 14px;">0798802030 / 0795180100</td></tr>
    <tr><td style="background:#f4f6f8;font-weight:bold;border:1.5px solid #999;padding:8px 14px;">الفاكس</td><td style="border:1.5px solid #999;padding:8px 14px;">064648105</td></tr>
    <tr><td style="background:#f4f6f8;font-weight:bold;border:1.5px solid #999;padding:8px 14px;">الهاتف الأرضي</td><td style="border:1.5px solid #999;padding:8px 14px;">064659955</td></tr>
    <tr><td style="background:#f4f6f8;font-weight:bold;border:1.5px solid #999;padding:8px 14px;">الايميل</td><td style="border:1.5px solid #999;padding:8px 14px;">Sales@hmest.com</td></tr>
    <tr><td style="background:#f4f6f8;font-weight:bold;border:1.5px solid #999;padding:8px 14px;">الموقع الالكتروني</td><td style="border:1.5px solid #999;padding:8px 14px;">www.hmest.com</td></tr>
    <tr><td style="background:#f4f6f8;font-weight:bold;border:1.5px solid #999;padding:8px 14px;">العنوان</td><td style="border:1.5px solid #999;padding:8px 14px;">عمان – شارع الملك حسين</td></tr>
  </tbody>
</table>
<p>واقبلوا الاحترام والتقدير</p>',
  'الدكتور محمد عقاب الجوابرة',
  'المدير العام',
  true,
  false
);
