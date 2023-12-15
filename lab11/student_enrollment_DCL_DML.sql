-- D. Student enrollment in courses and books adopted for each course
-- STUDENT (regno: string, name: string, major: string, bdate: date)
-- COURSE (course#:int, cname: string, dept: string)
-- ENROLL(regno:string, course#: int,sem: int,marks: int)
-- BOOK-ADOPTION (course#:int, sem: int, book-ISBN: int)
-- TEXT (book-ISBN: int, book-title: string, publisher: string,author: 
-- string)

-- Data Manipulation Language (DML) and Data Control Language 
-- (DCL)
-- Write valid DML statements to retrieve tuples from the databases. The 
-- query may contain appropriate DML and DCL commands such as:
-- Select with
--  %like, between, where clause
--  Order by
--  Set Operations
--  Exists and not exists
--  Join operations
--  Aggregate functions
--  Group by
--  Group by having
--  Nested and correlated nested Queries
-- Grant and revoke permission

-- Select students with names containing 'K'
SELECT * FROM STUDENT WHERE name LIKE '%K%';
+-------+-------+----------------------------------+------------+-----------------+
| regno | name  | major                            | bdate      | email           |
+-------+-------+----------------------------------+------------+-----------------+
| S3    | JACK  | Computer Science and Engineering | 2000-03-17 | jack@gmail.com  |
| S5    | KEVIN | Physics                          | 2000-03-19 | kevin@gmail.com |
+-------+-------+----------------------------------+------------+-----------------+


-- Select courses with course numbers between 1002 and 1004
SELECT * FROM COURSE WHERE course BETWEEN 1002 AND 1004;
+--------+--------------------+-------------+
| course | cname              | dept        |
+--------+--------------------+-------------+
|   1002 | World History      | History     |
|   1003 | Physical Chemistry | Chemistry   |
|   1004 | Calculus           | Mathematics |
+--------+--------------------+-------------+


-- Select students majoring in Computer Science
SELECT * FROM STUDENT WHERE major = 'Computer';
+-------+------+----------+------------+----------------+
| regno | name | major    | bdate      | email          |
+-------+------+----------+------------+----------------+
| S1    | JOHN | Computer | 2000-03-15 | john@gmail.com |
+-------+------+----------+------------+----------------+


-- Order students by birth date in ascending order
SELECT * FROM STUDENT ORDER BY bdate ASC;
+-------+-------+----------------------------------+------------+-----------------+
| regno | name  | major                            | bdate      | email           |
+-------+-------+----------------------------------+------------+-----------------+
| S1    | JOHN  | Computer                         | 2000-03-15 | john@gmail.com  |
| S2    | PETER | History                          | 2000-03-16 | peter@gmail.com |
| S3    | JACK  | Computer Science and Engineering | 2000-03-17 | jack@gmail.com  |
| S5    | KEVIN | Physics                          | 2000-03-19 | kevin@gmail.com |
+-------+-------+----------------------------------+------------+-----------------+

-- union
-- Union of students majoring in Computer Science or Physics
SELECT * FROM STUDENT WHERE major = 'Computer'
UNION
SELECT * FROM STUDENT WHERE major = 'Physics';
+-------+-------+----------+------------+-----------------+
| regno | name  | major    | bdate      | email           |
+-------+-------+----------+------------+-----------------+
| S1    | JOHN  | Computer | 2000-03-15 | john@gmail.com  |
| S5    | KEVIN | Physics  | 2000-03-19 | kevin@gmail.com |
+-------+-------+----------+------------+-----------------+

-- Select students who have enrolled in a course
SELECT * FROM STUDENT WHERE EXISTS (SELECT * FROM ENROLL WHERE ENROLL.regno = STUDENT.regno);
+-------+-------+----------------------------------+------------+-----------------+
| regno | name  | major                            | bdate      | email           |
+-------+-------+----------------------------------+------------+-----------------+
| S1    | JOHN  | Computer                         | 2000-03-15 | john@gmail.com  |
| S2    | PETER | History                          | 2000-03-16 | peter@gmail.com |
| S3    | JACK  | Computer Science and Engineering | 2000-03-17 | jack@gmail.com  |
| S5    | KEVIN | Physics                          | 2000-03-19 | kevin@gmail.com |
+-------+-------+----------------------------------+------------+-----------------+

-- join
-- Inner Join to get student details along with enrolled courses
SELECT STUDENT.regno, STUDENT.name, ENROLL.course, ENROLL.sem
FROM STUDENT
INNER JOIN ENROLL ON STUDENT.regno = ENROLL.regno;
+-------+-------+--------+------+
| regno | name  | course | sem  |
+-------+-------+--------+------+
| S1    | JOHN  |   1001 |    1 |
| S2    | PETER |   1002 |    2 |
| S3    | JACK  |   1003 |    3 |
| S5    | KEVIN |   1005 |    5 |
+-------+-------+--------+------+

-- Inner Join to retrieve students and their enrolled courses (only matched records)
SELECT *
FROM STUDENT
INNER JOIN ENROLL ON STUDENT.regno = ENROLL.regno;
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+
| regno | name  | major                            | bdate      | email           | regno | course | sem  | marks | enrollment_date |
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+
| S1    | JOHN  | Computer                         | 2000-03-15 | john@gmail.com  | S1    |   1001 |    1 |    90 | NULL            |
| S2    | PETER | History                          | 2000-03-16 | peter@gmail.com | S2    |   1002 |    2 |    91 | NULL            |
| S3    | JACK  | Computer Science and Engineering | 2000-03-17 | jack@gmail.com  | S3    |   1003 |    3 |    92 | NULL            |
| S5    | KEVIN | Physics                          | 2000-03-19 | kevin@gmail.com | S5    |   1005 |    5 |    94 | NULL            |
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+

-- Left Join to retrieve all students and their enrolled courses (including unmatched students)
SELECT *
FROM STUDENT
LEFT JOIN ENROLL ON STUDENT.regno = ENROLL.regno;
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+
| regno | name  | major                            | bdate      | email           | regno | course | sem  | marks | enrollment_date |
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+
| S1    | JOHN  | Computer                         | 2000-03-15 | john@gmail.com  | S1    |   1001 |    1 |    90 | NULL            |
| S2    | PETER | History                          | 2000-03-16 | peter@gmail.com | S2    |   1002 |    2 |    91 | NULL            |
| S3    | JACK  | Computer Science and Engineering | 2000-03-17 | jack@gmail.com  | S3    |   1003 |    3 |    92 | NULL            |
| S5    | KEVIN | Physics                          | 2000-03-19 | kevin@gmail.com | S5    |   1005 |    5 |    94 | NULL            |
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+

--  DELETE FROM STUDENT WHERE regno='S1';
-- Query OK, 1 row affected (0.00 sec)


-- Right Join to retrieve all enrolled courses and their associated students (including unmatched courses)
SELECT *
FROM STUDENT
RIGHT JOIN ENROLL ON STUDENT.regno = ENROLL.regno;
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+
| regno | name  | major                            | bdate      | email           | regno | course | sem  | marks | enrollment_date |
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+
| S2    | PETER | History                          | 2000-03-16 | peter@gmail.com | S2    |   1002 |    2 |    91 | NULL            |
| S3    | JACK  | Computer Science and Engineering | 2000-03-17 | jack@gmail.com  | S3    |   1003 |    3 |    92 | NULL            |
| S5    | KEVIN | Physics                          | 2000-03-19 | kevin@gmail.com | S5    |   1005 |    5 |    94 | NULL            |
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+


-- Full Outer Join without using the FULL OUTER JOIN keyword
-- FULL OUTER JOIN KEY WORD IS NOT defined in mysql
SELECT *
FROM STUDENT
LEFT JOIN ENROLL ON STUDENT.regno = ENROLL.regno
UNION
SELECT *
FROM STUDENT
RIGHT JOIN ENROLL ON STUDENT.regno = ENROLL.regno
WHERE STUDENT.regno IS NULL;  -- To exclude duplicates
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+
| regno | name  | major                            | bdate      | email           | regno | course | sem  | marks | enrollment_date |
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+
| S2    | PETER | History                          | 2000-03-16 | peter@gmail.com | S2    |   1002 |    2 |    91 | NULL            |
| S3    | JACK  | Computer Science and Engineering | 2000-03-17 | jack@gmail.com  | S3    |   1003 |    3 |    92 | NULL            |
| S5    | KEVIN | Physics                          | 2000-03-19 | kevin@gmail.com | S5    |   1005 |    5 |    94 | NULL            |
+-------+-------+----------------------------------+------------+-----------------+-------+--------+------+-------+-----------------+


-- aggregate functions
-- Calculate average marks for each student
SELECT regno, AVG(marks) AS avg_marks
FROM ENROLL
GROUP BY regno;
+-------+-----------+
| regno | avg_marks |
+-------+-----------+
| S2    |   91.0000 |
| S3    |   92.0000 |
| S5    |   94.0000 |
+-------+-----------+


--Group courses by department and count the number of courses in each department
-- group by
SELECT dept, COUNT(course) AS num_courses
FROM COURSE
GROUP BY dept;
+------------------+-------------+
| dept             | num_courses |
+------------------+-------------+
| Computer Science |           1 |
| History          |           1 |
| Chemistry        |           1 |
| Mathematics      |           1 |
| Physics          |           1 |
+------------------+-------------+

-- Display departments with more than 1 course
-- group by having
SELECT dept, COUNT(course) AS num_courses
FROM COURSE
GROUP BY dept
HAVING COUNT(course) > 0;
+------------------+-------------+
| dept             | num_courses |
+------------------+-------------+
| Computer Science |           1 |
| History          |           1 |
| Chemistry        |           1 |
| Mathematics      |           1 |
| Physics          |           1 |
+------------------+-------------+

-- Nested and Correlated Nested Queries

--Find students who have marks greater than the average marks in their respective courses
SELECT regno, marks
FROM ENROLL e
WHERE marks > (SELECT AVG(marks) FROM ENROLL e2 WHERE e2.course = e.course);

Empty set (0.00 sec)

 -- Create a View
 -- Create a view that shows student details along with the corresponding course and marks.
-- Create a view
CREATE VIEW StudentCourseMarks AS
SELECT STUDENT.regno, STUDENT.name, ENROLL.course, ENROLL.marks
FROM STUDENT
INNER JOIN ENROLL ON STUDENT.regno = ENROLL.regno;

-- check the view
SELECT * FROM StudentCourseMarks;
+-------+-------+--------+-------+
| regno | name  | course | marks |
+-------+-------+--------+-------+
| S2    | PETER |   1002 |    91 |
| S3    | JACK  |   1003 |    92 |
| S5    | KEVIN |   1005 |    94 |
+-------+-------+--------+-------+


-- Create a Trigger
--  Create a trigger that automatically inserts a record into the ENROLL table when a new student is added.

-- Create a trigger
CREATE TRIGGER AfterInsertStudent 
 AFTER INSERT ON STUDENT 
 FOR EACH ROW INSERT INTO ENROLL (regno, course, sem, marks) 
 VALUES (New.regno,DEFAULT,DEFAULT,DEFAULT);

-- Insert a new student
INSERT INTO STUDENT (regno, name, major, bdate) 
VALUES ('S6', 'EMMA', 'Biology', '2000-03-20');

--  check the trigger
SELECT * FROM ENROLL WHERE regno = 'S6';
+-------+--------+------+-------+-----------------+
| regno | course | sem  | marks | enrollment_date |
+-------+--------+------+-------+-----------------+
| S6    |   NULL | NULL |  NULL | NULL            |
+-------+--------+------+-------+-----------------+

-- grant command
GRANT select ON hussain.ENROLL TO 'JOHN'@'localhost';
ERROR 1410 (42000): You are not allowed to create a user with GRANT

-- revoke command
REVOKE select ON hussain.ENROLL FROM 'JOHN'@'localhost';
ERROR 1147 (42000): There is no such grant defined for user 'JOHN' on host 'localhost' on table 'ENROLL'
