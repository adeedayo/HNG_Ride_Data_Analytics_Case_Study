-- For each driver, calculate their average monthly rides since signup. Who are the top 5 drivers with the highest consistency (most rides per active month)?

WITH driver_activity AS (
    SELECT 
        d.driver_id,
        d.name,
        d.signup_date,
        COUNT(r.ride_id) AS total_rides,
        MAX(r.dropoff_time) AS last_ride_date
    FROM drivers_raw d
    JOIN rides_raw r 
        ON d.driver_id = r.driver_id
    WHERE r.status = 'completed'
    GROUP BY d.driver_id, d.name, d.signup_date
),
activity_calc AS (
    SELECT 
        driver_id,
        "name",
        total_rides,
        signup_date,
        last_ride_date,
        GREATEST(
            (EXTRACT(YEAR FROM AGE(last_ride_date, signup_date)) * 12) +
            EXTRACT(MONTH FROM AGE(last_ride_date, signup_date)),
            1
        ) AS active_months
    FROM driver_activity
)
SELECT 
    driver_id,
    "name",
    total_rides,
    active_months,
    ROUND(total_rides::numeric / active_months, 2) AS avg_rides_per_month
FROM activity_calc
ORDER BY avg_rides_per_month DESC
LIMIT 5;

