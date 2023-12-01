/*1. Consider the database schemas given below.
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
/* Find the names of sailors who have not reserved a boat whose name contains the string “storm”. Order the names in ascending order. */
