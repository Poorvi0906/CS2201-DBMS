
CREATE DATABASE BankingDB;
USE BankingDB;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    gender VARCHAR(10),
    phone VARCHAR(15),
    city VARCHAR(30)
);

-- Accounts Table
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Transactions Table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- Insert Customers
INSERT INTO Customers VALUES
(1, 'Ravi Kumar', 'Male', '9876543210', 'Delhi'),
(2, 'Priya Sharma', 'Female', '9876501234', 'Mumbai'),
(3, 'Amit Verma', 'Male', '9811122233', 'Bangalore'),
(4, 'Sneha Rao', 'Female', '9922334455', 'Chennai');

-- Insert Accounts
INSERT INTO Accounts VALUES
(101, 1, 'Savings', 50000.00),
(102, 2, 'Current', 75000.00),
(103, 3, 'Savings', 30000.00),
(104, 4, 'Savings', 90000.00);

-- Insert Transactions
INSERT INTO Transactions VALUES
(1, 101, '2025-10-01', 'Deposit', 20000.00),
(2, 101, '2025-10-05', 'Withdrawal', 5000.00),
(3, 102, '2025-10-03', 'Deposit', 10000.00),
(4, 102, '2025-10-10', 'Withdrawal', 7000.00),
(5, 103, '2025-10-02', 'Deposit', 8000.00),
(6, 104, '2025-10-06', 'Withdrawal', 10000.00),
(7, 104, '2025-10-15', 'Deposit', 12000.00);

-- 4️⃣ JOIN Queries

-- Display customer account details
SELECT c.customer_name, c.city, a.account_id, a.account_type, a.balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id;

-- Display transactions with customer details
SELECT c.customer_name, a.account_type, t.transaction_date, t.transaction_type, t.amount
FROM Transactions t
JOIN Accounts a ON t.account_id = a.account_id
JOIN Customers c ON a.customer_id = c.customer_id
ORDER BY t.transaction_date;

-- Aggregate Functions
-- Total amount transacted per account
SELECT account_id, SUM(amount) AS total_amount
FROM Transactions
GROUP BY account_id;

-- Maximum and Minimum transaction amount per customer
SELECT c.customer_name,
       MAX(t.amount) AS max_transaction,
       MIN(t.amount) AS min_transaction
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Transactions t ON a.account_id = t.account_id
GROUP BY c.customer_name;

-- Total balance per account type
SELECT account_type, SUM(balance) AS total_balance
FROM Accounts
GROUP BY account_type;

-- Date Function Examples

-- Show all transactions made in October 2025
SELECT * FROM Transactions
WHERE MONTH(transaction_date) = 10 AND YEAR(transaction_date) = 2025;

-- Show transactions made in the last 7 days
SELECT * FROM Transactions
WHERE transaction_date >= CURDATE() - INTERVAL 7 DAY;

-- Stored Procedure – Insert New Transaction

DELIMITER //
CREATE PROCEDURE InsertTransaction (
    IN p_transaction_id INT,
    IN p_account_id INT,
    IN p_transaction_date DATE,
    IN p_transaction_type VARCHAR(20),
    IN p_amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO Transactions (transaction_id, account_id, transaction_date, transaction_type, amount)
    VALUES (p_transaction_id, p_account_id, p_transaction_date, p_transaction_type, p_amount);
    
    IF p_transaction_type = 'Deposit' THEN
        UPDATE Accounts SET balance = balance + p_amount WHERE account_id = p_account_id;
    ELSEIF p_transaction_type = 'Withdrawal' THEN
        UPDATE Accounts SET balance = balance - p_amount WHERE account_id = p_account_id;
    END IF;
END //
DELIMITER ;

-- Example Usage:
CALL InsertTransaction(8, 103, '2025-10-25', 'Deposit', 5000.00);

-- Stored Procedure – Update Transaction Amount

DELIMITER //
CREATE PROCEDURE UpdateTransaction (
    IN p_transaction_id INT,
    IN p_new_amount DECIMAL(10,2)
)
BEGIN
    UPDATE Transactions
    SET amount = p_new_amount
    WHERE transaction_id = p_transaction_id;
END //
DELIMITER ;

-- Example Usage:
CALL UpdateTransaction(4, 9000.00);

-- Verify Updates

SELECT * FROM Accounts;
SELECT * FROM Transactions;

