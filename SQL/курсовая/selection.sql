USE coursework;
-- ****************************************************************************************************************************** --
-- Даны условия:
-- установленна категория ребонок-инвалид
SELECT * FROM invalid_info WHERE col2 = 'Категория ребенок-инвалид';
-- год установления инвалидности 2022
SELECT * FROM invalid_info WHERE year(col3) = 2022;
-- только первично установленная категория
SELECT * FROM last_mse_info WHERE col4 = 'первично';
-- отсутвие агрессивных тенденций
SELECT * FROM last_psy_test WHERE col4 = 0;
-- уровень социализации равен или выше второго
SELECT * FROM last_psy_test WHERE col3 != 'Первый';

-- Создадим представление с учетом имеющихся условий.
DROP VIEW IF EXISTS `coursework`.`selection`;
CREATE VIEW selection AS
SELECT 
	t0.*,
	t1.col2 AS t1_col2, 
	t1.col3 AS t1_col3, 
	t2.col4 AS t2_col4, 
	t3.col3 AS t3_col3, 
	t3.col4 AS t3_col4 
FROM persons AS t0
JOIN invalid_info AS t1 ON t0.id = t1.col1
JOIN last_mse_info AS t2 ON t0.id = t2.col1
JOIN last_psy_test AS t3 ON t0.id = t3.col1
WHERE 
	t1.col2 = 'Категория ребенок-инвалид' AND
	year(t1.col3) = 2022 AND
	t2.col4 = 'первично' AND
	t3.col3 != 'Первый' AND
	t3.col4 = 0;
-- ****************************************************************************************************************************** --
-- Теперь изучим условия прописанные для каждой организации.
SELECT id, col6 FROM medical_organizations;

-- И подберем граждан подходящих под условия, создав новое представление c id организации и id гражданина.
DROP VIEW IF EXISTS `coursework`.`selection_for_organization`;
CREATE VIEW selection_for_organization AS
	SELECT 
		'1' AS `org_id`, 
		id AS `pers_id` 
	FROM persons 
    WHERE 
		id IN (SELECT id FROM selection) AND 
		year(now()) - year(col4) between 14 AND 17
	UNION ALL
	SELECT '2', id 
    FROM disease_info 
    WHERE 
		id IN (SELECT id FROM selection) AND 
        (col2 like "F%" OR col4 like "F%")
	UNION ALL
	SELECT '3', id 
    FROM persons 
    WHERE 
		id IN (SELECT id FROM selection) 
        AND col5 like "%Екатеринбург%"
	UNION ALL
	SELECT '4', id 
    FROM persons 
    WHERE 
		id IN (SELECT id FROM selection) AND 
		year(now()) - year(col4)>16
	UNION ALL
	SELECT '5', id 
    FROM persons 
    WHERE 
		id IN (SELECT id FROM selection) AND 
        col5 like "%Нижний Тагил%"
	UNION ALL
	SELECT '6', id 
	FROM persons 
    WHERE 
		id IN (SELECT id FROM selection) AND
        col5 like "%Каменск-Уральский%"
	UNION ALL
	SELECT '7', id 
    FROM irpr 
    WHERE 
		id IN (SELECT id FROM selection) AND 
        (col4 = 1 OR col5 = 1 OR col6 = 1);
-- ****************************************************************************************************************************** --
-- Вонце составим таблицу для обзвона граждан:
DELIMITER //
DROP PROCEDURE IF EXISTS results//
CREATE PROCEDURE results ()
BEGIN
	DROP TABLE IF EXISTS `coursework`.`calling`;
	CREATE TABLE `coursework`.`calling` (
	  `id` INT NULL,
	  `Бюро в котором установлена инвалидность` LONGTEXT NULL,
	  `ФИО гражданина` TEXT NULL,
	  `ФИО представителя` TEXT NULL,
	  `Номер телефона для связи` VARCHAR(11) NULL,
	  `Наименование рекомендуемого учреждение учавствующее в проекте` VARCHAR(200) NULL,
	  `Адрес рекомендуемого учреждение учавствующее в проекте` LONGTEXT NULL,
	  `Телефон рекомендуемого учреждение учавствующее в проекте` VARCHAR(11) NULL,
	  `Контактное лицо рекомендуемого учреждение учавствующее в проекте` TEXT NULL,
	  FOREIGN KEY (id) REFERENCES persons (id) ON DELETE CASCADE,
      FOREIGN KEY (`Наименование рекомендуемого учреждение учавствующее в проекте`) REFERENCES medical_organizations (col2) ON DELETE CASCADE)
	  COMMENT = 'Базовые сведения о гражданине';

	SET @value = 0;
	SET @stop = (SELECT count(*) FROM medical_organizations);
    
	cycle: WHILE @value < @stop DO
			SET @value = @value + 1;
			INSERT INTO `coursework`.`calling`
			SELECT 
				t1.pers_id, 
				t2.col2,
				concat(t3.col1, ' ', t3.col2, ' ', t3.col3),
				t3.col6,
				t4.col2,
				t5.col2,
				t5.col3,
				t5.col4,
				t5.col5
			FROM selection_for_organization AS t1
			JOIN last_mse_info AS t2
			JOIN persons AS t3
			JOIN contact_info AS t4
			JOIN medical_organizations AS t5
			ON t1.pers_id = t2.col1 AND 
				t1.pers_id = t3.id AND
				t1.pers_id = t4.col1 AND
				t1.org_id = t5.id
			WHERE t1.org_id = @value;       
	END WHILE cycle;
    
    SELECT * FROM calling ORDER BY id;
END//
DELIMITER ;
-- ****************************************************************************************************************************** --
# Теперь мы можем как одной командой получать список людей для обзовона и информированию о том, что они учавствуют в программе
CALL results();
-- ****************************************************************************************************************************** --
# P.S.
# Попытался еще поработать над выгрузкой таблицы для последующей отправки в организацию, выгружает только в определенную папку, как задать путь самостоятельно, так и не понял:
SELECT *
FROM calling
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\results.csv'
    CHARACTER SET utf8mb4
    FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n';
# Хотел еще написать код, который бы сам брал csv файл переданный организацией с информацией о инвалидах, но все что смог это загрузить таблицу через Table Data ImpORt Wizard и от туда уже распределить по созданным таблицам (файл под названием `dump_FROM_data_bASe`).
