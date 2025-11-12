--Connect to the movie_rental database (that you have installed in LAB5 ) and change the phone number from the current one to 02392844444 for address with id 100. Do not alter any other data/attribute.   

UPDATE address
SET phone = '02392844444'
WHERE address_id = 100;