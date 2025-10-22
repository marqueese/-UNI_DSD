--Q3. Using same tables, list all departments in 'London' or 'Manchester' and their employees (if any).
CREATE OR REPLACE VIEW dept_location_employees AS
SELECT
    d.department AS "Department Name",
    e.name AS "Employee Name",
FROM departments d
LEFT JOIN employees e ON e.dept_id = d.dept_id
WHERE d.location IN ('London', 'Manchester');
