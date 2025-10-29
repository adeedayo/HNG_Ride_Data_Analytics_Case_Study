-- Top 10 drivers that are qualified to receive bonuses using the criteria below;
-- at least 30 rides completed, 
-- an average rating ≥ 4.5, and 
-- a cancellation rate under 5%. 

WITH completed_rides AS(
	SELECT 
		r.driver_id,
		COUNT(*) AS total_rides
	FROM rides_raw r
	JOIN payments_raw p
		ON r.ride_id = p.ride_id
	WHERE p.amount > 0 
	GROUP BY r.driver_id
),
driver_rating AS(
	SELECT 
		driver_id, 
		AVG(rating) as avg_rating
	FROM drivers_raw
	GROUP BY driver_id
	HAVING AVG(rating) >= 4.5
),
cancellation AS(
	SELECT 
    	driver_id,
    	SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_rides,
    	ROUND(
        	(SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END)::numeric / 
         	COUNT(*)) * 100, 
        	2
    	) AS cancellation_rate
	FROM rides_raw
	GROUP BY driver_id
)
SELECT
	dr.driver_id,
	dr.name,
	cr.total_rides,
	drt.avg_rating,
	c.cancelled_rides,
	c.cancellation_rate
FROM completed_rides cr
JOIN driver_rating drt
    ON cr.driver_id = drt.driver_id
JOIN cancellation c
    ON cr.driver_id = c.driver_id
JOIN drivers_raw dr
    ON cr.driver_id = dr.driver_id
WHERE cr.total_rides >= 30
  AND c.cancellation_rate < 5
ORDER BY drt.avg_rating DESC, cr.total_rides DESC
LIMIT 10;
	



