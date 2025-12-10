--Q6 Show each employee, their manager, and the manager’s department
CREATE OR REPLACE VIEW employee_manager_department AS
SELECT 
    e.name AS "Employee Name",
    e.manager_id AS "Manager ID",
    d.department AS "Department Name"
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;
