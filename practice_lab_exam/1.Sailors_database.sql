CREATE DATABASE sailors2;
USE sailors2;

-- Create SAILORS table
CREATE TABLE SAILORS (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    rating INT,
    age INT
);

-- Create BOAT table
CREATE TABLE BOAT (
    bid INT PRIMARY KEY,
    bname VARCHAR(50),
    color VARCHAR(50)
);

-- Create RESERVES table
CREATE TABLE RESERVES (
    sid INT,
    bid INT,
    date DATE,
    PRIMARY KEY (sid, bid),
    FOREIGN KEY (sid) REFERENCES SAILORS(sid),
    FOREIGN KEY (bid) REFERENCES BOAT(bid)
);

-- insertion

-- Insert sample data for SAILORS table
INSERT INTO SAILORS VALUES
(101, 'Albert', 8, 30),
(102, 'Bob', 7, 35),
(103, 'Charlie', 9, 40),
(104, 'David', 8, 28),
(105, 'Eve', 7, 32);

-- Insert sample data for BOAT table
INSERT INTO BOAT VALUES
(201, 'Boat1', 'Red'),
(202, 'Boat2', 'Blue'),
(203, 'Boat3', 'Green'),
(204, 'Boat4', 'Yellow'),
(205, 'Boat5', 'White');

-- Insert sample data for RESERVES table
INSERT INTO RESERVES VALUES
(101, 201, '2023-01-01'),
(102, 202, '2023-02-01'),
(103, 203, '2023-03-01'),
(101, 204, '2023-04-01'),
(104, 205, '2023-05-01');

-- queries
-- 1. Find the colours of boats reserved by Albert 
SELECT ALL b.color
FROM BOAT b
JOIN RESERVES r ON b.bid = r.bid
JOIN SAILORS s ON r.sid = s.sid
WHERE s.sname = 'Albert';

-- 2. Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103
--  LEFT JOIN is used to ensure that all rows from the SAILORS table are included in the result set, 
-- regardless of whether there is a match in the RESERVES table. 

SELECT DISTINCT s.sid
FROM SAILORS s
LEFT JOIN RESERVES r ON s.sid = r.sid
WHERE s.rating >= 8 OR r.bid = 103;

-- 3. Find the names of sailors who have not reserved a boat whose name contains the string 
-- “storm”. Order the names in ascending order. 
SELECT s.sname
FROM SAILORS s
WHERE s.sid NOT IN (SELECT r.sid FROM RESERVES r 
JOIN BOAT b ON r.bid = b.bid 
WHERE b.bname LIKE '%storm%')
ORDER BY s.sname ASC;

-- 4. Find the names of sailors who have reserved all boats.
SELECT s.sname
FROM SAILORS s
WHERE NOT EXISTS (
    SELECT b.bid
    FROM BOAT b
    WHERE NOT EXISTS (
        SELECT r.bid
        FROM RESERVES r
        WHERE r.sid = s.sid AND r.bid = b.bid
    )
);

-- 5. Find the name and age of the oldest sailor. 
SELECT sname, age
FROM SAILORS
ORDER BY age DESC
LIMIT 1;

-- 6. For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and 
-- the average age of such sailors.
SELECT r.bid AS BOAT_id, AVG(s.age) AS avg_age
FROM RESERVES r
JOIN SAILORS s ON r.sid = s.sid
WHERE s.age >= 40
GROUP BY r.bid
HAVING COUNT(DISTINCT r.sid) >= 5;

-- 7. Create a view that shows the names and colours of all the boats that have been reserved by 
-- a sailor with a specific rating.

CREATE OR REPLACE VIEW ReservedBoatsByRating AS
SELECT DISTINCT s.sname AS sailor_name, b.bname AS boat_name, b.color
FROM SAILORS s
JOIN RESERVES r ON s.sid = r.sid
JOIN BOAT b ON r.bid = b.bid
WHERE s.rating = 8;

-- check 
SELECT * FROM ReservedBoatsByRating;

-- 8. A trigger that prevents boats from being deleted If they have active reservations.

DELIMITER //
CREATE TRIGGER prevent_delete_active_reservations
BEFORE DELETE ON BOAT
FOR EACH ROW
BEGIN
    DECLARE reservation_count INT;

    -- Check if the boat has active reservations
    SELECT COUNT(*) INTO reservation_count
    FROM RESERVES
    WHERE bid = OLD.bid;

    -- If there are active reservations, prevent the deletion
    IF reservation_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete a boat with active reservations';
    END IF;
END;
//
DELIMITER ;

-- check trigger
DELETE FROM BOAT
WHERE bid = 203;
-- 'Cannot delete a boat with active reservations'.
