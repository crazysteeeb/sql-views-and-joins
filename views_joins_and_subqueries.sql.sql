--Steve Phillips-Ward

-- Part 1:
-- 1.	[5 points] (Similar to Q1 HW 6) Find the number of students in each department. Rename the count as numbStudents. I.e., schema of the output should be (dept_name, numbStudents).

select dept_name, count(*) as numbStudents from student group by dept_name;

-- 2.	[5 points] (Similar to Q2 HW 6) For departments that have at least three students, find department name and number of students. Rename the second attribute in the output as numbStudents.  

select dept_name, count(*) as numbStudents from student group by dept_name having count(*) >= 3;

-- 3.	[10 points] Use the set membership operator to find the names of students that have taken at least three courses.   

select name from student where ID in (select ID from takes group by ID having count(*) >= 3);

-- 4.	[10 points] Use the with clause to create a temporary relation to find the names of students that have taken at least three courses.    

with student_name as (select ID from takes group by ID having count(*) >= 3) select name from student where ID in (select ID from student_name);

-- 5.	[10 points] Use the exists construct to find the names of students that have taken at least three courses.  

select name from student s where exists ( select 1 from takes t where s.ID = t.ID group by t.ID having count(*) >= 3 );

-- 6.	[10 points] Use a correlated subquery in the where clause to find the names of students that have taken at least three courses.   

select name from student s where ( select count(*) from takes t where t.ID = s.ID ) >= 3;

-- 7.	[10 points] Uses a derived relation (you may also need to use the lateral clause) to find the names of students that have taken at least three courses.  

select s.name from student s, (select ID from takes group by ID having count(*) >= 3) as temp where s.ID = temp.ID;

-- 8.	[10 points] Use an outer join to find names of the students in the university database who have never taken any course. 

select s.name from student s left outer join takes t on s.ID = t.ID where t.ID is null;

/* Part 2: comment your solution to the following questions in a multiline comment of the form /* */
9.	[10 points] Define the terms: view, materialized view, updatable view.

View: A view is a virtual table based on the result set of an SQL select statement
Materialized view: a database object that stores the precomputed results of a quesry as a physical table.
Updatable view: virtual table that allows you to modify the data of its underlying base tables directly through the view.

10.	[10 points] Write an SQL statement to create a view that gives the number of students in each department. Schema of the view should be (dept_name, num_students).

create view student_count (dept_name, num_students) as select dept_name, count(ID) from student group by dept_name;

11.	[5 points] What is the difference between join type and join condition.

Join type refers to the way tables are combined such as inner join, left outer join, right outer join, and full outer join. How the attributes from the joined tables are included in the result set.
Join condition refers to the criteria used to match rows from the joined tables, typically specified in the ON clause of a join statement and using columns from the tables being joined to determine how rows are related. Comparing attributes.

12.	[5 points] List the three different ways one can specify a join condition. 

Three different ways to specify a join condition are:
Using the On clause 
Using the Using clause
Using the Najural join  

*/

