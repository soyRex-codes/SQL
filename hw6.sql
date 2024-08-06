--NAME: Rajkumar Kushwaha
--HW6
--1.[20 points] Find the number of students in each department. Rename the second attribute in the output as number_students. This means the schema of 
--the output is (dept_name, number_students).

select dept_name, count(ID) as number_students
from student -- or from student natural join department
group by dept_name;


-- 2. [20 points] For departments that have at least three students, find department name and number of students. Rename the second attribute in the output as number_students. 
--Remark: this question is similar to the previous one but the output lists only department that has at least three students.

select dept_name, count(ID) as number_students
from student -- or from student natural join department
group by dept_name
having count(distinct ID) >= 3;

--3. [20 points] Find the ids of instructors who are also students using a set operation. Assume that a person is identified by her or his id. So, if the same id appears in both
--instructor and student,then that person is both an instructor and a student. Remember: set operation means union, intersect or set difference.
select ID 
from instructor
Intersect --check if that instructor id is also in student list, means does that id intersetcs the other id
select ID 
from student;	             

--4.[20 points] Find the ids of instructors who are also students using the set membership operator.
--set memebership uses in , not in
select ID
from instructor
where ID in (select ID from student);

--5.[20 points] Find the ids of instructors who are also students using a set comparison operator.
select ID
from instructor
where ID = some(select ID from student);