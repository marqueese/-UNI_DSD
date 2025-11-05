--The below SQL statement has five syntax errors. Can you identify them? What would be the correct statement to return exactly the same result as in Fig1? Write the correct SQL statement.
SELECT
movie_id AS "Movie ID",
movie_title AS Movie_Title
movie_lang AS 'LANGUAGE',
cat_name AS "Category"
FROM
movie
INNER JOIN category LINK movie.movie_id = category.movie_id
WHERE
movie_title = ALADDIN CALENDAR


SELECT
movie_id AS "Movie ID",
movie_title AS "Movie_Title",
movie_lang AS "LANGUAGE",
cat_name AS "Category"
FROM
movie
INNER JOIN category ON movie.movie_id = category.movie_id
WHERE
movie_title = 'ALADDIN CALENDAR';