-- Table structure for 'authors'
CREATE TABLE authors (
    auth_id SERIAL PRIMARY KEY,
    auth_name VARCHAR(30) NOT NULL,
    auth_last_name VARCHAR(30) NOT NULL,
    auth_phone VARCHAR(15),
    auth_country VARCHAR(50)
);

-- Table structure for 'publishers'
CREATE TABLE publishers (
    pub_id SERIAL PRIMARY KEY,
    pub_name VARCHAR(100) NOT NULL,
    pub_city VARCHAR(50)
);

-- Table structure for 'books'
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    pub_id INT,
    book_isbn VARCHAR(17) UNIQUE,
    book_title VARCHAR(100) NOT NULL,
    book_pub_year INT CHECK (book_pub_year BETWEEN 1800 AND 2024),
    book_pages INT CHECK (book_pages > 0),
    FOREIGN KEY (pub_id) REFERENCES publishers(pub_id) ON DELETE SET NULL
);

-- Table structure for 'genres'
CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

-- Intersection table for 'books' and 'genres'
CREATE TABLE books_genres (
    book_id INT,
    genre_id INT,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
);

-- Intersection table for 'books' and 'authors'
CREATE TABLE books_authors (
    book_id INT,
    auth_id INT,
    PRIMARY KEY (book_id, auth_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (auth_id) REFERENCES authors(auth_id) ON DELETE CASCADE
);

-- Insert Authors (3 Entries)
INSERT INTO authors (auth_id, auth_name, auth_last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Johnson');

-- Insert Publishers (2 Entries)
INSERT INTO publishers (pub_id, pub_name, pub_city) VALUES
(1, 'Penguin Books', 'New York'),
(2, 'HarperCollins', 'London');

-- Insert Books (10 Entries)
INSERT INTO books (book_id, pub_id, book_isbn, book_title, book_pub_year, book_pages) VALUES
(1, 1, '978-0000000001', 'The Great Adventure', 2020, 320),
(2, 1, '978-0000000002', 'Mystery of the Lost', 2018, 250),
(3, 2, '978-0000000003', 'Science for Everyone', 2019, 400),
(4, 2, '978-0000000004', 'History of Time', 2021, 300),
(5, 1, '978-0000000005', 'Modern Technology', 2022, 500),
(6, 2, '978-0000000006', 'Cooking Mastery', 2020, 280),
(7, 1, '978-0000000007', 'Fantasy World', 2017, 450),
(8, 2, '978-0000000008', 'Deep Space Exploration', 2021, 380),
(9, 1, '978-0000000009', 'Economic Trends', 2019, 330),
(10, 2, '978-0000000010', 'The Final Mystery', 2022, 420);

-- Insert Genres (3 Entries)
INSERT INTO genres (genre_id, genre_name) VALUES
(1, 'Fiction'),
(2, 'Science'),
(3, 'History');

-- Insert Books-Genres Relationships
INSERT INTO books_genres (book_id, genre_id) VALUES
(1, 1), (6, 2), (9, 3),
(2, 1), (2, 3),
(7, 1), (7, 2),
(3, 1), (3, 2), (3, 3),
(4, 1), (4, 2), (4, 3),
(5, 1), (5, 2), (5, 3),
(8, 1), (8, 2), (8, 3),
(10, 1), (10, 2), (10, 3);

-- Insert Books-Authors Relationships
INSERT INTO books_authors (book_id, auth_id) VALUES
(1, 1), (2, 2),
(3, 2), (4, 2), (5, 2), (6, 2), (7, 2),
(2, 3), (3, 3), (4, 3), (5, 3), (7, 3),
(8, 3), (9, 3), (7, 3),
(10, 1), (10, 2), (10, 3);





---QUERIES---

CREATE VIEW book_details AS
SELECT
    b.book_id AS "Book ID",
    b.book_title AS "Title",
    g.genre_name AS "Genre",
    p.pub_name AS "Publisher",
    b.book_pub_year AS "Publication Year"
FROM books b
JOIN genres g ON b.genre_id = g.genre_id
JOIN publishers p ON b.pub_id = p.pub_id
ORDER BY g.genre_name;



/*Based on the previous VIEW, create a new query that will return concatenated full author(s) name, the book title and genre for all books published in 2020 and after. Order from the most recent book. */

CREATE VIEW books_details_improved AS
SELECT 
    b.book_id AS "Book ID", 
    STRING_AGG(CONCAT(a.auth_name, ' ', a.auth_last_name), ', ') AS "Author Name",
    b.book_title AS "Book Title", 
    g.genre_name AS "Genre Name", 
    p.pub_name AS "Publisher", 
    b.book_pub_year AS "Publishing Year"
FROM books b
JOIN books_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.auth_id = a.auth_id
JOIN books_genres bg ON b.book_id = bg.book_id
JOIN genres g ON bg.genre_id = g.genre_id
LEFT JOIN publishers p ON b.pub_id = p.pub_id
WHERE b.book_pub_year >= 2020
GROUP BY b.book_id, b.book_title, g.genre_name, p.pub_name, b.book_pub_year
ORDER BY g.genre_name;


\c dsd_libdb

CREATE VIEW student_loan_details AS
SELECT
    s.stu_id as "Student ID",
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) as "Student Name", 
    l.loan_id as "Loan ID", 
    l.loan_date as "Loan Date", 
    l.due_date as "Due Date",
    l.status as "Loan Status", 
    i.inv_id as "Inventory ID", 
    b.book_title as "Book Title"
FROM loans l  
JOIN students s ON l.stu_id = s.stu_id
JOIN books_inventory i ON i.inv_id = l.inv_id
Right JOIN books b ON b.book_id = i.book_id;


/*Using  student_loan_details VIEW, identify students who have overdue books (name of the book), along with details about the loan (id, dates status) and the course they are enrolled in.*/

CREATE VIEW overdue_books AS
SELECT
    s.stu_id as "Student ID",
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) as "Student Name",
    b.book_title as "Book Title",
    l.loan_id as "Loan ID",
    l.loan_date as "Loan Date",
    l.due_date as "Due Date",
    l.status as "Loan Status",
    c.course_name as "Course Name"
FROM loans l
JOIN students s ON l.stu_id = s.stu_id
JOIN books_inventory i ON i.inv_id = l.inv_id
JOIN books b ON b.book_id = i.book_id
JOIN courses c ON c.course_id = s.stu_course
WHERE l.status = 'Borrowed';

/*Using the books_details view, find all books details whose titles contain the word 'Science'.*/

CREATE VIEW science_books AS
SELECT *
FROM books
WHERE LOWER(book_title) LIKE '%science%';

/*Using the books_details view, find all books details whose publishers' name starts with 'penguin'.*/

CREATE VIEW penguin_books AS
SELECT *
FROM books
JOIN publishers p ON books.pub_id = p.pub_id
WHERE LOWER(p.pub_name) LIKE 'penguin%';


/*Using the books_details view, find all books whose titles start with 'The' followed by any word, then end with a word that starts with 'of' (e.g., 'The Secrets of the Mind', 'The Art of Learning').*/

CREATE VIEW the_of_books AS
SELECT *
FROM books
WHERE LOWER(book_title) LIKE 'the % %of%';

/*Analysing the query, which attribute or attributes would be the best candidates for indexing to improve query performance? Why?
Apply the INDEX(s) and demonstrate query execution time improvement. 
*/

SELECT
    b.book_id AS "Book ID",
    b.book_title AS "Title",
    CONCAT(a.auth_name,' ', COALESCE(a.auth_mid_name,''),' ', a.auth_last_name) AS "Author Full Name",
    b.book_pub_year AS "Publication Year",
    g.genre_name AS "Genre"
FROM books b
JOIN genres g ON b.genre_id = g.genre_id
JOIN books_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.auth_id = a.auth_id
WHERE b.book_pub_year > 2000 AND g.genre_name = 'Science';

-- Index on book_pub_year
CREATE INDEX idx_book_pub_year ON books(book_pub_year);

-- Index on genre_name  
CREATE INDEX idx_genre_name ON genres(genre_name);

-- Index on auth_name, auth_mid_name, auth_last_name
CREATE INDEX idx_auth_name ON authors(auth_name);

SELECT indexname, tablename FROM pg_indexes WHERE tablename = 'authors';
--still no idea how this works 

/*List all book titles that are in Chinese and German order in alphabetical order. You must use IN.  
*/

CREATE VIEW chinese_german_books AS
SELECT 
book_title as "Book Title",
lang_name as "Language Name"
FROM books b 
JOIN books_languages bl on b.book_id = bl.book_id
JOIN languages l on bl.lang_id = l.lang_id
WHERE LOWER(lang_name) LIKE '%chinese%' OR LOWER(lang_name) LIKE '%german%'
ORDER BY lang_name ASC;
 
/*List the course name and code that do not have any student registered. 
*/

CREATE VIEW empty_courses AS
SELECT 
c.course_name as "Course Name", 
c.course_code as "Course Code"
FROM courses c
LEFT JOIN students s ON c.course_id = s.stu_course
WHERE s.stu_course IS NULL;

/*List all the books that are meeting these conditions:
They are published between 2000 and 2020
They have pages between 200 and 300
Or pages between 400 and 500
NOTE: Books having pages 301 till 399 should not be returned. */

CREATE VIEW books_with_pages AS
SELECT 
book_title as "Book Title",
book_pub_year as "Publication Year",
book_pages as "Pages"
FROM books
WHERE 
book_pub_year BETWEEN 2000 AND 2020
AND (200 <= book_pages AND book_pages <= 300)
OR (400 <= book_pages AND book_pages <= 500);

