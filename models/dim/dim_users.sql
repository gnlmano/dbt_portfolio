WITH ratings AS(
SELECT *
FROM {{ ref('stg_ratings') }}
),
agg AS(
SELECT
    userid,
    COUNT(DISTINCT rating) AS num_ratings,
    ROUND(AVG(rating), 2) AS avg_rating,
    MIN(DATE(timestamp)) AS first_rating_date,
    MAX(DATE(timestamp)) AS latest_rating_date,
    COUNT(DISTINCT DATE(timestamp)) AS active_days
FROM ratings
GROUP BY userid
)
SELECT * FROM agg