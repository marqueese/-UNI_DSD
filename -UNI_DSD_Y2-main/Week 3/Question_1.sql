CREATE TABLE actor(
    actor_id SERIAL PRIMARY KEY,
    actor_name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS languages;

CREATE TABLE languages(
    language_id SERIAL PRIMARY KEY,
    language_name VARCHAR(50) NOT NULL
);

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS film;

CREATE TABLE film(
    film_id SERIAL PRIMARY KEY,
    actor_id INT,
    language_id INT,
    category_id INT,
    film_name VARCHAR(50) NOT NULL,
    film_duration VARCHAR(20) NOT NULL,
    release_year VARCHAR (4) NOT NULL, 
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (language_id) REFERENCES languages(language_id)
);


INSERT INTO actor(actor_name)
VALUES
('Brad Pitt'),
('Ryan Reynolds'),
('Bruce Lee'),
('Carmen Electra'),
('Margot Robbie'),
('Scarlett Johansson');

INSERT INTO languages(language_name)
VALUES
('English'),
('German'),
('French'),
('Chinese');

INSERT INTO category(category_name)
VALUES
('Thriller'),
('Action'),
('Christmas'),
('Drama'),
('Sci-Fi'),
('Superhero');

INSERT INTO film(actor_id, language_id, category_id, film_name, film_duration, release_year)
VALUES
(1, 1, 2, 'Bullet Train', '127 min', 2022),
(1, 2, 2, 'Bullet Train', '127 min', 2022),
(1, 4, 2, 'Bullet Train', '127 min', 2022),
(2, 1, 6, 'Green Lantern', '135 min', 2011),
(2, 3, 6, 'Green Lantern', '135 min', 2011),
(3, 1, 2, 'The Way of the Dragon', '135 min', 1973),
(3, 4, 2, 'The Way of the Dragon', '135 min', 1973),
(4, 4, 2, 'Scary Movie 1', '115 min', 2005),
(4, 4, 2, 'The Way of the Dragon', '115 min ', 2005),
(5, 1, 5, 'Barbie', '114 min', 2023),
(6, 1, 2, 'Lucy', '89 min', 2014),
(6, 3, 5, 'Lucy', '89 min', 2014);
(1, 1, 1, 'Se7en', '127 min', '1995'),
(1, 2, 4, 'The Curious Case of Benjamin Button', '166 min', '2008'),
(1, 3, 5, 'Ad Astra', '123 min', '2019'),
(1, 4, 2, 'Troy', '163 min', '2004'),
(2, 1, 6, 'Deadpool', '108 min', '2016'),
(2, 2, 1, 'The Voices', '103 min', '2014'),
(2, 3, 4, 'The Proposal', '108 min', '2009'),
(2, 4, 5, 'Free Guy', '115 min', '2021'),
(3, 1, 2, 'Enter the Dragon', '102 min', '1973'),
(3, 2, 4, 'Fist of Fury', '106 min', '1972'),
(3, 3, 5, 'Game of Death', '100 min', '1978'),
(3, 4, 1, 'The Big Boss', '100 min', '1971'),
(4, 1, 3, 'Scary Movie 2', '83 min', '2001'),
(4, 2, 1, 'Baywatch: Hawaiian Wedding', '96 min', '2003'),
(4, 3, 2, 'Meet the Spartans', '87 min', '2008'),
(4, 4, 4, 'Date Movie', '83 min', '2006'),
(5, 1, 4, 'I, Tonya', '119 min', '2017'),
(5, 2, 6, 'Suicide Squad', '123 min', '2016'),
(5, 3, 5, 'Asteroid City', '104 min', '2023'),
(5, 4, 2, 'The Legend of Tarzan', '110 min', '2016'),
(6, 1, 6, 'Black Widow', '134 min', '2021'),
(6, 2, 5, 'Her', '126 min', '2013'),
(6, 3, 4, 'Marriage Story', '137 min', '2019'),
(6, 4, 2, 'Ghost in the Shell', '107 min', '2017');



--Queries 


--films released in rhe same year 
SELECT 
    f.film_name,
    f.release_year,
    (
        SELECT COUNT(*) 
        FROM film f2
        WHERE f2.release_year = f.release_year
    ) AS films_in_same_year
FROM film f;

--actors most recent film 
WITH ranked_films AS (
    SELECT 
        a.actor_name,
        f.film_name,
        f.release_year,
        ROW_NUMBER() OVER (PARTITION BY a.actor_id ORDER BY f.release_year::INT DESC) AS rn
    FROM film f
    JOIN actor a ON f.actor_id = a.actor_id
)
SELECT actor_name, film_name, release_year
FROM ranked_films
WHERE rn = 1;

--actors in multiple categories 

SELECT 
    a.actor_name,
    COUNT(DISTINCT f.category_id) AS category_count
FROM actor a
JOIN film f ON a.actor_id = f.actor_id
GROUP BY a.actor_name
HAVING COUNT(DISTINCT f.category_id) > 1;

--films in multiple languages
WITH film_language_count AS (
    SELECT 
        film_name,
        COUNT(DISTINCT language_id) AS language_count
    FROM film
    GROUP BY film_name
),
ranked_films AS (
    SELECT 
        film_name,
        language_count,
        RANK() OVER (ORDER BY language_count DESC) AS rank
    FROM film_language_count
)
SELECT * 
FROM ranked_films
WHERE rank <= 2;
