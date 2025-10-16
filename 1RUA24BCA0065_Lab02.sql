-- Lab Experiment 01: Implementation of DDL Commands in SQL for the given scenarios
-- STUDENT NAME: Poorvi R 
-- USN: 1RUA24BCA0065
-- SECTION: 

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- root@localhost	RVU-PC-048	9.4.0	2025-08-25 11:23:41
-- Scenario: College Student Management System

-- CREATE AND LOAD THE database
-- Write your SQL query below Codespace:
CREATE database BCA_Lab002;
use BCA_Lab002;
-- Task 1: Create the Tables under this system (min 5 tables)

  -- Table 01: Departments ( DepartmentID, DepartmentName, HOD,ContactEmail,PhoneNumber,Location )
  -- Table 02: Course (CourseID, CourseName,Credits,DepartmentID,Duration,Fee )
  -- Table 03: Students (StudentID,FirstName,LastName,Email,DateOfBirth,CourseID)
  -- Table 04: Faculty FacultyID,FacultyName,DepartmentID,Qualification,Email,PhoneNumber)
  -- Table 05: Enrollments (  EnrollmentID,StudentID,CourseID,Semester,Year,Grade)
-- Specify the Key (Primary and Foreign) for each table while creating

-- Write your SQL query below Codespace:
CREATE TABLE Departments (
  DepartmentID INT PRIMARY KEY,
  DepartmentName VARCHAR(20),
  HOD VARCHAR(40),
  ContactEmail VARCHAR(70),
  PhoneNumber BIGINT,
  Location VARCHAR(1000)
);

CREATE TABLE Course (
  CourseID INT PRIMARY KEY,
  CourseName VARCHAR(30),
  Credits INT,
  DepartmentID INT,
  Duration VARCHAR(30),
  Fee VARCHAR(90),
  FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Students (
  StudentID INT PRIMARY KEY,
  FirstName VARCHAR(100),
  LastName VARCHAR(100),
  Email VARCHAR(80),
  DateOfBirth DATE,
  CourseID INT,
  FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Faculty (
  FacultyID INT PRIMARY KEY,
  FacultyName VARCHAR(50),
  DepartmentID INT,
  Qualification VARCHAR(40),
  Email VARCHAR(60),
  PhoneNumber BIGINT,
  FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Enrollments (
  EnrollmentID INT PRIMARY KEY,
  StudentID INT,
  CourseID INT,
  Semester INT,
  Year VARCHAR(30),
  Grade VARCHAR(10),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
  FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
  
DESC  Departments;
DESC Course;
DESC Students;
DESC Faculty;
DESC Enrollments;
  
-- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT : Disclaimer - This code is not the part of the SQL Code

--  describe the structure of each table and copy paste the Output 
/* DepartmentID	int	NO	PRI		
DepartmentName	varchar(20)	YES			
HOD	varchar(40)	YES			
ContactEmail	varchar(70)	YES			
PhoneNumber	bigint	YES			
Location	varchar(1000)	YES			

CourseID	int	NO	PRI		
CourseName	varchar(30)	YES			
Credits	int	YES			
DepartmentID	int	YES	MUL		
Duration	varchar(30)	YES			
Fee	varchar(90)	YES			

StudentID	int	NO	PRI		
FirstName	varchar(100)	YES			
LastName	varchar(100)	YES			
Email	varchar(80)	YES			
DateOfBirth	date	YES			
CourseID	int	YES	MUL		

FacultyID	int	NO	PRI		
FacultyName	varchar(50)	YES			
DepartmentID	int	YES	MUL		
Qualification	varchar(40)	YES			
Email	varchar(60)	YES			
PhoneNumber	bigint	YES			

EnrollmentID	int	NO	PRI		
StudentID	int	YES	MUL		
CourseID	int	YES	MUL		
Semester	int	YES			
Year	varchar(30)	YES			
Grade	varchar(10)	YES		*/	

-- Perform the following operations on the each of the tables
-- 01: add 2 new columns for each table
ALTER table Departments ADD (Number_of_Faculty varchar(20), Established_Year Varchar(50));
ALTER table Course ADD ( CourseDescription varchar(20), Max_Enrollment Varchar(50));
ALTER table Students ADD (Major_Department varchar(20), Current_Semester Varchar(50), CGPA varchar(15));
ALTER table Faculty ADD (Hire_Date DATE , Position Varchar(50));
ALTER table Enrollments ADD (StudentStatus varchar(20), Attendance_Percent Varchar(50));

-- 02: Modify the existing column from each table
ALTER table Departments Modify Established_Year Varchar(20);
ALTER table Course Modify CourseDescription varchar(110);
ALTER table Students Modify Current_Semester Varchar(10);
ALTER table Faculty Modify Position Varchar(30);
ALTER table Enrollments Modify Attendance_Percent Varchar(80);

-- 03 change the datatypes
ALTER TABLE students MODIFY CGPA DECIMAL(4,2);

-- 04: Rename a column
ALTER table Course rename column credits to No_of_credits ;

-- 05: Drop a column
ALTER TABLE Enrollments DROP COLUMN Attendance_Percent;

-- 06: Rename the table
rename table ENROLLMENTS TO Registation;
-- 07: describe the structure of the new table
DESC  Departments;
/* DepartmentID	int	NO	PRI		
DepartmentName	varchar(20)	YES			
HOD	varchar(40)	YES			
ContactEmail	varchar(70)	YES			
PhoneNumber	bigint	YES			
Location	varchar(1000)	YES			
Number_of_Faculty	varchar(20)	YES			
Established_Year	varchar(20)	YES		*/	

DESC Course;
/* CourseID	int	NO	PRI		
CourseName	varchar(30)	YES			
No_of_credits	int	YES			
DepartmentID	int	YES	MUL		
Duration	varchar(30)	YES			
Fee	varchar(90)	YES			
CourseDescription	varchar(110)	YES			
Max_Enrollment	varchar(50)	YES		*/	

DESC Students;
/* 	int	NO	PRI		
FirstName	varchar(100)	YES			
LastName	varchar(100)	YES			
Email	varchar(80)	YES			
DateOfBirth	date	YES			
CourseID	int	YES	MUL		
Major_Department	varchar(20)	YES			
Current_Semester	varchar(10)	YES			
CGPA	decimal(4,2)	YES		*/	

DESC Faculty;
/* FacultyID	int	NO	PRI		
FacultyName	varchar(50)	YES			
DepartmentID	int	YES	MUL		
Qualification	varchar(40)	YES			
Email	varchar(60)	YES			
PhoneNumber	bigint	YES			
Hire_Date	date	YES			
Position	varchar(30)	YES			*/

DESC registration;
/* DESC Registation;
EnrollmentID	int	NO	PRI		
StudentID	int	YES	MUL		
CourseID	int	YES	MUL		
Semester	int	YES			
Year	varchar(30)	YES			
Grade	varchar(10)	YES			
StudentStatus	varchar(20)	YES		*/	
  
-- Additional set of questions 
-- 1 Add a new column Address (VARCHAR(100)) to the Students table.
ALTER TABLE Students ADD Address VARCHAR(100);

-- 2 Add a column Gender (CHAR(1)) to the Students table.
ALTER TABLE Students ADD Gender CHAR(1);

-- 3 Add a column JoiningDate (DATE) to the Faculty table.
ALTER TABLE Faculty ADD Gender CHAR(1);

-- 4 Modify the column CourseName in the Courses table to increase its size from VARCHAR(50) to VARCHAR(100).
ALTER table Course Modify CourseName varchar(100);

-- 5 Modify the column Location in the Departments table to VARCHAR(80).
ALTER table Departments Modify Location varchar(80);

-- 6 Rename the column Qualification in the Faculty table to Degree.
ALTER table Faculty rename column Qualification to Degree;

-- 7 Rename the table Faculty to Teachers.
rename table Faculty TO Teachers;

-- 8 Drop the column PhoneNumber from the Departments table.
ALTER TABLE Departments DROP COLUMN PhoneNumber;

-- 9 Drop the column Email from the Students table.
ALTER TABLE Students DROP COLUMN Email;

-- 10 Drop the column Duration from the Courses table.
ALTER TABLE Courses DROP COLUMN Duration;

SHOW TABLES; -- Before dropping the table

-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:
drop table registation;
drop table Course;

SHOW TABLES; -- After dropping the table Enrollement and Course

-- Note: Perform the specified operations on all the 5 tables in the system
-- End of Lab Experiment 01
-- Upload the Completed worksheet in the google classroom with file name USN _ LabScenario01
