-- Create a table for the structure Student with attributes as SID, NAME, 
-- BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL, Insert atleast 10 
-- tuples and performthe following operationsusing SQL.
-- a. Insert a new student
-- b. Modify the address of the student based on SID
-- c. Delete a student
-- d. List all the students
-- e. List all the students of CSE branch.
-- f. List all the students of CSE branch and reside in Kuvempunagar.


CREATE DATABASE College;
USE College;

 CREATE TABLE student(
   SID INT PRIMARY KEY,
   NAME VARCHAR(25),
   BRANCH VARCHAR(25),
   SEMESTER INT NOT NULL,
   ADDRESS VARCHAR(100),
   PHONE VARCHAR(25),
   EMAIL VARCHAR(100)
 );

-- 10 students info
INSERT INTO student(SID, NAME, BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL)
VALUES
(880, "ARUN", "MECH", 5, "Indranagar", "1111111111", "arun@gmail.com"),
(881, "ARJUN", "ECE", 6, "Kuvempunagar", "2222222222", "arjun@gmail.com"),
(882, "ARYAN", "IP", 7, "Rajiv Nagar", "3333333333", "aryan@mail.com"),
(883, "AMITH", "CSE", 6, "Neharu Nagar", "4444444444", "amith@gmail.com"),
(884, "DHAWAN", "CSE", 3, "Kuvempunagar", "5555555555", "dhawan@gmail.com"),
(885, "JOHN", "EEE", 5, "Kuvempunagar", "6666666666", "john@gmail.com"),
(886, "JAMES", "CIVIL", 5, "Indranagar", "7777777777", "james@gmail.com"),
(887, "RAHUL", "CSE", 2, "Kuvempunagar", "8888888888", "rahul@gmail.com"),
(888, "YASH", "MECH", 4, "2nd main Mysore", "9999999999", "yash@gmail.com"),
(889, "PETER", "CSE", 3, "Rajiv nagar", "1234567890", "peter@gmail.com");

-- Insert a new student
INSERT INTO student(SID, NAME, BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL)
VALUES
(111, "ROHAN", "CSE", 5, "Kuvempunagar", "8976890982", "rohan@gmail.com");

-- Modify the address of the student based on SID
UPDATE student
SET ADDRESS = "5th main Mysore"
WHERE SID = 885;

-- Delete a student
DELETE FROM student
WHERE SID = 886;


-- List all the students
SELECT * FROM student;

-- List all the students of CSE branch
SELECT * FROM student
WHERE BRANCH = "CSE";

-- List all the students of CSE branch and reside in Kuvempunagar.
SELECT * FROM student
WHERE BRANCH = "CSE" AND ADDRESS = "Kuvempunagar";

