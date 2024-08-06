--Rajkumar Kushwaha
--hw10
/* use SQL syntax
[100 points] Suppose you are given a relation emp(empid, dept, salary) and wish to maintain a materialized view deptsalary(dept, totalsalary) which stores the total salary
for all employees of each department. Suppose the system does not support materialized views but supports triggers. Write an SQL trigger on insert on emp to keep the
relation deptsalary up to date. Do not worry about deletes or updates. Assume that there is already a tuple for each department in deptsalary so you do not need to
worry about new departments.

emp(empid, dept, salary)
deptsalary(dept, totalsalary)

--materalized view 
deptsalary(dept, totalsalary) --which stores the total salaryfor all employees of each department
*/
--SQL trigger on insert on emp to keep the

create trigger deptsalary after insert on emp
referencing new row as nrow
for each row
begin atomic
  update deptsalary
  set totalsalary=totalsalary+nrow.salary
  where deptsalary.dept=nrow.dept;
 
  end;