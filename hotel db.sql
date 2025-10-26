
CREATE DATABASE HotelManagementDB;
USE HotelManagementDB;


CREATE TABLE Guests (
    guest_id INT PRIMARY KEY,
    guest_name VARCHAR(50),
    gender VARCHAR(10),
    phone VARCHAR(15),
    city VARCHAR(30)
);

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(30),
    price_per_night DECIMAL(10,2),
    status VARCHAR(20)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

INSERT INTO Guests VALUES
(1, 'Ravi Kumar', 'Male', '9876543210', 'Delhi'),
(2, 'Priya Sharma', 'Female', '9876501234', 'Mumbai'),
(3, 'Amit Verma', 'Male', '9811122233', 'Bangalore'),
(4, 'Sneha Rao', 'Female', '9922334455', 'Chennai');

INSERT INTO Rooms VALUES
(101, 'Single', 2500.00, 'Available'),
(102, 'Double', 3500.00, 'Available'),
(103, 'Suite', 5500.00, 'Available'),
(104, 'Single', 2500.00, 'Available'),
(105, 'Double', 3500.00, 'Available');

INSERT INTO Bookings VALUES
(1, 1, 101, '2025-10-20', '2025-10-22', 5000.00),
(2, 2, 103, '2025-10-21', '2025-10-24', 16500.00),
(3, 3, 105, '2025-10-23', '2025-10-25', 7000.00),
(4, 4, 102, '2025-10-22', '2025-10-23', 3500.00);

-- Join Queries
SELECT g.guest_name, g.city, r.room_type, b.check_in, b.check_out, b.total_amount
FROM Guests g
JOIN Bookings b ON g.guest_id = b.guest_id
JOIN Rooms r ON b.room_id = r.room_id;

-- Aggregate Functions
SELECT r.room_type, SUM(b.total_amount) AS total_revenue
FROM Rooms r
JOIN Bookings b ON r.room_id = b.room_id
GROUP BY r.room_type;

-- Date Function (Booking Duration)
SELECT b.booking_id, g.guest_name,
       DATEDIFF(b.check_out, b.check_in) AS nights_stayed,
       b.total_amount
FROM Bookings b
JOIN Guests g ON b.guest_id = g.guest_id;

-- Procedure: Insert Booking
DELIMITER //
CREATE PROCEDURE InsertBooking (
    IN p_booking_id INT,
    IN p_guest_id INT,
    IN p_room_id INT,
    IN p_check_in DATE,
    IN p_check_out DATE,
    IN p_total_amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO Bookings (booking_id, guest_id, room_id, check_in, check_out, total_amount)
    VALUES (p_booking_id, p_guest_id, p_room_id, p_check_in, p_check_out, p_total_amount);

    UPDATE Rooms SET status = 'Booked' WHERE room_id = p_room_id;
END //
DELIMITER ;

CALL InsertBooking(5, 1, 104, '2025-10-26', '2025-10-28', 5000.00);

-- Procedure: Update Booking
DELIMITER //
CREATE PROCEDURE UpdateBooking (
    IN p_booking_id INT,
    IN p_new_check_out DATE,
    IN p_new_amount DECIMAL(10,2)
)
BEGIN
    UPDATE Bookings
    SET check_out = p_new_check_out,
        total_amount = p_new_amount
    WHERE booking_id = p_booking_id;
END //
DELIMITER ;

CALL UpdateBooking(2, '2025-10-25', 20000.00);

SELECT * FROM Guests;
SELECT * FROM Rooms;
SELECT * FROM Bookings;
