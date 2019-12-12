DROP TRIGGER IF EXISTS genre_insert;
DROP TRIGGER IF EXISTS genre_update;
DROP TRIGGER IF EXISTS genre_delete;

DROP TRIGGER IF EXISTS serial_insert;
DROP TRIGGER IF EXISTS serial_update;
DROP TRIGGER IF EXISTS serial_delete;

DROP TRIGGER IF EXISTS season_insert;
DROP TRIGGER IF EXISTS season_update;
DROP TRIGGER IF EXISTS season_delete;

DROP TRIGGER IF EXISTS series_insert;
DROP TRIGGER IF EXISTS series_update;
DROP TRIGGER IF EXISTS series_delete;

DROP TRIGGER IF EXISTS stg_insert;
DROP TRIGGER IF EXISTS stg_delete;

select "done" as triggers_deleted;


DELIMITER |
CREATE TRIGGER genre_insert AFTER INSERT ON genre
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "genre", "insert", NEW.id);|
CREATE TRIGGER genre_update AFTER UPDATE ON genre
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "genre", "update", NEW.id);|
CREATE TRIGGER genre_delete BEFORE DELETE ON genre
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "genre", "delete", OLD.id);|


CREATE TRIGGER serial_insert AFTER INSERT ON serial
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "serial", "insert", NEW.id);|
CREATE TRIGGER serial_update AFTER UPDATE ON serial
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "serial", "update", NEW.id);|
CREATE TRIGGER serial_delete BEFORE DELETE ON serial
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "serial", "delete", OLD.id);|
			

CREATE TRIGGER season_insert AFTER INSERT ON season
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "season", "insert", NEW.id);|
CREATE TRIGGER season_update AFTER UPDATE ON season
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "season", "update", NEW.id);|
CREATE TRIGGER season_delete BEFORE DELETE ON season
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "season", "delete", OLD.id);|
			

CREATE TRIGGER series_insert AFTER INSERT ON series
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "series", "insert", NEW.id);|
CREATE TRIGGER series_update AFTER UPDATE ON series
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "series", "update", NEW.id);|
CREATE TRIGGER series_delete BEFORE DELETE ON series
	FOR EACH ROW
		INSERT INTO change_log (change_time, table_name, type, id_row)
			VALUES(NOW(), "series", "delete", OLD.id);|


CREATE TRIGGER stg_insert AFTER INSERT ON serial_to_genre
	FOR EACH ROW
		INSERT INTO stg_change_log (id_serial, id_genre, type)
			VALUES(NEW.id_serial, NEW.id_genre, "insert");|
CREATE TRIGGER stg_delete BEFORE DELETE ON serial_to_genre
	FOR EACH ROW
		INSERT INTO stg_change_log (id_serial, id_genre, type)
			VALUES(OLD.id_serial, OLD.id_genre, "delete");|

DELIMITER ;


select "done" as triggers_created;
