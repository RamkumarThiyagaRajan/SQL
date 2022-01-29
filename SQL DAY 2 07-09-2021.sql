#DAY 2
/*
CONSTRAINTS

primary key-unique and not null
unique key-unique
not null-no null values
check-checks whether a column statisfies a specific condition-check age>18
default-sets a default values
index-creates and retrieves data very quickly
foreign key-links table together refers to pk of other table
*/

use chn_jul21;
/*student constraints
attributes-sid pk,sname not null,pnno unique not null,email_id unique,age 18-60,enrolled_city default BLR
*/
/*create table student_constraints
(
colname1 datatype constraintname,
colname2 datatype constraintname,
);
*/

create table student_constraints
(
sid int primary key,
sname varchar(30) not null,
phnno char(10) unique not null ,
email_id varchar(50) unique ,
age int check(age>=18 and age<=60),#check age between 18 and 60
enrolled_city varchar(10) default 'BLR'
);
desc student_constraints;#describe the table

/* already used table we can add constraints by using this:-*/
desc students;
alter table students add primary key(sid);#already used table we can add constraints by using this alter and then using modify
#in add primary key(column name) is a must
alter table students modify emailid varchar(50) unique;#already used table we can add constraints by using this alter and then modify 

alter table students drop primary key;#dropping the primary key-we dont need to mention column_name
alter table students drop index emailid;#drop index

#operators
/*
= != < > <= >= 
in(multiple or's),not in(multiple or's)
between-range
 where-filtering
 is null,is not null
*/
#select clause-and usage of where clause
use hr;
#Q1.WAQ TO LIST THE EMPLOYEES WHO DONOT WORK IN DEPARTMENT 80.
select * from employees
where department_id !=80;

#Q2.WAQ TO LIST THE EMPLOYEES WHO DO NOT WORK IN DEPT 80 OR 90
select * from employees
where department_id !=80 or department_id=90;#where department_id not in(80,90);

#Q3.WAQ TO LIST THE EMPLOYEES FOR WHOM THE COMMISSION IS NOT ALLOTTED
select * from employees
where commission_pct is null;#we can also use is not null

#Q4.WAQ TO LIST THE EMPLOYEES WHOSE FIRST NAME IS JOHN
select * from employees 
where first_name='JOHN';

select * from employees 
where first_name!='JOHN';

#Q5.WAQ TO LIST THE EMPLOYEES WHOSE NAME STARTS WITH J.
select * from employees 
where first_name like 'j%';#%-occurence of any character i.e 0 or more occurence of any charcter %-is called wildcard

#Q5.WAQ TO LIST THE EMPLOYEES WHOSE NAME ENDS WITH J.
select * from employees 
where first_name like '%j';#%-occurence of any character %-is called wildcard


select * from employees 
where first_name like '%j%';#%-occurence of any character %-is called wildcard

select * from employees 
where first_name like '_j';#_-occurence of exactly one character _-exactly onre character

select * from employees 
where first_name like 'j_';

#Q6.WAQ TO LIST EMPLOYEES WHOSE FIRST NAME END WITH A.
SELECT * FROM employees
WHERE first_name LIKE '%A';

#Q7.WAQ TO LIST THE EMPLOYEES WHOSE NAME HAS H IN IT(EITHER FIRST NAME OR LAST NAME)
SELECT * FROM employees
WHERE first_name LIKE '%h%' or last_name like '%h%';

#8.WAQ TO LIST THE EMPLOYEES WHOSE FIRST NAME STARTS WITH A AND ENDS WITH A
SELECT * FROM employees
WHERE first_name LIKE 'A%A';


#9.WAQ TO DISPLAY THE DETAILS OF EMPLOYEES WHOSE FIRST NAME HAS H IN THE SECOND POSITION AND ENDS WITH A.
SELECT * FROM employees
WHERE first_name LIKE '_H%A';

SELECT * FROM employees
WHERE first_name LIKE 'a%a_';

/*
SET OPERATIONS
*/
#Q10.WAQ TO DISPLAY COMBINED THE ID,FIRST_NAME AND LAST NAME OF EMPLOYEES WHOSE SALARY B/W  5000 AND 6000.AND LIST OF ID,FIRST_NMAE,LAST NAME OF EMPLOYEES WHO WORK AS IT_PROG?
SELECT employee_id,first_name,last_name #`NO.OF COLUMNS SHOULD BE SAME`
from employees
WHERE salary between 5000 AND 6000
 union #ONLY COMMON-NO DUPLICATES
SELECT employee_id,first_name,last_name #`NO.OF COLUMNS SHOULD BE SAME`
from employees
where job_id='IT_PROG';

SELECT employee_id,first_name,last_name #`NO.OF COLUMNS SHOULD BE SAME`
from employees
WHERE salary between 5000 AND 6000
 union ALL #COMMON WITH DUPLICATES
SELECT employee_id,first_name,last_name #`NO.OF COLUMNS SHOULD BE SAME`
from employees
where job_id='IT_PROG';

/*NOT IN MYSQL ARE
1.INTERSECTION,
2.A-B,
3.B-A */

/*DUPLICATE ROWS CAN BE LIMITED BY DISTINCT-UNIQUE ONES*/
#`DISTINCT EMPLOYEES`#`giving the unique values`
select distinct job_id
from employees;

select distinct job_id,salary  #`employee_id can have many duplicates hence we used jod_id`-combination togther giving the unique values
from employees;

/*EVALUATION IS BASED ON THE OPERATOR PRECEDENCE*/

/*SQL BUILT IN FUNCTION
#SINGLE ROW FUNCTIONS
1.NUMERIC
2.CHARACTER
3.DATE
4.CAST,CONVERT,CASE,IF NULL
*/
#1.NUMERIC FUNCTION-ROUND
select round(14.567);#highest precendence
select round(14.2);#low precendence
select round(14.567,2);#round off 

select round(columnname)
from employees;

select round(columnname,2)#2-two decimal places
from employees;

#2.NUMERIC FUNCTION-CEILING()
select ceil(14.6999);
select ceil(14.2);

#3.-abs
select abs(-100);
select abs(100);

#4.numeric function-sqrt
select sqrt(16);
select round(sqrt(16.56),2);

#5.NUMERIC FUNCTION-POWER
select pow(4,2);#4**2
select power(4,2);#4**2

#6.NUMERIC FUNCTION-TRUNCATE
select truncate(14.56789,0);#0-directly cut it
select truncate(14.256789,2);#2-two cuts

/*CHARACTER FUNCTION-UPPER,LOWER,REPLACE,REVERSE,SUBSTR,INSTR,LENGTH,CHAR_LENGTH,LPAD,RPAD,LTRIM,RTRIM,TRIM*/
SELECT LOWER('GREAT LEARNING');
SELECT upper('great learning');

select concat('Great','','Learning');
select concat('Great','','Learning',' ','Hello');

select replace('Great Learning','e','@');

/*
select reverse(character-column_name1)
from employees;
*/

select substr('Great Learning',2,5);#my sql index starts from 1,space also occupies a index.Starting index and Total index
select substr('Great Learning',2,6);

select instr('Great Learning','r');# in string check whether the letter is present in character or not and o/p is the index
select instr('Great Learning','a');#o/p is the index

select char_length('Great');
select length('Great');

select CHAR_LENGTH("Great learning"); # length

select CHARACTER_LENGTH("Great learning");

select CONCAT (first_name, " ", last_name) from employees; #appending

select concat_ws ( "," ,first_name, last_name) from employees;

select field("e", "G","r", "e", "a", "t"); # position

SELECT FIND_IN_SET("a", "g,r,e,a,t");

SELECT FORMAT(250500.5634, 2);#roundinf off to 2 decimal places

SELECT INSERT("Greatlearning", 9, 3, "ese");

SELECT INSTR("Grlatlearning", "l") AS MatchPosition;

select lcase("GREATLEARNING");
select lOWER("GREATLEARNING");

SELECT POSITION("L" IN "GREATLEARNING") AS MatchPosition;

SELECT STRCMP("GREATLEARNING", "GREATLARNING"); #string comparison #-1,0,1
SELECT STRCMP("GREATLEARNING", "GREATLEARNING"); #string comparison #-1,0,1
SELECT STRCMP("GREATLEARNINGGG", "GREATARNING"); #string comparison #-1,0,1
select strcmp ("bom", "mob");#IT COMPARES ASCII VALUES
select strcmp ("xom", "mob");
select strcmp ("mob", "mob");

SELECT LENGTH("GREATLEARNING") AS LengthOfString;

SELECT LOCATE("T", "GREATLEARNINGT", 4 ) AS MatchPosition;

SELECT repeat('GREATLEARNING',3);

SELECT RPAD("GREATLEARNING", 20, "THIS IS ");

SELECT LTRIM(" GREAT LEARNING") AS LeftTrimmedString;

SELECT RTRIM("GREAT LEARNING ") AS LeftTrimmedString;

SELECT MID("GREATLEARNING", 7, 3) AS ExtractString;



select lpad('hello',10,'#');#pad with desired length-lpad>left side padding

select lpad(first_name,10,'#')
from employees;

select rpad('hello',10,'#');#pad with desired length-rpad>right side  padding 

select rpad(first_name,10,'#')
from employees;

select ltrim('    Great');
select length('    Great');#`use length  to check them`
select ltrim('     Great       ');
select rtrim('    Great'        );
select rtrim('Great     ');

select trim(leading '#' from '####Hello######');#left side
select trim(trailing '#' from '####Hello######');#right side
select trim(both '#' from '####Hello######');


#DATE-CURRENTDATE,CURDATE,NOW,DAY,YEAR,NMONTH,WEEKNO,DAYOFWEEK,DAY OF YEAR,DATEDIFF,AND
SELECT current_date();
select current_time();
SELECT current_timestamp();

SELECT day('2021-09-07');
SELECT day(curdate());
SELECT month(curdate());
SELECT monthname(CURDATE());
SELECT YEAR(curdate());
SELECT quarter(curdate());
SELECT week(curdate());
SELECT weekofyear(CURDATE());
SELECT dayofyear(CURDATE());
SELECT weekday(CURDATE());#MON-0,...,SUN-6
SELECT dayofweek(CURDATE());#SUN-1,...,SAT-7

SELECT datediff('2021-09-01',CURDATE());

SELECT ADDdATE(CURDATE(),INTERVAL 1 DAY);
SELECT date_add(curdate(), interval 1 MONTH);

SELECT subdate(curdate(),interval 1 MONTH);

#DATE FORMAT-YYYY-MM-DD#GIVING AND DISPLAYING IN DESIRED FORMAT
SELECT date_format('2021-09-07','%D/%M/%Y');#M-in words
SELECT date_format('2021-09-07','%d/%m/%Y');#m- in numeric
SELECT date_format('2021-09-07','%D-%M-%Y');#-can be used
SELECT date_format('2021-09-07','%D,/%M,/%Y');

#STR_TO_DATE#DESIRED FORMAT TO DATE FORMAT
SELECT str_to_date('10-09-2021','%d-%m-%y');

	#`giving the wrong date will throw null`
SELECT str_to_date('20-09-2021','%m-%d-%y');


SELECT str_to_date('09--/--20--/--2020','%m--/--%d--/--%y');
