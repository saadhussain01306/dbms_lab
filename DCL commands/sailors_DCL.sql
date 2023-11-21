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

                                       @HUSSAIN
-- more operations to be done
