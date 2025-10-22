--Q1 List all employees, their department, and the project they are assigned to.
CREATE OR REPLACE VIEW employee_project AS
SELECT 
    e.name AS "Employee Name",
    d.department AS "Department Name",
    p.Project name AS "Project Name"
FROM 
    employees e 
JOIN departments d ON e.dept_id = d.dept_id
JOIN projects p ON e.project_id = p.project_id;


--Q2.	Using same tables, display each department and the number of employees assigned, including departments with no employees.
CREATE OR REPLACE VIEW dept_employees AS
SELECT 
    d.department "Department Name",
    COUNT(DISTINCT e.emp_id) AS "Number of Employees"
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.department;


--Q3. Using same tables, list all departments in 'London' or 'Manchester' and their employees (if any).
CREATE OR REPLACE VIEW dept_location_employees AS
SELECT
    d.department AS "Department Name",
    e.name AS "Employee Name",
FROM departments d
LEFT JOIN employees e ON e.dept_id = d.dept_id
WHERE d.location IN ('London', 'Manchester');


--Q4 return all orders and shippers, displaying customer names when available.
CREATE OR REPLACE VIEW order_shippers AS
SELECT 
    o.order_id AS "Order ID",
    s.shipper_name AS "Shipper Name",
    c.customer_name AS "Customer Name"
FROM orders o
JOIN shippers s ON o.shipper_id = s.shipper_id
LEFT JOIN customers c ON o.customer_id = c.customer_id;


--Q5 Create a full match schedule by listing all possible team and venue combinations.
CREATE OR REPLACE VIEW full_match_schedule AS
SELECT 
    t.team_name AS "Team Name",
    v.venue_name AS "Venue Name"
FROM teams t
CROSS JOIN venues v;


--Q6 Show each employee, their manager, and the manager’s department
CREATE OR REPLACE VIEW employee_manager_department AS
SELECT 
    e.name AS "Employee Name",
    e.manager_id AS "Manager ID",
    d.department AS "Department Name"
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;


--Q7 Identify the root, nodes, and leaves for this query:
SELECT m.name,
  b.title,
  g.genre_name
FROM Members m
  JOIN Loans l ON m.member_id = l.member_id
  JOIN Books b ON l.book_id = b.book_id
  JOIN Genres g ON b.genre_id = g.genre_id
WHERE g.genre_name = 'Science Fiction';

--Root: m.name, b.title, g.genre_name
--Nodes: m.member_id = l.member_id, l.book_id = b.book_id, b.genre_id = g.genre_id
--Leaves: Members, Loans, Books, Genres


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


--Q9. Represent the query tree for this SQL query and label the root, nodes, and leaves:
SELECT 
    f.flight_no, 
    a.airport_name, 
    l.airline_name
FROM
flights f
JOIN routes r ON f.route_id = r.route_id
JOIN airports a ON r.destination_id = a.airport_id
JOIN airlines l ON f.airline_id = l.airline_id
WHERE l.airline_name = 'SkyJet'

            π flight_no, airport_name, airline_name
                            │
                    σ l.airline_name = 'SkyJet'
                            │
                ⋈ f.airline_id = l.airline_id
                        /                   \
        r.destination_id = a.airport_id     Airlines
                        /            \
                    f.route_id = r.route_id
                              /        \
                            Flights   Routes
                                          \
                                        Airports


--Q10. In a query tree, what do the leaf nodes represent?
--the leaf nodes are the tables as a whole


--Q11. Which SQL operation typically forms the root of a query tree?
--anything included in the select statement


--Q12. Which of the following best describes a physical operator in a query tree?
--a real execution performed by the database when they join 


            π o_id, customer_name, total
                            │
        γ o_id, customer_name; SUM(oi.quantity*oi.unit_price)
                            │
            ⋈ o.customer_id = c.customer_id
                    /                          \
        oi.product_id = p.product_id        Customers
                        /       \
                    ⋈ o_id = oi.o_id
                    /                \
σ o.order_date >= DATE '2024-01-01'   OrderItems
                                            │
                                           Orders
                                              \
                                                σ p.category='Accessories'
                                                │
                                            Products


