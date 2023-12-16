Programs for DBMS LAB @JSSSTU 
20CS57L Database Management Systems Laboratory

List of Programs
1 Consider a structure named Student with attributes as SID, NAME, 
BRANCH, SEMESTER, ADDRESS. 
Write a program in C/C++/ and perform the following operations using 
the concept of files.
a. Insert a new student
b. Modify the address of the student based on SID
c. Delete a student
d. List all the students
e. List all the students of CSE branch.
f. List all the students of CSE branch and reside in Kuvempunagar.

2 Create a table for the structure Student with attributes as SID, NAME, 
BRANCH, SEMESTER, ADDRESS, PHONE, EMAIL, Insert atleast 10 
tuples and performthe following operationsusing SQL.
a. Insert a new student
b. Modify the address of the student based on SID
c. Delete a student
d. List all the students
e. List all the students of CSE branch.
f. List all the students of CSE branch and reside in Kuvempunagar.

3, 4,5,6 
Data Definition Language (DDL) commands in RDBMS
Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are 
underlined and the data types are specified.
Create tables for the following schema listed below by properly 
specifying the primary keys and foreign keys.
Enter at least five tuples for each relation.
Altering tables,
Adding and Dropping different types of constraints.
Also adding and dropping fields in to the relational schemas of the listed
problems.
Delete, Update operations

A.Sailors database
SAILORS (sid, sname, rating, age)
BOAT(bid, bname, color)
RSERVERS (sid, bid, date)

B. Insurance database
PERSON (driver id#: string, name: string, address: string)
CAR (regno: string, model: string, year: int)
ACCIDENT (report_ number: int, acc_date: date, location: string)
OWNS (driver id#: string, regno: string)
PARTICIPATED(driver id#:string, regno:string, report_ number: 
int,damage_amount: int)

C. Order processing database
Customer (Cust#:int, cname: string, city: string)
Order (order#:int, odate: date, cust#: int, order-amt: int)
Order-item (order#:int, Item#: int, qty: int)
Item (item#:int, unitprice: int)
Shipment (order#:int, warehouse#: int, ship-date: date)
Warehouse (warehouse#:int, city: string)

D. Student enrollment in courses and books adopted for each course
STUDENT (regno: string, name: string, major: string, bdate: date)
COURSE (course#:int, cname: string, dept: string)
ENROLL(regno:string, course#: int,sem: int,marks: int)
BOOK-ADOPTION (course#:int, sem: int, book-ISBN: int)
TEXT (book-ISBN: int, book-title: string, publisher: string,author: 
string)

E. Company Database:
EMPLOYEE (SSN, Name, Address, Sex, Salary, SuperSSN, DNo)
DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate)
DLOCATION (DNo,DLoc)
PROJECT (PNo, PName, PLocation, DNo)
WORKS_ON (SSN, PNo, Hours)

7,8,9,10
Data Manipulation Language (DML) and Data Control Language 
(DCL)
Write valid DML statements to retrieve tuples from the databases. The 
query may contain appropriate DML and DCL commands such as:
Select with
-> %like, between, where clause
-> Order by
-> Set Operations
-> Exists and not exists
-> Join operations
-> Aggregate functions
-> Group by
-> Group by having
-> Nested and correlated nested Queries
-> Grant and revoke permission

11,12 Views and Triggers
i. Views: creation and manipulating content.
ii. Triggers: creation and execution of database triggers on every insert, 
delete and update operation.

13 Lab Test/Event: Note (question no. 1 and 2 only for practice)
