-- Steve Phillips-Ward 20260302

/*1. [15 points] Find the ids of instructors who are also students using the exists construct. */

select ID from instructor where exists (select * from student where student.ID = instructor.ID);

/*2. [15 points] Find the names and ids of the students who have taken all the courses that are offered by their departments. Notice, the table course contains information about courses offered by departments. */

select S.ID, S.name from student as S where not exists ((select C.course_id from course as C where C.dept_name = S.dept_name) except (select T.course_id from takes as T where T.ID = S.ID));

/*3. [10 points] Find the names and ids of the students who have taken exactly one course in the Fall 2017 semester. */

Select S.ID, S.name from student as S where 1 = (select count(*) from takes as T where T.ID = S.ID and T.semester = 'Fall' and T.year = 2017);

/*4. [15 points] Find the names and ids of the students who have taken at most one course in the Fall 2017 semester. Notice, at most one means one or zero. So, the answer should include students who did not take any course during that semester. */

select S.ID, S.name from student as S where 1 >= (select count(*) from takes as T where T.ID = S.ID and T.semester = 'Fall' and T.year = 2017);

/*5, [15 points] Write a query that uses a derived relation to find the student(s) who have taken at least two courses in the Fall 2017 semester. Schema of the output should be (id, number_courses). Remember: derived relation means a subquery in the from clause. */

select ID, number_courses from (select T.ID, count(*) as number_courses from takes as T where T.semester = 'Fall' and T.year = 2017 group by T.ID) as derived_relation where number_courses >= 2;

/*6. [15 points] Write a query that uses a scalar query in the select clause to find the number of distinct courses that have been taught by each instructor. Schema of the output should be (name, id, number_courses). */

select I.name, I.ID, (select count(distinct course_id) from teaches as T where T.ID = I.ID) as number_courses from instructor as I;

/*7. [15 points] Write a query that uses the with clause or a derived relation to find the id and number of courses that have been taken by student(s) who have taken the most number of courses. Schema of the output should be (id, number_courses).
 */

 with course_count as (select ID, count(*) as number_courses from takes group by ID) select ID, number_courses from course_count where number_courses = (select max(number_courses) from course_count);