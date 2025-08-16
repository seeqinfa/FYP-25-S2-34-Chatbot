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
-- Table structure for table `furnitures`
--

DROP TABLE IF EXISTS `furnitures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `furnitures` (
  `furnitureID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `tags` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`furnitureID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `furnitures`
--

LOCK TABLES `furnitures` WRITE;
/*!40000 ALTER TABLE `furnitures` DISABLE KEYS */;
INSERT INTO `furnitures` VALUES (1,'Sofa Luxe','Sofa','sofa, leather, 3-seater, dark brown, living room','3-seater leather sofa in dark brown',899.00,5,'../../img/Sofa.jpg'),(2,'Oak Dining Set','Dining','dining set, oak, solid wood, 6-seater, table, chairs','6-seater solid oak wood dining set',1299.00,3,'../../img/table.jpg'),(3,'Ergo Chair','Chair','chair, office, ergonomic, lumbar support, swivel','Ergonomic office chair with lumbar support',199.00,12,'../../img/ergochair.jpg'),(4,'Coffee Table','Table','coffee table, glass, minimalist, living room','Minimalist glass coffee table',159.00,7,'../../img/coffeetable.jpg'),(5,'Queen Bed Frame','Bed','bed frame, queen, storage drawers, bedroom','Queen size bed frame with storage drawers',699.00,4,'../../img/queenbedframe.jpg'),(6,'Bookshelf Classic','Shelf','bookshelf, 5-tier, wooden, shelf, storage','5-tier wooden bookshelf',249.00,9,'../../img/bookshelf.jpg'),(7,'TV Console','Storage','tv console, low-rise, cable management, living room, storage','Low-rise TV console with cable management',399.00,6,'../../img/tvconsole.jpg'),(8,'Recliner Seat','Sofa','recliner, sofa, adjustable headrest, lounge, comfortable','Plush recliner with adjustable headrest',499.00,2,'../../img/reclinerseat.jpg'),(9,'Study Desk','Table','study desk, compact, drawers, office, work','Compact study desk with side drawers',299.00,10,'../../img/studydesk.jpg'),(10,'Bar Stool Set','Chair','bar stool, set of 2, footrest, kitchen, counter','Set of 2 bar stools with footrest',179.00,8,'../../img/barstool.jpg'),(11,'Bed','Bedroom',NULL,'bed',1299.90,5,'../../img/bed.jpg');
/*!40000 ALTER TABLE `furnitures` ENABLE KEYS */;
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
