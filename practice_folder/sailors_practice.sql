/*
1. Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are underlined and the data types are specified.
Create tables for the following schema listed below by properly specifying the primary keys and foreign keys.
Enter at least five tuples for each relation.
Sailors database
SAILORS (sid, sname, rating, age)
BOAT(bid, bname, color)
RSERVERS (sid, bid, date)
Queries, View and Trigger
1.	Find the colours of boats reserved by Albert 
2.	Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103
3.	 Find the names of sailors who have not reserved a boat whose name contains the string “storm”. Order the names in ascending order. 
4.	Find the names of sailors who have reserved all boats. 
5.	Find the name and age of the oldest sailor. 
6.	For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and the average age of such sailors.
7.	Create a view that shows the names and colours of all the boats that have been reserved by a sailor with a specific rating.
8.	A trigger that prevents boats from being deleted If they have active reservations. 
*/

/*1.	Find the colours of boats reserved by Albert */
SELECT DISTINCT BOAT.color 
  FROM SAILORS JOIN RSERVERS ON SAILORS.sid=RSERVERS.sid 
  JOIN BOAT ON RSERVERS.bid=BOAT.bid 
  WHERE SAILORS.sname='Albert';
+-------+
| color |
+-------+
| Green |
+-------+
  
/* 2.	Find all sailor id’s of sailors who have a rating of at least 4 or reserved boat 701*/
SELECT DISTINCT SAILORS.sid 
  FROM SAILORS LEFT JOIN RSERVERS ON SAILORS.sid= RSERVERS.sid 
  WHERE SAILORS.rating>4 OR RSERVERS.bid=701;
+-----+
| sid |
+-----+
| 601 |
| 602 |
| 604 |
+-----+
  
/* 3.Find the names of sailors who have not reserved a boat whose name contains the string “storm”. Order the names in ascending order. */
SELECT S.sname FROM SAILORS S WHERE S.sid NOT IN 
  (SELECT R.sid FROM RSERVERS R JOIN BOAT B ON R.bid = B.bid 
  WHERE B.bname LIKE '%at2%' ) 
  ORDER BY S.sname ASC;
+--------+
| sname  |
+--------+
| Albert |
| KEVIN  |
| PETER  |
| ROCK   |
+--------+

-- 4.	Find the names of sailors who have reserved all boats.   
SELECT S.sname
FROM SAILORS S
WHERE NOT EXISTS (
    SELECT B.bid
    FROM BOAT B
    WHERE NOT EXISTS (
        SELECT R.bid
        FROM RSERVERS R
        WHERE R.sid = S.sid AND R.bid = B.bid
    )
);
Empty set (0.00 sec)

-- 5.	Find the name and age of the oldest sailor. 
SELECT sname, age FROM SAILORS ORDER BY age DESC LIMIT 1;
+-------+------+
| sname | age  |
+-------+------+
| JAMES |   31 |
+-------+------+

-- 6.	For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and the average age of such sailors.
 SELECT R.bid AS boat_id, AVG(S.age) 
  AS average_age FROM RSERVERS R 
  JOIN SAILORS S ON R.sid = S.sid 
  WHERE S.age >= 40 
  GROUP BY R.bid HAVING COUNT(DISTINCT R.sid) >= 5;
Empty set (0.00 sec)

-- 7.	Create a view that shows the names and colours of all the boats that have been reserved by a sailor with a specific rating.
-- Create a view named 'ReservedBoatsByRating'
mysql> CREATE VIEW ReservedBoatsByRating AS
     SELECT DISTINCT B.bname AS boat_name, B.color
     FROM RSERVERS R
     JOIN SAILORS S ON R.sid = S.sid
    JOIN BOAT B ON R.bid = B.bid
   WHERE S.rating = 4.5;

-- 8.	A trigger that prevents boats from being deleted If they have active reservations. 
DELIMITER //
mysql> CREATE TRIGGER prevent_delete_active_reservations
    -> BEFORE DELETE ON BOAT
    -> FOR EACH ROW
    -> BEGIN
    ->     -- Check if the boat has active reservations
    ->     IF (SELECT COUNT(*) FROM RSERVERS WHERE bid = OLD.bid) > 0 THEN
    ->         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete boat with active reservations';
    ->     END IF;
    -> END;
    -> //
      
Query OK, 0 rows affected (0.08 sec)

mysql> DELIMITER ;
mysql> DELETE FROM BOAT WHERE bid=705;
ERROR 1644 (45000): Cannot delete boat with active reservations
