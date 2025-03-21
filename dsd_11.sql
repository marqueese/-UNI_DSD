\c dsd_11 

--Create a new INSERT in GENRES table as ‘History’ 
--(then list all genres and the total number of books in each genre, including the genres with no books allocated organised in genres alphabetical order.

INSERT INTO genres (genre_name) VALUES ('History');

SELECT 
    genre_name as "Genre name", 
    COUNT(b.book_id) as "Quantity "
FROM Genres g LEFT JOIN Books b ON g.genre_id = b.genre_id
GROUP BY g.genre_name
ORDER BY g.genre_name ASC;

--Question 2

SELECT 
    CONCAT(a.auth_name,' ', COALESCE(a.auth_mid_name, ''), ' ', a.auth_last_name) as "Full Name",
    COALESCE(b.book_title, 'N/A') as "Book Title",
FROM Authors a JOIN Books b on a.auth_id = b.book_id
ORDER BY a.auth_name, a.auth_last_name;

--Question 3 
SELECT 
    bi.inv_id AS "Inventory ID", 
    b.book_title AS "Book Title", 
    COALESCE(l.loan_id, 'N/A') AS "Loan ID"
FROM 
    books_inventory bi
    JOIN books b ON bi.book_id = b.book_id
    LEFT JOIN loans l ON bi.inv_id = l.inv_id 
WHERE 
    l.loan_id IS NULL 
ORDER BY 
    b.book_title ASC;

