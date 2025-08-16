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
-- Table structure for table `instruction_manuals`
--

DROP TABLE IF EXISTS `instruction_manuals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instruction_manuals` (
  `manualID` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `product_code` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `keywords` text COLLATE utf8mb4_general_ci,
  `manual_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`manualID`),
  KEY `idx_product_name` (`product_name`),
  KEY `idx_product_code` (`product_code`),
  KEY `idx_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instruction_manuals`
--

LOCK TABLES `instruction_manuals` WRITE;
/*!40000 ALTER TABLE `instruction_manuals` DISABLE KEYS */;
INSERT INTO `instruction_manuals` VALUES (1,'Ergo Chair','CHA-ERGO','chair ergonomic lumbar support office','/assets/manuals/ergo_chair.pdf','2025-08-11 00:17:22'),(2,'Coffee Table','TAB-COFF','table coffee glass minimalist living room','/assets/manuals/coffee_table.pdf','2025-08-11 00:17:22'),(3,'Queen Bed Frame','BED-QFRM','bed frame queen storage drawers bedroom','/assets/manuals/queen_bed_frame.pdf','2025-08-11 00:17:22'),(4,'Bookshelf Classic','SHE-BCLS','bookshelf shelf wooden 5-tier study','/assets/manuals/bookshelf_classic.pdf','2025-08-11 00:17:22'),(5,'TV Console','STO-TVCON','tv console storage low-rise cable management','/assets/manuals/tv_console.pdf','2025-08-11 00:17:22'),(6,'Recliner Seat','SOF-RECL','recliner sofa plush adjustable headrest','/assets/manuals/recliner_seat.pdf','2025-08-11 00:17:22'),(7,'Study Desk','TAB-STUD','study desk compact drawers office table','/assets/manuals/study_desk.pdf','2025-08-11 00:17:22'),(8,'Bar Stool Set','STL-BAR','bar stool set tall counter kitchen','/assets/manuals/bar_stool_set.pdf','2025-08-11 00:17:22');
/*!40000 ALTER TABLE `instruction_manuals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-16 15:47:32
