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

@S_HUSSAIN WORKBENCH

/*The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

There are two wildcards often used in conjunction with the LIKE operator:

The percent sign (%) represents zero, one, or multiple characters
The underscore sign (_) represents one, single character
*/

-- LIKE OPERATOR
-- Select the boats with names containing 'Boat'
SELECT * FROM BOAT WHERE bname LIKE '%B%'; -- Finds any values that have "B" in any position
SELECT * FROM BOAT WHERE bname LIKE 'BO%'; -- Finds any values that start with "BO"
SELECT * FROM BOAT WHERE bname LIKE '____2'; -- Finds value in which 2 occurs after 4 characters(BOAT2);

-- BETWEEN OPERATOR
/*The BETWEEN operator selects values within a given ridange. 
in BETWEEN operator begining and ending values are included*/

-- SELECT sailors aged between 26 and 29
SELECT * FROM SAILORS WHERE age BETWEEN 26 AND 29; -- Selects sailors that have age in between 26 and 29
SELECT * FROM SAILORS WHERE age NOT BETWEEN 26 AND 29; -- Selects sailors that have age in not between 26 and 29

SELECT * FROM Boat
WHERE color BETWEEN 'Blue' AND 'White' -- selects boat between whose name comes between 'B' and 'W'
ORDER BY bid;


-- WHERE CLAUSE
SELECT * FROM RSERVERS WHERE sid=601; -- selects row in which sid=601

-- ORDER BY
/* Used to sort the rows in ascending or decending order
by default it sorts in ascneding order is ASEC or DESC is not specified*/

-- Retrieve sailors with a rating greater than 2.0, order by rating in descending order
SELECT * FROM SAILORS WHERE rating > 2.0 ORDER BY rating DESC;
SELECT * FROM SAILORS WHERE rating > 2.0 ORDER BY rating;-- by default in descending order

-- SET operations

-- UNION operation
SELECT sid,sname FROM SAILORS
UNION
SELECT bid,bname FROM BOAT;  -- combines the both column entries into single column sname


DELETE FROM RSERVERS
WHERE sid = 603;

-- INTERSECT operation ( there is no INTERSECT command in Mysql instead we use this sub query)
SELECT sid,sname FROM SAILORS
WHERE sid IN (SELECT sid FROM RSERVERS);

-- MINUS opearation
-- Retrieve a list of sailors who did not make any reservations using NOT IN command
SELECT sname FROM SAILORS
WHERE sid NOT IN (SELECT sid FROM RSERVERS);


-- EXISTS  NOT EXISTS
-- this operator returns true or false value 

-- EXISTS
SELECT * FROM SAILORS WHERE EXISTS 
(SELECT * FROM RSERVERS WHERE SAILORS.sid=RSERVERS.sid); 
-- selects all the rows for which the exists condition is true

-- NOT EXISTS
SELECT * FROM SAILORS WHERE NOT EXISTS 
(SELECT * FROM RSERVERS WHERE SAILORS.sid=RSERVERS.sid); 
-- selects all the rows for which the exists condition is false

-- JOIN
-- it is used to combine row from two or more tables ,based on a related column between them
-- INNER JOIN,LEFT JOIN,RIGHT JOIN

-- INNER JOIN
SELECT * FROM SAILORS
JOIN RSERVERS
ON SAILORS.sid=RSERVERS.sid;

-- LEFT JOIN
SELECT * FROM SAILORS
LEFT JOIN RSERVERS
ON SAILORS.sid=RSERVERS.sid;

-- RIGHT JOIN
SELECT * FROM SAILORS
RIGHT JOIN RSERVERS
ON SAILORS.sid=RSERVERS.sid;

-- Aggregate functions
-- count,sum,min,max,avg

-- count() returns the total numbers of rows in the table
-- sum() returns the total sum of the numeric column
-- avg() calculates the avergae values of the set of values
-- min() returns lowest value in a set of non-null values
-- max() returns largest value in a set of non-null values

SELECT count(sid) FROM SAILORS WHERE rating>4.0; -- returns total sailors whose rating is more than 4
SELECT sum(age) FROM SAILORS;
SELECT avg(age) FROM SAILORS;
SELECT min(sid) FROM RSERVERS;
SELECT max(bid) FROM BOAT;

-- GROUP BY 
