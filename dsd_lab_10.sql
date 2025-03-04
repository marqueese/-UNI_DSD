\c dsd_libdb

--List all genres and the count the number of  the books in each genre. Sort them in alphabetical order. 

SELECT 
genre_name AS "Genre",
COUNT(book_id) AS "Total Number of Books in Genre"
FROM Books JOIN Genres on books.genre_id = genres.genre_id
GROUP BY genre_name;

--List all authors and the count of books they have authored, ordered by the number of written books in descending order.

SELECT 
    auth_name AS "Author's Name",
    COUNT(b.book_id) AS "Total Number of Books Authored"
FROM Books b
JOIN Books_Authors ba ON b.book_id = ba.book_id
JOIN Authors a ON ba.auth_id = a.auth_id
GROUP BY auth_name
ORDER BY COUNT(b.book_id) DESC;

--List all publishers that have published minimum of 5 books.

SELECT 
    pub_name as "Publishers Name",
    COUNT(b.pub_id) as "Number of books published"
FROM books b
JOIN publishers p on b.pub_id = p.pub_id
GROUP BY pub_name
HAVING COUNT(b.pub_id) >= 5
ORDER BY COUNT(b.pub_id);

--List 2 most common languages of the books in our library.

SELECT 
    l.lang_name AS "Language Name",
    COUNT(b.book_id) AS "Number of Books in Language"
FROM books b
JOIN books_languages bl ON b.book_id = bl.book_id
JOIN languages l ON l.lang_id = bl.lang_id
GROUP BY l.lang_id
ORDER BY COUNT(b.book_id) DESC
LIMIT 2;

--List all books names that are available in both English and Spanish.

SELECT 
    book_title as "Book Title",
    l.lang_name as "Language",
    COUNT(b.book_id) as "Number of books in this language"
FROM books b
JOIN books_languages bl ON b.book_id = bl.book_id
JOIN languages l ON l.lang_id = bl.lang_id
WHERE l.lang_name IN ('English','Spanish')
GROUP BY b.book_title, l.lang_name
ORDER BY b.book_title, l.lang_name;

--List all authors who have written more than 10 books.

SELECT 
    auth_name as "Author Name",
    COUNT(b.book_id) as "Number of books"
FROM Books b
JOIN Books_Authors ba ON b.book_id = ba.book_id
JOIN Authors a ON ba.auth_id = a.auth_id
GROUP BY auth_name
HAVING COUNT(ba.book_id) > 10 
ORDER BY COUNT(ba.book_id);

--List all genres and the number of books in each genre written by the author with ID 4. 

SELECT 
    genre_name as "Genre Name", 
    COUNT(b.book_id) AS "Number of books"
FROM Books b JOIN Genres g on b.genre_id = g.genre_id
JOIN Books_Authors ba ON b.book_id = ba.book_id
JOIN Authors a ON ba.auth_id = a.auth_id
WHERE a.auth_id = 4
GROUP BY g.genre_name, a.auth_name
ORDER by g.genre_name, a.auth_name;

--List all authors that wrote books in Programming genre and count the number of books they wrote

SELECT 
    auth_name as "Author Name", 
    COUNT(b.book_id) AS "Number of books"
FROM Books b JOIN Genres g on b.genre_id = g.genre_id
JOIN Books_Authors ba ON b.book_id = ba.book_id
JOIN Authors a ON ba.auth_id = a.auth_id
WHERE g.genre_name = 'Programming'
GROUP BY a.auth_name
ORDER by a.auth_name;

--Find the intersection of book titles written by the author with ID 3 and the author with ID 4.

SELECT 
    b.book_title as "Book Name"
FROM Books b
JOIN Books_Authors ba ON b.book_id = ba.book_id
JOIN Authors a ON ba.auth_id = a.auth_id
WHERE a.auth_id IN (3, 4) -- specify the authors id
GROUP BY b.book_title
HAVING COUNT(DISTINCT a.auth_id) = 2 --checking for both authors 
ORDER BY b.book_title;

--How many books has each student borrowed? Order them on last name alphabetical order.

SELECT 
    s.stu_name as "Student name", 
    count(l.loan_id) as "Number of borrowed books"
FROM books_inventory bi JOIN loans l on bi.inv_id = l.inv_id 
JOIN books b on b.book_id = bi.book_id
JOIN students s on s.stu_id = l.stu_id
GROUP BY s.stu_id
ORDER BY COUNT(l.loan_id) ASC;

--What is the last enrolment date for each of the courses? List them from the latest enrolment date to the earliest.

SELECT 
    c.course_name AS "course name ",
    MAX(s.stu_enroll) as "Enrollment date"  -- gets the highest values to start with i think 
    FROM students s 
    JOIN courses c on s.stu_course = c.course_id
GROUP BY c.course_name   -- group with any that have the same course name
ORDER BY MAX(c.course_id) DESC;


--For each librarian (name and last name), what is the earliest loan date they have processed?

SELECT 
    CONCAT_WS(' ', li.lib_name, li.lib_last_name) as "Librarians Name",
    MAX(l.loan_date) as "Earliest loan date"
    FROM loans l 
    JOIN Librarians li on l.lib_id = li.lib_id
GROUP BY li.lib_name, li.lib_last_name
ORDER BY MAX(l.loan_date) ASC;

--For each genre, what's the average number of pages for the books? List them in alphabetical order. Can you round to nearest integer?

SELECT 
    genre_name AS "Genre",
    ROUND(AVG(book_pages), 0) AS "Average number of pages" --dont seperate or the terminal complains
    FROM Books JOIN Genres on books.genre_id = genres.genre_id
GROUP BY genre_name
ORDER BY genre_name ASC;

--What is the average number of days books are loaned for each genre?
--There are 8 genres in total - if you did the query correctly using inner joins, you will have only 6 genres returned. 
--Can you explain why do you give only 6 returns?


SELECT 
    genre_name AS "Genre",
    ROUND(AVG(loan_date - return_date), 0) AS "Number of days booked out" --dont seperate or the terminal complains
    FROM books_inventory bi 
    INNER JOIN loans l on bi.inv_id = l.inv_id 
    INNER JOIN books b on b.book_id = bi.book_id
    INNER JOIN genres g on b.genre_id = g.genre_id
WHERE l.status = 'Returned' --works as a temporary fix
GROUP BY g.genre_name;  -- for some reason there is an empty row

SELECT 
    genre_name AS "genre_name", 
    count(b.book_id) as "Number of books in genre"
    FROM Books b
    JOIN Genres g on b.genre_id = g.genre_id
GROUP BY genre_name
ORDER BY genre_name ASC;

 -- run this there are 8 genres booked out

SELECT * FROM genres;

-- there are 9 genres yet short story has no book 

-- best guess either there are genres with no books assigned eg(short story) and there are books loaned out that have yet to be returned
-- run a check on books loaned that are action

SELECT 
    g.genre_name AS "Genre",
    l.status as "Status"
    FROM books_inventory bi 
    INNER JOIN loans l on bi.inv_id = l.inv_id 
    INNER JOIN books b on b.book_id = bi.book_id
    INNER JOIN genres g on b.genre_id = g.genre_id
WHERE g.genre_name = 'Action'
GROUP BY g.genre_name, l.status;  
-- this confirms one action book is borrowed and yet to be returned