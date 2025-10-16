-- Lab Experiment 05: To implement different types of joins: Inner Join, Outer Join (Left, Right, Full), and Natural Join.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: 
-- USN: 
-- SECTION: 
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Write your code below this line along with the output 
-- root@localhost	RVU-PC-046	8.4.6	2025-09-22 05:57:21
CREATE DATABASE SHOPPING;
USE SHOPPING;
-- CREATE  a TABLE named Customers (customer_id INT PRIMARY KEY,customer_name VARCHAR(50),city VARCHAR(50)
CREATE TABLE Customers(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50) );
-- insert 5 records
INSERT INTO Customers VALUES (102, 'AMITH' ,'BANGALORE');
INSERT INTO Customers VALUES (105, 'AARAV' ,'BANGALORE');
INSERT INTO Customers VALUES (101, 'SMITHA' ,'BANGALORE');
INSERT INTO Customers VALUES (111, 'AKSHAY' ,'BANGALORE');
INSERT INTO Customers VALUES (113, 'POOJA' ,'BANGALORE');

SELECT * FROM Customers;
-- TABLE:02 Orders Table
-- CREATE a TABLE named Orders (order_id INT PRIMARY KEY,customer_id INT foreign key,product_name VARCHAR(50),order_date DATE,
    -- insert 5 records
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders VALUES 
(6, 111, 'Wireless Mouse', '2025-09-18'),
(7, 102, 'Bluetooth Headphones', '2025-09-19'),
(8, 113, 'Chair', '2025-09-20'),
(9, 101, 'FaceCream', '2025-09-21'),
(10, 105, 'Earbuds', '2025-09-22');
 
 SELECT * FROM Orders;
 
 
-- TASK FOR STUDENTS 
-- Write and Execute Queries
/*
1. Inner Join – 
   Find all orders placed by customers from the city "Bangalore."
   List all customers with the products they ordered.
   Show customer names and their order dates.
   Display order IDs with the corresponding customer names.
   Find the number of orders placed by each customer.
   Show city names along with the products ordered by customers.
*/
SELECT 
    o.order_id,
    c.customer_name,
    o.product_name,
    o.order_date
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.city = 'BANGALORE';
  
  
  SELECT 
    c.customer_name,
    o.product_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;
    
    SELECT 
    c.customer_name,
    o.order_date
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

SELECT 
    o.order_id,
    c.customer_name
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id;

SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

SELECT 
    c.city,
    o.product_name
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

/* 
2  Left Outer Join – 
    Find all customers and their orders, even if a customer has no orders.
    List all customers and the products they ordered.
    Show customer IDs, names, and their order IDs.
    Find the total number of orders (if any) placed by each customer.
    Retrieve customers who have not placed any orders.
	Display customer names with their order dates.
-- Write your code below this line along with the output 
*/
 
 SELECT 
    c.customer_name,
    o.order_id,
    o.product_name,
    o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;


SELECT 
    c.customer_name,
    o.product_name
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id;


SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.customer_name;


SELECT 
    c.customer_id,
    c.customer_name,
    c.city
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
WHERE 
    o.order_id IS NULL;

SELECT 
    c.customer_name,
    o.order_date
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id;


/* 3: Right Outer Join – 
      Find all orders and their corresponding customers, even if an order doesn't have a customer associated with it.
      Show all orders with the customer names.
      Display product names with the customers who ordered them.
	  List order IDs with customer cities.
      Find the number of orders per customer (include those without orders).
	  Retrieve customers who do not have any matching orders.
     Write your code below this line along with the output 
 */
SELECT 
    o.order_id,
    o.product_name,
    c.customer_name
FROM 
    Customers c
RIGHT JOIN 
    Orders o ON c.customer_id = o.customer_id;
    
    SELECT 
    o.order_id,
    o.product_name,
    c.customer_name
FROM 
    Customers c
RIGHT JOIN 
    Orders o ON c.customer_id = o.customer_id;

SELECT 
    o.product_name,
    c.customer_name
FROM 
    Customers c
RIGHT JOIN 
    Orders o ON c.customer_id = o.customer_id;

SELECT 
    o.order_id,
    c.city
FROM 
    Customers c
RIGHT JOIN 
    Orders o ON c.customer_id = o.customer_id;

SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.customer_name;

SELECT 
    c.customer_id,
    c.customer_name,
    c.city
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
WHERE 
    o.order_id IS NULL;


/* 4: Full Outer Join – 
        Find all customers and their orders, including those customers with no orders and orders without a customer.
        List all customers and products, whether they placed an order or not.
        Show customer IDs with order IDs (include unmatched ones).
		Display customer names with order dates.
		Find all unmatched records (customers without orders and orders without customers).
        Show customer cities with products.
     Write your code below this line along with the output 
  */   
  SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.product_name,
    o.order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
UNION
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.product_name,
    o.order_date
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;


SELECT 
    c.customer_name,
    o.product_name
FROM 
    Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT 
    c.customer_name,
    o.product_name
FROM 
    Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;


SELECT 
    c.customer_id,
    o.order_id
FROM 
    Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT 
    c.customer_id,
    o.order_id
FROM 
    Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;


SELECT 
    c.customer_name,
    o.order_date
FROM 
    Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT 
    c.customer_name,
    o.order_date
FROM 
    Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    NULL AS order_id,
    NULL AS product_name,
    NULL AS order_date
FROM 
    Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
UNION
SELECT 
    NULL AS customer_id,
    NULL AS customer_name,
    NULL AS city,
    o.order_id,
    o.product_name,
    o.order_date
FROM 
    Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;


SELECT 
    c.city,
    o.product_name
FROM 
    Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id

UNION

SELECT 
    c.city,
    o.product_name
FROM 
    Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;


  /* 5: Natural Join – 
          Find all orders placed by customers.
          List all customers with the products they ordered using NATURAL JOIN.
          Show customer names along with their order dates using NATURAL JOIN.
          Find all customer cities and the products ordered by those customers using NATURAL JOIN.


     Write your code below this line along with the output 
  */
SELECT * FROM Customers NATURAL JOIN Orders;

SELECT customer_name, product_name
FROM Customers
NATURAL JOIN Orders;

SELECT customer_name, order_date
FROM Customers
NATURAL JOIN Orders;

SELECT city, product_name
FROM Customers
NATURAL JOIN Orders;

  -- END OF THE EXPERIMENT