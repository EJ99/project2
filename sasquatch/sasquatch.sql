CREATE DATABASE sasquatch;

  CREATE TABLE sightings (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(400),
    image_url TEXT,
    country_id INTEGER,
    user_id INTEGER,
    date DATE,
    l INTEGER,
    d INTEGER
  );

  INSERT INTO sightings (name, image_url) VALUES ('BF sighting', 'https://i.ytimg.com/vi/adwK4irr_Yo/maxresdefault.jpg')

  ---COUNTRIES TABLE

  CREATE TABLE countries (
    id SERIAL4 PRIMARY KEY,
    country_name VARCHAR(200),
  );

-- could add state, city and continent later

INSERT INTO countries (country_name) VALUES ('United States');
INSERT INTO countries (country_name) VALUES ('Canada');
INSERT INTO countries (country_name) VALUES ('Australia');
INSERT INTO countries (country_name) VALUES ('New Zealand');
INSERT INTO countries (country_name) VALUES ('Indonesia');
INSERT INTO countries (country_name) VALUES ('Malaysia');
INSERT INTO countries (country_name) VALUES ('Himalayas');
INSERT INTO countries (country_name) VALUES ('India');
INSERT INTO countries (country_name) VALUES ('China');
INSERT INTO countries (country_name) VALUES ('Russia');
INSERT INTO countries (country_name) VALUES ('Afganistan');


  ---USERS TABLE

  CREATE TABLE users (
    id SERIAL4 PRIMARY KEY,
    first VARCHAR(100),
    last VARCHAR(100),
    email VARCHAR(300),
    username VARCHAR(200),
    password_digest VARCHAR(400)
  );

---COMMENTS TABLE

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  body TEXT,
  sighting_id INTEGER,
  user_id INTEGER
);
