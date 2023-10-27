/* Data Definition Language (DDL) commands in RDBMS
Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are 
underlined and the data types are specified.
Create tables for the following schema listed below by properly 
specifying the primary keys and foreign keys.
Enter at least five tuples for each relation.
Altering tables,
Adding and Dropping different types of constraints.
Also adding and dropping fields in to the relational schemas of the listed problems.
Delete, Update operations

C. Order processing database
Customer (Cust#:int, cname: string, city: string)
Order (order#:int, odate: date, cust#: int, order-amt: int)
Order-item (order#:int, Item#: int, qty: int)
Item (item#:int, unitprice: int)
Shipment (order#:int, warehouse#: int, ship-date: date)
Warehouse (warehouse#:int, city: string)
*/
/* order is a key word and only "_" is allowed while naming the attributes*/


CREATE DATABASE Order_processing;
USE Order_processing;

-- create customer table
CREATE TABLE Customer (
    cust INT PRIMARY KEY,
    cname VARCHAR(100),
    city VARCHAR(100)
);

-- create order table 
-- order is a key word
CREATE TABLE Order_ (
    order_ INT PRIMARY KEY,
    odate DATE,
    cust INT,
    order_amt INT,
    FOREIGN KEY (cust) REFERENCES Customer(cust) ON DELETE CASCADE
);

-- Create Item table :  because order_item Table requires Item as reference
CREATE TABLE Item (
    item INT PRIMARY KEY,
    unitprice INT
);

-- Create Order_item table
CREATE TABLE OrderItem (
    order_ INT,
    item INT,
    qty INT,
    PRIMARY KEY (order_, item),
    FOREIGN KEY (order_) REFERENCES Order_(order_) ON DELETE CASCADE,
    FOREIGN KEY (item) REFERENCES Item(item) ON DELETE CASCADE
);

-- Create Warehouse table bcoz shipment requires warehouse as reference
CREATE TABLE Warehouse (
    warehouse INT PRIMARY KEY,
    city VARCHAR(100)
);

-- create shipment table
CREATE TABLE Shipment (
    order_ INT,
    warehouse INT,
    ship_date DATE,
    PRIMARY KEY (order_, warehouse),
    FOREIGN KEY (order_) REFERENCES Order_(order_) ON DELETE CASCADE,
    FOREIGN KEY (warehouse) REFERENCES Warehouse(warehouse) ON DELETE CASCADE
);

-- Insert data into the tables

-- Insert data into the Customer table
INSERT INTO Customer (cust, cname, city) 
VALUES
    (101, 'JOHN', 'City1'),
    (102, 'PETER', 'City2'),
    (103, 'JAMES', 'City3'),
    (104, 'KEVIN', 'City4'),
    (105, 'HARRY', 'City5');
    
-- check if the data is inserted
SELECT * FROM Customer;    

-- Insert data into the Order table
INSERT INTO Order_(order_, odate, cust, order_amt) 
VALUES
    (201, '2023-04-11', 101, 1567),
    (202, '2023-04-12', 102, 2567),
    (203, '2023-04-13', 103, 3567),
    (204, '2023-04-14', 104, 4567),
    (205, '2023-04-15', 105, 5567);
-- check if the data is inserted
SELECT * FROM Order_; 

-- Insert Data into Item table
INSERT INTO Item (item, unitprice) VALUES
    (1001, 100),
    (1002, 200),
    (1003, 300),
    (1004, 400),
    (1005, 500);
   
-- check if the data is inserted
SELECT * FROM Item;    
    
-- Insert data in OrderItem Table
INSERT INTO OrderItem (order_, item, qty) VALUES
    (201,1001, 10),
    (202,1002, 11),
    (203,1003, 12),
    (204,1004, 13),
    (205,1005, 14);    
  
-- check if the data is inserted
SELECT * FROM OrderItem;  

-- Insert Data in Warehouse
INSERT INTO Warehouse (warehouse, city) VALUES
    (901, 'City1'),
    (902, 'City2'),
    (903, 'City3'),
    (904, 'City4'),
    (905, 'City5');
    
 -- check if the data is inserted
SELECT * FROM Warehouse;     


-- Insert data into Shipment Table
INSERT INTO Shipment (order_, warehouse, ship_date) VALUES
    (201, 901, '2023-05-01'),
    (202, 902, '2023-05-02'),
    (203, 903, '2023-05-03'),
    (204, 904, '2023-05-04'),
    (205, 905, '2023-05-05');
    
-- check if the data is inserted
SELECT * FROM Shipment; 

-- alter the tables

-- alter the Order_  table
-- add the estimated delivery date

ALTER TABLE order_
ADD est_delivery DATE;

UPDATE order_
SET est_delivery = '2023-05-23'
WHERE order_=201;

UPDATE order_
SET est_delivery = '2023-05-24'
WHERE order_=202;

UPDATE order_
SET est_delivery = '2023-05-25'
WHERE order_=203;

UPDATE order_
SET est_delivery = '2023-05-26'
WHERE order_=204;

UPDATE order_
SET est_delivery = '2023-05-27'
WHERE order_=205;

-- check if the table is altered or not
SELECT * FROM order_;


-- alter the Item table
-- add the cost of delivery of the item

ALTER TABLE Item
ADD delivery_cost INT;

UPDATE Item
SET delivery_cost= 80
WHERE item IN (1001,1002,1003,1004,1005);

-- check if the table is altered or not
SELECT * FROM Item;

-- adding and dropping constraints

-- ensures that no two customers have the same order number
ALTER TABLE Order_
ADD CONSTRAINT unique_order_ID UNIQUE (order_);

-- ensures that no two items have the same item ID
ALTER TABLE Item
ADD CONSTRAINT unique_item_ID UNIQUE (item);

-- drop contraints
ALTER TABLE Order_
DROP CONSTRAINT unique_order_ID;

-- adding and dropping fields in to the relational schemas

-- adding feilds 

-- add the delivery address

ALTER TABLE Order_
ADD delivery_add VARCHAR(100);

UPDATE Order_
SET delivery_add = 'Address1'
WHERE order_=201;

UPDATE Order_
SET delivery_add = 'Address2'
WHERE order_=202;

UPDATE Order_
SET delivery_add = 'Address3'
WHERE order_=203;

UPDATE Order_
SET delivery_add = 'Address4'
WHERE order_=204;

UPDATE Order_
SET delivery_add = 'Address5'
WHERE order_=205;

-- check the added field
SELECT * FROM Order_;


-- dropping feilds
-- Dropping the 'quantity' field from the OrderItem
ALTER TABLE OrderItem
DROP COLUMN qty;

-- delete and update operations

-- update the Shipment table
-- delivery executive to the orders

ALTER TABLE Shipment
ADD delivery_exe VARCHAR(100);

UPDATE Shipment
SET delivery_exe= "executive1"
WHERE order_ IN (201,202,203,204,205);

-- check 
SELECT * FROM Shipment;

-- delete operatios
ALTER TABLE Shipment
DROP COLUMN delivery_exe;

-- order status
-- is the order cancelled or not

ALTER TABLE Shipment
ADD cancellation_status ENUM('yes', 'no') DEFAULT 'no';


-- OUTPUT:-
DESC Customer;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| cust  | int         | NO   | PRI | NULL    |       |
| cname | varchar(50) | YES  |     | NULL    |       |
| city  | varchar(50) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+

DESC order_;
+-----------+------+------+-----+---------+-------+
| Field     | Type | Null | Key | Default | Extra |
+-----------+------+------+-----+---------+-------+
| order_    | int  | NO   | PRI | NULL    |       |
| odate     | date | YES  |     | NULL    |       |
| cust      | int  | YES  | MUL | NULL    |       |
| order_amt | int  | YES  |     | NULL    |       |
+-----------+------+------+-----+---------+-------+
DESC Item;
+-----------+------+------+-----+---------+-------+
| Field     | Type | Null | Key | Default | Extra |
+-----------+------+------+-----+---------+-------+
| item      | int  | NO   | PRI | NULL    |       |
| unitprice | int  | YES  |     | NULL    |       |
+-----------+------+------+-----+---------+-------+

DESC OrderItem;
+--------+------+------+-----+---------+-------+
| Field  | Type | Null | Key | Default | Extra |
+--------+------+------+-----+---------+-------+
| order_ | int  | NO   | PRI | NULL    |       |
| item   | int  | NO   | PRI | NULL    |       |
| qty    | int  | YES  |     | NULL    |       |
+--------+------+------+-----+---------+-------+
DESC Warehouse;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| warehouse | int          | NO   | PRI | NULL    |       |
| city      | varchar(100) | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+
DESC Shipment;
+-----------+------+------+-----+---------+-------+
| Field     | Type | Null | Key | Default | Extra |
+-----------+------+------+-----+---------+-------+
| order_    | int  | NO   | PRI | NULL    |       |
| warehouse | int  | NO   | PRI | NULL    |       |
| ship_date | date | YES  |     | NULL    |       |
+-----------+------+------+-----+---------+-------+

SELECT * FROM Customer;
+------+-------+-------+
| cust | cname | city  |
+------+-------+-------+
|  101 | JOHN  | City1 |
|  102 | PETER | City2 |
|  103 | JAMES | City3 |
|  104 | KEVIN | City4 |
|  105 | HARRY | City5 |
+------+-------+-------+

SELECT * FROM order_;
+--------+------------+------+-----------+
| order_ | odate      | cust | order_amt |
+--------+------------+------+-----------+
|    201 | 2023-04-11 |  101 |      1567 |
|    202 | 2023-04-12 |  102 |      2567 |
|    203 | 2023-04-13 |  103 |      3567 |
|    204 | 2023-04-14 |  104 |      4567 |
|    205 | 2023-04-15 |  105 |      5567 |
+--------+------------+------+-----------+
SELECT * FROM Item; 
+------+-----------+
| item | unitprice |
+------+-----------+
| 1001 |       100 |
| 1002 |       200 |
| 1003 |       300 |
| 1004 |       400 |
| 1005 |       500 |
+------+-----------+
SELECT * FROM OrderItem;  
+--------+------+------+
| order_ | item | qty  |
+--------+------+------+
|    201 | 1001 |   10 |
|    202 | 1002 |   11 |
|    203 | 1003 |   12 |
|    204 | 1004 |   13 |
|    205 | 1005 |   14 |
+--------+------+------+

SELECT * FROM Warehouse;
+-----------+-------+
| warehouse | city  |
+-----------+-------+
|       901 | City1 |
|       902 | City2 |
|       903 | City3 |
|       904 | City4 |
|       905 | City5 |
+-----------+-------+

SELECT * FROM Shipment;
+--------+-----------+------------+
| order_ | warehouse | ship_date  |
+--------+-----------+------------+
|    201 |       901 | 2023-05-01 |
|    202 |       902 | 2023-05-02 |
|    203 |       903 | 2023-05-03 |
|    204 |       904 | 2023-05-04 |
|    205 |       905 | 2023-05-05 |
+--------+-----------+------------+
-- altering table order_ add estimated delivery date
+--------+------------+------+-----------+--------------+
| order_ | odate      | cust | order_amt | est_delivery |
+--------+------------+------+-----------+--------------+
|    201 | 2023-04-11 |  101 |      1567 | 2023-05-23   |
|    202 | 2023-04-12 |  102 |      2567 | 2023-05-24   |
|    203 | 2023-04-13 |  103 |      3567 | 2023-05-25   |
|    204 | 2023-04-14 |  104 |      4567 | 2023-05-26   |
|    205 | 2023-04-15 |  105 |      5567 | 2023-05-27   |
+--------+------------+------+-----------+--------------+
 -- altering Item table adding delivery cost
+------+-----------+---------------+
| item | unitprice | delivery_cost |
+------+-----------+---------------+
| 1001 |       100 |            80 |
| 1002 |       200 |            80 |
| 1003 |       300 |            80 |
| 1004 |       400 |            80 |
| 1005 |       500 |            80 |
+------+-----------+---------------+

-- upadte commands
-- adding dilvery executive column in shipment table
+--------+-----------+------------+---------------------+--------------+
| order_ | warehouse | ship_date  | cancellation_status | delivery_exe |
+--------+-----------+------------+---------------------+--------------+
|    201 |       901 | 2023-05-01 | no                  | executive1   |
|    202 |       902 | 2023-05-02 | no                  | executive1   |
|    203 |       903 | 2023-05-03 | no                  | executive1   |
|    204 |       904 | 2023-05-04 | no                  | executive1   |
|    205 |       905 | 2023-05-05 | no                  | executive1   |
+--------+-----------+------------+---------------------+--------------+
    
ALTER TABLE Shipment
ADD cancellation_status ENUM('yes', 'no') DEFAULT 'no';

+--------+-----------+------------+---------------------+
| order_ | warehouse | ship_date  | cancellation_status |
+--------+-----------+------------+---------------------+
|    201 |       901 | 2023-05-01 | no                  |
|    202 |       902 | 2023-05-02 | no                  |
|    203 |       903 | 2023-05-03 | no                  |
|    204 |       904 | 2023-05-04 | no                  |
|    205 |       905 | 2023-05-05 | no                  |
+--------+-----------+------------+---------------------+
