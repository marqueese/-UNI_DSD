--C1 - Using subqueries, list the concatenated first name and last name along with the email address - as a separate column - of all customers that have rented an action movie. 
--List them in alphabetical order first name then last name. 

CREATE OR REPLACE VIEW customer_rentals AS
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS "Customer",
    c.email AS "Customer Email"
FROM customer c 
WHERE c.customer_id 



CREATE OR REPLACE VIEW customer_rentals AS
-- Select customer full name and email
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS "Customer", -- Combine first and last name add email 
    c.email AS "Customer Email" 
FROM customer c
WHERE c.customer_id IN ( -- Filter customers who have rented an Action movie
    SELECT r.customer_id
    FROM rental r
    WHERE r.inventory_id IN (-- Get inventory IDs for the movies rented
        SELECT i.inventory_id
        FROM inventory i
        WHERE i.movie_id IN (-- Get movie IDs for movies that belong to the "Action" category
            SELECT m.movie_id
            FROM movie m
            WHERE m.movie_id IN (-- Get movie IDs linked to the "Action" category in the movie_category table
                SELECT fc.movie_id
                FROM movie_category fc
                WHERE fc.category_id IN (-- Get the category ID for 'Action' movies
                    SELECT cat.category_id
                    FROM category cat
                    WHERE cat.name = 'Action'
                )
            )
        )
    )
)
ORDER BY c.first_name, c.last_name;
