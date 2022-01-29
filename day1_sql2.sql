Employees who works in Marketing department
use hr;
select employee_id, department_id, first_name from employees
where department_id <> 
(select department_id from departments where department_name='marketing')

Write a query to display the employee id, employee 
name (first name and last name ) 
for all employees who earn more than the average salary of an organisation.

select employee_id, department_id, first_name, salary from employees
where salary <= 
(select avg(salary) from employees)

single row operator - =, <, <=
-- who earns  the average salary of any of the department

select employee_id, department_id, first_name, salary from employees
where salary in 
(select avg(salary) from employees group by department_id)


-- list the name of the employees, paid more than 'neena' 

select first_name from employees
where salary > 
(select salary from employees where first_name='neena')

List the employees reporting to payam

select employee_id, first_name from employees
where manager_id = 
( select employee_id  from employees where first_name='payam')

Display the employee name( first name and last name ) 
and hiredate for all employees in the same department as Clara. 
Exclude Clara. 33

select employee_id, first_name, hire_date from employees
where department_id= 
(select department_id from employees where first_name='clara')
and first_name<>'clara'

select employee_id, concat(first_name, ' ', last_name) name , hire_date
from employees where department_id  = (
select department_id from employees where first_name = 'Clara')
 and first_name != 'Clara'

-- 2nd second highest salary Sub query

select salary from employees
order by salary desc
limit 1,1;
or

SELECT first_name,last_name, salary
FROM employees
WHERE salary = 
(
SELECT salary
FROM employees
ORDER BY salary DESC LIMIT 1,1
);
or

select max(salary) from employees where salary < 
(select max(salary) from employees)


Write a query to display the employee id, first_name,
 salary, department name and city for all the employees 
who gets the salary more than the maximum salary earn by the employee 
who joined in the year 1997 -- 4

select e.first_name,department_name,city from 
employees e 
join departments d 
on e.department_id=d.department_id
join locations l
on d.location_id = l.location_id 
where salary>(select max(salary) from employees
where 1997=year(hire_date));
or
select first_name,salary, hire_date
from employees
where salary > (select max(salary) 
from employees where hire_date like '%1997%');


Write the name of all the managers 

SELECT CONCAT(first_name, " ", last_name) as name
FROM employees
WHERE employee_id IN 
(SELECT manager_id from departments where manager_id IS NOT NULL);
or
select first_name , department_id from employees where employee_id in 
(select distinct manager_id from employees)

select * from departments

SELECT CONCAT(first_name, " ", last_name) as name, job_title
FROM employees a
JOIN jobs b
ON a.job_id = b.job_id
WHERE b.job_title LIKE "%manager%"

-- Employees earning more than avg salary of his own department

select employee_id, first_name, salary from employees 
where salary> (select avg(salary) from employees )

-- correlated subquery
select employee_id, first_name, salary from employees e1
where salary> (select avg(salary) from employees e2 where
e1.department_id=e2.department_id)


101 2000 20  2500 avg 20
102 3000 20
103 1500 30  2000 avg 30
104 2500 30

Exists - 
existance of given condition
T/F
1/0

select * from employees where exists
(select 1 from employees where department_id=80) 

-- Display only the department which has employees (atleast 1 employee)

base departments - Master
compare employees 

select distinct department_id from departments

select distinct department_name 
from employees a
join departments b
on a.department_id = b.department_id
where employee_id is not null;

select distinct e.department_id from departments d , employees e
where e.department_id=d.department_id

select department_id from departments d where department_id in(
select department_id from employees) 

exits - correlated subquery 
select department_name from departments d where exists 
(select department_id from employees e where d.department_id=e.department_id)

ANY , ALL operator =ANY, =ALL,  >ANY, >ALL

salary >ANY (1000, 2000, 3000, 4000) salary>1000 or salary>2000
salary >ALL (1000, 2000, 3000, 4000) salary=1000 and  salary=2000

	
    Write a query find the employee details 
    and departments who belong to the location 1700

employees, departments

select department_id from departments where location_id = 1700

employees those department_id -> 1700

select employee_id,department_id from employees e 
where department_id in 
(select department_id from departments d where location_id=1700 
and e.department_id=d.department_id);

select e.employee_id, e.first_name, e.department_id 
from employees e where department_id = ANY
(select department_id from departments d where location_id = 1700);

select employee_id, department_id
from employees
where department_id =ANY 
(select department_id
from departments where location_id = 1700);

Write query selects the department with the highest average 
salary (using sub query)

select department_id, avg(salary) from employees group by department_id
 having avg(salary) >=ALL
 (select avg(salary) avgg from employees group by department_id)

select department_id , avg(salary)
from employees having avg(salary) =ANY (
select max(salary) from employees
group by department_id);

