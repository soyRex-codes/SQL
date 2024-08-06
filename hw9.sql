
/*Please notice that, assertions are not supported in PostgreSQL. So, you need to use standard SQL syntax to 
answer the above questions. You can write your answers in a .txt file and upload that to Brightspace. Please
write the question number and text before every question. */

--.[40 points] Consider the following database:

     salaried worker (name, office, phone, salary)
     hourly worker (name, hourly_wage)
    address (name, street, city)
	
	create table salaried_worker(
	name varchar(20) primary key,
	office varchar(50),
	phone numeric(10,0),
	salary numeric(6,2)
	);
	
	create table hourly_worker(
	name varchar(20) references salaried_worker,
	hourly_wage numeric(5,0)
	);
	
	create table address(
	name varchar(20) references salaried_worker,
	street varchar(50),
	city varchar(30)
	);
	

	
--1.Create an SQL assertion that ensures that every name that appears in the
-- relation address appears in either salaried_worker or hourly_worker, but not necessarily in both.

  create assertion address  --This assertion ensures that every name in the address relation appears in either salaried_worker or hourly_worker, but not necessarily in both.
  CHECK
      (not exists(select name from address
                   where name not in(
                    select name from salaried_worker
			          union 
			            select name from hourly_worker 
				   )
				)
		    );
 
--2.[20 points] Write an SQL statement to grant the user U1 the select authorization on the table student with the ability to pass the select privilege to other users.
grant select
on student
to U1 with grant option;

--3.[20 points] Write an SQL statement to revoke the grant option from the user U1.
revoke grant option for select on student from U1;

--4.[20 points] Write an SQL statement to create a role called manager, then assign this role to the user Green.*****************************************
create role manager;
grant manager to Green;
