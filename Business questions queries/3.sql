Which quarter had the biggest YoY growth?

WITH quarterly_revenue AS (
  SELECT
    EXTRACT("YEAR" FROM paid_date)::INT AS "year",
    EXTRACT(QUARTER FROM paid_date)::INT AS quarter,
    SUM(amount) AS total_revenue
  FROM payments_raw
  WHERE amount > 0
  GROUP BY 1, 2
),
yoy AS (
  SELECT
    cur.year,
    cur.quarter,
    cur.total_revenue AS revenue_current,
    prev.total_revenue AS revenue_prev,
    (cur.total_revenue - COALESCE(prev.total_revenue, 0)) AS revenue_change,
    ROUND(
      ((cur.total_revenue - COALESCE(prev.total_revenue, 0)) 
        / NULLIF(prev.total_revenue, 0)) * 100
    , 2) AS yoy_growth_percent
  FROM quarterly_revenue cur
  LEFT JOIN quarterly_revenue prev
    ON cur.quarter = prev.quarter
   AND cur.year = prev.year + 1
)
SELECT *
FROM yoy
ORDER BY yoy_growth_percent DESC NULLS LAST
LIMIT 1;
