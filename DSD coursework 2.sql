DSD coursework 2 

CREATE TABLE customers (
    cust_id SERIAL PRIMARY KEY, 
    cust_personal_number UNIQUE VARCHAR(15)NOT NULL ,
    cust_business_number UNIQUE VARCHAR(15),
    cust_personal_email  VARCHAR(150) UNIQUE NOT NULL,
    cust_business_email  VARCHAR(150) UNIQUE,
    cust_first_name VARCHAR(50) NOT NULL, 
    cust_last_name VARCHAR(50) NOT NULL, 
    cust_adds_1 VARCHAR(30) NOT NULL,
    cust_adds_2 VARCHAR(30),
    cust_city VARCHAR(30) NOT NULL, 
    cust_postcode VARCHAR(10) NOT NULL
);

CREATE TYPE status_enum AS ENUM('Completed','In Progress','Not Started', 'Unable To Complete');

CREATE TABLE appointment_status(
    status_id SERIAL PRIMARY KEY, 
    status status_enum DEFAULT('Not Started') NOT NULL
);

CREATE TABLE service_appointments(
    appt_id SERIAL PRIMARY KEY,
    cust_id INT, 
    status_id INT,
    report_id INT,
    start_date DATE NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    end_date DATE NOT NULL CHECK(end_date> start_date),
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id),
    FOREIGN KEY (status_id) REFERENCES appointment_status(status_id),
    FOREIGN KEY (report_id) REFERENCES service_reports(report_id),

);

CREATE TABLE vehicle_details(
    veh_id SERIAL PRIMARY KEY, 
    cust_id INT,
    veh_make VARCHAR(100) NOT NULL,
    veh_model VARCHAR(100) NOT NULL, 
    veh_year INT NOT NULL,
    veh_plate VARCHAR(10) UNIQUE NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

CREATE TABLE customer_feedback(
    feedback_id SERIAL PRIMARY KEY, 
    appt_id INT,
    cust_id INT,
    rating INT CHECK (rating >= 0 AND rating <= 5) NOT NULL,
    comments VARCHAR(255) NOT NULL, 
    FOREIGN KEY (appt_id) REFERENCES service_appointments(appt_id),
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

CREATE TABLE staff(
    staff_id SERIAL PRIMARY KEY, 
    staff_first_name VARCHAR(50) NOT NULL, 
    staff_last_name VARCHAR(50) NOT NULL, 
    staff_number  VARCHAR(15)UNIQUE NOT NULL ,
    staff_email  VARCHAR(150) UNIQUE NOT NULL,
    staff_adds_1 VARCHAR(30) NOT NULL,
    staff_adds_2 VARCHAR(30),
    staff_city VARCHAR(30) NOT NULL, 
    staff_postcode VARCHAR(10) NOT NULL,
    staff_ni_number VARCHAR(9) UNIQUE NOT NULL,
    staff_join_date DATE NOT NULL
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
    notes VARCHAR(255) NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TYPE departments_enum AS ENUM('Service','Operational'); --needs looking into

CREATE TABLE departments(
    dpt_id SERIAL PRIMARY KEY, 
    dpt_name VARCHAR(50) NOT NULL, 
    dpt_type departments_enum NOT NULL
);

CREATE TABLE department_staff(
    dpt_id INT,
    staff_id INT,  
    is_head BOOLEAN NOT NULL,  --this will need looking into
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (dpt_id) REFERENCES departments(dpt_id),
    PRIMARY KEY(dpt_id, staff_id)
);

CREATE TABLE service_details(
    srv_det_id SERIAL PRIMARY KEY, 
    srv_id INT,
    service_name VARCHAR(50) NOT NULL, 
    description VARCHAR(255) NOT NULL, 
    price DECIMAL(10, 2) CHECK (price>0) NOT NULL, 
    FOREIGN KEY (srv_id) REFERENCES services(srv_id)
);

CREATE TABLE service_reports(
    report_id SERIAL PRIMARY KEY, 
    veh_id INT, 
    srv_id INT,
    appt_id INT,
    report_date DATE NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    issues_found VARCHAR(255) NOT NULL, 
    actions_taken VARCHAR(255) NOT NULL,
    FOREIGN KEY (srv_id) REFERENCES services(srv_id),
    FOREIGN KEY (veh_id) REFERENCES vehicle_details(veh_id),
    FOREIGN KEY (appt_id) REFERENCES service_appointments(appt_id)

);

CREATE TABLE services(
    srv_id SERIAL PRIMARY KEY, 
    appt_id INT, 
    staff_id INT, 
    FOREIGN KEY (appt_id) REFERENCES service_appointments(appt_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
);

CREATE TABLE installment_plans(
    plan_id SERIAL PRIMARY KEY, 
    cust_id INT, 
    appt_id INT, 
    installment_count INT NOT NULL, 
    installment_ammount DECIMAL(10, 2) NOT NULL, 
    interest_rate DECIMAL(5, 2) NOT NULL DEFAULT 0, 
    date_created DATE NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id),
    FOREIGN KEY (appt_id) REFERENCES service_appointments(appt_id)
);

CREATE TABLE spare_parts_inventory(
    part_id SERIAL PRIMARY KEY, 
    dpt_id INT,
    part_name VARCHAR(100) NOT NULL, 
    description VARCHAR(255) NOT NULL, 
    quantity INT NOT NULL CHECK (quantity>0) DEFAULT 0, 
    unit_price DECIMAL(10, 2),
    supplier VARCHAR(50)
    FOREIGN KEY (dpt_id) REFERENCES departments(dpt_id)
);


INSERT INTO spare_parts_inventory (part_name, description, quantity, unit_price, supplier)
VALUES('Catalytic converter', 'Good for stealing in florida', '7', '32.30','Florida man steve');
