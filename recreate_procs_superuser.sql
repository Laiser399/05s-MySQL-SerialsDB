DROP PROCEDURE IF EXISTS change_user_password;
DROP PROCEDURE IF EXISTS create_user_editor;
DROP PROCEDURE IF EXISTS create_user_guest;
DROP PROCEDURE IF EXISTS delete_user;
DROP PROCEDURE IF EXISTS get_common_users;
DROP PROCEDURE IF EXISTS get_role_for;
DROP PROCEDURE IF EXISTS make_user_editor;
DROP PROCEDURE IF EXISTS make_user_guest;
DROP PROCEDURE IF EXISTS revoke_roles;


DELIMITER |

CREATE PROCEDURE `change_user_password`(user_name char(32), new_password varchar(255))
BEGIN
	set @sql := concat("set password for `", user_name, "`@localhost = \"", new_password, "\";");
    prepare statement from @sql;
    execute statement;
	flush privileges;
END|

CREATE PROCEDURE `create_user_editor`(user_name char(32), user_password char(255))
BEGIN
	set @sql := concat("create user `", user_name, "`@`localhost` identified by \"", user_password, "\" default role editor;");
    prepare statement from @sql;
    execute statement;
END|

CREATE PROCEDURE `create_user_guest`(user_name char(32), user_password char(255))
BEGIN
	set @sql := concat("create user `", user_name, "`@`localhost` identified by \"", user_password, "\" default role guest;");
    prepare statement from @sql;
    execute statement;
END|

CREATE PROCEDURE `delete_user`(name char(32))
BEGIN
	set @sql := concat("drop user `", name, "`@localhost;");
    prepare statement from @sql;
    execute statement;
END|

CREATE PROCEDURE `get_common_users`()
BEGIN
	select user, default_role_user as role from mysql.default_roles
		where default_role_user in ("guest", "editor");
END|

CREATE PROCEDURE `get_role_for`(user char(32))
BEGIN
	select default_role_user as role from mysql.default_roles
		where mysql.default_roles.user=user;
END|

CREATE PROCEDURE `make_user_editor`(user_name char(32))
BEGIN
	call revoke_roles(user_name);
    
    set @sql := concat("grant editor to `", user_name, "`@localhost");
    prepare statement from @sql;
    execute statement;
    
    set @sql := concat("set default role editor to `", user_name, "`@localhost");
    prepare statement from @sql;
    execute statement;
	
	flush privileges;
END|

CREATE PROCEDURE `make_user_guest`(user_name char(32))
BEGIN
	call revoke_roles(user_name);
    
    set @sql := concat("grant guest to `", user_name, "`@localhost");
    prepare statement from @sql;
    execute statement;
    
    set @sql := concat("set default role guest to `", user_name, "`@localhost");
    prepare statement from @sql;
    execute statement;
	
	flush privileges;
END|

CREATE PROCEDURE `revoke_roles`(user_name char(32))
BEGIN
	set @sql := concat("revoke guest from `", user_name, "`@localhost;");
    prepare statement from @sql;
    execute statement;
    
    set @sql := concat("revoke editor from `", user_name, "`@localhost;");
    prepare statement from @sql;
    execute statement;
END|


DELIMITER ;

