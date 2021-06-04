use vk;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	key_id BIGINT(20) NOT NULL,
	name_val VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;

DROP TRIGGER IF EXISTS watchdog_users;
delimiter //
CREATE TRIGGER watchdog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, key_id, name_val)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;

DROP TRIGGER IF EXISTS watchdog_catalogs;
delimiter //
CREATE TRIGGER watchdog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, key_id, name_val)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;

DROP TRIGGER IF EXISTS watchdog_products;
delimiter //
CREATE TRIGGER watchdog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, key_id, name_val)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;