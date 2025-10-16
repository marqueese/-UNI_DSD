CREATE OR REPLACE IF EXIST VIEW lowest_pop AS
SELECT 
    country as "Country Name",
    country_population as "Population Count"
FROM country
WHERE region = 'Southern Europe'
ORDER BY country_population ASC 
LIMIT 1;
--location vatican city

CREATE OR REPLACE IF EXIST VIEW language_spoken AS
SELECT language
FROM countrylanguage
WHERE country_code = (
  SELECT country_code FROM country WHERE name = 'Vatican City'
)
AND isofficial = TRUE;
--language spoken in vatican city 

CREATE OR REPLACE IF EXIST VIEW italian_only AS
SELECT name
FROM country
WHERE code IN (
  SELECT country_code
  FROM countrylanguage
  GROUP BY country_code
  HAVING COUNT(language) = 1
)
AND code IN (
  SELECT country_code FROM countrylanguage WHERE language = 'Italian'
);
--location italy

CREATE OR REPLACE IF EXIST VIEW milan AS
SELECT city_name, country_code
FROM city
WHERE city_name ILIKE 'Mila%';
--location milan
ecuador_capital
CREATE OR REPLACE IF EXIST VIEW  AS
SELECT city_name
FROM city
WHERE country_code = 'ECU'
AND city_id = (
  SELECT capital FROM country WHERE code = 'ECU'
);
--location quito

CREATE OR REPLACE IF EXIST VIEW san_marino AS
SELECT city_name, country_code, population
FROM city
WHERE population = 91084;
--location san marino

