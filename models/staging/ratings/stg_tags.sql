WITH tags AS(
SELECT *
FROM {{source('ratings', 'TAGS')}}
)
SELECT * FROM tags