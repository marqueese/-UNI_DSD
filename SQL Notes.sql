SQL Notes

# aliases  SELECT first_name as "First Name", last_name as "Last Name" FROM users; 

# INSET INTO ___ - Add to a table
# SELECT __ FROM __ - Run a query
# ALTER TABLE ___ - Change table structure
#    ADD - Add a field (e.g., car color)
#    SET - Change stored data
#    ALTER COLUMN - Change column data (e.g., ALTER COLUMN ___ TYPE ___)
#    Change the data type of a column
#    DROP COLUMN ___ - Deletes the selected field

# DELETE FROM ___ WHERE field_name = stored data - Deletes specific rows
# DELETE FROM ___ - Clears a table
# DROP TABLE ___ - Deletes the table

# Search for certain characters
# SELECT * FROM ___ WHERE ___ LIKE '?%'

# LIKE '%M' - Case-sensitive match ending with 'M'
# ILIKE 'm%' - Case-insensitive match starting with 'm'
# LIKE '%m%' - Search whole cell for 'm'

# SELECT * FROM ___ WHERE year BETWEEN 2000 AND 2006 - Select rows within a range

# SELECT _ FROM ___ WHERE ___ IN ('', '', '') - Selects rows where data matches any in a list eg('it', 'sales') - if looking for departments
# SELECT _ FROM __ WHERE ___ NOT IN ('IT', 'Sales' ) - selects everything that is not it or sales
# ORDER BY name - Arranges results in alphabetical order

# ORDER BY year DESC/ASC - Arranges results in descending/ascending numerical order

# SELECT DISTINCT name FROM users - Selects unique values of the 'name' column

# LIMIT number of rows being selected
# SELECT * FROM users LIMIT 10

# Write data under a different name
# SELECT name AS user_name FROM user

# Listing by location with count
# SELECT COUNT(user_ID), location FROM users GROUP BY location

# SELECT min/max(age) FROM users - Get minimum/maximum value of 'age'

# COUNT rows - Each row with a user ID will be counted
# SELECT COUNT(user_ID) FROM users;

# SUM all numerical data in a column
# SELECT SUM(age) FROM users;

# COUNT all rows and get average
# SELECT AVG(age) FROM users;

# JOIN tables
# SELECT * FROM orders LEFT JOIN users ON orders.user_ID = users.user_ID
# or INNER JOIN where matching data exists in both tables

# use this when the columns have different names 
#SELECT col1, col2, col3 
FROM table_1 
JOIN table_2 
    on table_1.pk1_id = table_2.pk1_id


#use this when the columns have the same names
#SELECT col1, col2, col3 
FROM table_1 
JOIN table_2 
    USING (pk1_id)


# offset and limit 
SELECT _ FROM _ OFFSET 1 LIMIT 2;

#concat columns through queries - output  john smith 
# useful for making simplified diagrams or tables
SELECT CONCAT(staff_name, ' ', staff_last_name ) AS 'Staff Name' FROM staff; 

#concatenate with seperator display the data in one cell but seperated with the comma
SELECT CONCAT_WS(' ', staff_name, staff_last_name ) AS 'Staff Name' FROM staff; 

CREATE ROLE user_name;
GRANT FUNCTION on DATABASE TO user_name;
REVOKE SELECT ON databse FROM user_name;
DROP ROLE user_name;

NOLOGIN --  Not logged in
GRANT FUNCTION on staff_details TO staff;
CREATE user john WITH LOGIN PASSWORD 'password';
GRANT staff TO john;