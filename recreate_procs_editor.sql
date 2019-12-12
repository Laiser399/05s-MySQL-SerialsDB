DROP PROCEDURE IF EXISTS add_genre_to_serial;
DROP PROCEDURE IF EXISTS clear_genres;
DROP PROCEDURE IF EXISTS create_genre;
DROP PROCEDURE IF EXISTS create_season;
DROP PROCEDURE IF EXISTS create_serial;
DROP PROCEDURE IF EXISTS create_series;

DROP PROCEDURE IF EXISTS delete_genre;
DROP PROCEDURE IF EXISTS delete_season;
DROP PROCEDURE IF EXISTS delete_serial;
DROP PROCEDURE IF EXISTS delete_series;

DROP PROCEDURE IF EXISTS update_genre;
DROP PROCEDURE IF EXISTS update_season;
DROP PROCEDURE IF EXISTS update_serial;
DROP PROCEDURE IF EXISTS update_series;



delimiter |

CREATE PROCEDURE `add_genre_to_serial`(id_serial INT, id_genre INT)
BEGIN
	insert into serial_to_genre values(id_serial, id_genre);
END|

CREATE PROCEDURE `clear_genres`(id_serial INT UNSIGNED)
BEGIN
	delete from serial_to_genre stg where stg.id_serial=id_serial;
END|

CREATE PROCEDURE `create_genre`(name varchar(255))
BEGIN
	insert into genre (genre.name) values (name);
    select last_insert_id();
END|

CREATE PROCEDURE `create_season`(id_serial int, number int, series_count int, torrent varchar(255))
BEGIN
	insert into season
		(season.id_serial, season.number, season.series_count, season.torrent_link)
        values(id_serial, number, series_count, torrent);
	select last_insert_id();
END|

CREATE PROCEDURE `create_serial`(name varchar(255), official_site varchar(255), mark float)
BEGIN
	insert into serial
		(serial.name, serial.official_site, serial.mark)
        values(name, official_site, mark);
	select last_insert_id();
END|

CREATE PROCEDURE `create_series`(id_season int, number int, name varchar(255), release_date date, torrent varchar(255))
BEGIN
	insert into series
		(series.id_season, series.number, series.name, series.release_date, series.torrent_link)
        values(id_season, number, name, release_date, torrent);
	select last_insert_id();
END|

CREATE PROCEDURE `delete_genre`(id int)
BEGIN
	delete from serial_to_genre where id_genre=id;
	delete from genre where genre.id=id;
END|

CREATE PROCEDURE `delete_season`(id int)
BEGIN
	delete from series where id_season=id;
    delete from season where season.id=id;
END|

CREATE PROCEDURE `delete_serial`(id int)
BEGIN
	delete from series where id_season in
		(select season.id from season where id_serial=id);
	delete from season where id_serial=id;
    delete from serial_to_genre where id_serial=id;
    delete from serial where serial.id=id;
END|

CREATE PROCEDURE `delete_series`(id int)
BEGIN
	delete from series where series.id=id;
END|

CREATE PROCEDURE `update_genre`(id int, name varchar(255))
BEGIN
	update genre set genre.name=name where genre.id=id;
END|

CREATE PROCEDURE `update_season`(id int, number int, series_count int, torrent varchar(255))
BEGIN
	update season
		set season.number=number, season.series_count=series_count, season.torrent_link=torrent
        where season.id=id;
END|

CREATE PROCEDURE `update_serial`(id INT UNSIGNED, name VARCHAR(255), official_site VARCHAR(255), mark FLOAT)
BEGIN
	update serial
		set serial.name=name, serial.official_site=official_site, serial.mark=mark
		where serial.id=id;
END|

CREATE PROCEDURE `update_series`(id int, number int, name varchar(255), release_date date, torrent varchar(255))
BEGIN
	update series
		set series.number=number, series.name=name,
        series.release_date=release_date, series.torrent_link=torrent
        where series.id=id;
END|






delimiter ;