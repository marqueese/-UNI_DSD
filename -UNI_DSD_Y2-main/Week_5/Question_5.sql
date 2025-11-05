--Q5.	Using your SQL knowledge create a query that will list all movies that have original language Italian along with the release year. The movies should be listed by release year in chronological order.

SELECT 
    m.title as "Film Title",
    m.release_year as "Release Year"
FROM movie m
JOIN language l ON m.language_id = l.language_id
WHERE original_language_id = '2'
ORDER BY release_year ASC;