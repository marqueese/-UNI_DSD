--Q5 Create a full match schedule by listing all possible team and venue combinations.
CREATE OR REPLACE VIEW full_match_schedule AS
SELECT 
    t.team_name AS "Team Name",
    v.venue_name AS "Venue Name"
FROM teams t
CROSS JOIN venues v;