-- How many riders who signed up in 2021 still took rides in 2024?

SELECT COUNT(DISTINCT r.rider_id) AS active_riders
FROM riders_raw AS r
JOIN rides_raw AS ri
	ON r.rider_id = ri.rider_id
WHERE EXTRACT (YEAR from r.signup_date) = 2021
	AND EXTRACT (YEAR from ri.pickup_time) = 2024;