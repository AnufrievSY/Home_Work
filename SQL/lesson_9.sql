------ Практическое задание по теме “Транзакции, переменные, представления”
--- Задание 1.
-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;
	INSERT INTO sample.users 
    SELECT * 
    FROM shop.users 
    WHERE id = 1 ;
	
    DELETE FROM shop.users 
    WHERE id = 1;
	
    SELECT *
	FROM sample.users;
COMMIT;


--- Задание 2.
-- Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE VIEW cat (product_name, catalog_name)
AS SELECT 
	p.name AS product_name,
	c.name AS catalog_name
FROM products AS p
JOIN catalogs AS c ON p.catalog_id=c.id;

SELECT * 
FROM cat;

--- Задание 3.
-- (по желанию) Пусть имеется таблица с календарным полем CREATEd_at. В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

DROP TABLE IF EXISTS new_table;
CREATE TABLE `new_table` (
  `id` INT NOT NULL,
  `CREATEd_at` datetime NULL,
  PRIMARY KEY (`id`));
  
INSERT INTO `new_table` VALUES 
	('1', '2018-08-01'),
	('2', '2016-08-04'),
	('3', '2018-08-16'),
	('4', '2018-08-17');

DELIMITER //
DROP PROCEDURE IF EXISTS test//
CREATE PROCEDURE test ()
BEGIN
	DECLARE i INT DEFAULT 0;
	DROP TABLE IF EXISTS test;
	CREATE TEMPORARY TABLE test (days int, date_in int);
	cycle: WHILE i < 31 DO
		SET i = i + 1;
		IF (i in (SELECT EXTRACT(DAY FROM CREATEd_at) AS day FROM new_table)) THEN
			INSERT INTO `test` VALUES (i, 1);
		ELSE 
			INSERT INTO `test` VALUES (i, 0);
		END IF;
	END WHILE cycle;
	SELECT * FROM test ORDER BY date_in DESC;
END//

CALL shop.test();

------ Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)
--- Задание 1.
-- Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

USE shop;
DROP USER 'shop_read'@'localhost';
DROP USER 'shop'@'localhost';

CREATE USER 'shop_read'@'localhost';
CREATE USER 'shop'@'localhost';

GRANT SELECT ON shop.* TO 'shop_read'@'localhost';
GRANT ALL ON shop.* TO 'shop'@'localhost';

SELECT * 
FROM INFORMATION_SCHEMA.SCHEMA_PRIVILEGES 
WHERE 
	grantee = "'shop_read'@'localhost'" OR 
    grantee = "'shop'@'localhost'";

--- Задание 3.
-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //

DROP PROCEDURE IF EXISTS format_now//
CREATE PROCEDURE format_now ()
BEGIN
	DECLARE VALUE INT;
	SET VALUE := (SELECT EXTRACT(HOUR_SECOND FROM now()));
	IF (VALUE BETWEEN 060000 AND 125959) THEN
		SELECT "Доброе утро";
	END IF;
	IF (VALUE BETWEEN 120000 AND 185959) THEN
		SELECT "Добрый день";
	END IF;
	IF  (VALUE BETWEEN 180000 AND 235959) THEN
		SELECT "Добрый вечер";
	END IF;
	IF (VALUE BETWEEN 000000 AND 065959) THEN
		SELECT "Доброй ночи";
	END IF;
END//

CALL format_now()//

--- Задание 4.
-- В таблице products есть два текстовых поля: name с названием товара и DESCriptiON с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

DELIMITER //

DROP TRIGGER IF exists not_null_insert//
CREATE TRIGGER not_null_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
	IF (isnull(new.name) AND isnull(new.DESCriptiON)) THEN
		SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Вводимые имя и описание не могут принимать одновременно неопределенное значение';
	END IF;
END//

SELECT *
FROM products;