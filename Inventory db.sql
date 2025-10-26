
CREATE DATABASE InventoryDB;
USE InventoryDB;

-- Create Tables
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50),
    contact VARCHAR(15),
    city VARCHAR(30)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    unit_price DECIMAL(10,2)
);

CREATE TABLE SupplyOrders (
    order_id INT PRIMARY KEY,
    supplier_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_cost DECIMAL(10,2),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert Records
INSERT INTO Suppliers VALUES
(1, 'ABC Traders', '9876543210', 'Delhi'),
(2, 'Bright Supplies', '9811122233', 'Mumbai'),
(3, 'Mega Distributors', '9922334455', 'Chennai');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Mouse', 'Electronics', 500.00),
(103, 'Keyboard', 'Electronics', 1500.00),
(104, 'Desk Chair', 'Furniture', 3500.00),
(105, 'Office Table', 'Furniture', 7000.00);

INSERT INTO SupplyOrders VALUES
(1, 1, 101, '2025-10-20', 10, 550000.00),
(2, 1, 102, '2025-10-21', 50, 25000.00),
(3, 2, 103, '2025-10-22', 30, 45000.00),
(4, 3, 104, '2025-10-23', 20, 70000.00),
(5, 3, 105, '2025-10-24', 15, 105000.00);

-- Join Queries
SELECT s.supplier_name, p.product_name, so.order_date, so.quantity, so.total_cost
FROM Suppliers s
JOIN SupplyOrders so ON s.supplier_id = so.supplier_id
JOIN Products p ON so.product_id = p.product_id
ORDER BY so.order_date;

-- Aggregate Functions
SELECT s.supplier_name, SUM(so.quantity) AS total_quantity_supplied
FROM Suppliers s
JOIN SupplyOrders so ON s.supplier_id = so.supplier_id
GROUP BY s.supplier_name;

SELECT p.category, SUM(so.total_cost) AS total_value
FROM Products p
JOIN SupplyOrders so ON p.product_id = so.product_id
GROUP BY p.category;

-- Date Function
SELECT order_id, order_date,
       DATEDIFF(CURDATE(), order_date) AS days_since_order
FROM SupplyOrders;

-- Procedure: Insert Supply Order
DELIMITER //
CREATE PROCEDURE InsertSupplyOrder (
    IN p_order_id INT,
    IN p_supplier_id INT,
    IN p_product_id INT,
    IN p_order_date DATE,
    IN p_quantity INT,
    IN p_total_cost DECIMAL(10,2)
)
BEGIN
    INSERT INTO SupplyOrders (order_id, supplier_id, product_id, order_date, quantity, total_cost)
    VALUES (p_order_id, p_supplier_id, p_product_id, p_order_date, p_quantity, p_total_cost);
END //
DELIMITER ;

CALL InsertSupplyOrder(6, 2, 104, '2025-10-25', 10, 35000.00);

-- Procedure: Update Supply Order
DELIMITER //
CREATE PROCEDURE UpdateSupplyOrder (
    IN p_order_id INT,
    IN p_new_quantity INT,
    IN p_new_total_cost DECIMAL(10,2)
)
BEGIN
    UPDATE SupplyOrders
    SET quantity = p_new_quantity,
        total_cost = p_new_total_cost
    WHERE order_id = p_order_id;
END //
DELIMITER ;

CALL UpdateSupplyOrder(2, 60, 30000.00);

-- Verify
SELECT * FROM Suppliers;
SELECT * FROM Products;
SELECT * FROM SupplyOrders;
