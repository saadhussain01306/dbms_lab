/* Data Definition Language (DDL) commands in RDBMS
Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are 
underlined and the data types are specified.
Create tables for the following schema listed below by properly 
specifying the primary keys and foreign keys.
Enter at least five tuples for each relation.
Altering tables,
Adding and Dropping different types of constraints.
Also adding and dropping fields in to the relational schemas of the listed problems.
Delete, Update operations

B. Insurance database
PERSON (driver id#: string, name: string, address: string)
CAR (regno: string, model: string, year: int)
ACCIDENT (report_ number: int, acc_date: date, location: string)
OWNS (driver id#: string, regno: string)
PARTICIPATED(driver id#:string, regno:string, report_ number: 
int,damage_amount: int)
*/

/* create all the tables to find whether the user is capable for claiming the insurance*/

CREATE DATABASE Insurance;
USE Insurance;

-- Create PERSON table
CREATE TABLE PERSON (
    driver_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(100)
);

-- Create CAR table
CREATE TABLE CAR (
    regno VARCHAR(20) PRIMARY KEY,
    model VARCHAR(50),
    year INT
);

-- Create ACCIDENT table
CREATE TABLE ACCIDENT (
    report_number INT PRIMARY KEY,
    acc_date DATE,
    location VARCHAR(100)
);

-- Create OWNS table
CREATE TABLE OWNS (
    driver_id VARCHAR(50),
    regno VARCHAR(20),
    PRIMARY KEY (driver_id, regno),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (regno) REFERENCES CAR(regno)
);

-- Create PARTICIPATED table
CREATE TABLE PARTICIPATED (
    driver_id VARCHAR(50),
    regno VARCHAR(20),
    report_number INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, regno, report_number),
    FOREIGN KEY (driver_id) REFERENCES PERSON(driver_id),
    FOREIGN KEY (regno) REFERENCES CAR(regno),
    FOREIGN KEY (report_number) REFERENCES ACCIDENT(report_number)
);

-- insert in PERSON table
INSERT INTO PERSON (driver_id,name, address) VALUES
    ("D01", "JOHN", "1st main"),
    ("D02", "JAMES","2nd main"),
    ("D03", "PETER", "3rd main"),
    ("D04", "ROCK", "4th main"),
    ("D05", "KEVIN", "5th main");
    
    -- check if the data is inserted in PERSON table
    SELECT * FROM PERSON;
 
 -- insert values in the CAR table
 INSERT INTO CAR (regno,model,year) VALUES
    ("R01", "Sedan", "2007"),
    ("R02", "Sports","2010"),
    ("R03", "XUV", "2011"),
    ("R04", "Hatchback", "2015"),
    ("R05", "SUV", "2019");
    
 -- check if the data is inserted in CAR table
    SELECT * FROM CAR;   
    
INSERT INTO  ACCIDENT(report_number,acc_date,location) VALUES
    (112, '2023-05-11', "Street A"),
    (113, '2023-05-12',"Street B"),
    (114, '2023-05-13', "Street C"),
    (115, '2023-05-14', "Street D"),
    (116, '2023-05-15',"Street E");   
    
    -- check if the data is inserted in ACCIDENT table
    SELECT * FROM ACCIDENT; 
    
 INSERT INTO OWNS (driver_id, regno) VALUES
('D01', 'R01'),
('D02', 'R02'),
('D03', 'R03'),
('D04', 'R04'),
('D05', 'R05');   

 -- check if the data is inserted in OWNS table
    SELECT * FROM OWNS; 
    
    INSERT INTO PARTICIPATED (driver_id, regno, report_number, damage_amount) VALUES
('D01', 'R01', 112, 5780),
('D02', 'R02', 113, 6780),
('D03', 'R03', 114, 7780),
('D04', 'R04', 115, 8780),
('D05', 'R05', 116, 9500);

-- check if the data is inserted in PARTICIPATED table
    SELECT * FROM  PARTICIPATED; 
    
    -- alter tables
    
    -- alter PERSON table
ALTER TABLE PERSON
ADD age INT;

UPDATE PERSON
SET age=52 
WHERE driver_id="D01";

UPDATE PERSON
SET age=53 
WHERE driver_id="D02";

UPDATE PERSON
SET age=57
WHERE driver_id="D03";

UPDATE PERSON
SET age=45 
WHERE driver_id="D04";

UPDATE PERSON
SET age=46
WHERE driver_id="D05";

-- check the PERSON table if it is altered ??
SELECT * FROM PERSON;

-- alter the CAR table 
ALTER TABLE CAR
ADD color VARCHAR(20);

UPDATE CAR
SET color= "Yellow"
WHERE regno IN ("R01","R02","R03","R04","R05");

-- check if the CAR tabel if it is altered??
SELECT * FROM CAR;

-- alter the OWNS table
ALTER TABLE OWNS
ADD purchase_date DATE;

UPDATE OWNS
SET purchase_date= "2023-07-23"
WHERE driver_id IN ("D01","D02","D03","D04","D05");

-- check if the OWNS table is altered or not??
SELECT * FROM OWNS;

-- adding and dropping constraints
-- ensures that no two person have the same driver_id
ALTER TABLE PERSON
ADD CONSTRAINT unique_driver_id UNIQUE (driver_id);

-- ensures that no CAR have a year less than 1980 
ALTER TABLE CAR
ADD CONSTRAINT check_year CHECK (year >= 1980);

-- drop the check_year constraints
ALTER TABLE CAR
DROP CONSTRAINT check_year;

-- adding and dropping fields in to the relational schemas 

-- add accident description
ALTER TABLE ACCIDENT
ADD description VARCHAR(100);

-- -- dropping feilds
-- Dropping the description field
ALTER TABLE ACCIDENT
DROP COLUMN description;

-- update and delete operations

-- update color in CAR Table
UPDATE CAR
SET color = 'Orange'
WHERE regno = 'R01';

-- delete from PARTICIPATED Table
DELETE FROM PARTICIPATED
WHERE driver_id="D01";
