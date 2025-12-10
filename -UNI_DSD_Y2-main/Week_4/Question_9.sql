
--Q9. Represent the query tree for this SQL query and label the root, nodes, and leaves:
SELECT 
    f.flight_no, 
    a.airport_name, 
    l.airline_name
FROM
flights f
JOIN routes r ON f.route_id = r.route_id
JOIN airports a ON r.destination_id = a.airport_id
JOIN airlines l ON f.airline_id = l.airline_id
WHERE l.airline_name = 'SkyJet'

            π flight_no, airport_name, airline_name
                            │
                    σ l.airline_name = 'SkyJet'
                            │
                ⋈ f.airline_id = l.airline_id
                        /                   \
        r.destination_id = a.airport_id     Airlines
                        /            \
                    f.route_id = r.route_id
                              /        \
                            Flights   Routes
                                          \
                                        Airports
