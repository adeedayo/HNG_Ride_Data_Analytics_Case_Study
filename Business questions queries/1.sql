select * from rides_raw;
-- Find the top 10 longest rides (by distance), including driver name, rider name, pickup/dropoff cities, and payment method.
SELECT 
	r.ride_id,
	r.distance_km,
	d.name AS driver_name,
	ri.name AS rider_name,
	r.pickup_city,
	r.dropoff_city,
	p.method AS payment_method
FROM rides_raw AS r
JOIN drivers_raw AS d
	ON r.driver_id = d.driver_id
JOIN riders_raw as ri
	ON r.rider_id = ri.rider_id
JOIN payments_raw p
	ON r.ride_id = p.ride_id
WHERE p.amount > 0	
ORDER BY r.distance_km DESC
LIMIT 10; 

