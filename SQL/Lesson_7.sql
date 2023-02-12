USE lesson7;

------------------ Задача 1.
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT 
	o.user_id AS id, 
	u.name,
    count(o.user_id) AS number_of_orders
FROM 
	orders AS o
JOIN 
	users AS u
ON 
	o.user_id = u.id
GROUP BY 
	id;

------------------ Задача 2.
-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT 
	p.id AS `product_id`,
    c.name AS `catalog_name`,
    p.name AS `product_name`,
    p.description,
    p.price
FROM 
	products AS p
JOIN 
	catalogs AS c
ON 
	p.catalog_id = c.id;


------------------ Задача 3. (по желанию) 
-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.
DROP TABLE IF EXISTS `flights`;
CREATE TABLE `flights` (
  `id` INT NOT NULL,
  `from` VARCHAR(45) NULL,
  `to` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));
INSERT INTO `flights` 
VALUES 
	(1, 'Moscow', 'London'),
	(2, 'Kiev', 'Beijing'),
	(3, 'Delhi', 'Seoul'),
	(4, 'Cairo', 'Ankara'),
	(5, 'Berlin', 'Algeria');  
    
  DROP TABLE IF EXISTS `cities`;
  CREATE TABLE `cities` (
  `label` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`label`));
INSERT INTO `cities` 
VALUES 
	('Moscow', 'Москва'), 
    ('London', 'Лондон'),
	('Kiev', 'Киев'), 
    ('Beijing', 'Пекин'),
	('Delhi', 'Дели'),  
    ('Seoul', 'Сеул'),
	('Cairo', 'Каир'),  
    ('Ankara', 'Анкара'),
	('Berlin', 'Берлин'),  
    ('Algeria', 'Алжир');
    
SELECT f.id, `from`.name AS `from`, `to`.name AS `to`
FROM flights as f
JOIN cities AS `from` ON f.`from` = `from`.label
JOIN cities AS `to` ON f.`to` = `to`.label
ORDER BY id;

