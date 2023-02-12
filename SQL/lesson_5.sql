USE lesson5;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at, updated_at) VALUES
  ('Геннадий', '1990-10-05', '20.10.2017 8:10', NULL),
  ('Наталья', '1984-11-12', NULL, '20.10.2017 8:10'),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '1992-08-29', '20.10.2017 8:10', NULL);

-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
UPDATE users SET created_at = NULL;
UPDATE users SET updated_at = NULL; 
UPDATE users SET created_at = NOW();
UPDATE users SET updated_at = NOW(); 

SELECT * FROM users;

-- 2.Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к 
-- типу DATETIME, сохранив введеные ранее значения.

UPDATE users
	SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');
    
ALTER TABLE users
	MODIFY COLUMN created_at DATETIME,
	MODIFY COLUMN updated_at DATETIME;
    
SELECT * FROM users;

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи
-- таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы 
-- должны выводиться в конце, после всех записей.

DELETE FROM storehouses_products;

INSERT INTO storehouses_products
	(storehouse_id, product_id, value, created_at, updated_at) VALUES
	(1, 1, 0, now(), now()),
	(2, 2, 2500, now(), now()),
	(3, 3, 0, now(), now()),
	(4, 4, 30, now(), now()),
	(5, 5, 500, now(), now()),
	(6, 6, 1, now(), now());

SELECT * 
FROM storehouses_products 
ORDER BY CASE 
	WHEN value = 0 
    THEN 999999999 
    ELSE value 
END;

-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT 
	*
FROM 
	users
WHERE 
	birthday_at LIKE '____-05-__' OR 
    birthday_at LIKE '____-08-__';

-- Подсчитайте средний возраст пользователей в таблице users
ALTER TABLE 
	users
ADD COLUMN 
	age INT NULL AFTER birthday_at;
    
UPDATE
	users
SET
	age = ROUND((TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25);

SELECT
	ROUND(AVG(age)) AS 'средний возраст пользователей'
FROM
	users;
    
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
   
SELECT 
	DAYNAME(CONCAT('2022-', MONTH(birthday_at), '-', DAY(birthday_at))) AS day,
	COUNT(*) AS total
FROM 
	users 
GROUP BY 
	day
ORDER BY 
	total DESC;   