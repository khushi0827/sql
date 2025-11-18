create database data_analytics;
USE data_analytics;
 create table Employee(EMP_ID smallint primary Key auto_increment ,
`EMPLOYEE NAME`char(20) NOT NULL,
REGION ENUM("NORTH","SOUTH","EAST","WEST"),
AGE TINYINT CHECK(AGE BETWEEN 18 AND 60),
SALARY INT CHECK(SALARY>0),
JOINING_DATE DATE,
FEEDBACK BOOL);

select*from data_analytics.employee;
select*from employee;

insert into employee()
values(1,"kunal","NORTH",30,99999999,"2025-11-12",TRUE);

-- numbers
-- tinyint(0-255)(-125+126) 1Bytes
-- Smallint(0-65000)4bytes
-- int
-- bigint bytes

-- text
-- text,tinytext,smalltext,bigtext
-- char,varchar,nvarchar

-- DATE,DATETIME,TIMESTAMP
CREATE table EMPLOYEES(employeeid int ,firstname char(20),lastname char(20),department varchar(30),salary int check(salary>0));
select*from data_analytics.employees;
create table customers( CustomerID smallint  auto_increment primary key , `Name` char(20), Email varchar(20),Phone varchar(100) unique,  Address varchar(100));
select*from data_analytics.customers;
drop table employee;
create table Employee(EMP_ID smallint primary Key auto_increment ,
`EMPLOYEE NAME`char(20) NOT NULL,
REGION ENUM("NORTH","SOUTH","EAST","WEST"),
AGE TINYINT CHECK(AGE BETWEEN 18 AND 60),
SALARY INT CHECK(SALARY>0),
JOINING_DATE DATE,
FEEDBACK BOOL,
phone_number varchar(10) check (phone_number regexp "^\\+91-[0-9]{10}$"));

alter table employee  modify column phone_number varchar(14) check( phone_number regexp "^\\+91-[0-9]{10}$");
insert into employee()
values(1,"kunal","North",30,999999,now(),True,"+91-8860065479");
select*from employee;

create table orders ( order_id int primary key  auto_increment ,
emp_id smallint ,
product_name char(20),
price decimal(8,2),
foreign key (emp_id) references employee(emp_id)
); 
insert into orders()
values(11,1,"Laptop",35000);
select*from orders;

-- DDL [Create | Alter | Rename | drop ]

-- Table name change
rename table employee to emp ;
-- column name change 
alter table emp rename column Region to R ;

drop table customers;
drop table employees;
-- modify data typ of a column
alter table emp modify column `Employee name` char(50) not null;
-- remove primary key and foriegn key
alter table orders drop constraint orders_ibfk_1 ;
alter table emp modify column emp_id smallint ;
alter table emp drop primary key;
-- add primary key and foreign key 
alter table emp modify column emp_id smallint primary key auto_increment;
alter table orders add constraint foreign key (emp_id) references emp(emp_id);
use classicmodels;
select*from customers;
select count(*) from customers;
select distinct state from customers;
select count(distinct state) from customers; 