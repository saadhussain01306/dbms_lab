CREATE DATABASE company;
USE company;

-- Create the EMPLOYEE table
CREATE TABLE EMPLOYEE (
    SSN INT PRIMARY KEY, -- Social Security Number of the employee
    EName VARCHAR(100), 
    Address VARCHAR(100),
    Sex VARCHAR(10),
    Salary DECIMAL(10, 2),
    SuperSSN INT,
    DNo INT
);

-- Create the DEPARTMENT table
CREATE TABLE DEPARTMENT (
    DNo INT PRIMARY KEY, -- Department number
    DName VARCHAR(100),
    MgrSSN INT,  -- Department manager in
    MgrStartDate DATE,  -- date when manager started the department.
    FOREIGN KEY (MgrSSN) REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE
);


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
    FOREIGN KEY (SSN) REFERENCES EMPLOYEE(SSN) ON DELETE CASCADE,
    FOREIGN KEY (PNo) REFERENCES PROJECT(PNo) ON DELETE CASCADE
);

-- insert into the tables
-- Insert data in Employee Table without DNo
INSERT INTO EMPLOYEE (SSN, EName, Address, Sex, Salary, SuperSSN,DNo)
VALUES
    (111, 'Scott', '1st Main', 'Male', 700000.00, 112,1),
    (112, 'Emma', '2nd Main', 'Female', 700000.00,NULL,1),
    (113, 'Starc', '3rd Main', 'Male', 700000.00, 112,1),
    (114, 'Sophie', '4th Main', 'Female', 700000.00, 112,1),
    (115, 'Smith', '5th Main', 'Female', 700000.00, 112,1),
    (116, 'David', '1st Main', 'Male', 60000.00, 112,2),
    (117, 'Tom', '2nd Main', 'Female', 150000.00,NULL,3),
    (118, 'Tim', '3rd Main', 'Male', 70000.00, 112,4),
    (119, 'Yash', '4th Main', 'Female', 80000.00, 112,5),
    (110, 'Smriti', '5th Main', 'Female', 90000.00, 112,6);
    
-- Insert data into the DEPARTMENT table
INSERT INTO DEPARTMENT (DNo, DName,MgrSSN,MgrStartDate)
VALUES
    (1, 'Accounts', 113,'2020-01-10'),
    (2, 'Finanace',114, '2020-02-10'),
    (3, 'Research',115, '2020-03-10'),
    (4, 'Sales', 115,'2020-04-10'),
    (5, 'Production',112, '2020-05-10'),
    (6, 'Services',114,'2020-07-20');
 
 -- Insert data into Department location table
INSERT INTO DLOCATION (DNo,DLoc)
VALUES
    (1,"London"),
    (2,"USA"),
    (3,"Qatar"),
    (4,"South Africa"),
    (5,"Australia");
    
-- Insert Data into Project Table
INSERT INTO PROJECT (PNo, PName, PLocation, DNo)
VALUES
    (701, 'Project1', 'London', 1),
    (702, 'Project2', 'USA', 2),
    (703, 'Iot', 'Qatar', 3),
    (704, 'Internet', 'South Africa', 4),
    (705, 'Project5', 'Australia', 5);    
    
 -- Insert data in Works_On table
INSERT INTO WORKS_ON (SSN, PNo, Hours)
VALUES
    (111, 701, 120.1),
    (112, 702, 130.21),
    (113, 703, 130.41),
    (114, 704, 150.21),
    (115, 705, 90.89);  

-- queries

-- 1. Make a list of all project numbers for projects that involve an employee whose last name 
-- is ‘Scott’, either as a worker or as a manager of the department that controls the project.  

SELECT * FROM PROJECT WHERE 
DNo IN (SELECT DNo FROM EMPLOYEE WHERE ENAME LIKE "%Scott%") 
OR 
DNo IN (SELECT DNo FROM DEPARTMENT WHERE MgrSSN IN (SELECT SSN FROM EMPLOYEE WHERE ENAME LIKE "%Scott%"));    
 
-- 2. Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 
-- percent raise. 

--  Update salaries with a 10% raise for employees working on the 'IoT' project
UPDATE EMPLOYEE
SET Salary = Salary * 1.1
WHERE SSN IN 
(SELECT SSN FROM WORKS_ON WHERE PNo IN 
(SELECT PNo FROM PROJECT WHERE PName = 'IoT')); 

-- Display the resulting salaries

SELECT SSN, ENAME, Salary
FROM EMPLOYEE
WHERE SSN IN (SELECT SSN FROM WORKS_ON WHERE PNo IN (SELECT PNo FROM PROJECT WHERE PName = 'IoT'));
 
-- 3. Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the 
-- maximum salary, the minimum salary, and the average salary in this department 
SELECT
  SUM(E.Salary) AS TotalSalary,
  MAX(E.Salary) AS MaxSalary,
  MIN(E.Salary) AS MinSalary,
  AVG(E.Salary) AS AvgSalary
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNo = D.DNo
WHERE D.DName = 'Accounts';
 
 -- 4. Retrieve the name of each employee who works on all the projects controlled by 
-- department number 5 (use NOT EXISTS operator). 
SELECT E.ENAME
FROM EMPLOYEE E
WHERE NOT EXISTS (
  SELECT P.PNo
  FROM PROJECT P
  WHERE P.DNo = 5
    AND NOT EXISTS (
      SELECT W.PNo
      FROM WORKS_ON W
      WHERE W.SSN = E.SSN AND W.PNo = P.PNo
    )
);
 
-- 5. For each department that has more than five employees, retrieve the department 
-- number and the number of its employees who are making more than Rs. 6,00,000. 

SELECT 
    D.DNo AS DepartmentNumber,
    COUNT(E.SSN) AS NumberOfEmployees
FROM 
    DEPARTMENT D
JOIN 
    EMPLOYEE E ON D.DNo = E.DNo
WHERE 
    E.Salary > 600000.00
GROUP BY 
    D.DNo
HAVING 
    COUNT(E.SSN) >= 5;
   
-- 6. Create a view that shows name, dept name and location of all employees. 
CREATE OR REPLACE VIEW EmployeeView AS
SELECT E.ENAME, D.DName AS Department, DL.DLoc AS Location
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNo = D.DNo
JOIN DLOCATION DL ON D.DNo = DL.DNo;

-- check view
SELECT * FROM EmployeeView;

-- 7. Create a trigger that prevents a project from being deleted if it is currently being worked 
-- by any employee.

DELIMITER //
CREATE TRIGGER PREVENT_DELETE
BEFORE DELETE ON PROJECT
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT * FROM WORKS_ON WHERE PNo = OLD.PNo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The project cannot be deleted as it has an assigned employee';
    END IF;
END;
//
DELIMITER ;

-- CHECK trigger

DELETE FROM PROJECT WHERE PNo=702;
-- The project cannot be deleted as it has an assigned employee
