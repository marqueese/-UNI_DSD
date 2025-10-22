
--Q8 CREATE a query from the provided tree 
CREATE OR REPLACE VIEW electronics_sales AS
SELECT 
    p.name AS "Product Name",
    ca.category_name AS "Category Name",
    cu.customer_name AS "Customer Name"
FROM sales s
JOIN customers cu ON s.customer_id = cu.customer_id
JOIN products p ON s.product_id = p.product_id
JOIN categories ca ON p.category_id = ca.category_id
WHERE ca.category_name = 'Electronics';
