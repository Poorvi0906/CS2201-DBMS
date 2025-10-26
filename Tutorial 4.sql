Create database LibraryDB;
use LibraryDB;

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Price INT,
    PublishDate DATE
);

INSERT INTO Books VALUES
(101, 'The Alchemist', 'Paulo Coelho', 350, '2010-06-15'),
(102, 'Atomic Habits', 'James Clear', 450, '2018-10-16'),
(103, 'Clean Code', 'Robert Martin', 550, '2008-08-01'),
(104, 'Think Like a Monk', 'Jay Shetty', 400, '2020-09-08'),
(105, 'Python Crash Course', 'Eric Matthes', 500, '2019-05-10');

CREATE TABLE Customers (
    CustID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

Insert into Customers values 
(201, "Arjun Rao", "arjun@gmail.com", '2021-02-10'),
(202, "Priya Nair", "priya@yahoo.com", '2020-07-25'),
(203, "John Smith", "john@gmail.com", '2022-01-14'),
(204, "Maria Lopez", "maria@outlook.com", '2019-11-30');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustID INT,
    BookID INT,
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (CustID) REFERENCES Customers(CustID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

INSERT INTO Orders VALUES
(301, 201, 101, '2022-03-05', 2),
(302, 202, 102, '2021-09-12', 1),
(303, 203, 103, '2023-05-19', 3),
(304, 204, 104, '2023-04-18', 2);

-- c.	Implement the below queries 
-- 1.	Display all customer names in uppercase.
 SELECT UPPER(Name) FROM Customers;
-- 2.	Show all customer names in lowercase.
SELECT LOWER(Name) FROM Customers;
-- 3.	Extract the first 3 letters of each book title.
SELECT SUBSTRING(Title,1,3) FROM Books;
-- 4.	Display each customer’s email domain (after @).
SELECT SUBSTRING(Email, INSTR(Email,'@')+1) AS Domain FROM Customers;
-- 5.	Find the length of each book title.
SELECT Title, LENGTH(Title) FROM Books;
-- 6.	Replace the word "Book" with "Text" in titles (if present).
SELECT REPLACE(Title,'Book','Text') FROM Books;
-- 7.	Concatenate Author name and Book title as a single string.
SELECT CONCAT(Author,' - ',Title) AS Info FROM Books;
-- 8.	Show book titles where the author’s name contains ‘a’.
SELECT * FROM Books WHERE Author LIKE '%a%';
-- 9.	Display the year in which each book was published.
SELECT Title, YEAR(PublishDate) FROM Books;
-- 10.	Find the month name in which each customer joined.
SELECT Name, MONTHNAME(JoinDate) FROM Customers;
-- 11.	List customers who joined in 2021.
SELECT * FROM Customers WHERE YEAR(JoinDate)=2021;
-- 12.	Find the day name on which each order was placed.
SELECT OrderID, DAYNAME(OrderDate) FROM Orders;
-- 13.	Display the age of each book (in years since published).
SELECT Title, YEAR(CURDATE()) - YEAR(PublishDate) AS AgeYears FROM Books;
-- 14.	Find the number of days between today and each customer’s join date.
SELECT Name, DATEDIFF(CURDATE(), JoinDate) AS DaysSinceJoin FROM Customers;
-- 15.	Show all orders placed in the month of December (any year).
SELECT * FROM Orders WHERE MONTH(OrderDate)=12;
-- 16.	Find the total number of books available in the store.
SELECT COUNT(*) AS TotalBooks FROM Books;
-- 17.	Find the average price of books.
SELECT AVG(Price) AS AvgPrice FROM Books;
-- 18.	Find the maximum and minimum book price.
SELECT MAX(Price), MIN(Price) FROM Books;
-- 19.	Count how many customers joined after 2020.
SELECT COUNT(*) FROM Customers WHERE YEAR(JoinDate) > 2020;
-- 20.	Find the total number of books ordered (all orders combined).
SELECT SUM(Qty) AS TotalBooksOrdered FROM Orders;
-- 21.	Show the total quantity of books ordered per customer.
SELECT CustID, SUM(Qty) FROM Orders GROUP BY CustID;
-- 22.	Find the average order quantity per book.
SELECT BookID, AVG(Qty) FROM Orders GROUP BY BookID;
-- 23.	Find the book with the highest total quantity ordered.
SELECT BookID, SUM(Qty) AS Total FROM Orders GROUP BY BookID ORDER BY Total DESC LIMIT 1;
-- 24.	Show the total revenue generated per book (Price × Quantity).
SELECT B.Title, SUM(O.Qty * B.Price) AS Revenue FROM Orders O JOIN Books B ON O.BookID=B.BookID GROUP BY O.BookID;
-- 25.	Find the total number of orders placed each year.
SELECT YEAR(OrderDate) AS Year, COUNT(*) AS OrderCount FROM Orders GROUP BY YEAR(OrderDate);

