--Q1.	 List all the functions available in the movie_rental database.  
\df 


--In the database is a function (movie_in_stock), with two INT parameters (p_movie_id and p_store_id ), that will return all available copies of a given movie in a particular store. Using the named function, find the number of copies of the movie Named  “Angels Life” in store 1. 
SELECT movie_in_stock(
    (SELECT movie_id FROM movie WHERE title = 'ANGELS LIFE' LIMIT 1),
    1
) AS "Available Copies";


--Create a stored procedure (sp_add_new_actor) that will automatically insert a new actor.Insert your own name through stored procedure CALL e.g.  CALL sp_add_new_actor('Val', 'Adamescu'); 
--You don’t need to allocate any ID as is automatically added by SERIAL PK and the last_update is automatically updated by another function. The procedure should take only two parameters (First Name & Last Name).  
CREATE OR REPLACE PROCEDURE sp_add_new_actor(
    p_first_name VARCHAR,
    p_last_name VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO actor (first_name, last_name)
    VALUES (p_first_name, p_last_name);
END;
$$;


--Q4.	 Create a new column in the country table named country_code as VARCHAR. 
ALTER TABLE country
ADD COLUMN country_code VARCHAR;


--oops, my bad.. CHAR(2)  data type will be more efficient. Modify the country_code from VARCHAR to CHAR(2) and to have only unique values for the column country_code. Use \d country and take a screenshot of the table details.   

ALTER TABLE country 
ALTER COLUMN country_code TYPE CHAR(2);


--Now if everything is ready, insert the country code as UK for the United Kingdom and create the output as country id, country name and country code.  
UPDATE country
SET country_code = 'UK'
WHERE country = 'United Kingdom';

SELECT 
    country_id AS "Country ID", 
    country AS "Country Name", 
    country_code AS "Country Code"
FROM country
WHERE country = 'United Kingdom';


--Q7.	 We are planning some migration of our data but we don’t want to transfer everything. Create a new table (new_staff) and copy only  id, first & last name and email address.  

CREATE TABLE new_staff AS
SELECT 
    staff_id AS id, 
    first_name, 
    last_name, 
    email
FROM staff;

--Q8.	 We have so many copies of each movie for rental but how many? The output of the movies in inventory must be exactly as below. Column naming, text formatting, number of copies starting from the movies with most copies until the ones with less copies.   

SELECT 
    m.title AS "Movie Title", 
    COUNT(i.inventory_id) AS "Number of Copies"
FROM movie m
JOIN inventory i ON m.movie_id = i.movie_id
GROUP BY m.title
ORDER BY "Number of Copies" DESC, m.title ASC;


--Q9.	What is the average movie length per category? Round it to the nearest two decimal places  in descending order as  below.

SELECT 
    c.name AS "Category", 
    ROUND(AVG(m.length), 2) AS "Average Movie Length"
FROM category c
JOIN movie_category mc ON c.category_id = mc.category_id
JOIN movie m ON mc.movie_id = m.movie_id
GROUP BY c.name
ORDER BY "Average Movie Length" DESC;

--Q10.	We know that the average length of all movies is 115.27. Which categories have movies above average? Do not use LIMIT but select only categories that are above the average in descending order and rounded to nearest two decimal places.

SELECT 
    c.name AS "Category", 
    ROUND(AVG(m.length), 2) AS "Average Movie Length"
FROM category c
JOIN movie_category mc ON c.category_id = mc.category_id
JOIN movie m ON mc.movie_id = m.movie_id
GROUP BY c.name
HAVING AVG(m.length) > 115.27
ORDER BY "Average Movie Length" DESC;
