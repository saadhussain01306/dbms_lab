/*Data Definition Language (DDL) commands in RDBMS
Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are 
underlined and the data types are specified.
Create tables for the following schema listed below by properly 
specifying the primary keys and foreign keys.
Enter at least five tuples for each relation.
Altering tables,
Adding and Dropping different types of constraints.
Also adding and dropping fields in to the relational schemas of the listed 
problems.
Delete, Update operations

D. Student enrollment in courses and books adopted for each course
STUDENT (regno: string, name: string, major: string, bdate: date)
COURSE (course#:int, cname: string, dept: string)
ENROLL(regno:string, course#: int,sem: int,marks: int)
BOOK-ADOPTION (course#:int, sem: int, book-ISBN: int)
TEXT (book-ISBN: int, book-title: string, publisher: string,author: 
string)*/

CREATE DATABASE Student_enrollment;
USE Student_enrollment;

-- Create table STUDENT
CREATE TABLE STUDENT (
    regno VARCHAR(40) PRIMARY KEY,
    name VARCHAR(100),
    major VARCHAR(100),
    bdate DATE
);


-- Create table COURSE
CREATE TABLE COURSE (
    course INT PRIMARY KEY,
    cname VARCHAR(100),
    dept VARCHAR(100)
);


-- Create table ENROLL
CREATE TABLE ENROLL (
    regno VARCHAR(40) PRIMARY KEY,
    course INT,
    sem INT,
    marks INT,
    FOREIGN KEY (regno) REFERENCES STUDENT(regno) ON DELETE CASCADE,
    FOREIGN KEY (course) REFERENCES COURSE(course) ON DELETE CASCADE
);

-- CREATE table TEXT
CREATE TABLE TEXT (
    book_ISBN INT PRIMARY KEY,
    title VARCHAR(100),
    publisher VARCHAR(100),
    author VARCHAR(100)
);

-- Create table BOOK_ADOPTION
CREATE TABLE BOOK_ADOPTION (
    course INT,
    sem INT,
    book_ISBN INT PRIMARY KEY,
    FOREIGN KEY (course) REFERENCES COURSE(course)  ON DELETE CASCADE,
    FOREIGN KEY (book_ISBN) REFERENCES TEXT(book_ISBN)  ON DELETE CASCADE
);


-- Insert data into the STUDENT table
INSERT INTO STUDENT (regno, name, major, bdate) 
VALUES
    ('S1', 'JOHN', 'Computer', '2000-03-15'),
    ('S2', 'PETER', 'History', '2000-03-16'),
    ('S3', 'JACK', 'Chemistry', '2000-03-17'),
    ('S4', 'YASH', 'Maths', '2000-03-18'),
    ('S5', 'KEVIN', 'Physics', '2000-03-19');
    
-- check 
SELECT * FROM STUDENT;


-- Insert data into the COURSE table
INSERT INTO COURSE (course, cname, dept) VALUES
    (1001, 'Computer Science and Engineering', 'Computer Science'),
    (1002, 'World History', 'History'),
    (1003, 'Physical Chemistry', 'Chemistry'),
    (1004, 'Calculus', 'Mathematics'),
    (1005, 'Quantum Physics', 'Physics');

 -- check 
SELECT * FROM COURSE;  

-- Insert data into the ENROLL table
INSERT INTO ENROLL (regno, course, sem, marks) VALUES
    ('S1', 1001, 1, 90),
    ('S2', 1002, 2, 91),
    ('S3', 1003, 3, 92),
    ('S4', 1004, 4, 93),
    ('S5', 1005, 5, 94);
    
 -- check 
 SELECT * FROM ENROLL;
 
 -- Insert data into the TEXT table
INSERT INTO TEXT (book_ISBN, title, publisher, author) VALUES
    (2001, 'Programming in C', 'Smith', 'Henry'),
    (2002, 'World History', 'Marsh', 'Mitchell'),
    (2003, 'Physical Chemistry-1', 'David', 'Starc'),
    (2004, 'Calculus-1', 'Ben', 'Tom'),
    (2005, 'Quantum Mechanics', 'Root', 'Newton');
    
    -- check 
    SELECT * FROM TEXT;

 
 -- Insert data into the BOOK_ADOPTION table
INSERT INTO BOOK_ADOPTION (course, sem, book_ISBN) VALUES
    (1001, 1, 2001),
    (1002, 2, 2002),
    (1003, 3, 2003),
    (1004, 4, 2004),
    (1005, 5, 2005);

-- check
SELECT * FROM BOOK_ADOPTION;

-- Find out who scored the highest marks amongst all the students

SELECT STUDENT.regno, STUDENT.name, MAX(ENROLL.marks) AS highest_marks
FROM ENROLL
INNER JOIN STUDENT ON ENROLL.regno = STUDENT.regno
GROUP BY STUDENT.regno, STUDENT.name
ORDER BY highest_marks DESC
LIMIT 1;

-- list the students according to the marks scored(highest to lowest)
SELECT STUDENT.regno, STUDENT.name, MAX(ENROLL.marks) AS highest_marks
FROM ENROLL
INNER JOIN STUDENT ON ENROLL.regno = STUDENT.regno
GROUP BY STUDENT.regno, STUDENT.name
ORDER BY highest_marks DESC;

-- List the students according to DOB(Youngest to Oldest)
SELECT regno, name, bdate
FROM STUDENT
ORDER BY bdate ASC;

-- List the corse name in alphabetical order
SELECT course, cname, dept
FROM COURSE
ORDER BY cname ASC;

-- alter the tables

-- alter the STUDENT
-- add the email column in the STUDENT

ALTER TABLE STUDENT
ADD email VARCHAR(100);

UPDATE STUDENT
SET email = 'john@gmail.com'
WHERE regno='S1';

UPDATE STUDENT
SET email = 'peter@gmail.com'
WHERE regno='S2';

UPDATE STUDENT
SET email = 'jack@gmail.com'
WHERE regno='S3';

UPDATE STUDENT
SET email = 'yash@gmail.com'
WHERE regno='S4';

UPDATE STUDENT
SET email = 'kevin@gmail.com'
WHERE regno='S5';

-- check 
SELECT * FROM STUDENT;

-- adding and dropping constraints

-- adding constraints
ALTER TABLE STUDENT
ADD CONSTRAINT uq_regno UNIQUE (regno);

-- droping constraints
-- drop constraints
ALTER TABLE STUDENT
DROP CONSTRAINT uq_regno;


-- adding and dropping fields

-- adding fields
ALTER TABLE ENROLL
ADD COLUMN enrollment_date DATE;

-- dropping fields
ALTER TABLE ENROLL
DROP COLUMN enrollment_date DATE;

-- delete and update operations
DELETE FROM STUDENT
WHERE regno = 'S4';

-- update operations
UPDATE ENROLL
SET marks = 100
WHERE regno = 'S5';


-- further operations
UPDATE STUDENT
SET major = 'Computer Science and Engineering'
WHERE regno = 'S4';

-- check if book returned or not

ALTER TABLE BOOK_ADOPTION
ADD return_status ENUM('yes', 'no') DEFAULT 'no';


-- output:-
DESC STUDENT;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| regno | varchar(40)  | NO   | PRI | NULL    |       |
| name  | varchar(100) | YES  |     | NULL    |       |
| major | varchar(100) | YES  |     | NULL    |       |
| bdate | date         | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
DESC COURSE;
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| course | int          | NO   | PRI | NULL    |       |
| cname  | varchar(100) | YES  |     | NULL    |       |
| dept   | varchar(100) | YES  |     | NULL    |       |
+--------+--------------+------+-----+---------+-------+
DESC ENROLL;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| regno  | varchar(40) | NO   | PRI | NULL    |       |
| course | int         | YES  | MUL | NULL    |       |
| sem    | int         | YES  |     | NULL    |       |
| marks  | int         | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
DESC TEXT;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| book_ISBN | int          | NO   | PRI | NULL    |       |
| title     | varchar(100) | YES  |     | NULL    |       |
| publisher | varchar(100) | YES  |     | NULL    |       |
| author    | varchar(100) | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+
DESC BOOK_ADOPTION;
+-----------+------+------+-----+---------+-------+
| Field     | Type | Null | Key | Default | Extra |
+-----------+------+------+-----+---------+-------+
| course    | int  | YES  | MUL | NULL    |       |
| sem       | int  | YES  |     | NULL    |       |
| book_ISBN | int  | NO   | PRI | NULL    |       |
+-----------+------+------+-----+---------+-------+

SELECT * FROM STUDENT;
+-------+-------+-----------+------------+
| regno | name  | major     | bdate      |
+-------+-------+-----------+------------+
| S1    | JOHN  | Computer  | 2000-03-15 |
| S2    | PETER | History   | 2000-03-16 |
| S3    | JACK  | Chemistry | 2000-03-17 |
| S4    | YASH  | Maths     | 2000-03-18 |
| S5    | KEVIN | Physics   | 2000-03-19 |
+-------+-------+-----------+------------+

SELECT * FROM COURSE;
+--------+----------------------------------+------------------+
| course | cname                            | dept             |
+--------+----------------------------------+------------------+
|   1001 | Computer Science and Engineering | Computer Science |
|   1002 | World History                    | History          |
|   1003 | Physical Chemistry               | Chemistry        |
|   1004 | Calculus                         | Mathematics      |
|   1005 | Quantum Physics                  | Physics          |
+--------+----------------------------------+------------------+

SELECT * FROM ENROLL;
+-------+--------+------+-------+
| regno | course | sem  | marks |
+-------+--------+------+-------+
| S1    |   1001 |    1 |    90 |
| S2    |   1002 |    2 |    91 |
| S3    |   1003 |    3 |    92 |
| S4    |   1004 |    4 |    93 |
| S5    |   1005 |    5 |    94 |
+-------+--------+------+-------+

SELECT * FROM TEXT;
+-----------+----------------------+-----------+----------+
| book_ISBN | title                | publisher | author   |
+-----------+----------------------+-----------+----------+
|      2001 | Programming in C     | Smith     | Henry    |
|      2002 | World History        | Marsh     | Mitchell |
|      2003 | Physical Chemistry-1 | David     | Starc    |
|      2004 | Calculus-1           | Ben       | Tom      |
|      2005 | Quantum Mechanics    | Root      | Newton   |
+-----------+----------------------+-----------+----------+

SELECT * FROM BOOK_ADOPTION;
+--------+------+-----------+
| course | sem  | book_ISBN |
+--------+------+-----------+
|   1001 |    1 |      2001 |
|   1002 |    2 |      2002 |
|   1003 |    3 |      2003 |
|   1004 |    4 |      2004 |
|   1005 |    5 |      2005 |
+--------+------+-----------+

-- student who scored the highest marks
+-------+-------+---------------+
| regno | name  | highest_marks |
+-------+-------+---------------+
| S5    | KEVIN |            94 |
+-------+-------+---------------+
 
--- list the students accordig to the marks (highest to lowest)
+-------+-------+---------------+
| regno | name  | highest_marks |
+-------+-------+---------------+
| S5    | KEVIN |            94 |
| S4    | YASH  |            93 |
| S3    | JACK  |            92 |
| S2    | PETER |            91 |
| S1    | JOHN  |            90 |
+-------+-------+---------------+

-- List the students according to DOB(Youngest to Oldest)   
+-------+-------+------------+
| regno | name  | bdate      |
+-------+-------+------------+
| S1    | JOHN  | 2000-03-15 |
| S2    | PETER | 2000-03-16 |
| S3    | JACK  | 2000-03-17 |
| S4    | YASH  | 2000-03-18 |
| S5    | KEVIN | 2000-03-19 |
+-------+-------+------------+

-- order by cname(alphabetically)
+--------+----------------------------------+------------------+
| course | cname                            | dept             |
+--------+----------------------------------+------------------+
|   1004 | Calculus                         | Mathematics      |
|   1001 | Computer Science and Engineering | Computer Science |
|   1003 | Physical Chemistry               | Chemistry        |
|   1005 | Quantum Physics                  | Physics          |
|   1002 | World History                    | History          |
+--------+----------------------------------+------------------+
-- alter table students 
+-------+-------+-----------+------------+-----------------+
| regno | name  | major     | bdate      | email           |
+-------+-------+-----------+------------+-----------------+
| S1    | JOHN  | Computer  | 2000-03-15 | john@gmail.com  |
| S2    | PETER | History   | 2000-03-16 | peter@gmail.com |
| S3    | JACK  | Chemistry | 2000-03-17 | jack@gmail.com  |
| S4    | YASH  | Maths     | 2000-03-18 | yash@gmail.com  |
| S5    | KEVIN | Physics   | 2000-03-19 | kevin@gmail.com |
+-------+-------+-----------+------------+-----------------+
-- delete s2 student
SELECT * FROM STUDENT WHERE regno='S4';
Empty set (0.00 sec)

-- update major
SELECT * FROM STUDENT WHERE regno='S3';
+-------+------+----------------------------------+------------+----------------+
| regno | name | major                            | bdate      | email          |
+-------+------+----------------------------------+------------+----------------+
| S3    | JACK | Computer Science and Engineering | 2000-03-17 | jack@gmail.com |
+-------+------+----------------------------------+------------+----------------+

-- alter BBOK_ADOPTION add return_status
+--------+------+-----------+---------------+
| course | sem  | book_ISBN | return_status |
+--------+------+-----------+---------------+
|   1001 |    1 |      2001 | no            |
|   1002 |    2 |      2002 | no            |
|   1003 |    3 |      2003 | no            |
|   1004 |    4 |      2004 | no            |
|   1005 |    5 |      2005 | no            |
+--------+------+-----------+---------------+

