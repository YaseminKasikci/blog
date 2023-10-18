-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (x86_64)
--
-- Host: localhost    Database: blog
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `category` varchar(45) NOT NULL,
  `author` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_article_user_idx` (`author`),
  CONSTRAINT `fk_article_user` FOREIGN KEY (`author`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,'Contrôlez votre ordinateur ...','https://cdn.futura-sciences.com/cdn-cgi/image/width=1920,quality=50,format=auto/sources/images/essai-implants-cerebraux-neuralink.jpeg','Neuralink a reçu le feu vert du comité éthique pour le recrutement de patients volontaires afin de commencer les premiers essais cliniques d&#39;implants cérébraux sur l&#39;Homme. Son interface cerveau-ordinateur sera la première à tenter de restaurer ou d&#39;améliorer les fonctions motrices déficientes. Les candidats intéressés doivent se manifester sur le registre dédié à cet effet.','technologie',4),(2,'Chutes Victoria','https://www.tourmalinesafaris.com/wp-content/uploads/2017/05/chutes-victoria-1.jpg','Les chutes Victoria sont des chutes d&#39;eau situées sur le fleuve Zambèze. Le fleuve se jette dans la cataracte sur environ 1 700 mètres de largeur et d&#39;une hauteur qui peut atteindre un maximum de 108 mètres.','nature',4),(3,'Droneline, un avion-cargo sans pilote','https://cdn.futura-sciences.com/cdn-cgi/image/width=1920,quality=50,format=auto/sources/images/avion-cargo-Droneliner.jpg','Une entreprise britannique vient de dévoiler son projet d’avion-cargo hybride qui pourrait transporter jusqu’à 350 tonnes de marchandises tout en réduisant considérablement les coûts et les émissions de CO2. Le projet repose sur un système sans pilote et des conteneurs plus légers.','technologie',4),(4,'Découvertes ','https://images.prismic.io/ndecommerce/66dd9b65-3ef0-42bd-b1be-3e4227a9ade9_Bcorp_desktop.jpg?auto=compress,format','Première entreprise de distribution à devenir B Corp™, notre certification a depuis été renouvelée deux fois, avec des référentiels de plus en plus exigeants. Ce label international atteste du travail quotidien de toutes les équipes Nature &#38; Découvertes, depuis plus de 30 ans, pour faire vivre nos engagements profonds en faveur de l&#39;environnement et l&#39;humain. Notre challenge en 2024 ? Une 4ème certification ! ','nature',5),(5,'Nicolas Sarkozy','https://cloudfront-eu-central-1.images.arcpublishing.com/lexpress/BQCBG3OXRRGPDG7HRNBBEGC7WE.jpg','“Si la vérité blesse, c&#39;est la faute de la vérité.”','politique',5),(6,' Pétra','https://voyagezchic.verychic.fr/wp-content/uploads/2022/02/Petra.png','&#13;&#10;&#13;&#10;Partir en vacances et découvrir Pétra, c’est explorer un trésor longtemps laissé à l’abandon puis, redécouvert par l’explorateur suisse Johann Ludwig Burckhardt, en 1812. Depuis ce temps, elle ne cesse d’être visitée par des voyageurs venus des quatre coins du globe.&#13;&#10;&#13;&#10;Si vous vous apprêtez à découvrir la Jordanie, Pétra est donc indispensable. Bien-sûr, n’oubliez de vous baigner dans la mer Morte, de vous prendre pour Lawrence d’Arabie dans le désert du Wadi Rum, de visiter les ruines de Jérash et les souks d’Amman. VeryChic a d’ailleurs réuni le meilleur de ce séjour dans un circuit.&#13;&#10;','nature',5),(7,'Emmanuel Macron','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlyrTvqarUBYjuoJb1JZ1gEFdNhgi5C1c08A&usqp=CAU','Il dit tout et son contraire','politique',6),(8,'François Hollande','https://www.biblond.com/wp-content/uploads/2016/07/holi.png','Apportes les croissants à son amant en scooteur.','politique',6),(9,'La nouvelle Tesla Model 3, un nouveau design.','https://cdn.futura-sciences.com/cdn-cgi/image/width=1920,quality=50,format=auto/sources/images/tesla.png','Tesla vient de dévoiler sa nouvelle Model 3. Elle évolue esthétiquement avec une ligne plus racée qui lui confère plus d’autonomie. L’habitacle évolue également notamment au niveau de son insonorisation.','technologie',6);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-18 21:08:26
