CREATE TABLE animal_type (
    animal_type_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL UNIQUE,
    scientific_name VARCHAR(150) NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);

INSERT INTO animal_type (common_name, scientific_name, conservation_status)
VALUES
('Bengal Tiger', 'Panthera tigris tigris', 'Endangered'),
('Arctic Wolf', 'Canis lupus arctos', 'Least Concern');

CREATE TABLE menagerie (
    menagerie_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    date_acquired DATE NOT NULL,
    gender CHAR(1) NOT NULL,
    acquired_from VARCHAR(250) NOT NULL,
    name VARCHAR(50) NOT NULL,
    notes TEXT NOT NULL,
    FOREIGN KEY (common_name) REFERENCES animal_type (common_name)
);

INSERT INTO menagerie (common_name, date_acquired, gender, acquired_from, name, notes)
VALUES
('Bengal Tiger', '2011-07-14', 'F', 'Dhaka Zoo', 'Ariel', 'Healthy coat at last exam'),
('Bengal Tiger', '2008-09-01', 'M', 'National Zoo', 'Freddy', 'Strong appetite'),
('Bengal Tiger', '2006-06-30', 'M', 'Southampton National Park', 'Spark', 'Likes to play'),
('Arctic Wolf', '2008-06-01', 'F', 'Scotland Zoo', 'Mia', 'Doesnt like sun'),
('Arctic Wolf', '2011-07-14', 'M', 'National Zoo', 'Freddy', 'Strong appetite'),
('Arctic Wolf', '2008-09-30', 'F', 'Southampton National Park', 'Ariel', 'Healthy coat at last exam');

--
