Create Database Employee;
use Employee;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    age INT,
    salary DECIMAL(10,2),
    designation VARCHAR(50),
    address VARCHAR(100),
    doj DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT INTO Department VALUES 
(1, 'HR', 'Bangalore'),
(2, 'Development', 'Hyderabad'),
(3, 'Sales', 'Mumbai'),
(4, 'Finance', 'Chennai');

INSERT INTO Employee VALUES
(101, 'Ananya Rao', 28, 50000, 'HR Executive', 'Bangalore', '2020-02-15', 1),
(102, 'Ravi Kumar', 30, 60000, 'Developer', 'Hyderabad', '2019-06-10', 2),
(103, 'Sneha Patil', 26, 55000, 'Developer', 'Hyderabad', '2021-04-20', 2),
(104, 'Vikram Singh', 35, 75000, 'Sales Manager', 'Mumbai', '2018-01-25', 3),
(105, 'Priya Menon', 29, 58000, 'Accountant', 'Chennai', '2022-08-05', 4);

UPDATE Employee
SET salary = salary + 5000
WHERE designation = 'Developer';

SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees,
    AVG(e.salary) AS avg_salary,
    MAX(e.salary) AS highest_salary,
    MIN(e.salary) AS lowest_salary
FROM Department d
JOIN Employee e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

SELECT 
    UPPER(emp_name) AS EMPLOYEE_NAME,
    UPPER(designation) AS DESIGNATION,
    CONCAT(emp_name, ' works as ', designation) AS DETAILS
FROM Employee;

SELECT 
    emp_name,
    YEAR(doj) AS joining_year,
    TIMESTAMPDIFF(YEAR, doj, CURDATE()) AS years_worked
FROM Employee;

SELECT emp_name, salary
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
WHERE salary BETWEEN 40000 AND 80000
AND d.dept_name <> 'Sales';

SELECT 
    e.emp_name,
    e.designation,
    d.dept_name,
    d.location
FROM Employee e
INNER JOIN Department d ON e.dept_id = d.dept_id;

SELECT 
    e.emp_name,
    d.dept_name
FROM Employee e
LEFT JOIN Department d ON e.dept_id = d.dept_id;

SELECT 
    e.emp_name,
    d.dept_name
FROM Employee e
RIGHT JOIN Department d ON e.dept_id = d.dept_id;

DELIMITER //
CREATE PROCEDURE InsertEmployee (
    IN p_emp_id INT,
    IN p_emp_name VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(50),
    IN p_address VARCHAR(100),
    IN p_doj DATE,
    IN p_dept_id INT
)
BEGIN
    INSERT INTO Employee VALUES (p_emp_id, p_emp_name, p_age, p_salary, p_designation, p_address, p_doj, p_dept_id);
END //
DELIMITER ;

CALL InsertEmployee(106, 'Kiran Joshi', 27, 62000, 'Developer', 'Hyderabad', '2023-03-10', 2);

DELIMITER //
CREATE PROCEDURE UpdateSalary (
    IN p_emp_id INT,
    IN p_new_salary DECIMAL(10,2)
)
BEGIN
    UPDATE Employee SET salary = p_new_salary WHERE emp_id = p_emp_id;
END //
DELIMITER ;

CALL UpdateSalary(102, 70000);

DELIMITER //
CREATE PROCEDURE DeleteEmployee (IN p_emp_id INT)
BEGIN
    DELETE FROM Employee WHERE emp_id = p_emp_id;
END //
DELIMITER ;

CALL DeleteEmployee(105);

SELECT 
    e.emp_name,
    d.dept_name,
    TIMESTAMPDIFF(YEAR, e.doj, CURDATE()) AS years_worked,
    (CASE WHEN e.designation = 'Developer' THEN e.salary + 5000 ELSE e.salary END) AS salary_after_increment
FROM Employee e
JOIN Department d ON e.dept_id = d.dept_id
WHERE TIMESTAMPDIFF(YEAR, e.doj, CURDATE()) > 2;

