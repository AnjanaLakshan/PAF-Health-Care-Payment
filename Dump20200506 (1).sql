-- MySQL dump 10.13  Distrib 8.0.19, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: payment
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `appointment_details`
--

DROP TABLE IF EXISTS `appointment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_date` date NOT NULL,
  `start_time` varchar(5) NOT NULL,
  `end_time` varchar(5) NOT NULL,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `department_id` int NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment_details`
--

LOCK TABLES `appointment_details` WRITE;
/*!40000 ALTER TABLE `appointment_details` DISABLE KEYS */;
INSERT INTO `appointment_details` VALUES (2,'2020-04-02','10.30','12.00',1,1,1,'not paid'),(3,'2020-04-02','10.00','12.00',1,1,1,'not paid'),(4,'2020-04-22','10.00','14.00',3,2,1,'paid'),(5,'2020-04-02','10.30','12.00',1,1,1,'paid'),(7,'2020-05-16','10:00','11:01',4,4,4,'paid');
/*!40000 ALTER TABLE `appointment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_details`
--

DROP TABLE IF EXISTS `payment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `appointmentId` int DEFAULT NULL,
  `paypalId` varchar(45) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_details`
--

LOCK TABLES `payment_details` WRITE;
/*!40000 ALTER TABLE `payment_details` DISABLE KEYS */;
INSERT INTO `payment_details` VALUES (2,1,'64Y08599ST0347901',10000,'2020-05-16 00:00:00','paypal'),(3,3,'8U193934AN742850G',5000,'2020-05-06 00:00:00','paypal'),(4,7,'8XH6095085388424E',5000,'2020-05-06 00:00:00','paypal'),(5,2,'80H95181AV130942V',5000,'2020-05-06 00:00:00','paypal'),(6,2,'1EV67506NS413841T',5000,'2020-05-06 00:00:00','paypal'),(7,2,'',6000,'2020-05-06 00:00:00','Insurance'),(8,7,'',9000,'2020-05-06 00:00:00','Insurance'),(12,2,'',90000,'2020-05-06 00:00:00','Insurance'),(13,2,'1D612112V4785160V',7000,'2020-05-06 00:00:00','paypal'),(15,4,'',0,'2020-05-06 00:00:00','Insurance'),(16,4,'',9000,'2020-05-06 00:00:00','Insurance');
/*!40000 ALTER TABLE `payment_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-06 22:48:31
