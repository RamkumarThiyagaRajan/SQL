-- Average difference of hire_Date for each department
1: Lead Hire_date for all the records t current_date lead
2. Find the diff between hire_date and the lead date tt
3. Find the average days for each department 

select *,avg(diff_hire_date)
from
(select *, datediff(next_hire_date,hire_date) as diff_hire_date from
(select department_id,employee_id,hire_date,
lead(hire_date) over(partition by department_id order by hire_date asc) as next_hire_date
from employees) t
where next_hire_date is not null) s
group by department_id;

First_value() & Last_value() - Frame 

select department_id, employee_id, salary, last_value(salary) over(partition by department_id) from employees

Frames - slicing 

-- Rows BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW  Frame slicing
-- Rows between current row and unbounded following 
-- Rows between UNBOUNDED PRECEDING and unbounded following 
 -- 1 preceding and 1 following

select department_id, salary, 
sum(salary) over(partition by department_id Rows BETWEEN  1 preceding and 1 following ) tot
from employees 


Find the last day of first job of every employee 
select * from
(select *, 
first_value(end_date)over(partition by employee_id order by end_date asc) 
as last_date_of_first_job from job_history) t
group by employee_id
or
select employee_id, job_id, first_value(end_date) over(partition by employee_id ) last_day_of_employee
from job_history
group by employee_id;


salary invested for each department/ department_name, 
Want to project high expense interms of salary Windows function

select department_id, max(dept_expense) from
(select department_id, 
sum(salary)over(partition by department_id) as dept_expense from employees group by department_id) t 
where department_id is not null;


select department_id, dept_expense from
(select department_id, sum(salary)over(partition by department_id) as dept_expense from employees group by department_id) t 
where dept_expense >= all 
(select sum(salary)over(partition by department_id) as dept_expense from employees group by department_id);

or

select * from
(select t.department_id,t.total_expense,d.department_name,dense_rank() over (order by t.total_expense desc) as ranking
from
(select department_id,salary,sum(salary) over(partition by department_id) as total_expense
from employees 
group by department_id)t
join departments d
on t.department_id=d.department_id)s
where ranking=1

select department_id, sum_Salary from
(select department_id, rank() over(order by SUM_SALARY desc) rnk from (
select department_id, sum(salary) over(partition by department_id)  SUM_SALARY
from employees
)t)tt
where rnk=1


Ntile()

select department_id, sum(salary) over(partition by department_id)
from employees;

select department_id, sum(salary) sal from employees group by department_id order by sal desc


select SUM_SALARY,department_id, rank() over(order by SUM_SALARY desc) from (
select department_id, sum(salary) over(partition by department_id)  SUM_SALARY
from employees
)t
limit 1 ;

Ntile() clustering

select department_id, salary, ntile(3) over(partition by department_id order by salary desc) from employees  
scores
30 students
ntile(6) 
Random - class student list - Group capstone 

 Find out how many ‘IT_PROG’ are moderately paid in the office.

select * from
(select employee_id,first_name,job_id,salary,ntile(3) over(order by salary desc) as pay_grade
from employees
where job_id='it_prog')t
where pay_grade=2;
or
with t1 as
(
select employee_id, salary,
ntile(3) over (order by salary desc) grade
from employees where job_id='IT_PROG') 
select * from t1

or
-- sacle of 3 
select * from (select salary, employee_id,job_id, ntile(3) over ( order by salary desc ) clust from employees) t
where job_id = 'IT_PROG' and clust=2


select * from employee_details

 Find out the 3 employee with worst performance 
 from the entire office also mention the Department alongside
 
select department, employee_id, ntile(5) over(order by employee_rating) rate
from employee_details limit 3


Data Constraints - Data integrity
FK refers PK of other table 
Parent - child relationship Need information 
emp_off
e_id(PK), doj, dept, salary

emp_per
e_id(FK), add, blood, age

Banking 
Master /Transaction table 
customer Details - unique PK parent Master update a/c deletion not  
Customer transaction - Duplicacy FK loan EMI 36 12 
use trans;
drop table child;
drop table parent;
create table parent
( id int primary key,
name varchar(10)
);
desc child

create table child
( id int,
dept varchar(10),
salary int,
Foreign key(id) references parent(id) )

insert into parent values
( 100, 'AAA'),
(101, 'BBB'),
(102, 'CCC'),
(103, 'DDD'),
(104, 'EEE');

insert into child values
(101, 'MKT', 5000),
(101, 'MKT', 5000),
(102, 'sales', 5500),
(102, 'sales', 5500),
(103, 'IT', 5000);


select * from parent;
select * from child;

-- Not possible
delete from parent where id=101
update child set id=500 where id=102

-- ON DELETE RESTRICT ON UPDATE RESTRICT
-- ON DELETE CASCADE ON UPDATE CASCADE

create table parent
( id int primary key,
name varchar(10)
);

create table child
( id int,
dept varchar(10),
salary int,
Foreign key(id) references parent(id) ON DELETE CASCADE ON UPDATE CASCADE)

delete from parent where id=101
update parent set id=500 where id=102

-- ON DELETE set null ON UPDATE set null
create table child
( id int,
dept varchar(10),
salary int,
Foreign key(id) references parent(id) ON DELETE set null ON UPDATE set null)

delete from parent where id=101
update parent set id=500 where id=102

1NF, 2NF, 3NF 
Normalisation - 1NF - Atmoic values 2NF Partial dependancy / 3NF Transitive dependancy




