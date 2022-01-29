# Datasets used: employee_details.csv and Department_Details.csv
create database takehome;
use takehome;
# Use subqueries to answer every question

CREATE SCHEMA IF NOT EXISTS Employee;
USE Employee;
# import csv files in Employee database.

SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;


#Q1. Retrive employee_id , first_name , last_name and salary details of those employees whose salary is greater than the average salary of all the employees.
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY
from employee_details
where SALARY >
(select avg(SALARY)
from employee_details);


#Q2. Display first_name , last_name and department_id of those employee where the location_id of their department is 1700
select FIRST_NAME,LAST_NAME,DEPARTMENT_ID
from employee_details
where DEPARTMENT_ID in
(select DEPARTMENT_ID
from department_details
where LOCATION_ID=1700);


#Q3. From the table employees_details, extract the employee_id, first_name, last_name, job_id and department_id who work in  any of the departments of Shipping, Executive and Finance.
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,JOB_ID,DEPARTMENT_ID
from employee_details
where DEPARTMENT_ID in
(select DEPARTMENT_ID
from department_details
where DEPARTMENT_NAME in  ('Shipping','Executive','Finance'));


#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the CLERKS who earn more than the salary of any IT_PROGRAMMER.
select FIRST_NAME,LAST_NAME,SALARY,PHONE_NUMBER,EMAIL
from employee_details
where JOB_ID  like '%CLERK' and salary > any
(select salary
from employee_details
where JOB_ID='IT_PROG');


#Q5. Extract employee_id, first_name, last_name,salary, phone_number, email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,PHONE_NUMBER,EMAIL
from employee_details
where JOB_ID like '%AC_ACCOUNTANT' and salary > all
(select salary 
from employee_details
where JOB_ID='AD_VP');

#Q6. Write a Query to display the employee_id, first_name, last_name, department_id of the employees 
#who have been recruited in the recent half timeline since the recruiting began. 

SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,DEPARTMENT_ID 
FROM EMPLOYEE_DETAILS 
WHERE str_to_date(HIRE_DATE,'%d-%c-%Y') > 
(SELECT date_add(min(str_to_date(hire_date,'%d-%c-%Y')),interval round(DATEDIFF(MAX(str_to_date(HIRE_DATE,'%d-%c-%Y')),MIN(str_to_date(HIRE_DATE,'%d-%c-%Y')))/2,0) day)
FROM EMPLOYEE_DETAILS);



#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees belonging to the 'Contracting' department 
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,PHONE_NUMBER,SALARY,JOB_ID
from employee_details
where DEPARTMENT_ID in
(select DEPARTMENT_ID
from department_details
where DEPARTMENT_NAME ='%Contracting');

#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees who does not belong to 'Contracting' department
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,PHONE_NUMBER,SALARY,JOB_ID
from employee_details
where DEPARTMENT_ID in
(select DEPARTMENT_ID
from department_details
where DEPARTMENT_NAME !='%Contracting');

select EMPLOYEE_ID,FIRST_NAME,LAST_NAME,PHONE_NUMBER,SALARY,JOB_ID
from employee_details
where DEPARTMENT_ID not in
(select DEPARTMENT_ID
from department_details
where DEPARTMENT_NAME ='%Contracting');

#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the employees who were recruited first in the department
select employee_id, first_name, last_name, job_id, department_id,min(distinct(str_to_date(hire_date,'%d-%c-%Y')))
from employee_details 
where (department_id,str_to_date(hire_date,'%d-%c-%Y'))in
(select distinct department_id,min(distinct(str_to_date(hire_date,'%d-%c-%Y'))) 
min_hire_date from employee_details
group by department_id)
group by employee_id, first_name, last_name, job_id,department_id
order by department_id;


#Q10. Display the employee_id, first_name, last_name, salary and job_id of the employees who earn maximum salary for every job.
select employee_id,first_name,last_name,salary,job_id
from employee_details 
where (job_id,salary) = any
( select job_id,max(salary) from employee_details group by job_id );

