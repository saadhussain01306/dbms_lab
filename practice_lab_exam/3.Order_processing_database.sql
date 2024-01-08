CREATE DATABASE Order_processing;
USE Order_processing;


 -- customer -> 
 --          Order_ -> 
 --               Item -> 
 --                   OrderItem -> 
 --                       Warehouse -> 
 --                                 Shipment

              
-- create customer table
CREATE TABLE Customer (
    cust INT PRIMARY KEY,
    cname VARCHAR(100),
    city VARCHAR(100)
);

-- create order table 
CREATE TABLE Order_ (
    order_ INT PRIMARY KEY,
    odate DATE,
    cust INT,
    order_amt INT,
    FOREIGN KEY (cust) REFERENCES Customer(cust) ON DELETE CASCADE
);

-- Create Item table 
CREATE TABLE Item (
    item INT PRIMARY KEY,
    unitprice INT
);

-- Create Order_item table
CREATE TABLE OrderItem (
    order_ INT,
    item INT,
    qty INT,
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
    FOREIGN KEY (order_) REFERENCES Order_(order_) ON DELETE CASCADE,
    FOREIGN KEY (warehouse) REFERENCES Warehouse(warehouse) ON DELETE CASCADE
);

-- Insert data into the tables

-- Insert data into the Customer table
INSERT INTO Customer (cust, cname, city) 
VALUES
    (101, 'Kumar', 'City1'),
    (102, 'Peter', 'City2'),
    (103, 'James', 'City3'),
    (104, 'Kevin', 'City4'),
    (105, 'Harry', 'City5');
    
-- Insert data into the Order table
INSERT INTO Order_(order_, odate, cust, order_amt) 
VALUES
    (201, '2023-04-11', 101, 1567),
    (202, '2023-04-12', 102, 2567),
    (203, '2023-04-13', 103, 3567),
    (204, '2023-04-14', 104, 4567),
    (205, '2023-04-15', 105, 5567);

-- Insert Data into Item table
INSERT INTO Item (item, unitprice) VALUES
    (1001, 100),
    (1002, 200),
    (1003, 300),
    (1004, 400),
    (1005, 500);
 
-- Insert data in OrderItem Table
INSERT INTO OrderItem (order_, item, qty) VALUES
    (201,1001, 10),
    (202,1002, 11),
    (203,1003, 12),
    (204,1004, 13),
    (205,1005, 14);    
   

-- Insert Data in Warehouse
INSERT INTO Warehouse (warehouse, city) VALUES
    (1, 'Wcity1'),
    (2, 'Wcity2'),
    (3, 'Wcity3'),
    (4, 'Wcity4'),
    (5, 'Wcity5');
    
-- Insert data into Shipment Table
INSERT INTO Shipment (order_, warehouse, ship_date) VALUES
    (201, 1, '2023-05-01'),
    (202, 2, '2023-05-02'),
    (203, 3, '2023-05-03'),
    (204, 4, '2023-05-04'),
    (205, 5, '2023-05-05');
    
-- queries
 -- 1. List the Order# and Ship_date for all orders shipped from Warehouse "2".   
SELECT s.order_, s.ship_date
FROM Shipment s
WHERE s.warehouse = 2;

-- 2. List the Warehouse information from which the Customer named "Kumar" was supplied his 
-- orders. Produce a listing of Order#, Warehouse#.

SELECT o.order_, s.warehouse,w.city
FROM Order_ o
JOIN Shipment s ON o.order_ = s.order_
JOIN Customer c ON o.cust = c.cust
JOIN Warehouse w ON s.warehouse = w.warehouse
WHERE c.cname = 'Kumar';

-- 3. Produce a listing: Cname, #ofOrders, Avg_Order_Amt, where the middle column is the total 
-- number of orders by the customer and the last column is the average order amount for that 
-- customer. (Use aggregate functions)

select cname, COUNT(*) as no_of_orders, AVG(order_amt) as avg_order_amt
from Customer c, Order_ o
where c.cust=o.cust 
group by cname;


-- 4. Delete all orders for customer named "Kumar".
DELETE FROM Order_
WHERE cust = (SELECT cust FROM Customer WHERE cname = 'Kumar');

-- check if deleted
SELECT * FROM Order_;

-- 5. Find the item with the maximum unit price. 
SELECT item,unitprice
FROM Item
WHERE unitprice = (SELECT MAX(unitprice) FROM Item);

-- 6. A trigger that updates order_amout based on quantity and unitprice of order_item

DELIMITER //
CREATE TRIGGER update_order_amount
BEFORE INSERT ON OrderItem
FOR EACH ROW
BEGIN
    UPDATE Order_
    SET order_amt = NEW.qty *(SELECT unitprice FROM Item WHERE item = NEW.item)
    WHERE order_ = NEW.order_;
END ;
//
DELIMITER ;

-- check
-- Insert a new item
INSERT INTO Item (item, unitprice) VALUES (1006, 600);

-- Insert a new order with the new item
INSERT INTO Order_ (order_, odate, cust, order_amt) VALUES (206, '2023-04-16', 102, NULL);

-- Insert the new item into the order
INSERT INTO OrderItem (order_, item, qty) VALUES (206, 1006, 5);

-- Check the updated order_amount using the trigger
SELECT * FROM Order_;

-- 7. Create a view to display orderID and shipment date of all orders shipped from a warehouse 5

CREATE OR REPLACE VIEW OrdersFromWarehouse5 AS
SELECT s.order_, s.ship_date
FROM Shipment s
WHERE s.warehouse = 5;

-- check view
SELECT * FROM OrdersFromWarehouse5;
