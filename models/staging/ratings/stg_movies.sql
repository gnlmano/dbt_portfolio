WITH movies AS(
SELECT
    MOVIEID,
    -- Get year out of title and remove it from title
    TRY_TO_NUMBER(NULLIF(REGEXP_SUBSTR(title, '\\(([0-9]{4})\\)\\s*$', 1, 1, 'e', 1), '')) AS RELEASE_YEAR,
    -- Clean title by removing year suffix
    TRIM(REGEXP_REPLACE(title, '\\s*\\(\\d{4}\\)$', '')) AS TITLE,
    SPLIT(genres, '|') AS GENRE_ARRAY,
FROM {{source('ratings', 'MOVIES')}}
)
SELECT * FROM movies
