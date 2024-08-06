--NAME: Rajkumar Kushwaha
--HW7

--1.[15 points] Find the ids of instructors who are also students using the exists construct.
select ID
from instructor
where exists 
(select*
from student
where student.ID=instructor.ID);
         
--2.[15 points] Find the names and ids of the students who have taken all the courses that are offered by their departments. Notice, the table course
--contains information about courses offered by departments.
--for every student S, we want to test if the set A of all the courses that were taken by that students
--contains the set B of all courses taught by their department(not exits B except A)

SELECT DISTINCT S.name, S.ID
FROM student AS S
WHERE NOT EXISTS (
    SELECT C.course_id --level 1: finding courses dept and students taking courses from those dept?
    FROM course AS C
    WHERE C.dept_name = S.dept_name
      AND NOT EXISTS (
          SELECT T.course_id --level 2: narrowing down to students who took all the courses offered by their department
          FROM takes AS T
          WHERE T.ID = S.ID
            AND T.course_id = C.course_id
      )
);

--3.[10 points] Find the names and ids of the students who have taken exactly one course in the Fall 2017 semester.
SELECT S.ID, S.name
FROM student AS S
WHERE S.ID IN (
    SELECT T.ID
    FROM takes AS T
    WHERE T.semester = 'Fall' AND T.year = 2017
    GROUP BY T.ID
    HAVING COUNT(T.course_id) = 1
);


--4.[15 points] Find the names and ids of the students who have taken at most one course in the Fall 2017 semester. Notice, at most one means one or zero.
--So, the answer should include students who did not take any course during that semester.
--we can use previos method used in Q3 or the below method which more clear
SELECT S.ID, S.name
FROM student AS S
WHERE S.ID IN (
    SELECT T.ID
    FROM takes AS T
    WHERE T.semester = 'Fall' AND T.year = 2017
    GROUP BY T.ID
    HAVING COUNT(T.course_id) <= 1
)
--or asks to include students who are not in takes so we can get all studnets name
OR S.ID NOT IN (
    SELECT T.ID
    FROM takes AS T
    WHERE T.semester = 'Fall' AND T.year = 2017
);
		 
--5.[15 points] Write a query that uses a derived relation to find the student(s) who have taken at least two courses in the Fall 2017 semester. Schema
--of the output should be (id, number_courses). Remember: derived relation means a subquery in the from clause.
SELECT coursecount.ID, coursecount.number_courses
FROM (
    SELECT T.ID, COUNT(T.course_id) AS number_courses
    FROM takes AS T
    WHERE T.semester = 'Fall' AND T.year = 2017
    GROUP BY T.ID
) AS coursecount
WHERE coursecount.number_courses >= 2;


--6.[15 points] Write a query that uses a scalar query in the select clause to find the number of distinct courses that have been taught by each instructor.
--Schema of the output should be (name, id, number_courses).
--scalar subquery, is a subquery that returns exactly one value. This type of subquery 
--can be used in the SELECT list, WHERE clause, or other parts of a SQL query where a single value is expected.
select I.name, I.id, (select count(distinct T.course_id) --selct under select is scalar query
                      from teaches as T
					  where T.ID=I.ID) as number_courses
from instructor as I;


--7.[15 points] Write a query that uses the with clause or a derived relation to find the id and number of courses that have been taken by student(s) who
--have taken the most number of courses. Schema of the output should be (id, number_courses).
--derived relation
SELECT ID, COUNT(course_id) AS number_courses
FROM takes
GROUP BY ID
HAVING COUNT(course_id) = (
    SELECT MAX(course_count)
    FROM (
        SELECT COUNT(course_id) AS course_count
        FROM takes
        GROUP BY ID
    ) AS course_counts
);

 

