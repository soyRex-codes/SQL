--Rajkumar Kushwaha
--HW8.sql
--Part 1. 
/* SQL aggregate functions can generally be used in the select and having clauses. An aggregate function can be used in the where clause if this usage is done in a
subquery and if the result of the subquery can be fully computed and the result is known before the outer query executes. Also remember that for many correlated
subqueries, the inner query is computed fully for each tuple from the outer subquery. Keeping this in mind, answer the following questions using the university
database: */

--1.[5 points] (Similar to Q1 HW 6) Find the number of students in each department. Rename the count as numbStudents. I.e., schema of the output should be (dept_name, numbStudents).
select dept_name, count(ID) as numbStudents
from student
group by dept_name;
--2.[5 points] (Similar to Q2 HW 6) For departments that have at least three students, find department name and number of students. Rename the second attribute in the output as numbStudents. 
select dept_name, count(ID) as numbStudents
from student
group by dept_name
having count(distinct ID)>=3;
--3.	[10 points] Use the set membership operator to find the names of students that have taken at least three courses.  
select name
from student
where ID in (select ID
              from takes
			  group by ID
			  having count(course_id)>=3);
--4.[10 points] Use the with clause to create a temporary relation to find the names of students that have taken at least three courses.   
with std3 As (
select ID
from takes
group by ID
having count(course_id)>=3
)

select student.name
from student, std3
where student.ID=std3.ID;

--5.	[10 points] Use the exists construct to find the names of students that have taken at least three courses.
select name
from student s
where exists ( select ID
                from takes t
				where s.ID=t.ID
				group by ID
				having count(course_id)>=3);

--6.[10 points] Use a correlated subquery in the where clause to find the names of students that have taken at least three courses.  
select name
from student s
where  ( select count(*) --correlated subquery in the where clause
         from takes t
		 where t.ID=s.ID 
		  ) >=3;

--7.[10 points]Uses a derived relation (you may also need to use the lateral clause) to find the names of students that have taken at least three courses. 
select s.name
from student s
join (select t.ID from takes t group by t.ID 
                having count(t.course_id)>=3) As std3_dept 
				         on s.ID = std3_dept.ID;

--8.[10 points] Use an outer join to find names of the students in the university database who have never taken any course.
select distinct name
from student left outer join takes --left because name is isn relation student
on student.ID=takes.ID
where takes.ID is NULL;

/* Part 2: comment your solution to the following questions in a multiline comment of the form
9.	[10 points] Define the terms: view, materialized view, updatable view.
view: A view is a simplified form of a relation as know as virtual relation, in cases where we want to limit some user of how much of information we want them to be able to see, such as an
instructors only needs to see his name, department name and ID, but not his salary, we create such view where only these thing sare visible to him/her.

materialized view: A materialized view is a view ehere in actual the database has stored the information of the table.

Updatable view: a Updatable view is a relation view that allow to update/modify table with new info using insert.but has alot of limitationa and certain conditions needs to be satified for it work be accepted by the relation.

10.	[10 points] Write an SQL statement to create a view that gives the number of students in each department. Schema of the view should be (dept_name, num_students).
--ans=>
create view num_std_dept As
select dept_name, count(ID) As num_students
from student
group by dept_name;

11.	[5 points] What is the difference between join type and join condition.
ans=> join type defines how tables are combined based on their relationship, it consist of join types such as natural left outer join, natural right outer join or natural full outer join
whereas  join condition specify the criteria for matching rows between tables in a join operation which helps us avoid not having duplicates of colums by ensuring correct row are combined, it uses On and using keyword.

12.	[5 points] List the three different ways one can specify a join condition.
ans=> the three different ways are:
1. natural join
eg: select* 
    from instructor natural join student;
2. on <predicate>
eg: select* 
    from instructor join student
    ON instructor.Id=studnet.ID;
3. using (A1, A2,---, An)
eg: select* 
    from instructor, student
    using (----);
*/
 
