select *from drivers_raw;
select *from payments_raw;
select *from riders_raw;
select *from rides_raw;

ALTER TABLE drivers_raw
ALTER COLUMN signup_date TYPE TIMESTAMP WITHOUT TIME ZONE
USING signup_date AT TIME ZONE 'UTC';

-- Data cleaning
-- Check for duplicates in drivers_raw - remove if present
WITH ranked AS(
	SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY "name", city, signup_date, rating
		ORDER BY driver_id
	) AS row_num
FROM drivers_raw
)
SELECT *
FROM ranked
WHERE row_num > 1;

-- Check for duplicates in payments_raw - remove if present
WITH ranked AS(
	SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY ride_id, amount, "method", paid_date
		ORDER BY payment_id
	) AS row_num
FROM payments_raw
)
SELECT *
FROM ranked
WHERE row_num > 1;

-- Check for duplicates in riders_raw - remove if present
WITH ranked AS(
	SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY "name", signup_date, city, email
		ORDER BY rider_id
	) AS row_num
FROM riders_raw
)
SELECT *
FROM ranked
WHERE row_num > 1;

-- Check for duplicates in rides_raw - remove if present
WITH ranked AS(
	SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY rider_id, driver_id, request_time, pickup_time, 
		dropoff_time, pickup_city, dropoff_city, distance_km, status, fare
		ORDER BY ride_id
	) AS row_num
FROM rides_raw
)
SELECT *
FROM ranked
WHERE row_num > 1;

-- Handling missing values
-- drivers_raw
SELECT 
    SUM(CASE WHEN driver_id IS NULL THEN 1 ELSE 0 END) AS driver_id_nulls,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name_nulls,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city_nulls,
    SUM(CASE WHEN signup_date IS NULL THEN 1 ELSE 0 END) AS signup_date_nulls,
    SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS rating_nulls
FROM drivers_raw;

-- payments_raw
SELECT 
    SUM(CASE WHEN payment_id IS NULL THEN 1 ELSE 0 END) AS payment_null,
    SUM(CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END) AS ride_nulls,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS amount_nulls,
    SUM(CASE WHEN "method" IS NULL THEN 1 ELSE 0 END) AS method_nulls,
    SUM(CASE WHEN paid_date IS NULL THEN 1 ELSE 0 END) AS paid_date_nulls
FROM payments_raw;

-- riders_raw
SELECT 
    SUM(CASE WHEN rider_id IS NULL THEN 1 ELSE 0 END) AS rider_id_nulls,
    SUM(CASE WHEN "name" IS NULL THEN 1 ELSE 0 END) AS name_nulls,
    SUM(CASE WHEN signup_date IS NULL THEN 1 ELSE 0 END) AS signup_date_nulls,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city_nulls,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS email_nulls
FROM riders_raw;

-- rides_raw
SELECT 
    SUM(CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END) AS ride,
    SUM(CASE WHEN rider_id IS NULL THEN 1 ELSE 0 END) AS rider,
    SUM(CASE WHEN driver_id IS NULL THEN 1 ELSE 0 END) AS driver,
    SUM(CASE WHEN request_time IS NULL THEN 1 ELSE 0 END) AS request,
    SUM(CASE WHEN pickup_time IS NULL THEN 1 ELSE 0 END) AS pickup_time,
	SUM(CASE WHEN dropoff_time IS NULL THEN 1 ELSE 0 END) AS dropoff_time,
	SUM(CASE WHEN pickup_city IS NULL THEN 1 ELSE 0 END) AS pickup_city,
	SUM(CASE WHEN dropoff_city IS NULL THEN 1 ELSE 0 END) AS dropoff_city,
	SUM(CASE WHEN distance_km IS NULL THEN 1 ELSE 0 END) AS distance,
	SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS status,
	SUM(CASE WHEN fare IS NULL THEN 1 ELSE 0 END) AS fare	
FROM rides_raw;

select *from drivers_raw;
select *from payments_raw;
select *from riders_raw;
select *from rides_raw;

-- Check for inconsistencies in data
select distinct city
from drivers_raw;

select distinct "method"
from payments_raw;

select distinct city
from riders_raw;

select distinct pickup_city
from rides_raw;

select distinct dropoff_city
from rides_raw;

-- Clean cities
UPDATE drivers_raw
SET city = CASE 
    WHEN city = 'S.F' THEN 'San Francisco'
    WHEN city = 'N.Y' THEN 'New York'
    WHEN city = 'L.A' THEN 'Los Angeles'
    ELSE city
END;

UPDATE rides_raw
SET pickup_city = CASE 
    WHEN pickup_city = 'N.Y' THEN 'New York'
    WHEN pickup_city = 'L.A' THEN 'Los Angeles'
    ELSE pickup_city
END;

UPDATE rides_raw
SET dropoff_city = CASE 
    WHEN dropoff_city = 'S.F' THEN 'San Francisco'
    ELSE dropoff_city
END;

UPDATE riders_raw
SET city = CASE 
    WHEN city = 'S.F' THEN 'San Francisco'
    WHEN city = 'N.Y' THEN 'New York'
    WHEN city = 'L.A' THEN 'Los Angeles'
    ELSE city
END;

-- Clean payment method
UPDATE payments_raw
SET "method" = CASE 
    WHEN "method" = 'pay pal' THEN 'paypal'
    ELSE "method"
END;

-- Clean status
UPDATE rides_raw
SET status = 'completed'
WHERE status = 'complted';

-- Handle negative values in amount (payments_raw) and fare (rides_raw)

SELECT *
FROM payments_raw
WHERE amount < 0;

SELECT *
FROM rides_raw
WHERE fare < 0;

SELECT * FROM drivers_raw;


