create database DBMS;
USE DBMS;
SET AUTOCOMMIT=0;
DROP TABLE IF EXISTS `account_details`;
CREATE TABLE IF NOT EXISTS `account_details` (
  `acc_id` int(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `ssn` char(10) NOT NULL,
  `acc_holder_id` int(10) NOT NULL,
  `balance` decimal(20,4) DEFAULT '0.0000',
  PRIMARY KEY (`acc_id`));
  
INSERT INTO `account_details` (`acc_id`, `acc_holder_id`, `balance`, `first_name`, `last_name`, `ssn`) VALUES
	(1, 100, 132.1020, 'Joseph', 'Cane', '098765432'),
	(2, 300, 4435.2030, 'Kim', 'Karry', '087654321'),
	(3, 120, 2345223.6600, 'Jim', 'Anderson', '123456780'),
	(4, 90, 98763.2300, 'Jessie', 'Thomson', '765432109'),
	(5, 110, 34221.1000, 'Palak', 'Patel', '654321890'),
	(6, 80, 7634.8000, 'Max', 'Jerrard', '456789012'),
	(7, 10, 876964.7000, 'Peter', 'Koshnov', '512345670'),
	(8, 110, 299876.6000, 'Monica', 'Irodov', '120088551'),
	(9, 100, 7659809.5300, 'Petro', 'Jenkins Jr', '123456789'),
	(10, 200, 111.1200, 'Jeff', 'Joshua', '765432189' );
    
select * from account_details;
# Q.1 Write a tansactional query that transfers 1000 dollars from Monica's account to Joseph's account
SET AUTOCOMMIT=0;
#SESSION 1
START transaction;
UPDATE account_details 
SET balance=132.1020+1000
WHERE first_name='%Joseph%';
START transaction;
UPDATE account_details 
SET balance=299876.6000-1000
WHERE first_name='%Monica%';
COMMIT;
#INFERENCE:-IN THE SESSION ,THE UPDATE COMMANDS UPDATE THE BALANCE OF BOTH MONICA  AND JOSEPH.THEY GET SAVED PERMANENTLY TO THE DATABASE.WHEN WE EXECUTE COMMIT STATEMENT.

# Q.2 Suppose while writing the above query you update i.e. transfer 1000 dollars to Peter's account instead of Joseph's account.
# Write a query to discard all the changes and end the transaction
SET AUTOCOMMIT=0;
#SESSION 1
START transaction;
UPDATE account_details 
SET balance=132.1020+1000
WHERE acc_id=1;

START transaction;
UPDATE account_details 
SET balance=299876.6000-1000
WHERE acc_id=8;

UPDATE account_details 
SET balance=876964.7000+1000
WHERE acc_id=10;
ROLLBACK;
COMMIT;
#INFERENCE:IN THE SESSION,THE UPDATE COMMANDS UPDATE THE BALANCE OF BOTH MONICA AND JOSEPH,BUT MISTANKELY UPDATES THE PETER'S ACCOUNT INSTEAD OF JOSEPH.TO UNDO THE 
#CHANGES WE CAN ROLLBACK
#############################################################################################################################################
# Create table to answer the follwoing question
Create table id_passwords( user_id varchar(20), 
							passwords varchar(20));
insert into id_passwords values
		('deborah_a', 'pass123'),
		('pique_xav', '123789pix'),
        ('jenny_fawx', '##**000'),
        ('alpha_m','infinity');
select * from id_passwords;

# Q.3 Write a query to make sure that no other mysql session should be able to insert any user ids or passwords

#SESSION 1
select * from id_passwords FOR UPDATE;
#INFERENCE:BECAUSE THE SESSION HAS PLACED AN EXCLUSIVE LOCK AND THE TRANSACTION IS STILL ACTIVE,NO OTHER USER CAN INSERT ANY NEW RECORD


############################################################################################################################################# 
-- ----------------------------------------------------
# Datasets Used: employee_details.csv and department_details.csv
-- ----------------------------------------------------
unlock tables;
# Q.4 Create a view "details" that contains the columns employee_id, first_name, last_name and the salary from the table "employee_details".
 USE TAKEHOME;
 CREATE VIEW DETAILS
 AS
 SELECT employee_id, first_name, last_name, salary 
 from employee_details;
 
 SELECT * FROM DETAILS;
 
# Q.5 Update the view "details" such that it contains the records from the columns employee_id, first_name, last_name, salary, hire_date and job_id 
-- --  where job_id is ‘IT_PROG’.
 CREATE VIEW details
 AS
 SELECT employee_id, first_name, last_name, salary,hire_date,job_id 
 from employee_details
 WHERE job_id LIKE '%IT_PROG%';
/* 
 #OR
 replace details
 SELECT employee_id, first_name, last_name, salary,hire_date,job_id 
 from employee_details
 WHERE job_id LIKE '%IT_PROG%';
 */
 
# Q.6 Create a view "check_salary" that contains the records from the columns employee_id, first_name, last_name, job_id and salary from the table "employee_details" 
-- --  where the salary should be greater than 50000.
 CREATE view check_salary
 AS
 select employee_id, first_name, last_name, job_id,salary
 FROM employee_details
 WHERE salary > 50000;
 
# Q.7 Create a view "location_details" that contains the records from the columns department_name, manager_id and the location_id from the table "department_details" 
-- --  where the department_name is ‘Shipping’.
 create view location_details
 AS
 SELECT department_name, manager_id,location_id 
 from department_details
 WHERE department_name LIKE '%Shipping%';
 
# Q.8 Create a view "salary_range" such that it contains the records from the columns employee_id, first_name, last_name, job_id and salary from the table "employee_details" 
-- --  where the salary is in the range (30000 to 50000).
 CREATE VIEW salary_range
 AS
 select employee_id, first_name, last_name, job_id,salary 
 from employee_details
 WHERE salary BETWEEN 30000 AND 50000;
 
# Q.9 Create a view "pattern_matching" such that it contains the records from the columns employee_id, first_name, job_id and salary from the table name "employee_details" 
-- --  where first_name ends with "l".
CREATE VIEW pattern_matching
AS
SELECT employee_id, first_name, job_id,salary
FROM employee_details
WHERE first_name LIKE '%L';

# Q.10 Drop multiple existing views "pattern_matching", "salary" and "location_details".
DROP VIEW location_details,salary_range,location_details;
 
# Q.11 Create a view "employee_department" that contains the common records from the tables "employee_details" and "department_table".
CREATE VIEW employee_department
AS 
SELECT * FROM employee_details E
INNER JOIN department_table D
ON E.EMPLOYEE_ID=D.EMPLOYEE_ID;
-- ----------------------------------------------------
# Datset Used: admission_predict.csv
-- ----------------------------------------------------
# Q.12 A university focuses only on SOP and LOR score and considers these scores of the students who have a research paper. Create a view for that university.
CREATE VIEW university_focuses
AS 
SELECT `Serial No.`,SOP,LOR,`Chance of Admit`
FROM admission_predict
WHERE Research=1;

# Q.13 Create and append a new column "SOP_LOR_AVG" to the view "SLR_Focus".
REPLACE university_focuses  
SELECT `Serial No.`,SOP,LOR,`Chance of Admit`,(SOP+LOR)/2 AS SLR_Focus
FROM admission_predict
WHERE Research=1;

#############################################################################################################################################
#Create Table:
CREATE TABLE BANK_CUSTOMER ( customer_id INT , 
			     customer_name VARCHAR(20), 
			     Address     VARCHAR(20),
			     state_code  VARCHAR(3) ,         
			     Telephone   VARCHAR(10)    );
		    
#Insert records:
INSERT INTO BANK_CUSTOMER VALUES (123001,"Oliver", "225-5, Emeryville", "CA" , "1897614500");
INSERT INTO BANK_CUSTOMER VALUES (123002,"George", "194-6,New brighton","MN" , "1897617000");
INSERT INTO BANK_CUSTOMER VALUES (123003,"Harry", "2909-5,walnut creek","CA" , "1897617866");
INSERT INTO BANK_CUSTOMER VALUES (123004,"Jack", "229-5, Concord",      "CA" , "1897627999");
INSERT INTO BANK_CUSTOMER VALUES (123005,"Jacob", "325-7, Mission Dist","SFO", "1897637000");
INSERT INTO BANK_CUSTOMER VALUES (123006,"Noah", "275-9, saint-paul" ,  "MN" , "1897613200");
INSERT INTO BANK_CUSTOMER VALUES (123007,"Charlie","125-1,Richfield",   "MN" , "1897617666");
INSERT INTO BANK_CUSTOMER VALUES (123008,"Robin","3005-1,Heathrow",     "NY" , "1897614000");

# Q.14 Suppose there is no customer_id: 123009 in the bank_customer table,
#One of the first user is trying to update the customer_id details with condition customer_id > 123008 and updating telephone as NULL.
#At the same time, if some other user is trying to insert a record with customer_id : 123009 with values ( 123009, 'Ropert' , '99-Bechkingam', 'CA' , 1867888950).
#During the above two transactions occuring at a same time, After first user checks the database , he recieves an additional record entry of 123009 which he doesn't expect.
#How will you restrict the second user entry?
#IN SESSION 1:-
SET transaction ISOLATION LEVEL serializable;
UPDATE BANK_CUSTOMER
SET telephone=null
WHERE customer_id > 123008;
COMMIT;

#IN SESSION2:-
start transaction;
INSERT INTO BANK_CUSTOMER VALUES( 123009, 'Ropert' , '99-Bechkingam', 'CA' , 1867888950);
COMMIT;
#INFERENCE:SINCE THE TRANSACTION-serializable-HIGHEST ISOLATION LEVEL.WRITE LOCK#2ND PERSON RESTRICTED ON ISOLATION ONLY.ONCE THE 1ST PERSON COMMITTED HE CAN SEE THE TRANSACTION

# Q.15 Write a query such that users can perform concurrent DML operations on the same customer_id = 123002 in bank_customer. 
# One user performs an updates House Address for that customer_id with "2999 New brighton" 
# Other user performs an update Telephone number with 189891899
START TRANSACTION;
UPDATE BANK_CUSTOMER
SET ADDRESS='2999 New brighton'
WHERE customer_id=123002;
COMMIT;
#SESSION2
START TRANSACTION;
UPDATE BANK_CUSTOMER
SET Telephone=189891899;

#INFERENCE:IT IS NOT POSSIBLE AS BOTH SESSION SIMULTANEOSLY AT THE SAME TIME.ONCE SESSION 1 IS GOING ON SESSION 2 HAVE TO WAIT.


# Q.16 Write a transaction on customer Id = 123001 in table: bank_customer to acquire shared lock . So others can also acquire the 
# shared lock but cannot modify any rows in the bank_customer table
start transaction;
select * FROM bank_customer
WHERE customer_id=123001 LOCK IN SHARE MODE;

#INFERENCE:-SHARED LOCK ON THE TABLE-EXCLUSIVE MODE-BUT NOT MODIFY IT

#############################################################################################################################################
CREATE TABLE BANK_ACCOUNT ( Customer_id INT, 		   			  
							Account_Number VARCHAR(19),
							Account_type VARCHAR(25),
							Balance_amount INT ,
                            Account_status VARCHAR(10), 
                            Relationship_type varchar(1) ) ;
INSERT INTO BANK_ACCOUNT  VALUES (123001, "4000-1956-3456",  "SAVINGS"            , 200000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123001, "5000-1700-3456",  "RECURRING DEPOSITS" ,9400000 ,"ACTIVE","S");  
INSERT INTO BANK_ACCOUNT  VALUES (123002, "4000-1956-2001",  "SAVINGS"            , 400000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123003, "4000-1956-2900",  "SAVINGS"            ,750000,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "5000-1700-6091",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "4000-1956-3401",  "SAVINGS"            , 655000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123005, "4000-1956-5102",  "SAVINGS"            , 300000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123006, "4000-1956-5698",  "SAVINGS"            , 455000 ,"ACTIVE" ,"P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "5000-1700-9800",  "SAVINGS"            , 355000 ,"ACTIVE" ,"P"); INSERT INTO BANK_ACCOUNT  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , 7025000,"ACTIVE" ,"S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "9000-1700-7777-4321",  "CREDITCARD"    ,0      ,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123008, "5000-1700-7755",  "SAVINGS"            ,NULL   ,"INACTIVE","P"); 


# Q.17 Write a transactional query such that a 3% interest is added in the balance_amount of all account_numbers 
# of a customer Id = 123001 in bank_account table. Make sure that no other users is able to make any update to the table
SELECT * FROM bank_customer;
start transaction;

update bank_customer
SET Balance_amount=200000*0.03
WHERE customer_Id=123001;

# Q.18 Three users are performing DML operations;
# Out of three users, one user increases  balance_amount by 0.03% of customer_id = 123001; in bank_account table.
# Write transactional query such that after the above update users can insert two different balance_amount concurrently for an account : '4000-1956-3401' parallely without any deadlock
#SESSION1:-
start transaction;
update bank_customer
SET Balance_amount=0.03*Balance_amount
WHERE customer_id = 123001;
COMMIT;
#SESSION2
start transaction;
update bank_customer
SET Balance_amount=0.03*Balance_amount
WHERE Account_Number='4000-1956-3401';
COMMIT;
#SESSION3-
start transaction;
update bank_customer
SET Balance_amount=1.2*Balance_amount
WHERE Account_Number='4000-1956-3401';
COMMIT;

#INFERENCE:-THE  SESSION 1 STARTED THE TRANSACTION AND AFTER IT ENDED.NOW SESSION 2 AND 3 GOING TO STARTED BUT THEY CANNOT PERFORM AT THE SAME TIME 
#SO IT CREATES THE ANAMOLY.IT FOLLOWS THE SESSION ONE BY ONE WHICH GET PREFERED FIRST.