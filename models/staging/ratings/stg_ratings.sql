WITH ratings AS(
SELECT *,
    
FROM {{source('ratings', 'RATINGS')}}
)
SELECT * FROM ratings