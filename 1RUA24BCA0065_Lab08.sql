-- Lab Experiment 08: Implementation of Procedure ( insert, update and delete)
-- STUDENT NAME: POORVI R
-- USN: 1RUA24BCA0065
-- SECTION: 

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]

-- Scenario: Employee Management System
-- CREATE AND LOAD THE database DBLab008
-- Write your SQL query below Codespace:
CREATE Database DBLab008 ;
use DBLab008;

-- Task 1: Create the Employee Table
-- Create a table to store information about Employee.
-- Include the following columns:
 --   empid INT PRIMARY KEY,
   -- empname VARCHAR(50),
   -- age INT,
   -- salary DECIMAL(10,2),
   -- designation VARCHAR(30),
   -- address VARCHAR(100),
   -- date_of_join DATE
-- Write your SQL query below Codespace:

create table Employee ( 
	 empid INT PRIMARY KEY,
    empname VARCHAR(50),
    age INT,
   salary DECIMAL(10,2),
   designation VARCHAR(30),
   address VARCHAR(100),
   date_of_join DATE ) ;
-- DESCRIBE THE SCHEMA -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
desc Employee;
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code
-- empid	int	NO	PRI		
-- empname	varchar(50)	YES			
-- age	int	YES			
-- salary	decimal(10,2)	YES			
-- designation	varchar(30)	YES			
-- address	varchar(100)	YES			
-- date_of_join	date	YES			

-- insert 10 records to the table 
-- Write your SQL query below Codespace:
INSERT INTO Employee (empid, empname, age, salary, designation, address, date_of_join) VALUES
(1, 'Amit Sharma', 30, 55000.00, 'Software Engineer', 'Bangalore, Karnataka', '2020-06-15'),
(2, 'Priya Verma', 28, 60000.00, 'Data Analyst', 'Mumbai, Maharashtra', '2021-03-10'),
(3, 'Rahul Mehta', 35, 75000.00, 'Project Manager', 'Delhi, India', '2019-11-01'),
(4, 'Sneha Kapoor', 26, 52000.00, 'UI/UX Designer', 'Pune, Maharashtra', '2022-01-20'),
(5, 'Vikram Singh', 40, 90000.00, 'Tech Lead', 'Hyderabad, Telangana', '2018-07-30'),
(6, 'Neha Joshi', 32, 58000.00, 'QA Engineer', 'Chennai, Tamil Nadu', '2020-09-25'),
(7, 'Ravi Kumar', 29, 61000.00, 'DevOps Engineer', 'Noida, Uttar Pradesh', '2021-05-18'),
(8, 'Anjali Desai', 27, 54000.00, 'Business Analyst', 'Ahmedabad, Gujarat', '2022-08-12'),
(9, 'Karan Patel', 33, 67000.00, 'Database Administrator', 'Surat, Gujarat', '2019-04-05'),
(10, 'Meera Nair', 31, 62000.00, 'HR Manager', 'Kochi, Kerala', '2020-12-01');

-- COPYPASTE OF THE OUTPUT in CSV Format and terminate with ;
-- # empid, empname, age, salary, designation, address, date_of_join
-- '1', 'Amit Sharma', '30', '55000.00', 'Software Engineer', 'Bangalore, Karnataka', '2020-06-15'
-- '2', 'Priya Verma', '28', '60000.00', 'Data Analyst', 'Mumbai, Maharashtra', '2021-03-10'
-- '3', 'Rahul Mehta', '35', '75000.00', 'Project Manager', 'Delhi, India', '2019-11-01'
-- '4', 'Sneha Kapoor', '26', '52000.00', 'UI/UX Designer', 'Pune, Maharashtra', '2022-01-20'
-- '5', 'Vikram Singh', '40', '90000.00', 'Tech Lead', 'Hyderabad, Telangana', '2018-07-30'
-- '6', 'Neha Joshi', '32', '58000.00', 'QA Engineer', 'Chennai, Tamil Nadu', '2020-09-25'
-- '7', 'Ravi Kumar', '29', '61000.00', 'DevOps Engineer', 'Noida, Uttar Pradesh', '2021-05-18'
-- '8', 'Anjali Desai', '27', '54000.00', 'Business Analyst', 'Ahmedabad, Gujarat', '2022-08-12'
-- '9', 'Karan Patel', '33', '67000.00', 'Database Administrator', 'Surat, Gujarat', '2019-04-05'
-- '10', 'Meera Nair', '31', '62000.00', 'HR Manager', 'Kochi, Kerala', '2020-12-01'

-- perform the following procedures on the employee database and copy paste the output in the space provided
-- A. Insert Procedure

-- 1. Write a stored procedure named InsertEmployee to insert a new employee record into the Employee table with all fields as input parameters.
DELIMITER //

CREATE PROCEDURE InsertEmployee (
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_address VARCHAR(100),
    IN p_date_of_join DATE
)
BEGIN
    INSERT INTO Employee (
        empid, empname, age, salary, designation, address, date_of_join
    ) VALUES (
        p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join
    );
END //

DELIMITER ;

-- CALL InsertEmployee(11, 'Suresh Raina', 34, 65000.00, 'System Analyst', 'Lucknow, Uttar Pradesh', '2023-02-14');

-- 2. Modify the insert procedure to ensure the employee’s age must be between 18 and 60.
      -- If not, display a message: "Invalid age, employee not added."
      DELIMITER //

CREATE PROCEDURE InsertEmployee (
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_address VARCHAR(100),
    IN p_date_of_join DATE
)
BEGIN
    IF p_age BETWEEN 18 AND 60 THEN
        INSERT INTO Employee (
            empid, empname, age, salary, designation, address, date_of_join
        ) VALUES (
            p_empid, p_empname, p_age, p_salary, p_designation, p_address, p_date_of_join
        );
    ELSE
        SELECT 'Invalid age, employee not added.' AS Message;
    END IF;
END //

DELIMITER ;
-- 3. Create a procedure that inserts a new employee record.
          -- If the salary is not provided, assign a default salary of 20000.
          DELIMITER //

CREATE PROCEDURE InsertEmployeeWithDefaultSalary (
    IN p_empid INT,
    IN p_empname VARCHAR(50),
    IN p_age INT,
    IN p_salary DECIMAL(10,2),
    IN p_designation VARCHAR(30),
    IN p_address VARCHAR(100),
    IN p_date_of_join DATE
)
BEGIN
    DECLARE v_salary DECIMAL(10,2);

    -- Assign default salary if NULL
    IF p_salary IS NULL THEN
        SET v_salary = 20000.00;
    ELSE
        SET v_salary = p_salary;
    END IF;

    INSERT INTO Employee (
        empid, empname, age, salary, designation, address, date_of_join
    ) VALUES (
        p_empid, p_empname, p_age, v_salary, p_designation, p_address, p_date_of_join
    );
END //

DELIMITER ;

-- 4. Write a procedure that inserts three new employee records in a single procedure using multiple INSERT statements.
DELIMITER //

CREATE PROCEDURE InsertThreeEmployees()
BEGIN
    INSERT INTO Employee (empid, empname, age, salary, designation, address, date_of_join)
    VALUES (14, 'Nikhil Rao', 27, 48000.00, 'Support Engineer', 'Nagpur, Maharashtra', '2023-04-10');

    INSERT INTO Employee (empid, empname, age, salary, designation, address, date_of_join)
    VALUES (15, 'Ritika Sen', 30, 53000.00, 'Marketing Executive', 'Indore, Madhya Pradesh', '2023-05-22');

    INSERT INTO Employee (empid, empname, age, salary, designation, address, date_of_join)
    VALUES (16, 'Manoj Pillai', 34, 70000.00, 'Product Manager', 'Thiruvananthapuram, Kerala', '2023-06-18');
END //

DELIMITER ;
-- B.  Update Procedure

-- Update Salary:
-- Write a stored procedure named UpdateSalary to update an employee’s salary based on their empid.
DELIMITER //

CREATE PROCEDURE UpdateSalary (
    IN p_empid INT,
    IN p_new_salary DECIMAL(10,2)
)
BEGIN
    UPDATE Employee
    SET salary = p_new_salary
    WHERE empid = p_empid;
END //

DELIMITER ;
-- Increment Salary by Percentage:
-- Create a procedure to increase the salary by 10% for all employees whose designation = 'Manager'.
DELIMITER //

CREATE PROCEDURE IncrementManagerSalary()
BEGIN
    UPDATE Employee
    SET salary = salary * 1.10
    WHERE designation = 'Manager';
END //

DELIMITER ;
-- Update Designation:
-- Write a procedure to update the designation of an employee by empid.
-- Example: Promote an employee from 'Clerk' to 'Senior Clerk'.
DELIMITER //

CREATE PROCEDURE UpdateDesignation (
    IN p_empid INT,
    IN p_new_designation VARCHAR(30)
)
BEGIN
    UPDATE Employee
    SET designation = p_new_designation
    WHERE empid = p_empid;
END //

DELIMITER ;

-- Update Address:
-- Write a procedure to update the address of an employee when empid is given as input.
DELIMITER //

CREATE PROCEDURE UpdateAddress (
    IN p_empid INT,
    IN p_new_address VARCHAR(100)
)
BEGIN
    UPDATE Employee
    SET address = p_new_address
    WHERE empid = p_empid;
END //

DELIMITER ;

-- Conditional Update (Age Check):
-- Create a procedure that updates salary only if the employee’s age > 40; otherwise, print "Not eligible for salary update."
DELIMITER //

CREATE PROCEDURE ConditionalSalaryUpdate (
    IN p_empid INT,
    IN p_new_salary DECIMAL(10,2)
)
BEGIN
    DECLARE v_age INT;

    -- Get the employee's age
    SELECT age INTO v_age
    FROM Employee
    WHERE empid = p_empid;

    -- Check age condition
    IF v_age > 40 THEN
        UPDATE Employee
        SET salary = p_new_salary
        WHERE empid = p_empid;
    ELSE
        SELECT 'Not eligible for salary update.' AS Message;
    END IF;
END //

DELIMITER ;

-- -- C. Delete Procedure

-- Delete by empid:
-- Write a stored procedure named DeleteEmployee to delete an employee record using their empid.
DELIMITER //

CREATE PROCEDURE DeleteEmployee (
    IN p_empid INT
)
BEGIN
    DELETE FROM Employee
    WHERE empid = p_empid;
END //

DELIMITER ;

-- Delete by Designation:
-- Create a procedure that deletes all employees belonging to a specific designation (e.g., 'Intern').
DELIMITER //

CREATE PROCEDURE DeleteByDesignation (
    IN p_designation VARCHAR(30)
)
BEGIN
    DELETE FROM Employee
    WHERE designation = p_designation;
END //

DELIMITER ;

-- Delete Based on Salary Range:
-- Write a procedure to delete employees whose salary is less than ₹15000.
DELIMITER //

CREATE PROCEDURE DeleteLowSalaryEmployees()
BEGIN
    DELETE FROM Employee
    WHERE salary < 15000.00;
END //

DELIMITER ;

-- Delete by Joining Year:
-- Write a procedure to delete employees who joined before the year 2015.
DELIMITER //

CREATE PROCEDURE DeleteByJoiningYear()
BEGIN
    DELETE FROM Employee
    WHERE YEAR(date_of_join) < 2015;
END //

DELIMITER ;

-- End of Lab Experiment 
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01