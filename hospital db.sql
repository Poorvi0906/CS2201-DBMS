-- 1. Hospital Management System
-- Design a database for a hospital that manages details of patients, doctors, and appointments.
--  Include primary and foreign keys, insert sample records, perform joins, aggregate functions to calculate total patients per doctor, and procedures for inserting and updating appointments.

CREATE DATABASE Hospital_Management_System;
USE Hospital_Management_System;

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15),
    email VARCHAR(100)
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    notes TEXT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

INSERT INTO Doctors VALUES
(1, 'Dr. Asha Mehta', 'Cardiologist', '9876543210', 'asha@hospital.com'),
(2, 'Dr. Ravi Kumar', 'Neurologist', '9876543211', 'ravi@hospital.com'),
(3, 'Dr. Leela Nair', 'Pediatrician', '9876543212', 'leela@hospital.com');

INSERT INTO Patients VALUES
(101, 'Ananya Singh', 30, 'Female', '9123456780', 'ananya@gmail.com'),
(102, 'Rohan Das', 45, 'Male', '9123456781', 'rohan@gmail.com'),
(103, 'Meera Iyer', 5, 'Female', '9123456782', 'meera@gmail.com'),
(104, 'Arjun Rao', 60, 'Male', '9123456783', 'arjun@gmail.com'),
(105, 'Sneha Patil', 28, 'Female', '9123456784', 'sneha@gmail.com');

INSERT INTO Appointments VALUES
(1001, 1, 101, '2025-10-20', 'Completed', 'Routine checkup'),
(1002, 2, 102, '2025-10-21', 'Scheduled', 'Migraine issues'),
(1003, 3, 103, '2025-10-22', 'Completed', 'Vaccination'),
(1004, 1, 104, '2025-10-23', 'Cancelled', 'Heart checkup'),
(1005, 3, 105, '2025-10-24', 'Scheduled', 'Fever'),
(1006, 1, 102, '2025-10-25', 'Scheduled', 'Follow-up'),
(1007, 2, 101, '2025-10-26', 'Completed', 'Headache'),
(1008, 3, 103, '2025-10-26', 'Scheduled', 'Routine checkup');

-- join query 
SELECT 
    a.appointment_id,
    d.name AS doctor_name,
    p.name AS patient_name,
    a.appointment_date,
    a.status
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Patients p ON a.patient_id = p.patient_id;

-- Aggregate Query
SELECT 
    d.name AS doctor_name,
    COUNT(DISTINCT a.patient_id) AS total_patients
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.name;

-- Stored Procedures
-- a. Insert Appointment
DELIMITER //

CREATE PROCEDURE InsertAppointment (
    IN doc_id INT,
    IN pat_id INT,
    IN app_date DATE,
    IN app_status VARCHAR(20),
    IN app_notes TEXT
)
BEGIN
    INSERT INTO Appointments (appointment_id, doctor_id, patient_id, appointment_date, status, notes)
    VALUES (
        (SELECT IFNULL(MAX(appointment_id), 1000) + 1 FROM Appointments),
        doc_id, pat_id, app_date, app_status, app_notes
    );
END //

DELIMITER ;
