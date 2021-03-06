CREATE database MP2;
USE MP2;
/*
Composite data of a business organisation, confined to ‘sales and delivery’
domain is given for the period of last decade. From the given data retrieve 
solutions for the given scenario.

*/
/*
1. Join all the tables and create a new table called combined_table.
(market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)*/
SELECT M.*,C.*
FROM MARKET_FACT M
JOIN CUST_DIMEN C
USING(CUST_ID);
CREATE TABLE COMBINED_TABLE
AS
SELECT 
M.ORD_ID,M.PROD_ID,M.SHIP_ID,M.CUST_ID,M.SALES,M.DISCOUNT,M.ORDER
_QUANTITY,M.PROFIT,M.SHIPPING_COST,M.PRODUCT_BASE_MARGIN,
C.CUSTOMER_NAME,C.PROVINCE,C.REGION,C.CUSTOMER_SEGMENT,
O.ORDER_ID ORDER_O_ID,O.ORDER_DATE,O.ORDER_PRIORITY,
P.PRODUCT_CATEGORY,P.PRODUCT_SUB_CATEGORY,
S.ORDER_ID SHIP_O_ID,S.SHIP_MODE,S.SHIP_DATE
FROM MARKET_FACT M
JOIN CUST_DIMEN C
ON C.CUST_ID = M.CUST_ID
JOIN ORDERS_DIMEN O
ON O.ORD_ID = M.ORD_ID
JOIN PROD_DIMEN P
ON P.PROD_ID = M.PROD_ID
JOIN SHIPPING_DIMEN S
ON S.SHIP_ID = M.SHIP_ID;

/*
2. Find the top 3 customers who have the maximum number of orders*/
SELECT CUST_ID,CUSTOMER_NAME,COUNT(ORD_ID) NUM_OF_ORDERS
FROM COMBINED_TABLE
GROUP BY CUST_ID,CUSTOMER_NAME
ORDER BY NUM_OF_ORDERS DESC LIMIT 3;

-- 3. Create a new column DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
select * from combined_table;
alter table combined_table
add column DaysTakenForDelivery varchar (5);
update combined_table
set DaysTakenForDelivery = datediff(str_to_date(ship_date,'%d-%c-%Y'),str_to_date(order_date,'%d-%c-%Y'));

-- 4. Find the customer whose order took the maximum time to get delivered.
select cust_id,customer_name,daystakenfordelivery from 
combined_table 
where daystakenfordelivery = (select max(daystakenfordelivery) 
from combined_table );

--  5. Retrieve total sales made by each product from the data
select * from combined_table;
select ord_id,prod_id,customer_name,sum(sales) over(partition by prod_id order by prod_id) sum_sales
from combined_table;

--  6. Retrieve total profit made from each product from the data (use windows function)
select * from combined_table;
select ord_id,prod_id,customer_name,sum(profit) over(partition by prod_id) sum_of_profit
from combined_table;

-- 7. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
select year(str_to_date(order_date,'%d-%c-%Y')) as years,Month(str_to_date(order_date,'%d-%c-%Y')) as months,count(cust_id) as Count_of_users
 from combined_table
 where (year(str_to_date(order_date,'%d-%c-%Y'))=2011)
 and cust_id in (
 select distinct cust_id 
 from combined_table
 where 
Month(str_to_date(order_date,'%d-%c-%Y')) =1
 and 
year(str_to_date(order_date,'%d-%c-%Y')) =2011
 )
 group by years,months
 order by years,months;
 
 -- 8.Retrieve month-by-month customer retention rate since the start of the business.(using views)
 select t2.buy_year,t2.buy_month,count(case when is_new=1 then 1 end) number_of_repeat_buyer,count(case when is_new=0 then 1 end) number_of_new_buyer,(100*count(case 
when is_new=1 then 1
 end))/(count(case 
when is_new=1 then 1
 end) + count(case
when is_new=0 then 1
 end)) as percent_retention
 from (select year(t1.order_date) buy_year,
month(t1.order_date) buy_month,
case
when t1.buyer_status='Repeat 
Buyer' then 1
else 0
end as is_new
from (select 
t.order_date,t.cust_id,
case 
when 
t.row_num=1 then 'New Buyer'
else 
'Repeat Buyer'
end as 
buyer_status
from(
select 
 c.cust_id,
str_to_date(c.order_date,'%d-%c-%Y') order_date,
 row_number() 
over (partition by c.cust_id order by 
c.cust_id,str_to_date(c.order_date,'%d-%c-%Y')) row_num
from 
combined_table c
 order by order_date
) t
order by t.order_date) t1
order by buy_year,buy_month) t2
group by t2.buy_year,t2.buy_month
order by t2.buy_year,t2.buy_month;

