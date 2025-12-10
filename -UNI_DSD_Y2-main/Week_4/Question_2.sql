--Q2.	Using same tables, display each department and the number of employees assigned, including departments with no employees.
CREATE OR REPLACE VIEW dept_employees AS
SELECT 
    d.department "Department Name",
    COUNT(DISTINCT e.emp_id) AS "Number of Employees"
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.department;
