-- Activity:
-- 1. School Database (Example Tables) 
-- (StudentID, FirstName, LastName, DOB, Class, Marks, City)
-- (TeacherID, FirstName, LastName, Subject, HireDate, Salary)
-- (CourseID, CourseName, Credits)
-- (EnrollID, StudentID, CourseID, Grade)
Create database student; 
use student;

CREATE TABLE Student (
    StudentID INT Primary Key,
    FirstName VARCHAR(50),
    LastName VARCHAR(30),
    DOB DATE,
    Class VARCHAR(5),
    Marks INT,
    City VARCHAR(20)
);

create table Teacher (
 TeacherID int primary Key, 
FirstName varchar(50), 
LastName varchar(20), 
Subject varchar(40), 
HireDate date, 
Salary int 
);

Create table Course (
CourseID int Primary Key, 
CourseName varchar(30), 
Credits int );

create table Enrollment (
EnrollID int Primary Key , 
StudentID int, 
CourseID int, 
Grade int,
Foreign Key (StudentID) references Student (StudentID),
Foreign Key (CourseID) references Course (CourseID)
);
ALTER TABLE Enrollment MODIFY Grade VARCHAR(2);

-- 2. Declare the keys as per requirement
-- 3.   Perform the below SQL functions on the Student database.
INSERT INTO Student VALUES (1, 'Amit', 'Sharma', '2005-01-15', '10A', 85, 'Delhi'),
(2, 'Priya', 'Verma', '2006-07-20', '9B', 92, 'Mumbai'),
(3, 'Rahul', 'Singh', '2005-12-05', '10A', 76, 'Chennai'),
(4, 'Sneha', 'Rao', '2007-01-10', '8C', 88, 'Bangalore'),
(5, 'Karan', 'Patel', '2006-03-25', '9A', 65, 'Kolkata');

-- 1.Display the details  of all students.
select * from Student;
-- 		output:- 
-- 1	Amit	Sharma	2005-01-15	10A	85	Delhi
-- 2	Priya	Verma	2006-07-20	9B	92	Mumbai
-- 3	Rahul	Singh	2005-12-05	10A	76	Chennai
-- 4	Sneha	Rao		2007-01-10	8C	88	Bangalore
-- 5	Karan	Patel	2006-03-25	9A	65	Kolkata
				
INSERT INTO Teacher VALUES (101, 'Meena', 'Iyer', 'Maths', '2015-06-10', 45000),
(102, 'Ravi', 'Kumar', 'Science', '2018-09-01', 52000),
(103, 'Sonal', 'Mehta', 'English', '2017-03-15', 48000),
(104, 'Vikram', 'Nair', 'History', '2016-11-20', 50000),
(105, 'Anjali', 'Desai', 'Computer', '2019-01-25', 55000);
						
INSERT INTO Course VALUES (201, 'Maths', 4),
(202, 'Science', 3),
(203, 'English', 2),
(204, 'History', 3),
(205, 'Computer', 5);
						
INSERT INTO Enrollment VALUES (301, 1, 201, 'A'),
(302, 2, 202, 'A'),
(303, 3, 203, 'B'),
(304, 4, 204, 'A'),
(305, 5, 205, 'C');

-- 2. Show the  last 3 characters of course names.
SELECT CourseName, RIGHT(CourseName, 3) AS Last3Chars FROM Course;
-- output:- 
-- Maths	ths
-- Science	nce
-- English	ish
-- History	ory
-- Computer	ter

-- 3. Concatenate FirstName and LastName of teachers as fullname
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Teacher;

-- 4. Find the length of each student’s name.
SELECT LENGTH(CONCAT(FirstName, ' ', LastName)) AS NameLength FROM Student;

-- 5.Replace the word "Maths" with "Mathematics" in the Course table. (use REPLACE function)
SELECT CourseName, REPLACE(CourseName, 'Maths', 'Mathematics') AS UpdatedCourse FROM Course;

-- 6.Find the absolute difference between maximum and minimum marks.
SELECT ABS(MAX(Marks) - MIN(Marks)) AS MarksDifference FROM Student;

-- 7. Round off teachers’ salaries to the nearest thousand.
SELECT ROUND(Salary, -3) AS RoundedSalary FROM Teacher;

-- 8.Show the square root of each course credit.
SELECT SQRT(Credits) AS CreditRoot FROM Course;

-- 9. Display students’ marks along with ceiling and floor values. 
SELECT CEIL(Marks) AS CeilingValue, FLOOR(Marks) AS FloorValue FROM Student;

-- 10. Find the modulus of total marks divided by 5.
SELECT MOD(SUM(Marks), 5) AS ModulusValue FROM Student;

-- 11. Display the current date and time.
SELECT NOW() AS CurrentDateTime;

-- 12.Show the year and month of hire for all teachers. 
SELECT YEAR(HireDate) AS HireYear,MONTH(HireDate) AS HireMonth FROM Teacher;

-- 13. List students who were born in January. 
SELECT * FROM Student WHERE MONTH(DOB) = 1;

-- 14. Find the difference in days between today and a teacher’s HireDate. 
SELECT DATEDIFF(CURDATE(), HireDate) AS DaysSinceHire FROM Teacher;

-- 15. Find the total number of students in the school. 
SELECT COUNT(*) AS TotalStudents FROM Student;

-- 16. Calculate the average salary of teachers.
SELECT AVG(Salary) AS AverageSalary FROM Teacher; 

-- 17. Find the highest and lowest marks in the Student table.
SELECT MAX(Marks) AS HighestMarks, MIN(Marks) AS LowestMarks FROM Student;