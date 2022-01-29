/*
DAY 1-SUB QUERY
DAY 2-WINDOWS FUNCTION
DAY 3-DATA INTEGRITY-NORMALIZATION ACID
DAY 4-TRANSCATION PROCESSING & VIEWS

*/

/* DAY1-SUB QUERIES:-
1.SUB QUERY IS A QUERY WITHIN A QUERY
2.IT IS AN OTHER WAY OF FETCHING DATA FROM MULTIPLE TABLES.SOMETIMES FROM DIFFERENT TABLE
3.NEED COMMON COLUMN TO JOIN WITH MAIN QUERIES.
4.SUB QUERIES CAN BE WRITTEN IN ANYWHERE IN THE SELECT CLAUSE,FROM CLAUSE AND WHERE CLAUSE OF ANOTHER SQL QUERY
5.FIRST SUB QUERY IS EXECUTED THEN OUTER QUERY EXECUTED

TYPES OF SUB-QUERIES:-
1.SINGLE ROW SUB QUERIES:- A SUB QUERY THAT RETURNS A SINGLE VALUE AND FEEDS TO MAIN QUERY =,<,>,<=,>=,<> OPERATORS RELATIONAL
2.MULTIPLE ROW SUBQUERY:-SUB QUERY RETURNS MULTIPLE VALUES (MORE ROWS) TO THE MAIN QUERY IN,NOT IN,RELATIONAL OPERATORS WITH ANY,ALL
3.MULTIPLE COLUMN SUBQUERIES:-RETURNS ONE OR MORE COLUMNS
4.CORRELATED SUB-QUERY
5.NESTED SUBQUERIES:-SUBQUERIES ARE PLACED WITHIN ANOTHER SUBQUERY



*/

/*SINGLE ROW SUB-QUERIES
--1.WAQ EMPLOYEES WHO WORK IN MARKETING DEPARTMENT EMPLOYEES,DEPARTMENT_ID,DEPARTMENTS=MARKETING
*/
SELECT department_id 
FROM departments 
WHERE department_name='Marketing';

SELECT employee_id,department_id,first_name
FROM employees
WHERE department_id= #=EQUAL TO SO WE FETCH MARKETING IN SUB QUERY
(SELECT department_id 
FROM departments 
WHERE department_name='Marketing');

#2.OTHER THAN MARKETING
SELECT employee_id,department_id,first_name
FROM employees
WHERE department_id <> #<>NOT EQUAL-THEN WE CAN FETCH OTHER THAN MARKETING IN SUB QUERY
(SELECT department_id FROM departments WHERE department_name='Marketing');

#--3.WRITE A QUERY TO DISPLAY THE employee_id,first_name,last_name FROM ALL employees WHO EARN MORE THAN AVERAGE SALARY OF AN ORGANISATION
SELECT employee_id,first_name,last_name,salary 
FROM employees
WHERE SALARY >
(SELECT AVG(salary) FROM employees);

/*
MULTIPLE ROWS SUB-QUERY
*/
#--4.WHO EARN MORE THAN AVG SALARY OF ANY OF THE DEPARTMENT ->SALARY MATCHING WITH MULTIPLE ROWS SO WE NEED TO USE MULTIPLE ROW OPERATOR
SELECT employee_id,first_name,last_name,salary FROM employees
WHERE SALARY IN
(SELECT AVG(salary) 
FROM employees 
group by department_id);

#--5.LIST THE NAME OF THE EMPLOYEES,PAID MORE THAN 'NEENA'
SELECT first_name
FROM employees
WHERE SALARY > 
(SELECT salary FROM employees WHERE first_name='Neena');

#-- 6.LIST THE EMPLOYEES REPORTING TO PAYAM
SELECT employee_id,first_name 
FROM employees
WHERE manager_id =
(SELECT employee_id FROM employees WHERE first_name='Payam');

#--7.display the employee name and hiredate for all employees in the same department as clara.EXECLUDE CLARA
SELECT first_name,last_name,hire_date
FROM employees
WHERE department_id=
(SELECT department_id FROM employees WHERE first_name='clara');#INCLUDE CLARA

SELECT first_name,last_name,hire_date
FROM employees
WHERE department_id =
(SELECT department_id FROM employees WHERE first_name='clara' OR last_name='clara');#MULTIPLE NAME WHETHER IN first_name OR last_name

SELECT first_name,last_name,hire_date
FROM employees
WHERE department_id=
(SELECT department_id FROM employees WHERE first_name='clara')#SUB QUERY
AND first_name<>'clara';#EXCLUDE THE CLARA

SELECT first_name,last_name,hire_date
FROM employees
WHERE department_id=
(SELECT department_id FROM employees WHERE first_name='clara')#SUB QUERY
AND first_name!='clara';#EXCLUDE THE CLARA

#--8.SECOND HIGHEST SALARY SUB-QUERY
select employee_id,first_name,last_name
FROM employees
WHERE salary=
(select salary FROM employees order by salary DESC LIMIT 1,1);

select employee_id,first_name,MAX(SALARY) FROM EMPLOYEES
WHERE SALARY <
(select MAX(SALARY) FROM EMPLOYEES);

#9.WHO GETS THE SALARY MORE THAN THE MAXIMUM SALARY EARN BY THE employees WHO JOINED IN THE YEAR 1997
select employee_id,first_name,salary,department_name,city
FROM employees e
JOIN departments d
on e.department_id=d.department_id
join locations l
on d.location_id=l.location_id
WHERE SALARY>
(SELECT max(salary) 
from employees
where year(hire_date)=1997); #or hire_date like"%1997"

select employee_id,first_name,salary,department_name,city
FROM employees e
JOIN departments d
on e.department_id=d.department_id
join locations l
on d.location_id=l.location_id
WHERE SALARY>
(SELECT max(salary) 
from employees
where hire_date like '%1997%'); 

#10.write the name of all the managers
select first_name,department_id
from employees
where employee_id in 
(select manager_id
from employees
);

select first_name,department_id
from employees
where employee_id in 
(select manager_id
from departments
);

/*
CORRELATED SUBQUERY:-
1.WHEN MY SUBQUERY IS DEPENDING ON MAIN MAIN QUERY FOR VALUES 
2.TAGGING OF OUTER QUERY IS CALLED CORRELATED SUBQUERY
3.ORDER OF EXECUTION-EXECUTION ALSO CHANGES-MAIN QUERY IS EXECUTED AND THEN SUBQUERY IS EXECUTED
4.ORDER OF EXECUTION FROM WHERE CLAUSE
*/
#1.EMPLOYEE EARNING MORE THAN AVERAGE SALARY
SELECT employee_id,first_name,salary
FROM employees
WHERE salary >
(SELECT AVG(salary) FROM employees);

#EMPLOYEE EARNING MORE THAN AVERAGE SALARY OF HIS OWN DEPARTMENT
SELECT employee_id,first_name,salary
FROM employees e1
WHERE salary >
(SELECT AVG(salary) FROM employees e2
where e1.department_id=e2.department_id
);

/*working
101 2000 20
				2500 avg 20
102 3000 20

103 1500 30 
				2000 avg 30
104 2500 30
*/

/*#-EXISTS CLAUSE
EXISTANCE OF GIVEN CONDITION
T/F 
1/0
1.ONLY WHEN SUB QUERY EXECUTED THEN ONLY QUERY IS EXECUTED ELSE IT WONT EXECUTED.
2.CHECKS ONLY THE CONDITION
3.EXISTS DONT RETURN ANY values.if exists true the return else false then return non
4.MEMORY SPACE
*/
SELECT * FROM employees
WHERE department_id in
(SELECT department_id 
FROM employees
WHERE department_id=20);

SELECT * FROM employees
WHERE EXISTS
(SELECT department_id 
FROM employees
WHERE department_id=20);#ONLY WHEN SUB QUERY EXECUTED THEN ONLY QUERY IS EXECUTED ELSE IT WONT EXECUTED.

SELECT * FROM employees
WHERE EXISTS
(SELECT '1' #'1'-TO AVOID SYNTAX ERROR WE USE IT
FROM employees
WHERE department_id=20);

(SELECT 'RAM' #'1'-TO AVOID SYNTAX ERROR WE USE IT
FROM employees
WHERE department_id=20);

(SELECT 'RAM' #'1'-TO AVOID SYNTAX ERROR WE USE IT
FROM employees
WHERE department_id=80);

/*
SELECT * FROM employees
WHERE EXISTS
(SELECT department_id 
FROM employees
WHERE department_id=20000); #GIVES ERROR BECAUSE DEPARTMENT_ID!=20000
*/
#--DISPLAY ONLY THE DEPARTMENT WHICH HAS EMPLOYEES (ATLEAST 1 EMPLOYEE)
SELECT distinct e.department_id
FROM departments d,employees e
where e.department_id=d.department_id;

select department_id 
from departments d 
where department_id in
(select department_id from employees);

select department_name 
from departments d 
where exists
(select department_id
 FROM employees e 
where d.department_id=e.department_id);

#ANY,ALL OPERATOR-ACCOMPANY WITH RELATIONAL OPERATOR =ANY,=ALL,<ANY,<ALL,>,<=,>=
-- #EMPLOYEE AND DEPARTMENTS WHO BELONGS TO LOCATION 1700
select employee_id,first_name,e.department_id
from employees e 
join departments d
on e.department_id=d.department_id
where location_id=  1700;

select employee_id,first_name,e.department_id
from employees e 
where department_id in
(select department_id 
from departments 
where location_id=1700);

select employee_id,first_name,e.department_id
from employees e 
where department_id = ANY
(select department_id from departments where location_id=1700);

#--select department with highest average salary using sub query
select department_id,avg(SALARY)
from employees
group by department_id
HAVING AVG(SALARY)>=ALL
(select AVG(salary)
from employees group by department_id
);


