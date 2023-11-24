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

/*The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

There are two wildcards often used in conjunction with the LIKE operator:

The percent sign (%) represents zero, one, or multiple characters
The underscore sign (_) represents one, single character
*/

@HUSSAIN Workbench

USE SAILORS;
-- LIKE OPERATOR
-- Select the boats with names containing 'Boat'
SELECT * FROM BOAT WHERE bname LIKE '%B%'; -- Finds any values that have "B" in any position
+-----+-------+--------+-------+
| bid | bname | color  | model |
+-----+-------+--------+-------+
| 701 | Boat1 | Green  |  1995 |
| 702 | Boat2 | Red    |  1995 |
| 703 | Boat3 | Green  |  1995 |
| 704 | Boat4 | Yellow |  1995 |
| 705 | Boat5 | White  |  1995 |
+-----+-------+--------+-------+

SELECT * FROM BOAT WHERE bname LIKE 'BO%'; -- Finds any values that start with "BO"
+-----+-------+--------+-------+
| bid | bname | color  | model |
+-----+-------+--------+-------+
| 701 | Boat1 | Green  |  1995 |
| 702 | Boat2 | Red    |  1995 |
| 703 | Boat3 | Green  |  1995 |
| 704 | Boat4 | Yellow |  1995 |
| 705 | Boat5 | White  |  1995 |
+-----+-------+--------+-------+


SELECT * FROM BOAT WHERE bname LIKE '____2'; -- Finds value in which 2 occurs after 4 characters(BOAT2);
+-----+-------+-------+-------+
| bid | bname | color | model |
+-----+-------+-------+-------+
| 702 | Boat2 | Red   |  1995 |
+-----+-------+-------+-------+


-- BETWEEN OPERATOR
/*The BETWEEN operator selects values within a given ridange. 
in BETWEEN operator begining and ending values are included*/

-- SELECT sailors aged between 26 and 29
SELECT * FROM SAILORS WHERE age BETWEEN 26 AND 29; -- Selects sailors that have age in between 26 and 29
+-----+-------+--------+------+-----------------+
| sid | sname | rating | age  | email           |
+-----+-------+--------+------+-----------------+
| 603 | PETER |    3.5 |   29 | peter@gmail.com |
| 604 | ROCK  |    4.2 |   26 | rock@gmail.com  |
| 605 | KEVIN |    3.9 |   28 | kevin@gmail.com |
+-----+-------+--------+------+-----------------+

SELECT * FROM SAILORS WHERE age NOT BETWEEN 26 AND 29; -- Selects sailors that have age in not between 26 and 29
+-----+-------+--------+------+-----------------+
| sid | sname | rating | age  | email           |
+-----+-------+--------+------+-----------------+
| 601 | JOHN  |    4.9 |   30 | john@gmail.com  |
| 602 | JAMES |    4.1 |   31 | james@gmail.com |
+-----+-------+--------+------+-----------------+

SELECT * FROM BOAT
WHERE color BETWEEN 'Blue' AND 'White' -- selects boat between whose name comes between 'B' and 'W'
ORDER BY bid;
+-----+-------+-------+-------+
| bid | bname | color | model |
+-----+-------+-------+-------+
| 701 | Boat1 | Green |  1995 |
| 702 | Boat2 | Red   |  1995 |
| 703 | Boat3 | Green |  1995 |
| 705 | Boat5 | White |  1995 |
+-----+-------+-------+-------+


-- WHERE CLAUSE
SELECT * FROM RSERVERS WHERE sid=601; -- selects row in which sid=601
+-----+-----+------------+----------------+
| sid | bid | date       | Departure_time |
+-----+-----+------------+----------------+
| 601 | 701 | 2023-07-01 | 10:30:00       |
+-----+-----+------------+----------------+

-- ORDER BY
/* Used to sort the rows in ascending or decending order
by default it sorts in ascneding order is ASEC or DESC is not specified*/

-- Retrieve sailors with a rating greater than 2.0, order by rating in descending order
SELECT * FROM SAILORS WHERE rating > 2.0 ORDER BY rating DESC;
+-----+-------+--------+------+-----------------+
| sid | sname | rating | age  | email           |
+-----+-------+--------+------+-----------------+
| 601 | JOHN  |    4.9 |   30 | john@gmail.com  |
| 604 | ROCK  |    4.2 |   26 | rock@gmail.com  |
| 602 | JAMES |    4.1 |   31 | james@gmail.com |
| 605 | KEVIN |    3.9 |   28 | kevin@gmail.com |
| 603 | PETER |    3.5 |   29 | peter@gmail.com |
+-----+-------+--------+------+-----------------+

SELECT * FROM SAILORS WHERE rating > 2.0 ORDER BY rating;-- by default in descending order
+-----+-------+--------+------+-----------------+
| sid | sname | rating | age  | email           |
+-----+-------+--------+------+-----------------+
| 603 | PETER |    3.5 |   29 | peter@gmail.com |
| 605 | KEVIN |    3.9 |   28 | kevin@gmail.com |
| 602 | JAMES |    4.1 |   31 | james@gmail.com |
| 604 | ROCK  |    4.2 |   26 | rock@gmail.com  |
| 601 | JOHN  |    4.9 |   30 | john@gmail.com  |
+-----+-------+--------+------+-----------------+

-- SET operations

-- UNION operation
SELECT sid,sname FROM SAILORS
UNION
SELECT bid,bname FROM BOAT;  -- combines the both column entries into single column sname
+-----+-------+
| sid | sname |
+-----+-------+
| 601 | JOHN  |
| 602 | JAMES |
| 603 | PETER |
| 604 | ROCK  |
| 605 | KEVIN |
| 701 | Boat1 |
| 702 | Boat2 |
| 703 | Boat3 |
| 704 | Boat4 |
| 705 | Boat5 |
+-----+-------+



DELETE FROM RSERVERS
WHERE sid = 603;

-- INTERSECT operation ( there is no INTERSECT command in Mysql instead we use this sub query)
SELECT sid,sname FROM SAILORS
WHERE sid IN (SELECT sid FROM RSERVERS);
+-----+-------+
| sid | sname |
+-----+-------+
| 601 | JOHN  |
| 602 | JAMES |
| 604 | ROCK  |
| 605 | KEVIN |
+-----+-------+

-- MINUS opearation
-- Retrieve a list of sailors who did not make any reservations using NOT IN command
SELECT sname FROM SAILORS
WHERE sid NOT IN (SELECT sid FROM RSERVERS);

+-------+
| sname |
+-------+
| PETER |
+-------+


-- EXISTS  NOT EXISTS
-- this operator returns true or false value 

-- EXISTS
SELECT * FROM SAILORS WHERE EXISTS 
(SELECT * FROM RSERVERS WHERE SAILORS.sid=RSERVERS.sid); 
-- selects all the rows for which the exists condition is true
+-----+-------+--------+------+-----------------+
| sid | sname | rating | age  | email           |
+-----+-------+--------+------+-----------------+
| 601 | JOHN  |    4.9 |   30 | john@gmail.com  |
| 602 | JAMES |    4.1 |   31 | james@gmail.com |
| 604 | ROCK  |    4.2 |   26 | rock@gmail.com  |
| 605 | KEVIN |    3.9 |   28 | kevin@gmail.com |
+-----+-------+--------+------+-----------------+


-- NOT EXISTS
SELECT * FROM SAILORS WHERE NOT EXISTS 
(SELECT * FROM RSERVERS WHERE SAILORS.sid=RSERVERS.sid); 
-- selects all the rows for which the exists condition is false
+-----+-------+--------+------+-----------------+
| sid | sname | rating | age  | email           |
+-----+-------+--------+------+-----------------+
| 603 | PETER |    3.5 |   29 | peter@gmail.com |
+-----+-------+--------+------+-----------------+


-- JOIN
-- it is used to combine row from two or more tables ,based on a related column between them
-- INNER JOIN,LEFT JOIN,RIGHT JOIN

-- INNER JOIN
SELECT * FROM SAILORS
JOIN RSERVERS
ON SAILORS.sid=RSERVERS.sid;
+-----+-------+--------+------+-----------------+-----+-----+------------+----------------+
| sid | sname | rating | age  | email           | sid | bid | date       | Departure_time |
+-----+-------+--------+------+-----------------+-----+-----+------------+----------------+
| 601 | JOHN  |    4.9 |   30 | john@gmail.com  | 601 | 701 | 2023-07-01 | 10:30:00       |
| 602 | JAMES |    4.1 |   31 | james@gmail.com | 602 | 702 | 2023-05-01 | 10:30:00       |
| 604 | ROCK  |    4.2 |   26 | rock@gmail.com  | 604 | 704 | 2023-02-05 | 10:30:00       |
| 605 | KEVIN |    3.9 |   28 | kevin@gmail.com | 605 | 705 | 2023-05-09 | 10:30:00       |
+-----+-------+--------+------+-----------------+-----+-----+------------+----------------+



-- LEFT JOIN
SELECT * FROM SAILORS
LEFT JOIN RSERVERS
ON SAILORS.sid=RSERVERS.sid;
+-----+-------+--------+------+-----------------+------+------+------------+----------------+
| sid | sname | rating | age  | email           | sid  | bid  | date       | Departure_time |
+-----+-------+--------+------+-----------------+------+------+------------+----------------+
| 601 | JOHN  |    4.9 |   30 | john@gmail.com  |  601 |  701 | 2023-07-01 | 10:30:00       |
| 602 | JAMES |    4.1 |   31 | james@gmail.com |  602 |  702 | 2023-05-01 | 10:30:00       |
| 603 | PETER |    3.5 |   29 | peter@gmail.com | NULL | NULL | NULL       | NULL           |
| 604 | ROCK  |    4.2 |   26 | rock@gmail.com  |  604 |  704 | 2023-02-05 | 10:30:00       |
| 605 | KEVIN |    3.9 |   28 | kevin@gmail.com |  605 |  705 | 2023-05-09 | 10:30:00       |
+-----+-------+--------+------+-----------------+------+------+------------+----------------+


-- RIGHT JOIN
SELECT * FROM SAILORS
RIGHT JOIN RSERVERS
ON SAILORS.sid=RSERVERS.sid;
+------+-------+--------+------+-----------------+-----+-----+------------+----------------+
| sid  | sname | rating | age  | email           | sid | bid | date       | Departure_time |
+------+-------+--------+------+-----------------+-----+-----+------------+----------------+
|  601 | JOHN  |    4.9 |   30 | john@gmail.com  | 601 | 701 | 2023-07-01 | 10:30:00       |
|  602 | JAMES |    4.1 |   31 | james@gmail.com | 602 | 702 | 2023-05-01 | 10:30:00       |
|  604 | ROCK  |    4.2 |   26 | rock@gmail.com  | 604 | 704 | 2023-02-05 | 10:30:00       |
|  605 | KEVIN |    3.9 |   28 | kevin@gmail.com | 605 | 705 | 2023-05-09 | 10:30:00       |
+------+-------+--------+------+-----------------+-----+-----+------------+----------------+

-- FULL OUTER JOIN 
SELECT * FROM SAILORS
LEFT JOIN RSERVERS
ON SAILORS.sid=RSERVERS.sid
UNION
SELECT * FROM SAILORS
RIGHT JOIN RSERVERS
ON SAILORS.sid=RSERVERS.sid; 

+------+-------+--------+------+-----------------+------+------+------------+----------------+
| sid  | sname | rating | age  | email           | sid  | bid  | date       | Departure_time |
+------+-------+--------+------+-----------------+------+------+------------+----------------+
|  601 | JOHN  |    4.1 |   30 | john@gmail.com  |  601 |  701 | 2023-07-01 | 10:30:00       |
|  602 | JAMES |    4.1 |   31 | james@gmail.com |  602 |  702 | 2023-05-01 | 10:30:00       |
|  603 | PETER |    3.5 |   29 | peter@gmail.com | NULL | NULL | NULL       | NULL           |
|  604 | ROCK  |    4.2 |   26 | rock@gmail.com  |  604 |  704 | 2023-02-05 | 10:30:00       |
|  605 | KEVIN |    3.9 |   28 | kevin@gmail.com |  605 |  705 | 2023-05-09 | 10:30:00       |
+------+-------+--------+------+-----------------+------+------+------------+----------------+

-- Aggregate functions
-- count,sum,min,max,avg

-- count() returns the total numbers of rows in the table
-- sum() returns the total sum of the numeric column
-- avg() calculates the avergae values of the set of values
-- min() returns lowest value in a set of non-null values
-- max() returns largest value in a set of non-null values

SELECT count(sid) FROM SAILORS WHERE rating>4.0; -- returns total sailors whose rating is more than 4
+------------+
| count(sid) |
+------------+
|          3 |
+------------+

SELECT sum(age) FROM SAILORS;
+----------+
| sum(age) |
+----------+
|      144 |
+----------+

SELECT avg(age) FROM SAILORS;
+----------+
| avg(age) |
+----------+
|  28.8000 |
+----------+

SELECT min(sid) FROM RSERVERS;
+----------+
| min(sid) |
+----------+
|      601 |
+----------+


SELECT max(bid) FROM BOAT;
+----------+
| max(bid) |
+----------+
|      705 |
+----------+



-- GROUP
UPDATE SAILORS
SET rating=4.1 WHERE sid=601;


-- GROUP BY
SELECT COUNT(sid),rating
FROM SAILORS
GROUP BY rating;
-- shows the number of sailors who have the same rating
+------------+--------+
| COUNT(sid) | rating |
+------------+--------+
|          2 |    4.1 |
|          1 |    3.5 |
|          1 |    4.2 |
|          1 |    3.9 |
+------------+--------+


-- GROUP BY HAVING
-- HAVING condition is used because WHERE clause cannot be used in aggregate functions

SELECT COUNT(sid),rating
FROM SAILORS
GROUP BY rating
HAVING COUNT(sid)>1;
+------------+--------+
| COUNT(sid) | rating |
+------------+--------+
|          2 |    4.1 |
+------------+--------+


-- nested queries
-- we first execute the inner query first and then the comapre the column atributes with the values
-- that we get in the inner query
SELECT * FROM SAILORS WHERE sid IN (SELECT sid FROM RSERVERS);
+-----+-------+--------+------+-----------------+
| sid | sname | rating | age  | email           |
+-----+-------+--------+------+-----------------+
| 601 | JOHN  |    4.1 |   30 | john@gmail.com  |
| 602 | JAMES |    4.1 |   31 | james@gmail.com |
| 604 | ROCK  |    4.2 |   26 | rock@gmail.com  |
| 605 | KEVIN |    3.9 |   28 | kevin@gmail.com |
+-----+-------+--------+------+-----------------+


-- correlated queries 
-- defines relation between outer and inner query (in top down approach)
SELECT * FROM SAILORS WHERE EXISTS 
(SELECT * FROM RSERVERS WHERE SAILORS.sid=RSERVERS.sid); 
+-----+-------+--------+------+-----------------+
| sid | sname | rating | age  | email           |
+-----+-------+--------+------+-----------------+
| 601 | JOHN  |    4.1 |   30 | john@gmail.com  |
| 602 | JAMES |    4.1 |   31 | james@gmail.com |
| 604 | ROCK  |    4.2 |   26 | rock@gmail.com  |
| 605 | KEVIN |    3.9 |   28 | kevin@gmail.com |
+-----+-------+--------+------+-----------------+



-- grant command
GRANT select ON hussain.boat TO 'JOHN'@'localhost';
ERROR 1142 (42000): GRANT command denied to user 'sem5d1'@'localhost' for table 'boat'

-- revoke command

REVOKE select ON hussain.boat FROM 'JOHN'@'localhost';
ERROR 1142 (42000): GRANT command denied to user 'sem5d1'@'localhost' for table 'boat'

