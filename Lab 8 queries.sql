Lab 8 queries


--List the student name, last name and student email along with the course name and course code. Select only the required attributes. Do not use SELECT * FROM table_name.--

SELECT 
    stu_name as "Student Name", 
    stu_last_name "Student Surname", 
    stu_email as "Student Email", 
    stu_course as "Student Course",
    course_code as "Course Code"
FROM students JOIN courses ON students.stu_course = courses.course_id;

--Retrieve the book title, publication year, and number of pages for all books along with the corresponding genre name.--

SELECT 
    book_title as "Book Title", 
    book_pub_year as "Pulication Year",
    book_pages as "Page Number",
    genre_name as "Genre Name"
FROM books JOIN genres on books.genre_id = genres.genre_id;


--Get the author name (full name), book title, and publication year for all books written by authors.--

SELECT 
    auth_name as "Author forename", 
    auth_mid_name as "Middle Name",
    auth_last_name as "Surname", 
    book_title as "Book Title", 
    book_pub_year as "Publication Year"
FROM authors JOIN books on authors.auth_id = books.book_id;


--Retrieve the book title, edition publication year, and edition number for all book editions along with the corresponding publisher name.--

SELECT
    book_title as "Book Title", 
    ed_year as "Edition Publication Year", 
    ed_no as "Edition Number", 
    pub_name as "Publisher Name"
FROM books_editions JOIN books on books.book_id = books_editions.book_id 
JOIN publishers on books.pub_id = publishers.pub_id; 

-- List the book title, publication year, and language name for all books along with the corresponding edition number.
SELECT
    book_title as "Book Title", 
    book_pub_year as "Publication Year", 
    lang_name as "Book Language", 
    ed_no as "Edition number"
FROM books JOIN languages on books.book_id = languages.lang_id 
JOIN books_editions on books.book_id = languages.lang_id;

--Retrieve the book title and student name for all books borrowed by students along with the corresponding librarian name and surname.--

SELECT 
    book_title as "Book Title", 
    stu_name as "Student Name", 
    lib_name as "Librarian Name", 
    lib_last_name as "Librarian Last Name"
FROM books_inventory JOIN loans on books_inventory.inv_id = loans.inv_id 
JOIN librarians on loans.lib_id = librarians.lib_id 
JOIN students on students.stu_id = loans.stu_id 
JOIN books on books.book_id = books_inventory.book_id;

--Retrieve the book title, student name and last name, loan date, due date, and return date (if available) for all books borrowed by students.--

SELECT 
    book_title as "Book Title", 
    stu_name as "Student Name", 
    stu_last_name as "Student Surname", 
    loan_date as "Loan Date", 
    due_date as "Due Date", 
    return_date as "Return Date"
FROM books_inventory JOIN loans on books_inventory.inv_id = loans.inv_id 
JOIN books on books.book_id = books_inventory.book_id
JOIN students on students.stu_id = loans.stu_id;

--List the book name, genre, edition number and the number of copies of each edition.

SELECT 
    book_title as "Book Title", 
    genre_name as "Genre Name",
    ed_no as "Edition Number", 
    total_copies as "Total Copies"
FROM books JOIN genres on books.genre_id = genres.genre_id
JOIN books_editions on books.book_id = books_editions.book_id
JOIN books_inventory on books.book_id = books_inventory.book_id;
