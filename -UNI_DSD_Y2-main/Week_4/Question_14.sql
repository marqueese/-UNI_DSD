--Q14. Three engineers wrote three possible SQL queries that will need to produce a report listing all departments and their projects 
-- —even those departments that have no employees assigned yet, for the following schema:

Employees(emp_id, name, dept_id) 
Departments(dept_id, department_name) 
Projects(project_id, dept_id, project_name)


-- Query A
SELECT 
    d.department_name, 
    p.project_name
FROM Departments d
JOIN Projects p ON d.dept_id = p.dept_id
JOIN Employees e ON e.dept_id = d.dept_id;


-- Query B
SELECT 
    d.department_name, 
    p.project_name
FROM Departments d
LEFT JOIN Projects p ON d.dept_id = p.dept_id
LEFT JOIN Employees e ON e.dept_id = d.dept_id;


-- Query C
SELECT 
    d.department_name, 
    p.project_name
FROM Projects p
RIGHT JOIN Departments d ON d.dept_id = p.dept_id
LEFT JOIN Employees e ON e.dept_id = d.dept_id


--Query b is correct as it gets a left join on employees whereas c has a right join where there is no employees in department
--and a fails for it being an inner join 

--if i were to switch the left to a right join it would priorotise the data in department when i need employee data 