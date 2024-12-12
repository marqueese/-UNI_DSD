\c dsd_lab_6

CREATE TABLE customers 
(
    cust_id     SERIAL PRIMARY KEY,
    cust_name   VARCHAR(50) NOT NULL,
    cust_mid_name   VARCHAR(50),
    cust_last_name   VARCHAR(50) NOT NULL,
    cust_addr1   VARCHAR(50) NOT NULL,
    cust_addr2   VARCHAR(50),
    cust_city  VARCHAR(50) NOT NULL,
    cust_postcode CHAR(8) NOT NULL,
    cust_email VARCHAR(150) NOT NULL UNIQUE,
    cust_phone VARCHAR(15) NOT NULL
);


CREATE TABLE playlists
(
    playlist_id    SERIAL PRIMARY KEY, 
    cust_id     INT NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id),
    pl_creation_date    DATE,
    pl_last_accessed    DATE
);


CREATE TABLE songs (
    song_id SERIAL PRIMARY KEY, 
    song_name   VARCHAR(200) NOT NULL,
    song_artist VARCHAR(250) NOT NULL,
    song_length INTERVAL NOT NULL,
    song_year DATE
);

CREATE TABLE song_playlist(
    playlist_id INT REFERENCES playlists(playlist_id) NOT NULL,
    song_id INT REFERENCES songs(song_id) NOT NULL,
    PRIMARY KEY (playlist_id, song_id)
);


INSERT INTO customers (cust_name, cust_mid_name, cust_last_name, cust_addr1, cust_addr2, cust_city, cust_postcode, cust_email, cust_phone)
VALUES
  ('John', 'M', 'Doe', '123 Main Street', '', 'Portsmouth', 'PO1 3AX', 'john.doe@email.com', '1234567890'),
  ('Jane', 'S', 'Smith', '456 High Street', 'Floor 3', 'London', 'SW1A 1AA', 'jane.smith@email.com', '0987654321');

INSERT INTO songs (song_name, song_artist, song_length, song_year)
VALUES
  ('Bohemian Rhapsody', 'Queen', '00:05:55', '1975-10-31'),
  ('Hotel California', 'Eagles', '00:06:30', '1977-02-26'),
  ('Imagine', 'John Lennon', '00:03:03', '1971-10-11'),
  ('Smells Like Teen Spirit', 'Nirvana', '00:05:01', '1991-09-10'),
  ('Like a Rolling Stone', 'Bob Dylan', '00:06:13', '1965-07-20');

INSERT INTO playlists (cust_id, pl_creation_date, pl_last_accessed)
VALUES
  (1, '2023-06-01','2023-06-10'),
  (1, '2023-06-15', NULL),
  (2, '2023-07-01','2023-07-05'),
  (2, '2023-07-10', NULL);

INSERT INTO song_playlist (playlist_id, song_id)
VALUES
  (1, 1),
  (1, 3),
  (2, 2),
  (2, 4),
  (3, 5),
  (3, 3),
  (4, 1),
  (4, 2),
  (4, 4);

  
\c dsd6_q2

CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY, 
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE lectures (
    lect_id SERIAL PRIMARY KEY, 
    dept_id INT,
    lect_title VARCHAR(10),
    lect_first_name VARCHAR(50) NOT NULL,
    lect_last_name VARCHAR(50) NOT NULL,
    lect_email VARCHAR(100) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY, 
    course_name VARCHAR(100) NOT NULL
);

CREATE TABLE students(
    stu_id     SERIAL PRIMARY KEY,
    stu_first_name   VARCHAR(50) NOT NULL,
    stu_mid_name   VARCHAR(50),
    stu_last_name   VARCHAR(50) NOT NULL,
    stu_addr1   VARCHAR(50) NOT NULL,
    stu_addr2   VARCHAR(50),
    stu_city  VARCHAR(50) NOT NULL,
    stu_postcode CHAR(8) NOT NULL,
    stu_email VARCHAR(150) NOT NULL,
    stu_phone VARCHAR(15) NOT NULL,
    stu_year SMALLINT NOT NULL
);

CREATE TABLE student_courses(
    stu_id INT REFERENCES student_courses(stu_id) NOT NULL,
    course_id INT REFERENCES courses(course_id) NOT NULL,
    PRIMARY KEY(lect_id, course_id)
);

CREATE TABLE lecturers_courses(
    lect INT REFERENCES lectures(lect_id) NOT NULL,
    course_id INT REFERENCES courses(course_id) NOT NULL,
    PRIMARY KEY(lect_id, course_id),
    grade SMALLINT
);

INSERT INTO students (stu_first_name, stu_mid_name, stu_last_name, stu_addr1, stu_addr2, stu_city, stu_postcode, stu_email, stu_phone, stu_year)
VALUES
  ('Mark', 'J', 'Johnson', '123 Main Street', '', 'Portsmouth', 'PO1 3AX', 'mark.johnson@email.com', '1234567890', 3),
  ('Lisa', 'M', 'Smith', '456 High Street', 'Floor 3', 'London', 'SW1A 1AA', 'lisa.smith@email.com', '0987654321', 2),
  ('John', 'D', 'Doe', '789 Park Avenue', 'Floor 2', 'Manchester', 'M1 4BT', 'john.doe@email.com', '1234567890', 4),
  ('Emma', 'L', 'Brown', '1011 South Street', '', 'Birmingham', 'B1 1QU', 'emma.brown@email.com', '0987654321', 1),
  ('Sam', 'T', 'Green', '1213 East Street', 'Floor 4', 'Liverpool', 'L1 1JT', 'sam.green@email.com', '1234567890', 3),
  ('Alan', 'B', 'Turing', '1415 North Street', '', 'Cambridge', 'CB2 1TN', 'alan.turing@email.com', '1112223334', 2),
  ('Grace', 'M', 'Hopper', '1617 West Street', 'Flat 6', 'Oxford', 'OX1 2JD', 'grace.hopper@email.com', '5556667778', 1);

INSERT INTO departments (dept_name)
VALUES
  ('School of Computing'),
  ('School of Engineering');

INSERT INTO lecturers (dept_id, lect_title, lect_first_name, lect_last_name, lect_email)
VALUES
  (1, '', 'Val', 'Adamescu', 'val.adamescu@port.ac.uk'),
  (1, '', 'Mark', 'Venn', 'mark.venn@port.ac.uk'),
  (1, 'Dr.', 'Claudia', 'Iacob', 'claudia.iacob@port.ac.uk'),
  (2, 'Prof.', 'Mark', 'Black', 'mark.black@port.ac.uk'),
  (2, 'Dr.', 'Sarah', 'Blue', 'sarah.blue@port.ac.uk');

INSERT INTO courses (course_name)
VALUES
  ('Computing'),
  ('Software Engineering'),
  ('Computer Science'),
  ('Networking'),
  ('Cyber Security'),
  ('Mechanical Engineering'),
  ('Civil Engineering');

INSERT INTO students_courses (stu_id, course_id, grade)
VALUES
  (1, 1, 75),
  (2, 2, 85),
  (3, 3, 65),
  (4, 4, 95),
  (5, 5, 80),
  (6, 6, 70),
  (7, 7, 88);

INSERT INTO lecturers_courses (lect_id, course_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 6),
  (5, 7);


CREATE TABLE customers(
    cust_id     SERIAL PRIMARY KEY,
    cust_name   VARCHAR(50) NOT NULL,
    cust_mid_name   VARCHAR(50),
    cust_last_name   VARCHAR(50) NOT NULL,
    cust_addr1   VARCHAR(50) NOT NULL,
    cust_addr2   VARCHAR(50),
    cust_city  VARCHAR(50) NOT NULL,
    cust_postcode CHAR(8) NOT NULL,
    cust_business_email VARCHAR(150) NOT NULL,
    cust_personal_email VARCHAR(150) NOT NULL,
    cust_mobile VARCHAR(15) NOT NULL,
    cust_landline VARCHAR(15) NOT NULL
);

CREATE TABLE categories(
    cat_id SERIAL PRIMARY KEY, 
    cat_name VARCHAR(50) NOT NULL, 
    cat_description VARCHAR(200)
);

CREATE TABLE dishes(
    dish_id  SERIAL PRIMARY KEY NOT NULL, 
    FOREIGN KEY (cat_id) REFERENCES categories(cat_id)
);


CREATE TABLE ingredients(
    ingredient_id PRIMARY key NOT NULL, 
);