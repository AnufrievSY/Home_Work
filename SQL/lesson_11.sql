------ Практическое задание по теме “Оптимизация запросов”
--- Задание 1.
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

USE sample;

DROP TABLE IF EXISTS logs;
CREATE TABLE `logs` (
`id` INT NOT NULL AUTO_INCREMENT,
`time` TIME NOT NULL COMMENT 'время создания',
`date` DATE NOT NULL COMMENT 'дата создания',
`table` VARCHAR(255) NOT NULL COMMENT 'название таблицы',
`table_id` INT NOT NULL COMMENT 'идентификатор первичного ключа',
`name_value` VARCHAR(255) NOT NULL COMMENT 'содержимое поля name',
PRIMARY KEY (`id`)) 
COMMENT = 'архив новых записей таблиц users, catalogs и products' 
ENGINE = Archive;

DELIMITER //
DROP TRIGGER IF EXISTS record_users//
CREATE TRIGGER record_users  AFTER INSERT ON users FOR EACH ROW
BEGIN
	insert into logs values (null, CURTIME(), CURDATE(), 'users', new.id, new.name);
END//
DELIMITER ;
DELIMITER //
DROP TRIGGER IF EXISTS record_catalogs//
CREATE TRIGGER record_catalogs  AFTER INSERT ON catalogs FOR EACH ROW
BEGIN
	insert into logs values (null, CURTIME(), CURDATE(), 'catalogs', new.id, new.name);
END//
DELIMITER ;
DELIMITER //
DROP TRIGGER IF EXISTS record_products//
CREATE TRIGGER record_products  AFTER INSERT ON products FOR EACH ROW
BEGIN
	insert into logs values (null, CURTIME(), CURDATE(), 'products', new.id, new.name);
END//
DELIMITER ;

truncate table users;
INSERT INTO USERS VALUES (1, 'recording', CURDATE(), NOW(), NOW());
truncate table catalogs;
INSERT INTO catalogs VALUES (1, 'recording');
truncate table products;
INSERT INTO products VALUES (1, 'recording', 'recording', '11', 1, now(), now());

select * from logs;

--- Задание 2.
-- (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DELIMITER //
DROP PROCEDURE IF EXISTS recording//
CREATE PROCEDURE recording ()
BEGIN
	set @a = 0;
    truncate table users;
	cycle: WHILE @a < 1000000 DO
		SET @a = @a + 1;
		INSERT INTO USERS VALUES (NULL, concat('name_', @a), CURDATE(), NOW(), NOW());
	END WHILE cycle;
	SELECT * FROM recording ORDER BY date_in DESC;
END//
DELIMITER ;

CALL recording();

SELECT * FROM users;

------ Практическое задание по теме “NoSQL”
--- Задание 1.
-- В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.



--- Задание 2.
-- При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.



--- Задание 3.
-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
