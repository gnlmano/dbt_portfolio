SELECT 
    MOVIEID,
    RELEASE_YEAR,
    TITLE,
    GENRE_ARRAY
FROM {{ ref('stg_movies') }}


SELECT MOVIEID FROM {{ ref('stg_ratings') }}

SELECT * FROM {{ref('stg_movies')}} 
WHERE MOVIEID = 105191

SELECT * FROM {{ ref('stg_ratings') }}
WHERE MOVIEID = 105191