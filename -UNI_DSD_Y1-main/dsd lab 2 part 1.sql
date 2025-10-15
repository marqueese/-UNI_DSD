\c dsd7_q1 

CREATE TABLE customers(
    customer_id     SERIAL PRIMARY KEY,
    customer_name   VARCHAR(50) NOT NULL,
    customer_email VARCHAR(150) NOT NULL UNIQUE,
    customer_phone VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE orders (
    order_id    SERIAL PRIMARY KEY,              
    customer_id INT NOT NULL,                   
    order_date  DATE NOT NULL,                  
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount > 0), 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products(
    product_id SERIAL PRIMARY KEY, 
    product_name VARCHAR(100) NOT NULL, 
    price DECIMAL NOT NULL CHECK (price > 0)
);

CREATE TABLE order_items (
    order_id   INT NOT NULL,                 
    product_id INT NOT NULL,                   
    quantity   INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
);

INSERT INTO customers (customer_name, customer_email, customer_phone) 
VALUES
    ('Jank parl', 'StagedFights@hotmail.com', '07486562981'),
    ('Log Pollen', 'TheForest@japaneseforest.co.uk', '07542875385');


INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
    (1, '2024-11-21', 150.75),
    (2, '2024-11-22', 220.50),
    (1, '2024-11-23', 99.99);

INSERT INTO products (product_name, price)
VALUES
    ('Product A', 24.99),
    ('Product B', 17.99);

INSERT INTO order_items(order_id, product_id, quantity)
VALUES
    (1, 2 ,2),
    (1, 1 ,1),
    (2, 2 ,1),
    (2, 2 ,2),
    (3, 1 ,1);


-- checking -- 

INSERT INTO customers (customer_name, customer_email, customer_phone) 
VALUES
    ('Jank park', 'StagedFights@hotmail.co.uk', '07486562981');

INSERT INTO customers (customer_name, customer_email, customer_phone) 
VALUES
    ('Log Pollen', 'TheForest@japaneseforest.co.uk', '07546875385');

INSERT INTO products (product_name, price)
VALUES
    ('Product C', 0);

CREATE TABLE cinemas (
    cinema_id SERIAL PRIMARY KEY,
    cinema_name VARCHAR(255) UNIQUE,
    location VARCHAR(255)
);

CREATE TABLE screens (
    screen_id SERIAL PRIMARY KEY,
    cinema_id INT,
    screen_date DATE,
    screen_time TIME CHECK (screen_time >= '08:00:00' AND screen_time <= '23:00:00'),
    FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id)
);

CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    movie_title VARCHAR(255),
    genre VARCHAR(100)
);

CREATE TABLE tickets (
    ticket_id SERIAL,
    screen_id INT,
    movie_id INT,
    seat_number VARCHAR(10),
    UNIQUE (screen_id, movie_id, seat_number),
    ticket_price DECIMAL(10, 2) CHECK(ticket_price >= 3.99),
    FOREIGN KEY (screen_id) REFERENCES screens(screen_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    PRIMARY KEY (ticket_id, screen_id, movie_id)
);
