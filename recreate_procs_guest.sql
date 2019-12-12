DROP PROCEDURE IF EXISTS get_all_genres;
DROP PROCEDURE IF EXISTS get_all_seasons;
DROP PROCEDURE IF EXISTS get_all_serials;
DROP PROCEDURE IF EXISTS get_all_series;
DROP PROCEDURE IF EXISTS get_genres_id_for;

DROP PROCEDURE IF EXISTS get_genre_by_id;
DROP PROCEDURE IF EXISTS get_season_by_id;
DROP PROCEDURE IF EXISTS get_serial_by_id;
DROP PROCEDURE IF EXISTS get_series_by_id;

DROP PROCEDURE IF EXISTS get_role;

DROP PROCEDURE IF EXISTS get_last_change_ids;
DROP PROCEDURE IF EXISTS get_changes_after;
DROP PROCEDURE IF EXISTS get_stg_changes_after;


delimiter |

CREATE PROCEDURE `get_all_genres`()
BEGIN
	select * from genre;
END|

CREATE PROCEDURE `get_all_seasons`()
BEGIN
	select * from season;
END|

CREATE PROCEDURE `get_all_serials`()
BEGIN
	SELECT * FROM serial;
END|

CREATE PROCEDURE `get_all_series`()
BEGIN
	select * from series;
END|

CREATE PROCEDURE `get_genres_id_for`(id_serial int)
BEGIN
	select id_genre from serial_to_genre stg where stg.id_serial=id_serial;
END|

CREATE PROCEDURE `get_genre_by_id`(id int)
BEGIN
	select * from genre where genre.id=id;
END|

CREATE PROCEDURE `get_season_by_id`(id int)
BEGIN
	select * from season where season.id=id;
END|

CREATE PROCEDURE `get_serial_by_id`(id int)
BEGIN
	select * from serial where serial.id=id;
END|

CREATE PROCEDURE `get_series_by_id`(id int)
BEGIN
	select * from series where series.id=id;
END|

CREATE PROCEDURE `get_role`()
BEGIN
	call get_role_for(substring_index(user(), '@', 1));
END|

CREATE PROCEDURE `get_last_change_ids`()
BEGIN
	set @a := (select id from change_log order by id desc limit 1);
    set @b := (select id from stg_change_log order by id desc limit 1);
    
    if @a is null then
		set @a := 0;
	end if;
    if @b is null then
		set @b := 0;
	end if;
    
    select @a as id_main, @b as id_stg;
END|

CREATE PROCEDURE `get_changes_after`(id int)
BEGIN
	select change_log.id, table_name, id_row, type
		from change_log
		where change_log.id > id
		order by change_log.id;
END|

CREATE PROCEDURE `get_stg_changes_after`(id int)
BEGIN
	select stg_change_log.id, id_serial, id_genre, type
		from stg_change_log
		where stg_change_log.id > id
		order by stg_change_log.id;
END|



delimiter ;