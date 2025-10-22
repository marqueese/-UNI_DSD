
--Q7 Identify the root, nodes, and leaves for this query:
SELECT m.name,
  b.title,
  g.genre_name
FROM Members m
  JOIN Loans l ON m.member_id = l.member_id
  JOIN Books b ON l.book_id = b.book_id
  JOIN Genres g ON b.genre_id = g.genre_id
WHERE g.genre_name = 'Science Fiction';

--Root: m.name, b.title, g.genre_name
--Nodes: m.member_id = l.member_id, l.book_id = b.book_id, b.genre_id = g.genre_id
--Leaves: Members, Loans, Books, Genres
