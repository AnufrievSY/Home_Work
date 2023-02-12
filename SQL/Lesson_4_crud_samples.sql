-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_22
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookmarks`
--

DROP TABLE IF EXISTS `bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmarks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `users_id` bigint(20) unsigned NOT NULL,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_id` bigint(20) unsigned NOT NULL,
  `tags_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks`
--

LOCK TABLES `bookmarks` WRITE;
/*!40000 ALTER TABLE `bookmarks` DISABLE KEYS */;
INSERT INTO `bookmarks` VALUES (1,1,'fugiat',1,1,'2004-04-29 09:19:07'),(2,2,'corporis',2,2,'1985-04-14 00:39:51'),(3,3,'fugit',3,3,'1981-02-25 22:23:34'),(4,4,'quam',4,4,'1984-07-25 19:20:50'),(5,5,'nihil',5,5,'1989-09-22 04:01:57'),(6,6,'reprehenderit',6,6,'1992-01-11 10:45:14'),(7,7,'quaerat',7,7,'2013-04-05 18:25:04'),(8,8,'cupiditate',8,8,'2006-07-25 09:26:28'),(9,9,'ut',9,9,'2015-01-07 03:50:35'),(10,10,'pariatur',10,10,'1996-12-25 05:21:16');
/*!40000 ALTER TABLE `bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookmarks_type`
--

DROP TABLE IF EXISTS `bookmarks_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmarks_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmarks_type`
--

LOCK TABLES `bookmarks_type` WRITE;
/*!40000 ALTER TABLE `bookmarks_type` DISABLE KEYS */;
INSERT INTO `bookmarks_type` VALUES (1,' сюжет'),(2,' статьи'),(3,' сообщества'),(4,'люди'),(5,' запись'),(6,' товары и услуги'),(7,' подкасты'),(8,' видео'),(9,' объявления'),(10,' ссылки');
/*!40000 ALTER TABLE `bookmarks_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_user_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `communities_name_idx` (`name`),
  KEY `admin_user_id` (`admin_user_id`),
  CONSTRAINT `communities_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
INSERT INTO `communities` VALUES (1,'Synchronised local function',9),(2,'Focused didactic intranet',1),(3,'Open-architected uniform knowledgebase',2),(4,'Vision-oriented clear-thinking functionalities',2),(5,'Streamlined systematic collaboration',4),(6,'Persistent holistic success',8),(7,'Triple-buffered cohesive website',4),(8,'Proactive content-based definition',7),(9,'Ergonomic demand-driven neural-net',3),(10,'Monitored maximized securedline',9);
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend_requests`
--

DROP TABLE IF EXISTS `friend_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend_requests` (
  `initiator_user_id` bigint(20) unsigned NOT NULL,
  `target_user_id` bigint(20) unsigned NOT NULL,
  `status` enum('requested','approved','declined','unfriended') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requested_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  KEY `target_user_id` (`target_user_id`),
  CONSTRAINT `friend_requests_ibfk_1` FOREIGN KEY (`initiator_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `friend_requests_ibfk_2` FOREIGN KEY (`target_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_requests`
--

LOCK TABLES `friend_requests` WRITE;
/*!40000 ALTER TABLE `friend_requests` DISABLE KEYS */;
INSERT INTO `friend_requests` VALUES (1,7,'requested','1986-08-26 00:15:41','2015-07-29 06:43:44'),(1,8,'declined','1980-08-20 14:36:02','1988-08-05 19:58:53'),(1,9,'requested','1984-08-12 02:47:03','1977-04-30 03:26:11'),(2,8,'declined','2016-07-14 06:38:30','1977-08-21 05:11:48'),(3,7,'requested','1976-02-01 22:39:18','1994-01-08 21:51:45'),(3,9,'requested','1978-12-14 21:47:35','2017-04-07 14:36:34'),(4,6,'requested','1983-07-19 19:35:33','1986-04-13 02:14:34'),(4,9,'unfriended','2006-12-31 09:44:56','1970-04-26 08:48:11'),(4,10,'declined','1987-07-28 16:14:56','1970-08-30 05:57:23'),(5,9,'declined','1978-11-15 03:44:44','2015-10-07 10:22:09');
/*!40000 ALTER TABLE `friend_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,10,8,'1979-12-17 19:54:37'),(2,8,1,'1981-12-04 04:36:19'),(3,8,10,'1970-09-04 14:29:51'),(4,10,7,'1974-02-14 07:48:27'),(5,6,3,'2017-03-24 14:53:35'),(6,6,8,'1984-08-24 04:13:46'),(7,3,7,'1983-06-24 13:23:30'),(8,1,2,'1992-09-25 21:41:58'),(9,4,1,'2015-07-16 21:44:43'),(10,2,8,'1978-06-29 13:35:39');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_type_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  KEY `media_type_id` (`media_type_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`media_type_id`) REFERENCES `media_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,1,'Ut laudantium deleniti explicabo quisquam provident. Dicta impedit dolor explicabo. Inventore omnis reiciendis consequatur.','reiciendis',213898485,NULL,'2013-09-29 06:44:46','1994-01-02 07:56:07'),(2,2,2,'Odio aut placeat ab aut. Deserunt eius pariatur delectus maxime itaque autem. Amet aut quidem recusandae. Fugit porro occaecati praesentium architecto exercitationem quidem.','molestiae',124151,NULL,'2010-07-07 05:39:53','1987-05-03 05:55:52'),(3,3,3,'Nisi repellat dolor quis. Quia sed ipsa suscipit. Minima sequi voluptatum omnis repellendus a ut fugiat.','rerum',607511,NULL,'1970-10-14 00:42:33','2021-07-22 01:17:58'),(4,4,4,'Quod perspiciatis accusamus amet enim iure repellendus possimus dolorum. Cum non non perspiciatis ad aut molestiae aut. Quos voluptas itaque nesciunt magni eum iusto exercitationem. Eum necessitatibus libero et amet non.','non',572,NULL,'1998-12-03 01:15:43','2021-06-21 11:52:41'),(5,5,5,'Eos ad earum veniam qui. Esse aut et doloremque aperiam. Possimus dolor sint consequatur incidunt eius aut.','quia',931,NULL,'1991-07-19 22:41:38','2010-08-11 08:49:34'),(6,6,6,'Tenetur libero et qui et ea. Et eveniet nesciunt molestiae. Molestiae eveniet commodi beatae asperiores esse eaque sequi. Atque optio totam autem aut vel voluptatibus voluptas.','nostrum',6,NULL,'2006-08-14 12:21:47','2019-09-08 08:06:55'),(7,7,7,'Corporis nostrum et rerum assumenda nihil ut provident. Repudiandae cum deleniti voluptatum rerum harum. Quidem minima facere similique animi. Est corporis voluptas eaque sed aut quos.','accusantium',846201137,NULL,'1985-05-31 02:42:18','2010-03-12 07:43:28'),(8,8,8,'Aliquid a sapiente repellendus dolorem qui veritatis suscipit quam. Magnam modi consequatur ut eius. Voluptatum quis delectus optio aut.','corrupti',84,NULL,'1982-02-23 06:17:41','1979-04-15 10:20:53'),(9,9,9,'Quasi qui repellat ut dolorem aut tempore. Omnis eveniet sunt dolor provident et quasi quo. Quis ducimus quam voluptas laborum corrupti. Vitae accusamus consequatur totam quidem tempore tempora provident est.','accusamus',368695826,NULL,'2021-03-31 19:23:50','1996-08-26 11:20:11'),(10,10,10,'Rerum dolorem alias dolor. Iste velit consequatur cumque sit autem voluptates. Velit non sed odit nulla. Sequi ut deserunt et autem recusandae.','velit',11,NULL,'2005-04-10 21:29:06','1973-08-11 18:29:07');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (1,'ex','2002-05-08 12:02:10','1977-10-05 12:38:14'),(2,'voluptatum','2008-04-09 04:45:29','2004-10-14 02:32:22'),(3,'et','1999-11-06 04:11:43','1974-12-01 14:19:13'),(4,'expedita','1998-03-23 07:53:45','2007-07-30 22:35:20'),(5,'quia','2021-02-04 10:43:20','1990-08-23 05:03:28'),(6,'quia','2015-09-16 03:28:47','2017-01-31 12:02:18'),(7,'sit','2022-09-19 05:06:13','1980-07-07 19:21:27'),(8,'quo','1975-04-08 05:05:35','1976-04-21 14:24:25'),(9,'aut','1986-05-26 06:19:16','2000-01-09 07:33:37'),(10,'nobis','1986-07-30 10:29:06','2002-05-07 05:43:32');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) unsigned NOT NULL,
  `to_user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  UNIQUE KEY `id` (`id`),
  KEY `from_user_id` (`from_user_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,8,'Molestiae fugiat praesentium quos et et hic quo. Ab sit ullam animi vel alias. Porro explicabo in modi quia deleniti aut consequatur. Ut neque nemo corrupti tempora voluptatem et. Voluptatibus aut aut occaecati praesentium sed.','1983-09-27 19:10:09'),(2,3,8,'Veniam ab est incidunt numquam sit laudantium explicabo. Ut adipisci amet omnis quos illum incidunt exercitationem. Fugit et aut enim quia. Ex aut eligendi voluptatem non molestias vero perspiciatis odio.','2000-12-15 21:23:38'),(3,5,8,'Sunt ipsum facilis tempora at. Dolores qui et et fugiat sunt. Aut at voluptates error.','1996-02-21 20:23:55'),(4,1,8,'Enim eius rerum voluptatibus eum iste natus ut. Quidem debitis voluptatibus distinctio. Sunt occaecati quam ducimus quis. Cumque tenetur quia asperiores minus voluptatum blanditiis soluta numquam.','2022-02-19 02:12:15'),(5,5,10,'Pariatur et id voluptas sed illum. Consequatur esse sed assumenda itaque voluptatibus cum sed suscipit. Ducimus libero dolorem cumque ipsam at delectus. Suscipit ipsam ea quo et in qui.','2018-01-19 03:09:21'),(6,3,10,'Quos harum magni quia suscipit molestiae sequi distinctio et. Eligendi sint est sapiente. Magnam quia quia quidem illo officia rerum pariatur. Saepe nostrum laboriosam saepe quo fugit.','1983-07-21 07:54:09'),(7,5,6,'Facilis eum magni placeat esse. Delectus omnis et et optio quaerat aut. Consectetur ut dolorem explicabo molestiae odit aut quam.','2004-11-26 00:38:45'),(8,1,7,'Est impedit consectetur aliquid quasi. Dolores optio odit est tempore. Laborum non ut sit non.','1980-04-24 00:47:09'),(9,2,9,'Sint odio in non consectetur. Repellendus provident voluptatum tempore sit quia culpa aut. Tempore qui sed sapiente asperiores. Cumque tenetur debitis cupiditate qui nesciunt suscipit aut.','2006-06-28 22:11:44'),(10,4,8,'Nostrum et qui officia sit maxime animi. Cupiditate sit minus voluptatem eum nostrum. Non illo dolorum molestiae omnis consectetur in voluptatem.','1979-08-28 00:46:40');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_tags`
--

DROP TABLE IF EXISTS `personal_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_tags`
--

LOCK TABLES `personal_tags` WRITE;
/*!40000 ALTER TABLE `personal_tags` DISABLE KEYS */;
INSERT INTO `personal_tags` VALUES (1,' идеи'),(2,' разобрать'),(3,' 8 марта'),(4,' мысли'),(5,' др'),(6,' посетить'),(7,' личное'),(8,' 23 февраля'),(9,'нг'),(10,' на вечер');
/*!40000 ALTER TABLE `personal_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_albums` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photo_albums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,'quibusdam',1),(2,'dignissimos',2),(3,'voluptate',3),(4,'accusamus',4),(5,'aspernatur',5),(6,'assumenda',6),(7,'totam',7),(8,'velit',8),(9,'eos',9),(10,'non',10);
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` bigint(20) unsigned DEFAULT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `album_id` (`album_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `photo_albums` (`id`),
  CONSTRAINT `photos_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `gender` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `photo_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `hometown` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'f','1984-05-02',4,'1981-10-03 12:21:06','Spencerton'),(2,'f','2007-08-19',4,'1974-03-02 15:17:42','Port Mercedes'),(3,'m','1985-10-08',4,'2012-10-22 08:11:24','Orrinland'),(4,'f','1974-06-21',3,'1990-01-23 07:28:15','Lake Gina'),(5,'m','1995-11-12',5,'2005-01-19 13:46:23','Alexandrealand'),(6,'m','1996-08-10',4,'1972-05-20 16:28:16','North Demarcus'),(7,'f','1989-08-22',10,'1971-02-10 04:35:28','Moenport'),(8,'f','1980-04-04',2,'1971-11-11 02:03:30','Lake Karlview'),(9,'m','2006-06-28',1,'2017-10-27 12:17:53','South Sabryna'),(10,'f','2005-10-22',9,'1973-04-29 23:32:35','Lurashire');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Фамиль',
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='юзеры';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Kristian','Kuhic','domingo27@example.com','b452b994f1fddad08f5beb99ccb5851a70a55207',89288456917),(2,'Myrtice','Rutherford','shannon.reynolds@example.org','c099cba03b687ee436db10ee34bc9a9da2d3482e',89177913254),(3,'Kobe','Kreiger','nberge@example.net','ff402b660ad7283310dbe1a1d3e24e322d5b9539',89378125336),(4,'Benjamin','Frami','sosinski@example.org','615a6de9aa90da76b05c8d618d117beb007e4470',89878758414),(5,'Dejuan','Beatty','jleffler@example.net','a7ae630e8541fa6b81c5ebb9324ec35d09291fd0',89351338468),(6,'Chandler','Leannon','janis.rutherford@example.com','01b61b5f981a9c0b2b643b48485e8d18af6a7fc8',89491242155),(7,'Lucienne','Ryan','lehner.pierce@example.net','5ec52dcb44d4acf9b09bd817c8cd02d50a39447c',89822520933),(8,'Judy','Kuhlman','alexandria26@example.org','9aa66a9903b2963a4a18866860db80a5661c79df',89113834696),(9,'Stephanie','Barton','eva.baumbach@example.com','8fa2175cf82d8dc2f7adcc150baf44edce055fc3',89915396364),(10,'Dillon','Nolan','mabel.effertz@example.com','40a6e3f4bb8eaf1c59246142234411be770eb905',89077358569);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_communities`
--

DROP TABLE IF EXISTS `users_communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_communities` (
  `user_id` bigint(20) unsigned NOT NULL,
  `community_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`community_id`),
  KEY `community_id` (`community_id`),
  CONSTRAINT `users_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `users_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_communities`
--

LOCK TABLES `users_communities` WRITE;
/*!40000 ALTER TABLE `users_communities` DISABLE KEYS */;
INSERT INTO `users_communities` VALUES (1,8),(3,8),(5,6),(8,2),(8,3),(8,5),(8,6),(8,9),(10,2),(10,3);
/*!40000 ALTER TABLE `users_communities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-03 10:38:45
