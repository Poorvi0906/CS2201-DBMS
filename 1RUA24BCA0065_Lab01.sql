-- Lab Experiment 01: Implementation of DDL Commands in SQL
-- STUDENT NAME: Poorvi R
-- USN: 1RUA24BCA0065
-- SECTION: 

SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;
-- OUTPUT : [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- 'root@localhost', 'RVU-PC-046', '8.4.6', '2025-08-18 11:35:13'

-- Scenario: University Course Management System
-- CREATE AND LOAD THE database DBLab001
-- Write your SQL query below Codespace:
CREATE database BCALab001;
use BCALab001;

-- Task 1: Create the Students Table
-- Create a table to store information about students.
-- Include the following columns:
-- 1. StudentID (Primary Key)
-- 2. FirstName
-- 3. LastName
-- 4. Email (Unique Constraint)
-- 5. DateOfBirth
Create table STUDENTS
( StudentID varchar(10) Primary Key,
FirstName varchar(15),
LastName varchar(10),
Email varchar(20) UNIQUE,
DateOfBirth DATE 
);

-- Write your SQL query below Codespace:

DESC STUDENTS; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
/* 'StudentID', 'varchar(10)', 'NO', 'PRI', NULL, ''
'FirstName', 'varchar(15)', 'YES', '', NULL, ''
'LastName', 'varchar(10)', 'YES', '', NULL, ''
'Email', 'varchar(20)', 'YES', 'UNI', NULL, ''
'DateOfBirth', 'date', 'YES', '', NULL, ''*/

-- OUTPUT : Disclaimer - This code is not the part of the SQL Code

-- Alter the table and 2 new columns
ALTER table STUDENTS ADD (Gender varchar(2), Age int);
-- Modify a column data type
ALTER table STUDENTS Modify Email varchar(50);
-- Rename a column
ALTER table STUDENTS rename column DateOfBirth to DoB;
-- Drop a column
ALTER TABLE STUDENTS DROP COLUMN LastName;
-- Rename the table
rename table STUDENTS TO Employee;
DESC Employee;


-- Task 2: Create the Courses Table
-- Create a table to store information about courses.
-- Include the following columns:
-- - CourseID (Primary Key)
-- - CourseName
-- - Credits

 CREATE table Courses
 (  CourseID varchar(10) Primary Key,
    CourseName varchar(20),
	Credits varchar(30) 
 );

-- Write your SQL query below Codespace:

DESC Courses; -- [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]
-- OUTPUT :
/*CourseID	varchar(10)	NO	PRI		
CourseName	varchar(20)	YES			
Credits	varchar(30)	YES	*/		

-- Alter the table and 2 new columns
ALTER table Courses ADD (Faculty varchar(20), CourseMaterial Varchar(50));
-- Modify a column data type 
ALTER table Courses Modify CourseName varchar(50);
-- Rename a column 
ALTER table Courses rename column Faculty to Faculties;
-- Drop a column
ALTER TABLE Courses DROP COLUMN Faculties;
-- Rename the table
rename table Courses TO Course;

-- Task 3: Create the Enrollments Table
-- Create a table to store course enrollment information.
-- Include the following columns:
-- - EnrollmentID (Primary Key)
-- - StudentID (Foreign Key referencing Students table)
-- - CourseID (Foreign Key referencing Courses table)
-- - EnrollmentDate

create table ENROLLMENTS
( EnrollID varchar(10) Primary Key,
StudentID varchar(10),
CourseID varchar(10),
Foreign Key (StudentID) references Student (StudentID),
Foreign Key (CourseID) references Course (CourseID)
);

-- Write your SQL query below Codespace:

DESC ENROLLMENTS; -- [ [ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ] ]
-- OUTPUT :
/* EnrollID	varchar(10)	NO	PRI		
StudentID	varchar(10)	YES	MUL		
CourseID	varchar(10)	YES	MUL		
Email	varchar(20)	YES			
fees	varchar(50)	YES		*/
	
-- Alter the table and 2 new columns
ALTER table ENROLLMENTS ADD (Email varchar(20), fees Varchar(50));
-- Modify a column data type
ALTER table ENROLLMENTS Modify Email varchar(50);
-- Rename a column
ALTER table ENROLLMENTS rename column fees to Fees_Payment;
-- Drop a column
ALTER TABLE ENROLLMENTS DROP COLUMN enrollID;
-- Rename the table
rename table ENROLLMENTS TO Registation;

-- Task 4: Alter the Students Table
-- Add a column 'PhoneNumber' to store student contact numbers.
alter table employee add (PhoneNumber varchar(10));
-- Write your SQL query below Codespace:

DESC employee; -- [[ COPYPASTE OF THE OUTPUT in CSV Format and terminate with ; ]]
/* StudentID	varchar(10)	NO	PRI		
FirstName	varchar(15)	YES			
Email	varchar(50)	YES	UNI		
DoB	date	YES			
Gender	varchar(2)	YES			
Age	int	YES			
PhoneNumber	varchar(10)	YES	*/ 
		
-- Task 5: Modify the Courses Table
-- Change the data type of the 'Credits' column to DECIMAL.
-- Write your SQL query below Codespace:
 alter table Courses modify Credits decimal;
-- Task 6: Drop Tables

SHOW TABLES; -- Before dropping the table

-- Drop the 'Courses' and 'Enrollments' tables from the database.
-- Write your SQL query below Codespace:
drop table registation;
drop table Course;
SHOW TABLES; -- After dropping the table Enrollement and Course

-- End of Lab Experiment 01
-- Upload the Completed worksheet in the google classroom with file name USN _ LabExperiment01
