-- 1 Q1. Using linux specific commands (CLI) create a backup of the database movie_rental.
mkdir - p db_backup 
pg_dump movie_rental > db_backup/movie_rental_bk.sql

--Q2.	 Using linux specific commands (CLI) delete database movie_rental.  
dropdb movie_rental

--Q3.	 Using linux commands, restore your database from the backup. If you are encountering issues or for any reason you cannot restore the database from backup, make another clean installation of the database and start from Q1. 
createdb movie_rental
psql movie_rental < db_backup/movie_rental_bk.sql

--Q4.	 Now that the DB is restored, let's see which country has the most rented movies, so the manager will be able to create some marketing strategies. The manager would like to focus on the top 5. 
SELECT c.country, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN customer cu ON r.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country c ON ci.country_id = c.country_id
GROUP BY c.country
ORDER BY total_rentals DESC
LIMIT 5;


--The manager is a huge Sci-Fi genre fan and would like to find which customers have rented more than 2 movies from this genre. Also he would like to run some statistics over the city the customer is from and their contact details (phone and email). Order by city and customer name. 
SELECT 
    cu.first_name AS "First Name", 
    cu.last_name AS "Last Name", 
    a.phone AS "Phone", 
    cu.email AS "Email", 
    ci.city, COUNT(r.rental_id) AS "Total Sci-Fi Rentals"
FROM rental r
JOIN customer cu ON r.customer_id = cu.customer_id
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN movie f ON i.movie_id = f.movie_id
JOIN movie_category mc ON f.movie_id = mc.movie_id
JOIN category c ON mc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
GROUP BY cu.customer_id, a.phone, ci.city
HAVING COUNT(r.rental_id) > 2
ORDER BY ci.city, cu.first_name, cu.last_name;

--The business is on the right track, however it seems that in May a particular movie was quite popular generating a high revenue. What movie was and what was the amount generated?  
SELECT 
    m.title AS "Movie Title", 
    SUM(p.amount) AS "Total Revenue"
FROM payment_p2022_05 p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN movie m ON i.movie_id = m.movie_id
GROUP BY m.title
ORDER BY "Total Revenue" DESC
LIMIT 1;

--Now the manager wants to have a closer look at the general business income. He would like to see the top 5 categories total gross  revenue for January per category. 
SELECT 
    c.name AS "Category", 
    SUM(p.amount) AS "Total Revenue"
FROM payment_p2022_01 p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN movie_category mc ON i.movie_id = mc.movie_id
JOIN category c ON mc.category_id = c.category_id
GROUP BY c.name
ORDER BY "Total Revenue" DESC
LIMIT 5;


