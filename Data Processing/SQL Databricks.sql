select * 
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis` limit 100;

--Viewing Distinct 
select Distinct 
       store_location
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis` limit 100;

-- Selecting Specific columns
select transaction_time,
       transaction_date
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis` limit 100;

-- Columns as Alias
select unit_price AS price,
       transaction_qty AS Quantity
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis` limit 100;

-- Selecting starting Date collecting
select min(transaction_date) As Start_date
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis`;

-- last date of data collection
select max(transaction_date) As last_date
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis`;

-- inspect Product Category
select distinct 
product_category
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis` limit 100;

-- Inspect Product_Details
select distinct product_detail
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis` limit 100;

-- grouping inspection product category and product details
select distinct 
       product_category AS Category,
       product_type AS Type,
       product_detail AS Product_Name
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis` limit 100;

-- What is the Title of the Product
select distinct 
       product_type
from `workspace`.`default`.`bright_coffee_shop_sales_Analysis` limit 100;

SELECT
  transaction_date AS Purchase_date,
  dayname(transaction_date) AS Day_name,
  monthname(transaction_date) AS Month_name,
  dayofmonth(transaction_date) AS Day_of_Month,
  CASE 
    WHEN dayname(transaction_date) IN ('Saturday','Sunday') THEN 'weekend'
    ELSE 'weekday'
  END AS day_classification,
  CASE
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '01.Morning'
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02.Afternoon'
    WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN '03.Evening'
  END AS time_buckets,
  COUNT(DISTINCT transaction_id) AS Number_of_sales,
  COUNT(DISTINCT product_id) AS Number_of_products,
  COUNT(DISTINCT store_id) AS number_of_stores,
  SUM(transaction_qty * unit_price) AS revenue_per_day,
  CASE
    WHEN SUM(transaction_qty * unit_price) <= 50 THEN '01.low Spend'
    WHEN SUM(transaction_qty * unit_price) BETWEEN 51 AND 100 THEN '02.Med spend'
    ELSE '03. High Spend'
  END AS Spend_bucket,
  store_location,
  product_category,
  product_detail
FROM `workspace`.`default`.`bright_coffee_shop_sales_Analysis`
GROUP BY
  transaction_date,
  dayname(transaction_date),
  monthname(transaction_date),
  dayofmonth(transaction_date),
  CASE 
    WHEN dayname(transaction_date) IN ('Saturday','Sunday') THEN 'weekend'
    ELSE 'weekday'
  END,
  CASE
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '01.Morning'
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02.Afternoon'
    WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN '03.Evening'
  END,
  store_location,
  product_category,
  product_detail;
