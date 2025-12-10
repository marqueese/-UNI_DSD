--List id, first name and last name of all actors that have the first name as Scarlett. The query should ignore the name capitalisation. 
--Hint: Look for the ILIKE/LIKE keywords or wildcard characters. 


SELECT 
    CONCAT (a.first_name,' ',a.last_name) as "Actors Name"
FROM actor a 
WHERE a.first_name
ILIKE '%scarlett%';


--How many unique last names are in actors' names? (e.g. If they are 3 Smith’s will be counted only once).  

SELECT DISTINCT
    a.last_name as "Actors Surname",
    COUNT(a.actor_id) "Number of Shared surnames"
FROM actor a
GROUP BY a.last_name;

--Following from the previous query, we know how many unique  last names are in the database. However, how many of them are appearing only once? E.g. OLIVIER  will be twice, so is not that unique, but PESCI will be only once making truly unique. List all the true unique names)  
--List in alphabetical order the last names that are repeated only once (e.g. if a last name is more than once  in the database it will not be considered).


SELECT DISTINCT
    a.last_name as "Actors Surname",
    COUNT(a.actor_id) "Number of Shared surnames"
FROM actor a
GROUP BY a.last_name
HAVING COUNT(*) = 1 -- limits it to one exaclt 
ORDER BY a.last_name;


--Q4.	List the first name and last name of the actor that appear in most movies and the number of movies. Hint: Look for USING. 
SELECT 
    CONCAT (a.first_name,' ',a.last_name) as "Actors Name",
    COUNT(m.movie_id) AS "Number of movies"
FROM actor a 
JOIN movie_actor ma on a.actor_id = ma.actor_id
JOIN movie m ON ma.movie_id = m.movie_id
GROUP BY a.actor_id;


SELECT 
    CONCAT (a.first_name,' ',a.last_name) as "Actors Name",
    m.movie_id AS "ID"
FROM actor a 
JOIN movie_actor ma on a.actor_id = ma.actor_id
JOIN movie m ON ma.movie_id = m.movie_id
WHERE a.first_name = 'ADAM' AND a.last_name = 'GRANT';
--ADAM GRANT   -- testing its correct 


--Q5.	Each store has several copies of each movie. List the available store 1 inventory for the movie named ‘Purple Movie’. How many copies are available and what are the inventory IDs?
SELECT 
    m.title AS "Movie Title",
    COUNT(i.inventory_id) AS "Number of Copies",
    STRING_AGG(i.inventory_id::text, ', ') AS "Inventory IDs" --converrs the id to text trust stackoverflow 
FROM inventory i
JOIN movie m ON i.movie_id = m.movie_id
WHERE m.title = 'PURPLE MOVIE'
  AND i.store_id = 1
GROUP BY m.title;




--Q6.	List staff name and last name, along with their home address, city and email address. The data should be  presented in a nice format (exactly as below). 

SELECT
    CONCAT (s.first_name,' ',s.last_name) AS "Staff Name",
    a.address AS "Staff Address",
    c. city AS "Staff City",
    s.email AS "Staff Email"
FROM staff s 
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id;


--Q7.	List the name and the last name in alphabetical order (on surname) of all actors that have acted in the movie named ‘Agent Truman’. The names should appear in a single column just the name of the actors, not the movie.  

SELECT
    CONCAT(a.first_name, ' ', a.last_name) AS "Actors Name"
FROM actor a
JOIN movie_actor ma ON a.actor_id = ma.actor_id
JOIN movie m ON ma.movie_id = m.movie_id
WHERE m.title ILIKE '%Agent Truman%'
GROUP BY a.actor_id
ORDER BY a.last_name;

SELECT * FROM movie WHERE title ILIKE '%Agent%';
--Check the movie exists 


--C1. - Question 7 displays a column of all actors in a movie, which is  not well formatted. 
--List the movie “Agent Truman” and all the actors as one row. The output should be exactly as below. 
--Hint: look for arrays and strings display.  

SELECT
    m.title AS "Movie Title",
    STRING_AGG(a.first_name || ' ' || a.last_name, ', ') AS "Actors in the movie" --for some stupid reason it doesnt like commas 
FROM actor a
JOIN movie_actor ma ON a.actor_id = ma.actor_id
JOIN movie m ON ma.movie_id = m.movie_id
WHERE m.title ILIKE '%Agent Truman%'
GROUP BY m.movie_id, m.title
ORDER BY m.title;
