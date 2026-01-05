-- USER ENGAGEMENT DAILY FACT TABLE
WITH ratings AS(
    SELECT *
    FROM {{ ref('stg_ratings') }}
),
agg AS(
SELECT
    userid,
    DATE(timestamp) AS activity_date,
    COUNT(*) AS daily_ratings_count,
    COUNT(DISTINCT movieid) AS num_movies_rated,
    AVG(rating) AS avg_rating_given,
    MIN(rating) AS min_rating_given,
    MAX(rating) AS max_rating_given,
    DATE(MAX(timestamp)) AS last_activity_time
FROM ratings
GROUP BY userid, DATE(timestamp))
SELECT *,
    CASE WHEN TIMESTAMPDIFF(DAY, last_activity_time, CURRENT_DATE) <= 7 THEN TRUE ELSE FALSE END AS is_active_last_7_days
FROM agg