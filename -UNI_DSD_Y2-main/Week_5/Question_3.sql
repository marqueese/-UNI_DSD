SELECT COUNT(*)
FROM information_schema.views
WHERE table_schema NOT IN ('pg_catalog', 'information_schema');

--output 7 