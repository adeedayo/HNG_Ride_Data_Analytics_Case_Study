-- Calculate the cancellation rate per city and identify which city had the highest cancellation rate?

SELECT 
    pickup_city AS city,
    COUNT(*) AS total_rides,
    SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_rides,
    ROUND(
        (SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END)::numeric / 
         COUNT(*)) * 100, 
        2
    ) AS cancellation_rate_percent
FROM rides_raw
GROUP BY pickup_city
ORDER BY cancellation_rate_percent DESC
LIMIT 1;

