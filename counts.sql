select * from 
	(select count(*) as genre from genre) as t1,
	(select count(*) as serial_to_genre from serial_to_genre) as t2,
	(select count(*) as serial from serial) as t3,
	(select count(*) as season from season) as t4,
	(select count(*) as series from series) as t5
;