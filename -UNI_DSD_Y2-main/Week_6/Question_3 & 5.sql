--Apply an INDEX on the  phone attribute. 
CREATE INDEX phone ON address(phone);

SELECT * FROM pg_indexes WHERE tablename = 'address';


--Q5.	Delete the INDEX you have created in Q3. 

DROP INDEX phone;