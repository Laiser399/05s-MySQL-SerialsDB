drop view if exists last_added_series;


create view last_added_series as
	select serial.id as id_serial, 
	serial.name as serial_name, 
	season.number as season_number, 
	series.number as series_number, 
	series.release_date as release_date
		from series, season, serial
		where series.id_season=season.id and season.id_serial=serial.id
		order by release_date desc
		limit 10;


