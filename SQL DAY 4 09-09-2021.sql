#DAY 4-JOINS
/*
-JOINS-HELP US TO COMBINE DATA FROM 2 OR MORE TABLE AND DISPLAY THEN AS SIMNGLE RESULT SET.
-WE CAN WRITE JOIN BETWEEN 2 RELATED TABLES USING FOREIGN KEY AND PRIMARY KEY RELATIONSHIP BETWEEN THEM
*/
#1.WAQ TO DISPLAY THE DISPLAY THE DETAILS OF EMPLOYEES AND THE NAME OF THE DEPARTMENT
select e.employee_id, e.first_name, e.last_name,
e.department_id, d.department_name
from Employees e
join Departments d
on e.department_id = d.department_id;#'ON ='IS CALLED EQUAL JOINS BY ANSI(AMERICAN STANDARD INSTITUTE) PROGRAM,OTHER THAN '=' IS NOT ANSI STANDARD IS CALLED NON EQUAL JOINS

/*
INNER JOINS-
i.ONLY THOSE ROWS RECORDS ARE MATCHING ONLY  IN BOTH TABLE ARE DISPLAYED.
ii.IT WILL NOT TAKE NULL VALUES
iii.directly applied in mysql by keyword inner or by just using join
iv.INNER JOIN-COMMON ROWS

OUTER JOINS:-
-1.LEFT OUTER JOINS LOJ-
i.ALONG WITH MATCHING RECORDS+ALL VALUES FROM LEFT TABLE+whererever no match-null values I.E INNER+LEFT TABLE
-2.RIGHT OUTER JOINS ROJ-
i.ALONG WITH MATCHING RECORDS+ALL  VALUES FROM RIGHT TABLE+whererever no match-null values I.E INNER+RIGHT TABLE
-3.FULL OUTER JOINS FOJ-
iALL ALONG WITH MATCHING RECORDS+ALL NON MATCHING VALUES FROM LEFT TABLE AND NON MATCHING VALUES FROM RIGHT TABLE
ii.NO DIRECT KEYWORD IN MYSQL BUT CAN BE PERFORMED BY USING UNION

IN MYSQL ONLY LOJ,ROJ.NO FOJ DIRECTLY IN MYSQL BUT WE CAN PERFORM BY IN-DIRECTLY
*/
#INNER JOIN-COMMON ROWS
select e.employee_id, e.first_name, e.last_name,
e.department_id, d.department_name
from Employees e
join Departments d #default join
on e.department_id = d.department_id;#INNER JOIN-COMMON ROWS

select e.employee_id, e.first_name, e.last_name,
e.department_id, d.department_name
from Employees e
inner join Departments d #using keyword inner join
on e.department_id = d.department_id;#INNER JOIN-COMMON ROWS

#LEFT JOIN:-INNER + EXCESS FROM LEFT
select e.employee_id, e.first_name, e.last_name,
e.department_id, d.department_name
from Employees e
LEFT join Departments d#INNER + EXCESS FROM LEFT
on e.department_id = d.department_id;

#RIGHT JOIN:-INNER + EXCESS FROM RIGHT
select e.employee_id, e.first_name, e.last_name,
e.department_id, d.department_name
from Employees e
RIGHT join Departments d#INNER + EXCESS FROM RIGHT
on e.department_id = d.department_id;


#FULL OUTER JOIN-#FULL OUTER JOIN KEYWORD NOT THERE,SO WE CAN USE UNION

select e.employee_id, e.first_name, e.last_name,
e.department_id, d.department_name
from Employees e
LEFT join Departments d 
on e.department_id = d.department_id

UNION #INNER+EXCESS FROM LEFT+EXCESS FROM RIGHT

select e.employee_id, e.first_name, e.last_name,
e.department_id, d.department_name
from Employees e
RIGHT join Departments d 
on e.department_id = d.department_id;

#OTHER USING ()-TO AVOID CONFUSION
(select e.employee_id, e.first_name, e.last_name,
e.department_id, d.department_name
from Employees e
LEFT join Departments d 
on e.department_id = d.department_id)

UNION #INNER+EXCESS FROM LEFT+EXCESS FROM RIGHT

(select e.employee_id, e.first_name, e.last_name,
e.department_id, d.department_name
from Employees e
RIGHT join Departments d 
on e.department_id = d.department_id);

/*
CROSS JOIN
NATURAL JOIN
SELF JOIN
*/

#2.WAQ TO DISPLAY THE DETAILS OF THE EMPLOYEES AND THEIR JOB TITLES.
select employee_id,first_name,last_name
from employees e
join jobs j
on e.job_id=j.job_id;

#3.WAQ TO DISPLAY DETAILS OF EMPLOYEES,NAMES OF DEPARTMENTS AND THE CITY THEY WORK IN.
SELECT employee_id,first_name,last_name,e.department_id,d.department_name,l.city
FROM employees e
JOIN departments d
ON e.department_id=d.department_id
join locations l
on d.location_id=l.location_id;

#4.WAQ TO DISPLAY THE DETAILS OF EMPLOYEES,NAMES OF THE DEPARTMENTS AND CITY FOR THOSE WHO WORK IN SEATTLE
SELECT employee_id,first_name,last_name,e.department_id,l.city
from employees e
join departments d 
on e.department_id=d.department_id
join locations l
on l.location_id=d.location_id
where l.city='SEATTLE';

/*statement skeleton
select
from
join
on
......many join on
......
where
group by
having
order by
limit
*/

#5.WAQ TO DISPLAY THE DETAILS OF EMPLOYEES,NAMES OF THE DEPARTMENT,CITY AND REGIONS THEY WORK IN.
SELECT employee_id,first_name,last_name,D.department_name,L.city,R.region_name
FROM EMPLOYEES E
JOIN departments D
ON E.department_id=D.department_id
JOIN locations L
ON L.location_id=D.location_id
JOIN countries C
ON C.country_id=L.country_id
JOIN regions R
ON R.region_id=C.region_id;

#6.WAQ TO LIST THE COUNTRIES AND THE NAMES OF THE REGION THEY BELONG TO.
SELECT country_name,r.region_name
FROM countries c
JOIN regions r
ON r.region_id=c.region_id;

#Q7. WAQ to get the details of the employees along with the names of the departments they work in.Also include such employees in the 
#result set who have not been allotted to any department.
select e.employee_id,first_name,last_name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id;


#Q8. WAQ to display the name of the employees, the department names ,job titles of those who are some kind of managers.
select e.employee_id,e.first_name,e.last_name,d.department_name,j.job_title
from employees e
join departments d
on e.department_id=d.department_id
join jobs j
on e.job_id=j.job_id
where job_title like '%manager%';

/*
CROSS JOIN-CARTESAN PRODUCT
EX: TABLE 1-10
TABLE 2-2
RESULT:20 i.e m*n
uses:-
1.all combination
2.ex colour matching with size

SYNTAX:-
FROM TABLE 1
CROSS JOIN TABLE 2;

OR 
SELECT *
FROM TABLE 1
JOIN/CROSS JOIN TABLE2;

CROSS JOIN:-
1.DO NOT HAVE 'ON'
2.USE CROSS JOIN-ONLY WHEN THE TABLE ARE SMALL
3.OTHERWISE IT CAN TAKE HUGE MEMORY SPACE
4.SO USE WHERE CLAUSE
5.CROSS PRODUCT B/W TWO TABLE 
6.EVERY ROW OF 1ST TABLE IS MAPPED WITH EVERY ROW OF 2ND TABLE
*/

/*NATURAL JOIN-PROMITIVE KIND OF JOIN WHICH JOINS TABLE BASED ON COLUMNS HAVE SAME NAME AND DATA TYPE:-
1.BUT IT DOES NOT MAKE ANY SENSE-IT GIVES RUBBISH RESULT
2.IT CAN BE USED ONLY WHEN SAME PRIMARY KEY AND FOREIGN KEY
3.NO ON CONDITION IS USED
SELECT * FROM TABLE1
NATURAL JOIN TABLE2;
*/

#Q9. WAQ to display the names of the departments and the number of employees working in the department ,
# along with the average salary drawn in the department.
SELECT D.department_name,COUNT(*) as emp_count,AVG(E.salary) as dept_avg_salary
FROM departments D
JOIN  EMPLOYEES E
ON E.department_id=D.department_id
group by department_name;

#Q10. WAQ to display the names of the departments and the average salary drawn 
# in the department where the average is more than 10000. 
SELECT D.department_name,AVG(e.salary) as dept_avg_salary
FROM departments D
JOIN  EMPLOYEES E
ON E.department_id=D.department_id
group by department_name
having AVG(E.salary)>10000;


#Q11. WAQ to display the department ids, names of the departments 
#and the details about the person managing them.

select d.department_id,d.department_name,d.manager_id
from departments d
join employees e
on e.employee_id=d.manager_id;


/*
self join:-
1.WHEN THERE IS self REFERENCING IS HAPPENING
2.TABLE IS JOINED WITH ITSELF
3.TWO COPIES OF SAME TABLE ARE CREATED IN THE MEMORY WITH DIFFERENT ALLIAS
4.NO SPECIAL KEYWORD IS USED FOR SELF JOIN-WE USE ONLY JOIN KEYWORD IS USED
5.ON CONDITION IS USED
6.use case:-
inorder to findout self-out employee and whom they report

*/
select E.employee_id,E.first_name,E.last_name
from employees E
JOIN employees M
ON E.manager_id=M.employee_id;

select E.employee_id,E.first_name,E.last_name,M.manager_id,M.first_name,M.last_name
from employees E
JOIN employees M
ON E.manager_id=M.employee_id;

