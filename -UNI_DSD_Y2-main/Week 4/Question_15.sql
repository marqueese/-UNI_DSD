--Q15. Design and write one SQL query using at least four tables, where at least one filter 
--(σ) and one projection (π) are required. Then, draw the query tree labelling each Root, Node, and Leaf.

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

--Query 
SELECT
    c.customer_name,
    p.product_name,
    o.order_date,
    od.quantity
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
WHERE c.city = 'London' AND p.category = 'Electronics';

π c.customer_name, p.product_name, o.order_date, od.quantity
                            ¦
                od.product_id = p.product_id
                            ¦
                    /                   \
    ⋈ o.order_id = od.order_id      σ p.category = 'Electronics'
                ¦                                  ¦
    ⋈ c.customer_id = o.customer_id            Products
               ¦              \ 
    σ c.city = 'London'        Orders
            ¦                      ¦
        Customers                 OrderDetails


