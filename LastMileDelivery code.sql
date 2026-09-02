DATABASE SETUP

-- 2.1 CREATE DATABASE
CREATE DATABASE quickroute_logistics_analytics;
USE quickroute_logistics_analytics;

-- 2.2 CREATE CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    delivery_zone_id VARCHAR(10) NOT NULL,
    preferred_time_slot VARCHAR(30) NOT NULL,
    customer_type VARCHAR(20) NOT NULL,
    account_since DATE NOT NULL
);

-- 2.3 CREATE DRIVERS TABLE
CREATE TABLE drivers (
    driver_id VARCHAR(10) PRIMARY KEY,
    driver_name VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    rating DECIMAL(3,2) NOT NULL,
    employment_type VARCHAR(20) NOT NULL,
    is_active VARCHAR(3) NOT NULL
);

-- 2.4 CREATE VEHICLES TABLE
CREATE TABLE vehicles (
    vehicle_id VARCHAR(10) PRIMARY KEY,
    vehicle_type VARCHAR(20) NOT NULL,
    fuel_type VARCHAR(20) NOT NULL,
    max_payload_kg DECIMAL(7,2) NOT NULL,
    depot VARCHAR(10) NOT NULL,
    last_service_date DATE NOT NULL,
    is_active VARCHAR(3) NOT NULL
);

-- 2.5 CREATE ORDERS TABLE
CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    delivery_zone_id VARCHAR(10) NOT NULL,
    package_weight_kg DECIMAL(5,2) NOT NULL,
    service_type VARCHAR(20) NOT NULL,
    priority VARCHAR(10) NOT NULL,
    total_value DECIMAL(10,2) NOT NULL,


    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- 2.6 CREATE DELIVERIES TABLE
CREATE TABLE deliveries (
    delivery_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20) NOT NULL,
    driver_id VARCHAR(10) NOT NULL,
    vehicle_id VARCHAR(10) NOT NULL,
    assigned_date DATE NOT NULL,
    actual_delivery_date DATE,
    status VARCHAR(20) NOT NULL,
    delivery_attempt TINYINT NOT NULL,
    distance_km DECIMAL(6,2) NOT NULL,
    delivery_duration_min INT NOT NULL,


    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),


    FOREIGN KEY (driver_id)
        REFERENCES drivers(driver_id),


    FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id)
);

-- 2.7 CHECK TABLES
SHOW TABLES;

--- Select the project database
USE quickroute_logistics_analytics;

-- Verify all five tables
SHOW TABLES;
TRUNCATE TABLE deliveries;

ALTER TABLE deliveries
MODIFY actual_delivery_date VARCHAR(20) NULL;

-- Verify the number of records imported

SELECT 'customers' AS table_name, COUNT(*) AS total_rows
FROM customers

UNION ALL

SELECT 'drivers', COUNT(*)
FROM drivers

UNION ALL

SELECT 'vehicles', COUNT(*)
FROM vehicles

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'deliveries', COUNT(*)
FROM deliveries;

-- Check table structures
DESCRIBE customers;

DESCRIBE drivers;

DESCRIBE vehicles;

DESCRIBE orders;

DESCRIBE deliveries;



-- SPRINT 3: BASIC ANALYSIS / DATA EXPLORATION

USE quickroute_logistics_analytics;

-- QUESTION 1
-- What is the total number of customers?

SELECT COUNT(*) AS total_customers
FROM customers;

-- QUESTION 2
-- What is the total number of orders?

SELECT COUNT(*) AS total_orders
FROM orders;

-- QUESTION 3
-- What is the total number of deliveries?

SELECT COUNT(*) AS total_deliveries
FROM deliveries;

-- QUESTION 4
-- What are the different service types available?

SELECT DISTINCT service_type
FROM orders
ORDER BY service_type;

-- QUESTION 5
-- How many drivers are currently active?

SELECT COUNT(*) AS active_drivers
FROM drivers
WHERE is_active = 'Yes';

-- QUESTION 6
-- What are the different vehicle types?

SELECT DISTINCT vehicle_type
FROM vehicles
ORDER BY vehicle_type;

-- QUESTION 7
-- What is the total order value?

SELECT
    ROUND(SUM(total_value), 2)
        AS total_order_value
FROM orders;

-- QUESTION 8
-- What is the average package weight?

SELECT
    ROUND(AVG(package_weight_kg), 2)
        AS average_package_weight
FROM orders;


-- SPRINT 4: OBJECTIVE-BASED ANALYSIS

-- The following analytical questions are formulated from the five Sprint 4 objectives.

-- The queries are used to analyse:

-- delivery demand
-- customer order behaviour
-- delivery performance
-- driver and vehicle performance
-- delivery problems

-- 4.1 UNDERSTAND DELIVERY DEMAND

-- QUESTION 4.1.1
-- Which delivery zones have the highest order volume?
SELECT
    delivery_zone_id,
    COUNT(order_id) AS order_volume
FROM orders
GROUP BY delivery_zone_id
ORDER BY order_volume DESC;

-- QUESTION 4.1.2
-- How does order volume differ across service types?
SELECT
    service_type,
    COUNT(order_id) AS order_volume
FROM orders
GROUP BY service_type
ORDER BY order_volume DESC;

-- QUESTION 4.1.3
-- How does order volume differ across priority levels?
SELECT
    priority,
    COUNT(order_id) AS order_volume
FROM orders
GROUP BY priority
ORDER BY order_volume DESC;

-- QUESTION 4.1.4
-- How does order demand change over time?
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    COUNT(order_id) AS order_volume
FROM orders
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;

-- QUESTION 4.1.5
-- Which delivery zones contribute the highest order value?
SELECT
    delivery_zone_id,
    COUNT(order_id) AS order_volume,
    ROUND(SUM(total_value), 2) AS total_order_value
FROM orders
GROUP BY delivery_zone_id
ORDER BY total_order_value DESC;


-- 4.2 UNDERSTAND CUSTOMER ORDER BEHAVIOUR

-- QUESTION 4.2.1
-- Which customers have the highest number of orders?
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY order_count DESC;
 
 -- QUESTION 4.2.2
-- Which customers have the highest cumulative order value?
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(o.total_value), 2)
        AS cumulative_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY cumulative_order_value DESC;
 
 -- QUESTION 4.2.3
-- How does customer activity differ across delivery zones?
SELECT
    c.delivery_zone_id,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.delivery_zone_id
ORDER BY order_count DESC;

-- QUESTION 4.2.4
-- How do Business and Individual customers differ in ordering activity?
SELECT
    c.customer_type,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(o.order_id) AS order_count,
    ROUND(SUM(o.total_value), 2)
        AS total_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_type
ORDER BY order_count DESC;

-- QUESTION 4.2.5
-- How do customer ordering patterns change over time?
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    c.customer_type,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date),
    c.customer_type
ORDER BY
    order_year,
    order_month,
    c.customer_type;
    
-- 4.3 EVALUATE DELIVERY PERFORMANCE

-- QUESTION 4.3.1
-- How do delivery outcomes differ across delivery zones?
SELECT
    o.delivery_zone_id,
    d.status,
    COUNT(d.delivery_id) AS delivery_count
FROM orders o
JOIN deliveries d
    ON o.order_id = d.order_id
GROUP BY
    o.delivery_zone_id,
    d.status
ORDER BY
    o.delivery_zone_id,
    delivery_count DESC;

-- QUESTION 4.3.2
-- What are the average delivery distance and delivery duration?
SELECT
    ROUND(AVG(distance_km), 2)
        AS average_distance_km,
    ROUND(AVG(delivery_duration_min), 2)
        AS average_delivery_duration
FROM deliveries;

-- QUESTION 4.3.3
-- How many deliveries are Delivered, Failed, Pending, and Rescheduled?
SELECT
    status,
    COUNT(*) AS delivery_count
FROM deliveries
GROUP BY status
ORDER BY delivery_count DESC;

-- QUESTION 4.3.4
-- Which zones have higher delivery activity or poorer outcomes?
SELECT
    o.delivery_zone_id,
    COUNT(d.delivery_id) AS total_deliveries,
    SUM(
        CASE
            WHEN d.status IN
                ('Failed', 'Pending', 'Rescheduled')
            THEN 1
            ELSE 0
        END
    ) AS problem_deliveries
FROM orders o
JOIN deliveries d
    ON o.order_id = d.order_id
GROUP BY o.delivery_zone_id
ORDER BY
    problem_deliveries DESC,
    total_deliveries DESC;

-- QUESTION 4.3.5
-- How does delivery performance change over time?
SELECT
    YEAR(actual_delivery_date) AS delivery_year,
    MONTH(actual_delivery_date) AS delivery_month,
    COUNT(delivery_id) AS delivery_count,
    ROUND(
        AVG(delivery_duration_min),
        2
    ) AS average_delivery_duration
FROM deliveries
WHERE actual_delivery_date IS NOT NULL
GROUP BY
    YEAR(actual_delivery_date),
    MONTH(actual_delivery_date)
ORDER BY
    delivery_year,
    delivery_month;
    
-- 4.4 UNDERSTAND DRIVER AND VEHICLE PERFORMANCE

-- QUESTION 4.4.1
-- Which drivers handled the highest number of deliveries?
SELECT
    dr.driver_id,
    dr.driver_name,
    COUNT(d.delivery_id) AS delivery_count
FROM drivers dr
JOIN deliveries d
    ON dr.driver_id = d.driver_id
GROUP BY
    dr.driver_id,
    dr.driver_name
ORDER BY delivery_count DESC;
--- QUESTION 4.4.2
-- How do driver delivery outcomes compare?
SELECT
    dr.driver_id,
    dr.driver_name,
    d.status,
    COUNT(d.delivery_id) AS delivery_count
FROM drivers dr
JOIN deliveries d
    ON dr.driver_id = d.driver_id
GROUP BY
    dr.driver_id,
    dr.driver_name,
    d.status
ORDER BY
    dr.driver_name,
    delivery_count DESC;
-- QUESTION 4.4.3
-- How does delivery duration differ across drivers?
SELECT
    dr.driver_id,
    dr.driver_name,
    COUNT(d.delivery_id) AS delivery_count,
    ROUND(
        AVG(d.delivery_duration_min),
        2
    ) AS average_delivery_duration
FROM drivers dr
JOIN deliveries d
    ON dr.driver_id = d.driver_id
GROUP BY
    dr.driver_id,
    dr.driver_name
ORDER BY average_delivery_duration DESC;

-- QUESTION 4.4.4
-- How is vehicle usage distributed across vehicle types?
SELECT
    v.vehicle_type,
    COUNT(d.delivery_id) AS delivery_count
FROM vehicles v
JOIN deliveries d
    ON v.vehicle_id = d.vehicle_id
GROUP BY v.vehicle_type
ORDER BY delivery_count DESC;

-- QUESTION 4.4.5
-- How does delivery performance differ across vehicle types?
SELECT
    v.vehicle_type,
    COUNT(d.delivery_id) AS delivery_count,
    ROUND(
        AVG(d.delivery_duration_min),
        2
    ) AS average_delivery_duration,
    ROUND(
        AVG(d.distance_km),
        2
    ) AS average_distance
FROM vehicles v
JOIN deliveries d
    ON v.vehicle_id = d.vehicle_id
GROUP BY v.vehicle_type
ORDER BY delivery_count DESC;

-- 4.5 IDENTIFY DELIVERY PROBLEMS

-- QUESTION 4.5.1
-- Which orders required multiple delivery attempts?
SELECT
    order_id,
    COUNT(*) AS delivery_attempt_count
FROM deliveries
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY delivery_attempt_count DESC;

-- QUESTION 4.5.2
-- What are the common delivery problem statuses?
SELECT
    status,
    COUNT(*) AS delivery_count
FROM deliveries
WHERE status IN
    ('Failed', 'Pending', 'Rescheduled')
GROUP BY status
ORDER BY delivery_count DESC;

-- QUESTION 4.5.3
-- Is delivery duration higher for deliveries requiring multiple attempts?
SELECT
    CASE
        WHEN delivery_attempt > 1
        THEN 'Multiple Attempts'
        ELSE 'Single Attempt'
    END AS attempt_category,
    COUNT(*) AS delivery_count,
    ROUND(
        AVG(delivery_duration_min),
        2
    ) AS average_delivery_duration
FROM deliveries
GROUP BY
    CASE
        WHEN delivery_attempt > 1
        THEN 'Multiple Attempts'
        ELSE 'Single Attempt'
    END
ORDER BY average_delivery_duration DESC;

-- QUESTION 4.5.4
-- Which delivery zones have more failed, pending, or rescheduled deliveries?
SELECT
    o.delivery_zone_id,
    d.status,
    COUNT(d.delivery_id) AS problem_count
FROM orders o
JOIN deliveries d
    ON o.order_id = d.order_id
WHERE d.status IN
    ('Failed', 'Pending', 'Rescheduled')
GROUP BY
    o.delivery_zone_id,
    d.status
ORDER BY problem_count DESC;

-- QUESTION 4.5.5
-- Is package weight associated with delivery duration?
SELECT
    CASE
        WHEN o.package_weight_kg <= 10
            THEN '0-10 kg'
        WHEN o.package_weight_kg <= 25
            THEN '10-25 kg'
        WHEN o.package_weight_kg <= 40
            THEN '25-40 kg'
        ELSE 'Above 40 kg'
    END AS weight_category,
    COUNT(d.delivery_id) AS delivery_count,
    ROUND(
        AVG(d.delivery_duration_min),
        2
    ) AS average_delivery_duration
FROM orders o
JOIN deliveries d
    ON o.order_id = d.order_id
GROUP BY
    CASE
        WHEN o.package_weight_kg <= 10
            THEN '0-10 kg'
        WHEN o.package_weight_kg <= 25
            THEN '10-25 kg'
        WHEN o.package_weight_kg <= 40
            THEN '25-40 kg'
        ELSE 'Above 40 kg'
    END
ORDER BY average_delivery_duration DESC;
