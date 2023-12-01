/*Data Manipulation Language (DML) and Data Control Language 
(DCL)
Write valid DML statements to retrieve tuples from the databases. The 
query may contain appropriate DML and DCL commands such as:
Select with
%like, between, where clause
Order by
Set Operations
Exists and not exists

Join operations
Aggregate functions
Group by
Group by having
Nested and correlated nested Queries
Grant and revoke permission

*/

/* INSURANCE DATABASE*/

USE Insurance;


-- like opeartor
SELECT * FROM PERSON WHERE name LIKE 'J%';
+-----------+-------+----------+------+
| driver_id | name  | address  | age  |
+-----------+-------+----------+------+
| D01       | JOHN  | 1st main |   52 |
| D02       | JAMES | 2nd main |   53 |
+-----------+-------+----------+------+

SELECT * FROM CAR WHERE model LIKE '%Sed%';
+-------+-------+------+
| regno | model | year |
+-------+-------+------+
| R01   | Sedan | 2007 |
+-------+-------+------+

-- BETWEEN OPERATOR
SELECT * FROM CAR WHERE year BETWEEN 2010 AND 2015;
+-------+-----------+------+
| regno | model     | year |
+-------+-----------+------+
| R02   | Sports    | 2010 |
| R03   | XUV       | 2011 |
| R04   | Hatchback | 2015 |
+-------+-----------+------+

SELECT * FROM CAR WHERE year NOT BETWEEN 2010 AND 2015;
+-------+-------+------+
| regno | model | year |
+-------+-------+------+
| R01   | Sedan | 2007 |
| R05   | SUV   | 2019 |
+-------+-------+------+

-- WHERE clause
SELECT * FROM PARTICIPATED WHERE damage_amount > 7000;
+-----------+-------+---------------+---------------+
| driver_id | regno | report_number | damage_amount |
+-----------+-------+---------------+---------------+
| D03       | R03   |           114 |          7780 |
| D04       | R04   |           115 |          8780 |
| D05       | R05   |           116 |          9780 |
+-----------+-------+---------------+---------------+

-- order by
SELECT * FROM PERSON ORDER BY name ASC;
+-----------+-------+----------+------+
| driver_id | name  | address  | age  |
+-----------+-------+----------+------+
| D02       | JAMES | 2nd main |   53 |
| D01       | JOHN  | 1st main |   52 |
| D05       | KEVIN | 5th main |   46 |
| D03       | PETER | 3rd main |   57 |
| D04       | ROCK  | 4th main |   45 |
+-----------+-------+----------+------+

-- set operation
-- UNION operation
SELECT driver_id,name FROM PERSON
UNION
SELECT regno,model FROM CAR;
+-----------+-----------+
| driver_id | name      |
+-----------+-----------+
| D01       | JOHN      |
| D02       | JAMES     |
| D03       | PETER     |
| D04       | ROCK      |
| D05       | KEVIN     |
| R01       | Sedan     |
| R02       | Sports    |
| R03       | XUV       |
| R04       | Hatchback |
| R05       | SUV       |
+-----------+-----------+

DELETE FROM PARTICIPATED
WHERE driver_id='D03';


-- INTERSECT OPRATION
SELECT driver_id,name FROM PERSON 
WHERE driver_id IN (SELECT driver_id FROM PARTICIPATED);
+-----------+-------+
| driver_id | name  |
+-----------+-------+
| D01       | JOHN  |
| D02       | JAMES |
| D04       | ROCK  |
| D05       | KEVIN |
+-----------+-------+

-- MINUS OPERATOR
SELECT driver_id,name FROM PERSON 
WHERE driver_id NOT IN (SELECT driver_id FROM PARTICIPATED);
+-----------+-------+
| driver_id | name  |
+-----------+-------+
| D03       | PETER |
+-----------+-------+

DELETE FROM OWNS 
WHERE driver_id='D04';  

-- EXISTS COMMAND
SELECT * FROM PERSON WHERE EXISTS
(SELECT * FROM OWNS WHERE PERSON.driver_id=OWNS.driver_id); 
+-----------+-------+----------+------+
| driver_id | name  | address  | age  |
+-----------+-------+----------+------+
| D01       | JOHN  | 1st main |   52 |
| D02       | JAMES | 2nd main |   53 |
| D03       | PETER | 3rd main |   57 |
| D05       | KEVIN | 5th main |   46 |
+-----------+-------+----------+------+

-- NOT EXISTS COMMAND
SELECT * FROM PERSON WHERE NOT EXISTS
(SELECT * FROM OWNS WHERE PERSON.driver_id=OWNS.driver_id); 
+-----------+------+----------+------+
| driver_id | name | address  | age  |
+-----------+------+----------+------+
| D04       | ROCK | 4th main |   45 |
+-----------+------+----------+------+

-- VIEWS

CREATE VIEW PERSON_VIEW AS 
SELECT driver_id,name FROM PERSON;

SELECT * FROM PERSON_VIEW;
+-----------+-------+
| driver_id | name  |
+-----------+-------+
| D01       | JOHN  |
| D02       | JAMES |
| D03       | PETER |
| D04       | ROCK  |
| D05       | KEVIN |
+-----------+-------+

-- adding columns in the view
CREATE OR REPLACE VIEW PERSON_VIEW AS 
SELECT driver_id, name, address FROM PERSON;

SELECT * FROM PERSON_VIEW;
+-----------+-------+----------+
| driver_id | name  | address  |
+-----------+-------+----------+
| D01       | JOHN  | 1st main |
| D02       | JAMES | 2nd main |
| D03       | PETER | 3rd main |
| D04       | ROCK  | 4th main |
| D05       | KEVIN | 5th main |
+-----------+-------+----------+


-- dropping columns in the view
CREATE OR REPLACE VIEW PERSON_VIEW AS 
SELECT driver_id, name FROM PERSON;

SELECT * FROM PERSON_VIEW;
+-----------+-------+
| driver_id | name  |
+-----------+-------+
| D01       | JOHN  |
| D02       | JAMES |
| D03       | PETER |
| D04       | ROCK  |
| D05       | KEVIN |
+-----------+-------+

-- TRIGGERS 
CREATE TABLE BACKUP (
    driver_id VARCHAR(50),
    regno VARCHAR(20)); 
-- creating a trigger
 
DELIMITER //
CREATE TRIGGER t
BEFORE DELETE ON OWNS
FOR EACH ROW
BEGIN
    INSERT INTO BACKUP VALUES(old.driver_id, old.regno);
END;
//
DELIMITER ;

-- drop a trigger
DROP TRIGGER IF EXISTS t;

DELETE FROM OWNS 
WHERE driver_id='D05'; 

-- check the backup table
SELECT * FROM BACKUP; 
+-----------+-------+
| driver_id | regno |
+-----------+-------+
| D05       | R05   |
+-----------+-------+

-- JOIN

-- INNER JOIN
SELECT * FROM CAR 
JOIN PARTICIPATED
ON CAR.regno=PARTICIPATED.regno;
+-------+-----------+------+-----------+-------+---------------+---------------+
| regno | model     | year | driver_id | regno | report_number | damage_amount |
+-------+-----------+------+-----------+-------+---------------+---------------+
| R01   | Sedan     | 2007 | D01       | R01   |           112 |          5780 |
| R02   | Sports    | 2010 | D02       | R02   |           113 |          6780 |
| R04   | Hatchback | 2015 | D04       | R04   |           115 |          8780 |
| R05   | SUV       | 2019 | D05       | R05   |           116 |          9780 |
+-------+-----------+------+-----------+-------+---------------+---------------+

-- LEFT JOIN
SELECT * FROM CAR 
LEFT JOIN PARTICIPATED
ON CAR.regno=PARTICIPATED.regno;
+-------+-----------+------+-----------+-------+---------------+---------------+
| regno | model     | year | driver_id | regno | report_number | damage_amount |
+-------+-----------+------+-----------+-------+---------------+---------------+
| R01   | Sedan     | 2007 | D01       | R01   |           112 |          5780 |
| R02   | Sports    | 2010 | D02       | R02   |           113 |          6780 |
| R03   | XUV       | 2011 | NULL      | NULL  |          NULL |          NULL |
| R04   | Hatchback | 2015 | D04       | R04   |           115 |          8780 |
| R05   | SUV       | 2019 | D05       | R05   |           116 |          9780 |
+-------+-----------+------+-----------+-------+---------------+---------------+

-- RIGHT JOIN
SELECT * FROM CAR 
RIGHT JOIN PARTICIPATED
ON CAR.regno=PARTICIPATED.regno;
+-------+-----------+------+-----------+-------+---------------+---------------+
| regno | model     | year | driver_id | regno | report_number | damage_amount |
+-------+-----------+------+-----------+-------+---------------+---------------+
| R01   | Sedan     | 2007 | D01       | R01   |           112 |          5780 |
| R02   | Sports    | 2010 | D02       | R02   |           113 |          6780 |
| R04   | Hatchback | 2015 | D04       | R04   |           115 |          8780 |
| R05   | SUV       | 2019 | D05       | R05   |           116 |          9780 |
+-------+-----------+------+-----------+-------+---------------+---------------+

-- full outer join
SELECT * FROM OWNS 
LEFT JOIN PARTICIPATED
ON OWNS.regno=PARTICIPATED.regno
UNION
SELECT * FROM OWNS 
RIGHT JOIN PARTICIPATED
ON OWNS.regno=PARTICIPATED.regno
WHERE OWNS.regno IS NULL;
+-----------+-------+-----------+-------+---------------+---------------+
| driver_id | regno | driver_id | regno | report_number | damage_amount |
+-----------+-------+-----------+-------+---------------+---------------+
| D01       | R01   | D01       | R01   |           112 |          5780 |
| D02       | R02   | D02       | R02   |           113 |          6780 |
| D03       | R03   | NULL      | NULL  |          NULL |          NULL |
| NULL      | NULL  | D04       | R04   |           115 |          8780 |
| NULL      | NULL  | D05       | R05   |           116 |          9780 |
+-----------+-------+-----------+-------+---------------+---------------+

-- Aggregate functions
-- count
SELECT o.driver_id, COUNT(p.driver_id) AS total_drivers
FROM OWNS o
LEFT JOIN PARTICIPATED p ON o.driver_id = p.driver_id
GROUP BY o.driver_id
HAVING COUNT(p.driver_id) > 0;
+-----------+---------------+
| driver_id | total_drivers |
+-----------+---------------+
| D01       |             1 |
| D02       |             1 |
+-----------+---------------+

-- AVG
SELECT avg(damage_amount) FROM PARTICIPATED;
+--------------------+
| avg(damage_amount) |
+--------------------+
|          7780.0000 |
+--------------------+

-- MIN
SELECT min(damage_amount) FROM PARTICIPATED;
+--------------------+
| min(damage_amount) |
+--------------------+
|               5780 |
+--------------------+
    
-- GROUP BY HAVING
SELECT COUNT(driver_id),damage_amount
FROM PARTICIPATED
GROUP BY damage_amount
HAVING COUNT(driver_id)>0;
+------------------+---------------+
| COUNT(driver_id) | damage_amount |
+------------------+---------------+
|                1 |          5780 |
|                1 |          6780 |
|                1 |          8780 |
|                1 |          9780 |
+------------------+---------------+

-- nested queries
SELECT * FROM PERSON WHERE driver_id IN (SELECT driver_id FROM OWNS);
+-----------+-------+----------+------+
| driver_id | name  | address  | age  |
+-----------+-------+----------+------+
| D01       | JOHN  | 1st main |   52 |
| D02       | JAMES | 2nd main |   53 |
| D03       | PETER | 3rd main |   57 |
+-----------+-------+----------+------+

-- correlated queries
SELECT * FROM PERSON WHERE EXISTS 
(SELECT * FROM OWNS WHERE PERSON.driver_id=OWNS.driver_id);
+-----------+-------+----------+------+
| driver_id | name  | address  | age  |
+-----------+-------+----------+------+
| D01       | JOHN  | 1st main |   52 |
| D02       | JAMES | 2nd main |   53 |
| D03       | PETER | 3rd main |   57 |
+-----------+-------+----------+------+

-- grant command
GRANT select ON hussain.PARTICIPATED TO 'JOHN'@'localhost';
ERROR 1410 (42000): You are not allowed to create a user with GRANT
    
-- revoke command
REVOKE select ON hussain.PARTICIPATED FROM 'JOHN'@'localhost';
ERROR 1147 (42000): There is no such grant defined for user 'JOHN' on host 'localhost' on table 'PARTICIPATED'
