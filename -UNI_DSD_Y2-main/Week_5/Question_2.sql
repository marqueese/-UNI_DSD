--You are given the following two queries. The table employee has numerous attributes and your department needs the name, NIN and hire date of an employee. Which one will have a better performance and why? Write down a reasonable explanation.

SELECT * 
FROM employee 
WHERE employee_id = 1;

SELECT 
    emp_name, 
    emp_last_name, 
    emp_nin, 
    emp_hire_date 
from employee 
WHERE employee_id =1;

--query 2 will perform better as you are choosing the specific fields of informationm you want rather than all of the data associated with that employee

