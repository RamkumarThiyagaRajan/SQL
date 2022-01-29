Punctuality# Datasets used: AirlineDetails.csv, passengers.csv and senior_citizen.csv
-- -----------------------------------------------------
-- Schema Airlines

CREATE DATABASE DBMS2_DAY3;
USE DBMS2_DAY3;

-- -------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Create a table Airline_Details. Follow the instructions given below: 
-- -- Q1. Values in the columns Flight_ID should not be null.
-- -- Q2. Each name of the airline should be unique.
-- -- Q3. No country other than United Kingdom, USA, India, Canada and Singapore should be accepted
-- -- Q4. Assign primary key to Flight_ID 
CREATE TABLE AIRLINE_DETAILS (
FLIGHT_ID INT NOT NULL PRIMARY KEY, 
AIRLINE VARCHAR(500) UNIQUE, 
COUNTRY VARCHAR(250) CHECK(COUNTRY IN ('UNITED KINGDOM', 'USA', 'INDIA', 'CANADA', 'SINGAPORE')), 
PUNCTUALITY DOUBLE, 
SERVICE_QUALITY DOUBLE, 
AIRHELP_SCORE DOUBLE
); 

SELECT * FROM AIRLINE_DETAILS;
DESCRIBE AIRLINE_DETAILS;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Only passengers having age greater than 18 are allowed.
-- -- Q3. Assign primary key to Traveller_ID
CREATE TABLE PASSENGERS (
TRAVELLER_ID VARCHAR(20) NOT NULL PRIMARY KEY, 
NAME VARCHAR(300), 
AGE INT CHECK(AGE > 18), 
PNR VARCHAR(300) NOT NULL, 
FLIGHT_ID INT, 
TICKET_PRICE DOUBLE
); 


-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique and should not be null.
ALTER TABLE PASSENGERS ADD PNR_STATUS VARCHAR(50) UNIQUE NOT NULL AFTER PNR;


-- -- Q4. Flight Id should not be null.
ALTER TABLE PASSENGERS MODIFY FLIGHT_ID INT NOT NULL; 

SELECT * FROM PASSENGERS;
DESCRIBE PASSENGERS; 

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Create a table Senior_Citizen_Details. Follow the instructions given below: 
-- -- Q1. Column Traveller_ID should not contain any null value.
-- -- Q2. Assign primary key to Traveller_ID
-- -- Q3. Assign foreign key constraint on Traveller_ID such that if any row from passenger table is updated, then the Senior_Citizen_Details table should also get updated.
-- -- --  Also deletion of any row from passenger table should not be allowed. 
CREATE TABLE SENIOR_CITIZEN_DETAILS (
TRAVELLER_ID VARCHAR(20) NOT NULL PRIMARY KEY, 
SENIOR_CITIZEN VARCHAR(300), 
DISCOUNTED_PRICE VARCHAR(50), 
FOREIGN KEY(TRAVELLER_ID) REFERENCES PASSENGERS(TRAVELLER_ID) ON UPDATE CASCADE ON DELETE RESTRICT
); 

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- -----------------------------------------------------
-- Table Senior_Citizen_Details
-- -- Q6. Create a new column Age in Passengers table that takes values greater than 18. 
ALTER TABLE PASSENGERS ADD AGE INT CHECK(AGE > 18);

SELECT * FROM SENIOR_CITIZEN_DETAILS;
DESCRIBE SENIOR_CITIZEN_DETAILS;
 
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Create a table books. Follow the instructions given below: 
-- -- Columns: books_no, description, author_name, cost
-- -- Qa. The cost should not be less than or equal to 0.
-- -- Qb. The cost column should not be null.
-- -- Qc. Assign a primary key to the column books_no.
CREATE TABLE BOOKS (
BOOKS_NO INT PRIMARY KEY, 
DESCRIPTION TEXT, 
AUTHOR_NAME TEXT, 
COST FLOAT NOT NULL CHECK(COST > 0)
); 

SELECT * FROM BOOKS;
DESCRIBE BOOKS;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

# Q8. Update the table 'books' such that the values in the columns 'description' and author' must be unique.
ALTER TABLE BOOKS MODIFY COLUMN DESCRIPTION VARCHAR(500) UNIQUE; 
ALTER TABLE BOOKS MODIFY AUTHOR_NAME VARCHAR(300) UNIQUE;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 9. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.
CREATE TABLE BIKE_SALES (
ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
PRODUCT VARCHAR(300) NOT NULL, 
QUANTITY INT NOT NULL CHECK(QUANTITY > 0), 
RELEASE_YEAR INT NOT NULL CHECK(RELEASE_YEAR BETWEEN 2000 AND 2010), 
RELEASE_MONTH INT NOT NULL CHECK(RELEASE_MONTH BETWEEN 1 AND 12)
); 

SELECT * FROM BIKE_SALES;
DESCRIBE BIKE_SALES;
-- --------------------------------------------------------------------------
-- Use the following comands to insert the values in the table bike_sales
/*('1','Pulsar','1','2001','7');
('2','yamaha','3','2002','3');
('3','Splender','2','2004','5');
('4','KTM','2','2003','1');
('5','Hero','1','2005','9');
('6','Royal Enfield','2','2001','3');
('7','Bullet','1','2005','7');
('8','Revolt RV400','2','2010','7');
('9','Jawa 42','1','2011','5');*/
INSERT INTO BIKE_SALES VALUES('1','Pulsar','1','2001','7');
INSERT INTO BIKE_SALES VALUES('2','yamaha','3','2002','3');
INSERT INTO BIKE_SALES VALUES('3','Splender','2','2004','5');
INSERT INTO BIKE_SALES VALUES('4','KTM','2','2003','1');
INSERT INTO BIKE_SALES VALUES('5','Hero','1','2005','9');
INSERT INTO BIKE_SALES VALUES('6','Royal Enfield','2','2001','3');
INSERT INTO BIKE_SALES VALUES('7','Bullet','1','2005','7');
INSERT INTO BIKE_SALES VALUES('8','Revolt RV400','2','2010','7');
INSERT INTO BIKE_SALES VALUES('9','Jawa 42','1','2011','5');   # THROWS ERROR AS VALUE FOR RELEASE_YEAR COLUMN FAILS THE CHECK CONSTRAINT

SELECT * FROM BIKE_SALES;
-- --------------------------------------------------------------------------
