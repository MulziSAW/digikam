-- MySQL dump 10.13  Distrib 5.1.56, for pc-linux-gnu (x86_64)
--
-- Host: localhost    Database: digikam
-- ------------------------------------------------------
-- Server version	5.1.56-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `albumroots`
--

DROP TABLE IF EXISTS `albumroots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albumroots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` longtext,
  `status` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `identifier` longtext,
  `specificPath` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`(167),`specificPath`(166))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albumroots`
--

LOCK TABLES `albumroots` WRITE;
/*!40000 ALTER TABLE `albumroots` DISABLE KEYS */;
INSERT INTO `albumroots` VALUES (1,NULL,0,1,'volumeid:?uuid=800b21c2-dadc-4930-829e-a96b04ce26fa','/vivo/digikam-devel/data/testimages/a1'),(3,'a2',0,1,'volumeid:?uuid=800b21c2-dadc-4930-829e-a96b04ce26fa','/vivo/digikam-devel/data/testimages/a2');
/*!40000 ALTER TABLE `albumroots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `albumRoot` int(11) NOT NULL,
  `relativePath` longtext NOT NULL,
  `date` date DEFAULT NULL,
  `caption` longtext,
  `collection` longtext,
  `icon` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `albumRoot` (`albumRoot`,`relativePath`(332))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albums`
--

LOCK TABLES `albums` WRITE;
/*!40000 ALTER TABLE `albums` DISABLE KEYS */;
INSERT INTO `albums` VALUES (1,1,'/','2011-06-28',NULL,NULL,NULL),(2,1,'/jpg','2011-06-28',NULL,NULL,NULL),(3,1,'/png','2011-06-28',NULL,NULL,NULL),(4,2,'/','2011-06-28',NULL,NULL,NULL),(5,2,'/pgf','2011-06-28',NULL,NULL,NULL),(6,2,'/pgf/link','2011-06-28',NULL,NULL,NULL),(7,3,'/','2011-06-28',NULL,NULL,NULL),(8,3,'/pgf','2011-06-28',NULL,NULL,NULL),(9,3,'/pgf/link','2011-06-28',NULL,NULL,NULL);
/*!40000 ALTER TABLE `albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `downloadhistory`
--

DROP TABLE IF EXISTS `downloadhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloadhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext,
  `filename` longtext,
  `filesize` int(11) DEFAULT NULL,
  `filedate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`(164),`filename`(165),`filesize`,`filedate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downloadhistory`
--

LOCK TABLES `downloadhistory` WRITE;
/*!40000 ALTER TABLE `downloadhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `downloadhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagecomments`
--

DROP TABLE IF EXISTS `imagecomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagecomments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imageid` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `language` varchar(128) DEFAULT NULL,
  `author` longtext,
  `date` datetime DEFAULT NULL,
  `comment` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imageid` (`imageid`,`type`,`language`,`author`(202))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagecomments`
--

LOCK TABLES `imagecomments` WRITE;
/*!40000 ALTER TABLE `imagecomments` DISABLE KEYS */;
INSERT INTO `imagecomments` VALUES (1,1,1,'x-default',NULL,NULL,'This file is a part of digiKam project\nhttp://www.digikam.org\nCopyright (C) 2011 by Francesco Riosa <francesco+kde at pnpitalia it>'),(2,2,1,'x-default',NULL,NULL,'This file is a part of digiKam project\nhttp://www.digikam.org\nCopyright (C) 2011 by Francesco Riosa <francesco+kde at pnpitalia it>'),(3,4,1,'x-default',NULL,NULL,'Test Caption');
/*!40000 ALTER TABLE `imagecomments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagecopyright`
--

DROP TABLE IF EXISTS `imagecopyright`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagecopyright` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imageid` int(11) DEFAULT NULL,
  `property` longtext,
  `value` longtext,
  `extraValue` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imageid` (`imageid`,`property`(110),`value`(111),`extraValue`(111))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagecopyright`
--

LOCK TABLES `imagecopyright` WRITE;
/*!40000 ALTER TABLE `imagecopyright` DISABLE KEYS */;
INSERT INTO `imagecopyright` VALUES (1,4,'creator','DigiKam Developers',NULL),(2,4,'provider','Opensource world',NULL),(3,4,'copyrightNotice','Same as DigiKam','x-default'),(4,4,'source','Snapshot',NULL),(5,4,'creatorJobTitle','developers',NULL),(6,4,'instructions','',NULL),(7,4,'creatorContactInfo.city',NULL,NULL),(8,4,'creatorContactInfo.country',NULL,NULL),(9,4,'creatorContactInfo.address',NULL,NULL),(10,4,'creatorContactInfo.postalCode',NULL,NULL),(11,4,'creatorContactInfo.provinceState',NULL,NULL),(12,4,'creatorContactInfo.email',NULL,NULL),(13,4,'creatorContactInfo.phone',NULL,NULL),(14,4,'creatorContactInfo.webUrl',NULL,NULL);
/*!40000 ALTER TABLE `imagecopyright` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagehaarmatrix`
--

DROP TABLE IF EXISTS `imagehaarmatrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagehaarmatrix` (
  `imageid` int(11) NOT NULL,
  `modificationDate` datetime DEFAULT NULL,
  `uniqueHash` longtext,
  `matrix` longblob,
  PRIMARY KEY (`imageid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagehaarmatrix`
--

LOCK TABLES `imagehaarmatrix` WRITE;
/*!40000 ALTER TABLE `imagehaarmatrix` DISABLE KEYS */;
INSERT INTO `imagehaarmatrix` VALUES (1,'2011-06-28 02:13:14','64ba82087739998c8ca2b6fe795a27ef','\0\0\0?вф5х\0ПЩCІЯeПГ&Tt*rџџџ\0\0\0$џџџлџџџї\0\0џџўќџџњ}џџљ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџљџџџ~\0\0ЛџџџШџџџyџџџѕ\0\0\0\0\n\0\0џџџ§џџўѓџџџў\0\0\0\0\0\0џџџфџџџљџџњ\0\0\0\rџџ§|џџњўџџќ\0\0џџ§~џџўџџџ\0\0\0\0\0џџћ\0\0џџ§ю\0\0	\0\0\0\0\0џџіP\0\0џџћPџџџЂ\0\0\0\0\0\0нџџ§8џџњбџџћ#џџї\0џџўњџџ§м\0\0	џџўє\0\0\0\0\0HџџіR\0\0\0\0\0џџџ\0\0џџіџ\0\0Џџџіuџџџѕ\0\0\0	џџџџџџў\0џџ§џџџџ\0џџџџџўю\0\0	џџћљџџ§јџџї\0\0\0\0џџџј\0\0џџўщ\0\0\n\0\0H\0\0\0%\0\0\0	џџ§мџџўэџџњўџџўѕџџџuџџўЗ\0\0%џџћќ\0\0џџћџџ§~\0\0\0џџіџ\0\0џџџќ\0\0џџ§ќџџџѕ\0\0џџћџџџџџџ§џџџўџџџџџџџўџџў\0џџџ\0'),(2,'2011-06-28 02:13:14','faff1ab097816445d6c99618634c1054','\0\0\0?вГ/rњ},Мr@СaшСEМdђщ:Rл\0\0\0\0\0$џџџл\0\0џџџїџџўќџџњ}џџљ\0\0\0\0\0\0\0\0\0џџџ~џџљ\0\0\0\0\0\0џџџѕ\0\0ЛџџџШ\0\0џџџy\0\0\0\0\nџџџў\0\0џџўѓџџџ§\0\0\0\0\0\0џџџфџџџљџџњ\0\0\0\rџџ§|џџњўџџќџџ§~\0\0џџўџџџ\0џџџeџџўуџџЯ\0\0\0џџђu\0\0\0\0\0	\0\0-|џџѕEџџџќџџыЋ\0\0џџєљџџ§џџџњ\0\0\0\r\0\0\0\0\0\08џџѕџџџўєџџє\0\0\0\0џџњѕџџчџџџх\0\0\nё\0\0џџ§y\0\0\0\0\0\0\0\0\0џџџњџџџѓ\0\0\0\0\0\0џџўџ\0\0\0\0\0\0\0џџєёџџњ\0\0-џџ§џ\0\0w\0\0ў\0\0(Ћ\0\0џџџe\0\0џџ§y\0\0\0\0\0Џ\0\0,\0\0)ё\0\0\0\0\0\0\0\0џџла\0\0([\0\0-уџџџњ\0\0џџвq\0\0\0\0\0rџџњѕ\0\0\nё\0\0\0\0\0\0\n\0\0\rџџџѓџџ§E\0\0\0\0\0\nђ\0\0*ђџџўџ\0\0\0\0\0'),(3,'2011-06-28 02:13:14','b7f6e38ad04f1a8b4307cee7d4d144f2','\0\0\0?ыыї?IП]Nљ5ПHщъg$џџџћ\0\0\0\0\0\0\0\0\0\0џџў~\0\0\0џџн\0џџјx\0\0\0џџј\0\0\0\0\0\0\0џџђџџџж\0\0\0~џџђ~џџђ\0\0\0\0\0џџќџџџпџџџН\0\0\0џџ№\0\0\0 џџўџџџўџџр\0\0\0@\0\0џџџ\0џџџџџџїџџџќ\0\0\0\0џџў\0џџџјџџџў\0\0џџя{џџћў\0\0\0\0\0џџф~\0\0\0\0џџњџџ§]\0\0\0џџїћџџџрџџџьџџўя\0\0\0\0џџяњџџўћ\0\0\0\0\0\0\0?џџ§ћ\0\0џџџџ\0\0џџћћџџџџџџ\0џџр\0\0 \0џџп\0\0\0\0\0џџя\0\0\0џџў\0џџј\0џџќ\0џџћПџџљѕ\0\0\0\0\0\0\0\0\0\0џџџ§џџўћ\0\0\0џџўг\0\0џџњ§џџџє\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџќџџџыџџџњџџў\0\0\0џџџ}\0\0\0\0\0\0\0џџўъ\0\0\0џџ№\0\0\0\0-џџўѕ\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(4,'2011-06-28 15:43:41','570d684473df126f54b8436a444b3ba1','\0\0\0?ъYaКяЁ?t6]зхџПkFL\'іџ}џџњџџўў\0\0џџЬџџѓ\0\0џџы\0џџљџ\0\0џџђxџџф{џџєћ\0\0\0џџџџџџџ}\0\0\0\0\0џџц\0\03џџњ}\0\0\0\0\rџџфџџфџџШќ\0\0џџЬy\0\0џџџџџнџџя\0\0\0\0џџї\0\0>\0\0\0\0\0\0џџџ\0џџќ\0џџў\0\0\0\0\0\0џџ§}џџд}џџњ{џџыzџџъjџџщџ\0\0\nџџњ§\0\0џџъ~\0\0\0\0+\0\0\0\0\0џџћ\0\0\0\0\0\0џџњџџѕ}\0\0\0\0\0џџг\0џџв§\0\0\0\0џџє§\0\0-\0\0\0\0\nџџѕ\0\0-џџъ{џџѕ\0џџџ\0џџў§\0\0\0\0\0\0\0\0\0\0џџы{џџњ§џџъjџџщџџџъ§џџъ~\0\0\0\0\0\0\0+\0\0\0\0џџ§џџћ\0\0\0\nџџњџџў§џџг\0џџв§\0\0\0\0џџє§\0\0\nџџџ\0\0\0\0\0-\0\0-џџѕ\0\0\0џџ§}џџѕzџџъ{џџъњ\0\0\0\0\nџџѕ}џџѕ\0\0\0\0'),(5,'2011-06-28 02:13:14','73ded88d97601deb2d42dedac59a4786','\0\0\0?uюЃО-ХП8<П3јЁ[ОЙRкКMЊџџўu\0\0БџџшЯ\0\0Ў\0\0\0\0\01\0\0\0\0\0\0џџњOџџџћ\0\0\0џџчuџџшє\0\0\0\0\0\0џџ§zџџњ}џџўєџџ§\0\0\0\0\0\0џџљћџџќѕ\0\0\0\0\0\0\0џџџѕ\0\0\0џџњzџџ§tџџњ\0\0\0\0џџљѕ\0\0џџњt\0\0\0\0\0џџчшџџњ{џџ§uџџњ\0џџѓ§џџўhџџљњџџќєџџшP\0\0\0\0\0\0\0\0\0\0Џ\0\0\0\0\0\0џџџшџџє{\0\0\0\0\0џџ§iџџє\0џџњuџџѓњџџќшџџљє\0\0\0\0\0\0\0\0џџєuџџњiџџѓєџџљш\0\0\0\0џџєiџџѓш\0\0/н\0\0\0\0Џ\0\00џџЯаџџаiџџє!\0\0^џџш\"џџш џџа\0\00`џџаO\0\0\0\00a\0\0/тџџњ!\0\0рџџњi\0\0\0\01^џџаQџџєi\0\0о\0\0/`џџєP\0\0b\0\0\0\0^џџЯЃ\0\0\0\0/0\0\0/^џџЯџџЮџџб!џџаP\0\0тџџчЁџџш#'),(6,'2011-06-28 02:13:14','6e6426a193df285022b616a563ce4ad6','\0\0\0?ШЊ0§2ХЯПl.жo§?Ouвeѕџџ§sџџћyџџќђ\0\0\0\0\0\0\0џџўњџџ§}\0\0џџќ\0\0\0џџџќ\0\0\0џџџђџџљ\0џџ§љџџџћ\0\0\0\0џџќzџџќљ\0\0џџј~\0\0\0\0џџј§џџўrџџўё\0\0\0\0џџџ\0\0\0џџў\0\0\0џџџў\0\0\0\0\0џџџџџџў}\0\0\0\0\0\0\0\0џџўwџџќќџџћ{џџћњџџјћ\0\0\0\0џџјz\0\0џџ§ћ\0\0\0\0џџќ{\0\0\0\0\0џџј}\0\0џџћ§\0\0џџџ|џџћ~\0\0\0\0\0\0\0\0џџџ~\0\0џџў\0џџјў\0\0џџќџџќ\0џџјџџўў\0\0\0\0\0\0\0џџў~\0\0\0\0\0џџј\0\0\0\0џџ§yџџў§џџќy\0\0\0	џџўx\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџўђџџ§ћџџћ~\0\0\0\0џџўq\0\0џџ§џџџ§|\0\0џџўџ\0\0џџџјџџўїџџџё\0\0џџџќџџџљ\0\0\0\0\0\0џџўў\0\0\0\0\0\0\0\0'),(8,'2011-06-28 17:42:36','6c335b8c4891b709969aaa5ec36ef097','\0\0\0?ЦзРуи-м?aЈ)П_(ПYжтAоіџџ§ћ\0\0\0	\0\0\0\0\0\0\0\0\0\0\0џџќ|\0\0\0\0\0џџќz\0\0џџј{џџџ}\0\0\0џџўx\0\0\0\0\0\0\0\0\0\0џџџџџљ\0џџ§|\0\0џџўўџџў\0\0\0џџј§\0\0\0\0\0џџўїџџј~џџў}џџџј\0\0\0\0џџџќџџџ\0\0\0\0\0џџћў\0\0џџџ}џџўё\0\0џџў\0\0\0\0\0\0\0џџџњџџџћџџ§ќџџџђ\0\0\0\0\0џџџ\0\0\0џџўј\0\0џџќzџџў\0\0\0\0џџј§џџќ\0\0\0\0\0\0\0џџќљ\0\0	\0\0\0\0\0\0џџџў\0\0\0џџўrџџџ§\0\0џџў}џџџџџџџ\0\0\0џџџ~џџќ\0\0	џџў\0џџџћџџўјџџћ§џџ§љ\0\0џџџњ\0\0џџџїџџјџџќ\0џџўёџџў\0\0џџќ{\0\0\0\0\0\0\0џџќ\0\0\0\0\0џџјў\0\0\0\0џџџ§џџќќ\0\0\0\0\0\0\0\0\0\0\0џџўwџџџў\0\0џџў~\0\0\0џџџџ'),(9,'2011-06-28 02:13:14','d77bfd4de3e8e4b2880a30cb03c824e6','\0\0\0?с/#I`Мѓ\nкmћ>МsZЮ^\0\0\0\0џџ§}џџўш\0\0\0\0\0\0џџ§\0џџёџџџg\0\0џџџњ\0\0џџќ|\0\0џџјr\0\0\0\0џџџwџџџzџџќ§\0\0џџљ\0џџќѓ\0\0	џџњzџџќr\0\0\0џџџћџџџё\0\0џџўwџџџ\0\0џџќџџџў~џџџљ\0\0џџџ~џџџ§џџџџџџё}\0\0\0\0\0џџтaџџссџџф2\0\0;К\0\0§џџў\0\0џџўv\0\0џџФy\0\0;єџџј\0\0\0\0\0\0\0\0\0\0\0\0\0wџџќmџџФЯџџјy\0\0\0\0\0џџўч\0\0\0\0\0\0\0џџј§\0\0\0џџФџџј\0\0\0\0\0џџќќ\0\0\0\0\0\0\0\0\0\0\0џџљt\0\0\0\0\0\0\0џџќb\0\0\0џџјџџ§џ\0\0\0\0џџмЪ\0\0\0\0Ь\0\0\0\0Ј\0\0	z\0\0\0џџњB\0\02\0\0wџџџ\0џџјq\0\0\0џџ§ўџџУ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџќќ\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(10,'2011-06-28 02:13:14','891ade31c9d71cae9eefb599b467561e','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќ'),(11,'2011-06-28 02:13:14','891ade31c9d71cae9eefb599b467561e','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќ'),(12,'2011-06-28 02:13:14','891ade31c9d71cae9eefb599b467561e','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќ'),(13,'2011-06-28 02:13:14','73ded88d97601deb2d42dedac59a4786','\0\0\0?uюЃО-ХП8<П3јЁ[ОЙRкКMЊџџўu\0\0БџџшЯ\0\0Ў\0\0\0\0\01\0\0\0\0\0\0џџњOџџџћ\0\0\0џџчuџџшє\0\0\0\0\0\0џџ§zџџњ}џџўєџџ§\0\0\0\0\0\0џџљћџџќѕ\0\0\0\0\0\0\0џџџѕ\0\0\0џџњzџџ§tџџњ\0\0\0\0џџљѕ\0\0џџњt\0\0\0\0\0џџчшџџњ{џџ§uџџњ\0џџѓ§џџўhџџљњџџќєџџшP\0\0\0\0\0\0\0\0\0\0Џ\0\0\0\0\0\0џџџшџџє{\0\0\0\0\0џџ§iџџє\0џџњuџџѓњџџќшџџљє\0\0\0\0\0\0\0\0џџєuџџњiџџѓєџџљш\0\0\0\0џџєiџџѓш\0\0/н\0\0\0\0Џ\0\00џџЯаџџаiџџє!\0\0^џџш\"џџш џџа\0\00`џџаO\0\0\0\00a\0\0/тџџњ!\0\0рџџњi\0\0\0\01^џџаQџџєi\0\0о\0\0/`џџєP\0\0b\0\0\0\0^џџЯЃ\0\0\0\0/0\0\0/^џџЯџџЮџџб!џџаP\0\0тџџчЁџџш#'),(14,'2011-06-28 02:13:14','6e6426a193df285022b616a563ce4ad6','\0\0\0?ШЊ0§2ХЯПl.жo§?Ouвeѕџџ§sџџћyџџќђ\0\0\0\0\0\0\0џџўњџџ§}\0\0џџќ\0\0\0џџџќ\0\0\0џџџђџџљ\0џџ§љџџџћ\0\0\0\0џџќzџџќљ\0\0џџј~\0\0\0\0џџј§џџўrџџўё\0\0\0\0џџџ\0\0\0џџў\0\0\0џџџў\0\0\0\0\0џџџџџџў}\0\0\0\0\0\0\0\0џџўwџџќќџџћ{џџћњџџјћ\0\0\0\0џџјz\0\0џџ§ћ\0\0\0\0џџќ{\0\0\0\0\0џџј}\0\0џџћ§\0\0џџџ|џџћ~\0\0\0\0\0\0\0\0џџџ~\0\0џџў\0џџјў\0\0џџќџџќ\0џџјџџўў\0\0\0\0\0\0\0џџў~\0\0\0\0\0џџј\0\0\0\0џџ§yџџў§џџќy\0\0\0	џџўx\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџўђџџ§ћџџћ~\0\0\0\0џџўq\0\0џџ§џџџ§|\0\0џџўџ\0\0џџџјџџўїџџџё\0\0џџџќџџџљ\0\0\0\0\0\0џџўў\0\0\0\0\0\0\0\0'),(15,'2011-06-28 17:42:36','6c335b8c4891b709969aaa5ec36ef097','\0\0\0?ЦзРуи-м?aЈ)П_(ПYжтAоіџџ§ћ\0\0\0	\0\0\0\0\0\0\0\0\0\0\0џџќ|\0\0\0\0\0џџќz\0\0џџј{џџџ}\0\0\0џџўx\0\0\0\0\0\0\0\0\0\0џџџџџљ\0џџ§|\0\0џџўўџџў\0\0\0џџј§\0\0\0\0\0џџўїџџј~џџў}џџџј\0\0\0\0џџџќџџџ\0\0\0\0\0џџћў\0\0џџџ}џџўё\0\0џџў\0\0\0\0\0\0\0џџџњџџџћџџ§ќџџџђ\0\0\0\0\0џџџ\0\0\0џџўј\0\0џџќzџџў\0\0\0\0џџј§џџќ\0\0\0\0\0\0\0џџќљ\0\0	\0\0\0\0\0\0џџџў\0\0\0џџўrџџџ§\0\0џџў}џџџџџџџ\0\0\0џџџ~џџќ\0\0	џџў\0џџџћџџўјџџћ§џџ§љ\0\0џџџњ\0\0џџџїџџјџџќ\0џџўёџџў\0\0џџќ{\0\0\0\0\0\0\0џџќ\0\0\0\0\0џџјў\0\0\0\0џџџ§џџќќ\0\0\0\0\0\0\0\0\0\0\0џџўwџџџў\0\0џџў~\0\0\0џџџџ'),(16,'2011-06-28 02:13:14','d77bfd4de3e8e4b2880a30cb03c824e6','\0\0\0?с/#I`Мѓ\nкmћ>МsZЮ^\0\0\0\0џџ§}џџўш\0\0\0\0\0\0џџ§\0џџёџџџg\0\0џџџњ\0\0џџќ|\0\0џџјr\0\0\0\0џџџwџџџzџџќ§\0\0џџљ\0џџќѓ\0\0	џџњzџџќr\0\0\0џџџћџџџё\0\0џџўwџџџ\0\0џџќџџџў~џџџљ\0\0џџџ~џџџ§џџџџџџё}\0\0\0\0\0џџтaџџссџџф2\0\0;К\0\0§џџў\0\0џџўv\0\0џџФy\0\0;єџџј\0\0\0\0\0\0\0\0\0\0\0\0\0wџџќmџџФЯџџјy\0\0\0\0\0џџўч\0\0\0\0\0\0\0џџј§\0\0\0џџФџџј\0\0\0\0\0џџќќ\0\0\0\0\0\0\0\0\0\0\0џџљt\0\0\0\0\0\0\0џџќb\0\0\0џџјџџ§џ\0\0\0\0џџмЪ\0\0\0\0Ь\0\0\0\0Ј\0\0	z\0\0\0џџњB\0\02\0\0wџџџ\0џџјq\0\0\0џџ§ўџџУ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџќќ\0\0\0\0\0\0\0\0\0\0\0\0\0\0'),(17,'2011-06-28 02:13:14','891ade31c9d71cae9eefb599b467561e','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќ'),(18,'2011-06-28 02:13:14','891ade31c9d71cae9eefb599b467561e','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќ'),(19,'2011-06-28 02:13:14','891ade31c9d71cae9eefb599b467561e','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0џџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќџџџџџџџ§џџџљџџџёџџџсџџџиџџџйџџџкџџџлџџџмџџџнџџџоџџџпџџџтџџџрџџџуџџџфџџџхџџџцџџџчџџџшџџџщџџџъџџџыџџџьџџџэџџџюџџџяџџџђџџџ№џџџѓџџџєџџџѕџџџіџџџїџџџњџџџјџџџћџџџўџџџќ');
/*!40000 ALTER TABLE `imagehaarmatrix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imageinformation`
--

DROP TABLE IF EXISTS `imageinformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imageinformation` (
  `imageid` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `creationDate` datetime DEFAULT NULL,
  `digitizationDate` datetime DEFAULT NULL,
  `orientation` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `format` longtext,
  `colorDepth` int(11) DEFAULT NULL,
  `colorModel` int(11) DEFAULT NULL,
  PRIMARY KEY (`imageid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imageinformation`
--

LOCK TABLES `imageinformation` WRITE;
/*!40000 ALTER TABLE `imageinformation` DISABLE KEYS */;
INSERT INTO `imageinformation` VALUES (1,-1,'2011-06-05 16:28:34','2011-06-05 16:28:34',1,720,479,'JPG',8,5),(2,-1,'2011-06-05 16:28:34','2011-06-05 16:28:34',1,720,479,'JPG',8,2),(3,-1,'2011-06-28 02:13:14',NULL,0,1538,852,'PNG',8,1),(4,-1,'2011-06-27 15:31:50','2011-06-27 15:31:50',0,802,1916,'PNG',8,4),(5,-1,'2011-06-28 02:13:14',NULL,0,2560,2560,'PNG',8,1),(6,-1,'2006-03-11 15:42:12','2006-03-11 15:42:12',1,400,400,'JPG',8,5),(7,-1,'2006-03-11 15:42:12','2006-03-11 15:42:12',1,400,400,'JPG',8,5),(8,-1,'2011-06-28 17:42:36',NULL,0,798,798,'JPG',8,5),(9,-1,'2011-06-18 16:40:36','2011-06-18 16:40:36',0,640,472,'JPG',8,2),(10,-1,'2011-06-05 16:28:34','2011-06-05 16:28:34',1,538,358,'PGF',24,1),(11,-1,'2011-06-05 16:28:34','2011-06-05 16:28:34',1,538,358,'PGF',24,1),(12,-1,'2011-06-05 16:28:34','2011-06-05 16:28:34',1,538,358,'PGF',24,1),(13,-1,'2011-06-28 02:13:14',NULL,0,2560,2560,'PNG',8,1),(14,-1,'2006-03-11 15:42:12','2006-03-11 15:42:12',1,400,400,'JPG',8,5),(15,-1,'2011-06-28 17:42:36',NULL,0,798,798,'JPG',8,5),(16,-1,'2011-06-18 16:40:36','2011-06-18 16:40:36',0,640,472,'JPG',8,2),(17,-1,'2011-06-05 16:28:34','2011-06-05 16:28:34',1,538,358,'PGF',24,1),(18,-1,'2011-06-05 16:28:34','2011-06-05 16:28:34',1,538,358,'PGF',24,1),(19,-1,'2011-06-05 16:28:34','2011-06-05 16:28:34',1,538,358,'PGF',24,1);
/*!40000 ALTER TABLE `imageinformation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagemetadata`
--

DROP TABLE IF EXISTS `imagemetadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagemetadata` (
  `imageid` int(11) NOT NULL,
  `make` longtext,
  `model` longtext,
  `lens` longtext,
  `aperture` double DEFAULT NULL,
  `focalLength` double DEFAULT NULL,
  `focalLength35` double DEFAULT NULL,
  `exposureTime` double DEFAULT NULL,
  `exposureProgram` int(11) DEFAULT NULL,
  `exposureMode` int(11) DEFAULT NULL,
  `sensitivity` int(11) DEFAULT NULL,
  `flash` int(11) DEFAULT NULL,
  `whiteBalance` int(11) DEFAULT NULL,
  `whiteBalanceColorTemperature` int(11) DEFAULT NULL,
  `meteringMode` int(11) DEFAULT NULL,
  `subjectDistance` double DEFAULT NULL,
  `subjectDistanceCategory` int(11) DEFAULT NULL,
  PRIMARY KEY (`imageid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagemetadata`
--

LOCK TABLES `imagemetadata` WRITE;
/*!40000 ALTER TABLE `imagemetadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `imagemetadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imagepositions`
--

DROP TABLE IF EXISTS `imagepositions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagepositions` (
  `imageid` int(11) NOT NULL,
  `latitude` longtext,
  `latitudeNumber` double DEFAULT NULL,
  `longitude` longtext,
  `longitudeNumber` double DEFAULT NULL,
  `altitude` double DEFAULT NULL,
  `orientation` double DEFAULT NULL,
  `tilt` double DEFAULT NULL,
  `roll` double DEFAULT NULL,
  `accuracy` double DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`imageid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagepositions`
--

LOCK TABLES `imagepositions` WRITE;
/*!40000 ALTER TABLE `imagepositions` DISABLE KEYS */;
INSERT INTO `imagepositions` VALUES (1,'0,0.00000000N',0,'90,0.00000000E',90,200,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `imagepositions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imageproperties`
--

DROP TABLE IF EXISTS `imageproperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imageproperties` (
  `imageid` int(11) NOT NULL,
  `property` longtext NOT NULL,
  `value` longtext NOT NULL,
  UNIQUE KEY `imageid` (`imageid`,`property`(332))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imageproperties`
--

LOCK TABLES `imageproperties` WRITE;
/*!40000 ALTER TABLE `imageproperties` DISABLE KEYS */;
INSERT INTO `imageproperties` VALUES (1,'country','Forever Iced'),(1,'city','Santa Claus'),(1,'location','North Pole'),(1,'provinceState','Icecream'),(4,'country',''),(4,'countryCode',''),(4,'city','Nowhere'),(4,'location',''),(4,'provinceState','Unknown');
/*!40000 ALTER TABLE `imageproperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `album` int(11) DEFAULT NULL,
  `name` longtext NOT NULL,
  `status` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `modificationDate` datetime DEFAULT NULL,
  `fileSize` int(11) DEFAULT NULL,
  `uniqueHash` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `album` (`album`,`name`(332)),
  KEY `dir_index` (`album`),
  KEY `hash_index` (`uniqueHash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,2,'foto001.jpg',1,1,'2011-06-28 02:13:14',145538,'64ba82087739998c8ca2b6fe795a27ef'),(2,2,'foto001bw.jpg',1,1,'2011-06-28 02:13:14',105505,'faff1ab097816445d6c99618634c1054'),(3,3,'snap001.png',1,1,'2011-06-28 02:13:14',173933,'b7f6e38ad04f1a8b4307cee7d4d144f2'),(4,3,'snap002.png',1,1,'2011-06-28 15:43:41',71591,'570d684473df126f54b8436a444b3ba1'),(5,4,'big-image.png',1,1,'2011-06-28 02:13:14',114493,'73ded88d97601deb2d42dedac59a4786'),(6,4,'icc-test-farbkreis.jpg',1,1,'2011-06-28 02:13:14',75675,'6e6426a193df285022b616a563ce4ad6'),(8,4,'icc-test-no-profile.jpg',1,1,'2011-06-28 17:42:36',50331,'6c335b8c4891b709969aaa5ec36ef097'),(9,4,'Martian_face_viking.jpg',1,1,'2011-06-28 02:13:14',99416,'d77bfd4de3e8e4b2880a30cb03c824e6'),(10,5,'foto001q5.pgf',1,1,'2011-06-28 02:13:14',89012,'891ade31c9d71cae9eefb599b467561e'),(11,6,'foto001q5.pgf',1,1,'2011-06-28 02:13:14',89012,'891ade31c9d71cae9eefb599b467561e'),(12,6,'otherlink.pgf',1,1,'2011-06-28 02:13:14',89012,'891ade31c9d71cae9eefb599b467561e'),(13,7,'big-image.png',1,1,'2011-06-28 02:13:14',114493,'73ded88d97601deb2d42dedac59a4786'),(14,7,'icc-test-farbkreis.jpg',1,1,'2011-06-28 02:13:14',75675,'6e6426a193df285022b616a563ce4ad6'),(15,7,'icc-test-no-profile.jpg',1,1,'2011-06-28 17:42:36',50331,'6c335b8c4891b709969aaa5ec36ef097'),(16,7,'Martian_face_viking.jpg',1,1,'2011-06-28 02:13:14',99416,'d77bfd4de3e8e4b2880a30cb03c824e6'),(17,8,'foto001q5.pgf',1,1,'2011-06-28 02:13:14',89012,'891ade31c9d71cae9eefb599b467561e'),(18,9,'foto001q5.pgf',1,1,'2011-06-28 02:13:14',89012,'891ade31c9d71cae9eefb599b467561e'),(19,9,'otherlink.pgf',1,1,'2011-06-28 02:13:14',89012,'891ade31c9d71cae9eefb599b467561e');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`digikam`@`%`*/ /*!50003 TRIGGER delete_image AFTER DELETE ON Images
            FOR EACH ROW BEGIN
            DELETE FROM ImageTags
            WHERE imageid=OLD.id;
            DELETE From ImageHaarMatrix
            WHERE imageid=OLD.id;
            DELETE From ImageInformation
            WHERE imageid=OLD.id;
            DELETE From ImageMetadata
            WHERE imageid=OLD.id;
            DELETE From ImagePositions
            WHERE imageid=OLD.id;
            DELETE From ImageComments
            WHERE imageid=OLD.id;
            DELETE From ImageCopyright
            WHERE imageid=OLD.id;
            DELETE From ImageProperties
            WHERE imageid=OLD.id;
            UPDATE Albums SET icon=null
            WHERE icon=OLD.id;
            UPDATE Tags SET icon=null
            WHERE icon=OLD.id;
            END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `imagetags`
--

DROP TABLE IF EXISTS `imagetags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagetags` (
  `imageid` int(11) NOT NULL,
  `tagid` int(11) NOT NULL,
  UNIQUE KEY `imageid` (`imageid`,`tagid`),
  KEY `tag_index` (`tagid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imagetags`
--

LOCK TABLES `imagetags` WRITE;
/*!40000 ALTER TABLE `imagetags` DISABLE KEYS */;
INSERT INTO `imagetags` VALUES (4,1),(4,2),(4,3);
/*!40000 ALTER TABLE `imagetags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searches`
--

DROP TABLE IF EXISTS `searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `name` longtext NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searches`
--

LOCK TABLES `searches` WRITE;
/*!40000 ALTER TABLE `searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `searches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `keyword` longtext NOT NULL,
  `value` longtext,
  UNIQUE KEY `keyword` (`keyword`(333))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES ('preAlpha010Update1','true'),('preAlpha010Update2','true'),('preAlpha010Update3','true'),('beta010Update1','true'),('beta010Update2','true'),('databaseImageFormats','jpg;jpeg;jpe;jp2;j2k;jpx;jpc;pgx;tif;tiff;png;xpm;ppm;pnm;pgf;gif;bmp;xcf;pcx;bay;bmq;cr2;crw;cs1;dc2;dcr;dng;erf;fff;hdr;k25;kdc;mdc;mos;mrw;nef;orf;pef;pxn;raf;raw;rdc;sr2;srf;x3f;arw;3fr;cine;ia;kc2;mef;nrw;qtk;rw2;sti;rwl;'),('databaseVideoFormats','mpeg;mpg;mpo;mpe;avi;mov;wmf;asf;mp4;3gp;wmv'),('databaseAudioFormats','ogg;mp3;wma;wav'),('FilterSettingsVersion','3'),('DcrawFilterSettingsVersion','3'),('DBVersion','0'),('databaseUserImageFormats',NULL),('databaseUserVideoFormats',NULL),('databaseUserAudioFormats',NULL),('DeleteRemovedCompleteScanCount','3'),('Scanned','2011-06-28T20:09:58'),('databaseUUID','{cb5e064b-a733-4466-a199-6d4022b5c932}');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `name` longtext NOT NULL,
  `icon` int(11) DEFAULT NULL,
  `iconkde` longtext,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,8,'tagl2a',0,NULL,35,36),(2,15,'tl0a',0,NULL,1,34),(3,2,'tl0a0',0,NULL,32,33),(4,0,'tagl0a',0,NULL,30,31),(5,0,'tagl0b',0,NULL,6,29),(6,0,'tagl0c',0,NULL,4,5),(7,5,'tagl1a',0,NULL,27,28),(8,5,'tagl1b',0,NULL,9,26),(9,5,'tagl1c',0,NULL,7,8),(10,8,'tagl2b',0,NULL,14,25),(11,8,'tagl2c',0,NULL,12,13),(12,8,'tagl2d',0,NULL,10,11),(13,10,'tagl3a',0,NULL,23,24),(14,10,'tagl3b',0,NULL,21,22),(15,0,'tl0',0,NULL,15,20),(16,15,'tl0b',0,NULL,18,19),(17,15,'tagl1c',0,NULL,16,17),(18,2,'tloa1',0,NULL,2,3);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`digikam`@`%`*/ /*!50003 TRIGGER move_tagstree AFTER UPDATE ON Tags
            FOR EACH ROW BEGIN
            DELETE FROM TagsTree;
            REPLACE INTO TagsTree
            SELECT node.id, parent.pid
            FROM Tags AS node, Tags AS parent
            WHERE node.lft BETWEEN parent.lft AND parent.rgt
            ORDER BY parent.lft;
            END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`digikam`@`%`*/ /*!50003 TRIGGER delete_tag AFTER DELETE ON Tags
            FOR EACH ROW BEGIN
                DELETE FROM ImageTags WHERE tagid=OLD.id;
                DELETE FROM TagsTree;
                REPLACE INTO TagsTree
                SELECT node.id, parent.pid
                FROM Tags AS node, Tags AS parent
                WHERE node.lft BETWEEN parent.lft AND parent.rgt
                ORDER BY parent.lft;
            END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tagstree`
--

DROP TABLE IF EXISTS `tagstree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagstree` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  UNIQUE KEY `id` (`id`,`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagstree`
--

LOCK TABLES `tagstree` WRITE;
/*!40000 ALTER TABLE `tagstree` DISABLE KEYS */;
INSERT INTO `tagstree` VALUES (1,8),(2,15),(3,2),(3,15),(4,0),(4,15),(5,0),(5,15),(6,0),(6,15),(7,0),(7,5),(7,15),(8,0),(8,5),(8,15),(9,0),(9,5),(9,15),(10,0),(10,5),(10,8),(10,15),(11,0),(11,5),(11,8),(11,15),(12,0),(12,5),(12,8),(12,15),(13,0),(13,5),(13,8),(13,10),(13,15),(14,0),(14,5),(14,8),(14,10),(14,15),(15,0),(15,5),(15,8),(15,15),(16,0),(16,5),(16,8),(16,15),(17,0),(17,5),(17,8),(17,15);
/*!40000 ALTER TABLE `tagstree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'digikam'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

