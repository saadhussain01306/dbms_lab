<h1>Programs for DBMS LAB @JSSSTU</h1>
<h2>20CS57L Database Management Systems Laboratory</h2>

<h1>List of Programs</h1>

<h2>Sailors Database</h2>
<h3>1. Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are underlined and the data types 
are specified.
Create tables for the following schema listed below by properly specifying the primary keys 
and foreign keys.
Enter at least five tuples for each relation.</h3>
<ol>
    <li>SAILORS (sid, sname, rating, age)</li>
    <li>BOAT(bid, bname, color)</li>
    <li>RSERVERS (sid, bid, date)</li>
</ol>
<p><strong>Queries, View and Trigger</strong></p>
<ol>
    <li>Find the colours of boats reserved by Albert</li>
    <li>Find all sailor id’s of sailors who have a rating of at least 8 or reserved boat 103</li>
    <li>Find the names of sailors who have not reserved a boat whose name contains the string “storm”. Order the names in ascending order.</li>
    <li>Find the names of sailors who have reserved all boats.</li>
    <li>Find the name and age of the oldest sailor.</li>
    <li>For each boat which was reserved by at least 5 sailors with age >= 40, find the boat id and the average age of such sailors.</li>
    <li>Create a view that shows the names and colours of all the boats that have been reserved by a sailor with a specific rating.</li>
    <li>A trigger that prevents boats from being deleted If they have active reservations.</li>
</ol>

<h2>Insurance Database</h2>
<h3>2. Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are underlined and the data types are 
specified.
Create tables for the following schema listed below by properly specifying the primary keys and 
foreign keys.
Enter at least five tuples for each relation.</h3>
<ol>
    <li>PERSON (driver_id# <u>string</u>, name <u>string</u>, address <u>string</u>)</li>
    <li>CAR (regno <u>string</u>, model <u>string</u>, year <u>int</u>)</li>
    <li>ACCIDENT (report_number <u>int</u>, acc_date <u>date</u>, location <u>string</u>)</li>
    <li>OWNS (driver_id# <u>string</u>, regno <u>string</u>)</li>
    <li>PARTICIPATED(driver_id# <u>string</u>, regno <u>string</u>, report_number <u>int</u>, damage_amount <u>int</u>)</li>
</ol>
<p><strong>Queries, View and Trigger</strong></p>
<ol>
    <li>Find the total number of people who owned cars that were involved in accidents in 2021.</li>
    <li>Find the number of accidents in which the cars belonging to “Smith” were involved.</li>
    <li>Add a new accident to the database; assume any values for required attributes.</li>
    <li>Delete the Mazda belonging to “Smith”.</li>
    <li>Update the damage amount for the car with license number “KA09MA1234” in the accident with report.</li>
    <li>A view that shows models and year of cars that are involved in accident.</li>
    <li>A trigger that prevents a driver from participating in more than 3 accidents in a given year.</li>
</ol>

<h2>Order Processing Database</h2>
<h3>3. Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are underlined and the data types are 
specified.
Create tables for the following schema listed below by properly specifying the primary keys and 
foreign keys.
Enter at least five tuples for each relation.</h3>
<ol>
    <li>Customer (Cust# <u>int</u>, cname <u>string</u>, city <u>string</u>)</li>
    <li>Order (order# <u>int</u>, odate <u>date</u>, cust# <u>int</u>, order_amt <u>int</u>)</li>
    <li>Order-item (order# <u>int</u>, Item# <u>int</u>, qty <u>int</u>)</li>
    <li>Item (item# <u>int</u>, unitprice <u>int</u>)</li>
    <li>Shipment (order# <u>int</u>, warehouse# <u>int</u>, ship-date <u>date</u>)</li>
    <li>Warehouse (warehouse# <u>int</u>, city <u>string</u>)</li>
</ol>
<p><strong>Queries, View and Trigger</strong></p>
<ol>
    <li>List the Order# and Ship_date for all orders shipped from Warehouse# "W2".</li>
    <li>List the Warehouse information from which the Customer named "Kumar" was supplied his orders. Produce a listing of Order#, Warehouse#.</li>
    <li>Produce a listing: Cname, #ofOrders, Avg_Order_Amt, where the middle column is the total number of orders by the customer and the last column is the average order amount for that customer. (Use aggregate functions).</li>
    <li>Delete all orders for customer named "Kumar".</li>
    <li>Find the item with the maximum unit price.</li>
    <li>A trigger that updates order_amout based on quantity and unitprice of order_item.</li>
    <li>Create a view to display orderID and shipment date of all orders shipped from a warehouse.</li>
</ol>

<h2>Student Enrollment Database</h2>
<h3>4. Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are underlined and the data types are 
specified.
Create tables for the following schema listed below by properly specifying the primary keys and 
foreign keys.
Enter at least five tuples for each relation.</h3>
<ol>
    <li>STUDENT (regno <u>string</u>, name <u>string</u>, major <u>string</u>, bdate <u>date</u>)</li>
    <li>COURSE (course# <u>int</u>, cname <u>string</u>, dept <u>string</u>)</li>
    <li>ENROLL(regno <u>string</u>, course# <u>int</u>, sem <u>int</u>, marks <u>int</u>)</li>
    <li>BOOK-ADOPTION (course# <u>int</u>, sem <u>int</u>, book-ISBN <u>int</u>)</li>
    <li>TEXT (book-ISBN <u>int</u>, book-title <u>string</u>, publisher <u>string</u>, author <u>string</u>)</li>
</ol>
<p><strong>Queries, View and Trigger</strong></p>
<ol>
    <li>Demonstrate how you add a new text book to the database and make this book be adopted by some department.</li>
    <li>Produce a list of text books (include Course #, Book-ISBN, Book-title) in the alphabetical order for courses offered by the ‘CS’ department that use more than two books.</li>
    <li>List any department that has all its adopted books published by a specific publisher.</li>
    <li>List the students who have scored maximum marks in ‘DBMS’ course.</li>
    <li>Create a view to display all the courses opted by a student along with marks obtained.</li>
    <li>Create a trigger that prevents a student from enrolling in a course if the marks prerequisite is less than 40.</li>
</ol>

<h2>Company Database</h2>
<h3>5. Consider the database schemas given below.
Write ER diagram and schema diagram. The primary keys are underlined and the data types are 
specified.
Create tables for the following schema listed below by properly specifying the primary keys and 
foreign keys.
Enter at least five tuples for each relation.</h3>
<ol>
    <li>EMPLOYEE (SSN <u>int</u>, Name <u>string</u>, Address <u>string</u>, Sex <u>char</u>, Salary <u>int</u>, SuperSSN <u>int</u>, DNo <u>int</u>)</li>
    <li>DEPARTMENT (DNo <u>int</u>, DName <u>string</u>, MgrSSN <u>int</u>, MgrStartDate <u>date</u>)</li>
    <li>DLOCATION (DNo <u>int</u>, DLoc <u>string</u>)</li>
    <li>PROJECT (PNo <u>int</u>, PName <u>string</u>, PLocation <u>string</u>, DNo <u>int</u>)</li>
    <li>WORKS_ON (SSN <u>int</u>, PNo <u>int</u>, Hours <u>int</u>)</li>
</ol>
<p><strong>Queries</strong></p>
<ol>
    <li>Make a list of all project numbers for projects that involve an employee whose last name is ‘Scott’, either as a worker or as a manager of the department that controls the project.</li>
    <li>Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 percent raise.</li>
    <li>Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the maximum salary, the minimum salary, and the average salary in this department.</li>
    <li>Retrieve the name of each employee who works on all the projects controlled by department number 5 (use NOT EXISTS operator).</li>
    <li>For each department that has more than five employees, retrieve the department number and the number of its employees who are making more than Rs. 6,00,000.</li>
    <li>Create a view that shows name, dept name and location of all employees.</li>
    <li>Create a trigger that prevents a project from being deleted if it is currently being worked by any employee.</li>
</ol>
