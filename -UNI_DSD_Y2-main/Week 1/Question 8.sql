SELECT 
    a.artist_name as "Artist Name",
    aw.work_title as "Artwork Name"
FROM artist a
JOIN creates c ON a.artist_id = c.artist_id
JOIN artwork aw ON c.artwork_id = aw.artwork_id
WHERE work_title = 'Rainbow';

SELECT * FROM artwork;