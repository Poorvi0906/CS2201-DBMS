-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 02: Program 02 - Implementation of DML Commands in SQL ( INSERT , SELECT, UPDATE and DELETE )
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: Poorvi R
-- USN: 1RUA24BCA0065
-- SECTION: 
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command
-- root@localhost	RVU-PC-048	9.4.0	2025-09-01 11:24:03

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Scenario: You are managing a database for a library with two tables: Books and Members.
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Task 01: Create Tables [ Check the below mentioned Instructions]:
-- Create the Books and Members tables with the specified structure.
-- Books Table and Member Table : 
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task with the Instructed Column in the session 
create database lib;
use lib;

CREATE DATABASE lib;
USE lib;

CREATE TABLE Books (
  bookID INT,
 title VARCHAR(50),
  author VARCHAR(50),
  publish_date DATE,
  available_copies int,
  total_copies int
);
DROP table Books;

CREATE TABLE Members (
  memberID INT,
  full_name VARCHAR(50),
  phone_number VARCHAR(50),
  issued_date DATE
);

DESC Books;
DESC Members;


-- Paste the Output below for the given command ( DESC TableName;) 
/* bookID	int	YES			
title	varchar(50)	YES			
author	varchar(50)	YES			
publish_date	date	YES			
available_copies	int	YES			
total_copies	int	YES						

memberID	int	YES			
full_name	varchar(50)	YES			
phone_number	varchar(50)	YES			
issued_date	date	YES			*/


ALTER TABLE Books RENAME COLUMN publish_date TO publishedIn;
ALTER table Books Modify publishedIn int ;
ALTER table Books ADD publishing_locations varchar(40); 

ALTER TABLE Members DROP COLUMN MembersID ;
ALTER TABLE Members DROP COLUMN phone_number;
ALTER TABLE Members DROP COLUMN issued_date;
ALTER table Members ADD joined_date DATE;
ALTER table Members ADD membershipType varchar(40);
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 02: Insert a New Book
-- Instructions: Insert a book titled "1984_The Black Swan" by George Orwell (published in 1949) with 04 available copies and 10 Total copies. 
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.
INSERT INTO Books (bookID, title, author, publishedIn, available_copies, total_copies)VALUES (1, '1984_The Black Swan', 'George Orwell', '1949', 4, 10);

INSERT INTO Books (bookID, title, author, publishedIn, available_copies, total_copies)VALUES (2, 'To Kill a Mockingbird', 'Harper Lee', '1960', 6, 12);

INSERT INTO Books (bookID, title, author, publishedIn, available_copies, total_copies)VALUES (3, 'Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', '2011', 5, 8);

INSERT INTO Books (bookID, title, author, publishedIn, available_copies, total_copies)VALUES (4, 'The Great Gatsby', 'F. Scott Fitzgerald', '1925', 2, 5);

INSERT INTO Books (bookID, title, author, publishedIn, available_copies, total_copies)VALUES (5, 'The Alchemist', 'Paulo Coelho', '1988', 7, 10);

SELECT * FROM Books;



-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
/* 1	1984_The Black Swan	George Orwell	1949	4	10
2	To Kill a Mockingbird	Harper Lee	1960	6	12
3	Sapiens: A Brief History of Humankind	Yuval Noah Harari	2011	5	8
4	The Great Gatsby	F. Scott Fitzgerald	1925	2	5
5	The Alchemist	Paulo Coelho	1988	7	10  */

-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 03: Add New Members
-- Instructions: Insert two members: David Lee (Platinum, joined 2024-04-15) and Emma Wilson (Silver, joined 2024-05-22).
-- Populate other fields as needed.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.
INSERT INTO Members (memberID, full_name, joined_date, membershipType) VALUES (1, 'David Lee', '2024-04-15', 'Platinum');
INSERT INTO Members (memberID, full_name, joined_date, membershipType) VALUES (1, 'Emma Wilson', '2024-05-22', 'Silver');

SELECT * FROM Members;




-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 04: Update Book Details 
-- Instructions: The library acquired 2 additional copies of "1984_The Black Swan". Update the Books table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

UPDATE Books
SET total_copies = total_copies + 2,
    available_copies = available_copies + 2
WHERE title = '1984_The Black Swan';

SELECT * FROM Books;

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
/* 1	1984_The Black Swan	George Orwell	1949	6	12	
2	To Kill a Mockingbird	Harper Lee	1960	6	12	
3	Sapiens: A Brief History of Humankind	Yuval Noah Harari	2011	5	8	
4	The Great Gatsby	F. Scott Fitzgerald	1925	2	5	
5	The Alchemist	Paulo Coelho	1988	7	10	*/
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 05: Modify a Member's Information
-- Instructions: Update a member's membership type. Emma Wilson has upgraded her membership from 'Silver' to 'Gold'.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

UPDATE Members SET membershipType = 'Gold' WHERE full_name = 'Emma Wilson';

SELECT * FROM Members;

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
/*
1	David Lee	2024-04-15	Platinum
1	Emma Wilson	2024-05-22	Gold        */
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 06: Remove a Member
-- Instructions: Delete David Lee’s record from the Members table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

DELETE FROM Members WHERE full_name = 'David Lee';

SELECT * FROM Members;

-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).
/* 
1	Emma Wilson	2024-05-22	Gold  */
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 09: Borrowing Table 
-- Instructions: Create a Borrowing table with foreign keys referencing Books and Members.
-- Subtask 1: Borrow a Book
-- Scenario:Emma Wilson (member_id = 2) borrows the book "The Catcher in the Rye" (book_id = 102) on 2024-06-01. Insert this record into the Borrowing table.
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.

CREATE TABLE Borrowing (
  borrowID INT PRIMARY KEY,
  memberID INT,
  bookID INT,
  borrowDate DATE,
  returnDate DATE,
  FOREIGN KEY (memberID) REFERENCES Members(memberID),
  FOREIGN KEY (bookID) REFERENCES Books(bookID)
);

INSERT INTO Borrowing (memberID, bookID, borrowDate)
VALUES (2, 102, '2024-06-01');




-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Task 10: Find the name of Borrower who book = 102 [ Advance and Optional ]
-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Write the SQL Query below for above mentioned task.








-- Paste the Output below for the given command ( SELECT * FROM TABLE_NAME ).


-- ------------------------------------------------------------------------------------------------------------------------------------------
-- Final Task 00: ER Diagram - Instructions:
-- Draw an ER diagram for the library database. Additional Upload the scanned copy of the created ER Daigram in the Google Classroom.



-- END of the Task -- 