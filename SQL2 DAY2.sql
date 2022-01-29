/*CREATION OF TEMPORARY SUB-QUERY TABLES:-USES;BASE TABLE IS CREATED BASED ON OUR REQUIREMENT 2.OPTIMAL WAY OF DOING THE PROCESS 3.SAVES TIME AND QUICK SOLVING
1.DERIVED TABLE/INLINE TABLE/TEMPORARY TABLE-ORDER OF EXECUTION IS 'FROM CLAUSE'
2.CTE COMMON TABLE EXPRESSION

#SYNTAX-SELECT * FROM (SELECT * FROM DEPARTMENTS WHERE) T; #DERIVED TABLE/INLINE TABLE/TEMPORARY TABLE
1.a derived table is a virtual table that’s returned from a SELECT statement. 
This concept is similar to temporary tables, but using derived tables in your SELECT statements is much simpler 
because they don’t require all the steps that temporary tables do
2.derived tables, views, or temporary tables are actually faster in terms of database performance.
3.ALIAS NAME AND TABLE IS MANDATORY FOR DERIVED TABLE
4.
*/

#SALARY,NETPAY=SALARY+10000 ONLY THE EMPLOYEES SALARY AND NETPAY WHOSE NETPAY IS >20000
#NORMAL METHOD
SELECT employee_id,salary,salary+10000 NETSALARY 
FROM EMPLOYEES
WHERE SALARY+10000>20000;

SELECT employee_id,salary,salary+10000 NETSALARY 
FROM EMPLOYEES
HAVING NETSALARY>20000;

#TABLE METHOD:-1.DERIVED TABLE/INLINE TABLE/TEMPORARY TABLE-ORDER OF EXECUTION IS 'FROM CLAUSE'
SELECT * FROM 
(SELECT employee_id,salary,salary+10000 NETSALARY 
FROM EMPLOYEES) T #T  ---T IS THE TABLE WHICH IS TEMPORARY TABLE/DERIVED TABLE/
WHERE NETSALARY>20000;#OUTER QUERY

#----CTE COMMON TABLE 
#1.SCOPE OF EXPRESSION ALSO A TEMPORARY TABLE -FOR MULTIPLE LEVELS IN THE SAME QUERY

WITH t AS 
(SELECT employee_id,salary,salary+10000 NETSALARY FROM employees)
SELECT * FROM t where NETSALARY>20000;

#WE CAN CREATE CTE WITHOUT WHERE
WITH t AS 
(SELECT employee_id,salary,salary+10000 NETSALARY FROM employees)
SELECT * FROM t where NETSALARY>20000;

#WAQ--10TH HIGHEST SALARY
#DIRECT METHOD:-
SELECT employee_id,salary from employees
order by salary desc LIMIT 9,1;

SELECT employee_id,salary from employees
order by salary desc LIMIT 10;

SELECT MIN(SALARY) FROM
(SELECT employee_id,salary FROM employees order by salary DESC LIMIT 10) T;#DERIVED TABLE

WITH T AS
(SELECT employee_id,salary FROM employees order by salary DESC LIMIT 10)
SELECT MIN(SALARY) FROM T;

#FIND THE HIGHEST AVERAGE SALARY AMONG ALL THE DEPARTMENT
-- DERIVED TABLE >TAKE HAVING CLAUSE

SELECT department_id,AVG(SALARY)
FROM employees
group by department_id
HAVING ROUND(AVG(SALARY))=
(SELECT ROUND(MAX(AVG_SALARY))
FROM 
(SELECT AVG(SALARY) AVG_SALARY
FROM EMPLOYEES
group by department_id) T);

SELECT department_id,AVG(SALARY)
FROM employees
group by department_id
HAVING ROUND(AVG(SALARY),2)=
(SELECT ROUND(MAX(AVG_SALARY),2)
FROM 
(SELECT AVG(SALARY) AVG_SALARY
FROM EMPLOYEES
group by department_id) T);

WITH T AS 
(SELECT department_id,AVG(salary) AVG_SAL 
FROM employees
group by department_id)
SELECT * FROM T WHERE AVG_SAL=(SELECT MAX(AVG_SAL) FROM T);

DESC employees;

/*
#DISPLAY THE COUNT OF MANAGERS AND CLERKS ACROSS THE DEPARTMENTS
JOB_ID COUNT
MANAGER 40
CLERK   16

STEP 1 PULL OUT ALL CLERK AND MANAGER TABLE
STEP 2 COUNT THEM BASED ON THE CLERK/MANAGER CASE MANAGER CLERK
STEP 3- DISPLAY TOTAL COUNTS WITH TITLE
EMPLOYEES JOB_ID
*/

select j.job_id,count(j.job_id)
from 
(select case
when job_id like '%mgr%' then 'MANAGER'
when job_id like '%CLERK%' then 'CLERK'
end as job_id
FROM employees
WHERE job_id LIKE '%mgr%' OR job_id LIKE '%CLERK%') j
group by J.job_id;

-- SELECT CLAUSE--
#DISPLAY EMPLOYEE NAME ALONG WITH MANAGER NAME

SELECT first_name AS EMPLOYER_NAME,
(SELECT first_name 
FROM EMPLOYEES e1
WHERE e2.manager_id=e1.employee_id) MANAGER_NAME
FROM employees e2; #it is a correlated sub query

#DISPLAY DEPT_ID AND NAME


/*
windows function
ADVANCED/WINDOWING/OLAP-ANALYTICAL FUNCTION
OVER()/OVER CLAUSE IS MANDATE WITH PARANTHESIS 3 ARGUMENTS OPTIONAL-
PARTITION BY-GROUP BY
ORDER BY
FRAME-SLICING OF WINDOW/FRAMING

WINDOWS FUNCTION-RANKING FUNCTION,AGGREGATEFUNCTION,ANALYTICAL OPERATIONS FUNCTION

*/
#WINDOWS FUNCTION
-- #1.ROW NUMBER() FUNCTION FOLLOWED BY OVER CLAUSE()
SELECT row_number() over() 'S.NO',employee_id from employees;

select * from
(select row_number() over() 'S.No',employee_id,first_name,salary
from employees) t
where `S.No` between 20 and 30;

-- #2.RANKING FUNCTION
SELECT employee_id,first_name,salary, rank() over(order by salary desc) rnk
from employees;#position-since ranking is shared it skip other position

select * from 
(SELECT employee_id,first_name,salary, rank() over(order by salary desc) rnk
from employees)
where rnk=2;#difficult to find 2 entities then we use dense_rank

select * from 
(SELECT employee_id,first_name,salary, dense_rank()over(order by salary desc) drnk1
from employees);

#calculate percentages OF RANK BASIS ON FORMULA:(RANK-1)/(TOTAL ROWS-1)

select employee_id,first_name,salary,
rank()over(order by salary desc) rnk,
dense_rank()over(order by salary desc) drnk,
percent_rank()over(order by salary desc) percentile from employees;

-- latest HIRED DATE AND EMPLOYEE DETAILS
SELECT * FROM 
(SELECT employee_id,first_name,hire_date,dense_rank()OVER(order by hire_date DESC) AS LATEST_HIRED FROM EMPLOYEES) T
WHERE LATEST_HIRED=1;

#ANALYTICAL FUNCTION
#DISTRIBUTION OF RECORD MEANS-THE PERCENTAGE OF A RECORD OCCUPIED IN THE TOTAL RECORD SET.
#CUMULATIVE DISTRIBUTION MEANS-THE CUMULATIVE PERCENTAGE OF RECORDS FROM FIRST TO CURRENT ROW IS CALCULATED OUT OF THE TOTAL RESULT.

SELECT employee_id,first_name,salary,RANK()OVER(ORDER BY salary DESC) RNK,cume_dist() OVER(order by SALARY DESC) CUM_DISTRIBUTION
FROM employees;

#PARTITION BY
SELECT * FROM 
(
SELECT employee_id,first_name,department_id,salary,RANK()OVER(partition by department_id ORDER by SALARY DESC) RNK
FROM EMPLOYEES) T
WHERE RNK<=3;

/*AGGREGATE FUNCTION - COUNT,MAX,MIN,AVG*/
SELECT department_id,first_name,salary,COUNT(employee_id) OVER(partition by department_id) COUNTOFEMPLOYEES 
FROM employees;

SELECT department_id,first_name,salary,COUNT(employee_id) OVER(partition by department_id) COUNTOFEMPLOYEES,MIN(SALARY) over(order by department_id) MINSALARY
FROM employees;

#HOW MUCH THE DIFFERENCE IN SALARY BETWEEN THE EARNINGS AND MINIMUM OF HIS/HER DEPARTMENT
SELECT *,SALARY-MINSALARY
FROM(
SELECT department_id,first_name,salary,MIN(SALARY) over(partition by  department_id) MINSALARY
FROM employees) T;

#HOW MUCH THE DIFFERENCE IN SALARY BETWEEN THE EARNINGS AND MINIMUM OF HIS/HER DEPARTMENT
#THEN LIST THOSE EMPLOYEES SALARY IS EQUAL TO MINIMUM SALARY
SELECT *,SALARY-MINSALARY
FROM(
SELECT department_id,first_name,salary,MIN(SALARY) over(partition by  department_id) MINSALARY
FROM employees) T
WHERE SALARY-MINSALARY=0;#OR SALARY=MINSALARY

#LEAD()-NEXT,LAG()-BEFORE VALUES
SELECT employee_id,salary,LEAD(salary) over() LEAD_VAL FROM employees;

SELECT employee_id,salary,LAG(salary) over() LAG_VAL FROM employees;

SELECT department_id,employee_id,salary,LAG(salary) over(partition by department_id) LAG_VAL FROM employees;
SELECT department_id,employee_id,salary,LEAD(salary) over(partition by department_id) LEAD_VAL FROM employees;

-- EX: WAQ FIRST DESIGNATION AND DATE,PROMOTED DESIGNATION AND DATE
SELECT * FROM
(SELECT employee_id,start_date,job_id,LEAD(start_date) OVER(partition by department_id) PROMO_DATE,
LEAD(job_id) over(partition by employee_id) PROMO_ID
FROM job_history)T
WHERE PROMO_DATE IS NOT NULL AND PROMO_ID IS NOT NULL;

#NTILE(COL,2)>BUCKETS/TILES LIKE 111,222,333
USE HR;
SELECT *,NTILE(10) OVER() AS GRUP_NO
FROM employees;

-- AVERAGE DIFFERENCE IN HIRE_DATE FOR EACH DEPARTMENT
#STEP1:LEAD HIRE_DATE FOR ALL THE RECORDS
#STEP2:FIND DIFF B/W HIRE_DATE AND LEAD DATE
#STEP 3:FIND THE AVERAGE DATES FOR EACH DEPARTMENT
select *,avg(diff_hire_date)
from
(select *, datediff(next_hire_date,hire_date) as diff_hire_date 
from
(select department_id,employee_id,hire_date,lead(hire_date) over(partition by department_id order by hire_date asc) as next_hire_date
from employees) t
where next_hire_date is not null) s
group by department_id;



