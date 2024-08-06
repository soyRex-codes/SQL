--NAME: RAJKUMAR KUSHWAHA

--Question no.1--
--1. [30 points] Give an SQL schema definition for the following employee database:

--employee (employee name, street, city)--
--works (employee name, company_name, salary)--
--company (company name, city)--
--manages(employee name, manager_name)--

-- Dropping existing tables
DROP TABLE IF EXISTS manages;
DROP TABLE IF EXISTS works;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS employee;

create table employee(employee_name varchar(50), street varchar(50), city varchar(50),
primary key(employee_name));

create table company(company_name varchar(50), city varchar(50),
primary key(company_name)
);
--NOTE: Foreign Key Requirements: A foreign key creates a link between two tables by ensuring that the values in the foreign key column correspond to values in the referenced column. This is typically used to maintain referential integrity for identifiers (like employee IDs, company IDs, etc.), not for general attributes like city names.--
            
--primary key depends on the table type, eg for employee, his name is primary key but for works compnay name is p[rimary key not the employee-name--
create  table works(employee_name varchar(50), company_name varchar(50), salary numeric(8,2),
            primary key(employee_name, company_name),
            foreign key(employee_name) references employee(employee_name),
            foreign key(company_name) references company(company_name)
            );

create table manages(employee_name varchar(50), manager_name varchar(50),
primary key(employee_name, manager_name),
foreign key(employee_name) references employee(employee_name)
); -- the reason manger_name as a foreign key referencing employee_name is manager is also an employee who can be found on employee table if searched--

--Question no.2--
--2. [20 points] Populate the tables you created for the previous question with data (i.e, write SQL insert statements to insert data in the tables). You need to insert at least three rows in each table. Be careful about the order you populate the tables with data.

insert into employee values('sam', 'harrison', 'Springfield');
 insert into employee values('max', 'campbell', 'Springfield');
  insert into employee values('alpha', 'grand', 'Springfield');

  insert into company values('First Bank Corporation', 'Springfield');
   insert into company values('City utilties', 'Springfield');
    insert into company values('Mediacom', 'springfield');

  insert into works values('sam', 'First Bank Corporation', 66000.00);
   insert into works values('max', 'City utilties', 99000.00);
    insert into works values('alpha', 'Mediacom', 88000.00);
 
-- in manages, I have used similar or same employee_name and manager_name, it is because there was a possibility that a manager is also an employee for the company--
  insert into manages values('sam', 'max');
   insert into manages values('max', 'alpha');                  
    insert into manages values('alpha', 'sam');                 
    
--Question no 3
--[50 points; each part is worth 10 points] For this question, you are not allowed to use any SQL command that was not covered in module 5. Answers that use SQL commands covered in modules after module 5 will be considered wrong. Write SQL queries to answer the following questions:
--1. Find the names of all employees who work for “First Bank Corporation”.
select employee_name
from works
where company_name = 'First Bank Corporation';
--i am selecting employee_name, which retrieves the names of employees who fulfill the condition specified in the WHERE clause.--

--2. Find the company_name and city for every company. Order the output in alphabetical order by company_name.
select company_name, city
from company
order by company_name;

--3. Find the names of the employees who make a salary of at least $65,000. Notice: in the query the value should be specified as 65000.
 
 select employee_name
 from works
 where salary >= 65000;
 
-- 4.Find all employees in the database who live in the same cities as the companies for which they work.

select e.employee_name
from employee e
join works w ON e.employee_name = w.employee_name
join company c ON w.company_name = c.company_name
where e.city = c.city;

--5. Find all employees in the database who live in the same cities and on the same streets as do their managers.
select e.employee_name
from employee e
join manages m ON e.employee_name = m.employee_name
join employee manager ON m.manager_name = manager.employee_name
where e.city = manager.city
  and e.street = manager.street;



 
    