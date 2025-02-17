/*
 views have been made in advance, there are 7 in total

 public | average_installment_amount | view |
 public | completed_appointments     | view |
 public | customer_rating            | view |
 public | most_expensive_service     | view | 
 public | service_information        | view |
 public | staff_info                 | view | 
 public | total_appointments         | view | 

*/

CREATE TABLE customer(
    cust_id SERIAL PRIMARY KEY,
    cust_personal_number  VARCHAR(15) UNIQUE NOT NULL,
    cust_business_number  VARCHAR(15),
    cust_personal_email  VARCHAR(150) UNIQUE NOT NULL,
    cust_business_email  VARCHAR(150),
    cust_first_name VARCHAR(50) NOT NULL,
    cust_last_name VARCHAR(50) NOT NULL, 
    cust_bill_addr1 VARCHAR(30) NOT NULL,
    cust_bill_addr2 VARCHAR(30),
    cust_bill_city VARCHAR(30) NOT NULL,
    cust_bill_postcode VARCHAR(10) NOT NULL
);


CREATE TYPE status_enum AS ENUM('Completed', 'In Progress', 'Not Started', 'Unable To Complete');

CREATE TABLE appointment_status(
    status_id SERIAL PRIMARY KEY,
    status status_enum DEFAULT('Not Started') NOT NULL
);


CREATE TABLE service_appointment(
    appt_id SERIAL PRIMARY KEY,
    cust_id INT, 
    status_id INT,
    start_date DATE NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    end_date DATE NOT NULL CHECK(end_date > start_date),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id),
    FOREIGN KEY (status_id) REFERENCES appointment_status(status_id)
);


CREATE TABLE staff(
    staff_id SERIAL PRIMARY KEY, 
    staff_name VARCHAR(50) NOT NULL, 
    staff_surname VARCHAR(50) NOT NULL, 
    staff_number  VARCHAR(15)UNIQUE NOT NULL ,
    staff_email  VARCHAR(150) UNIQUE NOT NULL,
    staff_addr1 VARCHAR(30) NOT NULL,
    staff_addr2 VARCHAR(30),
    staff_city VARCHAR(30) NOT NULL, 
    staff_postcode VARCHAR(10) NOT NULL,
    staff_national_insurance VARCHAR(10) UNIQUE NOT NULL,
    staff_join_date DATE NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE services(
    srv_id SERIAL PRIMARY KEY, 
    appt_id INT, 
    staff_id INT, 
    FOREIGN KEY (appt_id) REFERENCES service_appointment(appt_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);


CREATE TABLE vehicle_details(
    veh_id SERIAL PRIMARY KEY, 
    cust_id INT,
    veh_make VARCHAR(100) NOT NULL,
    veh_model VARCHAR(100) NOT NULL, 
    veh_year INT NOT NULL,
    veh_plate VARCHAR(10) UNIQUE NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);


CREATE TABLE service_report(
    report_id SERIAL PRIMARY KEY, 
    veh_id INT, 
    srv_id INT,
    appt_id INT,
    report_date DATE NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    issues_found VARCHAR(255), 
    actions_taken VARCHAR(255),
    FOREIGN KEY (srv_id) REFERENCES services(srv_id),
    FOREIGN KEY (veh_id) REFERENCES vehicle_details(veh_id),
    FOREIGN KEY (appt_id) REFERENCES service_appointment(appt_id)
);


CREATE TABLE customer_feedback(
    feedback_id SERIAL PRIMARY KEY,
    appt_id INT,
    cust_id INT,
    rating INT CHECK (rating >= 0 AND rating <= 5) NOT NULL,
    comments VARCHAR(255),
    FOREIGN KEY (appt_id) REFERENCES service_appointment(appt_id),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);


CREATE TYPE technician_enum AS  ENUM('Available', 'Unavailable');

CREATE TABLE technician_availability(
    availability_id SERIAL PRIMARY KEY,
    staff_id INT, 
    date_start DATE NOT NULL, 
    date_end DATE NOT NULL,
    time_start TIME NOT NULL,
    time_end TIME NOT NULL,
    status technician_enum NOT NULL, 
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);


CREATE TYPE departments_enum AS ENUM('Service','Operational'); --needs looking into

CREATE TABLE department(
    dpt_id SERIAL PRIMARY KEY, 
    dpt_name VARCHAR(25) NOT NULL, 
    dpt_type departments_enum NOT NULL
);


CREATE TABLE department_staff(
    dpt_id INT,
    staff_id INT,  
    is_head BOOLEAN NOT NULL,  --this will need looking into
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (dpt_id) REFERENCES department(dpt_id),
    PRIMARY KEY(dpt_id, staff_id)
);


CREATE TABLE service_details(
    srv_det_id SERIAL PRIMARY KEY, 
    srv_id INT,
    service_name VARCHAR(50) NOT NULL, 
    description VARCHAR(255) NOT NULL, 
    price DECIMAL(10, 2) CHECK (price>0) NOT NULL, 
    service_estimated_time VARCHAR(15) NOT NULL,
    FOREIGN KEY (srv_id) REFERENCES services(srv_id)
);


CREATE TABLE installment_plan(
    plan_id SERIAL PRIMARY KEY, 
    cust_id INT, 
    appt_id INT, 
    installment_count INT NOT NULL, 
    installment_ammount DECIMAL(10, 2) NOT NULL, 
    interest_rate DECIMAL(5, 2) NOT NULL DEFAULT 0, 
    date_created DATE NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id),
    FOREIGN KEY (appt_id) REFERENCES service_appointment(appt_id)
);


CREATE TABLE spare_parts_inventory(
    part_id SERIAL PRIMARY KEY, 
    dpt_id INT,
    part_name VARCHAR(100) NOT NULL, 
    quantity INT NOT NULL CHECK (quantity>0) DEFAULT 0, 
    unit_price DECIMAL(10, 2) NOT NULL,
    supplier VARCHAR(50) NOT NULL,
    FOREIGN KEY (dpt_id) REFERENCES department(dpt_id)
);


--PAST THIS POINT DO NOT SUBMIT AI WAS PARTLY USED TO GENERATE INSERTS AND SELECTS--


--inserts for the customers--
INSERT INTO customer(cust_personal_number, cust_business_number, cust_personal_email, cust_business_email, cust_first_name, cust_last_name, cust_bill_addr1, cust_bill_addr2, cust_bill_city, cust_bill_postcode)
VALUES 
    ('07700900001', NULL, 'john.doe@email.com', NULL, 'John', 'Doe', '123 Main St', NULL, 'London', 'W1A 1AA'),
    ('07700900002', 'B1234567890', 'jane.smith@email.com', 'jane@business.com', 'Jane', 'Smith', '456 High St', 'Suite 789', 'Manchester', 'M1 1AA'),
    ('07700900003', NULL, 'bob.johnson@email.com', NULL, 'Bob', 'Johnson', '789 Park Ave', 'Apt 101', 'Birmingham', 'B1 1AA'),
    ('07700900004', 'B2345678901', 'sarah.williams@email.com', 'sarah@company.com', 'Sarah', 'Williams', '321 Oak Rd', NULL, 'Glasgow', 'G1 1AA'),
    ('07700900005', NULL, 'michael.brown@email.com', NULL, 'Michael', 'Brown', '654 Pine St', NULL, 'Liverpool', 'L1 1AA'),
    ('07700900006', 'B3456789012', 'emma.taylor@email.com', 'emma@enterprise.com', 'Emma', 'Taylor', '987 Elm St', 'Floor 3', 'Edinburgh', 'EH1 1AA');


-- inserts for appointment_status--
INSERT INTO appointment_status(status)
VALUES 
    ('Completed'),
    ('In Progress'),
    ('Not Started'),
    ('Unable To Complete');


-- inserts for service_appointments--
INSERT INTO service_appointment(cust_id, status_id, start_date, end_date)
VALUES 
    (1, 1, '2022-01-01', '2022-01-05'),
    (2, 2, '2022-02-10', '2022-02-15'),
    (3, 3, '2022-03-15', '2022-03-20'),
    (4, 4, '2022-04-20', '2022-04-25'),
    (5, 1, '2022-05-25', '2022-06-01'),
    (6, 2, '2022-06-20', '2022-06-25');

-- inserts for vehicle_details--
INSERT INTO vehicle_details (cust_id, veh_make, veh_model, veh_year, veh_plate)
VALUES 
    (1, 'Toyota', 'Camry', 2021, 'AB21 CDE'),
    (2, 'Honda', 'Civic', 2022, 'CD22 FGH'),
    (3, 'Ford', 'Mustang', 2020, 'EF20 IJK'),
    (4, 'BMW', 'X5', 2023, 'GH23 LMN'),
    (5, 'Tesla', 'Model 3', 2022, 'IJ22 OPQ'),
    (6, 'Volkswagen', 'Golf', 2021, 'MN21 IJK');


-- inserts for customer_feedback--
INSERT INTO customer_feedback (appt_id, cust_id, rating, comments)
VALUES 
    (1, 1, 4, 'Excellent service, prompt attention.'),
    (2, 2, 3, 'Service was good, but needed more attention.'),
    (3, 3, 5, 'Customer service was top-notch.'),
    (4, 4, 2, 'Service was average, but could have been better.'),
    (5, 5, 4, 'Service was excellent, prompt attention.'),
    (6, 6, 5, 'Customer service was top-notch.');


--inserts for staff--
INSERT INTO staff (staff_name, staff_surname, staff_number, staff_email, staff_addr1, staff_addr2, staff_city, staff_postcode, staff_national_insurance, staff_join_date)
VALUES 
    ('Geoffrey', 'Smith', '07777777777', 'geoffrey.smith@example.com', '10 Downing Street', NULL, 'London', 'SW1A 2AA', 'AB123456C', '2022-01-01'),
    ('Jane', 'Doe', '07788888888', 'jane.doe@example.com', '20 Baker Street', 'Flat 3B', 'London', 'NW1 6XE', 'CD234567D', '2022-02-15'),
    ('David', 'Williams', '07799999999', 'david.williams@example.com', '30 Oxford Road', NULL, 'Manchester', 'M13 9PL', 'EF345678E', '2022-03-20'),
    ('Sarah', 'Brown', '07800000007', 'sarah.brown@example.com', '40 Princes Street', 'Suite 5', 'Edinburgh', 'EH2 2YR', 'GH456789F', '2022-04-10'),
    ('Steve', 'Haines', '0734000006', 'steve.haines@example.com', '27 Duke Street', 'Apt 9', 'Liverpool', 'EH3 2PS', 'lO128QHF', '2022-05-16'),
    ('Maggie', 'Simpson', '07720000005', 'maggie.simpson@example.com', '742 Evergreen Terrace', Null, 'Springfield', 'PO3 1LZ', 'GH456789H', '2022-04-10'),
    ('Bart', 'Simpson', '07720000004', 'bart.simpson@example.com', '742 Evergreen Terrace', Null, 'Springfield', 'PO3 1LZ', 'GH456789D', '2022-04-14'),
    ('Homer', 'Simpson', '07720054003', 'homer.simpson@example.com', '742 Evergreen Terrace', Null, 'Springfield', 'PO3 1LZ', 'GH456789C', '2022-06-03'),
    ('Marge', 'Simpson', '07720240002', 'marge.simpson@example.com', '742 Evergreen Terrace', Null, 'Springfield', 'PO3 1LZ', 'GH456789B', '2022-12-02'),
    ('Neek', 'Simpson', '07720085001', 'neek.simpson@example.com', '742 Evergreen Terrace', Null, 'Springfield', 'PO3 1LZ', 'GH456789A', '2022-09-11');


-- inserts for technician_availability--
INSERT INTO technician_availability (staff_id, date_start, date_end, time_start, time_end, status)
VALUES 
    (1, '2023-05-01', '2023-05-01', '09:00:00', '17:00:00', 'Available'),
    (2, '2023-05-02', '2023-05-02', '08:00:00', '16:00:00', 'Available'),
    (3, '2023-05-03', '2023-05-03', '10:00:00', '18:00:00', 'Unavailable'),
    (4, '2023-05-04', '2023-05-04', '09:00:00', '17:00:00', 'Available'),
    (5, '2023-05-05', '2023-05-05', '08:00:00', '16:00:00', 'Unavailable'),
    (6, '2023-05-06', '2023-05-06', '09:00:00', '17:00:00', 'Available');


-- insert into departments-- 
INSERT INTO department(dpt_name, dpt_type)
VALUES
    ('Engine & Transmission', 'Service'),
    ('electrical Systems', 'Service'),
    ('Bodywork & Paint', 'Service'),
    ('General Maintenance', 'Service'),
    ('Customer Service', 'Operational'),
    ('Finance', 'Operational');


-- inserts for department_staff--
INSERT INTO department_staff (dpt_id, staff_id, is_head)
VALUES
    (1, 1, False),
    (1, 2, True),
    (2, 3, False),
    (2, 4, True),
    (3, 5, False),
    (3, 6, True),
    (4, 7, False),
    (4, 8, True),
    (5, 9, True),
    (6, 10, True);

-- insert into services--
INSERT INTO services(staff_id, appt_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

--inserta for service details--
INSERT INTO service_details(srv_id, service_name, description, price, service_estimated_time)
VALUES
    (1, 'Oil Change', 'Change the oil in your engine to prevent engine damage and improve performance.', 25.00, '1 Hour'),
    (2, 'Tire Rotation', 'Rotate your tires to prevent them from wearing out and improve fuel efficiency.', 10.00, '2 Hour'),
    (3, 'Air Filter Replacement', 'Replace the air filter in your vehicle to improve fuel efficiency and reduce emissions.', 15.00, '1 Hour'),
    (4, 'Brake System Repair', 'Replace the brake pads, rotors, and drums in your vehicle to prevent sudden braking and improve performance.',30.00,  '3 Hours'),
    (5, 'Transmission Fluid Change', 'Change the transmission fluid in your vehicle to prevent transmission issues and improve performance.', 20.00, '30 Minutes');


--service reports
INSERT INTO service_report(veh_id, srv_id, appt_id, report_date, issues_found, actions_taken)
VALUES
    (1, 1, 1, '2023-05-01', 'No further issues', 'Engine oil change completed successfully.'),
    (2, 2, 2, '2023-05-02', 'Uneven tire wear', 'Tire rotation completed successfully.'),
    (3, 3, 3, '2023-05-03', 'Clogged air filter', 'Air filter replacement completed successfully.'),
    (4, 4, 4, '2023-05-04', 'Worn brake pads', 'Brake system repair completed successfully.'),
    (5, 5, 5, '2023-05-05', 'Low transmission fluid', 'Transmission fluid change completed successfully.'),
    (6, 1, 6, '2023-05-06', 'No further issues', 'Engine oil change completed successfully.');


-- insert into installment_plans

INSERT INTO installment_plan(cust_id, appt_id, installment_count, installment_ammount, interest_rate, date_created)
VALUES
    (1, 1, 2, 70.00, 0.05, '2023-01-01'),
    (2, 2, 3, 50.00, 0.05, '2023-02-02'),
    (3, 3, 4, 20.00, 0.05, '2023-05-03'),
    (4, 4, 3, 10.00, 0.05, '2023-07-04'),
    (5, 5, 2, 70.00, 0.05, '2023-09-01'),
    (6, 6, 3, 30.00, 0.05, '2024-05-06');


-- insert into spare_parts_inventory
INSERT INTO spare_parts_inventory (dpt_id, part_name, quantity, unit_price, supplier)
VALUES
    (1, 'Oil', 50, 2.00, 'Duggan Oil Company'),
    (1, 'Spark Plugs', 250, 5.00, 'Spark Plugs Inc'),
    (1, 'Brake Fluid', 75, 1.50, 'Brake Fluids Corp'),
    (1, 'Coolant', 90, 3.00, 'Coolant Suppliers'),
    (1, 'Catalytic converter', 10, 3.50, 'Florida man steve'),
    (2, '15 amp fuses', 10, 0.50, 'Spark and Co'),
    (2, 'OBD Reader', 5, 55.99, 'Dash masters'),
    (3, 'Wrap (oilslick)', 45, 50.00, 'LS Customs'),
    (3, 'Gas masks', 5, 30.00, 'Bogdan Masks'),
    (3, 'Wrap (oilslick)', 45, 50.00, 'LS Customs'),
    (4, 'Brake Fluid', 75, 1.50, 'Brake Fluids Corp'),
    (4, 'Tire', 500, 20.00, 'Tire Masters'),
    (4, 'Battery', 80, 100.00, 'Battery Manufacturers'),
    (5, 'Keyboard', 10, 23.50, 'Macrohard'),
    (5, 'Phones', 5, 70.00, 'Smamsmungs'),
    (6, 'Calculators', 45, 5.00, 'Carsio'),
    (6, 'Post-it-notes', 500, 0.02, 'Dunder mifflin'),
    (6, 'Paper', 50, 10.00, 'dunder mifflin');


--Queries
-- select customer name, car make and model, service type and 
CREATE VIEW service_information AS
SELECT 
    CONCAT_WS(' ', c.cust_first_name, c.cust_last_name) as "Customer Name",
    CONCAT_WS(' ', v.veh_year, v.veh_make, v.veh_model) as "Vehicle Type",
    d.dpt_name as "Department Type"
FROM
    customer c
    JOIN vehicle_details v ON c.cust_id = v.cust_id
    JOIN service_report sr ON sr.veh_id = v.veh_id
    JOIN services s ON s.srv_id = sr.srv_id
    JOIN department_staff ds ON ds.staff_id = s.staff_id
    JOIN department d ON d.dpt_id = ds.dpt_id;


-- Select all completed appointments
CREATE VIEW completed_appointments AS
SELECT
     CONCAT_WS(' ', c.cust_first_name, c.cust_last_name) as "Customer Name",
     s.status AS "Appointment Status",
     i.installment_count AS "Remaining Paments",
     i.installment_ammount AS "Payment Remaining", 
     sa.start_date AS "Date Booked In",
     sa.end_date AS "Date Booked Out",
     i.date_created AS "Installments Began"
FROM customer c 
    JOIN installment_plan i ON c.cust_id = i.cust_id
    JOIN service_appointment sa ON sa.cust_id = i.cust_id
    JOIN appointment_status s ON s.status_id = sa.status_id;


-- staff name and department 
CREATE VIEW staff_info AS
SELECT 
    CONCAT_WS(' ', s.staff_name, s.staff_surname) AS "Staff Name",
    d.dpt_name AS "Department", 
    (SELECT CASE
    WHEN ds.is_head = 'T' THEN 'True'
    WHEN ds.is_head = 'F' THEN 'False'
    ELSE 'Intruder'
    END) AS "Department Head"
FROM staff s 
    JOIN department_staff ds ON s.staff_id = ds.staff_id
    JOIN department d ON d.dpt_id = ds.dpt_id;


--customer rating 
CREATE VIEW customer_rating AS
SELECT
    CONCAT_WS(' ', c.cust_first_name, c.cust_last_name) as "Customer Name",
    cf.comments AS "Customer Comment", 
    cf.rating AS "Customer Rating"
FROM customer c
    JOIN customer_feedback cf ON c.cust_id = cf.cust_id;
    

-- select the most expensive service
CREATE VIEW most_expensive_service AS
SELECT 
    CONCAT_WS(' ', c.cust_first_name, c.cust_last_name) as "Customer Name",
    sdet.service_name AS "Service Name",
    sdet.price AS "Service Price"
FROM customer c
    JOIN service_appointment sa ON c.cust_id = sa.cust_id
    JOIN services s ON sa.appt_id = s.appt_id
    JOIN service_details sdet ON s.srv_id = sdet.srv_id
ORDER BY sdet.price DESC
LIMIT 1;


-- select the average installment amount for each department
CREATE VIEW average_installment_amount AS
SELECT
    d.dpt_name AS "Department Name",
    ROUND(AVG(i.installment_ammount)) AS "Average Installment Amount"
FROM department d
    JOIN department_staff ds ON d.dpt_id = ds.dpt_id
    JOIN staff s ON ds.staff_id = s.staff_id
    JOIN services ser ON s.staff_id = ser.staff_id
    JOIN service_appointment sa ON ser.appt_id = sa.appt_id
    JOIN installment_plan i ON sa.appt_id = i.appt_id
GROUP BY d.dpt_name;


-- select the total number of appointments for each department
CREATE VIEW total_appointments AS
SELECT
    d.dpt_name AS "Department Name",
    COUNT(sa.appt_id) AS "Total Appointments"
    FROM department d
        JOIN department_staff ds ON d.dpt_id = ds.dpt_id
        JOIN staff s ON ds.staff_id = s.staff_id
        JOIN services ser ON s.staff_id = ser.staff_id
        JOIN service_appointment sa ON ser.appt_id = sa.appt_id
GROUP BY d.dpt_name;


--create indexes 
CREATE INDEX idx_cust_id ON customer(cust_id);
CREATE INDEX idx_appt_id ON service_appointment(appt_id);
CREATE INDEX idx_staff_id ON staff(staff_id);
CREATE INDEX idx_dpt_id ON department(dpt_id);
CREATE INDEX idx_srv_id ON services(srv_id);

