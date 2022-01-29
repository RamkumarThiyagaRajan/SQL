# Dataset used: titanic_ds.csv
# Use subqueries for every question

#Q1. Display the first_name, last_name, passenger_no , fare of the passenger who paid less than the  maximum fare. (20 Row)
SELECT first_name,last_name,Passenger_No,fare,AVG(FARE)
FROM titanic_ds
WHERE FARE<
(SELECT MAX(FARE) FROM titanic_ds);

#Q2. Retrieve the first_name, last_name and fare details of those passengers who paid fare greater than average fare. (11 Rows)
SELECT first_name,last_name,Passenger_No,fare,AVG(FARE)
FROM titanic_ds
WHERE FARE>
(SELECT AVG(FARE) FROM titanic_ds);


#Q3. Display the first_name ,sex, age, fare and deck_number of the passenger equals to passenger number 7 but exclude passenger number 7.(3 Rows)
 SELECT first_name,sex,age,fare,DECK_NUMBER
 FROM titanic_ds
 WHERE DECK_NUMBER=
 (SELECT DECK_NUMBER 
 FROM titanic_ds
 WHERE Passenger_No=7)
 AND Passenger_No!=7;
 
#Q4. Display first_name,embark_town where deck is equals to the deck of embark town ends with word 'town' (7 Rows)
SELECT first_name,embark_town,deck
FROM titanic_ds
WHERE deck IN
(SELECT deck
FROM titanic_ds
WHERE embark_town LIKE '%TOWN');

# Dataset used: youtube_11.csv

#Q5. Display the video Id and the number of likes of the video that has got less likes than maximum likes(10 Rows)
select Video_id,count(Likes)
from youtube_11
where Likes <
(select max(Likes)
from youtube_11);

#Q6. Write a query to print video_id and channel_title where trending_date is equals to the trending_date of  category_id 1(5 Rows)
select Video_id,Channel_Title,Trending_Date
from youtube_11
where Trending_Date=
(select Trending_Date
from youtube_11
where Category_id=1);

#Q7. Write a query to display the publish date, trending date ,views and description where views are more than views of Channel 'vox'.(7 Rows))
select Publish_Date,Trending_Date,Views,Description
from youtube_11
where views >
(select Views
from youtube_11
where Channel_Title='vox' );

#Q8. Write a query to display the channel_title, publish_date and the trending_date having category id in between 9 to Maximum category id .
# Do not use Max function(3 Rows)
select Category_id,Channel_Title,Publish_Date,Trending_Date
from youtube_11
where Category_id between 9 and 
(select distinct Category_id
from youtube_11
order by Category_id desc limit 1 );

#Q9. Write a query to display channel_title, video_id and number of view of the video that has received more than  mininum views. (10 Rows)
select Channel_Title,Video_id,Views,min(Views)
from youtube_11
where Views>
(select min(Views)
from youtube_11);

# Database used: db1 (db1.sql file provided)

#Q10. Get those order details whose amount is greater than 100,000 and got cancelled(1 Row))
select *
from orders
where customerNumber in 
(select customerNumber 
from payments
where amount>100000)
and status='cancelled';

#Q11. Get employee details who shipped an order within a time span of two days from order date (15 Rows)
select employeeNumber,firstName,lastName
from employees
where employeeNumber in(select salesRepEmployeeNumber
							from customers
							where customerNumber in(
                            select customerNumber
							from orders
							where abs(datediff(orderDate,shippedDate))<=2));

#Q12. Get product name , product line , product vendor of products that got cancelled(53 Rows)
 select productName,productLine,productVendor
from products
where 	productCode in
(select productCode
from orderdetails
where orderNumber in
(select orderNumber 
from orders
where status='cancelled'));
 
#Q13. Get customer full name along with phone number ,address , state, country, who's order was resolved(4 Rows)
 select concat(contactFirstName,contactLastName),phone,concat(ifnull(addressLine1,addressLine2),' ',city) address
 from customers where customerNumber in 
 (select customerNumber 
 from orders
 where status='resolved');
 
#Q14. Display those customers who ordered product of price greater than average price of all products(98 Rows)
 select customerNumber,customerName,contactLastName
 from customers
 where customerNumber in
 (select orderNumber
 from orders
 where orderNumber in 
 (select productCode
 from orderdetails
 where priceEach>
 (select avg(quantityOrdered*priceEach)
 from orderdetails)));
 
#Q15. Get office deatils of employees who work in the same city where their customers reside(5 Rows)
select employeeNumber,concat(firstName,lastName) Employees
from employees
where officeCode in 
(select officeCode
from offices
where city in 
(select city from customers));

select employeeNumber,concat(firstName,lastName) Employees
from employees e
where officecode in (select officecode from offices 
     where city in (select city from customers c where e.employeenumber = c.salesRepEmployeeNumber));