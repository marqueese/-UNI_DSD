/*List the author name and last name who have written books published after the year 2020. Use a subquery to identify these books and then relate them to their authors. Just the names, not the books or years.
*/

CREATE VIEW books_After_2020 AS
SELECT 
    a.auth_name AS "Author Forename",
    a.auth_last_name AS "Authur Surname"
FROM books b 
JOIN books_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.auth_id = a.auth_id
WHERE b.book_id IN (
    SELECT book_id
    FROM books
    WHERE book_pub_year > 2020
);


/*Modifying the previous query, list authors name and last name who have at least one edition of their books published after the year 2020, considering that the original publication might have been earlier. Just the names, not the books or years. There are several ways of achieving this query and one of them is using EXISTS.  Use a subquery.*/

CREATE VIEW more_book_Stuff AS
SELECT
    a.auth_name AS "Author Name",
    a.auth_last_name AS "Author Last Name"
FROM authors AS a
WHERE EXISTS (
        SELECT 1
        FROM books_authors AS ba
            JOIN books_editions AS be ON ba.book_id = be.book_id
        WHERE ba.auth_id = a.auth_id
            AND be.ed_year > 2020);

/*Extending from the previous query, list the author name & last name as one column, book title, original publication year and last edition year after 2020.
 Use subquery.*/

CREATE VIEW even_more_book_stuff AS
SELECT
    CONCAT(a.auth_name,' ',a.auth_last_name) AS "Author",
    b.book_title AS "Book Title",
    b.book_pub_year AS "Pub. Year",
    le."Last Ed." AS "Latest Ed. Year"
FROM authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
    JOIN books b ON ba.book_id = b.book_id
    JOIN (
        SELECT
            be.book_id,
        MAX(be.ed_year) AS "Last Ed." --highest value is the last
            FROM books_editions be
            GROUP BY be.book_id
            HAVING MAX(be.ed_year) > 2020
    ) le ON b.book_id = le.book_id
ORDER BY a.auth_name, a.auth_last_name, b.book_title;

/*List the name and last name of all authors that do not have a book in the genre of Science Fiction. Use subquery.*/

CREATE VIEW not_sci-fi AS
SELECT
    a.auth_name AS "Author Name",
    a.auth_last_name AS "Author Last Name"
FROM
    authors AS a
WHERE
    a.auth_id NOT IN (
    SELECT
        ba.auth_id
    FROM
        books_authors AS ba
        JOIN books AS b ON ba.book_id = b.book_id
        JOIN genres AS g ON b.genre_id = g.genre_id
    WHERE
    g.genre_name = 'Sci-Fi');

/*What is the genre with the highest number of books published, and how many books are published under this genre? Use subquery.*/

SELECT COUNT(name) from ...

-- Create a view named 'books_published' 
CREATE VIEW books_published AS
SELECT 
    g.genre_name as "Genre name",
    b.book_count as "Number of books"
FROM genres g-- Join the genres table with a subquery that calculates the book count per genre
JOIN (
    SELECT        
        genre_id,    
        COUNT(*) AS book_count-- Count the number of books for each genre
    FROM books 
        GROUP BY genre_id-- Group the books by genre_id to get the count per genre
    ORDER BY COUNT(*) DESC -- Order the results by the book count in descending order
    LIMIT 1     -- Limit the result to only the genre with the most books
) AS b 
ON g.genre_id = b.genre_id; -- Join on the genre_id from the genres table and the subquery result

/*list all students who have overdue loans for “PostgreSQL up and running" as of today date along with the loan and due dates and inventory id. 
Use subquery. */

SELECT
    "Student Name", 
    "Loan Date",
    "Due Date",
    "Inventory ID"
FROM 
    (SELECT * FROM student_loan_details
        WHERE "Book Title" = 'PostgreSQL up and running') AS Late --selecting those elements from that premade view
WHERE 
    Late."Due Date" < '2025-03-01' --within that view due date is less than current dat
    AND Late."Loan Status" = 'Borrowed'; -- borrowed
 

/*Using the books_details VIEW (created in LAB13) identify titles of books that have never been loaned out. 
Use a subquery to select books that do not appear in the student_loan_details view (books that have never been loaned).*/

SELECT bd."Title" AS "Book Title"
FROM book_details AS bd
WHERE bd."Book ID" NOT IN (
        SELECT be.book_id
        FROM student_loan_details AS sld
            JOIN books_inventory AS bi ON sld."Inventory ID" = bi.inv_id
            JOIN books_editions AS be ON bi.ed_id = be.ed_id
    );

/*What is the average loan duration for each book title? Order by the loan duration, in ascending order.
Use the books_details and student_loan_details views along with a subquery.*/

SELECT "Book Title",
    AVG ("Loan Duration") AS "Average Loan Duration" --get averaage for each book title
FROM (
        SELECT "Book Title", -- get book title
            ("Due Date" - "Loan Date") AS "Loan Duration" --minus due date from loan date to get duration 
        FROM student_loan_details --from the view
        LIMIT 10;
    ) AS sld
GROUP BY "Book Title" --each book can only appear once
ORDER BY "Average Loan Duration";

/* Find the titles of books that have no editions available in English, using a subquery to filter out books with English editions.*/
SELECT b.book_title AS "Book Title" -- book title
FROM books b
WHERE NOT EXISTS ( --where the thing in the query doesnt not appear
        SELECT 1     --each one of each item
        FROM books_languages bl     --from languages
            JOIN languages l ON bl.lang_id = l.lang_id --basic join
        WHERE l.lang_code = 'EN'  --where langauge = english
            AND bl.book_id = b.book_id 
    )
ORDER BY b.book_title;

-- get book title find ones where the edition is not in english 

--Identify the course with the highest number of enrolled students. Use a subquery to calculate the total number of students enrolled in each course, then identify the course with the highest enrolment. List the course name and the number of registered students. 

SELECT c.course_name AS "Course Name", -- gt course name 
    COUNT (s.stu_id) AS "Number of Enrolled Students" --count students per course
FROM courses c -- from courses table
    JOIN students s ON c.course_id = s.stu_course --basic join
GROUP BY C.course_id --group by course id 
HAVING COUNT (s.stu_id) = ( --after counting all students int courses
        SELECT MAX (enrollment_count) --get highest value from students in courses
        FROM (
                SELECT COUNT (stu_id) AS enrollment_count --set the maximum to enrollment count
                FROM students
                GROUP BY stu_course
            ) AS enrollment_totals
    );


