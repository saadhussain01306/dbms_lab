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
SELECT * FROM CAR WHERE model LIKE '%Sed%';

-- BETWEEN OPERATOR
SELECT * FROM CAR WHERE year BETWEEN 2010 AND 2015;
SELECT * FROM CAR WHERE year NOT BETWEEN 2010 AND 2015;

-- WHERE clause
SELECT * FROM PARTICIPATED WHERE damage_amount > 7000;

-- order by
SELECT * FROM PERSON ORDER BY name ASC;

-- set operation
-- UNION operation
SELECT driver_id,name FROM PERSON
UNION
SELECT regno,model FROM CAR;

DELETE FROM PARTICIPATED
WHERE driver_id='D03';

-- INTERSECT OPRATION
SELECT driver_id,name FROM PERSON 
WHERE driver_id IN (SELECT driver_id FROM PARTICIPATED);

-- MINUS OPERATOR
SELECT driver_id,name FROM PERSON 
WHERE driver_id NOT IN (SELECT driver_id FROM PARTICIPATED);

DELETE FROM OWNS 
WHERE driver_id='D04';  

-- EXISTS COMMAND
SELECT * FROM PERSON WHERE EXISTS
(SELECT * FROM OWNS WHERE PERSON.driver_id=OWNS.driver_id); 
-- NOT EXISTS COMMAND
SELECT * FROM PERSON WHERE NOT EXISTS
(SELECT * FROM OWNS WHERE PERSON.driver_id=OWNS.driver_id); 

-- VIEWS

CREATE VIEW PERSON_VIEW AS 
SELECT driver_id,name FROM PERSON;

SELECT * FROM PERSON_VIEW;

-- adding columns in the view
CREATE OR REPLACE VIEW PERSON_VIEW AS 
SELECT driver_id, name, address FROM PERSON;

-- dropping columns in the view
CREATE OR REPLACE VIEW PERSON_VIEW AS 
SELECT driver_id, name FROM PERSON;

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

-- JOIN

-- INNER JOIN
SELECT * FROM CAR 
JOIN PARTICIPATED
ON CAR.regno=PARTICIPATED.regno;

-- LEFT JOIN
SELECT * FROM CAR 
LEFT JOIN PARTICIPATED
ON CAR.regno=PARTICIPATED.regno;

-- RIGHT JOIN
SELECT * FROM CAR 
RIGHT JOIN PARTICIPATED
ON CAR.regno=PARTICIPATED.regno;

-- full outer join
SELECT * FROM OWNS 
LEFT JOIN PARTICIPATED
ON OWNS.regno=PARTICIPATED.regno
UNION
SELECT * FROM OWNS 
RIGHT JOIN PARTICIPATED
ON OWNS.regno=PARTICIPATED.regno
WHERE OWNS.regno IS NULL;

-- Aggregate functions
-- count
SELECT o.driver_id, COUNT(p.driver_id) AS total_drivers
FROM OWNS o
LEFT JOIN PARTICIPATED p ON o.driver_id = p.driver_id
GROUP BY o.driver_id
HAVING COUNT(p.driver_id) > 0;

-- AVG
SELECT avg(damage_amount) FROM PARTICIPATED;

-- MIN
SELECT min(damage_amount) FROM PARTICIPATED;


-- GROUP BY HAVING
SELECT COUNT(driver_id),damage_amount
FROM PARTICIPATED
GROUP BY damage_amount
HAVING COUNT(driver_id)>0;

-- nested queries
SELECT * FROM PERSON WHERE driver_id IN (SELECT driver_id FROM OWNS);

-- correlated queries
SELECT * FROM PERSON WHERE EXISTS 
(SELECT * FROM OWNS WHERE PERSON.driver_id=OWNS.driver_id);

-- grant command
GRANT select ON hussain.participated TO 'JOHN'@'localhost';
ERROR 1142 (42000): GRANT command denied to user 'sem5d1'@'localhost' for table 'participated'

-- revoke command

REVOKE select ON hussain.participated FROM 'JOHN'@'localhost';
ERROR 1142 (42000): GRANT command denied to user 'sem5d1'@'localhost' for table 'participated'
