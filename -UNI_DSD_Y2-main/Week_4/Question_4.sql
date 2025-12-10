--Q4 return all orders and shippers, displaying customer names when available.
CREATE OR REPLACE VIEW order_shippers AS
SELECT 
    o.order_id AS "Order ID",
    s.shipper_name AS "Shipper Name",
    c.customer_name AS "Customer Name"
FROM orders o
JOIN shippers s ON o.shipper_id = s.shipper_id
LEFT JOIN customers c ON o.customer_id = c.customer_id;