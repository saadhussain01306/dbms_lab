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

/* Order_processing_DCL_DML DATABASE*/

USE Order_processing;

-- LIKE OPERATOR
SELECT * FROM Customer WHERE city LIKE '____2';
+------+-------+-------+
| cust | cname | city  |
+------+-------+-------+
|  102 | PETER | City2 |
+------+-------+-------+

SELECT * FROM order_ WHERE odate LIKE '%11%';
+--------+------------+------+-----------+--------------+--------------+
| order_ | odate      | cust | order_amt | est_delivery | delivery_add |
+--------+------------+------+-----------+--------------+--------------+
|    201 | 2023-04-11 |  101 |      1567 | 2023-05-23   | NULL         |
+--------+------------+------+-----------+--------------+--------------+

DELETE FROM Shipment 
WHERE order_=203;

-- BETWEEN OPEARTOR;
SELECT * FROM Warehouse WHERE city BETWEEN 'City1' AND 'City5';
+-----------+-------+
| warehouse | city  |
+-----------+-------+
|       901 | City1 |
|       902 | City2 |
|       903 | City3 |
|       904 | City4 |
|       905 | City5 |
+-----------+-------+

SELECT * FROM order_ WHERE odate BETWEEN '2023-04-12' AND '2023-04-14' 
AND cust IN (SELECT cust FROM Customer WHERE city = 'City2');
+--------+------------+------+-----------+--------------+--------------+
| order_ | odate      | cust | order_amt | est_delivery | delivery_add |
+--------+------------+------+-----------+--------------+--------------+
|    202 | 2023-04-12 |  102 |      2567 | 2023-05-24   | NULL         |
+--------+------------+------+-----------+--------------+--------------+

-- WHERE clause
SELECT * FROM Item WHERE unitprice=500;
+------+-----------+---------------+
| item | unitprice | delivery_cost |
+------+-----------+---------------+
| 1005 |       500 |            80 |
+------+-----------+---------------+

-- Order By
SELECT * FROM Warehouse WHERE warehouse>903 ORDER BY warehouse DESC;
+-----------+-------+
| warehouse | city  |
+-----------+-------+
|       905 | City5 |
|       904 | City4 | REVOKE select ON hussain.Shipment FROM 'JOHN'@'localhost';
ERROR 1147 (42000): There is no such grant defined for user 'JOHN' on host 'localhost' on table 'Shipment'

+-----------+-------+
  
SELECT * FROM Warehouse WHERE warehouse>903 ORDER BY warehouse;
+-----------+-------+
| warehouse | city  |
+-----------+-------+
|       904 | City4 |
|       905 | City5 |
+-----------+-------+

-- SET operation
-- UNION operation
SELECT cust,cname  FROM Customer
UNION
SELECT warehouse,city FROM Warehouse;
+------+-------+
| cust | cname |
+------+-------+
|  101 | JOHN  |
|  102 | PETER |
|  103 | JAMES |
|  104 | KEVIN |
|  105 | HARRY |
|  901 | City1 |
|  902 | City2 |
|  903 | City3 |
|  904 | City4 |
|  905 | City5 |
+------+-------+

-- Intersect Opeartion
SELECT * FROM Warehouse WHERE 
warehouse IN (SELECT warehouse FROM Shipment);
+-----------+-------+
| warehouse | city  |
+-----------+-------+
|       901 | City1 |
|       902 | City2 |
|       904 | City4 |
|       905 | City5 |
+-----------+-------+

-- MINUS operator
SELECT * FROM Warehouse WHERE 
warehouse NOT IN (SELECT warehouse FROM Shipment);
+-----------+-------+
| warehouse | city  |
+-----------+-------+
|       903 | City3 |
+-----------+-------+

-- EXISTS command
SELECT * FROM order_ WHERE EXISTS (SELECT * FROM Shipment WHERE order_.order_ = Shipment.order_);
+--------+------------+------+-----------+--------------+--------------+
| order_ | odate      | cust | order_amt | est_delivery | delivery_add |
+--------+------------+------+-----------+--------------+--------------+
|    201 | 2023-04-11 |  101 |      1567 | 2023-05-23   | NULL         |
|    202 | 2023-04-12 |  102 |      2567 | 2023-05-24   | NULL         |
|    204 | 2023-04-14 |  104 |      4567 | 2023-05-26   | NULL         |
|    205 | 2023-04-15 |  105 |      5567 | 2023-05-27   | NULL         |
+--------+------------+------+-----------+--------------+--------------+

-- NOT EXISTS
  
SELECT * FROM order_ WHERE NOT EXISTS (SELECT * FROM Shipment WHERE order_.order_ = Shipment.order_);
+--------+------------+------+-----------+--------------+--------------+
| order_ | odate      | cust | order_amt | est_delivery | delivery_add |
+--------+------------+------+-----------+--------------+--------------+
|    203 | 2023-04-13 |  103 |      3567 | 2023-05-25   | NULL         |
+--------+------------+------+-----------+--------------+--------------+

-- JOIN 
-- INNER JOIN
SELECT * FROM order_ JOIN Shipment ON order_.order_=Shipment.order_;
+--------+------------+------+-----------+--------------+--------------+--------+-----------+------------+---------------------+--------------+
| order_ | odate      | cust | order_amt | est_delivery | delivery_add | order_ | warehouse | ship_date  | cancellation_status | delivery_exe |
+--------+------------+------+-----------+--------------+--------------+--------+-----------+------------+---------------------+--------------+
|    201 | 2023-04-11 |  101 |      1567 | 2023-05-23   | NULL         |    201 |       901 | 2023-05-01 | no                  | executive1   |
|    202 | 2023-04-12 |  102 |      2567 | 2023-05-24   | NULL         |    202 |       902 | 2023-05-02 | no                  | executive1   |
|    204 | 2023-04-14 |  104 |      4567 | 2023-05-26   | NULL         |    204 |       904 | 2023-05-04 | no                  | executive1   |
|    205 | 2023-04-15 |  105 |      5567 | 2023-05-27   | NULL         |    205 |       905 | 2023-05-05 | no                  | executive1   |
+--------+------------+------+-----------+--------------+--------------+--------+-----------+------------+---------------------+--------------+

-- LEFT JOIN
SELECT * FROM Warehouse LEFT JOIN Shipment ON Warehouse.warehouse=Shipment.warehouse;
+-----------+-------+--------+-----------+------------+---------------------+--------------+
| warehouse | city  | order_ | warehouse | ship_date  | cancellation_status | delivery_exe |
+-----------+-------+--------+-----------+------------+---------------------+--------------+
|       901 | City1 |    201 |       901 | 2023-05-01 | no                  | executive1   |
|       902 | City2 |    202 |       902 | 2023-05-02 | no                  | executive1   |
|       903 | City3 |   NULL |      NULL | NULL       | NULL                | NULL         |
|       904 | City4 |    204 |       904 | 2023-05-04 | no                  | executive1   |
|       905 | City5 |    205 |       905 | 2023-05-05 | no                  | executive1   |
+-----------+-------+--------+-----------+------------+---------------------+--------------+

-- RIGHT JOIN
SELECT * FROM Warehouse RIGHT JOIN Shipment ON Warehouse.warehouse=Shipment.warehouse;
+-----------+-------+--------+-----------+------------+---------------------+--------------+
| warehouse | city  | order_ | warehouse | ship_date  | cancellation_status | delivery_exe |
+-----------+-------+--------+-----------+------------+---------------------+--------------+
|       901 | City1 |    201 |       901 | 2023-05-01 | no                  | executive1   |
|       902 | City2 |    202 |       902 | 2023-05-02 | no                  | executive1   |
|       904 | City4 |    204 |       904 | 2023-05-04 | no                  | executive1   |
|       905 | City5 |    205 |       905 | 2023-05-05 | no                  | executive1   |
+-----------+-------+--------+-----------+------------+---------------------+--------------+
  
-- FULL OUTER JOIN
 -- Using LEFT JOIN
SELECT Warehouse.*, Shipment.*
FROM Warehouse
LEFT JOIN Shipment ON Warehouse.warehouse = Shipment.warehouse
UNION
-- Using RIGHT JOIN
SELECT Warehouse.*, Shipment.*
FROM Warehouse
RIGHT JOIN Shipment ON Warehouse.warehouse = Shipment.warehouse
WHERE Warehouse.warehouse IS NULL;
+-----------+-------+--------+-----------+------------+---------------------+--------------+
| warehouse | city  | order_ | warehouse | ship_date  | cancellation_status | delivery_exe |
+-----------+-------+--------+-----------+------------+---------------------+--------------+
|       902 | City2 |    202 |       902 | 2023-05-02 | no                  | executive1   |
|       903 | City3 |   NULL |      NULL | NULL       | NULL                | NULL         |
|       904 | City4 |    204 |       904 | 2023-05-04 | no                  | executive1   |
|       905 | City5 |    205 |       905 | 2023-05-05 | no                  | executive1   |
+-----------+-------+--------+-----------+------------+---------------------+--------------+

-- Aggregate funnction;
SELECT Customer.cust, Customer.cname, SUM(order_.order_amt) AS total_order_amount FROM Customer JOIN order_ ON Customer.cust = order_.cust GROUP BY Customer.cust, Customer.cname;
+------+-------+--------------------+
| cust | cname | total_order_amount |
+------+-------+--------------------+
|  101 | JOHN  |               1567 |
|  102 | PETER |               2567 |
|  103 | JAMES |               3567 |
|  104 | KEVIN |               4567 |
|  105 | HARRY |               5567 |
+------+-------+--------------------+

-- Average amount
SELECT AVG(OrderItem.qty) AS avg_quantity_ordered
FROM OrderItem;
+----------------------+
| avg_quantity_ordered |
+----------------------+
|              12.0000 |
+----------------------+

-- GROUP BY HAVING
SELECT Shipment.warehouse, COUNT(Shipment.order_) 
AS order_count FROM Shipment GROUP BY Shipment.warehouse HAVING order_count > 0;
+-----------+-------------+
| warehouse | order_count |
+-----------+-------------+
|       902 |           1 |
|       904 |           1 |
+-----------+-------------+

-- nested queries
SELECT * FROM Warehouse WHERE warehouse IN (SELECT warehouse FROM Shipment);
+-----------+-------+
| warehouse | city  |
+-----------+-------+
|       902 | City2 |
|       904 | City4 |
+-----------+-------+

-- corelated queries
SELECT * FROM order_ WHERE EXISTS (SELECT * FROM Shipment WHERE order_.order_=Shipment.order_);
+--------+------------+------+-----------+--------------+--------------+
| order_ | odate      | cust | order_amt | est_delivery | delivery_add |
+--------+------------+------+-----------+--------------+--------------+
|    201 | 2023-04-11 |  101 |      1567 | 2023-05-23   | NULL         |
|    202 | 2023-04-12 |  102 |      2567 | 2023-05-24   | NULL         |
|    204 | 2023-04-14 |  104 |      4567 | 2023-05-26   | NULL         |
|    205 | 2023-04-15 |  105 |      5567 | 2023-05-27   | NULL         |
+--------+------------+------+-----------+--------------+--------------+

-- grant command
GRANT select ON hussain.Shipment TO 'JOHN'@'localhost';
ERROR 1410 (42000): You are not allowed to create a user with GRANT

-- revoke command
 REVOKE select ON hussain.Shipment FROM 'JOHN'@'localhost';
ERROR 1147 (42000): There is no such grant defined for user 'JOHN' on host 'localhost' on table 'Shipment'
