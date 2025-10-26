
CREATE DATABASE Library_management_system;
USE Library_management_system;

-- Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(50),
    genre VARCHAR(30),
    available_copies INT
);

-- Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50),
    membership_date DATE,
    city VARCHAR(30)
);

-- IssueRecords Table
CREATE TABLE IssueRecords (
    issue_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Books
INSERT INTO Books VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', 3),
(2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 2),
(3, '1984', 'George Orwell', 'Dystopian', 4),
(4, 'The Alchemist', 'Paulo Coelho', 'Adventure', 5),
(5, 'Pride and Prejudice', 'Jane Austen', 'Romance', 3);

-- Members
INSERT INTO Members VALUES
(101, 'Asha Rao', '2023-01-10', 'Bangalore'),
(102, 'Rahul Kumar', '2023-03-05', 'Mysore'),
(103, 'Sneha Patil', '2023-04-22', 'Mangalore'),
(104, 'Rohit Sharma', '2023-06-15', 'Hubli');

-- Issue Records
INSERT INTO IssueRecords VALUES
(1, 1, 101, '2024-07-01', '2024-07-15'),
(2, 2, 102, '2024-07-05', '2024-07-20'),
(3, 3, 103, '2024-07-10', '2024-07-25'),
(4, 1, 104, '2024-08-01', '2024-08-16'),
(5, 4, 101, '2024-08-05', NULL);

-- JOIN Queries
-- INNER JOIN: Show member name, book title, issue and return dates
SELECT m.member_name, b.title, i.issue_date, i.return_date
FROM Members m
INNER JOIN IssueRecords i ON m.member_id = i.member_id
INNER JOIN Books b ON i.book_id = b.book_id;

-- LEFT JOIN: List all members even if they haven't issued any books
SELECT m.member_name, b.title, i.issue_date
FROM Members m
LEFT JOIN IssueRecords i ON m.member_id = i.member_id
LEFT JOIN Books b ON i.book_id = b.book_id;

-- RIGHT JOIN: List all issued books with their members
SELECT b.title, m.member_name, i.issue_date
FROM Books b
RIGHT JOIN IssueRecords i ON b.book_id = i.book_id
RIGHT JOIN Members m ON i.member_id = m.member_id;

-- Total issued books per member
SELECT m.member_name, COUNT(i.issue_id) AS total_issued_books
FROM Members m
LEFT JOIN IssueRecords i ON m.member_id = i.member_id
GROUP BY m.member_name;

-- Total issued books per genre
SELECT b.genre, COUNT(i.issue_id) AS total_issued_books
FROM Books b
LEFT JOIN IssueRecords i ON b.book_id = i.book_id
GROUP BY b.genre;

-- Find how many days each book was borrowed
SELECT issue_id, DATEDIFF(return_date, issue_date) AS days_borrowed
FROM IssueRecords
WHERE return_date IS NOT NULL;

-- List overdue books (not returned for more than 15 days)
SELECT i.issue_id, b.title, m.member_name, i.issue_date
FROM IssueRecords i
JOIN Books b ON i.book_id = b.book_id
JOIN Members m ON i.member_id = m.member_id
WHERE DATEDIFF(CURDATE(), i.issue_date) > 15 AND i.return_date IS NULL;

DELIMITER //
CREATE PROCEDURE UpdateBookAvailability (
    IN p_book_id INT,
    IN p_change INT
)
BEGIN
    UPDATE Books
    SET available_copies = available_copies + p_change
    WHERE book_id = p_book_id;
END //
DELIMITER ;

-- Example Usage:
-- When a book is issued
CALL UpdateBookAvailability(1, -1);

-- When a book is returned
CALL UpdateBookAvailability(1, 1);
