-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: shortline.proxy.rlwy.net    Database: railway
-- ------------------------------------------------------
-- Server version	9.4.0

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

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `customer_first_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `customer_last_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `customer_email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `customer_phone` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `shipping_address` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `shipping_city` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `shipping_state` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `shipping_zip` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `tax_amount` decimal(10,2) NOT NULL,
  `shipping_fee` decimal(10,2) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `order_status` enum('pending','processing','shipped','delivered','cancelled') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `special_instructions` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
  KEY `idx_orders_username` (`username`),
  CONSTRAINT `fk_orders_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'user','John','Doe','john@example.com','00000000','123 Street','Tampines','SG','522256',1299.00,0.00,0.00,1299.00,'pending',NULL,'2025-08-11 22:38:05','2025-08-11 22:38:05'),(2,'user','John','Doe','john@example.com','00000000','123 Street','Tampines','SG','522256',159.00,0.00,0.00,159.00,'pending',NULL,'2025-08-11 22:38:05','2025-08-11 22:38:05'),(3,'user','John','Doe','john@example.com','00000000','123 Street','Tampines','SG','522256',199.00,0.00,0.00,199.00,'pending',NULL,'2025-08-11 22:38:05','2025-08-11 22:38:05'),(4,'user','John','Doe','john@example.com','00000000','123 Street','Tampines','SG','522256',1458.00,0.00,0.00,1458.00,'pending',NULL,'2025-08-11 22:38:05','2025-08-11 22:38:05'),(5,'user','Yang','Guang','bladekoi99@gmail.com','91266236','Pasir Ris Drive 3 Block 633','singapore','AK','510632',179.00,14.32,15.00,208.32,'pending','please be fast','2025-08-16 07:07:23','2025-08-16 07:07:23');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-16 15:47:30
