-- Step 1: Create the Database (if not already created)
CREATE DATABASE IF NOT EXISTS ride_db;
USE ride_db;

-- Step 2: Create the 'users' Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    role ENUM('customer', 'driver') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 3: Create the 'vehicles' Table
CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    make VARCHAR(100),
    model VARCHAR(100),
    year INT,
    license_plate VARCHAR(50) UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Step 4: Create the 'rides' Table
CREATE TABLE IF NOT EXISTS rides (
    ride_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_id INT,
    customer_id INT,
    start_location VARCHAR(255),
    end_location VARCHAR(255),
    ride_status ENUM('pending', 'in_progress', 'completed', 'canceled') NOT NULL,
    fare DECIMAL(10, 2),
    ride_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (driver_id) REFERENCES users(user_id),
    FOREIGN KEY (customer_id) REFERENCES users(user_id)
);

-- Step 5: Insert Customers (IDs 1 to 5)
INSERT INTO users (full_name, email, phone_number, role)
VALUES 
('Bob Smith', 'bob@example.com', '9876543210', 'customer'),
('David Green', 'david@example.com', '5566778899', 'customer'),
('Frank Black', 'frank@example.com', '6677889900', 'customer'),
('Henry Gray', 'henry@example.com', '3344556677', 'customer'),
('Jack Red', 'jack@example.com', '5544332211', 'customer');

-- Step 6: Insert Drivers (IDs 6 to 10)
INSERT INTO users (full_name, email, phone_number, role)
VALUES 
('Alice Johnson', 'alice@example.com', '1234567890', 'driver'),
('Charlie Brown', 'charlie@example.com', '1122334455', 'driver'),
('Eva White', 'eva@example.com', '2233445566', 'driver'),
('Grace Blue', 'grace@example.com', '9988776655', 'driver'),
('Ivy Yellow', 'ivy@example.com', '4433221100', 'driver');

-- Step 7: Insert Vehicles for Drivers (IDs 6 to 10)
INSERT INTO vehicles (user_id, make, model, year, license_plate)
VALUES 
(6, 'Toyota', 'Camry', 2020, 'XYZ 1234'),
(7, 'Honda', 'Civic', 2018, 'ABC 5678'),
(8, 'Ford', 'Fusion', 2021, 'LMN 9101'),
(9, 'Chevrolet', 'Malibu', 2019, 'PQR 3456'),
(10, 'Hyundai', 'Elantra', 2022, 'STU 7890');

-- Step 8: Insert Ride Records (Only 10 total, using IDs 1-5 for customers and 6-10 for drivers)
INSERT INTO rides (driver_id, customer_id, start_location, end_location, ride_status, fare)
VALUES 
(6, 1, 'Downtown', 'Airport', 'completed', 35.50),
(7, 2, 'Suburbia', 'Mall', 'completed', 15.75),
(8, 3, 'City Center', 'Train Station', 'completed', 25.00),
(9, 4, 'Park Avenue', 'Shopping Center', 'completed', 18.50),
(10, 5, 'Beachside', 'Restaurant', 'completed', 30.00),
(6, 2, 'Main Street', 'University', 'completed', 12.50),
(7, 3, 'Market Square', 'Library', 'completed', 10.00),
(8, 4, 'East Side', 'Stadium', 'completed', 45.00),
(9, 5, 'River Road', 'Hospital', 'completed', 20.00),
(10, 1, 'City Center', 'Bank', 'completed', 33.50);
