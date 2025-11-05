--Q4.	Using the provided ERD and Data Dictionary, create a query that will return all the movie titles that are in the Documentary category. 
--Create 2 versions of the same query and in one use category as string (‘documentary’) and in the other use category ID (you will need to check what is the category ID for Documentary). Use the EXPLAIN ANALYZE command and see which query performs better? Why? 


EXPLAIN ANALYZE SELECT 
    m.title as "Film Name",
    c.name as "Category name"
FROM movie m
JOIN movie_category mc ON m.movie_id = mc.movie_id
JOIN category c ON mc.category_id = c.category_id
WHERE c.name = 'Documentary';

EXPLAIN ANALYZE SELECT 
    m.title as "Film Name",
    c.name as "Category name"
FROM movie m
JOIN movie_category mc ON m.movie_id = mc.movie_id
JOIN category c ON mc.category_id = c.category_id
WHERE c.category_id = '6';