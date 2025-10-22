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