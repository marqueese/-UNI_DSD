--Q7.	Using a subquery list all cities from the United Kingdom along with the city ID.
--As an extension of the previous query, list the cities from the United Kingdom and France using the IN operator, this time showing the country name as well. Group them by country.
SELECT
<<<<<<< HEAD
    ci.city_id AS "City ID",
=======
>>>>>>> 82fa4158c364aadfb0b8f15f4cfe35a6315fe808
    ci.city AS "Customer City",
    co.country AS "Customer Country"
FROM city ci
JOIN country co ON ci.country_id = co.country_id
WHERE co.country_id IN (
    SELECT country_id 
    FROM country
    WHERE country IN ('United Kingdom', 'France') --use in for multiple conditions
)
ORDER BY co.country, ci.city;

