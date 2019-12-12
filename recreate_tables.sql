DROP TABLE IF EXISTS stg_change_log;
DROP TABLE IF EXISTS change_log;
DROP TABLE IF EXISTS series;
DROP TABLE IF EXISTS season;
DROP TABLE IF EXISTS serial_to_genre;
DROP TABLE IF EXISTS serial;
DROP TABLE IF EXISTS genre;

select "done" as tables_deleted;



CREATE TABLE genre (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	
	PRIMARY KEY(id)
);

CREATE TABLE serial (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	official_site VARCHAR(255),
	mark FLOAT NOT NULL CHECK(mark >= 0 AND mark <= 10),
	
	PRIMARY KEY(id)
);

CREATE TABLE serial_to_genre (
	id_serial INT NOT NULL,
	id_genre INT NOT NULL,
	
	PRIMARY KEY(id_serial, id_genre),
	FOREIGN KEY(id_serial) REFERENCES serial(id),
	FOREIGN KEY(id_genre) REFERENCES genre(id)
);

CREATE TABLE season (
	id INT AUTO_INCREMENT NOT NULL,
	id_serial INT NOT NULL,
	number INT NOT NULL,
	series_count INT NOT NULL,
	torrent_link VARCHAR(255),
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_serial) REFERENCES serial(id)
);

CREATE TABLE series (
	id INT AUTO_INCREMENT NOT NULL,
	id_season INT NOT NULL,
	number INT NOT NULL,
	name VARCHAR(255) NOT NULL,
	release_date DATE NOT NULL,
	torrent_link VARCHAR(255),
	
	PRIMARY KEY(id),
	FOREIGN KEY(id_season) REFERENCES season(id)
);



CREATE TABLE change_log (
	id INT AUTO_INCREMENT NOT NULL,
	table_name ENUM("genre", "serial", "season", "series") NOT NULL,
	id_row INT NOT NULL,
	type ENUM("insert", "update", "delete") NOT NULL,
	change_time DATETIME NOT NULL DEFAULT NOW(),
	
	PRIMARY KEY(id)
);

CREATE TABLE stg_change_log (
	id INT AUTO_INCREMENT NOT NULL,
	id_serial INT NOT NULL,
	id_genre INT NOT NULL,
	type ENUM("insert", "delete") NOT NULL,
	change_time DATETIME NOT NULL DEFAULT NOW(),
	
	PRIMARY KEY(id)
);


select "done" as tables_created;
