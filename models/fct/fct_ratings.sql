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
        YEAR(r.timestamp) AS rating_year,
        MONTH(r.timestamp) AS rating_month,
        DAY(r.timestamp) AS rating_day
    FROM movies m
    INNER JOIN ratings r
      ON m.movieid = r.movieid
)
SELECT *
FROM joined