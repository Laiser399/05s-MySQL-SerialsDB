select "+" as reconstruction_start;

source recreate_tables.sql
source recreate_triggers.sql
source insert_data.sql

source recreate_procs_guest.sql
source recreate_procs_editor.sql
source recreate_procs_superuser.sql
select "done" as procs_recreated;

source recreate_schedule.sql
source recreate_views.sql
source grant_rules.sql





select "+" as reconstruction_end;