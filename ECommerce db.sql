CREATE DATABASE ECommerceDB;
USE ECommerceDB;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    email VARCHAR(50),
    city VARCHAR(30)
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(10,2),
    stock INT
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Sample Data
-- Customers
INSERT INTO Customers VALUES
(1, 'Asha Rao', 'asha@gmail.com', 'Bangalore'),
(2, 'Rahul Kumar', 'rahul@gmail.com', 'Mysore'),
(3, 'Sneha Patil', 'sneha@gmail.com', 'Mangalore'),
(4, 'Rohit Sharma', 'rohit@gmail.com', 'Hubli'),
(5, 'Neha Singh', 'neha@gmail.com', 'Udupi');

-- Products
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 60000.00, 10),
(102, 'Smartphone', 'Electronics', 25000.00, 20),
(103, 'Headphones', 'Accessories', 2000.00, 50),
(104, 'Shoes', 'Fashion', 3000.00, 30),
(105, 'Watch', 'Fashion', 4000.00, 25);

-- Orders
INSERT INTO Orders VALUES
(1, 1, 101, '2024-07-01', 1, 60000.00),
(2, 2, 103, '2024-07-05', 2, 4000.00),
(3, 3, 102, '2024-07-08', 1, 25000.00),
(4, 4, 104, '2024-07-10', 3, 9000.00),
(5, 5, 105, '2024-07-12', 2, 8000.00),
(6, 1, 103, '2024-07-15', 3, 6000.00);

-- JOIN Queries
-- Show all orders with customer and product details
SELECT o.order_id, c.customer_name, p.product_name, o.quantity, o.total_amount, o.order_date
FROM Orders o
INNER JOIN Customers c ON o.customer_id = c.customer_id
INNER JOIN Products p ON o.product_id = p.product_id;

-- List all customers and their orders (including those who haven’t ordered)
SELECT c.customer_name, o.order_id, p.product_name, o.quantity
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Products p ON o.product_id = p.product_id;

-- Aggregate Functions


-- Total Sales per Product
SELECT p.product_name, SUM(o.total_amount) AS total_sales
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_name;

-- Most Purchased Product (by quantity)
SELECT p.product_name, SUM(o.quantity) AS total_quantity
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 1;

-- Total Revenue (All Orders)
SELECT SUM(total_amount) AS total_revenue
FROM Orders;

-- Total Orders per Customer
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- Stored Procedure - Update Product Stock


DELIMITER //
CREATE PROCEDURE UpdateProductStock (
    IN p_product_id INT,
    IN p_quantity_sold INT
)
BEGIN
    UPDATE Products
    SET stock = stock - p_quantity_sold
    WHERE product_id = p_product_id;
END //
DELIMITER ;

-- Example Usage:
CALL UpdateProductStock(103, 3);

-- Verify Updated Stock
SELECT * FROM Products;

