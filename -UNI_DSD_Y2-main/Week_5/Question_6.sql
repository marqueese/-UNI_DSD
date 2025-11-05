--Q6.	List how many movies are in each category per original language. The output should be similar to the one below.

SELECT 
    c.name AS "Category Name",
    l.name AS "Language",
    COUNT(m.movie_id) AS "Number of Movies"
FROM movie m
JOIN movie_category mc ON m.movie_id = mc.movie_id
JOIN category c ON mc.category_id = c.category_id
JOIN language l ON m.original_language_id = l.language_id
GROUP BY c.name, l.name
ORDER BY c.name, l.name;
