create role if not exists guest;
create role if not exists editor;
create role if not exists superuser;

revoke all privileges, grant option from guest;
revoke all privileges, grant option from editor;
revoke all privileges, grant option from superuser;


grant superuser to root@localhost;
set default role superuser to root@localhost;



grant execute on procedure get_all_genres to guest;
grant execute on procedure get_all_seasons to guest;
grant execute on procedure get_all_serials to guest;
grant execute on procedure get_all_series to guest;
grant execute on procedure get_genres_id_for to guest;

grant execute on procedure get_genre_by_id to guest;
grant execute on procedure get_season_by_id to guest;
grant execute on procedure get_serial_by_id to guest;
grant execute on procedure get_series_by_id to guest;

grant execute on procedure get_role to guest;

grant execute on procedure get_last_change_ids to guest;
grant execute on procedure get_changes_after to guest;
grant execute on procedure get_stg_changes_after to guest;

grant select on serials_cw.last_added_series to guest;



grant guest to editor;
grant execute on procedure add_genre_to_serial to editor;
grant execute on procedure clear_genres to editor;
grant execute on procedure create_genre to editor;
grant execute on procedure create_season to editor;
grant execute on procedure create_serial to editor;
grant execute on procedure create_series to editor;

grant execute on procedure delete_genre to editor;
grant execute on procedure delete_season to editor;
grant execute on procedure delete_serial to editor;
grant execute on procedure delete_series to editor;

grant execute on procedure update_genre to editor;
grant execute on procedure update_season to editor;
grant execute on procedure update_serial to editor;
grant execute on procedure update_series to editor;



grant editor to superuser;
grant execute on procedure change_user_password to superuser;
grant execute on procedure create_user_editor to superuser;
grant execute on procedure create_user_guest to superuser;
grant execute on procedure delete_user to superuser;
grant execute on procedure get_common_users to superuser;
grant execute on procedure get_role_for to superuser;
grant execute on procedure make_user_editor to superuser;
grant execute on procedure make_user_guest to superuser;
grant execute on procedure revoke_roles to superuser;

grant insert on serials_cw.genre to superuser;
grant insert on serials_cw.serial_to_genre to superuser;
grant insert on serials_cw.serial to superuser;
grant insert on serials_cw.season to superuser;
grant insert on serials_cw.series to superuser;

grant delete on serials_cw.genre  to superuser;
grant delete on serials_cw.serial_to_genre to superuser;
grant delete on serials_cw.serial to superuser;
grant delete on serials_cw.season to superuser;
grant delete on serials_cw.series to superuser;

select "done" as grants_done;