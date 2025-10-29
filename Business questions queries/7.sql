-- Find the top 3 drivers in each city by total revenue earned between June 2021 and Dec 2024. If a driver has multiple cities, count revenue where they picked up passengers in that city.

WITH driver_revenue AS (
    SELECT 
        r.driver_id,
        r.pickup_city,
        SUM(p.amount) AS total_revenue
    FROM rides_raw r
    JOIN payments_raw p 
        ON r.ride_id = p.ride_id
    WHERE p.amount > 0
      AND p.paid_date BETWEEN '2021-06-01' AND '2024-12-31'
    GROUP BY r.driver_id, r.pickup_city
),
ranked_drivers AS (
    SELECT 
        pickup_city,
        driver_id,
        total_revenue,
        RANK() OVER (PARTITION BY pickup_city ORDER BY total_revenue DESC) AS city_rank
    FROM driver_revenue
)
SELECT 
    pickup_city,
    driver_id,
    total_revenue
FROM ranked_drivers
WHERE city_rank <= 3
ORDER BY pickup_city, city_rank;

