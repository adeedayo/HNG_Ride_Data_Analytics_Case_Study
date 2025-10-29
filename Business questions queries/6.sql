-- Identify riders who have taken more than 10 rides but never paid with cash.

WITH cash_riders AS (
    SELECT DISTINCT r.rider_id
    FROM rides_raw r
    JOIN payments_raw p 
        ON r.ride_id = p.ride_id
    WHERE p.method = 'cash'
      AND p.amount > 0
),
completed_rides AS (
    SELECT 
        r.rider_id,
        COUNT(DISTINCT r.ride_id) AS total_rides
    FROM rides_raw r
    JOIN payments_raw p 
        ON r.ride_id = p.ride_id
    WHERE p.amount > 0
    GROUP BY r.rider_id
)
SELECT 
    c.rider_id,
    c.total_rides
FROM completed_rides c
WHERE c.total_rides > 10
  AND c.rider_id NOT IN (SELECT rider_id FROM cash_riders)
ORDER BY c.total_rides DESC;

