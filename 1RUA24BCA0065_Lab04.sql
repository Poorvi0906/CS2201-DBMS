-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 03: Implementation of different types of SQL functions.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: POORVI R
-- USN: 1RUA24BCA0065
-- SECTION: 
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command
	#	Time	Action	Message	Duration / Fetch
/* 1	11:29:07	SELECT USER(), 
        @@hostname AS Host_Name, 
        VERSION() AS MySQL_Version, 
        NOW() AS Current_Date_Time
 LIMIT 0, 1000	1 row(s) returned	0.000 sec / 0.000 sec */

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- PreCoded Relational Schema and Instance.
CREATE DATABASE Employee;
use Employee;
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- 1. create a table named Employee with EmpID ,FirstName,LastName Salary BirthDate HireDate 
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2),
    BirthDate DATE,
    HireDate DATE
);
-- 2. Insert 10 records to employee;
INSERT INTO Employee VALUES
(1, 'Amit', 'Sharma', 55908.50, '1990-03-15', '2015-06-01'),
(2, 'Priya', 'Verma', 62054.60, '1988-07-22', '2016-09-15'),
(3, 'Rahul', 'Mehta', 48670.70, '1992-11-05', '2018-01-10'),
(4, 'Sneha', 'Patil', 75567.66, '1985-02-28', '2012-04-20'),
(5, 'Vikram', 'Rao', 51532.43, '1993-09-12', '2019-07-01'),
(6, 'Neha', 'Singh', 58974.78, '1991-06-30', '2017-03-25'),
(7, 'Karan', 'Joshi', 67086.90, '1989-12-18', '2014-11-05'),
(8, 'Divya', 'Nair', 60426.08, '1990-08-10', '2016-08-01'),
(9, 'Arjun', 'Kapoor', 53000.05, '1994-01-22', '2020-02-17'),
(10, 'Meera', 'Desai', 72698.09, '1987-05-14', '2013-10-30');
-- 3. create a table named Orders with OrderID , OrderDate, totalAmount, EmpID(foreign key)  
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    EmpID INT,
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);
-- 4. Insert 10 records to Orders
INSERT INTO Orders VALUES
(101, '2025-01-15', 1200.50, 1),
(102, '2025-01-20', 850.00, 2),
(103, '2025-02-05', 4300.75, 3),
(104, '2025-02-18', 2999.99, 4),
(105, '2025-03-01', 1500.00, 5),
(106, '2025-03-12', 2200.40, 6),
(107, '2025-03-25', 1750.25, 7),
(108, '2025-04-03', 980.00, 8),
(109, '2025-04-15', 3100.60, 9),
(110, '2025-04-28', 4500.00, 10);

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Print the Information of the Employee and Order Table. [ Hint: SELECT * FROM TABLENAME ]
-- Write the SQL Query below this line.
SELECT * FROM Employee;
SELECT * FROM Orders;

 drop table Orders;
 drop table Employee;

-- Output: 
/* 1	Amit	Sharma	55908.60	1990-03-15	2015-06-01
2	Priya	Verma	62054.50	1988-07-22	2016-09-15
3	Rahul	Mehta	48670.70	1992-11-05	2018-01-10
4	Sneha	Patil	75567.66	1985-02-28	2012-04-20
5	Vikram	Rao		51532.43	1993-09-12	2019-07-01
6	Neha	Singh	58974.78	1991-06-30	2017-03-25
7	Karan	Joshi	67086.90	1989-12-18	2014-11-05
8	Divya	Nair	60426.08	1990-08-10	2016-08-01
9	Arjun	Kapoor	53000.05	1994-01-22	2020-02-17
10	Meera	Desai	72698.09	1987-05-14	2013-10-30
					
      101	2025-01-15	1200.50	1
102	2025-01-20	850.00	2
103	2025-02-05	4300.75	3
104	2025-02-18	2999.99	4
105	2025-03-01	1500.00	5
106	2025-03-12	2200.40	6
107	2025-03-25	1750.25	7
108	2025-04-03	980.00	8
109	2025-04-15	3100.60	9
110	2025-04-28	4500.00	10 */ 
			              
			                
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Number Functions Section
-- ------------------------------------------------------------
/* a. Round Salaries: Round employee salaries to nearest integer */
SELECT ROUND(Salary) As RoundSalary FROM Employee;

-- Output: 

/* b. Absolute Values: Show absolute values of salaries */
SELECT ABS(Salary) AS AbsoluteSalary FROM Employee;

-- Output: 
/* 55908
62054
48670
75567
51532
58974
67086
60426
53000
72698 */
/* c. Ceiling Values: Get ceiling values of order amounts */
SELECT CEIL(TotalAmount) AS CeilingAmount FROM Orders;

-- Output: 
/* 1201
850
4301
3000
1500
2201
1751
980
3101
4500 */
-- ------------------------------------------------------------
-- Aggregate Functions Section
-- ------------------------------------------------------------
/* a. Count of Employees: Find total number of employees */
SELECT COUNT(*) AS TotalEmployees FROM Employee;
-- Output: 
-- 10


/* b. Sum of Salaries: Calculate total salary expense */
SELECT SUM(Salary) AS TotalSalaryExpense FROM Employee;
-- Output: 
-- 605915.00

/* c. Average Order Amount: Find average order value */
SELECT AVG(TotalAmount) AS AvgOrderValue FROM Orders;
-- Output: 
-- 2338.249000

/* d. Max/Min Salary: Find highest and lowest salaries */
SELECT 
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary
FROM Employee;
-- Output: 
-- 75567.00	48670.00
-- ------------------------------------------------------------
-- Character Functions Section
-- ------------------------------------------------------------
/* a. Case Conversion: Show names in uppercase and lowercase */
SELECT 
    UPPER(FirstName) AS FirstName_Upper,
    LOWER(FirstName) AS FirstName_Lower,
    UPPER(LastName) AS LastName_Upper,
    LOWER(LastName) AS LastName_Lower
FROM Employee;
-- Output: 
/* AMIT	amit	SHARMA	sharma
PRIYA	priya	VERMA	verma
RAHUL	rahul	MEHTA	mehta
SNEHA	sneha	PATIL	patil
VIKRAM	vikram	RAO	rao
NEHA	neha	SINGH	singh
KARAN	karan	JOSHI	joshi
DIVYA	divya	NAIR	nair
ARJUN	arjun	KAPOOR	kapoor
MEERA	meera	DESAI	desai*/ 

/* b. Concatenate Names: Create full names */
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Employee;
-- Output: 
-- Amit Sharma
-- Priya Verma
-- Rahul Mehta
-- Sneha Patil
-- Vikram Rao
-- Neha Singh
-- Karan Joshi
-- Divya Nair
-- Arjun Kapoor
-- Meera Desai

/* c. Extract Substring: Get first 3 characters of first names */
SELECT SUBSTRING(FirstName, 1, 3) AS FirstThreeChars FROM Employee;
-- Output: 
/* Ami
Pri
Rah
Sne
Vik
Neh
Kar
Div
Arj
Mee		*/
-- ------------------------------------------------------------
-- Conversion Functions Section
-- ------------------------------------------------------------
/* Convert String to Date: Convert DATE to text type */
SELECT cast(OrderDate AS char ) AS ConvertedDate FROM Orders;
-- Output: 
/* 2025-01-15
2025-01-20
2025-02-05
2025-02-18
2025-03-01
2025-03-12
2025-03-25
2025-04-03
2025-04-15
2025-04-28 */ 
-- ------------------------------------------------------------
-- Date Functions Section
-- ------------------------------------------------------------
/* a. Current Date/Time: Get current timestamp */
SELECT now();
-- Output: 
-- 2025-09-08 12:46:33

/* b. Extract Year: Get year from order dates */
SELECT EXTRACT(YEAR FROM OrderDate) AS OrderYear FROM Orders;
-- Output: 
/* 2025
2025
2025
2025
2025
2025
2025
2025
2025
2025  */ 

/* c. Add Months: Add 3 months to order dates */
SELECT DATE_ADD(OrderDate, INTERVAL 3 MONTH) AS FinalDate FROM Orders;
-- Output: 
/* 2025-04-15
2025-04-20
2025-05-05
2025-05-18
2025-06-01
2025-06-12
2025-06-25
2025-07-03
2025-07-15
2025-07-28 */ 

/* d. Days Since Order: Calculate days between order date and now */
 SELECT OrderId, datediff( OrderDate, Now()) AS DATESINCEORDER from Orders;
-- Output: 
/* 236
231
215
202
191
180
167
158
146
133  */
-- END of the Task -- 