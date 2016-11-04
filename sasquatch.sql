CREATE DATABASE sasquatch;

  CREATE TABLE sightings (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(400),
    image_url TEXT,
    country_id INTEGER,
    user_id INTEGER,
    date DATE,
    likes INTEGER,
    dislikes INTEGER,
    picture TEXT
  );

  INSERT INTO sightings (name, image_url) VALUES ('BF sighting', 'https://i.ytimg.com/vi/adwK4irr_Yo/maxresdefault.jpg');


  ---COUNTRIES TABLE

  CREATE TABLE countries (
    id SERIAL4 PRIMARY KEY,
    name VARCHAR(200),
  );

-- could add state, city and continent later

INSERT INTO countries (name) VALUES ('United States');
INSERT INTO countries (name) VALUES ('Canada');
INSERT INTO countries (name) VALUES ('Australia');
INSERT INTO countries (name) VALUES ('New Zealand');
INSERT INTO countries (name) VALUES ('Indonesia');
INSERT INTO countries (name) VALUES ('Malaysia');
INSERT INTO countries (name) VALUES ('Himalayas');
INSERT INTO countries (name) VALUES ('India');
INSERT INTO countries (name) VALUES ('China');
INSERT INTO countries (name) VALUES ('Russia');
INSERT INTO countries (name) VALUES ('Afganistan');


  ---USERS TABLE

  CREATE TABLE users (
    id SERIAL4 PRIMARY KEY,
    first VARCHAR(100),
    email VARCHAR(300),
    username VARCHAR(200),
    password_digest VARCHAR(400),
    image TEXT,
    tagline TEXT,
    profilepic TEXT
  );

---COMMENTS TABLE

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  body TEXT,
  sighting_id INTEGER,
  user_id INTEGER
);

--- LIKES TABLE
--
-- CREATE TABLE likes (
--   id SERIAL4 PRIMARY KEY,
--   sighting_id INTEGER,
--   user_id INTEGER
-- );
