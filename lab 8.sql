
/*
 Source Server         : dsd_libdb
 Source Server Type    : PostgreSQL
 Source Server Version : 150002 (150002)
 Source Host           : localhost:5432
 Source Schema         : public
 
 File Encoding         : 65001
 Date: 14/07/2023 11:53:31
 */

-- ----------------------------
-- Table structure for LANGUAGES
-- ----------------------------
CREATE TABLE languages (
    lang_id SERIAL PRIMARY KEY,
    lang_name VARCHAR(50) UNIQUE NOT NULL,
    lang_code CHAR(2) UNIQUE NOT NULL
);
-- ----------------------------
-- Records of LANGUAGES
-- ----------------------------
INSERT INTO languages (lang_name, lang_code)
VALUES 
('English', 'EN'),
('Spanish', 'ES'),
('Chinese', 'ZH'),
('French', 'FR'),
('German', 'DE');



-- ----------------------------
-- Table structure for GENRES
-- ----------------------------
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) UNIQUE NOT NULL
);
-- ----------------------------
-- Records of GENRES
-- ----------------------------
INSERT INTO genres (genre_name)
VALUES 
('Action'),
('Adventure'),
('Education'),
('Mystery'),
('Non-fiction'),
('Programming'),
('Sci-Fi'),
('Science'),
('Short Story');



-- ----------------------------
-- Table structure for PUBLISHERS
-- ----------------------------
CREATE TABLE publishers (
    pub_id SERIAL PRIMARY KEY,
    pub_name VARCHAR(50) UNIQUE NOT NULL
);
-- ----------------------------
-- Records of PUBLISHERS
-- ----------------------------
INSERT INTO publishers (pub_name)
VALUES 
('HarperCollins Publishers'),
('Penguin Random House'),
('Wiley'),
('Oxford University Press'),
('Cambridge University Press'),
('Elsevier'),
('Penguin Books'),
('Vintage Books');



-- ----------------------------
-- Table structure for author
-- ----------------------------
CREATE TABLE authors (
    auth_id SERIAL PRIMARY KEY,
    auth_name VARCHAR(50) NOT NULL,
    auth_mid_name VARCHAR(50),
    auth_last_name VARCHAR(50) NOT NULL,
    CONSTRAINT unique_author_name UNIQUE (auth_name, auth_mid_name, auth_last_name)
);
-- ----------------------------
-- Records of author
-- ----------------------------
INSERT INTO authors (auth_name, auth_mid_name, auth_last_name)
VALUES 
('Ayato', NULL, 'Murphy'),
('Daichi', NULL, 'Butler'),
('Michael', 'Brandon', 'West'),
('Momoka', 'Jack', 'Lee'),
('Leslie', NULL, 'Kelley'),
('Johnny', 'R', 'Rivierra'),
('Maria', NULL, 'West');



-- ----------------------------
-- Table structure for BOOKS
-- ----------------------------
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    pub_id INT,
    genre_id INT,
    book_isbn VARCHAR(17) UNIQUE,
    book_title VARCHAR(255) NOT NULL,
    book_pub_year SMALLINT CHECK (
        book_pub_year >= 1800
        AND book_pub_year <= 2100
    ),
    book_pages SMALLINT,
    FOREIGN KEY (pub_id) REFERENCES publishers (pub_id),
    FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
);
-- ----------------------------
-- Records of BOOKS
-- ----------------------------
INSERT INTO books (pub_id, genre_id, book_isbn, book_title, book_pub_year, book_pages)
VALUES
(3, 7, '978-1-86197-876-9', 'The Unseen World', 2015, 332),
(7, 5, '978-3-86197-876-9', 'Dark Matter Chronicles', 2005, 795),
(6, 8, '978-4-57029-456-7', 'The Starship Chronicles', 2015, 656),
(3, 5, '979-2-93211-543-8', 'Mastering SQL', 2021, 255),
(1, 2, '978-5-59777-765-1', 'The Cipher Chronicles', 2020, 958),
(3, 2, '979-9-77492-098-3', 'PostgreSQL up and running', 2004, 643),
(5, 3, '978-6-65233-567-2', 'The Mindful Way', 2003, 569),
(7, 2, '979-1-48732-654-9', 'The Secrets of the Mind', 2009, 340),
(7, 3, '978-8-92058-789-4', 'The Lost of Time', 2004, 492),
(3, 3, '979-3-36674-321-6', 'The Forbidden Empire', 2017, 670),
(5, 7, '978-2-99876-543-2', 'The Wilderness Survival Guide', 2005, 585),
(8, 8, '979-6-60908-765-4', 'Return of the Jedi', 2007, 732),
(6, 6, '978-3-76432-567-8', 'The Rain', 2017, 440),
(4, 8, '979-8-50231-098-7', 'Secrets of the Cosmos', 2017, 422),
(2, 8, '978-1-28376-432-1', 'The Quantum Paradox', 2009, 422),
(5, 1, '979-4-43765-987-4', 'The Forbidden Experiment', 2020, 886),
(8, 8, '978-5-67439-876-5', 'Adventures in Time', 2012, 683),
(4, 4, '979-0-80723-210-9', 'Code Breakers', 2005, 288),
(4, 8, '978-9-99999-999-9', 'The Art of Study', 2003, 414),
(3, 8, '979-2-51234-567-0', 'The Art of Learning', 2010, 523),
(4, 3, '978-8-99234-678-2', 'The Mystery of Hollow Hill', 2021, 900),
(5, 7, '979-5-87654-321-5', 'Code Breaker''s Quest', 2016, 885),
(3, 3, '978-7-23456-789-3', 'The Lost Expedition', 2000, 668),
(5, 3, '979-3-99876-543-2', 'The Science of Genetics', 2014, 424),
(2, 5, '979-1-23436-789-3', 'Database Systems', 2022, 550);


-- ----------------------------
-- Table structure for BOOKS_AUTHORS
-- ----------------------------
CREATE TABLE books_authors (
    book_id INT,
    auth_id INT,
    PRIMARY KEY (book_id, auth_id),
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (auth_id) REFERENCES authors (auth_id)
);
-- ----------------------------
-- Records of BOOKS_AUTHORS
-- ----------------------------
INSERT INTO books_authors (book_id, auth_id)
VALUES 
(15, 4),
(13, 3),
(24, 1),
(18, 2),
(9, 1),
(7, 1),
(10, 5),
(12, 4),
(12, 3),
(19, 2),
(6, 4),
(14, 1),
(23, 1),
(6, 2),
(9, 4),
(23, 3),
(21, 2),
(23, 2),
(22, 1),
(8, 2),
(14, 3),
(5, 2),
(7, 4),
(13, 1),
(3, 4),
(24, 3),
(1, 1),
(14, 2),
(13, 4),
(21, 4),
(16, 2),
(20, 1),
(11, 2),
(9, 2),
(16, 4),
(1, 3),
(20, 2),
(3, 3),
(2, 3),
(24, 2);


-- ----------------------------
-- Table structure for BOOKS_EDITIONS
-- ----------------------------
CREATE TABLE books_editions (
    ed_id SERIAL PRIMARY KEY,
    book_id INT,
    ed_no SMALLINT NULL,
    ed_year SMALLINT CHECK (
        ed_year >= 1800
        AND ed_year <= 2100
    ),
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    CONSTRAINT unique_book_edition UNIQUE (book_id, ed_no)
);
-- ----------------------------
-- Records of BOOKS_EDITIONS
-- ----------------------------
INSERT INTO books_editions (book_id, ed_no, ed_year)
VALUES 
    (1, 1, 2014),
    (1, 2, 2022),
    (2, 3, 2017),
    (2, 2, 1950),
    (2, 1, 2000),
    (3, 1, 1981),
    (4, 1, 1998),
    (5, 2, 1981),
    (5, 1, 1971),
    ( 6, 3, 1963),
    ( 7, 2, 1986),
    ( 8, 1, 1958),
    ( 9, 1, 1995),
    ( 9, 2, 2012),
    ( 9, 3, 2018),
    ( 9, 4, 2023),
    ( 10, 2, 2001),
    ( 11, 2, 1982),
    ( 11, 1, 2001),
    ( 12, 1, 2020),
    ( 12, 3, 1974),
    ( 13, 2, 1982),
    ( 14, 2, 1967),
    ( 15, 2, 2018),
    ( 16, 2, 1968),
    ( 17, 1, 1959),
    ( 18, 1, 1953),
    ( 18, 2, 1991),
    ( 18, 3, 2001),
    ( 18, 4, 2010),
    ( 18, 5, 2020),
    ( 19, 1, 1975),
    ( 19, 4, 1993),
    ( 19, 2, 1978),
    ( 19, 3, 1980),
    ( 19, 5, 1997),
    ( 20, 2, 2004),
    ( 20, 1, 2000),
    ( 20, 3, 2020),
    ( 21, 1, 2012),
    ( 21, 2, 2018),
    ( 21, 3, 2020),
    ( 22, 1, 2003),
    ( 22, 2, 2010),
    ( 23, 1, 2007),
    ( 23, 2, 2008),
    ( 23, 3, 2010),
    ( 24, 1, 1978),
    ( 24, 2, 1987),
    ( 24, 3, 2014),
    ( 25, 1, 2022),
    ( 25, 2, 2023);



-- ----------------------------
-- Table structure for BOOKS_LANGUAGES
-- ----------------------------
CREATE TABLE books_languages (
    book_id INT,
    lang_id INT,
    PRIMARY KEY (book_id, lang_id),
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (lang_id) REFERENCES languages (lang_id)
);
-- ----------------------------
-- Records of BOOKS_LANGUAGE
-- ----------------------------
INSERT INTO books_languages (book_id, lang_id)
VALUES 
(1, 1),
(1, 2),
(1, 5),
(2, 1),
(2, 2),
(2, 4),
(2, 5),
(3, 5),
(4, 1),
(4, 2),
(4, 4),
(4, 5),
(5, 2),
(5, 3),
(5, 4),
(5, 5),
(6, 1),
(6, 2),
(6, 4),
(6, 5),
(7, 2),
(7, 3),
(7, 4),
(7, 5),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(9, 1),
(9, 4),
(10, 1),
(10, 2),
(10, 4),
(12, 1),
(12, 2),
(12, 3),
(12, 5),
(13, 1),
(13, 2),
(13, 4),
(13, 5),
(14, 1),
(14, 2),
(14, 3),
(14, 4),
(14, 5),
(15, 1),
(15, 4),
(15, 5),
(16, 1),
(16, 2),
(16, 3),
(16, 4),
(16, 5),
(17, 1),
(17, 2),
(17, 3),
(17, 4),
(17, 5),
(18, 1),
(18, 2),
(18, 3),
(18, 4),
(18, 5),
(19, 1),
(19, 2),
(19, 4),
(19, 5),
(20, 1),
(20, 2),
(20, 3),
(20, 4),
(20, 5),
(21, 1),
(21, 2),
(21, 3),
(21, 4),
(21, 5),
(22, 1),
(22, 3),
(22, 4),
(22, 5),
(23, 1),
(23, 2),
(23, 3),
(24, 1),
(24, 3),
(24, 4),
(24, 5),
(25, 1),
(25, 2),
(25, 3),
(25, 4),
(25, 5);


-- ----------------------------
-- Table structure for COURSES
-- ----------------------------
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) UNIQUE NOT NULL,
    course_code CHAR(6) UNIQUE NOT NULL
);
-- ----------------------------
-- Records of COURSES
-- ----------------------------
INSERT INTO courses (course_name, course_code)
VALUES 
    ('Artificial Intelligence', 'C001'),
    ('Computer Science', 'C002'),
    ('Data Analytics', 'C003'),
    ('Information Security', 'C004'),
    ('Networking', 'C005'),
    ('Software Engineering', 'C006'),
    ('Web Development', 'C007'),
    ('Cyber Security', 'C008');


-- ----------------------------
-- Table structure for STUDENTS
-- ----------------------------
CREATE TABLE students (
    stu_id SERIAL PRIMARY KEY,
    stu_course INT,
    stu_name VARCHAR(50) NOT NULL,
    stu_mid_name VARCHAR(50),
    stu_last_name VARCHAR(50) NOT NULL,
    stu_addr1 VARCHAR(50) NOT NULL,
    stu_addr2 VARCHAR(50),
    stu_city VARCHAR(60) NOT NULL,
    stu_postcode CHAR(8) NOT NULL,
    stu_phone VARCHAR(15) NOT NULL,
    stu_email VARCHAR(100) UNIQUE NOT NULL,
    stu_enroll DATE,
    FOREIGN KEY (stu_course) REFERENCES courses (course_id)
);
-- ----------------------------
-- Records of STUDENTS
-- ----------------------------
INSERT INTO students (stu_course, stu_name, stu_mid_name, stu_last_name, stu_addr1, stu_addr2, stu_city, stu_postcode, stu_phone, stu_email, stu_enroll)
VALUES 
(5, 'Michael', NULL, 'Baker', '396 39 William IV St, Charing Cross', NULL, 'Portsmouth', 'PO16 7GF', '075682957361', 'wfho7@myport.ac.uk', '2021-09-25'),
(6, 'Kar Yan', 'Lu', 'Long', '579 39 William IV St, Charing Cross', NULL, 'Liverpool', 'L16 4PB', '0710740505', 'huiky1@myport.ac.uk', '2022-08-29'),
(7, 'Mai', 'Sue', 'Peterson', '594 Lower Temple Street', 'Apt 33', 'Birmingham', 'B17 8QF', '071219345695', 'maiishi@myport.ac.uk', '2023-02-12'),
(2, 'Wai San', NULL, 'Kong', '50 Stephenson Street', 'Apt 25', 'Birmingham', 'B5 7PA', '027346955187', 'mok6@myport.ac.uk', '2021-10-31'),
(4, 'Jessy', NULL, 'Tsang', '932 Papworth Rd, Trumpington', NULL, 'Cambridge', 'CB2 1TN', '071223864725', 'kojima46@myport.ac.uk', '2023-01-01'),
(4, 'Hana', NULL, 'Cheng', '170 New Wakefield St', 'Block 29', 'Manchester', 'M20 6YR', '011613413870', 'hanaishii@myport.ac.uk', '2022-02-11'),
(6, 'Philip', NULL, 'Patterson', '971 Portland St', NULL, 'Portsmouth', 'PO7 5JH', '07726387533', 'phrobe@myport.ac.uk', '2022-04-21'),
(1, 'Jessica', NULL, 'Look', '513 Regent Street', NULL, 'London', 'E14 7DF', '0751697409', 'hernandezjessica301@myport.ac.uk', '2022-11-29'),
(3, 'Ming', 'Maria', 'Gutierrez', '397 39 William IV St, Charing Cross', 'Suite 41', 'Liverpool', 'L13 9AQ', '01511397891', 'hsuanmin2@myport.ac.uk', '2023-06-09'),
(4, 'Kazuma', NULL, 'Turner', '172 Maddox Street', NULL, 'London', 'NW1 5AL', '2032422136', 'kt909@myport.ac.uk', '2022-11-12'),
(NULL, 'Edison', NULL, 'Taylor', '182 London Road',NULL, 'Portsmouth', 'PO2 7AF', '07452698698','edison.taylor@myport.ac.uk','2023-07-01') ;


-- ----------------------------
-- Table structure for LIBRARIANS
-- ----------------------------
CREATE TABLE librarians (
    lib_id SERIAL PRIMARY KEY,
    lib_name VARCHAR(50) NOT NULL,
    lib_last_name VARCHAR(50) NOT NULL,
    lib_email VARCHAR(100) UNIQUE NOT NULL
);
-- ----------------------------
-- Records of LIBRARIANS
-- ----------------------------
INSERT INTO librarians (lib_name, lib_last_name, lib_email)
VALUES 
('James', 'Scott', 'james.scott@uop.ac.uk'),
('Anthony', 'Silva', 'silva.anthony@uop.ac.uk'),
('Earl', 'Snyder', 'earl.snyder6@uop.ac.uk');


-- ----------------------------
-- Table structure for BOOKS_INVENTORY
-- ----------------------------
CREATE SEQUENCE inv_id_seq;
CREATE TABLE books_inventory (
    inv_id VARCHAR(10) DEFAULT (
        'INV-' || to_char(nextval('inv_id_seq'), 'FM00000')
    ) PRIMARY KEY,
    ed_id INT,
    book_id INT,
    total_copies INT NOT NULL CHECK (total_copies >= 0),
    FOREIGN KEY (ed_id) REFERENCES books_editions (ed_id),
    FOREIGN KEY (book_id) REFERENCES books (book_id)
);
-- ----------------------------
-- Records of BOOKS_INVENTORY
-- ----------------------------
INSERT INTO books_inventory (ed_id, book_id, total_copies)
VALUES 
(1, 1, 6),
(2, 1, 2),
(3, 2, 9),
(4, 2, 4),
(5, 2, 7),
(6, 3, 1),
(7, 4, 3),
(8, 5, 2),
(9, 5, 5),
(10, 6, 10),
(11, 7, 1),
(12, 8, 7),
(13, 9, 3),
(14, 9, 8),
(15, 9, 2),
(16, 9, 6),
(17, 10, 9),
(18, 11, 4),
(19, 11, 8),
(20, 12, 3),
(21, 12, 1),
(22, 13, 2),
(23, 14, 3),
(24, 15, 6),
(25, 16, 5),
(26, 17, 7),
(27, 18, 9),
(28, 18, 8),
(29, 18, 6),
(30, 18, 7),
(31, 18, 2),
(32, 19, 3),
(33, 19, 6),
(34, 19, 3),
(35, 19, 4),
(36, 19, 9),
(37, 20, 8),
(38, 20, 7),
(39, 20, 5),
(40, 21, 3),
(41, 21, 1),
(42, 21, 4),
(43, 22, 7),
(44, 22, 8),
(45, 23, 6),
(46, 23, 5),
(47, 23, 3),
(48, 24, 9),
(49, 24, 10),
(50, 24, 4),
(51, 25, 6),
(52, 25, 2);
  


-- ----------------------------
-- Table structure for loan
-- ----------------------------
CREATE TYPE loan_status AS ENUM ('Borrowed', 'Returned');
CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    stu_id INT,
    lib_id INT,
    inv_id VARCHAR(9),
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status loan_status,
    CONSTRAINT unique_loan UNIQUE (stu_id, inv_id, loan_date),
    CONSTRAINT check_loan_dates CHECK (return_date >= loan_date),
    FOREIGN KEY (stu_id) REFERENCES students (stu_id),
    FOREIGN KEY (lib_id) REFERENCES librarians (lib_id),
    FOREIGN KEY (inv_id) REFERENCES books_inventory (inv_id)
);
-- ----------------------------
-- Records of loan
-- ----------------------------
INSERT INTO loans (stu_id, lib_id, inv_id, loan_date, due_date, return_date, status) 
VALUES
(6, 3, 'INV-00016', '2023-05-05', '2023-06-14', '2023-05-11', 'Returned'),
(8, 3, 'INV-00051', '2022-12-06', '2023-07-06', '2023-05-19', 'Returned'),
(1, 2, 'INV-00032', '2023-02-08', '2023-03-11', NULL, 'Borrowed'),
(7, 2, 'INV-00017', '2023-05-08', '2023-07-09', '2023-06-25', 'Returned'),
(1, 3, 'INV-00028', '2023-03-24', '2023-05-13', NULL, 'Borrowed'),
(4, 3, 'INV-00009', '2022-12-26', '2023-02-25', NULL, 'Borrowed'),
(8, 3, 'INV-00015', '2022-06-22', '2022-10-07', '2022-07-11', 'Returned'),
(2, 3, 'INV-00004', '2022-09-03', '2023-02-06', NULL, 'Borrowed'),
(9, 3, 'INV-00030', '2023-02-24', '2023-07-08', NULL, 'Borrowed'),
( 6, 3, 'INV-00020', '2023-04-26', '2023-05-02', '2023-05-19', 'Returned'),
( 10, 3, 'INV-00032', '2022-02-04', '2022-10-26', '2022-05-28', 'Returned'),
( 10, 2, 'INV-00044', '2022-01-29', '2022-05-23', '2022-07-25', 'Returned'),
( 1, 3, 'INV-00012', '2023-04-24', '2023-06-01', NULL, 'Borrowed'),
( 2, 3, 'INV-00005', '2022-12-06', '2023-07-10', NULL, 'Borrowed'),
( 5, 3, 'INV-00013', '2022-12-10', '2023-01-01', NULL, 'Borrowed'),
( 7, 3, 'INV-00016', '2022-03-08', '2023-12-15', '2022-07-23', 'Returned'),
( 10, 1, 'INV-00024', '2022-09-16', '2023-01-08', NULL, 'Borrowed'),
( 2, 3, 'INV-00009', '2023-04-30', '2023-06-07', NULL, 'Borrowed'),
( 6, 2, 'INV-00032', '2022-12-22', '2023-06-10', NULL, 'Borrowed'),
( 9, 1, 'INV-00040', '2022-10-11', '2022-11-11', '2022-10-11', 'Returned'),
( 8, 3, 'INV-00034', '2022-09-07', '2023-03-25', '2022-10-27', 'Returned'),
( 6, 3, 'INV-00050', '2023-06-23', '2023-09-10', '2023-07-30', 'Returned'),
( 1, 1, 'INV-00052', '2023-03-13', '2023-12-31', '2023-10-07', 'Returned'),
( 10, 1, 'INV-00005', '2022-10-08', '2023-01-30', NULL, 'Borrowed'),
( 1, 3, 'INV-00045', '2023-03-04', '2023-03-11', NULL, 'Borrowed'),
( 7, 2, 'INV-00027', '2023-03-30', '2023-08-08', '2023-10-06', 'Returned'),
( 4, 1, 'INV-00003', '2023-02-11', '2023-10-27', '2023-03-18', 'Returned'),
( 7, 2, 'INV-00004', '2023-01-20', '2023-03-11', NULL, 'Borrowed'),
( 1, 1, 'INV-00001', '2023-05-31', '2023-06-25', '2023-11-17', 'Returned'),
( 3, 3, 'INV-00014', '2023-05-01', '2023-08-20', '2023-09-06', 'Returned'),
( 1, 1, 'INV-00016', '2022-09-23', '2023-04-18', '2022-12-16', 'Returned'),
( 6, 1, 'INV-00030', '2022-09-30', '2023-03-14', NULL, 'Borrowed'),
( 3, 2, 'INV-00011', '2023-02-16', '2023-05-21', '2023-04-27', 'Returned'),
( 5, 3, 'INV-00041', '2023-06-17', '2023-11-23', '2023-09-15', 'Returned'),
( 8, 3, 'INV-00014', '2023-05-17', '2023-09-05', '2023-06-04', 'Returned'),
( 6, 1, 'INV-00048', '2022-11-13', '2023-04-28', '2022-12-06', 'Returned'),
( 6, 2, 'INV-00020', '2023-01-06', '2023-02-01', '2023-04-17', 'Returned'),
( 2, 3, 'INV-00010', '2022-09-27', '2022-11-29', '2022-10-20', 'Returned'),
( 9, 2, 'INV-00017', '2022-12-26', '2023-03-27', '2023-05-01', 'Returned'),
( 2, 3, 'INV-00024', '2022-09-16', '2023-04-16', NULL, 'Borrowed'),
( 7, 2, 'INV-00008', '2023-06-07', '2023-12-24', '2023-11-23', 'Returned'),
( 9, 1, 'INV-00036', '2022-09-06', '2023-06-08', '2022-11-18', 'Returned'),
( 2, 1, 'INV-00034', '2022-11-20', '2023-01-02', '2023-01-06', 'Returned'),
( 9, 3, 'INV-00038', '2022-11-16', '2023-04-27', NULL, 'Borrowed'),
( 8, 3, 'INV-00035', '2022-03-27', '2022-12-12', NULL, 'Borrowed'),
( 6, 2, 'INV-00011', '2023-01-23', '2023-11-23', '2023-10-29', 'Returned'),
( 4, 2, 'INV-00032', '2023-07-05', '2023-09-13', '2023-08-03', 'Returned'),
( 6, 1, 'INV-00047', '2022-11-10', '2023-03-15', NULL, 'Borrowed'),
( 3, 3, 'INV-00042', '2023-04-06', '2023-06-11', NULL, 'Borrowed'),
( 6, 1, 'INV-00036', '2022-10-13', '2023-01-27', NULL, 'Borrowed'),
( 6, 1, 'INV-00043', '2023-01-16', '2023-01-21', '2023-02-23', 'Returned'),
( 9, 1, 'INV-00042', '2022-11-27', '2023-01-25', NULL, 'Borrowed'),
( 9, 3, 'INV-00016', '2022-09-21', '2022-12-09', NULL, 'Borrowed'),
( 6, 3, 'INV-00045', '2022-12-27', '2023-03-13', '2023-04-22', 'Returned'),
( 8, 1, 'INV-00034', '2023-02-08', '2023-05-14', NULL, 'Borrowed'),
( 5, 3, 'INV-00018', '2023-02-01', '2023-11-23', NULL, 'Borrowed'),
( 5, 3, 'INV-00004', '2022-10-21', '2023-06-30', '2023-12-21', 'Returned'),
( 10, 3, 'INV-00037', '2023-05-16', '2023-08-19', '2023-06-08', 'Returned'),
( 4, 1, 'INV-00046', '2023-06-06', '2023-12-26', '2023-11-20', 'Returned'),
( 10, 1, 'INV-00021', '2023-01-19', '2023-10-12', '2023-05-06', 'Returned'),
( 6, 2, 'INV-00040', '2023-07-11', '2023-11-06', NULL, 'Borrowed'),
( 7, 1, 'INV-00042', '2022-11-23', '2023-06-03', '2023-03-10', 'Returned'),
( 7, 2, 'INV-00038', '2022-11-10', '2023-03-22', '2023-06-13', 'Returned'),
( 8, 1, 'INV-00035', '2023-07-07', '2023-08-02', '2023-08-02', 'Returned'),
( 3, 3, 'INV-00023', '2023-04-22', '2023-05-25', NULL, 'Borrowed'),
( 7, 2, 'INV-00010', '2023-03-29', '2023-10-07', NULL, 'Borrowed'),
( 4, 3, 'INV-00047', '2023-05-09', '2023-07-26', '2023-06-05', 'Returned'),
( 2, 1, 'INV-00052', '2022-10-29', '2022-11-03', NULL, 'Borrowed'),
( 5, 1, 'INV-00001', '2023-03-25', '2023-11-20', '2023-10-30', 'Returned'),
( 10, 2, 'INV-00046', '2023-05-05', '2023-08-31', NULL, 'Borrowed'),
( 2, 2, 'INV-00020', '2023-01-14', '2023-06-15', '2023-04-15', 'Returned'),
( 8, 1, 'INV-00025', '2023-02-13', '2023-06-18', NULL, 'Borrowed'),
( 10, 2, 'INV-00023', '2023-04-19', '2023-10-31', NULL, 'Borrowed'),
( 9, 1, 'INV-00049', '2023-04-06', '2023-11-30', '2023-04-10', 'Returned'),
( 1, 3, 'INV-00035', '2023-02-27', '2023-05-05', NULL, 'Borrowed'),
( 6, 2, 'INV-00044', '2023-06-29', '2023-09-30', '2023-07-04', 'Returned'),
( 5, 1, 'INV-00051', '2023-05-29', '2023-10-15', NULL, 'Borrowed'),
( 4, 3, 'INV-00004', '2023-06-30', '2023-09-15', '2023-10-05', 'Returned'),
( 6, 2, 'INV-00043', '2023-03-11', '2023-11-03', '2023-11-23', 'Returned'),
( 9, 3, 'INV-00017', '2023-05-24', '2023-05-31', NULL, 'Borrowed'),
( 6, 1, 'INV-00045', '2023-03-18', '2023-11-16', '2023-08-27', 'Returned'),
( 4, 2, 'INV-00012', '2022-10-28', '2022-12-02', NULL, 'Borrowed'),
( 6, 1, 'INV-00019', '2023-04-01', '2023-12-06', '2023-07-24', 'Returned'),
( 10, 2, 'INV-00002', '2022-09-16', '2023-01-05', NULL, 'Borrowed'),
( 5, 3, 'INV-00050', '2023-01-12', '2023-04-05', NULL, 'Borrowed'),
( 1, 2, 'INV-00024', '2022-09-18', '2023-03-13', NULL, 'Borrowed'),
( 4, 3, 'INV-00044', '2022-10-27', '2023-05-25', '2022-12-11', 'Returned'),
( 10, 2, 'INV-00033', '2023-04-20', '2023-11-18', NULL, 'Borrowed'),
( 10, 2, 'INV-00042', '2022-12-23', '2023-01-18', '2023-02-07', 'Returned'),
( 4, 3, 'INV-00015', '2023-04-02', '2023-08-25', NULL, 'Borrowed'),
( 8, 2, 'INV-00007', '2023-01-27', '2023-03-02', '2023-04-23', 'Returned'),
( 2, 3, 'INV-00036', '2023-03-03', '2023-06-23', '2023-04-13', 'Returned'),
( 2, 1, 'INV-00049', '2023-06-08', '2023-08-28', '2023-07-19', 'Returned'),
( 3, 3, 'INV-00044', '2023-03-22', '2023-04-18', '2023-03-25', 'Returned'),
( 5, 3, 'INV-00032', '2023-06-06', '2023-08-25', '2023-09-12', 'Returned'),
( 2, 1, 'INV-00033', '2023-02-15', '2023-04-05', '2023-02-24', 'Returned'),
( 7, 2, 'INV-00009', '2022-12-09', '2023-03-02', NULL, 'Borrowed'),
( 7, 3, 'INV-00044', '2022-12-31', '2023-02-20', '2023-02-07', 'Returned'),
( 5, 3, 'INV-00005', '2023-05-06', '2023-10-13', NULL, 'Borrowed'),
( 9, 3, 'INV-00031', '2023-05-11', '2023-06-12', '2023-06-30', 'Returned');
lib_db.sql
Displaying lib_db.sql.