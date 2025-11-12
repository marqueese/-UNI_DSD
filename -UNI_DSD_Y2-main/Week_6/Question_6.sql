CREATE OR REPLACE VIEW customer_Details AS 
SELECT
    CONCAT(c.first_name,' ', c.last_name) AS "Customer",
    CONCAT(c.email, '  |  ', a.phone ) AS "Contact Details",
    a.address AS "Customer Address",
    ci.city AS "Customer City",
    co.country AS "Customer Country"
FROM customer c 
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
ORDER BY co.country ASC;