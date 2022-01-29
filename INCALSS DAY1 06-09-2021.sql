# Question 1:
# 1) Create a Database Bank.
create database Bank; #creating a new bank database
use Bank;

# Question 2:
# 2) Create a table with the name “Bank_Inventory” with the following columns
-- Product  with string data type and size 10 --
-- Quantity with numerical data type --
-- Price with data type that can handle all real numbers
-- purcahase_cost with data type which always shows two decimal values --
-- estimated_sale_price with data type float --
use bank;
create table Bank_Inventory(Product varchar(10),Quantity int,Price real,purchase_cost decimal(10,2),estimated_sale_price float);

show tables;
/*create table Bank_Inventory
(product char(10),
quantity int,
Price Real,
Purchase_cost decimal(10,2),
estimated_sale_price float);*/
#(10,2)2-takes two decimal places

# Question 3:
# 3) Display all column names and their datatype and size in Bank_Inventory.
desc bank_inventory;

# Question 4:
# 4) Insert the below two records into Bank_Inventory table .
-- 1st record with values --
			-- Product : PayCard
			-- Quantity: 2 
			-- price : 300.45 
			-- Puchase_cost : 8000.87
			-- estimated_sale_price: 9000.56 --
-- 2nd record with values --
			-- Product : PayPoints
			-- Quantity: 4
			-- price : 200.89 
			-- Puchase_cost : 7000.67
			-- estimated_sale_price: 6700.56
		insert into bank_inventory values('paycard',2,300.45,8000.87,9000.56);

# Question 5:
# 5) Add a column : Geo_Location to the existing Bank_Inventory table with data type varchar and size 20 .
alter table bank_inventory add Geo_Location varchar(20);

# Question 6:
# 6) What is the value of Geo_Location for product : ‘PayCard’?
select Geo_Location from bank_inventory where product='PayCard';

# Question 7:
# 7) How many characters does the  Product : ‘PayCard’ store in the Bank_Inventory table.
select char_length(product) from Bank_inventory where product='PayCard';

# Question 8:
# a) Update the Geo_Location field from NULL to ‘Delhi-City’ 
update bank_inventory set Geo_Location='Delhi-City' where Geo_Location is null;

# b) How many characters does the  Geo_Location field value ‘Delhi-City’ stores in the Bank_Inventory table
#we cannot do it.

# Question 9:
# 9) update the Product field from CHAR to VARCHAR size 10 in Bank_Inventory 
alter table bank_inventory modify product varchar(10);


# Question 10:
# 10) Reduce the size of the Product field from 10 to 6 and check if it is possible. 
alter table bank_inventory modify product varchar(6);#we cannot do it

# Question 11:
# 11) Bank_inventory table consists of ‘PayCard’ product details .
-- For ‘PayCard’ product, Update the quantity from 2 to 10  
update bank_inventory set quantity=10 where product='Paycard';


 # Question 12:
# 12) Create a table named as Bank_Holidays with below fields 
-- a) Holiday field which displays or accepts only date 
-- b) Start_time field which also displays or accepts date and time both.  
-- c) End_time field which also displays or accepts date and time along with the timezone also. 

create table Bank_holidays(Holiday_field date,Start_time datetime,End_time timestamp);
select  date(Holiday_field) from Bank_holidays;
select timestamp('2021-09-06');
select now();
select curdate();
select curtime();


 # Question 13:
# 13) Step 1: Insert today’s date details in all fields of Bank_Holidays 
-- Step 2: After step1, perform the below 

insert into bank_holidays values(current_date(),current_date(),current_date());
-- Postpone Holiday to next day by updating the Holiday field 
#date_add-add days to the field
update bank_holidays set holiday=date_add(holiday,interval 1 day);



# Question 14:
# 14) Modify  the Start_time data with today's datetime in the Bank_Holidays table 
update bank_holidays set start_time=current_timestamp();#or now() 


# Question 15:
# 15) Update the End_time with UTC time(GMT Time) in the Bank_Holidays table. 
update bank_holidays set End_time=UTC_timestamp();

# Question 16:
# 16) Select all columns from Bank_Inventory without mentioning any column name
select * from bank_inventory;

# Question 17:
# 17)  Display output of PRODUCT field as NEW_PRODUCT in  Bank_Inventory table 
select product as new_product from bank_inventory;

# Question 18:
# 18)  Display only one record from bank_Inventory 
select * from bank_inventory limit 1;

# Question 19:
# 19) Modify  the End_time data with today's datetime in the Bank_Holidays table 
update bank_holidays set End_time=curtime();

# Question 20:
# 20) Display the first five rowss of the Geo_location field of Bank_Inventory.
select Geo_location from Bank_Inventory limit 5;





