-- Data Definition Language (DDL) commands in RDBMS

--Consider the database schemas given below.

-- Write ER diagram and schema diagram. The primary keys are 

--underlined and the data types are specified.

--Create tables for the following schema listed below by properly 

--specifying the primary keys and foreign keys.

--Enter at least five tuples for each relation.

--Altering tables,

--Adding and Dropping different types of constraints.

--Also adding and dropping fields in to the relational schemas of the listed
--problems.

--Delete, Update operations

--  A.Sailors database

--SAILORS (sid, sname, rating, age)

--BOAT(bid, bname, color)

--RSERVERS (sid, bid, date)



CREATE DATABASE Sailors;
USE Sailors;

CREATE TABLE SAILORS (
    sid INT PRIMARY KEY,
    sname VARCHAR(100),
    rating FLOAT,
    age INT
);

CREATE TABLE BOAT (
    bid INT PRIMARY KEY,
    bname VARCHAR(100),
    color VARCHAR(100)
);

CREATE TABLE RSERVERS (
    sid INT ,
    bid INT,
    date DATE,
    PRIMARY KEY (sid,bid),
    FOREIGN KEY (sid) REFERENCES SAILORS(sid),
    FOREIGN KEY (bid) REFERENCES BOAT(bid)
);

-- insert data in SAILORS

INSERT INTO SAILORS (sid, sname, rating, age) VALUES
    (601, "JOHN", 4.3, 30),
    (602, "JAMES", 4.1, 31),
    (603, "PETER", 3.5, 29),
    (604, "ROCK", 4.2, 26),
    (605, "KEVIN", 3.9, 28);

-- insert data in BOAT
INSERT INTO BOAT (bid, bname, color) VALUES
    (701, 'Boat1', 'Blue'),
    (702, 'Boat2', 'Red'),
    (703, 'Boat3', 'Green'),
    (704, 'Boat4', 'Yellow'),
    (705, 'Boat5', 'White');
    
    
-- insert into rservers    
INSERT INTO RSERVERS (sid, bid, date) VALUES
    (601, 701, '2023-07-01'),
    (602, 702, '2023-05-02'),
    (603, 703, '2023-03-04'),
    (604, 704, '2023-02-05'),
    (605, 705, '2023-05-09');
    
-- alter the sailor table
ALTER TABLE SAILORS
ADD email VARCHAR(100);

UPDATE SAILORS
SET email= 'john@gamil.com'
WHERE sid=601;

UPDATE SAILORS
SET email= 'james@gamil.com'
WHERE sid=602;

UPDATE SAILORS
SET email= 'peter@gamil.com'
WHERE sid=603;

UPDATE SAILORS
SET email= 'rock@gamil.com'
WHERE sid=604;

UPDATE SAILORS
SET email= 'kevin@gamil.com'
WHERE sid=605;

-- check if the table is altered or not
SELECT * FROM SAILORS;


-- alter the boat table
ALTER TABLE BOAT
ADD model INT;

UPDATE BOAT
SET model= 1995
WHERE bid IN (701,702,703,704,705);

-- check if the table is altered or not
SELECT * FROM BOAT;


-- alter the rservers table
ALTER TABLE RSERVERS
ADD Departure_time time ;

UPDATE RSERVERS
SET Departure_time = '10:30:00'
WHERE bid IN (701,702,703,704,705);

-- check if the table is updated
SELECT * FROM RSERVERS;

-- adding and dropping constraints

-- ensures that no two sailors have the same email ID
ALTER TABLE SAILORS
ADD CONSTRAINT unique_email UNIQUE (email);

-- ensures that no boat have the model year less than 1980 
ALTER TABLE BOAT
ADD CONSTRAINT check_model_year CHECK (model >= 1980);

-- dropping constriants

-- dropping the unique email id constraint
ALTER TABLE SAILORS
DROP CONSTRAINT unique_email;

-- dropping the model year constraints
-- Drop the check constraint from the model column in BOAT table
ALTER TABLE BOAT
DROP CONSTRAINT check_model_year;

-- adding and dropping fields in to the relational schemas 

-- adding feilds 
ALTER TABLE BOAT
ADD location VARCHAR(100);

-- dropping feilds
-- Dropping the 'loctaion 'field from the BOAT table
ALTER TABLE BOAT
DROP COLUMN location;


-- delete and update operations

-- update rating of john
UPDATE SAILORS
SET rating = 4.9
WHERE sid = 601;


-- update color of boat1
UPDATE BOAT
SET color = 'Green'
WHERE bname = 'Boat1';

-- delete operations
DELETE FROM SAILORS
WHERE sid = 603;

DELETE FROM BOAT
WHERE bid = 705;

-- output:-

DESC SAILORS;
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| sid    | int          | NO   | PRI | NULL    |       |
| sname  | varchar(100) | YES  |     | NULL    |       |
| rating | float        | YES  |     | NULL    |       |
| age    | int          | YES  |     | NULL    |       |
+--------+--------------+------+-----+---------+-------+
DESC BOAT;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| bid   | int          | NO   | PRI | NULL    |       |
| bname | varchar(100) | YES  |     | NULL    |       |
| color | varchar(100) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
DESC RSERVERS;
+-------+------+------+-----+---------+-------+
| Field | Type | Null | Key | Default | Extra |
+-------+------+------+-----+---------+-------+
| sid   | int  | NO   | PRI | NULL    |       |
| bid   | int  | NO   | PRI | NULL    |       |
| date  | date | YES  |     | NULL    |       |
+-------+------+------+-----+---------+-------+
SELECT * FROM SAILORS;
+-----+-------+--------+------+
| sid | sname | rating | age  |
+-----+-------+--------+------+
| 601 | JOHN  |    4.3 |   30 |
| 602 | JAMES |    4.1 |   31 |
| 603 | PETER |    3.5 |   29 |
| 604 | ROCK  |    4.2 |   26 |
| 605 | KEVIN |    3.9 |   28 |
+-----+-------+--------+------+

SELECT * FROM BOAT;
+-----+-------+--------+
| bid | bname | color  |
+-----+-------+--------+
| 701 | Boat1 | Blue   |
| 702 | Boat2 | Red    |
| 703 | Boat3 | Green  |
| 704 | Boat4 | Yellow |
| 705 | Boat5 | White  |
+-----+-------+--------+
SELECT * FROM RSERVERS;
+-----+-----+------------+
| sid | bid | date       |
+-----+-----+------------+
| 601 | 701 | 2023-07-01 |
| 602 | 702 | 2023-05-01 |
| 603 | 703 | 2023-03-04 |
| 604 | 704 | 2023-02-05 |
| 605 | 705 | 2023-05-09 |
+-----+-----+------------+
update salors table;
+-----+-------+--------+------+-----------------+
| sid | sname | rating | age  | email           |
+-----+-------+--------+------+-----------------+
| 601 | JOHN  |    4.3 |   30 | john@gmail.com  |
| 602 | JAMES |    4.1 |   31 | james@gmail.com |
| 603 | PETER |    3.5 |   29 | peter@gmail.com |
| 604 | ROCK  |    4.2 |   26 | rock@gmail.com  |
| 605 | KEVIN |    3.9 |   28 | kevin@gmail.com |
+-----+-------+--------+------+-----------------+
-- alter boat table;
+-----+-------+--------+-------+
| bid | bname | color  | model |
+-----+-------+--------+-------+
| 701 | Boat1 | Blue   |  1995 |
| 702 | Boat2 | Red    |  1995 |
| 703 | Boat3 | Green  |  1995 |
| 704 | Boat4 | Yellow |  1995 |
| 705 | Boat5 | White  |  1995 |
+-----+-------+--------+-------+
-- alter the rservers value
+-----+-----+------------+----------------+
| sid | bid | date       | Departure_time |
+-----+-----+------------+----------------+
| 601 | 701 | 2023-07-01 | 10:30:00       |
| 602 | 702 | 2023-05-01 | 10:30:00       |
| 603 | 703 | 2023-03-04 | 10:30:00       |
| 604 | 704 | 2023-02-05 | 10:30:00       |
| 605 | 705 | 2023-05-09 | 10:30:00       |
+-----+-----+------------+----------------+
-- adding the constraint unique_email
UPDATE SAILORS
    -> SET email="john@gmail.com"
    -> WHERE sid IN (602,603,604);
ERROR 1062 (23000): Duplicate entry 'john@gmail.com' for key 'SAILORS.unique_email'

-- adding the check_model_year constraint in the boat table 
UPDATE BOAT
    -> SET model=1975
    -> WHERE bid IN (702,703,705);
ERROR 3819 (HY000): Check constraint 'check_model_year' is violated.

-- adding the location field in the boat table
+-----+-------+--------+-------+----------+
| bid | bname | color  | model | LOCATION |
+-----+-------+--------+-------+----------+
| 701 | Boat1 | Blue   |  1995 | NULL     |
| 702 | Boat2 | Red    |  1995 | NULL     |
| 703 | Boat3 | Green  |  1995 | NULL     |
| 704 | Boat4 | Yellow |  1995 | NULL     |
| 705 | Boat5 | White  |  1995 | NULL     |
+-----+-------+--------+-------+----------+
-- dropping the location field in the boat table
+-----+-------+--------+-------+
| bid | bname | color  | model |
+-----+-------+--------+-------+
| 701 | Boat1 | Blue   |  1995 |
| 702 | Boat2 | Red    |  1995 |
| 703 | Boat3 | Green  |  1995 |
| 704 | Boat4 | Yellow |  1995 |
| 705 | Boat5 | White  |  1995 |
+-----+-------+--------+-------+

-- update operatios
UPDATE BOAT 
    -> SET color="Green"
    -> WHERE bid=701;
+-----+-------+-------+-------+
| bid | bname | color | model |
+-----+-------+-------+-------+
| 701 | Boat1 | Green |  1995 |
+-----+-------+-------+-------+
UPDATE SAILORS
    -> SET rating=4.9
    -> WHERE sid=601;
+-----+-------+--------+------+----------------+
| sid | sname | rating | age  | email          |
+-----+-------+--------+------+----------------+
| 601 | JOHN  |    4.9 |   30 | john@gmail.com |
+-----+-------+--------+------+----------------+

