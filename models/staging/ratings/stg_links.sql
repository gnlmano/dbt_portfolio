WITH links AS(
SELECT *
FROM {{source('ratings', 'LINKS')}}
)
SELECT * FROM links