
CREATE DATABASE CinemaDB;
USE CinemaDB;

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    movie_name VARCHAR(50),
    genre VARCHAR(30),
    duration_minutes INT
);

CREATE TABLE Shows (
    show_id INT PRIMARY KEY,
    movie_id INT,
    show_date DATE,
    show_time TIME,
    hall VARCHAR(20),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    show_id INT,
    customer_name VARCHAR(50),
    tickets INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (show_id) REFERENCES Shows(show_id)
);

-- Insert Records
INSERT INTO Movies VALUES
(1, 'Avengers: Endgame', 'Action', 181),
(2, 'The Lion King', 'Animation', 118),
(3, 'Inception', 'Sci-Fi', 148),
(4, 'Titanic', 'Romance', 195);

INSERT INTO Shows VALUES
(1, 1, '2025-11-05', '18:00:00', 'Hall 1'),
(2, 1, '2025-11-05', '21:00:00', 'Hall 1'),
(3, 2, '2025-11-06', '17:00:00', 'Hall 2'),
(4, 3, '2025-11-06', '20:00:00', 'Hall 3'),
(5, 4, '2025-11-07', '19:00:00', 'Hall 4');

INSERT INTO Bookings VALUES
(1, 1, 'Ravi Kumar', 2, 1000.00),
(2, 2, 'Priya Sharma', 3, 1500.00),
(3, 3, 'Amit Verma', 1, 500.00),
(4, 4, 'Sneha Rao', 4, 2000.00),
(5, 5, 'Kiran Das', 2, 1000.00);

-- Join Queries
SELECT b.customer_name, m.movie_name, s.show_date, s.show_time, s.hall, b.tickets, b.total_amount
FROM Bookings b
JOIN Shows s ON b.show_id = s.show_id
JOIN Movies m ON s.movie_id = m.movie_id
ORDER BY s.show_date, s.show_time;

-- Aggregate Functions
SELECT m.movie_name, SUM(b.tickets) AS total_tickets
FROM Movies m
JOIN Shows s ON m.movie_id = s.movie_id
JOIN Bookings b ON s.show_id = b.show_id
GROUP BY m.movie_name;

-- Procedure: Insert Booking
DELIMITER //
CREATE PROCEDURE InsertBooking (
    IN p_booking_id INT,
    IN p_show_id INT,
    IN p_customer_name VARCHAR(50),
    IN p_tickets INT,
    IN p_total_amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO Bookings (booking_id, show_id, customer_name, tickets, total_amount)
    VALUES (p_booking_id, p_show_id, p_customer_name, p_tickets, p_total_amount);
END //
DELIMITER ;

CALL InsertBooking(6, 3, 'Neha Singh', 2, 1000.00);

-- Procedure: Update Booking
DELIMITER //
CREATE PROCEDURE UpdateBooking (
    IN p_booking_id INT,
    IN p_new_tickets INT,
    IN p_new_total_amount DECIMAL(10,2)
)
BEGIN
    UPDATE Bookings
    SET tickets = p_new_tickets,
        total_amount = p_new_total_amount
    WHERE booking_id = p_booking_id;
END //
DELIMITER ;

CALL UpdateBooking(2, 4, 2000.00);

-- Verify
SELECT * FROM Movies;
SELECT * FROM Shows;
SELECT * FROM Bookings;
