
-- Lab Experiment 04: Implement arithmetic, logical, comparison, special, and set operators in SQL using the Employees and Departments tables.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Poorvi R 
-- USN: 1RUA24BCA0065 
-- SECTION: 
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- root@localhost	LAPTOP-06BRA9QN	8.4.6	2025-09-15 11:55:57

-- Write your code below this line along with the output 
Create database office; 
use office; 

CREATE TABLE Employees (  
    EmployeeID INT PRIMARY KEY,  
    Name VARCHAR(100),  
    Age INT,  
    Salary DECIMAL(10,2),  
    DepartmentID INT,  
    HireDate DATE,  
    Address VARCHAR(255)  
);  

INSERT INTO Employees VALUES  
(1, 'Alice Johnson', 30, 60000, 1, '2020-03-15', '123 Main St, City A'),  
(2, 'Bob Smith', 28, 55000, 2, '2021-06-20', '456 Oak St, City B'),  
(3, 'Charlie Brown', 35, 75000, 3, '2019-01-10', '789 Pine St, City C'),  
(4, 'David Wilson', 40, 90000, 3, '2018-07-25', '101 Maple St, City D'),  
(5, 'Emma Davis', 27, 50000, 4, '2022-09-30', '202 Birch St, City E'),  
(6, 'Frank Miller', 32, 70000, 5, '2020-11-18', '303 Cedar St, City F'),  
(7, 'Grace Lee', 29, 58000, 1, '2021-04-05', '404 Walnut St, City G'),  
(8, 'Hank Adams', 45, 98000, 2, '2017-12-12', '505 Spruce St, City H'),  
(9, 'Ivy Green', 31, 64000, 4, '2023-02-14', '606 Redwood St, City I'),  
(10, 'Jack White', 38, 85000, 5, '2019-08-08', '707 Elm St, City J');  

-- TABLE:02 Department Table

CREATE TABLE Departments (  
    DepartmentID INT PRIMARY KEY,  
    DepartmentName VARCHAR(50)  
);  

INSERT INTO Departments VALUES  
(1, 'HR'),  
(2, 'Finance'),  
(3, 'Engineering'),  
(4, 'Marketing'),  
(5, 'Sales');  


-- TASK FOR STUDENTS 
select * from Employees ; 
-- 1	Alice Johnson	30	60000.00	1	2020-03-15	123 Main St, City A
-- 2	Bob Smith	28	55000.00	2	2021-06-20	456 Oak St, City B
-- 3	Charlie Brown	35	75000.00	3	2019-01-10	789 Pine St, City C
-- 4	David Wilson	40	90000.00	3	2018-07-25	101 Maple St, City D
-- 5	Emma Davis	27	50000.00	4	2022-09-30	202 Birch St, City E
-- 6	Frank Miller	32	70000.00	5	2020-11-18	303 Cedar St, City F
-- 7	Grace Lee	29	58000.00	1	2021-04-05	404 Walnut St, City G
-- 8	Hank Adams	45	98000.00	2	2017-12-12	505 Spruce St, City H
-- 9	Ivy Green	31	64000.00	4	2023-02-14	606 Redwood St, City I
-- 10	Jack White	38	85000.00	5	2019-08-08	707 Elm St, City J
						
select * from  Departments;
-- 1	HR
-- 2	Finance
-- 3	Engineering
-- 4	Marketing
-- 5	Sales
	
-- Exercise 1: Arithmetic Operators
-- Addition, Subtraction, Multiplication, Division
-- Q1 - Add a bonus (10% of Salary) to each employee’s salary.
UPDATE employees SET salary = salary + (salary * 0.10);
-- Q2 - Subtract tax (15% of Salary) from each employee’s salary.
UPDATE employees SET salary = salary - (salary * 0.15);
-- Q3 - Calculate the yearly salary from the monthly salary.
SELECT salary * 12 AS yearly_salary FROM employees; 
-- output :-
-- 673200.00
-- 617100.00
-- 841500.00
-- 1009800.00
-- 561000.00
-- 785400.00
-- 650760.00
-- 1099560.00
-- 718080.00
-- 953700.00
-- -- Modulus Operator
-- Q4 - Find the remainder when employees’ ages are divided by 5.
SELECT Age % 5 AS AgeRemainder FROM Employees;
/* 0
3
0
0
2
2
4
0
1
3 */ 
-- Write your code below this line along with the output 
--  final output 
--  1	Alice Johnson	30	56100.00	1	2020-03-15	123 Main St, City A
-- 2	Bob Smith	28	51425.00	2	2021-06-20	456 Oak St, City B
-- 3	Charlie Brown	35	70125.00	3	2019-01-10	789 Pine St, City C
-- 4	David Wilson	40	84150.00	3	2018-07-25	101 Maple St, City D
-- 5	Emma Davis	27	46750.00	4	2022-09-30	202 Birch St, City E
-- 6	Frank Miller	32	65450.00	5	2020-11-18	303 Cedar St, City F
-- 7	Grace Lee	29	54230.00	1	2021-04-05	404 Walnut St, City G
-- 8	Hank Adams	45	91630.00	2	2017-12-12	505 Spruce St, City H
-- 9	Ivy Green	31	59840.00	4	2023-02-14	606 Redwood St, City I
-- 10	Jack White	38	79475.00	5	2019-08-08	707 Elm St, City J
						
-- Exercise 2: Logical Operators: AND, OR, NOT

-- Q5 - Retrieve employees older than 30 AND with salary > 50000.
SELECT * FROM Employees WHERE Age > 30 AND Salary > 50000;
-- output :-  
-- 3	Charlie Brown	35	70125.00	3	2019-01-10	789 Pine St, City C
-- 4	David Wilson	40	84150.00	3	2018-07-25	101 Maple St, City D
-- 6	Frank Miller	32	65450.00	5	2020-11-18	303 Cedar St, City F
-- 8	Hank Adams	45	91630.00	2	2017-12-12	505 Spruce St, City H
-- 9	Ivy Green	31	59840.00	4	2023-02-14	606 Redwood St, City I
-- 10	Jack White	38	79475.00	5	2019-08-08	707 Elm St, City J
						
-- Q6 - Retrieve employees in the HR department (ID=1) OR earning > 70000.
SELECT * FROM Employees WHERE DepartmentID = 1 OR Salary > 70000;
/* 1	Alice Johnson	30	56100.00	1	2020-03-15	123 Main St, City A
3	Charlie Brown	35	70125.00	3	2019-01-10	789 Pine St, City C
4	David Wilson	40	84150.00	3	2018-07-25	101 Maple St, City D
7	Grace Lee	29	54230.00	1	2021-04-05	404 Walnut St, City G
8	Hank Adams	45	91630.00	2	2017-12-12	505 Spruce St, City H
10	Jack White	38	79475.00	5	2019-08-08	707 Elm St, City J
						*/
-- Q7 - Retrieve employees NOT living in City G.
SELECT * FROM Employees WHERE Address NOT LIKE '%City G%';
 /* output:-
1	Alice Johnson	30	56100.00	1	2020-03-15	123 Main St, City A
2	Bob Smith	28	51425.00	2	2021-06-20	456 Oak St, City B
3	Charlie Brown	35	70125.00	3	2019-01-10	789 Pine St, City C
4	David Wilson	40	84150.00	3	2018-07-25	101 Maple St, City D
5	Emma Davis	27	46750.00	4	2022-09-30	202 Birch St, City E
6	Frank Miller	32	65450.00	5	2020-11-18	303 Cedar St, City F
8	Hank Adams	45	91630.00	2	2017-12-12	505 Spruce St, City H
9	Ivy Green	31	59840.00	4	2023-02-14	606 Redwood St, City I
10	Jack White	38	79475.00	5	2019-08-08	707 Elm St, City J     */ 
						
-- Write your code below this line along with the output 
-- Exercise 3: Comparison Operators

-- Q8 - Equality, Inequality, Greater Than, Less Than
-- Q9 - Find employees with salary = 60000.
SELECT * FROM Employees WHERE Salary = 60000;
-- Q10 - List employees not in the IT department (no IT department exists; returns all).
SELECT * 
FROM Employees  
WHERE DepartmentID NOT IN (
    SELECT DepartmentID 
    FROM Departments 
    WHERE DepartmentName = 'IT'
);
/* output:- 
1	Alice Johnson	30	56100.00	1	2020-03-15	123 Main St, City A
2	Bob Smith	28	51425.00	2	2021-06-20	456 Oak St, City B
3	Charlie Brown	35	70125.00	3	2019-01-10	789 Pine St, City C
4	David Wilson	40	84150.00	3	2018-07-25	101 Maple St, City D
5	Emma Davis	27	46750.00	4	2022-09-30	202 Birch St, City E
6	Frank Miller	32	65450.00	5	2020-11-18	303 Cedar St, City F
7	Grace Lee	29	54230.00	1	2021-04-05	404 Walnut St, City G
8	Hank Adams	45	91630.00	2	2017-12-12	505 Spruce St, City H
9	Ivy Green	31	59840.00	4	2023-02-14	606 Redwood St, City I
10	Jack White	38	79475.00	5	2019-08-08	707 Elm St, City J
						*/ 

-- Q11 - Retrieve employees younger than 25 with salary > 50000 
SELECT * FROM Employees WHERE Age < 25 AND Salary > 50000;
-- Q12 - List employees aged 25–35.
SELECT * FROM Employees WHERE Age BETWEEN 25 AND 35; 
/* 1	Alice Johnson	30	56100.00	1	2020-03-15	123 Main St, City A
2	Bob Smith	28	51425.00	2	2021-06-20	456 Oak St, City B
3	Charlie Brown	35	70125.00	3	2019-01-10	789 Pine St, City C
5	Emma Davis	27	46750.00	4	2022-09-30	202 Birch St, City E
6	Frank Miller	32	65450.00	5	2020-11-18	303 Cedar St, City F
7	Grace Lee	29	54230.00	1	2021-04-05	404 Walnut St, City G
9	Ivy Green	31	59840.00	4	2023-02-14	606 Redwood St, City I
						*/ 
                        
-- Q13 - Find employees in HR, Finance, or Engineering (IDs 1, 2, 3).
	SELECT * FROM Employees WHERE DepartmentID IN (1, 2, 3);	
/* output:-     1	Alice Johnson	30	56100.00	1	2020-03-15	123 Main St, City A
2	Bob Smith	28	51425.00	2	2021-06-20	456 Oak St, City B
3	Charlie Brown	35	70125.00	3	2019-01-10	789 Pine St, City C
5	Emma Davis	27	46750.00	4	2022-09-30	202 Birch St, City E
6	Frank Miller	32	65450.00	5	2020-11-18	303 Cedar St, City F
7	Grace Lee	29	54230.00	1	2021-04-05	404 Walnut St, City G
9	Ivy Green	31	59840.00	4	2023-02-14	606 Redwood St, City I    */
						
-- Q14 - Find employees with names starting with A.
Select * from employees where Name like 'A%';
-- 1	Alice Johnson	30	56100.00	1	2020-03-15	123 Main St, City A
	
-- Q15 - List employees with no address.
SELECT * FROM Employees WHERE Address IS NULL;

-- Write your code below this line along with the output 

-- Exercise 5: Set Operators: UNION.

-- Q16 - Retrieve names from the HR department hired in 2022 OR 2023.

-- Q17 - Find common employees in the Engineering department (ID=3) hired before and after 2020.

-- Q18 - Find employees hired in 2023 but not in 2022.
