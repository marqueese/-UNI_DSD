CREATE OR REPLACE VIEW customer_Details AS 
SELECT
    CONCAT_WS(c.first_name , c.last_name) AS "Customer",
    CONCAT_WS(c.email,'¦',a.phone) AS "Contact Details",
    a.address AS "Customer Address",
    c.city AS "Customer City",
    co.country AS "Customer Country"