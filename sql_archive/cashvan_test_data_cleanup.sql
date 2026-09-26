-- حذف البيانات الوهمية اللي أضافها cashvan_test_data.sql — شغّله لما تخلص من التجربة.
-- بيحذف فقط الصفوف الموسومة "TEST DATA" بحقل notes، ما بيلمس أي بيانات حقيقية.

DELETE FROM public.cashvan_sale_items
  WHERE sale_id IN (SELECT id FROM public.cashvan_sales WHERE notes LIKE 'TEST DATA%');
DELETE FROM public.cashvan_sales WHERE notes LIKE 'TEST DATA%';

DELETE FROM public.cashvan_stock_load_items
  WHERE load_id IN (SELECT id FROM public.cashvan_stock_loads WHERE notes LIKE 'TEST DATA%');
DELETE FROM public.cashvan_stock_loads WHERE notes LIKE 'TEST DATA%';

DELETE FROM public.cashvan_settlements WHERE notes LIKE 'TEST DATA%';
