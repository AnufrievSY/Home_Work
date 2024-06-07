DROP DATABASE IF EXISTS `coursework`;
CREATE SCHEMA `coursework` ;
USE `coursework`;
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS persons;
CREATE TABLE `coursework`.`persons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` VARCHAR(45) NULL comment 'Фамилия',
  `col2` VARCHAR(45) NULL comment 'Имя',
  `col3` VARCHAR(45) NULL comment 'Отчество',
  `col4` DATE NULL comment 'Дата рождения',
  `col5` VARCHAR(255) NULL comment 'Адрес места жительства',
  `col6` VARCHAR(45) NULL comment 'Представитель',
  `col7` DATETIME DEFAULT CURRENT_TIMESTAMP comment 'Дата создания', 
  `col8` DATETIME DEFAULT CURRENT_TIMESTAMP comment 'Дата последнего изменения',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
  COMMENT = 'Базовые сведения о гражданине';

DELIMITER //
DROP TRIGGER IF EXISTS update_person//
CREATE TRIGGER update_person  BEFORE UPDATE ON persons
FOR EACH ROW
BEGIN
	SET NEW.col6 = OLD.col6;
    SET NEW.col7 = now();
END//
DELIMITER ;
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS invalid_info;
CREATE TABLE `coursework`.`invalid_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` INT NULL COMMENT 'ID гражданина',
  `col2` VARCHAR(45) NULL COMMENT 'Группа инвалидности',
  `col3` DATE NULL DEFAULT NULL COMMENT 'Дата установления инвалидности',
  `col4` DATE NULL DEFAULT NULL COMMENT 'Дата до которой установлена инвалидность',
  PRIMARY KEY (`id`),
  FOREIGN KEY (col1) REFERENCES persons (id) ON DELETE CASCADE)
COMMENT = 'Базовая информация об инвалиде';
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS documents;
CREATE TABLE `coursework`.`documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` INT NULL COMMENT 'ID гражданина',
  `col2` VARCHAR(14) NULL COMMENT 'СНИЛС',
  `col3` VARCHAR(255) NULL COMMENT 'Тип документа удостоверяющего личность',
  `col4` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Номер',
  `col5` VARCHAR(45) NULL COMMENT 'Серия',
  `col6` LONGTEXT NULL COMMENT 'Орган выдавший документ',
  `col7` DATE NULL COMMENT 'Дата выдачи',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `col2_UNIQUE` (`col2` ASC) VISIBLE,
  FOREIGN KEY (col1) REFERENCES persons (id) ON DELETE CASCADE)
COMMENT = 'Документы гражданина';
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS disease_info;
  CREATE TABLE `coursework`.`disease_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` INT NULL COMMENT 'ID гражданина',
  `col2` VARCHAR(45) NULL COMMENT 'Основное заболевание (код)',
  `col3` LONGTEXT NULL COMMENT 'Основное заболевание (текст)',
  `col4` VARCHAR(45) NULL COMMENT 'Сопутствующее заболевание (код)',
  PRIMARY KEY (`id`),
  FOREIGN KEY (col1) REFERENCES persons (id) ON DELETE CASCADE)
  COMMENT = 'Информация о заболевании инвалида';
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS rva;
CREATE TABLE `coursework`.`rva` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` INT NULL COMMENT 'ID гражданина',
  `col2` VARCHAR(14) NULL DEFAULT NULL COMMENT 'Способность к самообслуживанию',
  `col3` VARCHAR(14) NULL DEFAULT NULL COMMENT 'Способность к самостоятельному передвижению',
  `col4` VARCHAR(14) NULL DEFAULT NULL COMMENT 'Способность к ориентации',
  `col5` VARCHAR(14) NULL DEFAULT NULL COMMENT 'Способность к общению',
  `col6` VARCHAR(14) NULL DEFAULT NULL COMMENT 'Способность контролировать свое поведение',
  `col7` VARCHAR(14) NULL DEFAULT NULL COMMENT 'Cпособность к обучению',
  `col8` VARCHAR(14) NULL DEFAULT NULL COMMENT 'Способность к трудовой деятельности',
  PRIMARY KEY (`id`),
  FOREIGN KEY (col1) REFERENCES persons (id) ON DELETE CASCADE)
COMMENT = 'Ограничение жизнедеятельности';
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS last_mse_info;
CREATE TABLE `coursework`.`last_mse_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` INT NULL COMMENT 'ID гражданина',
  `col2` TEXT NOT NULL COMMENT 'Учреждение проводившее экспертизу',
  `col3` DATE NOT NULL COMMENT 'Дата проведения',
  `col4` VARCHAR(45) NOT NULL COMMENT 'Порядок проведения',
  PRIMARY KEY (`id`),
  FOREIGN KEY (col1) REFERENCES persons (id) ON DELETE CASCADE)
COMMENT = 'Информация о последней медико-социальной экспертизе гражданине';
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS contact_info;
CREATE TABLE `coursework`.`contact_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` INT NULL COMMENT 'ID гражданина',
  `col2` VARCHAR(45) NOT NULL COMMENT 'Номер телефона (сотовый или домашний) или  Email',
  PRIMARY KEY (`id`),
  FOREIGN KEY (col1) REFERENCES persons (id) ON DELETE CASCADE)
COMMENT = 'Контактная информация';
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS irpr;
CREATE TABLE `coursework`.`irpr` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` INT NULL COMMENT 'ID гражданина',
  `col2` TINYINT NULL DEFAULT NULL COMMENT 'Нуждаемость в медицинской реабилитации',
  `col3` TINYINT NULL DEFAULT NULL COMMENT 'Нуждаемость в проффесиональной адаптации',
  `col4` TINYINT NULL DEFAULT NULL COMMENT 'Нуждаемость в услугах сурдопереводчика',
  `col5` TINYINT NULL DEFAULT NULL COMMENT 'Нуждаемость в услугах кинологических организаций',
  `col6` TINYINT NULL DEFAULT NULL COMMENT 'Нуждаемость в технических средствах реабилитации',
  PRIMARY KEY (`id`),
  FOREIGN KEY (col1) REFERENCES persons (id) ON DELETE CASCADE)
COMMENT = 'Индивидуальная программы реабилитации и абилитация инвалида';
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS medical_organizations;
CREATE TABLE `coursework`.`medical_organizations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` BIGINT NOT NULL CHECK (col1 BETWEEN 1000000000000 AND 9999999999999) COMMENT 'ОГРН',
  `col2` varchar(200) NOT NULL COMMENT 'Наименование учреждения',
  `col3` LONGTEXT NOT NULL COMMENT 'Адресс учреждения',
  `col4` VARCHAR(45) NOT NULL COMMENT 'Телефон организации',
  `col5` VARCHAR(45) NOT NULL COMMENT 'Контактное лицо',
  `col6` VARCHAR(45) NOT NULL COMMENT 'Специализация учреждения',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `col2_UNIQUE` (`col2` ASC) VISIBLE)
COMMENT = 'Медицинские организации сотрудничающие с учреждением медико-социальной экспертизы';
-- ****************************************************************************************************************************** --
DROP TABLE IF EXISTS last_psy_test;
CREATE TABLE `coursework`.`last_psy_test` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `col1` INT NULL COMMENT 'ID гражданина',
  `col2` INT NULL DEFAULT NULL COMMENT 'Уровень IQ',
  `col3` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Уровень социализации',
  `col4` TINYINT NULL DEFAULT NULL COMMENT 'Наличие агрессивных тенденций',
  PRIMARY KEY (`id`),
  FOREIGN KEY (col1) REFERENCES persons (id) ON DELETE CASCADE)
COMMENT = 'Результаты последнего психологического тестирования';