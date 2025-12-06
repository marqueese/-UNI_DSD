--list employees with their roles, hourly rates, and branch
SELECT 
    e.emp_id as "Employee ID",
    e.emp_first_name || ' ' || e.emp_last_name as "Employee Name",
    r.role_name as "Role",
    r.role_hourly_rate as "Hourly Rate",
    b.branch_address1 as "Branch Address"
FROM employee e
JOIN  role r ON e.role_id = r.role_id
JOIN  branch b ON e.branch_id = b.branch_id
ORDER BY b.branch_address1, e.emp_id;

--average payment amount for each service
SELECT 
    s.ser_name AS "Service Name",
    ROUND(AVG(p.pay_amount), 2) AS "Average Payment"
FROM payment p
JOIN service_appointment sa ON p.ser_app_id = sa.ser_app_id
JOIN service s ON sa.ser_id = s.ser_id
GROUP BY s.ser_name
ORDER BY "Average Payment" DESC;

--service appointments scheduled for the next 7 days 
SELECT 
    sa.ser_app_id AS "Service Appointment ID",
    ca.cust_acc_first_name || ' ' || ca.cust_acc_last_name AS "Customer Name",
    car.car_registration AS "Car Registration",   
    s.ser_name AS "Service Name",
    sa.ser_app_date AS "Appointment Date",
    sa.ser_app_time AS "Appointment Time"
FROM service_appointment sa
JOIN service s ON sa.ser_id = s.ser_id
JOIN car ON sa.car_id = car.car_id
JOIN customer_car cc ON car.car_id = cc.car_id
JOIN customer_account ca ON cc.cust_acc_id = ca.cust_acc_id
WHERE sa.ser_app_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days'
ORDER BY sa.ser_app_date, sa.ser_app_time;
-- after writing i realised we have no data within the next week 

--profit from each branch in the last year
SELECT 
    b.branch_address1 AS "Branch Address",
    ROUND(SUM(p.pay_amount) - SUM(r.role_hourly_rate * sa.ser_app_duration_mins / 60.0), 2) AS "Profit"
FROM branch b
JOIN employee e ON b.branch_id = e.branch_id
JOIN role r ON e.role_id = r.role_id
JOIN service_detail sd ON e.emp_id = sd.emp_id
JOIN service_appointment sa ON sd.ser_app_id = sa.ser_app_id
JOIN payment p ON sa.ser_app_id = p.ser_app_id
WHERE sa.ser_app_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY b.branch_address1
ORDER BY "Profit" DESC;

--profit from each department deviedied by cities

--number of each item in inventory didvided by branch 
SELECT 
    b.branch_address1 AS "Branch Address",
    i.item_name AS "Item Name",
    SUM(si.stock_quantity) AS "Total Quantity"  
FROM branch b
JOIN stock_inventory si ON b.branch_id = si.branch_id
JOIN inventory_item i ON si.item_id = i.item_id
GROUP BY b.branch_address1, i.item_name
ORDER BY b.branch_address1, i.item_name;


