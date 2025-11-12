--Q7.	Using a subquery list all cities from the United Kingdom along with the city ID.
--As an extension of the previous query, list the cities from the United Kingdom and France using the IN operator, this time showing the country name as well. Group them by country.
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS "Customer",
    CONCAT(c.email, ' | ', a.phone) AS "Contact Details",
    a.address AS "Customer Address",
    ci.city AS "Customer City",
    co.country AS "Customer Country"
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country_id IN (
    SELECT country_id
    FROM country
    WHERE country IN ('United Kingdom', 'France') --use in for multiple conditions
)
ORDER BY co.country, ci.city;
