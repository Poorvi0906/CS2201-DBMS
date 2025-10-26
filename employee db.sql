
CREATE DATABASE EmployeePayrollDB;
USE EmployeePayrollDB;

-- Departments Table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

-- Employees Table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    gender VARCHAR(10),
    dob DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- SalaryDetails Table
CREATE TABLE SalaryDetails (
    salary_id INT PRIMARY KEY,
    emp_id INT,
    basic_pay DECIMAL(10,2),
    hra DECIMAL(10,2),
    deductions DECIMAL(10,2),
    net_salary DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);

-- Insert into Departments
INSERT INTO Departments VALUES
(1, 'HR', 'Bangalore'),
(2, 'Finance', 'Mysore'),
(3, 'IT', 'Mangalore'),
(4, 'Marketing', 'Hubli');

-- Insert into Employees
INSERT INTO Employees VALUES
(101, 'Asha Rao', 'Female', '1998-04-12', 1),
(102, 'Rahul Kumar', 'Male', '1996-10-05', 3),
(103, 'Sneha Patil', 'Female', '1997-07-22', 2),
(104, 'Rohit Sharma', 'Male', '1995-12-11', 3),
(105, 'Neha Singh', 'Female', '1999-01-25', 4);

-- Insert into SalaryDetails
INSERT INTO SalaryDetails VALUES
(1, 101, 30000.00, 5000.00, 2000.00, 33000.00),
(2, 102, 45000.00, 8000.00, 3000.00, 50000.00),
(3, 103, 40000.00, 6000.00, 2500.00, 43500.00),
(4, 104, 50000.00, 9000.00, 3500.00, 55500.00),
(5, 105, 35000.00, 7000.00, 2200.00, 39700.00);

SELECT e.emp_name, e.gender, d.dept_name, d.location
FROM Employees e
INNER JOIN Departments d ON e.dept_id = d.dept_id;

SELECT e.emp_name, d.dept_name, s.basic_pay, s.hra, s.deductions, s.net_salary
FROM Employees e
INNER JOIN Departments d ON e.dept_id = d.dept_id
INNER JOIN SalaryDetails s ON e.emp_id = s.emp_id;

-- Total Salary Expenditure (Sum)
SELECT SUM(net_salary) AS total_salary_expenditure
FROM SalaryDetails;

-- Average Salary
SELECT AVG(net_salary) AS average_salary
FROM SalaryDetails;

-- Salary Summary by Department
SELECT d.dept_name,
       COUNT(e.emp_id) AS total_employees,
       SUM(s.net_salary) AS total_salary,
       AVG(s.net_salary) AS avg_salary
FROM Departments d
JOIN Employees e ON d.dept_id = e.dept_id
JOIN SalaryDetails s ON e.emp_id = s.emp_id
GROUP BY d.dept_name;

-- STORED PROCEDURE - Insert New Salary Record

DELIMITER //
CREATE PROCEDURE InsertSalaryRecord (
    IN p_salary_id INT,
    IN p_emp_id INT,
    IN p_basic DECIMAL(10,2),
    IN p_hra DECIMAL(10,2),
    IN p_deduct DECIMAL(10,2)
)
BEGIN
    DECLARE v_net DECIMAL(10,2);
    SET v_net = p_basic + p_hra - p_deduct;

    INSERT INTO SalaryDetails (salary_id, emp_id, basic_pay, hra, deductions, net_salary)
    VALUES (p_salary_id, p_emp_id, p_basic, p_hra, p_deduct, v_net);
END //
DELIMITER ;

-- Example Usage:
CALL InsertSalaryRecord(6, 103, 42000, 7000, 2500);


-- STORED PROCEDURE - Update Employee Salary
DELIMITER //
CREATE PROCEDURE UpdateSalary (
    IN p_emp_id INT,
    IN p_new_basic DECIMAL(10,2),
    IN p_new_hra DECIMAL(10,2),
    IN p_new_deduct DECIMAL(10,2)
)
BEGIN
    DECLARE v_new_net DECIMAL(10,2);
    SET v_new_net = p_new_basic + p_new_hra - p_new_deduct;

    UPDATE SalaryDetails
    SET basic_pay = p_new_basic,
        hra = p_new_hra,
        deductions = p_new_deduct,
        net_salary = v_new_net
    WHERE emp_id = p_emp_id;
END //
DELIMITER ;

-- Example Usage:
CALL UpdateSalary(102, 48000, 8500, 3000);

