CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100)
);

INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');


CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100),
    scientific_name VARCHAR(150),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id),
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR(100),
    sighting_time TIMESTAMP,
    notes TEXT
);

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);



-- Problem 1,
INSERT INTO rangers (name, region) 
VALUES ('Derek Fox', 'Coastal Plains');


-- Problem 2,
SELECT COUNT(*) AS unique_species_count FROM (SELECT species_id FROM sightings GROUP BY species_id);


-- Problem 3,
SELECT * FROM sightings
    WHERE location LIKE '%Pass%';


-- Problem 4,
SELECT r.name, COUNT(s.sighting_id) AS total_sightings FROM rangers AS r
    LEFT JOIN sightings AS s ON r.ranger_id = s.ranger_id
    GROUP BY r.name
    ORDER BY r.name;


-- Problem 5,
SELECT s.common_name FROM species AS s
    LEFT JOIN sightings AS si ON s.species_id = si.species_id
    WHERE si.species_id IS NULL;


-- Problem 6,
SELECT sp.common_name, si.sighting_time, ra.name FROM sightings AS si
    JOIN species AS sp ON si.species_id = sp.species_id
    JOIN rangers AS ra ON si.ranger_id = ra.ranger_id
    ORDER BY si.sighting_time DESC LIMIT 2;


-- Problem 7,
UPDATE species SET conservation_status = 'Historic'
    WHERE discovery_date < '1800-01-01';


-- Problem 8,
SELECT sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day FROM sightings;


-- Problem 9,
DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id FROM sightings
);
