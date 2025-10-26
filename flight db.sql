
CREATE DATABASE FlightReservationDB;
USE FlightReservationDB;

-- Create Tables
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    passenger_name VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(30)
);

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    flight_name VARCHAR(50),
    source_city VARCHAR(30),
    destination_city VARCHAR(30),
    departure_time DATETIME,
    arrival_time DATETIME,
    price DECIMAL(10,2)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    booking_date DATE,
    seat_no VARCHAR(10),
    status VARCHAR(20),
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Insert Records
INSERT INTO Passengers VALUES
(1, 'Ravi Kumar', 'Male', 28, 'Delhi'),
(2, 'Priya Sharma', 'Female', 25, 'Mumbai'),
(3, 'Amit Verma', 'Male', 30, 'Bangalore'),
(4, 'Sneha Rao', 'Female', 27, 'Chennai'),
(5, 'Kiran Das', 'Male', 35, 'Hyderabad');

INSERT INTO Flights VALUES
(101, 'IndiGo 6E-201', 'Delhi', 'Mumbai', '2025-11-05 08:00:00', '2025-11-05 10:15:00', 5500.00),
(102, 'Air India AI-305', 'Mumbai', 'Bangalore', '2025-11-06 09:30:00', '2025-11-06 11:45:00', 6500.00),
(103, 'Vistara UK-112', 'Bangalore', 'Chennai', '2025-11-07 14:00:00', '2025-11-07 15:30:00', 4500.00),
(104, 'SpiceJet SG-908', 'Chennai', 'Delhi', '2025-11-08 07:45:00', '2025-11-08 10:45:00', 6000.00),
(105, 'GoAir G8-410', 'Hyderabad', 'Kolkata', '2025-11-09 12:00:00', '2025-11-09 15:00:00', 7000.00);

INSERT INTO Bookings VALUES
(1, 1, 101, '2025-10-25', 'A12', 'Confirmed'),
(2, 2, 102, '2025-10-26', 'B10', 'Confirmed'),
(3, 3, 103, '2025-10-26', 'C05', 'Cancelled'),
(4, 4, 104, '2025-10-27', 'A07', 'Confirmed'),
(5, 5, 105, '2025-10-27', 'D02', 'Confirmed');

-- Join Queries
SELECT p.passenger_name, p.city, f.flight_name, f.source_city, f.destination_city, b.booking_date, b.status
FROM Passengers p
JOIN Bookings b ON p.passenger_id = b.passenger_id
JOIN Flights f ON b.flight_id = f.flight_id
ORDER BY b.booking_date;

SELECT f.flight_name, f.source_city, f.destination_city, p.passenger_name, b.seat_no, b.status
FROM Flights f
JOIN Bookings b ON f.flight_id = b.flight_id
JOIN Passengers p ON b.passenger_id = p.passenger_id;

-- Aggregate Functions
SELECT f.flight_id, f.flight_name, COUNT(b.passenger_id) AS total_passengers
FROM Flights f
LEFT JOIN Bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.flight_name;

SELECT AVG(price) AS average_ticket_price FROM Flights;

SELECT f.flight_name, COUNT(b.booking_id) AS confirmed_bookings
FROM Flights f
JOIN Bookings b ON f.flight_id = b.flight_id
WHERE b.status = 'Confirmed'
GROUP BY f.flight_name;

-- Procedure: Insert Booking
DELIMITER //
CREATE PROCEDURE InsertBooking (
    IN p_booking_id INT,
    IN p_passenger_id INT,
    IN p_flight_id INT,
    IN p_booking_date DATE,
    IN p_seat_no VARCHAR(10),
    IN p_status VARCHAR(20)
)
BEGIN
    INSERT INTO Bookings (booking_id, passenger_id, flight_id, booking_date, seat_no, status)
    VALUES (p_booking_id, p_passenger_id, p_flight_id, p_booking_date, p_seat_no, p_status);
END //
DELIMITER ;

CALL InsertBooking(6, 1, 102, '2025-10-28', 'E09', 'Confirmed');

-- Procedure: Update Booking
DELIMITER //
CREATE PROCEDURE UpdateBookingStatus (
    IN p_booking_id INT,
    IN p_new_status VARCHAR(20)
)
BEGIN
    UPDATE Bookings
    SET status = p_new_status
    WHERE booking_id = p_booking_id;
END //
DELIMITER ;

CALL UpdateBookingStatus(3, 'Confirmed');

-- Verify
SELECT * FROM Passengers;
SELECT * FROM Flights;
SELECT * FROM Bookings;
