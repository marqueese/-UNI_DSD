\c dsd7_q2

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
    ticket_price DECIMAL(10, 2) CHECK(ticket_price >= 4.99),
    FOREIGN KEY (screen_id) REFERENCES screens(screen_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    PRIMARY KEY (ticket_id, screen_id, movie_id)
);

INSERT INTO cinemas (cinema_name, location)
VALUES
    ('Cinema A', 'Liverpool'),
    ('Cinema B', 'London');

INSERT INTO screens (cinema_id, screen_date, screen_time)
VALUES
    (1, '2024-12-18', '16:30:00'),
    (1, '2024-12-19', '10:30:00'),  
    (2, '2024-12-18', '20:35:00'),    
    (2, '2024-12-20', '12:15:00');

INSERT INTO movies (movie_title, genre)
VALUES
    ('Movie A', 'Horror'),
    ('Movie B', 'Comedy'),
    ('Movie B', 'Action');

INSERT INTO tickets (screen_id, movie_id, seat_number, ticket_price)
VALUES
    (1, 2, '34', 5.99),
    (1, 3, '4', 5.99),
    (1, 1, '17', 5.99),
    (2, 2, '28', 7.99),
    (2, 1, '42', 7.99);

INSERT INTO cinemas (cinema_name, location)
VALUES
    ('Cinema A', 'Manchester');

INSERT INTO screens (cinema_id, screen_date, screen_time)
VALUES  
    (2, '2024-16-20', '05:00:00');

INSERT INTO tickets (screen_id, movie_id, seat_number, ticket_price)
VALUES
    (2, 1, '50', 3.99);

INSERT INTO tickets (screen_id, movie_id, seat_number, ticket_price)
VALUES
    (1, 1, '17', 5.99);

