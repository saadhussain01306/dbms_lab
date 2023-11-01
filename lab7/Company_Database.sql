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

E. Company Database:
EMPLOYEE (SSN, Name, Address, Sex, Salary, SuperSSN, DNo)
DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate)
DLOCATION (DNo,DLoc)
PROJECT (PNo, PName, PLocation, DNo)
WORKS_ON (SSN, PNo, Hours)

Concept to look out for  "circular dependency" of the EMPLOYEE And the DEPARTMENT Table" 
*/


CREATE DATABASE Company;
USE Company;

  -- Create the EMPLOYEE table
CREATE TABLE EMPLOYEE (
    SSN INT PRIMARY KEY, -- Social Security Number of the employee
    Name VARCHAR(100), 
    Address VARCHAR(200),
    Sex CHAR(10),
    Salary DECIMAL(10, 2),
    SuperSSN INT, -- The Social Security Number of the employee's supervisor
    DNo INT
);

-- create the deportment table
CREATE TABLE DEPARTMENT (
    DNo INT PRIMARY KEY, -- Department nunber
    DName VARCHAR(50),
    MgrSSN INT,  -- Department manager in
    MgrStartDate DATE  -- date when manager started the department.
);
DESC DEPARTMENT;

-- there is a circular dependency on the tables DEPARTMENT and EMPLOYEE 
-- So adding foriegn Keys for DNo and MgrSSN requires alteration of the table

-- alter Employee
ALTER TABLE EMPLOYEE
ADD FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo) ON DELETE CASCADE;

-- alter department
ALTER TABLE DEPARTMENT
ADD FOREIGN KEY (MgrSSN) REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE;

-- Create the DLOCATION table
CREATE TABLE DLOCATION (
    DNo INT PRIMARY KEY,
    DLoc VARCHAR(200), -- department location
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo) ON DELETE CASCADE
);

-- Create the PROJECT table
CREATE TABLE PROJECT (
    PNo INT PRIMARY KEY, -- project number
    PName VARCHAR(50),  -- project name
    PLocation VARCHAR(100), -- project location
    DNo INT,  
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo) ON DELETE CASCADE
);

-- Create the WORKS_ON table
CREATE TABLE WORKS_ON (
    SSN INT,
    PNo INT,
    Hours DECIMAL(6, 2), -- number of hours the employee works on the project
    PRIMARY KEY (SSN, PNo),
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE,
    FOREIGN KEY (PNo) REFERENCES PROJECT(PNo) ON DELETE CASCADE
);

/* because of the circular dependency we cannot include the DNo without inserting data in 
DEPARTMENT Table*/


-- Insert data in Employee Table without DNo
INSERT INTO EMPLOYEE (SSN, Name, Address, Sex, Salary, SuperSSN)
VALUES
    (111, 'JOHN', '1st Main', 'Male', 60000.00, 112),
    (112, 'EMMA', '2nd Main', 'Female', 150000.00,NULL),
    (113, 'STARC', '3rd Main', 'Male', 70000.00, 112),
    (114, 'SOPHIE', '4th Main', 'Female', 80000.00, 112),
    (115, 'SMITH', '5th Main', 'Female', 90000.00, 112);

-- check inserted input
SELECT * FROM EMPLOYEE;
  

-- Insert data into the DEPARTMENT table
INSERT INTO DEPARTMENT (DNo, DName,MgrSSN,MgrStartDate)
VALUES
    (1, 'Finance Department', 113,'2020-01-10'),
    (2, 'Marketing Department',114, '2020-02-10'),
    (3, 'Research Department',115, '2020-03-10'),
    (4, 'Sales Department', 115,'2020-04-10'),
    (5, 'Production Department',112, '2020-05-10');
   
-- check inserted data   
SELECT * FROM DEPARTMENT;

/* Now insert the DNo in the Employee table by updating the table*/

UPDATE EMPLOYEE
SET DNo = 1
WHERE SSN = 111;

UPDATE EMPLOYEE
SET DNo = 3
WHERE SSN = 112;

UPDATE EMPLOYEE
SET DNo = 4
WHERE SSN = 113;

UPDATE EMPLOYEE
SET DNo = 5
WHERE SSN = 114;

UPDATE EMPLOYEE
SET DNo = 5
WHERE SSN = 115;

-- check
SELECT DNo FROM EMPLOYEE;

-- Insert data into Department location table
INSERT INTO DLOCATION (DNo,DLoc)
VALUES
    (1,"London"),
    (2,"USA"),
    (3,"Qatar"),
    (4,"South Africa"),
    (5,"Australia");

-- Check
SELECT * FROM DLOCATION; 

-- Insert Data into Project Table
INSERT INTO PROJECT (PNo, PName, PLocation, DNo)
VALUES
    (701, 'Project1', 'London', 1),
    (702, 'Project2', 'USA', 2),
    (703, 'Project3', 'Qatar', 3),
    (704, 'Project4', 'South Africa', 4),
    (705, 'Project5', 'Australia', 5);
    
 -- Insert data in Works_On table
INSERT INTO WORKS_ON (SSN, PNo, Hours)
VALUES
    (111, 701, 120.1),
    (112, 702, 130.21),
    (113, 703, 130.41),
    (114, 704, 150.21),
    (115, 705, 90.89);


-- various operations

-- Find the sum of the TotalHours required for the project completion
SELECT PName, SUM(Hours) AS TotalHours
FROM WORKS_ON
INNER JOIN PROJECT ON WORKS_ON.PNo = PROJECT.PNo
WHERE PROJECT.PNo = 701
GROUP BY PName;

SELECT PName, SUM(Hours) AS TotalHours
FROM WORKS_ON
INNER JOIN PROJECT ON WORKS_ON.PNo = PROJECT.PNo
WHERE PROJECT.PNo = 704
GROUP BY PName;
   
-- Altering Tables

-- Alter Employee table
ALTER TABLE EMPLOYEE
ADD DOB DATE;

-- ALter Department table
-- Add department expenditure
ALTER TABLE DEPARTMENT
ADD Department_Expenditure Decimal(10,2);

-- Adding Constraints

-- Allow only unique project name
ALTER TABLE PROJECT
ADD CONSTRAINT UniqueName UNIQUE (PName);

-- Dropping Constraints
-- drop the Unique Name of the project constraints
ALTER TABLE PROJECT
DROP CONSTRAINT UniqueName;

-- adding and dropping feilds
-- add project completion status

ALTER TABLE PROJECT
ADD Project_completion_status ENUM('yes', 'no','In Progress');

-- Update and Delete operations
-- Update an employee's salary
UPDATE EMPLOYEE
SET Salary = 20000.00
WHERE SSN = 112;

-- Delete Operations
-- Delete project from the project status
DELETE FROM PROJECT
WHERE PNo=701;

-- further operations
TRUNCATE TABLE WORKS_ON;  -- delete the contents of the table without actually dropping the table
-- the table remains with all the existing attributes with no data inside it

-- check
SELECT * FROM WORKS_ON;
