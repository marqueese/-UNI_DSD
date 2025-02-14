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
    a.auth_name AS "Author Forename",
    a.auth_last_name AS "Authur Surname",
    be.ed_year AS "Edition Year"
FROM books b 
JOIN books_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.auth_id = a.auth_id
JOIN books_editions be on b.book_id = be.book_id
WHERE b.book_id IN (
    SELECT book_id
    FROM books_editions 
    WHERE ed_year > 2020
);

/*Extending from the previous query, list the author name & last name as one column, book title, original publication year and last edition year after 2020.
 Use subquery.*/

CREATE VIEW even_more_book_stuff AS
SELECT 
    CONCAT_WS(' ', a.auth_name, a.auth_last_name),
    b.book_title AS "Book Title",
    b.book_pub_year AS "Original Publication Year",
    be.ed_year as "Last Edition",
    be.ed_year AS "Edition Year"
FROM books b 
JOIN books_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.auth_id = a.auth_id
JOIN books_editions be on b.book_id = be.book_id
WHERE b.book_id IN (
    SELECT book_id
    FROM books_editions 
    WHERE ed_year > 2020
);

/*List the name and last name of all authors that do not have a book in the genre of Science Fiction. Use subquery.*/

CREATE VIEW not_sci-fi AS
SELECT 
    a.auth_name AS "Author Forename",
    a.auth_last_name AS "Authur Surname",
JOIN books_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.auth_id = a.auth_id
JOIN genres g on b.genre_id = g.genre_id
WHERE b.book_id IN (
    SELECT genre_id
    FROM genres
    WHERE genre_name != "Science Fiction"
);
