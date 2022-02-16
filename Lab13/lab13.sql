CREATE TABLE lab13.sample (
  Row_id int,
  Order_id int,
  Order_data date,
  Order_priority varchar,
  Order_quantity int,
  Sales numeric(10,2),
  Discount numeric(10,2),
  Ship_mode varchar,
  Profit numeric(10,2),
  Unit_price numeric(10,2),
  Shipping_cost numeric(10,2),
  Customer_name varchar,
  Province varchar,
  Region varchar,
  Customer_segment varchar,
  Product_category varchar,
  Product_sub_category varchar,
  Product_name varchar,
  Product_container varchar,
  Product_basa_margin numeric(10,2),
  Ship_date date ) ;
--

\COPY lab13.sample FROM '~/BD/13/sample.csv' DELIMITER ';' CSV ;  --kopiowanie danych z lokalnego pliku sample.csv umieszczonego w katalogu domowym

    --1--
--v1--
with cte as(
SELECT product_name, customer_name, COUNT(*), SUM(sales) FROM lab13.sample GROUP BY product_name, customer_name
HAVING COUNT(*) > 1
UNION SELECT product_name, null, COUNT(*), SUM(sales)
FROM lab13.sample GROUP BY product_name
HAVING COUNT(*) > 20
UNION SELECT null, customer_name, COUNT(*), SUM(sales)
FROM lab13.sample GROUP BY customer_name
HAVING COUNT(*) > 30)
SELECT * FROM cte ORDER BY 1, 2;
--v2--
select product_name, customer_name, count(*), sum(sales) from lab13.sample group by product_name, customer_name;
--v3-- dla testow
select customer_name, count(*), sum(sales) from lab13.sample group by grouping sets ((customer_name, product_name), (customer_name), (product_name));


    --2--
with cte as (select ship_mode, region, sum(shipping_cost) as shipcost from lab13.sample group by ship_mode, region)
select ship_mode, region, row_number() over (order by shipcost desc), DENSE_RANK() over (order by shipcost desc), shipcost, sum(shipcost) over (partition by region order by region) from cte order by ROW_NUMBER;


    --3--
select * from crosstab ( 'select product_category-product_sub_category, region, s from lab13.sample') as fr ("category" text);
