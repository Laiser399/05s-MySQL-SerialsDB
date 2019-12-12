SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE "insert_data/genre.txt" 
	INTO TABLE genre
	FIELDS
		TERMINATED BY ", "
		OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY "\r\n"
	IGNORE 1 LINES;
	
LOAD DATA LOCAL INFILE "insert_data/serial.txt" 
	INTO TABLE serial
	FIELDS
		TERMINATED BY ", "
		OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY "\r\n"
	IGNORE 1 LINES;
	
LOAD DATA LOCAL INFILE "insert_data/serial_to_genre.txt" 
	INTO TABLE serial_to_genre
	FIELDS
		TERMINATED BY ", "
		OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY "\r\n"
	IGNORE 1 LINES;
	
LOAD DATA LOCAL INFILE "insert_data/season.txt" 
	INTO TABLE season
	FIELDS
		TERMINATED BY ", "
		OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY "\r\n"
	IGNORE 1 LINES;
	
LOAD DATA LOCAL INFILE "insert_data/series.txt" 
	INTO TABLE series
	FIELDS
		TERMINATED BY ", "
		OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY "\r\n"
	IGNORE 1 LINES
	(id, id_season, number, name, @release_date, torrent_link)
		SET release_date = STR_TO_DATE(@release_date, "%d.%c.%Y");
	
source counts.sql;