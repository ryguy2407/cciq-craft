-- MySQL dump 10.13  Distrib 8.0.16, for macos10.14 (x86_64)
--
-- Host: localhost    Database: cciq
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetindexdata`
--

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (2,1,1,'robot.png','image',2431,2431,6071833,NULL,NULL,NULL,'2019-06-22 10:25:10','2019-06-22 10:25:10','2019-06-22 10:25:10','284efc87-944e-4f22-be20-7da42ece9c5e');
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransformindex`
--

LOCK TABLES `assettransformindex` WRITE;
/*!40000 ALTER TABLE `assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_partyName` text,
  `field_cciqScore` text,
  `field_numberOfBusinessesRepresented` text,
  `field_description` text,
  `field_outcome` text,
  `field_stateSenate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,1,1,NULL,'2019-06-21 06:37:38','2019-06-21 06:37:38','00bd59d1-2850-43f2-b0b6-c2143cec319a',NULL,NULL,NULL,NULL,NULL,NULL),(2,2,1,'Robot','2019-06-22 10:25:07','2019-06-22 10:25:07','ffaa11b7-a37d-47e6-b2e1-984c3565bc80',NULL,NULL,NULL,NULL,NULL,NULL),(3,3,1,'Ryan Murray','2019-06-22 10:25:37','2019-06-24 04:21:30','5f9a83de-972c-4648-9557-0765a3ff43f4','Some Party','70','5',NULL,NULL,NULL),(4,4,1,'A plebiscite on the carbon pricing system','2019-06-22 10:27:32','2019-06-22 10:27:32','a5539273-3e0e-4d40-89d1-cda5b1c813bf',NULL,NULL,NULL,'Here is a description for this bill','Carried','state'),(5,5,1,'Herbert','2019-06-22 10:34:49','2019-06-22 10:34:49','31ae592c-e856-4dae-b1a1-2b4ed749356c',NULL,NULL,NULL,NULL,NULL,NULL),(6,10,1,'Some new bill','2019-06-24 04:20:39','2019-06-24 04:20:39','9d7e1f01-5e03-4ea7-8ee1-fdbc02689fc4',NULL,NULL,NULL,'Here is the bill','Carried','state');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
INSERT INTO `deprecationerrors` VALUES (1,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/index.twig:35','2019-06-24 03:26:10','/Users/ryanmurray/Sites/cciq/templates/members/index.twig',35,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/ed/edef680734e9deb504134ae4e4aade11a9e38b76da0353471fb0215c319d2be2.php\",\"line\":115,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"method\":\"doDisplay\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[], []\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[]\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members\\\", []]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 03:26:10','2019-06-24 03:26:10','70c1823e-d8b6-4d98-8fa7-4225f3a4c490'),(2,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/index.twig:34','2019-06-24 03:21:59','/Users/ryanmurray/Sites/cciq/templates/members/index.twig',34,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/ed/edef680734e9deb504134ae4e4aade11a9e38b76da0353471fb0215c319d2be2.php\",\"line\":114,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"method\":\"doDisplay\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, \\\"SORT_ASC\\\" => 4, \\\"SORT_DESC\\\" => 3, ...], []\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[], []\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[]\"},{\"objectClass\":\"__TwigTemplate_38f96f1647db1d85e671e74da756d5b559e2fab1215ccd23bdc7a69f6f1e072a\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members\\\", []\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members\\\", []]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members\\\"]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 03:21:59','2019-06-24 03:21:59','2757e1c4-9c80-49d7-9785-3ff9dcc2a1d0'),(12,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/show.twig:22','2019-06-24 03:36:18','/Users/ryanmurray/Sites/cciq/templates/members/show.twig',22,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/52/528af261380305eca982f47919d49aa2b2c0d706a7ae85272f7e8e5d6f811b2e.php\",\"line\":81,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 03:36:18','2019-06-24 03:36:18','5e83f97a-df5a-496e-87a0-5e5392843c5e'),(13,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/show.twig:26','2019-06-24 03:36:57','/Users/ryanmurray/Sites/cciq/templates/members/show.twig',26,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/52/528af261380305eca982f47919d49aa2b2c0d706a7ae85272f7e8e5d6f811b2e.php\",\"line\":93,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 03:36:57','2019-06-24 03:36:57','98041836-15a2-4203-9f28-e6400604cbb2'),(14,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/show.twig:25','2019-06-24 04:01:27','/Users/ryanmurray/Sites/cciq/templates/members/show.twig',25,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/52/528af261380305eca982f47919d49aa2b2c0d706a7ae85272f7e8e5d6f811b2e.php\",\"line\":90,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 04:01:27','2019-06-24 04:01:27','0f503268-4918-4b51-a19b-95926e5cff59'),(17,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/show.twig:35','2019-06-24 04:10:52','/Users/ryanmurray/Sites/cciq/templates/members/show.twig',35,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/52/528af261380305eca982f47919d49aa2b2c0d706a7ae85272f7e8e5d6f811b2e.php\",\"line\":110,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 04:10:52','2019-06-24 04:10:52','85eed21b-167d-444c-8e07-509a384a77b4'),(20,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/show.twig:36','2019-06-24 04:11:58','/Users/ryanmurray/Sites/cciq/templates/members/show.twig',36,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/52/528af261380305eca982f47919d49aa2b2c0d706a7ae85272f7e8e5d6f811b2e.php\",\"line\":111,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 04:11:58','2019-06-24 04:11:58','42796869-1a12-445b-9ec6-cfe8ff74b744'),(21,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/show.twig:64','2019-06-24 04:14:53','/Users/ryanmurray/Sites/cciq/templates/members/show.twig',64,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/52/528af261380305eca982f47919d49aa2b2c0d706a7ae85272f7e8e5d6f811b2e.php\",\"line\":139,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 04:14:53','2019-06-24 04:14:53','960f2412-85f0-4b19-aa19-9720fe32a31c'),(26,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/show.twig:62','2019-06-24 04:15:22','/Users/ryanmurray/Sites/cciq/templates/members/show.twig',62,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/52/528af261380305eca982f47919d49aa2b2c0d706a7ae85272f7e8e5d6f811b2e.php\",\"line\":137,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 04:15:22','2019-06-24 04:15:22','26e66d4e-9131-4212-a22b-101eff09c7a5'),(29,'ElementQuery::getIterator()','/Users/ryanmurray/Sites/cciq/templates/members/show.twig:59','2019-06-24 04:32:04','/Users/ryanmurray/Sites/cciq/templates/members/show.twig',59,'Looping through element queries directly has been deprecated. Use the all() function to fetch the query results before looping over them.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/elements/db/ElementQuery.php\",\"line\":464,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"ElementQuery::getIterator()\\\", \\\"Looping through element queries directly has been deprecated. Us...\\\"\"},{\"objectClass\":\"craft\\\\elements\\\\db\\\\EntryQuery\",\"file\":\"/Users/ryanmurray/Sites/cciq/storage/runtime/compiled_templates/52/528af261380305eca982f47919d49aa2b2c0d706a7ae85272f7e8e5d6f811b2e.php\",\"line\":134,\"class\":\"craft\\\\elements\\\\db\\\\ElementQuery\",\"method\":\"getIterator\",\"args\":null},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":407,\"class\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"method\":\"doDisplay\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":52,\"class\":\"Twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":380,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"displayWithErrorHandling\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry], \\\"view\\\" => craft\\\\web\\\\View, \\\"devMode\\\" => true, ...], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/twig/Template.php\",\"line\":34,\"class\":\"Twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Template.php\",\"line\":392,\"class\":\"craft\\\\web\\\\twig\\\\Template\",\"method\":\"display\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"__TwigTemplate_8feb816b06bec9757d30e6ea1c34322ea5103a71b03583ea19773cb9711d3d3b\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/TemplateWrapper.php\",\"line\":45,\"class\":\"Twig\\\\Template\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]], []\"},{\"objectClass\":\"Twig\\\\TemplateWrapper\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/twig/twig/src/Environment.php\",\"line\":318,\"class\":\"Twig\\\\TemplateWrapper\",\"method\":\"render\",\"args\":\"[\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\twig\\\\Environment\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":343,\"class\":\"Twig\\\\Environment\",\"method\":\"render\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/View.php\",\"line\":393,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\View\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":161,\"class\":\"craft\\\\web\\\\View\",\"method\":\"renderPageTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/controllers/TemplatesController.php\",\"line\":78,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"renderTemplate\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":null,\"line\":null,\"class\":\"craft\\\\controllers\\\\TemplatesController\",\"method\":\"actionRender\",\"args\":\"\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry, \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/InlineAction.php\",\"line\":57,\"class\":null,\"method\":\"call_user_func_array\",\"args\":\"[craft\\\\controllers\\\\TemplatesController, \\\"actionRender\\\"], [\\\"members/show\\\", [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"yii\\\\base\\\\InlineAction\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Controller.php\",\"line\":157,\"class\":\"yii\\\\base\\\\InlineAction\",\"method\":\"runWithParams\",\"args\":\"[\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Controller.php\",\"line\":109,\"class\":\"yii\\\\base\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\controllers\\\\TemplatesController\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Module.php\",\"line\":528,\"class\":\"craft\\\\web\\\\Controller\",\"method\":\"runAction\",\"args\":\"\\\"render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":297,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/web/Application.php\",\"line\":103,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"runAction\",\"args\":\"\\\"templates/render\\\", [\\\"template\\\" => \\\"members/show\\\", \\\"variables\\\" => [\\\"entry\\\" => craft\\\\elements\\\\Entry]]\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/craftcms/cms/src/web/Application.php\",\"line\":286,\"class\":\"yii\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/vendor/yiisoft/yii2/base/Application.php\",\"line\":386,\"class\":\"craft\\\\web\\\\Application\",\"method\":\"handleRequest\",\"args\":\"craft\\\\web\\\\Request\"},{\"objectClass\":\"craft\\\\web\\\\Application\",\"file\":\"/Users/ryanmurray/Sites/cciq/web/index.php\",\"line\":21,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"run\",\"args\":null},{\"objectClass\":null,\"file\":\"/Users/ryanmurray/.composer/vendor/laravel/valet/server.php\",\"line\":158,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/Users/ryanmurray/Sites/cciq/web/index.php\\\"\"}]','2019-06-24 04:32:04','2019-06-24 04:32:04','36faa325-3c93-47da-8596-8243c9b855af');
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
INSERT INTO `elementindexsettings` VALUES (1,'craft\\elements\\Entry','{\"sources\":{\"section:254c0796-705e-4bfd-9225-6795c64d5a08\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"link\"}},\"section:d807f805-e423-4005-a1b2-852d98a45fd9\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"author\",\"4\":\"slug\",\"5\":\"link\"}},\"section:dff8813a-f89e-4ad3-a6f6-9c9770beffcb\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"field:1\",\"4\":\"link\"}}}}','2019-06-22 10:36:19','2019-06-22 10:36:19','ca8107c6-2019-41a8-a371-f73b7d741a7f');
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
INSERT INTO `elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2019-06-21 06:37:38','2019-06-21 06:37:38',NULL,'f22d1646-742e-4087-a98d-76298a7a27dc'),(2,NULL,'craft\\elements\\Asset',1,0,'2019-06-22 10:25:07','2019-06-22 10:25:07',NULL,'0af48197-0794-4a28-9833-493a14f45746'),(3,1,'craft\\elements\\Entry',1,0,'2019-06-22 10:25:37','2019-06-24 04:21:30',NULL,'4a098083-7542-4fc0-80b4-46d3f8878fcc'),(4,2,'craft\\elements\\Entry',1,0,'2019-06-22 10:27:32','2019-06-22 10:27:32',NULL,'fbff1788-f9ce-416e-bd22-2c3586e22dd3'),(5,4,'craft\\elements\\Entry',1,0,'2019-06-22 10:34:49','2019-06-22 10:34:49',NULL,'6c7b9223-d271-4b59-9b6d-dd73251de559'),(6,3,'craft\\elements\\MatrixBlock',1,0,'2019-06-22 10:34:49','2019-06-22 10:34:49',NULL,'54907022-be8a-40de-af74-bc478f440f27'),(7,3,'craft\\elements\\MatrixBlock',1,0,'2019-06-22 10:34:50','2019-06-22 10:34:50',NULL,'3d6b035c-5fda-4880-ba10-14040f154715'),(8,5,'craft\\elements\\MatrixBlock',1,0,'2019-06-24 00:23:45','2019-06-24 04:21:30',NULL,'f2859a85-2638-4922-8d6d-b4d0db311c98'),(9,5,'craft\\elements\\MatrixBlock',1,0,'2019-06-24 04:20:07','2019-06-24 04:20:07','2019-06-24 04:21:30','be76874f-22a2-412c-9c3d-11eb510c0729'),(10,2,'craft\\elements\\Entry',1,0,'2019-06-24 04:20:39','2019-06-24 04:20:39',NULL,'a8d5ff9e-a15b-4bbb-bafa-4adc30d3f5d0'),(11,5,'craft\\elements\\MatrixBlock',1,0,'2019-06-24 04:21:30','2019-06-24 04:21:30',NULL,'1eedb4ec-45e2-434b-bb76-ff465da479b5');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-06-21 06:37:38','2019-06-21 06:37:38','1b2a77c3-afab-47dd-b123-536c02007a72'),(2,2,1,NULL,NULL,1,'2019-06-22 10:25:07','2019-06-22 10:25:07','6124230c-aca8-46db-a015-daf68d77688d'),(3,3,1,'ryan-murray','members/ryan-murray',1,'2019-06-22 10:25:37','2019-06-24 04:21:30','b75baa24-03a2-4f7a-b91f-cebde5f4a32e'),(4,4,1,'a-plebiscite-on-the-carbon-pricing-system','bills/a-plebiscite-on-the-carbon-pricing-system',1,'2019-06-22 10:27:32','2019-06-22 10:27:32','42936e80-fe67-4b59-885d-a99523af6c80'),(5,5,1,'herbert','electorates/herbert',1,'2019-06-22 10:34:49','2019-06-22 10:34:49','b803f4a6-629c-4889-86f4-5a43cde5a8db'),(6,6,1,NULL,NULL,1,'2019-06-22 10:34:49','2019-06-22 10:34:49','f5093613-8378-4a6c-ab7c-230846cfe263'),(7,7,1,NULL,NULL,1,'2019-06-22 10:34:50','2019-06-22 10:34:50','b9e9743c-9c25-45b5-a6f5-8c1d90eab8e3'),(8,8,1,NULL,NULL,1,'2019-06-24 00:23:45','2019-06-24 04:21:30','5e2930b8-21ae-4f81-bd61-3ac022ce9a27'),(9,9,1,NULL,NULL,1,'2019-06-24 04:20:07','2019-06-24 04:20:07','52d6ddd8-ebbd-4a0e-b97d-180beb601ad4'),(10,10,1,'some-new-bill','bills/some-new-bill',1,'2019-06-24 04:20:39','2019-06-24 04:20:39','28d57ca3-ebf8-4b9b-8332-9450fc84dac1'),(11,11,1,NULL,NULL,1,'2019-06-24 04:21:30','2019-06-24 04:21:30','6fc58db4-3be9-4e7f-8697-19f251bce371');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
INSERT INTO `entries` VALUES (3,1,NULL,1,1,'2019-06-22 10:25:00',NULL,NULL,'2019-06-22 10:25:37','2019-06-24 04:21:30','0fae715b-ddab-452d-a4f4-e95899f6aa4f'),(4,2,NULL,2,1,'2019-06-22 10:27:00',NULL,NULL,'2019-06-22 10:27:33','2019-06-22 10:27:33','352b8730-ec1f-494a-b007-5cbe6da38fe9'),(5,3,NULL,3,1,'2019-06-22 10:34:00',NULL,NULL,'2019-06-22 10:34:49','2019-06-22 10:34:49','3df0b354-366d-41ad-a1c6-d377eaf70e27'),(10,2,NULL,2,1,'2019-06-24 04:20:00',NULL,NULL,'2019-06-24 04:20:39','2019-06-24 04:20:39','0b667c04-e09d-4c35-b32c-02bec985b409');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrydrafts`
--

DROP TABLE IF EXISTS `entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrydrafts`
--

LOCK TABLES `entrydrafts` WRITE;
/*!40000 ALTER TABLE `entrydrafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
INSERT INTO `entrytypes` VALUES (1,1,1,'Members','members',1,'Title','',1,'2019-06-22 10:05:14','2019-06-24 00:23:03',NULL,'5cdf339d-021e-401a-ad06-8e42c9601b6d'),(2,2,2,'Bills','bills',1,'Title','',1,'2019-06-22 10:18:38','2019-06-22 10:24:39',NULL,'9286799e-ac83-4ca4-a34c-1e4b41e44444'),(3,3,4,'Electorates','electorates',1,'Title','',1,'2019-06-22 10:29:54','2019-06-22 10:33:56',NULL,'5752c4cb-c0fe-4f5a-9336-a897413fb744');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entryversions`
--

DROP TABLE IF EXISTS `entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entryversions`
--

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;
INSERT INTO `entryversions` VALUES (1,3,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Ryan Murray\",\"slug\":\"ryan-murray\",\"postDate\":1561199100,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"3\":[\"2\"],\"2\":\"Some Party\",\"1\":[\"2\"]}}','2019-06-22 10:25:37','2019-06-22 10:25:37','5ee3e282-6bf8-45fc-a252-29c46c7bcce5'),(2,4,2,1,1,1,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"A plebiscite on the carbon pricing system\",\"slug\":\"a-plebiscite-on-the-carbon-pricing-system\",\"postDate\":1561199220,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"6\":\"Here is a description for this bill\",\"10\":[\"3\"],\"9\":[\"3\"],\"7\":\"Carried\",\"8\":\"state\"}}','2019-06-22 10:27:33','2019-06-22 10:27:33','94b4f58b-77d8-4586-9c05-5e3decd6fe2f'),(3,5,3,1,1,1,'','{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Herbert\",\"slug\":\"herbert\",\"postDate\":1561199640,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"11\":{\"6\":{\"type\":\"electorateDetails\",\"enabled\":\"1\",\"collapsed\":false,\"fields\":{\"suburb\":\"Aitkenvale\",\"postcode\":\"4810\"}},\"7\":{\"type\":\"electorateDetails\",\"enabled\":\"1\",\"collapsed\":false,\"fields\":{\"suburb\":\"Belgian Gardens\",\"postcode\":\"4810\"}}}}}','2019-06-22 10:34:50','2019-06-22 10:34:50','2af9687d-09ac-4988-9219-a2fbead21364'),(4,3,1,1,1,2,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Ryan Murray\",\"slug\":\"ryan-murray\",\"postDate\":1561199100,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"14\":[\"5\"],\"3\":[\"2\"],\"2\":\"Some Party\",\"1\":[\"2\"]}}','2019-06-22 10:38:16','2019-06-22 10:38:16','7f52fe25-4909-4bd5-b903-7c837fb3cbe6'),(5,3,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Ryan Murray\",\"slug\":\"ryan-murray\",\"postDate\":1561199100,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":\"70\",\"14\":[\"5\"],\"5\":\"5\",\"3\":[\"2\"],\"2\":\"Some Party\",\"1\":[\"2\"],\"15\":{\"8\":{\"type\":\"bills\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"memberBill\":[\"4\"],\"memberVoted\":\"no\"}}}}}','2019-06-24 00:23:46','2019-06-24 00:23:46','6f802c42-4ec7-4411-ac2f-d5691a7e9f80'),(6,3,1,1,1,4,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Ryan Murray\",\"slug\":\"ryan-murray\",\"postDate\":1561199100,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":\"70\",\"14\":[\"5\"],\"5\":\"5\",\"3\":[\"2\"],\"2\":\"Some Party\",\"1\":[\"2\"],\"15\":{\"8\":{\"type\":\"bills\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"billTitle\":[\"4\"],\"memberVoted\":\"no\"}}}}}','2019-06-24 00:27:15','2019-06-24 00:27:15','0555ceec-85c6-4e16-9cb3-57726131aa61'),(7,3,1,1,1,5,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Ryan Murray\",\"slug\":\"ryan-murray\",\"postDate\":1561199100,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":\"70\",\"14\":[\"5\"],\"5\":\"5\",\"3\":[\"2\"],\"2\":\"Some Party\",\"1\":[\"2\"],\"15\":{\"8\":{\"type\":\"bills\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"billTitle\":[\"4\"],\"memberVoted\":\"no\"}},\"9\":{\"type\":\"bills\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"billTitle\":[\"4\"],\"memberVoted\":\"yes\"}}}}}','2019-06-24 04:20:07','2019-06-24 04:20:07','073d5d83-fc94-490a-b611-1a6aa5aa463f'),(8,10,2,1,1,1,'','{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"Some new bill\",\"slug\":\"some-new-bill\",\"postDate\":1561350000,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"6\":\"Here is the bill\",\"7\":\"Carried\",\"8\":\"state\"}}','2019-06-24 04:20:39','2019-06-24 04:20:39','fd6bec4b-cc66-44c7-8a45-adfa4258f018'),(9,3,1,1,1,6,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Ryan Murray\",\"slug\":\"ryan-murray\",\"postDate\":1561199100,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"4\":\"70\",\"14\":[\"5\"],\"5\":\"5\",\"3\":[\"2\"],\"2\":\"Some Party\",\"1\":[\"2\"],\"15\":{\"8\":{\"type\":\"bills\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"billTitle\":[\"4\"],\"memberVoted\":\"no\"}},\"11\":{\"type\":\"bills\",\"enabled\":true,\"collapsed\":false,\"fields\":{\"billTitle\":[\"10\"],\"memberVoted\":\"yes\"}}}}}','2019-06-24 04:21:30','2019-06-24 04:21:30','1766d8fe-ea83-476a-89bb-8c7b2f46bd5b');
/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
INSERT INTO `fieldgroups` VALUES (1,'Common','2019-06-21 06:37:38','2019-06-21 06:37:38','4bf26699-bc41-46c2-94d9-b4d8ef891dbc'),(2,'Member Fields','2019-06-22 10:08:14','2019-06-22 10:08:14','6bd9bd98-62b5-4c53-b8a5-fbbe6b52cd4e'),(3,'Bill Fields','2019-06-22 10:19:04','2019-06-22 10:19:04','5f7f6c2a-4ff5-4f96-aebc-051ecd64056c'),(4,'Electorate Fields','2019-06-22 10:30:06','2019-06-22 10:30:06','7002b8a8-bee8-484f-bfd4-a7267c4a3be3');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
INSERT INTO `fieldlayoutfields` VALUES (6,2,4,6,0,1,'2019-06-22 10:24:39','2019-06-22 10:24:39','3f7b8849-9e74-48b1-9a68-ddceed71d2d1'),(7,2,4,7,0,2,'2019-06-22 10:24:39','2019-06-22 10:24:39','f353cb68-943f-41b6-a6e4-e5189ad87e4e'),(8,2,4,8,0,3,'2019-06-22 10:24:39','2019-06-22 10:24:39','300b5017-03a2-4699-9d3b-dce90fe550bf'),(11,3,5,12,0,1,'2019-06-22 10:33:24','2019-06-22 10:33:24','56eeaa8c-120d-4724-b600-b6119abee095'),(12,3,5,13,0,2,'2019-06-22 10:33:24','2019-06-22 10:33:24','4680d091-9937-4315-9389-8bc31cc70e59'),(13,4,6,11,0,1,'2019-06-22 10:33:56','2019-06-22 10:33:56','694d7b26-c1ba-4a61-a80e-50a28c65be73'),(20,1,9,1,0,1,'2019-06-24 00:23:03','2019-06-24 00:23:03','092fca41-eeb1-4d17-a287-253248cd1abc'),(21,1,9,3,0,2,'2019-06-24 00:23:03','2019-06-24 00:23:03','f3e8cddd-e39a-4615-8092-ea2f459eaeb8'),(22,1,9,2,0,3,'2019-06-24 00:23:03','2019-06-24 00:23:03','6a79e691-f735-4dde-8f47-e1accbd40c61'),(23,1,9,14,0,4,'2019-06-24 00:23:03','2019-06-24 00:23:03','6fa2e24f-caed-4dff-bd9d-3dfb74db7bbb'),(24,1,9,4,0,5,'2019-06-24 00:23:03','2019-06-24 00:23:03','72aff61a-1f0d-412f-821b-0a2b803d059d'),(25,1,9,5,0,6,'2019-06-24 00:23:03','2019-06-24 00:23:03','68d17e75-20f7-4b92-b2ff-ff73e53af62b'),(26,1,10,15,0,1,'2019-06-24 00:23:03','2019-06-24 00:23:03','425b1e41-d7b9-4ad8-929e-e5422fc8bbe4'),(29,5,12,16,1,1,'2019-06-24 00:26:38','2019-06-24 00:26:38','599be03b-db52-4e60-be48-5adfd3078de1'),(30,5,12,17,0,2,'2019-06-24 00:26:38','2019-06-24 00:26:38','6e358bb6-ae8c-4538-99cf-d195525d2229');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Entry','2019-06-22 10:10:53','2019-06-24 00:23:03',NULL,'1c65b01e-4838-4c6c-aab7-8d7e385d0d9c'),(2,'craft\\elements\\Entry','2019-06-22 10:20:02','2019-06-22 10:24:39',NULL,'eef5034b-1b8b-45f8-b8fc-e4ff65bb65e1'),(3,'craft\\elements\\MatrixBlock','2019-06-22 10:33:24','2019-06-22 10:33:24',NULL,'e9243b94-f3a0-408c-9d23-04de67e92153'),(4,'craft\\elements\\Entry','2019-06-22 10:33:55','2019-06-22 10:33:55',NULL,'93097a34-f548-4ca7-b57c-0d49cfceb9f1'),(5,'craft\\elements\\MatrixBlock','2019-06-24 00:21:55','2019-06-24 00:26:37',NULL,'adbc81eb-f1d9-4c43-83a3-3acbbf46ad6a');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
INSERT INTO `fieldlayouttabs` VALUES (4,2,'Bill Fields',1,'2019-06-22 10:24:39','2019-06-22 10:24:39','4ee7a6e9-e2ac-476c-b076-432006c8c93f'),(5,3,'Content',1,'2019-06-22 10:33:24','2019-06-22 10:33:24','ad3ea5cd-739d-4ad6-b84a-db20944cce1d'),(6,4,'Electorate Fields',1,'2019-06-22 10:33:55','2019-06-22 10:33:55','54bd99d1-dec9-47ff-a3b6-c879e537c8c1'),(9,1,'Member Fields',1,'2019-06-24 00:23:03','2019-06-24 00:23:03','f969c7b2-53d7-481c-86e6-a855d1c388bf'),(10,1,'Voting History',2,'2019-06-24 00:23:03','2019-06-24 00:23:03','d189972c-e533-411b-9d1e-3aceb780da64'),(12,5,'Content',1,'2019-06-24 00:26:37','2019-06-24 00:26:37','4f67efaa-8e87-49b8-a532-c3c3c504a0ef');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (1,2,'Profile Image','profileImage','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:501ef12a-77fa-4e7f-bf39-481aa9347b3e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:501ef12a-77fa-4e7f-bf39-481aa9347b3e\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"1\",\"selectionLabel\":\"Add profile image\",\"localizeRelations\":false}','2019-06-22 10:07:22','2019-06-22 10:11:38','08067416-d6e2-48b3-884b-1b64b2f95d53'),(2,2,'Party Name','partyName','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-22 10:12:19','2019-06-22 10:12:19','d704f28e-0eee-40fc-b7af-47734db0812e'),(3,2,'Party Logo','partyLogo','global','',1,'site',NULL,'craft\\fields\\Assets','{\"useSingleFolder\":\"\",\"defaultUploadLocationSource\":\"volume:501ef12a-77fa-4e7f-bf39-481aa9347b3e\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"volume:501ef12a-77fa-4e7f-bf39-481aa9347b3e\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"allowedKinds\":null,\"sources\":\"*\",\"source\":null,\"targetSiteId\":null,\"viewMode\":\"list\",\"limit\":\"\",\"selectionLabel\":\"\",\"localizeRelations\":false}','2019-06-22 10:13:50','2019-06-22 10:13:50','2a3b764d-eda7-4ae6-93bc-85e1bb41c2c6'),(4,2,'CCIQ Score (%)','cciqScore','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-22 10:16:38','2019-06-22 10:16:38','0ed4dc29-d88b-446e-945d-7023cf2233cc'),(5,2,'Number of Businesses Represented','numberOfBusinessesRepresented','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-22 10:18:03','2019-06-22 10:18:03','d6bd6450-e771-45e0-a300-9d7b723460a5'),(6,3,'Description','description','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"1\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-22 10:19:41','2019-06-22 10:19:41','3d9cecfd-d969-47ad-ba7e-2860d666596d'),(7,3,'Outcome','outcome','global','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-22 10:21:20','2019-06-22 10:21:58','2edc6b51-16d0-4bc0-af96-6d4bc454a892'),(8,3,'State/Senate','stateSenate','global','',1,'none',NULL,'craft\\fields\\RadioButtons','{\"options\":[{\"label\":\"State\",\"value\":\"state\",\"default\":\"\"},{\"label\":\"Senate\",\"value\":\"senate\",\"default\":\"\"}]}','2019-06-22 10:22:38','2019-06-22 10:22:38','71bf0c45-74a9-41c6-a28a-cb71625be337'),(11,4,'Electorate Areas','electorateAreas','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_electorateareas}}\",\"localizeBlocks\":false}','2019-06-22 10:33:23','2019-06-22 10:33:23','ae4b0a58-01d9-4024-b8e5-159a337cc1c8'),(12,NULL,'Suburb','suburb','matrixBlockType:0346a29b-9bc7-484b-9c5a-e39b11e174d7','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-22 10:33:24','2019-06-22 10:33:24','8d8d90fa-85be-49a1-abee-a08cd756f8ec'),(13,NULL,'Postcode','postcode','matrixBlockType:0346a29b-9bc7-484b-9c5a-e39b11e174d7','',1,'none',NULL,'craft\\fields\\PlainText','{\"placeholder\":\"\",\"code\":\"\",\"multiline\":\"\",\"initialRows\":\"4\",\"charLimit\":\"\",\"columnType\":\"text\"}','2019-06-22 10:33:24','2019-06-22 10:33:24','1b30257a-b703-4806-b945-6c3833575a3b'),(14,2,'Member Electorate','memberElectorate','global','',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":[\"section:254c0796-705e-4bfd-9225-6795c64d5a08\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"\",\"selectionLabel\":\"Select Members Electorate/s\",\"localizeRelations\":false}','2019-06-22 10:37:09','2019-06-22 10:38:39','40141a1c-b108-4784-a53f-e3f40a04bb98'),(15,2,'Voting History','votingHistory','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"minBlocks\":\"\",\"maxBlocks\":\"\",\"contentTable\":\"{{%matrixcontent_votinghistory}}\",\"localizeBlocks\":false}','2019-06-24 00:21:54','2019-06-24 00:26:37','bb2e73c7-ac7d-4159-9534-abf0862093f1'),(16,NULL,'Bill Title','billTitle','matrixBlockType:d9975dcb-f695-4327-984e-934c2c07775c','',1,'site',NULL,'craft\\fields\\Entries','{\"sources\":[\"section:d807f805-e423-4005-a1b2-852d98a45fd9\"],\"source\":null,\"targetSiteId\":null,\"viewMode\":null,\"limit\":\"1\",\"selectionLabel\":\"Add a bill\",\"localizeRelations\":false}','2019-06-24 00:21:54','2019-06-24 00:26:37','6af810b0-e0a8-4c47-af9a-10193c213116'),(17,NULL,'Member Voted','memberVoted','matrixBlockType:d9975dcb-f695-4327-984e-934c2c07775c','',1,'none',NULL,'craft\\fields\\RadioButtons','{\"options\":[{\"label\":\"Yes\",\"value\":\"yes\",\"default\":\"\"},{\"label\":\"No\",\"value\":\"no\",\"default\":\"\"}]}','2019-06-24 00:21:55','2019-06-24 00:26:37','5774752c-9f3e-4741-9dfe-6022ed164a25');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
INSERT INTO `info` VALUES (1,'3.1.31','3.1.28',0,'a:12:{s:11:\"fieldGroups\";a:4:{s:36:\"4bf26699-bc41-46c2-94d9-b4d8ef891dbc\";a:1:{s:4:\"name\";s:6:\"Common\";}s:36:\"6bd9bd98-62b5-4c53-b8a5-fbbe6b52cd4e\";a:1:{s:4:\"name\";s:13:\"Member Fields\";}s:36:\"5f7f6c2a-4ff5-4f96-aebc-051ecd64056c\";a:1:{s:4:\"name\";s:11:\"Bill Fields\";}s:36:\"7002b8a8-bee8-484f-bfd4-a7267c4a3be3\";a:1:{s:4:\"name\";s:17:\"Electorate Fields\";}}s:10:\"siteGroups\";a:1:{s:36:\"6832b384-de12-4112-9fa4-4204e69b4648\";a:1:{s:4:\"name\";s:4:\"CCIQ\";}}s:5:\"sites\";a:1:{s:36:\"a8c97652-0966-4e3c-a5db-9beefee1e028\";a:8:{s:7:\"baseUrl\";s:17:\"$DEFAULT_SITE_URL\";s:6:\"handle\";s:7:\"default\";s:7:\"hasUrls\";b:1;s:8:\"language\";s:5:\"en-US\";s:4:\"name\";s:4:\"CCIQ\";s:7:\"primary\";b:1;s:9:\"siteGroup\";s:36:\"6832b384-de12-4112-9fa4-4204e69b4648\";s:9:\"sortOrder\";i:1;}}s:5:\"email\";a:3:{s:9:\"fromEmail\";s:25:\"ryanmurrayemail@gmail.com\";s:8:\"fromName\";s:4:\"CCIQ\";s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:6:\"system\";a:5:{s:7:\"edition\";s:3:\"pro\";s:4:\"name\";s:4:\"CCIQ\";s:4:\"live\";b:1;s:13:\"schemaVersion\";s:6:\"3.1.28\";s:8:\"timeZone\";s:19:\"America/Los_Angeles\";}s:5:\"users\";a:5:{s:24:\"requireEmailVerification\";b:1;s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:14:\"photoVolumeUid\";N;s:12:\"photoSubpath\";s:0:\"\";}s:12:\"dateModified\";i:1561347062;s:7:\"plugins\";a:1:{s:4:\"copy\";a:3:{s:7:\"edition\";s:8:\"standard\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:5:\"1.0.0\";}}s:8:\"sections\";a:3:{s:36:\"dff8813a-f89e-4ad3-a6f6-9c9770beffcb\";a:7:{s:4:\"name\";s:7:\"Members\";s:6:\"handle\";s:7:\"members\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"a8c97652-0966-4e3c-a5db-9beefee1e028\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:14:\"members/{slug}\";s:8:\"template\";s:12:\"members/show\";}}s:10:\"entryTypes\";a:1:{s:36:\"5cdf339d-021e-401a-ad06-8e42c9601b6d\";a:7:{s:4:\"name\";s:7:\"Members\";s:6:\"handle\";s:7:\"members\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:0:\"\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"1c65b01e-4838-4c6c-aab7-8d7e385d0d9c\";a:1:{s:4:\"tabs\";a:2:{i:0;a:3:{s:4:\"name\";s:13:\"Member Fields\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:6:{s:36:\"08067416-d6e2-48b3-884b-1b64b2f95d53\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"2a3b764d-eda7-4ae6-93bc-85e1bb41c2c6\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"d704f28e-0eee-40fc-b7af-47734db0812e\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}s:36:\"40141a1c-b108-4784-a53f-e3f40a04bb98\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:4;}s:36:\"0ed4dc29-d88b-446e-945d-7023cf2233cc\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:5;}s:36:\"d6bd6450-e771-45e0-a300-9d7b723460a5\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:6;}}}i:1;a:3:{s:4:\"name\";s:14:\"Voting History\";s:9:\"sortOrder\";i:2;s:6:\"fields\";a:1:{s:36:\"bb2e73c7-ac7d-4159-9534-abf0862093f1\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}}}s:36:\"d807f805-e423-4005-a1b2-852d98a45fd9\";a:7:{s:4:\"name\";s:5:\"Bills\";s:6:\"handle\";s:5:\"bills\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"a8c97652-0966-4e3c-a5db-9beefee1e028\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:12:\"bills/{slug}\";s:8:\"template\";s:0:\"\";}}s:10:\"entryTypes\";a:1:{s:36:\"9286799e-ac83-4ca4-a34c-1e4b41e44444\";a:7:{s:4:\"name\";s:5:\"Bills\";s:6:\"handle\";s:5:\"bills\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:0:\"\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"eef5034b-1b8b-45f8-b8fc-e4ff65bb65e1\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:11:\"Bill Fields\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:3:{s:36:\"3d9cecfd-d969-47ad-ba7e-2860d666596d\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"2edc6b51-16d0-4bc0-af96-6d4bc454a892\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}s:36:\"71bf0c45-74a9-41c6-a28a-cb71625be337\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:3;}}}}}}}}}s:36:\"254c0796-705e-4bfd-9225-6795c64d5a08\";a:7:{s:4:\"name\";s:11:\"Electorates\";s:6:\"handle\";s:11:\"electorates\";s:4:\"type\";s:7:\"channel\";s:16:\"enableVersioning\";b:1;s:16:\"propagateEntries\";b:1;s:12:\"siteSettings\";a:1:{s:36:\"a8c97652-0966-4e3c-a5db-9beefee1e028\";a:4:{s:16:\"enabledByDefault\";b:1;s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:18:\"electorates/{slug}\";s:8:\"template\";s:0:\"\";}}s:10:\"entryTypes\";a:1:{s:36:\"5752c4cb-c0fe-4f5a-9336-a897413fb744\";a:7:{s:4:\"name\";s:11:\"Electorates\";s:6:\"handle\";s:11:\"electorates\";s:13:\"hasTitleField\";b:1;s:10:\"titleLabel\";s:5:\"Title\";s:11:\"titleFormat\";s:0:\"\";s:9:\"sortOrder\";i:1;s:12:\"fieldLayouts\";a:1:{s:36:\"93097a34-f548-4ca7-b57c-0d49cfceb9f1\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:17:\"Electorate Fields\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:1:{s:36:\"ae4b0a58-01d9-4024-b8e5-159a337cc1c8\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}}}}}}}}}}s:6:\"fields\";a:11:{s:36:\"08067416-d6e2-48b3-884b-1b64b2f95d53\";a:10:{s:4:\"name\";s:13:\"Profile Image\";s:6:\"handle\";s:12:\"profileImage\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:501ef12a-77fa-4e7f-bf39-481aa9347b3e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:501ef12a-77fa-4e7f-bf39-481aa9347b3e\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:0:\"\";s:12:\"allowedKinds\";N;s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:17:\"Add profile image\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"6bd9bd98-62b5-4c53-b8a5-fbbe6b52cd4e\";}s:36:\"d704f28e-0eee-40fc-b7af-47734db0812e\";a:10:{s:4:\"name\";s:10:\"Party Name\";s:6:\"handle\";s:9:\"partyName\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"6bd9bd98-62b5-4c53-b8a5-fbbe6b52cd4e\";}s:36:\"2a3b764d-eda7-4ae6-93bc-85e1bb41c2c6\";a:10:{s:4:\"name\";s:10:\"Party Logo\";s:6:\"handle\";s:9:\"partyLogo\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Assets\";s:8:\"settings\";a:14:{s:15:\"useSingleFolder\";s:0:\"\";s:27:\"defaultUploadLocationSource\";s:43:\"volume:501ef12a-77fa-4e7f-bf39-481aa9347b3e\";s:28:\"defaultUploadLocationSubpath\";s:0:\"\";s:26:\"singleUploadLocationSource\";s:43:\"volume:501ef12a-77fa-4e7f-bf39-481aa9347b3e\";s:27:\"singleUploadLocationSubpath\";s:0:\"\";s:13:\"restrictFiles\";s:0:\"\";s:12:\"allowedKinds\";N;s:7:\"sources\";s:1:\"*\";s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";s:4:\"list\";s:5:\"limit\";s:0:\"\";s:14:\"selectionLabel\";s:0:\"\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"6bd9bd98-62b5-4c53-b8a5-fbbe6b52cd4e\";}s:36:\"0ed4dc29-d88b-446e-945d-7023cf2233cc\";a:10:{s:4:\"name\";s:14:\"CCIQ Score (%)\";s:6:\"handle\";s:9:\"cciqScore\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"6bd9bd98-62b5-4c53-b8a5-fbbe6b52cd4e\";}s:36:\"d6bd6450-e771-45e0-a300-9d7b723460a5\";a:10:{s:4:\"name\";s:32:\"Number of Businesses Represented\";s:6:\"handle\";s:29:\"numberOfBusinessesRepresented\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"6bd9bd98-62b5-4c53-b8a5-fbbe6b52cd4e\";}s:36:\"3d9cecfd-d969-47ad-ba7e-2860d666596d\";a:10:{s:4:\"name\";s:11:\"Description\";s:6:\"handle\";s:11:\"description\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:1:\"1\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"5f7f6c2a-4ff5-4f96-aebc-051ecd64056c\";}s:36:\"2edc6b51-16d0-4bc0-af96-6d4bc454a892\";a:10:{s:4:\"name\";s:7:\"Outcome\";s:6:\"handle\";s:7:\"outcome\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";s:36:\"5f7f6c2a-4ff5-4f96-aebc-051ecd64056c\";}s:36:\"71bf0c45-74a9-41c6-a28a-cb71625be337\";a:10:{s:4:\"name\";s:12:\"State/Senate\";s:6:\"handle\";s:11:\"stateSenate\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:25:\"craft\\fields\\RadioButtons\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:5:\"State\";s:5:\"value\";s:5:\"state\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:6:\"Senate\";s:5:\"value\";s:6:\"senate\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"5f7f6c2a-4ff5-4f96-aebc-051ecd64056c\";}s:36:\"ae4b0a58-01d9-4024-b8e5-159a337cc1c8\";a:10:{s:4:\"name\";s:16:\"Electorate Areas\";s:6:\"handle\";s:15:\"electorateAreas\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:34:\"{{%matrixcontent_electorateareas}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"7002b8a8-bee8-484f-bfd4-a7267c4a3be3\";}s:36:\"40141a1c-b108-4784-a53f-e3f40a04bb98\";a:10:{s:4:\"name\";s:17:\"Member Electorate\";s:6:\"handle\";s:16:\"memberElectorate\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\fields\\Entries\";s:8:\"settings\";a:7:{s:7:\"sources\";a:1:{i:0;s:44:\"section:254c0796-705e-4bfd-9225-6795c64d5a08\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;s:5:\"limit\";s:0:\"\";s:14:\"selectionLabel\";s:27:\"Select Members Electorate/s\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"6bd9bd98-62b5-4c53-b8a5-fbbe6b52cd4e\";}s:36:\"bb2e73c7-ac7d-4159-9534-abf0862093f1\";a:10:{s:4:\"name\";s:14:\"Voting History\";s:6:\"handle\";s:13:\"votingHistory\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:19:\"craft\\fields\\Matrix\";s:8:\"settings\";a:4:{s:9:\"minBlocks\";s:0:\"\";s:9:\"maxBlocks\";s:0:\"\";s:12:\"contentTable\";s:32:\"{{%matrixcontent_votinghistory}}\";s:14:\"localizeBlocks\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";s:36:\"6bd9bd98-62b5-4c53-b8a5-fbbe6b52cd4e\";}}s:7:\"volumes\";a:2:{s:36:\"501ef12a-77fa-4e7f-bf39-481aa9347b3e\";a:7:{s:4:\"name\";s:14:\"Profile Images\";s:6:\"handle\";s:13:\"profileImages\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:1;s:3:\"url\";s:22:\"/assets/profile_images\";s:8:\"settings\";a:1:{s:4:\"path\";s:31:\"@root/web/assets/profile_images\";}s:9:\"sortOrder\";i:1;}s:36:\"dc024a8d-d23f-4bd4-9d0c-d6b8f7c92b60\";a:7:{s:4:\"name\";s:11:\"Party Logos\";s:6:\"handle\";s:10:\"partyLogos\";s:4:\"type\";s:19:\"craft\\volumes\\Local\";s:7:\"hasUrls\";b:1;s:3:\"url\";s:19:\"/assets/party_logos\";s:8:\"settings\";a:1:{s:4:\"path\";s:28:\"@root/web/assets/party_logos\";}s:9:\"sortOrder\";i:2;}}s:16:\"matrixBlockTypes\";a:2:{s:36:\"0346a29b-9bc7-484b-9c5a-e39b11e174d7\";a:6:{s:5:\"field\";s:36:\"ae4b0a58-01d9-4024-b8e5-159a337cc1c8\";s:4:\"name\";s:18:\"Electorate Details\";s:6:\"handle\";s:17:\"electorateDetails\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"8d8d90fa-85be-49a1-abee-a08cd756f8ec\";a:10:{s:4:\"name\";s:6:\"Suburb\";s:6:\"handle\";s:6:\"suburb\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}s:36:\"1b30257a-b703-4806-b945-6c3833575a3b\";a:10:{s:4:\"name\";s:8:\"Postcode\";s:6:\"handle\";s:8:\"postcode\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:22:\"craft\\fields\\PlainText\";s:8:\"settings\";a:6:{s:11:\"placeholder\";s:0:\"\";s:4:\"code\";s:0:\"\";s:9:\"multiline\";s:0:\"\";s:11:\"initialRows\";s:1:\"4\";s:9:\"charLimit\";s:0:\"\";s:10:\"columnType\";s:4:\"text\";}s:17:\"contentColumnType\";s:4:\"text\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"e9243b94-f3a0-408c-9d23-04de67e92153\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"8d8d90fa-85be-49a1-abee-a08cd756f8ec\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:1;}s:36:\"1b30257a-b703-4806-b945-6c3833575a3b\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}s:36:\"d9975dcb-f695-4327-984e-934c2c07775c\";a:6:{s:5:\"field\";s:36:\"bb2e73c7-ac7d-4159-9534-abf0862093f1\";s:4:\"name\";s:5:\"Bills\";s:6:\"handle\";s:5:\"bills\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"6af810b0-e0a8-4c47-af9a-10193c213116\";a:10:{s:4:\"name\";s:10:\"Bill Title\";s:6:\"handle\";s:9:\"billTitle\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"site\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:20:\"craft\\fields\\Entries\";s:8:\"settings\";a:7:{s:7:\"sources\";a:1:{i:0;s:44:\"section:d807f805-e423-4005-a1b2-852d98a45fd9\";}s:6:\"source\";N;s:12:\"targetSiteId\";N;s:8:\"viewMode\";N;s:5:\"limit\";s:1:\"1\";s:14:\"selectionLabel\";s:10:\"Add a bill\";s:17:\"localizeRelations\";b:0;}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}s:36:\"5774752c-9f3e-4741-9dfe-6022ed164a25\";a:10:{s:4:\"name\";s:12:\"Member Voted\";s:6:\"handle\";s:11:\"memberVoted\";s:12:\"instructions\";s:0:\"\";s:10:\"searchable\";b:1;s:17:\"translationMethod\";s:4:\"none\";s:20:\"translationKeyFormat\";N;s:4:\"type\";s:25:\"craft\\fields\\RadioButtons\";s:8:\"settings\";a:1:{s:7:\"options\";a:2:{i:0;a:3:{s:5:\"label\";s:3:\"Yes\";s:5:\"value\";s:3:\"yes\";s:7:\"default\";s:0:\"\";}i:1;a:3:{s:5:\"label\";s:2:\"No\";s:5:\"value\";s:2:\"no\";s:7:\"default\";s:0:\"\";}}}s:17:\"contentColumnType\";s:6:\"string\";s:10:\"fieldGroup\";N;}}s:12:\"fieldLayouts\";a:1:{s:36:\"adbc81eb-f1d9-4c43-83a3-3acbbf46ad6a\";a:1:{s:4:\"tabs\";a:1:{i:0;a:3:{s:4:\"name\";s:7:\"Content\";s:9:\"sortOrder\";i:1;s:6:\"fields\";a:2:{s:36:\"6af810b0-e0a8-4c47-af9a-10193c213116\";a:2:{s:8:\"required\";b:1;s:9:\"sortOrder\";i:1;}s:36:\"5774752c-9f3e-4741-9dfe-6022ed164a25\";a:2:{s:8:\"required\";b:0;s:9:\"sortOrder\";i:2;}}}}}}}}}','[]','mSJoSViaxsCp','2019-06-21 06:37:38','2019-06-24 03:31:02','4d3d6f7e-00f2-46d0-ba59-9af52a173d59');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
INSERT INTO `matrixblocks` VALUES (6,5,NULL,11,1,1,NULL,'2019-06-22 10:34:50','2019-06-22 10:34:50','237af9f0-82e6-4498-83d7-df8507c1437a'),(7,5,NULL,11,1,2,NULL,'2019-06-22 10:34:50','2019-06-22 10:34:50','b23eab23-5e2f-49e8-87b2-f42379346e1a'),(8,3,NULL,15,2,1,NULL,'2019-06-24 00:23:46','2019-06-24 04:21:30','926d38dc-6dfe-4538-bdc8-2abb9a4267ed'),(9,3,NULL,15,2,2,0,'2019-06-24 04:20:07','2019-06-24 04:20:07','259a67b6-0613-4acd-8b68-13e956c71fab'),(11,3,NULL,15,2,2,NULL,'2019-06-24 04:21:30','2019-06-24 04:21:30','eb25088d-e6ab-419a-b526-5ce57dc63777');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
INSERT INTO `matrixblocktypes` VALUES (1,11,3,'Electorate Details','electorateDetails',1,'2019-06-22 10:33:24','2019-06-22 10:33:24','0346a29b-9bc7-484b-9c5a-e39b11e174d7'),(2,15,5,'Bills','bills',1,'2019-06-24 00:21:55','2019-06-24 00:26:38','d9975dcb-f695-4327-984e-934c2c07775c');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixcontent_electorateareas`
--

DROP TABLE IF EXISTS `matrixcontent_electorateareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `matrixcontent_electorateareas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_electorateDetails_suburb` text,
  `field_electorateDetails_postcode` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_electorateareas_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_electorateareas_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_electorateareas_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_electorateareas_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixcontent_electorateareas`
--

LOCK TABLES `matrixcontent_electorateareas` WRITE;
/*!40000 ALTER TABLE `matrixcontent_electorateareas` DISABLE KEYS */;
INSERT INTO `matrixcontent_electorateareas` VALUES (1,6,1,'2019-06-22 10:34:49','2019-06-22 10:34:49','69950662-bc20-430c-b1c1-9f244a56d05b','Aitkenvale','4810'),(2,7,1,'2019-06-22 10:34:50','2019-06-22 10:34:50','0b233b08-bb35-4ebb-b0e0-1c07aaa5101a','Belgian Gardens','4810');
/*!40000 ALTER TABLE `matrixcontent_electorateareas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixcontent_votinghistory`
--

DROP TABLE IF EXISTS `matrixcontent_votinghistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `matrixcontent_votinghistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_bills_memberVoted` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_votinghistory_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_votinghistory_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_votinghistory_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_votinghistory_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixcontent_votinghistory`
--

LOCK TABLES `matrixcontent_votinghistory` WRITE;
/*!40000 ALTER TABLE `matrixcontent_votinghistory` DISABLE KEYS */;
INSERT INTO `matrixcontent_votinghistory` VALUES (1,8,1,'2019-06-24 00:23:45','2019-06-24 04:21:30','3e432d71-1055-4b08-bce0-e87fe4028a80','no'),(2,9,1,'2019-06-24 04:20:07','2019-06-24 04:20:07','28e26274-5303-4dfa-aba6-b74032d428ed','yes'),(3,11,1,'2019-06-24 04:21:30','2019-06-24 04:21:30','f2098524-db3a-4adc-9434-0511cb9c1dde','yes');
/*!40000 ALTER TABLE `matrixcontent_votinghistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','330f3e11-5123-4360-83d3-a060c88de830'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','753a6938-c433-4c73-8059-730255aa00a5'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','30e1767e-c160-4ac9-820f-9f77a5ec8e09'),(4,NULL,'app','m150403_184533_field_version','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','921aec86-2269-47f5-ae52-507a64a9b8cc'),(5,NULL,'app','m150403_184729_type_columns','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','eff22a96-efa8-4533-aff8-212252f6cde0'),(6,NULL,'app','m150403_185142_volumes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','e01a9157-3a73-4c28-9991-85989b2eb663'),(7,NULL,'app','m150428_231346_userpreferences','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','b859a670-f393-4306-8b65-edd891691ff3'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','80e40406-477b-4800-8b7d-76dd081e7deb'),(9,NULL,'app','m150617_213829_update_email_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','43d71623-e19c-4b74-a0ac-49a0801db9cd'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','b8919406-908a-441a-8005-4f1aa5201756'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','a2a3eabc-f13c-4fdc-ae2f-c1b94116cd0b'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','01d8f455-4cf1-4b20-8808-a1e376d72a4d'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','94c368f7-14b4-4209-b77d-e04653105c9f'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','8e519c46-087f-4ea9-a122-8b17d0f864f8'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','a3cd0475-5b24-4227-b9d7-e9c6f239a050'),(16,NULL,'app','m151209_000000_move_logo','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','c9b1c566-a9d6-4a30-970d-1e1d755f27eb'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','01f13c28-0c68-432b-a502-3af57d82b350'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','80c44e76-91a1-4bc5-9cf0-2df04261a07a'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','b278a3d9-aa09-4d32-9c80-de65081c6220'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','f289f076-053c-4b2c-b7b8-d3a3a1c42bb8'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','310c6d93-147e-4e66-a09a-6b22ae054fa3'),(22,NULL,'app','m160727_194637_column_cleanup','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','89bac9ad-93e0-408a-8d7e-594d3200ac39'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','e1436ff3-6f59-44af-87cb-a290ea57cda6'),(24,NULL,'app','m160807_144858_sites','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','494aaab2-32b4-4525-aab7-345314b59ce0'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','33f8385d-f721-4115-add6-e965cadce985'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','b69ec472-9eb0-4d20-ab85-81a22ca5b58f'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','9d14447d-3ac4-4212-835b-536a763e227a'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','426a3937-882d-46d4-8840-bec2fda4e94a'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','bb1920b9-6f28-4175-9441-516ab26ddfd5'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','3ce55e48-bd54-49ed-bc92-cfc36dc22083'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','90f0c6fa-55f8-4f4d-aea0-3725595262f5'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','f1c48b7b-e463-42d1-bfc7-2e497029d94e'),(33,NULL,'app','m161007_130653_update_email_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','a4f4ed18-f17e-4354-85ff-29dc82fa7a77'),(34,NULL,'app','m161013_175052_newParentId','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','3a7859a0-7934-4830-9591-c6da970b3831'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','37a88d99-ab81-4cca-b182-317ef0bf58ed'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','6ba14b0a-ee1f-40cc-ac08-426262aff83f'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','4c428ede-9fb3-4470-b2d9-bfc5f75aeac5'),(38,NULL,'app','m161029_124145_email_message_languages','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','73ee8ce4-7ea6-42ea-a291-2d6cafcd6be6'),(39,NULL,'app','m161108_000000_new_version_format','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','9c0feeb1-2f82-49e0-a34a-ee0e46eb996d'),(40,NULL,'app','m161109_000000_index_shuffle','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','182bb5cb-22c9-4365-b380-267e436c5d98'),(41,NULL,'app','m161122_185500_no_craft_app','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','a6a1bda8-5b2d-4d2d-90a4-eea15f12669c'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','d15a045d-201d-4c1a-9686-f72e1f15ee1f'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','360436ba-bd4a-430b-9e07-ff22cd254941'),(44,NULL,'app','m170114_161144_udates_permission','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','e55d740e-51b1-4c21-aa59-033dc0ba0eb6'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','94e317f4-78db-4c60-b227-11c38bd59a65'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','1f797fcb-234b-4cb8-8225-94961ad6ba25'),(47,NULL,'app','m170206_142126_system_name','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','090b89d5-c1c9-458e-b0cd-1884dc4e471e'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','79b89e45-fe6a-4d0e-8ac9-4289fdbce20d'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','7f5927b3-07f1-4507-847b-69e8d341d9fe'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','4b025564-21d2-4059-b8e4-2ad03c300452'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','cdaff050-3fc2-406b-b355-768813cbb5ba'),(52,NULL,'app','m170228_171113_system_messages','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','68555b10-fc65-40e6-853e-267d0dc25e99'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','5017db28-1e93-4698-bd2d-5570d35eeade'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','272c7fac-db86-4949-91e8-1c27d8434cf2'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','2e9aab84-bdb7-47e2-98f1-b132b0b3d870'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','d107b963-ad4a-4fec-9d87-d034ecd64958'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','5c4131fd-02ad-4323-bcee-cc342408298c'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','dca2b9e7-d73e-4757-bfb2-c2767506dd07'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','76691517-6f6b-405e-b25f-a3b75474639c'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','9a11aeb8-c2e5-43c5-90c3-3ec7dce552ca'),(61,NULL,'app','m170704_134916_sites_tables','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','0c01c175-e8b2-44f9-84a6-240dcfa2eb07'),(62,NULL,'app','m170706_183216_rename_sequences','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','55259a79-a4ba-400f-8da4-d15fa1b63252'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','f4b10075-228a-47f7-9078-5a84f6d2c7b7'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','b33a8165-ec7c-4dd1-87e0-f708058870ad'),(65,NULL,'app','m170810_201318_create_queue_table','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','5130f523-3ae1-4922-8555-d71083b1a686'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','d9edc291-4dbc-4448-b447-28541825af0d'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','9100ba4a-eb14-47a9-9720-c8d45c921de6'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','af487b8b-8485-4b1d-be16-f82602766c37'),(69,NULL,'app','m171011_214115_site_groups','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','96d52a54-37c6-4c9a-a7c9-c1e3273255d3'),(70,NULL,'app','m171012_151440_primary_site','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','020a80b4-2706-459c-9489-7cbd990f62b1'),(71,NULL,'app','m171013_142500_transform_interlace','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','e9ee153e-3d51-44c8-9766-ab79713bdc1c'),(72,NULL,'app','m171016_092553_drop_position_select','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','43a2c5fb-a207-4b45-a0e1-52ef907631cf'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','3d4702af-3a4f-4f6e-8b98-de5edc8f0251'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','86450dab-1177-4e92-b140-862edfd1beb5'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','673dfe52-37f4-4a47-904b-6fc67fe843d0'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','fbb89374-c1aa-4921-b75f-3adb5ca3fdf7'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','1b7967ea-d17a-44eb-a055-b5b913763925'),(78,NULL,'app','m171202_004225_update_email_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','7b37b36a-823e-460f-9b2c-f54cd5bd2ea0'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','06e567c3-d4d8-411c-82f5-b4dc41f9b1b8'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','db687171-ca41-4227-8dde-dd0b89e3593c'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','421ace24-d0c2-484d-8181-e25b352225b9'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','611630bd-d6b7-4fda-8cfd-e3269f46c228'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','87a1a546-6a45-46e2-a464-5fee7f789e04'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','353af93e-ab78-4a2a-9d9b-83f10aaf6bf2'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','0e44a63b-fde7-42c7-8273-da3fcd38eb9d'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','2bf18958-e264-432e-9bc8-eaae5f1b5e46'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','48a518d3-9ccb-4de7-b802-724f1fb89495'),(88,NULL,'app','m180217_172123_tiny_ints','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','9dcd70cd-8292-459a-9072-5f618ce16fdd'),(89,NULL,'app','m180321_233505_small_ints','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','109c5845-e555-412a-9d95-92172af1f436'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','7646ebe7-1bc1-488c-bcea-f111b68bda20'),(91,NULL,'app','m180404_182320_edition_changes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','c6213bb0-00f6-402b-a3c8-e4165940036a'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','f74c7d8f-a5f6-4350-a177-38c73342d20c'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','78318649-f104-4107-a55b-3685bf1ba808'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','91f9b87f-a67b-44c5-9d62-4e7990641b7a'),(95,NULL,'app','m180425_203349_searchable_fields','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','c839a7eb-a248-43d1-91fe-fc72db8c9d61'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','999928cd-dc95-4e74-a4b6-dc257e93a8fc'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','17112bb1-896a-4871-bc6a-35eec5d822f5'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','c63490c1-b7d7-4f6c-ae54-d2775275f377'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','24f6a753-bb83-4412-bb07-3ed6d974e3a2'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','95ade10e-fbd9-44e9-a727-0fba0f51c24e'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','9f26a1f6-9c8d-4c3f-b7d8-b8cd48d1b38f'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','480dd59f-27fd-4bfc-a988-91c3e0ac727b'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','9bb2548b-071f-42ea-8238-c002daf9b4ac'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','dd82bd3a-9aec-4c41-8f5f-dbc45d63d05f'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','8cea2fe9-478e-4c35-aba1-276bbf722756'),(106,NULL,'app','m180904_112109_permission_changes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','b56c89d9-21c1-4c03-84f4-9d9e11fd7ea5'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','2afe64f1-26de-415a-9e80-a4079e0838fa'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','817b66e2-28d3-46fd-88b5-a4e96c445d8f'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','7fa39a04-de54-418b-a079-297934aabb08'),(110,NULL,'app','m181017_225222_system_config_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','a24f5160-0431-4d8f-a8e7-cd6b1b0dff11'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','86f6fdc7-110d-404f-a049-3399c3100128'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','53cfc608-af7b-4b10-af5b-38a3e13535be'),(113,NULL,'app','m181112_203955_sequences_table','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','83d6908a-cca3-46ab-bed1-cf093af50159'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','70d73071-817f-489c-a44d-dddbead70b0c'),(115,NULL,'app','m181128_193942_fix_project_config','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','15393a33-bfe6-42c1-901f-3489d9d7c28b'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','3ddfed04-cc23-4ff6-a518-1bba7d7c686a'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','ad26597b-c886-4f44-9845-901705074f41'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','bb1294a3-d54e-4505-9477-b6c3b9f58a71'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','a2778c3e-1e1e-4d81-967b-0169b8de7820'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','933ddc9f-2108-4b38-a766-8fabcb6f84d2'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','a562d022-04b2-4b1a-8107-122f2cd43f91'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','08c6309d-5c59-46a4-a454-c9fdad5bc33d'),(123,NULL,'app','m190109_172845_fix_colspan','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','dcdd163d-7eef-4b21-a501-a42ed73ec7f4'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','c4dbd02d-66d9-4094-bed2-7bd4990314c0'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','bd2846b8-0f52-4d44-805b-a5bebc8ff441'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','ec1232fc-01ea-4ec3-8fe2-2d322846a855'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','ab0b4318-7bfd-42ad-873d-ccabcbfd3ffb'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','4e085401-5a6a-48ea-adf5-b19d8fcd2a96'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','80d64e93-7924-47ab-a728-cc3d0c22801e'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','20a2f457-a908-49c8-b152-32c84dfe5af5'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','6e4f269c-cb56-49c3-ad6d-d9670f37a8a1'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','afbbd692-3128-4731-b586-c1fb6d317325'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','1147cb96-1359-4b19-814a-ee319f3fdf2f'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','b196f30e-64b6-47e2-b6df-25e61fe832c9'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','b0babe96-3de1-428a-96f8-be26292f8a1b'),(136,NULL,'app','m190401_223843_drop_old_indexes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','232de20d-4abc-4517-9fc8-8a9ca84d5ddb'),(137,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','256d3f41-015d-4896-be76-6a644de6cf6c'),(138,NULL,'app','m190502_122019_store_default_user_group_uid','2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-21 06:37:39','4bcd768f-f9ab-43fb-bab1-99627394f0f0');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES (1,'copy','1.0.0-RC5','1.0.0','unknown',NULL,'2019-06-21 10:52:27','2019-06-21 10:52:27','2019-06-23 10:12:38','5a22208b-a3c2-4f8e-8d59-52505b221787');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
INSERT INTO `relations` VALUES (20,16,9,NULL,4,1,'2019-06-24 04:20:07','2019-06-24 04:20:07','2c250eb9-13e1-44e2-95b5-64135e768dca'),(21,1,3,NULL,2,1,'2019-06-24 04:21:30','2019-06-24 04:21:30','8311e222-9504-4145-8a55-0267f20f30e3'),(22,3,3,NULL,2,1,'2019-06-24 04:21:30','2019-06-24 04:21:30','5bbaff8e-7188-44ec-a04d-0fac1b45de7d'),(23,14,3,NULL,5,1,'2019-06-24 04:21:30','2019-06-24 04:21:30','72b66e1b-2265-4330-ad26-cfcce0a8e83c'),(24,16,8,NULL,4,1,'2019-06-24 04:21:30','2019-06-24 04:21:30','53d99565-2207-4593-bd0c-b70389120a49'),(25,16,11,NULL,10,1,'2019-06-24 04:21:30','2019-06-24 04:21:30','fa467b9a-5b6b-4749-a9fb-3a57704d639e');
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
INSERT INTO `resourcepaths` VALUES ('197269b2','@app/web/assets/dashboard/dist'),('1a003277','@lib/fabric'),('1ac5fb9a','@craft/web/assets/fields/dist'),('2ab6d060','@lib/fileupload'),('322635e0','@craft/web/assets/matrix/dist'),('325ed19e','@lib/picturefill'),('32d749ef','@craft/web/assets/tablesettings/dist'),('35faed5c','@lib/jquery-touch-events'),('377ce7d5','@lib/prismjs'),('3afde199','@craft/web/assets/utilities/dist'),('3cfbf1cf','@lib/d3'),('44cb42ac','@craft/web/assets/recententries/dist'),('53b3e0e5','@lib/timepicker'),('600fd953','@craft/web/assets/cp/dist'),('6620fc1a','@lib/selectize'),('6c4cb890','@lib/xregexp'),('6d738285','@craft/web/assets/installer/dist'),('7a7100c2','@craft/web/assets/updateswidget/dist'),('7f835b06','@lib/datepicker-i18n'),('84410e28','@craft/web/assets/matrixsettings/dist'),('86de2ce1','@lib'),('916446ec','@lib/element-resize-detector'),('9b8bed44','@craft/web/assets/dashboard/dist'),('a3646c40','@app/web/assets/feed/dist'),('af7b1a64','@lib/velocity'),('b35cb58c','@lib/jquery.payment'),('bb2d2f44','@craft/web/assets/editentry/dist'),('bef4ed19','@bower/jquery/dist'),('c1476ad5','@app/web/assets/pluginstore/dist'),('c7320073','@app/web/assets/recententries/dist'),('d5db4106','@craft/web/assets/login/dist'),('da7f27fe','@app/web/assets/cp/dist'),('ddddf6cb','@craft/web/assets/craftsupport/dist'),('de413280','@app/web/assets/login/dist'),('e1d281c1','@lib/jquery-ui'),('e2c8cb8f','@craft/web/assets/feed/dist'),('ef8a0673','@app/web/assets/installer/dist'),('f46e649','@lib/garnishjs'),('f71aeedc','@app/web/assets/craftsupport/dist'),('f988421d','@app/web/assets/updateswidget/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' ryanmurrayemail gmail com '),(1,'slug',0,1,''),(2,'filename',0,1,' robot png '),(2,'extension',0,1,' png '),(2,'kind',0,1,' image '),(2,'slug',0,1,''),(2,'title',0,1,' robot '),(3,'field',1,1,' robot '),(3,'field',3,1,' robot '),(3,'field',2,1,' some party '),(3,'slug',0,1,' ryan murray '),(3,'title',0,1,' ryan murray '),(4,'field',6,1,' here is a description for this bill '),(4,'field',7,1,' carried '),(4,'field',8,1,' state '),(4,'field',9,1,' ryan murray '),(4,'field',10,1,' ryan murray '),(4,'slug',0,1,' a plebiscite on the carbon pricing system '),(4,'title',0,1,' a plebiscite on the carbon pricing system '),(5,'field',11,1,' 4810 aitkenvale 4810 belgian gardens '),(6,'field',12,1,' aitkenvale '),(6,'field',13,1,' 4810 '),(6,'slug',0,1,''),(7,'field',12,1,' belgian gardens '),(7,'field',13,1,' 4810 '),(7,'slug',0,1,''),(5,'slug',0,1,' herbert '),(5,'title',0,1,' herbert '),(3,'field',14,1,' herbert '),(3,'field',4,1,' 70 '),(3,'field',5,1,' 5 '),(8,'field',16,1,' a plebiscite on the carbon pricing system '),(8,'field',17,1,' no '),(8,'slug',0,1,''),(3,'field',15,1,' a plebiscite on the carbon pricing system no some new bill yes '),(9,'field',16,1,' a plebiscite on the carbon pricing system '),(9,'field',17,1,' yes '),(9,'slug',0,1,''),(10,'field',6,1,' here is the bill '),(10,'field',7,1,' carried '),(10,'field',8,1,' state '),(10,'slug',0,1,' some new bill '),(10,'title',0,1,' some new bill '),(11,'field',16,1,' some new bill '),(11,'field',17,1,' yes '),(11,'slug',0,1,'');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,NULL,'Members','members','channel',1,1,'2019-06-22 10:05:14','2019-06-24 03:31:02',NULL,'dff8813a-f89e-4ad3-a6f6-9c9770beffcb'),(2,NULL,'Bills','bills','channel',1,1,'2019-06-22 10:18:38','2019-06-22 10:24:39',NULL,'d807f805-e423-4005-a1b2-852d98a45fd9'),(3,NULL,'Electorates','electorates','channel',1,1,'2019-06-22 10:29:54','2019-06-22 10:33:55',NULL,'254c0796-705e-4bfd-9225-6795c64d5a08');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'members/{slug}','members/show',1,'2019-06-22 10:05:14','2019-06-24 03:31:02','1c1ee2bb-c434-410d-9a15-a01ec919cd3d'),(2,2,1,1,'bills/{slug}','',1,'2019-06-22 10:18:38','2019-06-22 10:24:39','2907aa1e-63b6-44e5-9336-6dc3e37cac9c'),(3,3,1,1,'electorates/{slug}','',1,'2019-06-22 10:29:54','2019-06-22 10:33:55','f6a97bd5-b3c8-4d5e-a0be-9894ceb6b1f1');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,1,'ExVX-vkuiZgzkAIUszvzvVO0ltyoMiy4fShPnVu6wIwUCDj_0VIlcJtd-guilkTSr1XRjN9136Ads-RxvlIKXs1X6p-1oNqJ9gMx','2019-06-21 06:37:58','2019-06-21 06:38:27','2fd14e50-8ef4-454e-a6d4-22281642e30b'),(2,1,'634uivKXNqBKeY6lmBrasLPj1P0SgMtvgnnK1qzaY_Mt1ftnZKKoarJ0kNOsUqyKDb0gXwufJmTHf7lR_4yL4xdM77CRoESeO0c1','2019-06-21 07:38:31','2019-06-21 07:38:31','f4bf36f7-0513-452a-984a-8a6c4b245ac6'),(3,1,'_Or_Borjlpm7VwAHuC9mQ9nGxTf7i8msiTb7-tkYtJpz0O-AnaN2vgW5HImL0cEh9RS8IArRnVbvvpXsmZPn_2hkAxL59K3zsJSo','2019-06-21 08:46:27','2019-06-21 08:46:27','0bff847c-6582-4373-8292-4925d523eba6'),(4,1,'Z5nSIyYI6lq76twYu-uFV-i20cjB3xh9rk_fg5PuDGwz105nHx-huH5tPJ8calzF0u3O6J6c9NtLQaoTVzkKf6vzfaFcLWjtE8w8','2019-06-21 09:46:31','2019-06-21 11:08:33','db002c68-c000-42de-afde-5722341a49ff'),(5,1,'7tKgRzA26xsCapsfxfd99c1yVexq9BYD80GuQu0OkWwSGdWS4Ck-4oXjPXoRZIWENMROoR-TKegsM5Hb0xa2hMt6cJRI0w55ALTa','2019-06-21 12:15:18','2019-06-21 12:15:18','7b737098-ad9a-400b-b973-c1ddb08448c5'),(6,1,'mhdNgJVfXycRC4aA_jrA5JeTm5ATdifWpCbpfFPOFiyED2HAvrGY60Rv3WqAoA9eN2Q4IoNMZPMRL_AFiPOfC3t55Z9oqqDOhMkt','2019-06-21 14:03:46','2019-06-21 14:03:46','5c2fc93c-e295-49ea-b0d6-541f74267a8b'),(7,1,'tDKHWegcTE6AGI56jN-XPJbxF9s-lHrD12imzwNriI_LF_gH3S6KzupAwq-oaiGpUSqxraUhjLwU0u5zdQvsme7bvfyMeZWX-hiv','2019-06-21 15:52:15','2019-06-21 15:52:15','067f3f71-8532-4231-a9c4-05d643c9bd02'),(8,1,'ndyM0-w3S3HFowXHaao4hBGpS0r4uMvIBCcQJPRcORTwCwXuzu2U-ijClrKaeOvQFDXFM93F14b0mUqnic5Mw-SMFo7__6FK7oDz','2019-06-21 22:53:57','2019-06-21 22:53:58','d2e4d510-bb2c-4c12-b9a9-fd9f81c29794'),(9,1,'tUF16ouK5CLfAnl0H3kfvMBImVdU6fNdmfl_jMhR-BO65X2cz30AyQx_-JyywpP2iZ0KR239fMGFnNViTxz81faRBRKBAQV8N3p_','2019-06-22 00:36:30','2019-06-22 00:36:30','bfe17401-2495-4d85-8e9c-65a8f68a0540'),(10,1,'jA87_VMXAFFfDhuV46BYvLVC_0ih-IT3vHZ8Gj8770wWN7j0t_nMm1KUIP_w-HqXpFOXBkfkEG0n0SAr9_AVzzdb2Ng1OZMqCx_5','2019-06-22 10:03:41','2019-06-22 10:39:37','4d80f179-1e04-4068-8fa0-1224466e58c9'),(11,1,'D30e0TjiYQp4p6428b5S8I6l9j4PV01yHfAfmoNeLTgK-yczdZgXVciEVrXzpRyLwIUURcdgbdrSqWLsedregR-bzdwu2yy3TOZa','2019-06-22 12:22:25','2019-06-22 12:22:25','be39b4de-644d-4ae2-a7a0-24a942f20359'),(12,1,'yTnYb4GRHzmoSNwAuxYvilAcBZ-vlxwE_0_5L1H6gYmM671Zowq8P48Nw8BNjw3a4drKBN3-ADIcqopk-hyvaDz7KN7qgQ2TsKiX','2019-06-22 14:10:53','2019-06-22 14:10:53','f0e1e30f-9930-4f6e-a8c5-98f1de5664a5'),(13,1,'coooiv71gZScdym89nLxSJw6-B0ERk2IIaNUTwnRQac6oYl4a1RHDE9In78GiAksJVHhMoPOrasNRSTsbqoXOMg2TN0cMrcNzxPY','2019-06-22 15:58:22','2019-06-22 15:58:22','a841db3e-5b05-40d9-9b6e-07b97fb31173'),(14,1,'9V_d7HEdopWFnxmd3PaqyWbSUYzTz5v6yzv05BB4AnTPmD5FL-xXprHpvf5cbeoyaU3suk98ofJweQZSK6wT7xXVm9IGNDJEd-6e','2019-06-22 17:18:11','2019-06-22 17:18:11','6d7e586a-2aac-4a7f-9592-d4fd5776ca3a'),(15,1,'D2RwpzZ7-5jHSTQkBAFoKuirvIgvwzecw-5g0pfiEatJH4HWkJvKYBccWkykSHceHQCS__Gxm8P6NiPnP8uA50ECJqmJDPaLpNMQ','2019-06-22 19:06:41','2019-06-22 19:06:41','4d05b620-c3c4-4c60-95d7-117bbedd4777'),(16,1,'XdQmFW91pA8Wlp8rTMBdhcXDZAlr7e5vvmDXngTxVDuR2yHqrEWXQrzkTZG0TchLNd5c4ec2w2tZ7L4YQ2rff7HVKPx7Vw6Wr1yX','2019-06-22 20:55:09','2019-06-22 20:55:09','9458f5ec-ea32-44d1-8028-05edb8aa74bc'),(17,1,'NUnIsxmNybHOowdDcdJOF69X7uMjMnxqkJWe7290jSkx0vDJfyPANSylVsf-AMWJTedAPfApE-Q-VI2g-8icJF8TX9ptd0asLcZG','2019-06-23 04:51:59','2019-06-23 04:51:59','3da6aade-e638-447c-a48c-02c8b4a80441'),(18,1,'90xme0zMpC-Y4g5BTEQAlyeQta69oNNjWpiwYNYMS-gRfBZaM47xokfcQ1XXUEVSKd6ch0GVoIVOhi3bMns-kmuCU8AZ5TLHRym9','2019-06-23 06:41:28','2019-06-23 06:41:28','622bcb60-cc98-44b9-a58a-08af05f4dc78'),(19,1,'j-CtucDXjATB86TiMJxN-r87SgNujIRY5tuh2zy1a5RNfeQ6U8HDiQaypoh6b4NilqbCFJtqqtsH7i7QLqS9-BooxXV51QL7uev9','2019-06-23 08:29:56','2019-06-23 08:29:56','94a365fc-0dd8-460c-a312-6b86f1c11876'),(20,1,'Rey5q866ZlHd0OKsMj6LyX9-ReS3NNC9SR2cRSwIj-TzS-pgcfGCYRizCxEFiVdnvl1jNd17RNm0RxCKTGb4DWx8SDxXD3AcDG_H','2019-06-23 09:30:00','2019-06-23 10:49:17','4465e78d-6947-47e9-8675-f11458c46ffb'),(21,1,'uQN-Z0iYDZ83kI9iJjAyETHZSSxa8i67qNI8S7qXKmf2S7PvCvsmPk2KW2VdtbztprAqKYx4XQqgHoKQZ9zvdY0NHgruUsq7jLv1','2019-06-24 00:12:55','2019-06-24 00:27:32','fd4f2c32-3990-41a4-96c0-439ca55d5776'),(22,1,'JcSKfE5xmjk90Vh8-euFAMzq1I77TU3hxkVSUSCruLnPR8ZwkgdOLSDBsyB9kv84HiuBMKyvTdGUxCh6lRVqmjaucjbxQ58vhYRz','2019-06-24 01:27:36','2019-06-24 01:27:36','6c61e042-b0f7-4133-aec2-50421722fdf8'),(23,1,'QlUno7eXkC9rJ8wWtDsD6__Ni04da_jLs0UiegWolN4YAfG7VvMxhbUPbAD-DZQ37a3yRE1WkGlf-bqLN9ssQ2qiGwVf5PAOFcng','2019-06-24 02:27:40','2019-06-24 07:11:58','d4fa4f83-5c2c-4f77-81c6-4ce49d9185cf'),(24,1,'Tb6h5nU8EmA3q9kpsc30X9XkYH9iWOiKk6UgD49_bvYuXYaCJG-juo0c02ckboDVEte3uFMIPFVOXKyZs6tLX8_ilWNZrmgmKwKi','2019-06-24 07:12:03','2019-06-24 07:12:09','4fa50152-dbb5-4bc1-93f3-097a7560318d'),(25,1,'vDKnR2xINc5qA8VGG0faQiuM-sMdO_rQHwTGj7qEPKBX4RqPx_UrBVkWkLPohjkJ6CdV8uskg5SmpsutLQQ_2k_8wUuWVedTsjJR','2019-06-24 08:56:12','2019-06-24 08:56:12','71b315c8-b95a-4c1d-b90d-eb9194750cd9'),(26,1,'bjqDW5pvM_Pgo-M-FTtbgj5uzdojzTaFh9XAQZF0yecHtNdhVMSyeDCjVb5jw4EP_hUC6HzmyCKQ0u6nk0-q8YvKLhC_Oofwcmsn','2019-06-24 10:06:05','2019-06-24 10:06:05','b95dc705-7f6d-48e8-a702-2f32a0e8ecec');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
INSERT INTO `sitegroups` VALUES (1,'CCIQ','2019-06-21 06:37:38','2019-06-21 06:37:38',NULL,'6832b384-de12-4112-9fa4-4204e69b4648');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,1,1,'CCIQ','default','en-US',1,'$DEFAULT_SITE_URL',1,'2019-06-21 06:37:38','2019-06-21 06:37:38',NULL,'a8c97652-0966-4e3c-a5db-9beefee1e028');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecacheelements`
--

LOCK TABLES `templatecacheelements` WRITE;
/*!40000 ALTER TABLE `templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecaches`
--

LOCK TABLES `templatecaches` WRITE;
/*!40000 ALTER TABLE `templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (2,'oWSmiumFmBELTArKl0WUy5JmY_aOurGp','[\"live-preview/preview\",{\"previewAction\":\"entries/preview-entry\",\"userId\":\"1\"}]',NULL,NULL,'2019-06-25 00:27:03','2019-06-24 00:27:03','2019-06-24 00:27:03','748bae33-79cd-4333-ac4c-df9f6cc584d1'),(3,'rjwFtRIIc2jX4O2W84WuL9L9QEyWQ6iz','[\"live-preview/preview\",{\"previewAction\":\"entries/preview-entry\",\"userId\":\"1\"}]',NULL,NULL,'2019-06-25 00:27:19','2019-06-24 00:27:19','2019-06-24 00:27:19','337a5032-b600-4885-a517-092b1cf0a761');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin',NULL,NULL,NULL,'ryanmurrayemail@gmail.com','$2y$13$REimD4WjiuGg92BI5l2OeO5Y2x8TPczicU2.9dqs9jFfnE.R/PIjG',1,0,0,0,'2019-06-24 10:06:05',NULL,NULL,NULL,'2019-06-23 04:49:50',NULL,1,NULL,NULL,NULL,0,'2019-06-21 06:37:39','2019-06-21 06:37:39','2019-06-24 10:06:05','079a6b22-ba08-4c49-b2de-418d4f344f53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Profile Images','','2019-06-22 10:10:03','2019-06-23 10:48:42','dc4976a6-9142-4844-a8ba-1c4cccb018f6'),(2,NULL,NULL,'Temporary source',NULL,'2019-06-22 10:13:53','2019-06-22 10:13:53','f25fb25d-7780-455f-af7a-f00891016163'),(3,2,NULL,'user_1','user_1/','2019-06-22 10:13:53','2019-06-22 10:13:53','96f75bc9-865e-4d3e-b130-6ba3c0e99584'),(4,NULL,2,'Party Logos','','2019-06-22 10:15:10','2019-06-23 10:49:00','cb16fba8-68ff-45dc-9782-bffc1b5945db');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
INSERT INTO `volumes` VALUES (1,NULL,'Profile Images','profileImages','craft\\volumes\\Local',1,'/assets/profile_images','{\"path\":\"@root/web/assets/profile_images\"}',1,'2019-06-22 10:10:03','2019-06-23 10:48:42',NULL,'501ef12a-77fa-4e7f-bf39-481aa9347b3e'),(2,NULL,'Party Logos','partyLogos','craft\\volumes\\Local',1,'/assets/party_logos','{\"path\":\"@root/web/assets/party_logos\"}',2,'2019-06-22 10:15:10','2019-06-23 10:49:00',NULL,'dc024a8d-d23f-4bd4-9d0c-d6b8f7c92b60');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-06-21 06:37:59','2019-06-21 06:37:59','3061a689-43fa-40bb-9909-f4c93b66f49c'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-06-21 06:37:59','2019-06-21 06:37:59','09203b47-08a3-42c5-86a3-c65e69ef6412'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-06-21 06:37:59','2019-06-21 06:37:59','6018a2f1-50cc-443f-b71e-30247397eaee'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-06-21 06:37:59','2019-06-21 06:37:59','061966ae-0cf6-4aa6-88a3-44e0bf1b1953');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-24 20:58:41
