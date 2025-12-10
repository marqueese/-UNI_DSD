psql -U up2271401 -d movie_rental -c "CREATE ROLE junior_analyst LOGIN PASSWORD '5432';"

GRANT SELECT ON staff TO junior_analyst;
--note to self 
--go into the primary database being up2271401 then to movie_rentals then set permissions, its a bitch 
--tell val his powerpoint sucks ass 



psql -U up2271401 -d movie_rental -c "CREATE ROLE cashier LOGIN PASSWORD '5432';"
GRANT INSERT ON payment_p2022_01 TO cashier;
GRANT SELECT ON payment_p2022_01 TO cashier;

SELECT * FROM payment_p2022_01 LIMIT 10;


--q3

INSERT INTO payment_p2022_01(customer_id, staff_id, rental_id, amount, payment_date) VALUES (1, 1, 1, 5.99, CURRENT_TIMESTAMP);

--denied assumed because of foreign keys 

GRANT SELECT ON TABLE staff, rental, customer TO cashier;
GRANT SELECT ON TABLE payment TO cashier;

GRANT INSERT ON TABLE staff, rental, customer, payment_p2022_01, payment TO cashier;
GRANT INSERT ON payment_p2022_02 TO cashier;

--this bloody thing 
GRANT USAGE, UPDATE ON SEQUENCE payment_p2022_01_payment_id_seq TO cashier;

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (17000, CURRENT_DATE,  1,  1, NULL, 1, CURRENT_TIMESTAMP);

DELETE FROM rental WHERE rental_id = 17000; --didnt work 
GRANT DELETE ON rental TO cashier;


--Q4
psql -U up2271401 -d movie_rental -c "CREATE ROLE manager LOGIN PASSWORD '5432';" --create manager and sales
psql -U up2271401 -d movie_rental -c "CREATE ROLE sales LOGIN PASSWORD '5432';"

-- Allow manager to do all kinds of fun stuff
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE country TO manager WITH GRANT OPTION;

--login as manager 
psql -h localhost -p 5432 -U manager -d movie_rental

--login as sales 
psql -h localhost -p 5432 -U sales -d movie_rental

--give permission to sales 
GRANT UPDATE, SELECT ON country TO sales;


--Q5 
GRANT SELECT ON customer_view TO sales;

--Q6 
psql -U up2271401 -d movie_rental -c "CREATE ROLE admin LOGIN PASSWORD '5432';"

psql -U up2271401 -d movie_rental -c "CREATE ROLE valadam LOGIN PASSWORD '5432';"

psql -U up2271401 -d movie_rental -c "CREATE ROLE senior_analyst LOGIN PASSWORD '5432';"
-- As a superuser
ALTER ROLE role_name WITH CREATEDB;

-- Allow senior_analyst to create and drop tables in public schema
GRANT CREATE, USAGE ON SCHEMA public TO senior_analyst;

--senior_analyst login 
psql -h localhost -p 5432 -U senior_analyst -d movie_rental

CREATE TABLE new_table (
    id SERIAL PRIMARY KEY,
    info TEXT
);

DROP TABLE new_table;

SELECT * FROM customer;