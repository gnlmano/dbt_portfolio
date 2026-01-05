-- If a new rating is submitted for a movie, we want to update the average rating and number of ratings ONLY for that movie.

{{config(
    materialized='incremental',
    unique_key='movieid',
    incremental_strategy='merge'
)}}

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
        CAST(r.timestamp AS TIMESTAMP_NTZ) AS rating_ts
    FROM movies m
    LEFT JOIN ratings r
      ON m.movieid = r.movieid
)

SELECT
    MOVIEID,
    TITLE,
    RELEASE_YEAR,
    GENRE_ARRAY,
    DATE(MAX(rating_ts)) AS LATEST_REVIEW_DATE,
    DATE(MIN(rating_ts)) AS FIRST_REVIEW_DATE,
    MAX(rating_ts) AS last_review_ts,
    ROUND(AVG(RATING), 2) AS AVG_RATING,
    COUNT(RATING) AS NUM_RATINGS
FROM joined

{% if is_incremental() %}
WHERE rating_ts >= (
    SELECT DATEADD(day, -1, MAX(last_review_ts))
    FROM {{ this }}
    )
{% endif %}

GROUP BY MOVIEID, TITLE, RELEASE_YEAR, GENRE_ARRAY
