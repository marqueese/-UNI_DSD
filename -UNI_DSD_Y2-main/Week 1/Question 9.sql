SELECT 
    aw.work_title as "Artwork Name"
FROM artist a
JOIN creates c ON a.artist_id = c.artist_id
JOIN artwork aw ON c.artwork_id = aw.artwork_id
WHERE artist_name = 'Lolo';