CREATE OR REPLACE IF EXIST VIEW lowest_pop AS
SELECT 
    country as "Country Name",
    country_population as "Population Count"
FROM country
WHERE region = 'Southern Europe'
ORDER BY country_population ASC 
LIMIT 1;

--location italy


CREATE OR REPLACE IF EXIST VIEW language_spoken AS
SELECT 
    cl.country_code AS "Country Code",
    cl.language AS "Spoken Language"
FROM country_language cl
JOIN country c ON c.country_code = cl.country_code
WHERE c.country_name = 'Holy See (Vatican City State)';

SELECT 
    country as "Country Name",
    country_population as "Population Count"
FROM country
WHERE 
ORDER BY country_population ASC 
LIMIT 1;