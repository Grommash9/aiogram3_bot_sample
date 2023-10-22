-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: cakealliance-bots-oleksandr-5.cbiq3ffy489l.eu-central-1.rds.amazonaws.com    Database: bot_currency_exchange
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `currency_price`
--

DROP TABLE IF EXISTS `currency_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_price` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `cur_code` varchar(50) NOT NULL,
  `rate` double NOT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  `rate_source_id` int NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `currency_price_cur_code_rate_source_id_e2f027d7_uniq` (`cur_code`,`rate_source_id`),
  KEY `currency_price_rate_source_id_67a3256b_fk_currency_` (`rate_source_id`),
  CONSTRAINT `currency_price_rate_source_id_67a3256b_fk_currency_` FOREIGN KEY (`rate_source_id`) REFERENCES `currency_source` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1805530230 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_price`
-- Table structure for table `currency_price_modify`
--

DROP TABLE IF EXISTS `currency_price_modify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_price_modify` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `additional_percent` double NOT NULL,
  `bot_id` bigint NOT NULL,
  `currency_id` int NOT NULL,
  `divide_to_calculate` tinyint(1) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `currency_price_modify_currency_id_bot_id_ffaaf5ec_uniq` (`currency_id`,`bot_id`),
  KEY `currency_price_modify_bot_id_b3bdcd43_fk_tg_bot_tg_id` (`bot_id`),
  CONSTRAINT `currency_price_modif_currency_id_8796af29_fk_currency_` FOREIGN KEY (`currency_id`) REFERENCES `currency_price` (`record_id`),
  CONSTRAINT `currency_price_modify_bot_id_b3bdcd43_fk_tg_bot_tg_id` FOREIGN KEY (`bot_id`) REFERENCES `tg_bot` (`tg_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_price_modify`
--

LOCK TABLES `currency_price_modify` WRITE;
/*!40000 ALTER TABLE `currency_price_modify` DISABLE KEYS */;
INSERT INTO `currency_price_modify` VALUES (1,10,6341753035,18,1),(2,20,6341753035,418,1),(7,22,6341753035,637,1),(8,2,6275774162,347,1),(9,2,6220001215,347,1),(13,2,6220001215,417,1),(14,20,6341753035,421,0),(15,6,6341753035,347,0),(16,2,6341753035,85,0),(20,6,6626630391,347,0),(21,6,5727679143,73,1),(22,10,6564303561,121,0),(23,10,6594701198,84,1),(24,10,6594701198,87,1),(25,6,6524842903,87,0),(26,5,6138427843,347,0),(27,2,6514603813,347,0),(28,2,6665144460,347,0),(29,5,6331743662,347,0),(30,17,6483317448,347,0);
/*!40000 ALTER TABLE `currency_price_modify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_source`
--

DROP TABLE IF EXISTS `currency_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_source` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_source`
--

LOCK TABLES `currency_source` WRITE;
/*!40000 ALTER TABLE `currency_source` DISABLE KEYS */;
INSERT INTO `currency_source` VALUES (3,'Lavandos'),(1,'WhiteBit');
/*!40000 ALTER TABLE `currency_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_operation`
--

DROP TABLE IF EXISTS `exchange_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_operation` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `created` datetime(6) DEFAULT NULL,
  `updated` datetime(6) DEFAULT NULL,
  `deposit_tx_id` varchar(200) DEFAULT NULL,
  `withdrawal_tx_id` varchar(200) DEFAULT NULL,
  `rate_applied` double NOT NULL,
  `deposit_amount` double NOT NULL,
  `withdrawal_amount` double NOT NULL,
  `deposit_gate_title` varchar(50) NOT NULL,
  `withdrawal_gate_title` varchar(50) NOT NULL,
  `deposit_gateway_id` int NOT NULL,
  `deposit_token_and_network_id` int DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `withdrawal_gateway_id` int NOT NULL,
  `withdrawal_token_id` int DEFAULT NULL,
  `bot_used_id` bigint DEFAULT NULL,
  `message_associated_id` bigint DEFAULT NULL,
  `user_associated_id` bigint DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `exchange_operation_deposit_gateway_id_c93f11ba_fk_gate_way_` (`deposit_gateway_id`),
  KEY `exchange_operation_status_id_421392b9_fk_exchange_` (`status_id`),
  KEY `exchange_operation_withdrawal_gateway_i_93532aec_fk_gate_way_` (`withdrawal_gateway_id`),
  KEY `exchange_operation_withdrawal_token_id_05f3359c_fk_gate_way_` (`withdrawal_token_id`),
  KEY `exchange_operation_deposit_token_and_ne_7fb08275_fk_gate_way_` (`deposit_token_and_network_id`),
  KEY `exchange_operation_bot_used_id_e7ca8cef_fk_tg_bot_tg_id` (`bot_used_id`),
  KEY `exchange_operation_user_associated_id_59ca8377_fk_tg_user_t` (`user_associated_id`),
  CONSTRAINT `exchange_operation_bot_used_id_e7ca8cef_fk_tg_bot_tg_id` FOREIGN KEY (`bot_used_id`) REFERENCES `tg_bot` (`tg_id`),
  CONSTRAINT `exchange_operation_deposit_gateway_id_c93f11ba_fk_gate_way_` FOREIGN KEY (`deposit_gateway_id`) REFERENCES `gate_way` (`record_id`),
  CONSTRAINT `exchange_operation_deposit_token_and_ne_7fb08275_fk_gate_way_` FOREIGN KEY (`deposit_token_and_network_id`) REFERENCES `gate_way_token_network` (`record_id`),
  CONSTRAINT `exchange_operation_status_id_421392b9_fk_exchange_` FOREIGN KEY (`status_id`) REFERENCES `exchange_operation_status` (`record_id`),
  CONSTRAINT `exchange_operation_user_associated_id_59ca8377_fk_tg_user_t` FOREIGN KEY (`user_associated_id`) REFERENCES `tg_user` (`tg_chat_id`),
  CONSTRAINT `exchange_operation_withdrawal_gateway_i_93532aec_fk_gate_way_` FOREIGN KEY (`withdrawal_gateway_id`) REFERENCES `gate_way` (`record_id`),
  CONSTRAINT `exchange_operation_withdrawal_token_id_05f3359c_fk_gate_way_` FOREIGN KEY (`withdrawal_token_id`) REFERENCES `gate_way_token_network` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_operation`
--

LOCK TABLES `exchange_operation` WRITE;
/*!40000 ALTER TABLE `exchange_operation` DISABLE KEYS */;
INSERT INTO `exchange_operation` VALUES (1,'2023-07-26 15:26:04.629872',NULL,NULL,NULL,39.4332,3122.3182496,123123,'USDT','UAH Wise',1,1,8,4,2,NULL,NULL,NULL),(2,'2023-07-26 15:44:44.336863',NULL,NULL,NULL,39.4332,31.21734985,1231,'USDT','UAH',1,1,8,5,3,NULL,NULL,NULL),(3,'2023-07-26 16:04:18.211495',NULL,NULL,NULL,39.4332,3.34743313,132,'USDT','UAH',1,1,8,3,2,NULL,NULL,NULL),(4,'2023-07-27 10:39:24.995156',NULL,NULL,NULL,4.39177,87835.4,20000,'USDT','UAH',1,1,8,3,2,NULL,NULL,NULL),(8,'2023-07-27 11:52:00.304023',NULL,NULL,NULL,30173.26261,6128917535878.204,203124124,'USDT','UAH',1,1,8,3,2,NULL,NULL,NULL),(9,'2023-07-27 12:09:15.321224',NULL,NULL,NULL,39.4332,157732.8,4000,'USDT','UAH',1,1,8,6,2,NULL,NULL,NULL),(10,'2023-07-27 12:12:29.716157',NULL,NULL,NULL,39.4332,78866.4,2000,'USDT','QIWI',1,1,8,7,2,NULL,NULL,NULL),(11,'2023-07-27 12:33:00.826529',NULL,NULL,NULL,39.4332,78984.6996,2003,'USDT','QIWI',1,1,8,7,2,NULL,NULL,NULL),(12,'2023-07-27 12:55:11.758808',NULL,NULL,NULL,40.9796,1065469.6,26000,'USDT','UAH',1,1,8,2,2,NULL,NULL,NULL),(13,'2023-07-28 10:36:06.750228',NULL,NULL,NULL,40.9796,81959.2,2000,'USDT','UAH',1,1,8,4,2,NULL,NULL,NULL),(14,'2023-07-28 10:38:24.120153',NULL,NULL,NULL,40.9796,50445.8876,1231,'USDT','UAH',1,1,8,4,2,NULL,NULL,NULL),(15,'2023-07-31 07:25:01.172145',NULL,NULL,NULL,31167.5722,311675722,10000,'USD','UAH',1,1,8,2,2,NULL,NULL,NULL),(16,'2023-08-01 07:17:26.000000',NULL,NULL,NULL,40.56151,49.30782902,2000,'USDT','Wise UAH',1,2,8,4,2,6138427843,21,5891826489),(17,'2023-08-01 08:18:33.390248',NULL,'5ba227810fcfd76463b65c71bbb1249bc36ae86818c507c3960887d909bf12a6','Manual 1',40.56151,1000,40561.50999999,'USDT','Wise UAH',1,2,4,4,2,6138427843,24,5891826489),(18,'2023-08-01 08:38:43.519650',NULL,'5ba227810fcfd76463b65c71bbb1249bc36ae86818c507c3960887d909bf12a6','Manual 2',40.56151,1000,40561.5,'USDT','Wise UAH',1,2,4,4,5,6138427843,45,5891826489),(19,'2023-08-01 08:43:33.361894',NULL,NULL,NULL,40.56151,49.30782902,2000,'USDT','Wise UAH',1,2,8,4,5,6138427843,53,5891826489),(20,'2023-08-01 08:53:38.767592',NULL,'5ba227810fcfd76463b65c71bbb1249bc36ae86818c507c3960887d909bf12a6','Manual 3',40.57201,1000,40572,'USDT','Wise UAH',1,2,4,4,5,6138427843,76,5891826489),(21,'2023-08-01 11:09:19.876521',NULL,'internal_transaction_5ca85fd8-4f28-466a-b00c-270c7b5b68b1','Manual 4',40.63501,10358,420897.43,'USDT','Wise UAH',1,2,4,4,5,6138427843,106,5891826489),(22,'2023-08-01 13:23:32.977810',NULL,'81e12920eb7ec37ffafc00baee53437bb5bd161b326d4655e8b6d5be3879d6e1','Manual 5',39.41281,734,28929,'USDT','UAH',1,2,4,4,5,6514603813,703,5891826489),(23,'2023-08-01 13:29:28.216773',NULL,'81e12920eb7ec37ffafc00baee53437bb5bd161b326d4655e8b6d5be3879d6e1','Manual 6',39.41281,734,28929,'USDT','UAH',1,2,4,4,5,6514603813,724,5891826489),(24,'2023-08-01 13:57:06.724668',NULL,'08a7fe0fbd77d943b76f89d79733f5ddbbc45e981885477554c6619b4579fab8','Manual 7',39.423,794.594594,31325.3,'USDT','UAH',1,2,5,4,5,6514603813,745,5891826489),(25,'2023-08-01 18:45:01.818560',NULL,'ae747cc464fde822095509200a18535f9e553ffa9ab6a6e885df155f58f44cf2','29309',39.423,5000,197115,'USDT','UAH',1,2,5,8,5,6665144460,14,5891826489),(26,'2023-08-01 18:57:19.688880',NULL,'ae747cc464fde822095509200a18535f9e553ffa9ab6a6e885df155f58f44cf2','29312',39.4536,5000,197268,'USDT','UAH',1,2,5,8,5,6665144460,29,5891826489),(27,'2023-08-02 08:13:35.417441',NULL,NULL,NULL,39.4536,58.87929111,2323,'USDT','UAH',1,1,8,4,5,6514603813,765,5891826489),(28,'2023-08-02 08:49:52.012159',NULL,NULL,NULL,39.4332,82.21498635,3242,'USDT','UAH',1,2,7,8,5,6665144460,52,5891826489),(29,'2023-08-02 08:51:14.625620',NULL,NULL,NULL,39.4332,586.15582808,23114,'USDT','UAH',1,2,8,8,5,6665144460,59,5891826489),(30,'2023-08-02 11:55:26.615169',NULL,'6ff19b84cf5ad5f5fc9689211413692c286fc2f19c29c0c25660e0cb775b4131','29500',40.5825,5000,202912.5,'USDT','UAH',1,2,5,8,5,6331743662,17,5891826489),(31,'2023-08-02 12:00:15.061401',NULL,'6ff19b84cf5ad5f5fc9689211413692c286fc2f19c29c0c25660e0cb775b4131','Manual 8',45.2205,5000,226102.5,'USDT','UAH',1,2,5,4,5,6483317448,25,5891826489),(32,'2023-08-02 12:30:07.744332',NULL,NULL,NULL,45.2205,2722.72531263,123123,'USDT','UAH',1,3,8,4,5,6483317448,46,5891826489);
/*!40000 ALTER TABLE `exchange_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_operation_deposit_data`
--

DROP TABLE IF EXISTS `exchange_operation_deposit_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_operation_deposit_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `exchangeoperation_id` int NOT NULL,
  `usergatewaydata_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exchange_operation_depos_exchangeoperation_id_use_a17266b0_uniq` (`exchangeoperation_id`,`usergatewaydata_id`),
  KEY `exchange_operation_d_usergatewaydata_id_99737a5a_fk_gate_way_` (`usergatewaydata_id`),
  CONSTRAINT `exchange_operation_d_exchangeoperation_id_191379e9_fk_exchange_` FOREIGN KEY (`exchangeoperation_id`) REFERENCES `exchange_operation` (`record_id`),
  CONSTRAINT `exchange_operation_d_usergatewaydata_id_99737a5a_fk_gate_way_` FOREIGN KEY (`usergatewaydata_id`) REFERENCES `gate_way_user_input` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_operation_deposit_data`
--

LOCK TABLES `exchange_operation_deposit_data` WRITE;
/*!40000 ALTER TABLE `exchange_operation_deposit_data` DISABLE KEYS */;
INSERT INTO `exchange_operation_deposit_data` VALUES (1,1,1),(2,1,2),(3,1,3),(4,2,8),(5,2,9),(6,2,10),(7,3,13),(8,3,14),(9,3,15),(10,4,18),(11,4,19),(12,4,20),(13,8,23),(14,8,24),(15,8,25),(16,9,28),(17,9,29),(18,9,30),(19,10,33),(20,10,34),(21,10,35),(22,11,38),(23,11,39),(24,11,40),(25,12,43),(26,12,44),(27,12,45),(28,13,48),(29,13,49),(30,13,50),(31,14,54),(32,14,55),(33,14,56),(34,15,60),(35,15,61),(36,15,62),(37,16,65),(38,16,66),(39,16,67),(40,17,71),(41,17,72),(42,17,73),(43,18,77),(44,18,78),(45,18,79),(46,19,83),(47,19,84),(48,19,85),(49,20,89),(50,20,90),(51,20,91),(52,21,95),(53,21,96),(54,21,97),(55,22,101),(56,22,102),(57,22,103),(58,23,107),(59,23,108),(60,23,109),(61,24,113),(62,24,114),(63,24,115),(64,25,119),(65,25,120),(66,25,121),(67,26,123),(68,26,124),(69,26,125),(70,27,127),(71,27,128),(72,27,129),(73,28,133),(74,28,134),(75,28,135),(76,29,137),(77,29,138),(78,29,139),(79,30,141),(80,30,142),(81,30,143),(82,31,145),(83,31,146),(84,31,147),(85,32,151),(86,32,152),(87,32,153);
/*!40000 ALTER TABLE `exchange_operation_deposit_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_operation_status`
--

DROP TABLE IF EXISTS `exchange_operation_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_operation_status` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_operation_status`
--

LOCK TABLES `exchange_operation_status` WRITE;
/*!40000 ALTER TABLE `exchange_operation_status` DISABLE KEYS */;
INSERT INTO `exchange_operation_status` VALUES (1,'New','new'),(2,'In progress','in_progress'),(3,'Payed','payed'),(4,'Real Pay','realpay'),(5,'Success','success'),(6,'Failed','failed'),(7,'Canceled','canceled'),(8,'Expired','expired');
/*!40000 ALTER TABLE `exchange_operation_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_operation_status_translations`
--

DROP TABLE IF EXISTS `exchange_operation_status_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_operation_status_translations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `language_id` int NOT NULL,
  `param_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `exchange_operation_s_language_id_df204af5_fk_languages` (`language_id`),
  KEY `exchange_operation_s_param_id_b5fd8074_fk_exchange_` (`param_id`),
  CONSTRAINT `exchange_operation_s_language_id_df204af5_fk_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`record_id`),
  CONSTRAINT `exchange_operation_s_param_id_b5fd8074_fk_exchange_` FOREIGN KEY (`param_id`) REFERENCES `exchange_operation_status` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_operation_status_translations`
--

LOCK TABLES `exchange_operation_status_translations` WRITE;
/*!40000 ALTER TABLE `exchange_operation_status_translations` DISABLE KEYS */;
INSERT INTO `exchange_operation_status_translations` VALUES (1,'Створена',9,1),(2,'В процесі',9,2);
/*!40000 ALTER TABLE `exchange_operation_status_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exchange_operation_withdrawal_data`
--

DROP TABLE IF EXISTS `exchange_operation_withdrawal_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exchange_operation_withdrawal_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `exchangeoperation_id` int NOT NULL,
  `usergatewaydata_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exchange_operation_withd_exchangeoperation_id_use_67f1ff2b_uniq` (`exchangeoperation_id`,`usergatewaydata_id`),
  KEY `exchange_operation_w_usergatewaydata_id_d2ce9354_fk_gate_way_` (`usergatewaydata_id`),
  CONSTRAINT `exchange_operation_w_exchangeoperation_id_c8c3f8b2_fk_exchange_` FOREIGN KEY (`exchangeoperation_id`) REFERENCES `exchange_operation` (`record_id`),
  CONSTRAINT `exchange_operation_w_usergatewaydata_id_d2ce9354_fk_gate_way_` FOREIGN KEY (`usergatewaydata_id`) REFERENCES `gate_way_user_input` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exchange_operation_withdrawal_data`
--

LOCK TABLES `exchange_operation_withdrawal_data` WRITE;
/*!40000 ALTER TABLE `exchange_operation_withdrawal_data` DISABLE KEYS */;
INSERT INTO `exchange_operation_withdrawal_data` VALUES (1,1,4),(2,1,5),(3,1,6),(4,1,7),(5,2,11),(6,2,12),(7,3,16),(8,3,17),(9,4,21),(10,4,22),(11,8,26),(12,8,27),(13,9,31),(14,9,32),(15,10,36),(16,10,37),(17,11,41),(18,11,42),(19,12,46),(20,12,47),(21,13,51),(22,13,52),(23,13,53),(24,14,57),(25,14,58),(26,14,59),(27,15,63),(28,15,64),(29,16,68),(30,16,69),(31,16,70),(32,17,74),(33,17,75),(34,17,76),(35,18,80),(36,18,81),(37,18,82),(38,19,86),(39,19,87),(40,19,88),(41,20,92),(42,20,93),(43,20,94),(44,21,98),(45,21,99),(46,21,100),(47,22,104),(48,22,105),(49,22,106),(50,23,110),(51,23,111),(52,23,112),(53,24,116),(54,24,117),(55,24,118),(56,25,122),(57,26,126),(58,27,130),(59,27,131),(60,27,132),(61,28,136),(62,29,140),(63,30,144),(64,31,148),(65,31,149),(66,31,150),(67,32,154),(68,32,155),(69,32,156);
/*!40000 ALTER TABLE `exchange_operation_withdrawal_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_way`
--

DROP TABLE IF EXISTS `gate_way`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_way` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `gate_way_title` varchar(100) NOT NULL,
  `auto_processing` tinyint(1) NOT NULL,
  `deposit_acceptable` tinyint(1) NOT NULL,
  `withdrawal_acceptable` tinyint(1) NOT NULL,
  `account_id` int DEFAULT NULL,
  `programing_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `gate_way_title` (`gate_way_title`),
  UNIQUE KEY `programing_code` (`programing_code`),
  KEY `gate_way_account_id_978b64f4_fk_gate_way_` (`account_id`),
  CONSTRAINT `gate_way_account_id_978b64f4_fk_gate_way_` FOREIGN KEY (`account_id`) REFERENCES `gate_way_account_details` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_way`
--

LOCK TABLES `gate_way` WRITE;
/*!40000 ALTER TABLE `gate_way` DISABLE KEYS */;
INSERT INTO `gate_way` VALUES (1,'WhiteBit',1,1,0,1,'white_bit'),(2,'PrivatBank',0,0,1,NULL,NULL),(3,'MonoBank',0,0,1,NULL,NULL),(4,'Wise',0,0,1,NULL,NULL),(5,'Paypal',0,0,1,NULL,NULL),(6,'Payoneer',0,0,1,NULL,NULL),(7,'Qiwi',0,0,1,NULL,NULL),(8,'Karbovanec UA',1,0,1,2,'karbovanecbot_ua');
/*!40000 ALTER TABLE `gate_way` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_way_account_details`
--

DROP TABLE IF EXISTS `gate_way_account_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_way_account_details` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `connection_details` longblob NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_way_account_details`
--

LOCK TABLES `gate_way_account_details` WRITE;
/*!40000 ALTER TABLE `gate_way_account_details` DISABLE KEYS */;
INSERT INTO `gate_way_account_details` VALUES (1,'WhiteBit FB2',_binary '{\"api_key\":\"6e87359cfcb04c42af34bc08934a310d\", \"secret_key\":\"c16cf7d30b3fefd7ac8918a8d0fa7800\"}'),(2,'karbo_ua_test',_binary '{\"api_url\": \"https://api.karbovanecbot.io/payout\", \"api_token\": \"a0164a0c-0b77-438c-a8b3-434908d788bd\"}');
/*!40000 ALTER TABLE `gate_way_account_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_way_available_token_and_network`
--

DROP TABLE IF EXISTS `gate_way_available_token_and_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_way_available_token_and_network` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `paymentgateway_id` int NOT NULL,
  `networktoken_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gate_way_available_token_paymentgateway_id_networ_1293ce06_uniq` (`paymentgateway_id`,`networktoken_id`),
  KEY `gate_way_available_t_networktoken_id_8bd4c4f3_fk_gate_way_` (`networktoken_id`),
  CONSTRAINT `gate_way_available_t_networktoken_id_8bd4c4f3_fk_gate_way_` FOREIGN KEY (`networktoken_id`) REFERENCES `gate_way_token_network` (`record_id`),
  CONSTRAINT `gate_way_available_t_paymentgateway_id_bc6429f4_fk_gate_way_` FOREIGN KEY (`paymentgateway_id`) REFERENCES `gate_way` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_way_available_token_and_network`
--

LOCK TABLES `gate_way_available_token_and_network` WRITE;
/*!40000 ALTER TABLE `gate_way_available_token_and_network` DISABLE KEYS */;
INSERT INTO `gate_way_available_token_and_network` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,2,5),(6,2,6),(7,3,5),(8,3,6),(9,4,5),(10,4,6),(11,5,5),(12,5,6),(13,6,5),(14,6,6),(15,7,5),(16,7,6),(17,8,5);
/*!40000 ALTER TABLE `gate_way_available_token_and_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_way_network`
--

DROP TABLE IF EXISTS `gate_way_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_way_network` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `network_title` varchar(100) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `network_title` (`network_title`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_way_network`
--

LOCK TABLES `gate_way_network` WRITE;
/*!40000 ALTER TABLE `gate_way_network` DISABLE KEYS */;
INSERT INTO `gate_way_network` VALUES (3,'BTC'),(1,'ERC20'),(2,'TRC20'),(4,'TRX');
/*!40000 ALTER TABLE `gate_way_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_way_param`
--

DROP TABLE IF EXISTS `gate_way_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_way_param` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(15) NOT NULL,
  `code` varchar(15) NOT NULL,
  `regexp` varchar(200) DEFAULT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_way_param`
--

LOCK TABLES `gate_way_param` WRITE;
/*!40000 ALTER TABLE `gate_way_param` DISABLE KEYS */;
INSERT INTO `gate_way_param` VALUES (1,'Wallet','wallet',NULL,''),(2,'Card Number','card_number',NULL,'your card number'),(3,'Full Name','full_name',NULL,'first and last name'),(4,'iban','iban',NULL,'International Bank Account Number'),(5,'email','email',NULL,'email address'),(6,'Token Title','crypto_token',NULL,'crypto_token'),(7,'Network Title','crypto_network',NULL,'crypto_network'),(8,'Wallet','crypto_wallet',NULL,'crypto wallet'),(9,'Phone Number','phone_number',NULL,'phone_number'),(10,'Token','crypto_token',NULL,''),(11,'Network','crypto_network',NULL,'');
/*!40000 ALTER TABLE `gate_way_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_way_params_relation`
--

DROP TABLE IF EXISTS `gate_way_params_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_way_params_relation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `paymentgateway_id` int NOT NULL,
  `gatewayparam_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gate_way_params_paymentgateway_id_gatewayparam_id_491cbbc5_uniq` (`paymentgateway_id`,`gatewayparam_id`),
  KEY `gate_way_params_gatewayparam_id_a9fd86a9_fk_gate_way_` (`gatewayparam_id`),
  CONSTRAINT `fk_gate_way_params_gatewayparam_id` FOREIGN KEY (`gatewayparam_id`) REFERENCES `gate_way_param` (`record_id`),
  CONSTRAINT `fk_gate_way_params_paymentgateway_id` FOREIGN KEY (`paymentgateway_id`) REFERENCES `gate_way` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--
-- Dumping data for table `gate_way_params_relation`
--

LOCK TABLES `gate_way_params_relation` WRITE;
/*!40000 ALTER TABLE `gate_way_params_relation` DISABLE KEYS */;
INSERT INTO `gate_way_params_relation` VALUES (13,1,6),(14,1,7),(12,1,8),(2,2,2),(3,2,3),(4,3,2),(5,3,3),(7,4,3),(8,4,4),(9,4,5),(15,5,3),(10,5,5),(16,6,3),(11,6,5),(18,7,3),(17,7,9),(19,8,2);
/*!40000 ALTER TABLE `gate_way_params_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_way_token`
--

DROP TABLE IF EXISTS `gate_way_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_way_token` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `token_title` varchar(100) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `token_title` (`token_title`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_way_token`
--

LOCK TABLES `gate_way_token` WRITE;
/*!40000 ALTER TABLE `gate_way_token` DISABLE KEYS */;
INSERT INTO `gate_way_token` VALUES (8,'BTC'),(5,'BUSD'),(4,'EUR'),(7,'TRX'),(2,'UAH'),(3,'USD'),(6,'USDC'),(1,'USDT');
/*!40000 ALTER TABLE `gate_way_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_way_token_network`
--

DROP TABLE IF EXISTS `gate_way_token_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_way_token_network` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `decimals` int NOT NULL,
  `network_id` int DEFAULT NULL,
  `token_id` int NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `gate_way_token_netwo_network_id_f6db008f_fk_gate_way_` (`network_id`),
  KEY `gate_way_token_netwo_token_id_79b36361_fk_gate_way_` (`token_id`),
  CONSTRAINT `gate_way_token_netwo_network_id_f6db008f_fk_gate_way_` FOREIGN KEY (`network_id`) REFERENCES `gate_way_network` (`record_id`),
  CONSTRAINT `gate_way_token_netwo_token_id_79b36361_fk_gate_way_` FOREIGN KEY (`token_id`) REFERENCES `gate_way_token` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_way_token_network`
--

LOCK TABLES `gate_way_token_network` WRITE;
/*!40000 ALTER TABLE `gate_way_token_network` DISABLE KEYS */;
INSERT INTO `gate_way_token_network` VALUES (1,8,1,1),(2,8,2,1),(3,8,3,8),(4,8,4,7),(5,2,NULL,2),(6,2,NULL,3);
/*!40000 ALTER TABLE `gate_way_token_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_way_user_input`
--

DROP TABLE IF EXISTS `gate_way_user_input`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_way_user_input` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `users_input` varchar(200) DEFAULT NULL,
  `param_id` int NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `gate_way_user_input_param_id_06f7617f_fk_gate_way_` (`param_id`),
  CONSTRAINT `gate_way_user_input_param_id_06f7617f_fk_gate_way_` FOREIGN KEY (`param_id`) REFERENCES `gate_way_param` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_way_user_input`
--

LOCK TABLES `gate_way_user_input` WRITE;
/*!40000 ALTER TABLE `gate_way_user_input` DISABLE KEYS */;
INSERT INTO `gate_way_user_input` VALUES (1,'USDT',6),(2,'ERC20',7),(3,'none',8),(4,'123123123123',2),(5,'asda',3),(6,'asdasda',4),(7,'asdasd',5),(8,'USDT',6),(9,'ERC20',7),(10,'TLpJummictXctgCBdFNpyoceHCgR6grVcC',8),(11,'Data Boba',3),(12,'asdasd@gmail.com',5),(13,'USDT',6),(14,'ERC20',7),(15,'TVvfkwGjCo7CL3J5C1H4LnViXGYQ1y4WJN',8),(16,'1234123412341234',2),(17,'Data Kola',3),(18,'USDT',6),(19,'ERC20',7),(20,'TCAmfDwjTBNXxYNoM5WKo7yZWPDR5jHEeH',8),(21,'4141414141414141',2),(22,'Oleks Popol',3),(23,NULL,6),(24,NULL,7),(25,NULL,8),(26,NULL,2),(27,NULL,3),(28,'USDT',6),(29,'ERC20',7),(30,'TCAmfDwjTBNXxYNoM5WKo7yZWPDR5jHEeH',8),(31,'Oleksand OPo',3),(32,'gdfgdfg@gmai.com',5),(33,NULL,6),(34,NULL,7),(35,NULL,8),(36,NULL,3),(37,NULL,9),(38,'USDT',6),(39,'ERC20',7),(40,'TW9fVM7cHBs9d3Ha77LLe2s4FZvc3VgaTs',8),(41,'фывы фывф',3),(42,'+23232323',9),(43,'USDT',6),(44,'TRC20',7),(45,'TW9fVM7cHBs9d3Ha77LLe2s4FZvc3VgaTs',8),(46,'41414414144141441414',2),(47,'asdasd asdas',3),(48,NULL,6),(49,NULL,7),(50,NULL,8),(51,'Opol Ikok',3),(52,'GH21312313',4),(53,'sdasd',5),(54,NULL,6),(55,NULL,7),(56,NULL,8),(57,NULL,3),(58,NULL,4),(59,'asda',5),(60,'USDT',6),(61,'ERC20',7),(62,'TLLLbHQubzVnRKoL4XB2Hv42zG9aESEedw',8),(63,'1111111111111111',2),(64,'Маша Наша',3),(65,NULL,6),(66,NULL,7),(67,NULL,8),(68,'Valera Popov',3),(69,'ASD23123123',4),(70,'asdasd@gmail.com',5),(71,'USDT',6),(72,'TRC20',7),(73,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(74,'Valera Popov',3),(75,'ASD23123123',4),(76,'asdasd@gmail.com',5),(77,'USDT',6),(78,'TRC20',7),(79,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(80,'asdasda asda',3),(81,'123ASDAsd',4),(82,'asdas@gmail.com',5),(83,NULL,6),(84,NULL,7),(85,NULL,8),(86,NULL,3),(87,NULL,4),(88,NULL,5),(89,'USDT',6),(90,'TRC20',7),(91,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(92,'asdAD aSDAd',3),(93,'ASDasdaSD21323',4),(94,'asdasds@gmail.com',5),(95,'USDT',6),(96,'TRC20',7),(97,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(98,'asdasd ASDASd',3),(99,'ASDA23123123',4),(100,'asdasd@gmail.com',5),(101,'USDT',6),(102,'TRC20',7),(103,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(104,'asdasd ASDasd',3),(105,'SDq2313123',4),(106,'asdasd@gmailc.om',5),(107,'USDT',6),(108,'TRC20',7),(109,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(110,'ASDASD asdasd',3),(111,'asdASFGWEFASD',4),(112,'asdasd@gmail.com',5),(113,'USDT',6),(114,'TRC20',7),(115,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(116,'ASda ASD',3),(117,'UA123981293123',4),(118,'asdasd@gmail.com',5),(119,'USDT',6),(120,'TRC20',7),(121,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(122,'2314231423142314',2),(123,'USDT',6),(124,'TRC20',7),(125,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(126,'4141414141414141',2),(127,NULL,6),(128,NULL,7),(129,NULL,8),(130,NULL,3),(131,NULL,4),(132,NULL,5),(133,'USDT',6),(134,'TRC20',7),(135,'TRQHYxPB12V9J6jwxYWL5D1FGgDPFmVDaY',8),(136,'312313',2),(137,NULL,6),(138,NULL,7),(139,NULL,8),(140,NULL,2),(141,'USDT',6),(142,'TRC20',7),(143,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(144,'2411241124112411',2),(145,'USDT',6),(146,'TRC20',7),(147,'TWPqBE4i4F7qBtmkNTHxKuUjLLnU37Cp6B',8),(148,'asdas ASdasd',3),(149,'aASD222323',4),(150,'asdasd@gmail.com',5),(151,'BTC',6),(152,'BTC',7),(153,'bc1qh6qfx8wa7l9lgs5udu6jn4t62mzmugd0gs6ap0',8),(154,'фывфыв фывф',3),(155,'фывфы фывфыв',4),(156,'asda@gmailc.om',5);
/*!40000 ALTER TABLE `gate_way_user_input` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'zh','Chinese'),(2,'hi','Hindi'),(3,'es','Spanish'),(4,'fr','French'),(5,'ar','Arabic'),(6,'bn','Bengali'),(7,'pt','Portuguese'),(8,'id','Indonesian'),(9,'uk','Ukrainian');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manual_exchange_operation_processing`
--

DROP TABLE IF EXISTS `manual_exchange_operation_processing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manual_exchange_operation_processing` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `message_id` bigint DEFAULT NULL,
  `exchange_application_id` int NOT NULL,
  `operator_associated_id` bigint DEFAULT NULL,
  `status_id` int NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `manual_exchange_oper_exchange_application_9d8fc7f9_fk_exchange_` (`exchange_application_id`),
  KEY `manual_exchange_oper_operator_associated__095bbdc7_fk_tg_user_t` (`operator_associated_id`),
  KEY `manual_exchange_oper_status_id_5798bc44_fk_exchange_` (`status_id`),
  CONSTRAINT `manual_exchange_oper_exchange_application_9d8fc7f9_fk_exchange_` FOREIGN KEY (`exchange_application_id`) REFERENCES `exchange_operation` (`record_id`),
  CONSTRAINT `manual_exchange_oper_operator_associated__095bbdc7_fk_tg_user_t` FOREIGN KEY (`operator_associated_id`) REFERENCES `tg_user` (`tg_chat_id`),
  CONSTRAINT `manual_exchange_oper_status_id_5798bc44_fk_exchange_` FOREIGN KEY (`status_id`) REFERENCES `exchange_operation_status` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manual_exchange_operation_processing`
--

LOCK TABLES `manual_exchange_operation_processing` WRITE;
/*!40000 ALTER TABLE `manual_exchange_operation_processing` DISABLE KEYS */;
INSERT INTO `manual_exchange_operation_processing` VALUES (1,NULL,17,NULL,1),(2,NULL,18,NULL,1),(3,NULL,20,NULL,1),(4,NULL,21,NULL,1),(5,NULL,22,NULL,1),(6,NULL,23,NULL,1),(7,NULL,24,5891826489,5),(8,NULL,31,5891826489,5);
/*!40000 ALTER TABLE `manual_exchange_operation_processing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `param_translations`
--

DROP TABLE IF EXISTS `param_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `param_translations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `translated_title` varchar(15) NOT NULL,
  `translated_description` varchar(50) NOT NULL,
  `language_id` int NOT NULL,
  `param_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `param_translations_language_id_f66244b9_fk_languages_record_id` (`language_id`),
  KEY `param_translations_param_id_e47d866b_fk_gate_way_param_record_id` (`param_id`),
  CONSTRAINT `param_translations_language_id_f66244b9_fk_languages_record_id` FOREIGN KEY (`language_id`) REFERENCES `languages` (`record_id`),
  CONSTRAINT `param_translations_param_id_e47d866b_fk_gate_way_param_record_id` FOREIGN KEY (`param_id`) REFERENCES `gate_way_param` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `param_translations`
--

LOCK TABLES `param_translations` WRITE;
/*!40000 ALTER TABLE `param_translations` DISABLE KEYS */;
INSERT INTO `param_translations` VALUES (1,'Картка','Номер картки',9,2);
/*!40000 ALTER TABLE `param_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tg_bot`
--

DROP TABLE IF EXISTS `tg_bot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tg_bot` (
  `tg_id` bigint NOT NULL,
  `token` varchar(200) NOT NULL,
  `user_name` varchar(200) NOT NULL,
  `added_by_id` bigint NOT NULL,
  `deposit_gate_way_id` int DEFAULT NULL,
  `deposit_manual_chat_id` int DEFAULT NULL,
  `deposit_token_id` int DEFAULT NULL,
  `rate_cur_source_id` int DEFAULT NULL,
  `withdrawal_gate_way_id` int DEFAULT NULL,
  `withdrawal_manual_chat_id` int DEFAULT NULL,
  `withdrawal_token_id` int DEFAULT NULL,
  `deposit_gate_way_user_title` varchar(100) DEFAULT NULL,
  `withdrawal_gate_way_user_title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`tg_id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `tg_bot_added_by_id_78c08561_fk_tg_user_tg_chat_id` (`added_by_id`),
  KEY `tg_bot_deposit_gate_way_id_f789cda8_fk_gate_way_record_id` (`deposit_gate_way_id`),
  KEY `tg_bot_deposit_manual_chat__71b38c46_fk_tg_chat_m` (`deposit_manual_chat_id`),
  KEY `tg_bot_deposit_token_id_7665b94a_fk_gate_way_token_record_id` (`deposit_token_id`),
  KEY `tg_bot_rate_cur_source_id_fb59aa0e_fk_currency_price_record_id` (`rate_cur_source_id`),
  KEY `tg_bot_withdrawal_gate_way_id_5ea5998f_fk_gate_way_record_id` (`withdrawal_gate_way_id`),
  KEY `tg_bot_withdrawal_manual_ch_4f3c664f_fk_tg_chat_m` (`withdrawal_manual_chat_id`),
  KEY `tg_bot_withdrawal_token_id_be7b503d_fk_gate_way_token_record_id` (`withdrawal_token_id`),
  CONSTRAINT `tg_bot_added_by_id_78c08561_fk_tg_user_tg_chat_id` FOREIGN KEY (`added_by_id`) REFERENCES `tg_user` (`tg_chat_id`),
  CONSTRAINT `tg_bot_deposit_gate_way_id_f789cda8_fk_gate_way_record_id` FOREIGN KEY (`deposit_gate_way_id`) REFERENCES `gate_way` (`record_id`),
  CONSTRAINT `tg_bot_deposit_manual_chat__71b38c46_fk_tg_chat_m` FOREIGN KEY (`deposit_manual_chat_id`) REFERENCES `tg_chat_manual_processing` (`record_id`),
  CONSTRAINT `tg_bot_deposit_token_id_7665b94a_fk_gate_way_token_record_id` FOREIGN KEY (`deposit_token_id`) REFERENCES `gate_way_token` (`record_id`),
  CONSTRAINT `tg_bot_rate_cur_source_id_fb59aa0e_fk_currency_price_record_id` FOREIGN KEY (`rate_cur_source_id`) REFERENCES `currency_price` (`record_id`),
  CONSTRAINT `tg_bot_withdrawal_gate_way_id_5ea5998f_fk_gate_way_record_id` FOREIGN KEY (`withdrawal_gate_way_id`) REFERENCES `gate_way` (`record_id`),
  CONSTRAINT `tg_bot_withdrawal_manual_ch_4f3c664f_fk_tg_chat_m` FOREIGN KEY (`withdrawal_manual_chat_id`) REFERENCES `tg_chat_manual_processing` (`record_id`),
  CONSTRAINT `tg_bot_withdrawal_token_id_be7b503d_fk_gate_way_token_record_id` FOREIGN KEY (`withdrawal_token_id`) REFERENCES `gate_way_token` (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tg_bot`
--

LOCK TABLES `tg_bot` WRITE;
/*!40000 ALTER TABLE `tg_bot` DISABLE KEYS */;
INSERT INTO `tg_bot` VALUES (5727679143,'5727679143:AAGIQEklzn-IAlh60m3KW9KWNXNqC5hHsWA','AtomUSDTBot',6098189488,1,NULL,8,73,2,7,3,'BTCZ_BTC','BTC'),(6138427843,'6138427843:AAFGXb52-FNdE4-6gHf7ASIWVWPn10yxlgc','adasddawdasdasd_bot',5891826489,1,NULL,1,347,4,15,2,'USDT','Wise UAH'),(6213278326,'6213278326:AAFfewQezFSoNEZn0GsoU9yRToAWxsIZDS0','ldsfkjdkflaskjdflaksfas_bot',5891826489,1,NULL,8,NULL,2,NULL,3,NULL,NULL),(6220001215,'6220001215:AAEA0DyI_aOoPmtqy4jIWCz8-oBrWDKHEoI','asda3fwadsasdasd_bot',5891826489,1,NULL,1,417,3,5,2,'USDT','UAH'),(6275774162,'6275774162:AAHB_flqIvBg2GqYmLBepEZHLGEmyXqmOFo','snlsjdfksjdflskdf_bot',5891826489,1,NULL,1,347,4,4,2,'USDT','UAH Wise'),(6331743662,'6331743662:AAENT-7TfPzmC7JgcrNoxNkZInsIPdmYyrM','usdt_to_uah_fast_bot',5891826489,1,NULL,1,347,8,NULL,2,'USDT','UAH'),(6341753035,'6341753035:AAHYIQubWN2Fpj09dVq1LGN7kQKfp--B1oo','koop_lop_bop_bot',5891826489,1,NULL,1,347,4,3,2,'USDT','UAH'),(6396023794,'6396023794:AAHVpY8tcoOVDDf-Ki9YAfbsy1PInJER61Y','mother_exchange_bot',5891826489,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6483317448,'6483317448:AAH9-l_p9x5uK8mD5yiQjggiM70xNd28TZI','usdt_to_wise_uah_bot',5891826489,1,NULL,8,347,4,18,2,'USDT','UAH'),(6514603813,'6514603813:AAHwHfdToBc7_DokeiW-zjvunrsIYWbtUO4','new_test_child_2bot',5891826489,1,NULL,1,347,4,16,2,'USDT','UAH'),(6524842903,'6524842903:AAHsSQvHqVionXsDKubxc-wub1OLfdxFy5o','Blade_Gray_USDTbot',6098189488,1,NULL,1,87,2,12,2,'USD','UAH'),(6564303561,'6564303561:AAHb2zGRqVUjOZUrRfKlIGGURKJIjFykAg0','Blade_USDTBot',6098189488,1,NULL,1,121,2,10,2,'USDT','USDT'),(6594701198,'6594701198:AAHYs2DBKcDBH1j-hIv5OqbiWcAQ5PUE1yc','DoDo_USDTBot',6098189488,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6626630391,'6626630391:AAHavmUvmBsw1b9F2UmgC3AU8E9fXpR1B1o','first_btc_udst_uah_bot',5891826489,1,NULL,1,347,2,6,2,'USDT','UAH'),(6665144460,'6665144460:AAHbpSNBavlUM3Zp3aZCsXyCe0q7YJWRMy0','usdt_to_uah_auto_payment_bot',5891826489,1,NULL,1,347,8,NULL,2,'USDT','UAH');
/*!40000 ALTER TABLE `tg_bot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tg_chat`
--

DROP TABLE IF EXISTS `tg_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tg_chat` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `tg_chat_id` bigint NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `tg_chat_id` (`tg_chat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tg_chat`
--

LOCK TABLES `tg_chat` WRITE;
/*!40000 ALTER TABLE `tg_chat` DISABLE KEYS */;
INSERT INTO `tg_chat` VALUES (1,5891826489,'Karbo_Support','Karbo_Support_17'),(2,-1001979760839,'Karbo_Support & обмин USDT223',''),(4,-1001968253887,'PAYOUT CHAT TEST',''),(5,1290114095,'MV','Mathivn'),(8,6098189488,'Karbo_Support','Karbo_Support_55'),(9,-874564272,'Тест Ботов',''),(10,-1001962823779,'Тест Ботов',''),(14,5054370390,'friendly cat101','grass_oblitrator'),(15,6517430762,'Issam Issam',''),(18,6220412642,'bots .',''),(20,-1001591425483,'Karbo_Support & APPLICATION TEST BOT',''),(23,5067342097,'Afsal Afsal',''),(24,5170042071,'Nikhil Kumar Singh','NiKhiL_SiNgH_Chouhan_Cs');
/*!40000 ALTER TABLE `tg_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tg_chat_locale`
--

DROP TABLE IF EXISTS `tg_chat_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tg_chat_locale` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `locale` varchar(20) NOT NULL,
  `tg_bot_id` bigint NOT NULL,
  `tg_chat_id` int NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `tg_chat_locale_tg_chat_id_tg_bot_id_a72627e0_uniq` (`tg_chat_id`,`tg_bot_id`),
  KEY `tg_chat_locale_tg_bot_id_585564c4_fk_tg_bot_tg_id` (`tg_bot_id`),
  CONSTRAINT `tg_chat_locale_tg_bot_id_585564c4_fk_tg_bot_tg_id` FOREIGN KEY (`tg_bot_id`) REFERENCES `tg_bot` (`tg_id`),
  CONSTRAINT `tg_chat_locale_tg_chat_id_8a70c043_fk_tg_chat_record_id` FOREIGN KEY (`tg_chat_id`) REFERENCES `tg_chat` (`record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tg_chat_locale`
--

LOCK TABLES `tg_chat_locale` WRITE;
/*!40000 ALTER TABLE `tg_chat_locale` DISABLE KEYS */;
INSERT INTO `tg_chat_locale` VALUES (2,'uk',6396023794,1),(4,'en',6213278326,2),(5,'uk',6213278326,1),(13,'en',6341753035,2),(14,'en',6341753035,4),(15,'uk',6341753035,1),(16,'en',6396023794,5),(18,'en',6275774162,2),(20,'uk',6220001215,1),(21,'uk',6275774162,1),(25,'en',6626630391,2),(26,'uk',6626630391,1),(27,'uk',6396023794,8),(29,'uk',5727679143,8),(30,'en',5727679143,9),(31,'en',5727679143,10),(33,'en',6564303561,10),(35,'uk',6564303561,8),(36,'en',6396023794,14),(39,'en',6396023794,15),(40,'uk',6524842903,8),(41,'en',6524842903,10),(43,'en',6396023794,18),(45,'en',6138427843,4),(46,'uk',6138427843,1),(49,'en',6514603813,20),(51,'uk',6514603813,1),(52,'uk',6665144460,1),(53,'uk',6331743662,1),(54,'en',6483317448,2),(55,'uk',6483317448,1),(56,'en',6396023794,23),(58,'en',6396023794,24);
/*!40000 ALTER TABLE `tg_chat_locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tg_chat_manual_processing`
--

DROP TABLE IF EXISTS `tg_chat_manual_processing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tg_chat_manual_processing` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `tg_chat_id` bigint NOT NULL,
  `title` varchar(200) NOT NULL,
  `bot_associated` bigint NOT NULL,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `tg_chat_manual_processin_tg_chat_id_bot_associate_b47ea5af_uniq` (`tg_chat_id`,`bot_associated`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tg_chat_manual_processing`
--

LOCK TABLES `tg_chat_manual_processing` WRITE;
/*!40000 ALTER TABLE `tg_chat_manual_processing` DISABLE KEYS */;
INSERT INTO `tg_chat_manual_processing` VALUES (1,-1001979760839,'Karbo_Support & обмин USDT223',6213278326),(3,-1001968253887,'PAYOUT CHAT TEST',6341753035),(4,-1001979760839,'Karbo_Support & обмин USDT223',6275774162),(5,-1001979760839,'Karbo_Support & обмин USDT223',6220001215),(6,-1001979760839,'Karbo_Support & обмин USDT223',6626630391),(7,-874564272,'Тест Ботов',5727679143),(8,-1001962823779,'Тест Ботов',5727679143),(10,-1001962823779,'Тест Ботов',6564303561),(12,-1001962823779,'Тест Ботов',6524842903),(15,-1001968253887,'PAYOUT CHAT TEST',6138427843),(16,-1001591425483,'Karbo_Support & APPLICATION TEST BOT',6514603813),(18,-1001979760839,'Karbo_Support & обмин USDT223',6483317448);
/*!40000 ALTER TABLE `tg_chat_manual_processing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tg_user`
--

DROP TABLE IF EXISTS `tg_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tg_user` (
  `tg_chat_id` bigint NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `bot_control` tinyint(1) NOT NULL,
  PRIMARY KEY (`tg_chat_id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tg_user`
--

LOCK TABLES `tg_user` WRITE;
/*!40000 ALTER TABLE `tg_user` DISABLE KEYS */;
INSERT INTO `tg_user` VALUES (1290114095,'MV','Mathivn',0),(5054370390,'friendly cat101','grass_oblitrator',0),(5170042071,'Nikhil Kumar Singh','NiKhiL_SiNgH_Chouhan_Cs',0),(5891826489,'Karbo_Support','Karbo_Support_17',0),(6098189488,'Karbo_Support','Karbo_Support_55',0),(6517430762,'Issam Issam','',0);
/*!40000 ALTER TABLE `tg_user` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-03 17:54:02
