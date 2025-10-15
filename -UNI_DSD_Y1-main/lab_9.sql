\c dsd_libdb
--Write a query to retrieve all book titles and publication year of all books with more than 500 pages--

SELECT 
book_title as "Book Title", 
book_pub_year as "Publication Year",
book_pages as "Pages"
FROM books
WHERE book_pages > 500;

--Find all authors who have 'Michael' as their first name. List their full name as one column.--

SELECT 
CONCAT_WS(' ' ,auth_name, auth_mid_name, auth_last_name) as "Authors name"
From authors 
WHERE auth_name = 'Michael';

--Retrieve all details of students (not the IDs) who have enrolled after the 1st of September 2021 and reside in Portsmouth.
--Create one column for the name, one for address and all the other details must have appropriate column name.

SELECT 
    CONCAT_WS(' ' ,stu_name, stu_mid_name, stu_last_name) as "Student Name",
    CONCAT_WS(' ' ,stu_addr1, stu_addr2, stu_city, stu_postcode) as "Student info",
    stu_email as "Student email",
    stu_phone as "Student phone number",
    stu_enroll as "Student enrollment"
FROM students 
WHERE 
    stu_enroll > '2021-09-01' AND 
    stu_city = 'Portsmouth';

--Find the titles of books that have been published between the years 2000 and 2005, inclusive. Sort them ascending on publication year. Format columns.--

SELECT 
book_title as "Book Title", 
book_pub_year as "Publication Year"
FROM books
WHERE book_pub_year BETWEEN 2000 AND 2006;

--List the full name of all authors who have any of their names starting with letter M (any name - first, mid, last).--

SELECT 
CONCAT_WS(' ' ,auth_name, auth_mid_name, auth_last_name) as "Authors name"
From authors 
WHERE 
    auth_name LIKE 'M%'
    OR auth_mid_name LIKE 'M%'
    OR auth_last_name LIKE 'M%';

--Retrieve the titles of all books that belong to either science fiction or action genres.

SELECT 
    book_title as "Book Title", 
    genre_name as "Genre Name"
FROM books JOIN genres on books.genre_id = genres.genre_id
WHERE 
    genre_name = 'Sci-Fi'
    OR genre_name = 'Action';

--Get the student name and last name as one column, who are not enrolled in the course with the course code 'C006'. 
--Show the courses name and code that are registered on. List them on student name alphabetical order.

SELECT 
    CONCAT_WS(' ' ,stu_name, stu_last_name) as "Student Name",
    stu_course as "Student Course",
    course_code as "Course code"
FROM students JOIN courses on students.stu_id = courses.course_id
WHERE 
    course_code != 'C006'
ORDER BY stu_name;

--Retrieve the titles of the first 10 books, sorted by their publication year in descending order and book title alphabetical order.--

SELECT 
    book_title as "Book Title", 
    book_pub_year as "Publication Year"
FROM books
ORDER BY book_pub_year DESC, book_title
LIMIT 10;
    
--List all the genres (no duplicates) of books that have been borrowed by students who have enrolled in Web Development course. 
--The output should be as below
SELECT DISTINCT
    genre_name as "Genre Name"
From books 
JOIN genres on books.genre_id = genres.genre_id
JOIN books_inventory on books.book_id = books_inventory.book_id
JOIN loans on books_inventory.inv_id = loans.inv_id 
JOIN students on students.stu_id = loans.stu_id
JOIN courses on students.stu_id = courses.course_id
WHERE 
    course_name = 'Web Development';

--Find all books published by Elsevier in 2015.

SELECT 
book_title as "Book Title"
FROM books
JOIN publishers on books.pub_id = publishers.pub_id
WHERE book_pub_year = 2015 AND pub_name = 'Elsevier';

--Get the full name in one column of all authors who have written 
--books with minimum 800 pages along with the book title and order them by ascending number of pages.

SELECT 
CONCAT_WS(' ' ,auth_name, auth_mid_name, auth_last_name) as "Authors name",
book_title as "Book Title"
FROM authors
JOIN books_authors on authors.auth_id = books_authors.auth_id
JOIN books on books_authors.book_id = books.book_id
WHERE book_pages >= 800
ORDER BY book_pages;

--Find all students studying the course of Software Engineering who lives in Portsmouth.
SELECT 
    CONCAT_WS(' ' ,stu_name, stu_mid_name, stu_last_name) as "Student Name"
FROM students s
JOIN courses c on s.stu_course = c.course_id
WHERE 
    course_name = 'Software Engineering' AND 
    stu_city = 'Portsmouth';

--List all books within science genre written by the author Ayato Murphy.

SELECT 
    book_title as "Book Name",
    genre_name as "Genre Name",
    CONCAT_WS(' ' ,auth_name, auth_mid_name, auth_last_name) as "Authors name"
From authors 
JOIN books_authors on authors.auth_id = books_authors.auth_id
JOIN books on books_authors.book_id = books.book_id
JOIN genres on books.genre_id = genres.genre_id
WHERE 
    auth_name = 'Ayato' AND
    auth_last_name = 'Murphy' AND
    genre_name = 'Sci-Fi';

--Get the details of books that are available in German and published by Wiley. Order them by publication year.

SELECT 
    book_title as "Book Name",
    book_pub_year as "Publication Year",
    lang_name as "Book Language"
From books b
JOIN books_languages bl on b.book_id = bl.book_id
JOIN languages l on bl.lang_id = l.lang_id
JOIN publishers p on b.pub_id = p.pub_id
WHERE 
    pub_name = 'Wiley' AND 
    lang_name = 'German';

--Get the full name of students (as one column), the date they borrowed the book, and the due date for the book titled 
--'Database Systems' that they have not yet returned. 
--We want to contact the student to remind them that they need to bring the book back.

SELECT 
    CONCAT_WS(' ' ,stu_name, stu_mid_name, stu_last_name) as "Student Name",
    loan_date as "Loan Date",
    due_date as "Due Date"
FROM books
    JOIN books_inventory on books.book_id = books_inventory.book_id
    JOIN loans on books_inventory.inv_id = loans.inv_id 
    JOIN students on students.stu_id = loans.stu_id
WHERE book_title = 'Database Systems' AND return_date is null;
