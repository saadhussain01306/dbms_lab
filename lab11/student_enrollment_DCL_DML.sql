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

-- Select courses with course numbers between 1002 and 1004
SELECT * FROM COURSE WHERE course BETWEEN 1002 AND 1004;

-- Select students majoring in Computer Science
SELECT * FROM STUDENT WHERE major = 'Computer';

-- Order students by birth date in ascending order
SELECT * FROM STUDENT ORDER BY bdate ASC;

-- union
SELECT * FROM STUDENT WHERE major = 'Computer'
UNION
SELECT * FROM STUDENT WHERE major = 'Physics';

SELECT * FROM STUDENT WHERE EXISTS (SELECT * FROM ENROLL WHERE ENROLL.regno = STUDENT.regno);

-- join
SELECT STUDENT.regno, STUDENT.name, ENROLL.course, ENROLL.sem
FROM STUDENT
INNER JOIN ENROLL ON STUDENT.regno = ENROLL.regno;

-- Inner Join to retrieve students and their enrolled courses (only matched records)
SELECT *
FROM STUDENT
INNER JOIN ENROLL ON STUDENT.regno = ENROLL.regno;

-- Left Join to retrieve all students and their enrolled courses (including unmatched students)
SELECT *
FROM STUDENT
LEFT JOIN ENROLL ON STUDENT.regno = ENROLL.regno;

-- Right Join to retrieve all enrolled courses and their associated students (including unmatched courses)
SELECT *
FROM STUDENT
RIGHT JOIN ENROLL ON STUDENT.regno = ENROLL.regno;

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


-- aggregate functions
SELECT regno, AVG(marks) AS avg_marks
FROM ENROLL
GROUP BY regno;

-- group by
SELECT dept, COUNT(course) AS num_courses
FROM COURSE
GROUP BY dept;

-- group by having
SELECT dept, COUNT(course) AS num_courses
FROM COURSE
GROUP BY dept
HAVING COUNT(course) > 1;

-- Nested and Correlated Nested Queries

--Find students who have marks greater than the average marks in their respective courses
SELECT regno, marks
FROM ENROLL e
WHERE marks > (SELECT AVG(marks) FROM ENROLL e2 WHERE e2.course = e.course);

 -- Create a View
 -- Create a view that shows student details along with the corresponding course and marks.
-- Create a view
CREATE VIEW StudentCourseMarks AS
SELECT STUDENT.regno, STUDENT.name, ENROLL.course, ENROLL.marks
FROM STUDENT
INNER JOIN ENROLL ON STUDENT.regno = ENROLL.regno;

-- check the view
SELECT * FROM StudentCourseMarks;

-- Create a Trigger
--  Create a trigger that automatically inserts a record into the ENROLL table when a new student is added.

-- Create a trigger
CREATE TRIGGER AfterInsertStudent
AFTER INSERT ON STUDENT
FOR EACH ROW
INSERT INTO ENROLL (regno, course, sem, marks)
VALUES (NEW.regno, DEFAULT, DEFAULT, DEFAULT);

-- Insert a new student
INSERT INTO STUDENT (regno, name, major, bdate) 
VALUES ('S6', 'EMMA', 'Biology', '2000-03-20');

--  check the trigger
SELECT * FROM ENROLL WHERE regno = 'S6';

-- grant command
GRANT select ON hussain.ENROLL TO 'JOHN'@'localhost';
ERROR 1410 (42000): You are not allowed to create a user with GRANT

-- revoke command
 REVOKE select ON hussain.ENROLL FROM 'JOHN'@'localhost';
ERROR 1147 (42000): There is no such grant defined for user 'JOHN' on host 'localhost' on table 'ENROLL'
