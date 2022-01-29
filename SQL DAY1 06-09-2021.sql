/*DATA IS A COLLECTION OF MEANINGFUL INFORMATION
DATABASE-COLLECTION OR PLACEHOLDER OF DATA IS DATABASE
DBMS-DATABASE MANAGEMENT SYSTEM-APPLICATION
RDBMS-RELATIONAL DTABASE MANGEMENT SYSTEM-BECAUSE THEY ARE MADEUP OF TABLES/RELATIONS>THEY ARE RELATED TO EACHOTHER,IT USES RELATIONAL ALGEBRA
TABLES-ROWS/TUPLES/RECORDS,COLUMNS/ATTRIBUTES/FIELDS

SQL-DDL,DML,DQL,DCL,TCL

DDL-DATA DEFINITION LANGUAGE IT DEALS WITH STRUCTURE/SCHEMA OF THE DATA
DDL-AUTO COMMIT(DONE IS DONE COMMITING AUTOMATICALLY)
1.CREATE-DATBASE/TABLE
2.ALTER-ADD COLUMN DROP COLUMN MODIFY COLUMN
3.DROP-DROP THE ENTIRE SCHEMA-INDROP WE CANOT ROLL BACK CTRL+Z
4..TRUNCATE-
i.DELETE ENTIRE DATA SET
ii.STRUCTURE REMAINS THERE
iii.we can not roll back because ddl is autocommit
iv.for memory savings

DML-DATA MANIPULATION LANGUAGE
DML-
1.INSERT-INSERT VALUES INTO TABLE
2.UPDATE-UPDATE A TABLE
3.DELETE-
i.DELETE SPECIFIC RECORD 
ii.DELETE-DELETE SPECIFIC COLUMN-i.e partial deletion/ROW WE CAN ROLLBACK.


DQL-DATA QUERY LANGUAGE BY SELECT
WHERE-FILTER CONDITION WHERE WE CAN ADD /DELETE-RELATIONAL(), AND OR,LIKE,BETWEEN,IN
HAVING- FILTERING AGGREGATE FUNCTION

OPERATORS:-
1.COMPARISON OPERATOR:<,>,<=,>=,>=
2.LOGICAL OPERATOR:and or not
3.BOOLEAN OPERATOR:true/false
KEYS:
1.UNIQUE KEY:UNIQUE VALUES
2.CANDIDATE KEY:UNIQUE VALUES+NOT NULL
3.PRIMARY KEYS-UNIQUE,USE LESS MEMORY,EASY TO SORT AUTO GENERATE SEARCH,CAN BE INTEGER-DEPEND ON DOMAIN
4.ALTERNATE KEY:THOSE ARE NOT TAKEN AS PRIMARY KET ARE ALTERNATE KEYS
5.FOREIGN KEYS:HAVE A RELATION SHIP


/* COMMAND GROUPS:
DDL-CREATE DROP ALTER TRUNCATE
DML
DQL
*/
#DDL-DATA DEFINITION LANGUAGE:-CREATE,ALTER,DROP,RENAME
	create database CHN_JUL21; #CREATE  A DATABASE/CREATING
    
    
    #DROP-REMOVES THE DATABASE FROM THE TOOL
    drop database CHN_JUL21;
    
   /*
   SQL IS CASE INSENSITIVE-ALL THE COMMANDS ARE ALSO CASE INSENSITIVE
   BUT THE DATA WE HAVE IS A CASE SENSITIVE IN ALL TOOLS
   BUT MYSQL BOTH COMMANDS AND DATA ARE CASE INSENSTIVE
   */
   
   use  CHN_JUL21;
    /*
    Student-Table Name
    attributes-sid(int),sname(varchar),phno(char but not in int because loss of data,we have no attribute),email-id(varchar(50))
    */
    /*CREATE Table Tablename
    (
    colname1 datatype,
    colname2 datatype,
    colname3 datatype,
    ,.........,
    );
    */
    create table students(
    sid int,
    sname varchar(50),
    phno char(10),
    emailid varchar(50)
    );
    
    #DESCRIBE THE STRUCTURE OF THE TABLE
    desc students;
    
    #DROP table USING:
    /*
    DROP TABLE STUDENTS;
    */
    drop table students;#droping the table students
    
    create table students(
    sid int,
    sname varchar(50),
    phno char(10),
    emailid varchar(50)
    );#again creating of dropping table
    
    desc students;
    
    #ALTER THE TABLE-add a column,drop a column,modify column,rename column,add constraints,drop constraints
    #alter table name add column name  dtype;
    #alter table name drop column name  ;
    #alter table name modify column name  dtype;#modify the datatype
    #alter table name change column name  columndtype;
    #alter table name rename column name  to newcolumn name;
    /*
    ADD DROP RENAME CHANGE THE DATATYPE,ADD CERTAIN CONSTRAIN,REMOVE THE CONSTRAIN
    ALTER TABLE STUDENTS ADD COLUMN DOB DATE;
    */
    alter table students add column dob date;
    
    desc students;
    
    #droping using alter
    alter table students drop column dob;
    
    desc students;
    alter table students add column age int;
    #DML:
    #INSERT- INSERT INTO STUDENTS(SID,SNAME,PHNO,EMAILID,DOB) VALUES(1,'A','99999',A@GMAIL.COM,25);
    
    insert into students(SID,SNAME,PHNO,EMAILID,age)
    values(1,'a','9999','a@gmail.com',25);
    
    select *
    from students;#viewing the table
    
    insert into students(SID,SNAME,PHNO,EMAILID,age)
    values(2,'b','7299','b@gmail.com',24),
    (3,'c','9999','c@gmail.com',25),
    (4,'d','9299','d@gmail.com',26);
    
    select *
    from students;
    
    Insert into students(SID,SNAME,PHNO,EMAILID,age)
    values (5,'e','9895','e@gmail.com',24);# or v can use insert into students values(5,'e','9895','e@gmail.com',25)
    
    select *
    from students;
    
    /*
    UPDATE UPDATE TABLENAME SET AGE=26 WHERE ID=4;
    */
    #UPDATE-MYSQL DEFAULT SAFE UPDATE AND SAFE DELETE MODE WITHOUT PRIMARY KEY,SO REMOVE PREFERENCE IN EDIT-preference-sql editor-safe updates 
    
    update students
    set age=25
    where sid=4;
    
    select *
    from students;
    
    #delete
    delete from students
    where emailid='a@gail.com';#only a few column
    
    select *
    from students;
    
    #DDL-TRUNCATE DELETE WHOLE OF THE DATA AND ONLY STRUCTURE WILL REMAIN/delete all the values but the table will be there-IN TRUNCATE WE CANNOT UNDO
    truncate students;
    
    #drop table-completly drop the data and also clear entire structure
    
    /*
    DQL-SELECT STATEMENT
    */
    insert into students(SID,SNAME,PHNO,EMAILID,age)
    values(1,'a','9999','a@gmail.com',25),
    (2,'b','7299','b@gmail.com',24),
    (3,'c','9999','c@gmail.com',25),
    (4,'d','9299','d@gmail.com',26),
    (5,'e','9895','e@gmail.com',24);
    
    #select
    SELECT *
    from students;
    
    select sid,sname
    from students;#select column
    
    select *
    from students
    where sid=1;#filtering the rows
    
    select *
    from students
    where age>25;#filtering the rows-#selected all column entity
    
    select sid,sname
    from students
    where age>25;#filtering the rows-#selected 2 column entity
    
    #limit-default donot skip
    /*
    limit used to limit the no of rows displayedas output
    limit offset,num;
    #offset-no of rows to skip while displaying.
    */
    select * from students
    limit 2;
    
    select * from students
    limit 2,1;#first 2 will skip and displays 3rd one
    
    #HR DATABASE
    use hr;
    
    show tables;
    
    select * from employees;
    /*
    different where 
    */
    #Q1.WAQ TO LIST THE EMPLOYEES WORKING IN DEPT ID10?
    select * from employees where department_id=10;
    
    #Q2.WAQ TO LIST THE EMPLOYEES WORKING IN DEPT ID10,20?
    select * from employees where department_id=10 or department_id=20;#or tired of writing or 
    #simple way/alternate way/easy way-'in operator'  opposite-#not in operator
    select *
    from employees
    where department_id in(10,20,30,40);#one particular value
    
    #Q3.WAQ TO LIST EMPLOYEES WORKING IN THE DEPTID 80 AND HAVING SALARY >10000?
    select * from employees where department_id=80 and salary=10000; #using and operator
    
    #for range we can use between
    select * 
    from employees 
    where department_id=80 
    and salary between 10000 and 15000;
   
    
    
    
    
    