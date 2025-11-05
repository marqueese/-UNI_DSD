CREATE OR REPLACE IF EXIST VIEW lowest_pop AS
SELECT 
    country as "Country Name",
    country_population as "Population Count"
FROM country
WHERE region = 'Southern Europe'
ORDER BY country_population ASC 
LIMIT 1;
--location vatican city

SELECT cl.language
FROM country_language cl
JOIN country c ON cl.country_code = c.country_code
WHERE c.region = 'Southern Europe'
ORDER BY c.country_population
LIMIT 1;
--language spoken in vatican city 

SELECT c.country_name
FROM country c
JOIN country_language cl ON c.country_code = cl.country_code
WHERE cl.language = (
    SELECT cl.language
    FROM country_language cl
    JOIN country c ON cl.country_code = c.country_code
    WHERE c.region = 'Southern Europe'
    ORDER BY c.country_population
    LIMIT 1
)
GROUP BY c.country_name
HAVING COUNT(*) = 1;
--location san marino 

SELECT city_name
FROM city
WHERE country_code = (
    SELECT c.country_code
    FROM country c
    JOIN country_language cl ON c.country_code = cl.country_code
    GROUP BY c.country_code
    HAVING COUNT(*) = 1
)
AND city_name <> (
    SELECT country_name
    FROM country
    WHERE country_code = (
        SELECT c.country_code
        FROM country c
        JOIN country_language cl ON c.country_code = cl.country_code
        GROUP BY c.country_code
        HAVING COUNT(*) = 1
    )
);
--serravalle
    
SELECT city_name, country_code
FROM city
WHERE continent = 'South America'
AND city_name LIKE (
    SELECT LEFT(city_name, 4) || '%'
    FROM city
    WHERE country_code = (
        SELECT c.country_code
        FROM country c
        JOIN country_language cl ON c.country_code = cl.country_code
        GROUP BY c.country_code
        HAVING COUNT(*) = 1
    )
)
AND city_name NOT LIKE (
    SELECT city_name
    FROM city
    WHERE country_code = (
        SELECT c.country_code
        FROM country c
        JOIN country_language cl ON c.country_code = cl.country_code
        GROUP BY c.country_code
        HAVING COUNT(*) = 1
    )
);
--location serrana 

SELECT capital
FROM country
WHERE country_code = (
    SELECT country_code
    FROM city
    WHERE city_name = 'Serrana'
);
--brasillia

CREATE OR REPLACE IF EXIST VIEW san_marino AS
SELECT city_name, country_code, population
FROM city
WHERE population = 91084;
--location santa monica 


