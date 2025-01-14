-- 1. Retrieve the names and contact details of all drivers with a rating of 4.5 or higher.
SELECT full_name, email, phone_number
FROM users
WHERE role = 'driver' AND rating >= 4.5;

-- 2. Find the total number of rides completed by each driver.
SELECT driver_id, COUNT(*) AS total_rides
FROM rides
WHERE ride_status = 'completed'
GROUP BY driver_id;

-- 3. List all riders who have never booked a ride.
SELECT u.full_name, u.email
FROM users u
LEFT JOIN rides r ON u.user_id = r.customer_id
WHERE u.role = 'customer' AND r.customer_id IS NULL;

-- 4. Calculate the total earnings of each driver from completed rides.
SELECT driver_id, SUM(fare) AS total_earnings
FROM rides
WHERE ride_status = 'completed'
GROUP BY driver_id;

-- 5. Retrieve the most recent ride for each rider.
SELECT r1.customer_id, r1.ride_id, r1.start_location, r1.end_location, r1.ride_date
FROM rides r1
JOIN (
    SELECT customer_id, MAX(ride_date) AS most_recent_ride
    FROM rides
    GROUP BY customer_id
) r2 ON r1.customer_id = r2.customer_id AND r1.ride_date = r2.most_recent_ride;

-- 6. Count the number of rides taken in each city.
SELECT start_location AS city, COUNT(*) AS ride_count
FROM rides
GROUP BY start_location;

-- 7. List all rides where the distance was greater than 20 km.
SELECT * FROM rides
WHERE distance > 20;

-- 8. Identify the most preferred payment method.
SELECT payment_method, COUNT(*) AS method_count
FROM rides
GROUP BY payment_method
ORDER BY method_count DESC
LIMIT 1;

-- 9. Find the top 3 highest-earning drivers.
SELECT driver_id, SUM(fare) AS total_earnings
FROM rides
WHERE ride_status = 'completed'
GROUP BY driver_id
ORDER BY total_earnings DESC
LIMIT 3;

-- 10. Retrieve details of all cancelled rides along with the rider's and driver's names.
SELECT r.ride_id, r.start_location, r.end_location, r.ride_date, r.fare,
       c.full_name AS customer_name, c.email AS customer_email,
       d.full_name AS driver_name, d.email AS driver_email
FROM rides r
JOIN users c ON r.customer_id = c.user_id
JOIN users d ON r.driver_id = d.user_id
WHERE r.ride_status = 'canceled';
