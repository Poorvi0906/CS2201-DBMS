-- ===============================================

CREATE DATABASE SchoolDB;
USE SchoolDB;

-- Classes Table
CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(30),
    section VARCHAR(10)
);

-- Students Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender VARCHAR(10),
    dob DATE,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- Marks Table
CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(30),
    marks_obtained INT,
    max_marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- Insert Sample Data
-- Insert into Classes
INSERT INTO Classes VALUES
(1, 'Grade 10', 'A'),
(2, 'Grade 10', 'B'),
(3, 'Grade 11', 'A'),
(4, 'Grade 12', 'A');

-- Insert into Students
INSERT INTO Students VALUES
(101, 'Asha Rao', 'Female', '2007-03-15', 1),
(102, 'Rahul Kumar', 'Male', '2006-07-20', 1),
(103, 'Sneha Patil', 'Female', '2007-08-22', 2),
(104, 'Rohit Sharma', 'Male', '2005-12-11', 3),
(105, 'Neha Singh', 'Female', '2004-11-05', 4);

-- Insert into Marks
INSERT INTO Marks VALUES
(1, 101, 'Math', 85, 100),
(2, 101, 'Science', 90, 100),
(3, 102, 'Math', 78, 100),
(4, 102, 'Science', 88, 100),
(5, 103, 'Math', 82, 100),
(6, 103, 'Science', 80, 100),
(7, 104, 'Math', 91, 100),
(8, 104, 'Science', 89, 100),
(9, 105, 'Math', 87, 100),
(10, 105, 'Science', 93, 100);

-- JOIN Queries
-- Show class-wise student marks with subjects
SELECT c.class_name, s.student_name, m.subject, m.marks_obtained
FROM Classes c
JOIN Students s ON c.class_id = s.class_id
JOIN Marks m ON s.student_id = m.student_id
ORDER BY c.class_name, s.student_name;

-- List students with their total marks
SELECT s.student_name, c.class_name, SUM(m.marks_obtained) AS total_marks
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Classes c ON s.class_id = c.class_id
GROUP BY s.student_name, c.class_name;

-- Aggregate Functions

-- Average marks per class
SELECT c.class_name, AVG(m.marks_obtained) AS average_marks
FROM Classes c
JOIN Students s ON c.class_id = s.class_id
JOIN Marks m ON s.student_id = m.student_id
GROUP BY c.class_name;

-- Highest marks in each subject
SELECT subject, MAX(marks_obtained) AS highest_marks
FROM Marks
GROUP BY subject;

-- Stored Procedure – Insert New Student

DELIMITER //
CREATE PROCEDURE InsertNewStudent (
    IN p_student_id INT,
    IN p_student_name VARCHAR(50),
    IN p_gender VARCHAR(10),
    IN p_dob DATE,
    IN p_class_id INT
)
BEGIN
    INSERT INTO Students (student_id, student_name, gender, dob, class_id)
    VALUES (p_student_id, p_student_name, p_gender, p_dob, p_class_id);
END //
DELIMITER ;

-- Example Usage:
CALL InsertNewStudent(106, 'Kiran Das', 'Male', '2007-06-18', 2);

-- Stored Procedure – Update Marks

DELIMITER //
CREATE PROCEDURE UpdateMarks (
    IN p_student_id INT,
    IN p_subject VARCHAR(30),
    IN p_new_marks INT
)
BEGIN
    UPDATE Marks
    SET marks_obtained = p_new_marks
    WHERE student_id = p_student_id AND subject = p_subject;
END //
DELIMITER ;

-- Example Usage:
CALL UpdateMarks(101, 'Math', 95);

-- Verify Updates

SELECT * FROM Students;
SELECT * FROM Marks;
