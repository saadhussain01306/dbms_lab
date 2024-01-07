CREATE DATABASE insurance;
USE insurance;

CREATE TABLE IF NOT EXISTS person (
driver_id VARCHAR(255) NOT NULL,
driver_name TEXT NOT NULL,
address TEXT NOT NULL,
PRIMARY KEY (driver_id)
);

CREATE TABLE IF NOT EXISTS car (
reg_no VARCHAR(255) NOT NULL,
model TEXT NOT NULL,
c_year INTEGER,
PRIMARY KEY (reg_no)
);

CREATE TABLE IF NOT EXISTS accident (
report_no INTEGER NOT NULL,
accident_date DATE,
location TEXT,
PRIMARY KEY (report_no)
);

CREATE TABLE IF NOT EXISTS owns (
driver_id VARCHAR(255) NOT NULL,
reg_no VARCHAR(255) NOT NULL,
FOREIGN KEY (driver_id) REFERENCES person(driver_id) ON DELETE CASCADE,
FOREIGN KEY (reg_no) REFERENCES car(reg_no) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS participated (
driver_id VARCHAR(255) NOT NULL,
reg_no VARCHAR(255) NOT NULL,
report_no INTEGER NOT NULL,
damage_amount FLOAT NOT NULL,
FOREIGN KEY (driver_id) REFERENCES person(driver_id) ON DELETE CASCADE,
FOREIGN KEY (reg_no) REFERENCES car(reg_no) ON DELETE CASCADE,
FOREIGN KEY (report_no) REFERENCES accident(report_no)
);

INSERT INTO PERSON VALUES
("D111", "Driver_1", "Kuvempunagar, Mysuru"),
("D222", "Smith", "JP Nagar, Mysuru"),
("D333", "Driver_3", "Udaygiri, Mysuru"),
("D444", "Driver_4", "Rajivnagar, Mysuru"),
("D555", "Driver_5", "Vijayanagar, Mysore");

INSERT INTO CAR VALUES
("KA-20-AB-4223", "Swift", 2020),
("KA-20-BC-5674", "Mazda", 2017),
("KA-21-AC-5473", "Alto", 2015),
("KA-21-BD-4728", "Triber", 2019),
("KA-09-MA-1234", "Tiago", 2018);

INSERT INTO ACCIDENT VALUES
(43627, "2020-04-05", "Nazarbad, Mysuru"),
(56345, "2019-12-16", "Gokulam, Mysuru"),
(63744, "2020-05-14", "Vijaynagar, Mysuru"),
(54634, "2019-08-30", "Kuvempunagar, Mysuru"),
(65738, "2021-01-21", "JSS Layout, Mysuru"),
(66666, "2021-01-21", "JSS Layout, Mysuru"),
(45562, "2024-04-05", "Mandya"),
(49999, "2024-04-05", "kolkatta");



INSERT INTO OWNS VALUES
("D111", "KA-20-AB-4223"),
("D222", "KA-20-BC-5674"),
("D333", "KA-21-AC-5473"),
("D444", "KA-21-BD-4728"),
("D222", "KA-09-MA-1234");


INSERT INTO PARTICIPATED VALUES
("D111", "KA-20-AB-4223", 43627, 20000),
("D222", "KA-20-BC-5674", 56345, 49500),
("D333", "KA-21-AC-5473", 63744, 15000),
("D444", "KA-21-BD-4728", 54634, 5000),
("D222", "KA-09-MA-1234", 65738, 25000),
("D222", "KA-21-BD-4728", 45562, 50000),
("D222", "KA-21-BD-4728", 49999, 50000);



-- 1. Find the total number of people who owned cars that were involved in accidents in 2021.
SELECT COUNT(*) FROM accident JOIN participated USING(report_no)
 WHERE accident_date>='2021-01-01' AND accident_date<='2021-12-31';
 
 -- 2. Find the number of accidents in which the cars belonging to “Smith” were involved. 
SELECT COUNT(*) FROM accident JOIN participated USING(report_no) 
JOIN person USING(driver_id) WHERE person.driver_name='Smith';

-- 3. Add a new accident to the database; assume any values for required attributes. 
insert into accident values
(46969, "2024-04-05", "Mandya");

insert into participated values
("D555", "KA-21-BD-4728", 46969, 50000);

-- 4. Delete the Mazda belonging to “Smith”.   
DELETE FROM CAR WHERE
model='Mazda' AND reg_no IN 
(SELECT reg_no FROM OWNS JOIN PERSON USING(driver_id) 
WHERE driver_name='Smith');

-- check
SELECT * FROM CAR;


-- 5. Update the damage amount for the car with license number “KA09MA1234” in the accident 
-- with report.  
UPDATE participated 
SET damage_amount=2000 
WHERE reg_no="KA-09-MA-1234"
AND report_no=65738;

-- check table
SELECT * FROM PARTICIPATED;

-- 6. A view that shows models and year of cars that are involved in accident. 

CREATE OR REPLACE VIEW AccidentCars AS
SELECT DISTINCT model, c_year
FROM car JOIN participated USING(reg_no);

-- check view
SELECT * FROM AccidentCars;

-- 7. A trigger that prevents a driver from participating in more than 3 accidents in a given year. 
DELIMITER //
CREATE TRIGGER PreventParticipation
BEFORE INSERT ON participated
FOR EACH ROW
BEGIN
	IF 3<=(SELECT COUNT(*) FROM PARTICIPATED WHERE driver_id=new.driver_id) THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT='Driver already in 3 accidents';
	END IF;
END;//
DELIMITER ;


-- check trigger

-- first insert a new accident number
INSERT INTO ACCIDENT VALUES
(99999, "2024-04-05", "kolkatta");


-- check the trigger
INSERT INTO participated VALUES
("D222", "KA-20-AB-4223", 99999, 20000);
-- Driver already in 3 accidents



-- alternative

DELIMITER //

CREATE TRIGGER tr2
BEFORE INSERT ON participated
FOR EACH ROW
BEGIN
	IF (
        SELECT COUNT(*) AS accident_count
        FROM participated
        JOIN accident USING(report_no)
        WHERE driver_id = NEW.driver_id
        AND YEAR(accident_date) = (SELECT YEAR(accident_date) FROM accident WHERE report_no = NEW.report_no)
    ) >= 3 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Driver already in 3 accidents';
	END IF;
END;

//

DELIMITER ;
