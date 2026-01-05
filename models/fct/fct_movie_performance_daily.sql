-- MOVIE ENGAGEMENT DAILY FACT TABLE
WITH movies AS(
    SELECT *
    FROM {{ref('stg_movies')}}
),
ratings AS(
    SELECT *
    FROM {{ ref('stg_ratings') }}
),
joined AS (
    SELECT 
        m.movieid,
        m.release_year,
        m.title,
        m.genre_array,
        r.userid,
        r.rating,
        DATE(r.timestamp) AS rating_date
    FROM movies m
    INNER JOIN ratings r
      ON m.movieid = r.movieid
),
agg AS(
SELECT
    movieid,
    release_year,
    title,
    COUNT(rating) AS num_ratings,
    MIN(rating) AS min_rating_given,
    MAX(rating) AS max_rating_given,
    ROUND(AVG(rating),2) AS avg_rating_given,
    DATE(MAX(rating_date)) AS last_rating_time
FROM joined
GROUP BY movieid, release_year, title, DATE(rating_date))
SELECT 
    *,
    CASE WHEN TIMESTAMPDIFF(DAY, last_rating_time, CURRENT_DATE) <= 7 THEN TRUE ELSE FALSE END AS received_ratings_last_7_days
FROM agg