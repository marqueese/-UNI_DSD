\c dsd7_q3

CREATE TABLE cars(
    car_id  SERIAL PRIMARY KEY, 
    car_make VARCHAR(50) NOT NULL, 
    car_model VARCHAR(50) NOT NULL, 
    car_year VARCHAR(4) NOT NULL, 
    car_price DECIMAL NOT NULL
);

CREATE TABLE customers(
    cust_id     SERIAL PRIMARY KEY,
    cust_name   VARCHAR(50) NOT NULL,
    cust_last_name   VARCHAR(50) NOT NULL,
    cust_email VARCHAR(150) NOT NULL UNIQUE,
    cust_phone VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    car_id INT,
    cust_id INT,
    rental_start_date DATE NOT NULL,
    rental_end_date DATE NOT NULL,
    CHECK (rental_end_date > rental_start_date), 
    CHECK (rental_end_date - rental_start_date >= 1)
    FOREIGN KEY (car_id) REFERENCES cars(car_id),
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
); 

CREATE TABLE rental_payments(
    payment_id SERIAL PRIMARY KEY, 
    rental_id INT NOT NULL,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL NOT NULL CHECK(payment_amount >= 19.99),
    FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);

CREATE TABLE rental_reviews(
    review_id SERIAL PRIMARY KEY,
    rental_id INT NOT NULL,
    rating INT NOT NULL CHECK (0 >= rating or rating <= 5),
    comment VARCHAR (255)
);

INSERT INTO cars(car_make, car_model, car_year, car_price)
VALUES
    ('Ford', 'Focus', 2019, 29.99),
    ('Fiat', '500', 2019, 20.00),
    ('Mazda', '3', 2019, 24.50),
    ('kia', 'ceed', 2019, 26.00),
    ('lexus', 'is250', 2019, 31.00);

INSERT INTO customers (cust_name, cust_last_name, cust_email, cust_phone)
VALUES
    ('Jank' , 'parl', 'StagedFights@hotmail.com', '07486562981'),
    ('Log' ,'Pollen', 'TheForest@japaneseforest.co.uk', '07542875385'),
    ('John' ,'Beast', 'StoleUrNansKidneyForATesla@gmail.com', '07725497275');

INSERT INTO rentals (car_id, cust_id, rental_start_date, rental_end_date)
VALUES
    (1, 1, '2024-11-20', '2024-12-18'), 
    (1, 2, '2024-12-19', '2025-01-18'),
    (2, 3, '2024-11-22', '2024-12-20'), 
    (2, 4, '2024-12-21', '2025-01-20'), 
    (3, 5, '2024-11-24', '2024-12-21'); 

INSERT INTO rental_payments (rental_id, payment_date, payment_amount)
VALUES
    (1, '2024-11-25', 500.00),
    (2, '2024-11-26', 400.00),
    (3, '2024-11-27', 600.00),
    (4, '2024-11-28', 700.00),
    (5, '2024-11-29', 800.00);


INSERT INTO rental_reviews (rental_id, payment_date, rating, comment)
VALUES
    (1,'2024-12-25','4/5', 'it didnt spontaneously combust'),
    (2,'2024-12-28','0/5', 'it spontaneously combusted'),
    (3,'2024-12-26','5/5', 'it didnt spontaneously combust'),
    (4,'2024-12-27','4/5', 'it didnt spontaneously combust'),
    (5, '2024-12-29','4/5', 'it didnt spontaneously combust');