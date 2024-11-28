USE eatin;

-- Get All Reservations for a Specific Customer
SELECT 
    r.reservation_id,
    r.reservation_time,
    r.status,
    t.table_number,
    t.capacity
FROM 
    reservations r
JOIN 
    tables t ON r.table_id = t.table_id
WHERE 
    r.customer_id = 1
ORDER BY 
    r.reservation_time DESC;

-- List Available Tables for a Specific Time
SELECT 
    t.table_id,
    t.table_number,
    t.capacity
FROM 
    tables t
LEFT JOIN 
    reservations r ON t.table_id = r.table_id AND r.reservation_time = '2024-11-28 19:00:00'
WHERE 
    r.reservation_id IS NULL;

-- Count Reservations by Status
SELECT 
    status,
    COUNT(*) AS total_reservations
FROM 
    reservations
GROUP BY 
    status;

-- Get Reservations for a Specific Day
SELECT 
    r.reservation_id,
    c.`First name`,
    c.`Last name`,
    t.table_number,
    r.reservation_time,
    r.status
FROM 
    reservations r
JOIN 
    customers c ON r.customer_id = c.customer_id
JOIN 
    tables t ON r.table_id = t.table_id
WHERE 
    DATE(r.reservation_time) = '2024-11-28'
ORDER BY 
    r.reservation_time ASC;

-- Add a New Reservation
INSERT INTO reservations (customer_id, table_id, reservation_time, status)
VALUES (1, 3, '2024-12-01 18:30:00', 'Reserved');

-- Cancel a Reservation
UPDATE reservations
SET status = 'Cancelled'
WHERE reservation_id = 1;

-- Find Customers with Multiple Reservations
SELECT 
    c.`First name`,
    c.`Last name`,
    COUNT(r.reservation_id) AS total_reservations
FROM 
    customers c
JOIN 
    reservations r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id
HAVING 
    total_reservations > 1;
