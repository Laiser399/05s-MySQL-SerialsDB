delimiter |

drop event if exists clear_useless_logs;

create event clear_useless_logs
	on schedule every 1 hour
	do begin
		delete from change_log where change_time < subtime(now(), "0:59:0");
		delete from stg_change_log where change_time < subtime(now(), "0:59:0");
	end;|
	
delimiter ;


select "done" as schedule_created;