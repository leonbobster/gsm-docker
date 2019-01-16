# ************************************************************
# Sequel Pro SQL dump
# Version 5189
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: publisher
# Generation Time: 2017-05-12 16:39:15 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table a_all_product_phrases
# ------------------------------------------------------------

DROP TABLE IF EXISTS `a_all_product_phrases`;

CREATE TABLE `a_all_product_phrases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revisionId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `englishPhrase` mediumtext NOT NULL,
  `pmId` int(11) DEFAULT NULL,
  `domainId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`),
  KEY `productId` (`productId`),
  CONSTRAINT `a_all_product_phrases_ibfk_1` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `a_all_product_phrases_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table a_tmp_id_mapping
# ------------------------------------------------------------

DROP TABLE IF EXISTS `a_tmp_id_mapping`;

CREATE TABLE `a_tmp_id_mapping` (
  `old_id` varchar(32) NOT NULL,
  `new_id` varchar(32) NOT NULL,
  `type` enum('MANUFACTURER','SUPPLIER','EC','CCM','CPM','CHM','PM','REVISION','HF','PARENT','KIT') NOT NULL,
  PRIMARY KEY (`old_id`,`new_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table a_translated_product_phrases
# ------------------------------------------------------------

DROP TABLE IF EXISTS `a_translated_product_phrases`;

CREATE TABLE `a_translated_product_phrases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `englishPhraseId` int(11) NOT NULL,
  `languageIso` varchar(10) NOT NULL,
  `translation` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `englishPhraseId` (`englishPhraseId`),
  CONSTRAINT `a_translated_product_phrases_ibfk_1` FOREIGN KEY (`englishPhraseId`) REFERENCES `a_all_product_phrases` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table as_binder
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_binder`;

CREATE TABLE `as_binder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `autosdsTrackingNumber` char(11) NOT NULL,
  `createdUserId` int(11) NOT NULL,
  `createdUserType` int(10) NOT NULL,
  `createdDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `accountNumber` varchar(255) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `isBinderMailed` int(1) DEFAULT NULL,
  `carrierOptions` int(3) DEFAULT NULL,
  `trackingNumber` varchar(15) DEFAULT NULL,
  `isSentElectronically` int(1) DEFAULT NULL,
  `receivedDate` datetime DEFAULT NULL,
  `receivedUserId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table as_cached_client_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_cached_client_product`;

CREATE TABLE `as_cached_client_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clientAccountNumber` varchar(50) NOT NULL,
  `productOuterId` varchar(100) NOT NULL,
  `processed` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table as_client
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_client`;

CREATE TABLE `as_client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resellerId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `hash` varchar(50) NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modifiedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `contactName` varchar(255) NOT NULL COMMENT 'Primary contact name',
  `contactPhone` varchar(100) NOT NULL,
  `contactEmail` varchar(255) NOT NULL,
  `accountNumber` varchar(50) NOT NULL COMMENT 'Reseller account number',
  `advantageProgramStatus` enum('no','yes') NOT NULL,
  `geography` enum('US','CAN') NOT NULL,
  `branchNumber` varchar(50) NOT NULL,
  `branchName` varchar(255) NOT NULL,
  `territory` varchar(255) NOT NULL,
  `salesRepContactName` varchar(100) NOT NULL,
  `salesRepContactEmail` varchar(100) NOT NULL,
  `dateInvitationSent` datetime DEFAULT NULL,
  `accountStatus` tinyint(4) NOT NULL DEFAULT '1',
  `accountStatusDate` datetime NOT NULL,
  `clientSourceTypeId` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `demo` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Account using for demo',
  `typeOfPractice` int(10) unsigned NOT NULL DEFAULT '1',
  `parentId` int(11) DEFAULT NULL,
  `billingCycle` enum('monthly','annually') NOT NULL DEFAULT 'monthly',
  `typeOfBilling` enum('central','location') DEFAULT 'location',
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash` (`hash`),
  UNIQUE KEY `accountNumber` (`accountNumber`),
  KEY `resellerId` (`resellerId`),
  KEY `fk_ParentId` (`parentId`),
  CONSTRAINT `as_client_ibfk_1` FOREIGN KEY (`resellerId`) REFERENCES `as_reseller` (`id`),
  CONSTRAINT `fk_ParentId` FOREIGN KEY (`parentId`) REFERENCES `as_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='AutoSDS clients';



# Dump of table as_client_free_request
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_client_free_request`;

CREATE TABLE `as_client_free_request` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `number` int(11) NOT NULL DEFAULT '1',
  `date` date NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Stores increment/decrement log';



# Dump of table as_client_productid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_client_productid`;

CREATE TABLE `as_client_productid` (
  `sdsProductId` int(11) NOT NULL COMMENT 'link to as_sds_productid table',
  `clientId` int(11) NOT NULL COMMENT 'link to as_client table',
  PRIMARY KEY (`sdsProductId`,`clientId`),
  KEY `sdsProductId` (`sdsProductId`),
  KEY `clientId` (`clientId`),
  CONSTRAINT `as_client_productid_ibfk_1` FOREIGN KEY (`sdsProductId`) REFERENCES `as_sds_productid` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `as_client_productid_ibfk_2` FOREIGN KEY (`clientId`) REFERENCES `as_client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Product ids for client';



# Dump of table as_client_productid_copy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_client_productid_copy`;

CREATE TABLE `as_client_productid_copy` (
  `sdsProductId` int(11) NOT NULL COMMENT 'link to as_sds_productid table',
  `clientId` int(11) NOT NULL COMMENT 'link to as_client table',
  PRIMARY KEY (`sdsProductId`,`clientId`),
  KEY `sdsProductId` (`sdsProductId`),
  KEY `clientId` (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Product ids for client';



# Dump of table as_client_productid_orig
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_client_productid_orig`;

CREATE TABLE `as_client_productid_orig` (
  `sdsProductId` int(11) NOT NULL COMMENT 'link to as_sds_productid table',
  `clientId` int(11) NOT NULL COMMENT 'link to as_client table',
  PRIMARY KEY (`sdsProductId`,`clientId`),
  KEY `sdsProductId` (`sdsProductId`),
  KEY `clientId` (`clientId`),
  CONSTRAINT `as_client_productid_orig_ibfk_1` FOREIGN KEY (`sdsProductId`) REFERENCES `as_sds_productid_orig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `as_client_productid_orig_ibfk_2` FOREIGN KEY (`clientId`) REFERENCES `as_client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Product ids for client';



# Dump of table as_client_promotion
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_client_promotion`;

CREATE TABLE `as_client_promotion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `promotionId` int(11) unsigned NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ClientId` (`clientId`),
  KEY `promotionId` (`promotionId`),
  CONSTRAINT `fk_ClientId` FOREIGN KEY (`clientId`) REFERENCES `as_client` (`id`),
  CONSTRAINT `fk_PromotionId` FOREIGN KEY (`promotionId`) REFERENCES `as_promotion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table as_client_sds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_client_sds`;

CREATE TABLE `as_client_sds` (
  `clientId` int(11) NOT NULL,
  `sdsId` int(11) NOT NULL,
  `assignTs` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `source` enum('csv','ui') NOT NULL DEFAULT 'ui' COMMENT 'If SDS assigned using CSV or manually by client admin',
  UNIQUE KEY `clientId` (`clientId`,`sdsId`),
  KEY `source` (`source`),
  KEY `sdsId` (`sdsId`),
  CONSTRAINT `as_client_sds_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `as_client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='SDS to AutoSDS client relation';



# Dump of table as_client_sds_copy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_client_sds_copy`;

CREATE TABLE `as_client_sds_copy` (
  `clientId` int(11) NOT NULL,
  `sdsId` int(11) NOT NULL,
  `assignTs` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `source` enum('csv','ui') NOT NULL DEFAULT 'ui' COMMENT 'If SDS assigned using CSV or manually by client admin',
  UNIQUE KEY `clientId` (`clientId`,`sdsId`),
  KEY `source` (`source`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='SDS to AutoSDS client relation';



# Dump of table as_client_source
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_client_source`;

CREATE TABLE `as_client_source` (
  `id` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table as_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_config`;

CREATE TABLE `as_config` (
  `section` varchar(100) NOT NULL,
  `key` varchar(100) NOT NULL,
  `val` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`section`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table as_dict_billing_cycle
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_dict_billing_cycle`;

CREATE TABLE `as_dict_billing_cycle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table as_dict_billing_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_dict_billing_type`;

CREATE TABLE `as_dict_billing_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table as_dict_client_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_dict_client_type`;

CREATE TABLE `as_dict_client_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table as_intake_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_intake_history`;

CREATE TABLE `as_intake_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `intakeListId` int(11) NOT NULL,
  `objectId` int(11) DEFAULT NULL,
  `objectType` enum('ACCOUNT','PRODUCT') NOT NULL,
  `description` varchar(2056) DEFAULT NULL,
  `accountNumber` varchar(50) DEFAULT NULL,
  `runDate` datetime NOT NULL,
  `status` enum('INFO','ERROR','OK') NOT NULL DEFAULT 'OK',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table as_intake_list
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_intake_list`;

CREATE TABLE `as_intake_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `intakeDate` date NOT NULL,
  `lastRunDate` datetime DEFAULT NULL,
  `status` enum('INFO','SUCCESS','ERROR') NOT NULL DEFAULT 'INFO',
  `progress` enum('in_progress','finished') CHARACTER SET utf8 NOT NULL DEFAULT 'finished',
  PRIMARY KEY (`id`),
  UNIQUE KEY `intakeDate` (`intakeDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table as_promotion
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_promotion`;

CREATE TABLE `as_promotion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `validFrom` date DEFAULT NULL,
  `validTo` date DEFAULT NULL,
  `chargeSetupFee` tinyint(2) DEFAULT '1',
  `freeMonths` int(10) unsigned NOT NULL DEFAULT '0',
  `freeBinders` int(10) unsigned NOT NULL DEFAULT '0',
  `freeSDSRequests` int(10) unsigned NOT NULL DEFAULT '0',
  `billingCycles` int(10) unsigned NOT NULL DEFAULT '1',
  `promotionMessage` varchar(1024) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table as_reseller
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_reseller`;

CREATE TABLE `as_reseller` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL DEFAULT '' COMMENT 'ALWAYS use "default" as value for Click!SDS profile',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='AutoSDS resellers';



# Dump of table as_reseller_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_reseller_profile`;

CREATE TABLE `as_reseller_profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resellerId` int(11) NOT NULL,
  `key` varchar(255) NOT NULL DEFAULT '',
  `val` blob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_resellerId_unique` (`key`,`resellerId`),
  KEY `resellerId` (`resellerId`),
  CONSTRAINT `reseller_profile_ibfk_1` FOREIGN KEY (`resellerId`) REFERENCES `as_reseller` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table as_reseller_profile_origin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_reseller_profile_origin`;

CREATE TABLE `as_reseller_profile_origin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resellerId` int(11) NOT NULL,
  `key` varchar(255) NOT NULL DEFAULT '',
  `val` blob,
  PRIMARY KEY (`id`),
  KEY `resellerId` (`resellerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table as_sds_extra
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_sds_extra`;

CREATE TABLE `as_sds_extra` (
  `clientId` int(11) NOT NULL,
  `sdsId` int(11) NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY (`clientId`,`sdsId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Client-specific extra data for SDS';



# Dump of table as_sds_productid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_sds_productid`;

CREATE TABLE `as_sds_productid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sdsId` int(11) NOT NULL,
  `outerId` varchar(100) NOT NULL,
  `resellerId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sdsId_2` (`sdsId`,`outerId`,`resellerId`),
  KEY `sdsId` (`sdsId`),
  KEY `resellerId` (`resellerId`),
  KEY `outerId` (`outerId`),
  CONSTRAINT `as_sds_productid_ibfk_1` FOREIGN KEY (`resellerId`) REFERENCES `as_reseller` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Reseller ids assigned to SDS';



# Dump of table as_sds_productid_copy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_sds_productid_copy`;

CREATE TABLE `as_sds_productid_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sdsId` int(11) NOT NULL,
  `outerId` varchar(100) NOT NULL,
  `resellerId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sdsId_2` (`sdsId`,`outerId`,`resellerId`),
  KEY `sdsId` (`sdsId`),
  KEY `resellerId` (`resellerId`),
  KEY `outerId` (`outerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Reseller ids assigned to SDS';



# Dump of table as_sds_productid_copy_new
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_sds_productid_copy_new`;

CREATE TABLE `as_sds_productid_copy_new` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sdsId` int(11) NOT NULL,
  `outerId` varchar(100) NOT NULL,
  `resellerId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sdsId_2` (`sdsId`,`outerId`,`resellerId`),
  KEY `sdsId` (`sdsId`),
  KEY `resellerId` (`resellerId`),
  KEY `outerId` (`outerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Reseller ids assigned to SDS';



# Dump of table as_sds_productid_old
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_sds_productid_old`;

CREATE TABLE `as_sds_productid_old` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sdsId` int(11) NOT NULL,
  `outerId` varchar(100) NOT NULL,
  `resellerId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sdsId_2` (`sdsId`,`outerId`,`resellerId`),
  KEY `sdsId` (`sdsId`),
  KEY `resellerId` (`resellerId`),
  KEY `outerId` (`outerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Reseller ids assigned to SDS';



# Dump of table as_sds_productid_orig
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_sds_productid_orig`;

CREATE TABLE `as_sds_productid_orig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sdsId` int(11) NOT NULL,
  `outerId` varchar(100) NOT NULL,
  `resellerId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sdsId_2` (`sdsId`,`outerId`,`resellerId`),
  KEY `sdsId` (`sdsId`),
  KEY `resellerId` (`resellerId`),
  KEY `outerId` (`outerId`),
  CONSTRAINT `as_sds_productid_orig_ibfk_1` FOREIGN KEY (`resellerId`) REFERENCES `as_reseller` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Reseller ids assigned to SDS';



# Dump of table as_sds_request
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_sds_request`;

CREATE TABLE `as_sds_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `autosdsTrackingNumber` char(11) NOT NULL,
  `createdDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `clientId` int(11) NOT NULL,
  `body` text NOT NULL COMMENT 'Request text',
  `status` enum('pending','finished','declined') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `clientId` (`clientId`),
  CONSTRAINT `as_sds_request_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `as_client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='SDS creation requests';



# Dump of table as_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_user`;

CREATE TABLE `as_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pwd` varchar(64) NOT NULL COMMENT 'password',
  `salt` varchar(32) NOT NULL COMMENT 'salt',
  `invitationDate` datetime DEFAULT NULL COMMENT 'Date when invitation mail sent',
  `active` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'User finished registration process',
  `accountAdmin` int(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL COMMENT 'name of user',
  `acceptedToU` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Acceptance of Terms of Use',
  `user_type_id` int(10) unsigned NOT NULL DEFAULT '100',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ClientID_Email` (`clientId`,`email`),
  KEY `as_user_ibfk_2` (`user_type_id`),
  KEY `clientId` (`clientId`),
  CONSTRAINT `as_user_ibfk_2` FOREIGN KEY (`user_type_id`) REFERENCES `as_user_type` (`user_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='AutoSDS client users';



# Dump of table as_user_invitation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_user_invitation`;

CREATE TABLE `as_user_invitation` (
  `userInvitationId` int(11) NOT NULL AUTO_INCREMENT,
  `creationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `uniqueHash` varchar(100) NOT NULL,
  `userId` int(11) NOT NULL,
  `consumed` int(1) NOT NULL DEFAULT '0',
  `active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`userInvitationId`,`uniqueHash`),
  UNIQUE KEY `userInvitationId_UNIQUE` (`userInvitationId`),
  UNIQUE KEY `uniqueHash_UNIQUE` (`uniqueHash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Registration invitations';



# Dump of table as_user_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `as_user_type`;

CREATE TABLE `as_user_type` (
  `user_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table async_process
# ------------------------------------------------------------

DROP TABLE IF EXISTS `async_process`;

CREATE TABLE `async_process` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `process_id` varchar(255) DEFAULT NULL,
  `processed` tinyint(1) DEFAULT '0',
  `data` json DEFAULT NULL,
  `started_dt` datetime DEFAULT CURRENT_TIMESTAMP,
  `finished_dt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table attribute_template_settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attribute_template_settings`;

CREATE TABLE `attribute_template_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL DEFAULT '',
  `render` enum('0','1') NOT NULL DEFAULT '1',
  `context_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_context_id` (`key`,`context_id`),
  KEY `context_id` (`context_id`),
  CONSTRAINT `attribute_template_settings_ibfk_3` FOREIGN KEY (`context_id`) REFERENCES `documenttypetemplate` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table batchdefile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `batchdefile`;

CREATE TABLE `batchdefile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zipId` int(11) NOT NULL COMMENT 'Id of zip batch file',
  `unzipDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date of unzip operation',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT 'Original file name',
  `storageName` varchar(40) CHARACTER SET utf8 NOT NULL COMMENT ' file name on S3 storage',
  `msdsTypeId` smallint(6) DEFAULT NULL COMMENT 'Default MSDS type',
  `languageId` smallint(6) DEFAULT NULL COMMENT 'Language',
  `trackingId` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Tracking id',
  `status` enum('unzipped','mapped','processed','error') CHARACTER SET utf8 NOT NULL,
  `msdsId` int(11) DEFAULT NULL COMMENT 'MSDS id',
  `clientId` int(11) DEFAULT NULL COMMENT 'Submitting client id',
  `effectiveDate` date DEFAULT NULL COMMENT 'Effective date',
  PRIMARY KEY (`id`),
  KEY `zipId` (`zipId`),
  KEY `processed` (`status`),
  CONSTRAINT `batchdefile_ibfk_1` FOREIGN KEY (`zipId`) REFERENCES `batchdezip` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Unzipped files';



# Dump of table batchdezip
# ------------------------------------------------------------

DROP TABLE IF EXISTS `batchdezip`;

CREATE TABLE `batchdezip` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id ',
  `name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT 'Original zip name',
  `uploadDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date of upload',
  `userId` int(11) NOT NULL COMMENT 'User id',
  `storageName` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT 'Name on storage',
  `msdsTypeId` smallint(6) DEFAULT NULL COMMENT 'Default MSDS type',
  `languageId` smallint(6) DEFAULT NULL COMMENT 'Default language',
  `trackingId` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Default tracking id',
  `status` enum('uploaded','processed','error') CHARACTER SET utf8 NOT NULL DEFAULT 'uploaded' COMMENT 'Status',
  `clientId` int(11) DEFAULT NULL COMMENT 'Submitting client id',
  `notificationEmail` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `effectiveDate` date DEFAULT NULL COMMENT 'Effective date',
  PRIMARY KEY (`id`),
  KEY `processed` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Uploaded zips for batch data entry';



# Dump of table bucket
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bucket`;

CREATE TABLE `bucket` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `userId` int(10) unsigned NOT NULL DEFAULT '0',
  `createdDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bucketmsds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bucketmsds`;

CREATE TABLE `bucketmsds` (
  `bucketId` int(10) unsigned NOT NULL DEFAULT '0',
  `msdsId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bucketId`,`msdsId`),
  CONSTRAINT `bucketId` FOREIGN KEY (`bucketId`) REFERENCES `bucket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bulk_translation_phrase
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bulk_translation_phrase`;

CREATE TABLE `bulk_translation_phrase` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `guid` varchar(36) NOT NULL DEFAULT '',
  `phrase` text,
  `md5` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `guid` (`guid`,`md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bulktranslation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bulktranslation`;

CREATE TABLE `bulktranslation` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `languageId` int(10) unsigned NOT NULL,
  `uploadDate` datetime NOT NULL,
  `rowCount` int(11) NOT NULL DEFAULT '0',
  `category` varchar(25) DEFAULT NULL,
  `status` tinyint(2) NOT NULL DEFAULT '0',
  `files` varchar(200) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table change_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `change_logs`;

CREATE TABLE `change_logs` (
  `change_log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `change_log_dt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `type_change_id` int(10) unsigned NOT NULL DEFAULT '0',
  `change_details` varchar(255) NOT NULL DEFAULT '',
  `msds_id` int(10) unsigned NOT NULL DEFAULT '0',
  `client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `location_id` int(10) unsigned NOT NULL DEFAULT '0',
  `new_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`change_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table client_component_masters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client_component_masters`;

CREATE TABLE `client_component_masters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(11) unsigned NOT NULL,
  `legacyId` varchar(255) DEFAULT NULL,
  `legacyParentId` varchar(255) DEFAULT NULL,
  `domainId` int(11) NOT NULL,
  `name` varchar(500) NOT NULL,
  `componentType` enum('supplier','governmental') NOT NULL,
  `source` varchar(255) NOT NULL,
  `productId` varchar(100) DEFAULT NULL,
  `gsmId` varchar(100) DEFAULT NULL,
  `cas` varchar(100) NOT NULL,
  `effectiveDate` date NOT NULL,
  `jsonData` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`domainId`,`componentType`,`source`,`cas`),
  UNIQUE KEY `domainId_2` (`domainId`,`parentId`),
  UNIQUE KEY `legacyId` (`legacyId`),
  KEY `domainId` (`domainId`),
  KEY `parentId` (`parentId`),
  KEY `legacyParentId` (`legacyParentId`),
  CONSTRAINT `client_component_masters_ibfk_1` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `client_component_masters_ibfk_2` FOREIGN KEY (`parentId`) REFERENCES `component_masters` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `client_component_masters_ibfk_3` FOREIGN KEY (`legacyParentId`) REFERENCES `component_masters` (`legacyId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table client_health_masters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client_health_masters`;

CREATE TABLE `client_health_masters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(11) unsigned NOT NULL,
  `legacyId` varchar(255) DEFAULT NULL,
  `legacyParentId` varchar(255) DEFAULT NULL,
  `domainId` int(11) NOT NULL,
  `name` varchar(500) NOT NULL,
  `effectiveDate` date NOT NULL,
  `jsonData` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`domainId`),
  UNIQUE KEY `legacy_id` (`legacyId`),
  KEY `parent_id` (`parentId`),
  KEY `legacy_parent_id` (`legacyParentId`),
  KEY `domain_id` (`domainId`),
  CONSTRAINT `client_health_masters_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `health_masters` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `client_health_masters_ibfk_2` FOREIGN KEY (`legacyParentId`) REFERENCES `health_masters` (`legacyId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `client_health_masters_ibfk_3` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table client_languages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client_languages`;

CREATE TABLE `client_languages` (
  `client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `language_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_id`,`language_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table client_msds_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client_msds_type`;

CREATE TABLE `client_msds_type` (
  `client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_id`,`msds_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table client_physical_masters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client_physical_masters`;

CREATE TABLE `client_physical_masters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parentId` int(11) unsigned NOT NULL,
  `legacyId` varchar(255) DEFAULT NULL,
  `legacyParentId` varchar(255) DEFAULT NULL,
  `domainId` int(11) NOT NULL,
  `name` varchar(500) NOT NULL,
  `effectiveDate` date NOT NULL,
  `jsonData` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`domainId`),
  UNIQUE KEY `legacy_id` (`legacyId`),
  KEY `parent_id` (`parentId`),
  KEY `legacy_parent_id` (`legacyParentId`),
  KEY `domain_id` (`domainId`),
  CONSTRAINT `client_physical_masters_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `physical_masters` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `client_physical_masters_ibfk_2` FOREIGN KEY (`legacyParentId`) REFERENCES `physical_masters` (`legacyId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `client_physical_masters_ibfk_3` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table client_reports
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client_reports`;

CREATE TABLE `client_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  `report_name` varchar(64) NOT NULL,
  `report_fields` text NOT NULL,
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `report_name_2` (`report_name`),
  KEY `client_id` (`client_id`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table clients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clients`;

CREATE TABLE `clients` (
  `client_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_name` varchar(80) NOT NULL DEFAULT '',
  `client_contact_first_name` varchar(80) NOT NULL DEFAULT '',
  `client_contact_last_name` varchar(80) NOT NULL DEFAULT '',
  `client_phone` varchar(80) NOT NULL DEFAULT '',
  `client_email` varchar(80) NOT NULL DEFAULT '',
  `client_street` varchar(80) NOT NULL DEFAULT '',
  `client_city` varchar(80) NOT NULL DEFAULT '',
  `client_state` varchar(80) NOT NULL DEFAULT '',
  `client_country` varchar(80) NOT NULL DEFAULT '',
  `client_zip_code` varchar(80) NOT NULL DEFAULT '',
  `gsm_admin_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `client_url` varchar(32) NOT NULL DEFAULT '',
  `client_status_flag` tinyint(1) NOT NULL DEFAULT '0',
  `add_msds_records_flag` tinyint(1) NOT NULL DEFAULT '0',
  `hide_old_docs_flag` tinyint(1) NOT NULL DEFAULT '0',
  `show_doc_start_date` date DEFAULT NULL,
  `show_doc_finish_date` date DEFAULT NULL,
  `regulatory_reporting_flag` tinyint(1) NOT NULL DEFAULT '0',
  `next_location_client_id` int(10) unsigned NOT NULL DEFAULT '1',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table component_masters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `component_masters`;

CREATE TABLE `component_masters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `legacyId` varchar(255) DEFAULT NULL,
  `name` varchar(500) NOT NULL,
  `componentType` enum('supplier','governmental') NOT NULL,
  `source` varchar(255) NOT NULL,
  `productId` varchar(100) DEFAULT NULL,
  `gsmId` varchar(100) DEFAULT NULL,
  `cas` varchar(100) NOT NULL,
  `effectiveDate` date NOT NULL,
  `jsonData` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`componentType`,`source`,`cas`),
  UNIQUE KEY `legacyId` (`legacyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cpsynctrack
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cpsynctrack`;

CREATE TABLE `cpsynctrack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sdsId` int(11) NOT NULL COMMENT 'id of SDS',
  `finishTime` datetime NOT NULL,
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('started','finished') NOT NULL DEFAULT 'started',
  `hasError` tinyint(4) DEFAULT NULL,
  `errorText` text,
  `source` enum('admin','api') NOT NULL DEFAULT 'admin' COMMENT 'Source',
  `taskResponse` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sdsId` (`sdsId`),
  CONSTRAINT `cpsynctrack_ibfk_1` FOREIGN KEY (`sdsId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='CP sync tracking';



# Dump of table cronexec
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cronexec`;

CREATE TABLE `cronexec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `startTs` datetime NOT NULL COMMENT 'start timestamp',
  `finishTs` datetime NOT NULL COMMENT 'finish timestamp',
  `log` mediumtext COLLATE utf8_unicode_ci NOT NULL COMMENT 'Plain log',
  `internalErrors` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Our script errors',
  `hasErrors` tinyint(1) NOT NULL,
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  `json` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'JSONs returned',
  `apiErrors` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Client API Errors',
  `testing` tinyint(4) NOT NULL COMMENT 'Integration testing worker',
  `processedNum` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='php script executions';



# Dump of table croninvocation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `croninvocation`;

CREATE TABLE `croninvocation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='cron daemon invocations';



# Dump of table cronsds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cronsds`;

CREATE TABLE `cronsds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `execId` int(11) NOT NULL COMMENT 'cron execution id',
  `childId` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Child SDS outer id',
  `status` enum('new','old') COLLATE utf8_unicode_ci NOT NULL COMMENT 'processing status',
  `parentId` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Parent SDS outer Id',
  `revisionId` int(11) DEFAULT NULL COMMENT 'Id of revision created/updated',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='SDS processed by cron script';



# Dump of table curlprofiling
# ------------------------------------------------------------

DROP TABLE IF EXISTS `curlprofiling`;

CREATE TABLE `curlprofiling` (
  `execId` int(11) NOT NULL,
  `count` int(11) NOT NULL COMMENT 'count of curl invokations',
  `errorText` text,
  `startTs` datetime NOT NULL COMMENT 'Start of non-error loop',
  `finishTs` datetime NOT NULL COMMENT 'Finish of non-error loop',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `execId` (`execId`),
  CONSTRAINT `curlprofiling_ibfk_1` FOREIGN KEY (`execId`) REFERENCES `cronexec` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table custom_error_message
# ------------------------------------------------------------

DROP TABLE IF EXISTS `custom_error_message`;

CREATE TABLE `custom_error_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `msds_id` int(11) unsigned NOT NULL,
  `client_id` int(11) unsigned NOT NULL,
  `message` text CHARACTER SET utf8,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id__msds_id__unique` (`msds_id`,`client_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `custom_error_message_ibfk_1` FOREIGN KEY (`msds_id`) REFERENCES `msds` (`msds_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `custom_error_message_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table delme_clid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `delme_clid`;

CREATE TABLE `delme_clid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `location_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table deptconvert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deptconvert`;

CREATE TABLE `deptconvert` (
  `department_id` int(11) DEFAULT NULL,
  `department_name` varchar(80) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `location_max_num_msds` int(11) DEFAULT NULL,
  `location_status_flag` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `location_client_id` int(11) DEFAULT NULL,
  `location_url` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table dict_countries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dict_countries`;

CREATE TABLE `dict_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `iso` char(2) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `priority` (`priority`),
  KEY `priority_2` (`priority`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dict_ghs_label_element
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dict_ghs_label_element`;

CREATE TABLE `dict_ghs_label_element` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `symbol` char(12) NOT NULL DEFAULT '',
  `signalWord` char(20) NOT NULL DEFAULT '',
  `statement` varchar(500) NOT NULL DEFAULT '',
  `order` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `statement` (`statement`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dict_ghs_statement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dict_ghs_statement`;

CREATE TABLE `dict_ghs_statement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` char(20) NOT NULL DEFAULT '',
  `statement` varchar(500) NOT NULL DEFAULT '',
  `category` varchar(50) NOT NULL DEFAULT '',
  `order` int(6) DEFAULT NULL,
  `mustEdit` tinyint(1) unsigned zerofill NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dict_jurisdictions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dict_jurisdictions`;

CREATE TABLE `dict_jurisdictions` (
  `id` char(4) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dict_labelelement_statement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dict_labelelement_statement`;

CREATE TABLE `dict_labelelement_statement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `labelelementId` int(11) unsigned NOT NULL,
  `statementId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `labelelementId` (`labelelementId`,`statementId`),
  KEY `fk_sid` (`statementId`),
  CONSTRAINT `fk_leid` FOREIGN KEY (`labelelementId`) REFERENCES `dict_ghs_label_element` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sid` FOREIGN KEY (`statementId`) REFERENCES `dict_ghs_statement` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dict_language
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dict_language`;

CREATE TABLE `dict_language` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(30) CHARACTER SET latin1 NOT NULL,
  `displayName` char(50) NOT NULL,
  `alias` char(5) NOT NULL DEFAULT '',
  `priority` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `alias` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dict_pdflogo_placement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dict_pdflogo_placement`;

CREATE TABLE `dict_pdflogo_placement` (
  `id` int(10) unsigned NOT NULL,
  `position` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dict_pdftemplate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dict_pdftemplate`;

CREATE TABLE `dict_pdftemplate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `className` varchar(100) NOT NULL,
  `accessible_by` enum('orphan','normal','all') NOT NULL DEFAULT 'all',
  `logo_available_placements` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table disconnect_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `disconnect_log`;

CREATE TABLE `disconnect_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `processId` int(11) DEFAULT NULL,
  `taskId` int(11) DEFAULT NULL,
  `level` varchar(128) NOT NULL DEFAULT '',
  `category` varchar(128) NOT NULL DEFAULT '',
  `logtime` int(11) NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taskId` (`taskId`),
  KEY `processId` (`processId`),
  CONSTRAINT `disconnect_log_ibfk_1` FOREIGN KEY (`taskId`) REFERENCES `disconnect_tasks` (`id`),
  CONSTRAINT `disconnect_log_processId_fk` FOREIGN KEY (`processId`) REFERENCES `disconnect_process` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table disconnect_process
# ------------------------------------------------------------

DROP TABLE IF EXISTS `disconnect_process`;

CREATE TABLE `disconnect_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `masterId` int(11) NOT NULL COMMENT 'Document ID',
  `status` int(11) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finishedAt` timestamp NULL DEFAULT NULL,
  `hasErrors` tinyint(1) DEFAULT NULL,
  `runId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `masterId` (`masterId`),
  KEY `disconnect_process_ibfk_1` (`runId`),
  CONSTRAINT `disconnect_process_ibfk_1` FOREIGN KEY (`runId`) REFERENCES `pdf_backup_run` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `disconnect_process_masterId_fkey` FOREIGN KEY (`masterId`) REFERENCES `sdsmaster` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table disconnect_tasks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `disconnect_tasks`;

CREATE TABLE `disconnect_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `processId` int(11) NOT NULL,
  `masterId` int(11) NOT NULL COMMENT 'Document ID (master or child)',
  `revisionId` int(11) NOT NULL,
  `language` char(5) NOT NULL DEFAULT '',
  `templateId` int(10) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `startedAt` datetime NOT NULL,
  `finishedAt` datetime DEFAULT NULL,
  `try` int(2) NOT NULL DEFAULT '0',
  `effectiveDate` date DEFAULT NULL,
  `msds_scan_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `processId` (`processId`),
  KEY `parentId` (`masterId`),
  KEY `revisionId` (`revisionId`),
  KEY `languageId` (`language`),
  KEY `templateId` (`templateId`),
  CONSTRAINT `disconnect_tasks_masterId_fkey` FOREIGN KEY (`masterId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `disconnect_tasks_processId_fkey` FOREIGN KEY (`processId`) REFERENCES `disconnect_process` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `disconnect_tasks_revisionId_fkey` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `disconnect_tasks_templateId_fkey` FOREIGN KEY (`templateId`) REFERENCES `dict_pdftemplate` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_language` FOREIGN KEY (`language`) REFERENCES `dict_language` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table documenttypetemplate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `documenttypetemplate`;

CREATE TABLE `documenttypetemplate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domainId` int(10) DEFAULT NULL,
  `documentTypeId` int(10) unsigned DEFAULT NULL,
  `pdfTemplateId` int(10) unsigned DEFAULT NULL,
  `pdfLogoPlacementId` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `domainDocumentType` (`domainId`,`documentTypeId`),
  UNIQUE KEY `domainTemplate` (`domainId`,`pdfTemplateId`),
  KEY `pdfTemplateId` (`pdfTemplateId`),
  KEY `documenttypetemplate_ibfk_3` (`pdfLogoPlacementId`),
  CONSTRAINT `documenttypetemplate_ibfk_1` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`),
  CONSTRAINT `documenttypetemplate_ibfk_2` FOREIGN KEY (`pdfTemplateId`) REFERENCES `dict_pdftemplate` (`id`),
  CONSTRAINT `documenttypetemplate_ibfk_3` FOREIGN KEY (`pdfLogoPlacementId`) REFERENCES `dict_pdflogo_placement` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table domain
# ------------------------------------------------------------

DROP TABLE IF EXISTS `domain`;

CREATE TABLE `domain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Domain name',
  `hash` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Unique key',
  `cpClientLocation` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'CP client/location name',
  `cpHash` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Compliance Plus client/location hash',
  `manufacturerName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `manufacturerPhone` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `manufacturerWebsite` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `manufacturerStreet` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `manufacturerAddress` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ecName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ecNotes` text COLLATE utf8_unicode_ci NOT NULL,
  `ecPhones` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'JSON encoded phones',
  `hasPublishAs` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `isTrial` tinyint(1) DEFAULT NULL,
  `publicPublish` tinyint(1) DEFAULT NULL COMMENT 'Publish to all published client',
  `isLivePDF` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Domains';



# Dump of table domainlanguage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `domainlanguage`;

CREATE TABLE `domainlanguage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domainId` int(11) NOT NULL,
  `languageId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table dynamodb_revision
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dynamodb_revision`;

CREATE TABLE `dynamodb_revision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revisionId` int(11) NOT NULL,
  `collectionKey` varchar(100) NOT NULL,
  `scalarKey` varchar(100) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='export from dynamo db for revision data';



# Dump of table emergencycontact
# ------------------------------------------------------------

DROP TABLE IF EXISTS `emergencycontact`;

CREATE TABLE `emergencycontact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phoneNumbers` varchar(512) COLLATE utf8_unicode_ci NOT NULL COMMENT 'JSON array of phone numbers',
  `notes` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `domainId` int(11) DEFAULT NULL,
  `countryId` int(11) DEFAULT NULL,
  `headerDisplay` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `fullIndex` (`name`,`phoneNumbers`(255),`notes`,`domainId`),
  KEY `domainIdNameIndex` (`domainId`,`name`),
  KEY `countryId` (`countryId`),
  CONSTRAINT `emergencycontact_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `dict_countries` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Emergency contact';



# Dump of table export_scan
# ------------------------------------------------------------

DROP TABLE IF EXISTS `export_scan`;

CREATE TABLE `export_scan` (
  `id` int(11) NOT NULL,
  `msdsId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `languageId` int(11) NOT NULL,
  `filename` varchar(300) NOT NULL,
  `effectiveDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table formula_process
# ------------------------------------------------------------

DROP TABLE IF EXISTS `formula_process`;

CREATE TABLE `formula_process` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `progress` int(3) NOT NULL DEFAULT '0',
  `revisionId` int(11) NOT NULL,
  `message` text,
  `started` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`),
  CONSTRAINT `formula_process_ibfk_1` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table hazard_formula
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hazard_formula`;

CREATE TABLE `hazard_formula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revisionId` int(11) NOT NULL,
  `min` decimal(5,2) DEFAULT NULL,
  `max` decimal(5,2) DEFAULT NULL,
  `usedInCalculation` tinyint(1) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL COMMENT 'parent formula id',
  `cMasterId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`),
  KEY `parentId` (`parentId`),
  KEY `cMasterId` (`cMasterId`),
  CONSTRAINT `hazard_formula_ibfk_2` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hazard_formula_ibfk_3` FOREIGN KEY (`parentId`) REFERENCES `hazard_formula` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hazard_formula_ibfk_4` FOREIGN KEY (`cMasterId`) REFERENCES `client_component_masters` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table hazardcomponent
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hazardcomponent`;

CREATE TABLE `hazardcomponent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revisionId` int(11) NOT NULL COMMENT 'link to family revision',
  `chemicalName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `otherNames` text COLLATE utf8_unicode_ci NOT NULL,
  `concentrationPercentMin` decimal(11,8) NOT NULL,
  `concentrationPercentMax` decimal(11,8) NOT NULL,
  `tsHideNames` tinyint(4) DEFAULT NULL COMMENT 'Trade secret: hide names',
  `tsHideIds` tinyint(4) DEFAULT NULL COMMENT 'Trade secret: hide ids',
  `tsHideQuantity` tinyint(4) DEFAULT NULL COMMENT 'Trade secret: hide quantity',
  `effectiveDate` date DEFAULT NULL,
  `thresholdReportingPercent` int(11) DEFAULT NULL,
  `percentToImpactClassification` int(11) DEFAULT NULL,
  `acceptableRange11` int(11) DEFAULT NULL,
  `acceptableRange12` int(11) DEFAULT NULL,
  `displayAsTradeSecret` tinyint(1) DEFAULT NULL,
  `doNotDisplay` tinyint(1) DEFAULT NULL,
  `percentInProduct` int(11) DEFAULT NULL,
  `rangeValueToDisplay1` int(11) DEFAULT NULL,
  `rangeValueToDisplay2` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`),
  CONSTRAINT `hazardcomponent_ibfk_1` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Hazardous components';



# Dump of table hazardcomponent_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hazardcomponent_items`;

CREATE TABLE `hazardcomponent_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `componentId` int(11) NOT NULL,
  `cas` varchar(255) DEFAULT NULL,
  `einecs` varchar(255) DEFAULT NULL,
  `ghsLabelElements` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `componentId` (`componentId`),
  CONSTRAINT `hazardcomponent_items_ibfk_1` FOREIGN KEY (`componentId`) REFERENCES `hazardcomponent` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table hazardcomponent_items_modif
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hazardcomponent_items_modif`;

CREATE TABLE `hazardcomponent_items_modif` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `componentId` int(11) NOT NULL,
  `cas` varchar(255) DEFAULT NULL,
  `einecs` varchar(255) DEFAULT NULL,
  `ghsLabelElements` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `componentId` (`componentId`),
  CONSTRAINT `hazardcomponent_items_modif_ibfk_1` FOREIGN KEY (`componentId`) REFERENCES `hazardcomponentmodif` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table hazardcomponentmodif
# ------------------------------------------------------------

DROP TABLE IF EXISTS `hazardcomponentmodif`;

CREATE TABLE `hazardcomponentmodif` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revisionId` int(11) NOT NULL COMMENT 'link to family revision',
  `chemicalName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `otherNames` text COLLATE utf8_unicode_ci NOT NULL,
  `concentrationPercentMin` decimal(11,8) NOT NULL,
  `concentrationPercentMax` decimal(11,8) NOT NULL,
  `tsHideNames` tinyint(4) DEFAULT NULL COMMENT 'Trade secret: hide names',
  `tsHideIds` tinyint(4) DEFAULT NULL COMMENT 'Trade secret: hide ids',
  `tsHideQuantity` tinyint(4) DEFAULT NULL COMMENT 'Trade secret: hide quantity',
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`),
  CONSTRAINT `hazardcomponentmodif_ibfk_1` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Hazardous components';



# Dump of table health_masters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `health_masters`;

CREATE TABLE `health_masters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `legacyId` varchar(255) DEFAULT NULL,
  `name` varchar(500) NOT NULL,
  `effectiveDate` date NOT NULL,
  `jsonData` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `legacy_id` (`legacyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table intervalcounter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `intervalcounter`;

CREATE TABLE `intervalcounter` (
  `counter` int(11) NOT NULL,
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `clientQueryInterval` int(11) NOT NULL COMMENT 'Interval between executions in seconds',
  `maxRecords` int(11) NOT NULL COMMENT 'max records processed',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='interval counter';



# Dump of table ip_filter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ip_filter`;

CREATE TABLE `ip_filter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `locationId` int(11) DEFAULT NULL,
  `ip` varchar(50) NOT NULL DEFAULT '',
  `inheritSublocations` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ip_filter_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ip_filter_config`;

CREATE TABLE `ip_filter_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `clientId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table kit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `kit`;

CREATE TABLE `kit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Internal id of kit',
  `outerId` varchar(255) CHARACTER SET latin1 NOT NULL COMMENT 'Outer Id',
  `domainId` int(11) NOT NULL COMMENT 'domain id',
  PRIMARY KEY (`id`),
  KEY `domainId` (`domainId`),
  CONSTRAINT `kit_ibfk_1` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Kits';



# Dump of table kitsdsmaster
# ------------------------------------------------------------

DROP TABLE IF EXISTS `kitsdsmaster`;

CREATE TABLE `kitsdsmaster` (
  `kitId` int(11) NOT NULL COMMENT 'Id of kit',
  `masterId` int(11) NOT NULL COMMENT 'id of sds master record',
  PRIMARY KEY (`kitId`,`masterId`),
  KEY `masterId` (`masterId`),
  CONSTRAINT `kitsdsmaster_ibfk_1` FOREIGN KEY (`kitId`) REFERENCES `kit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kitsdsmaster_ibfk_2` FOREIGN KEY (`masterId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Kit to SDS relation';



# Dump of table language_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `language_type`;

CREATE TABLE `language_type` (
  `language_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_type_name` varchar(20) NOT NULL DEFAULT '',
  `code` char(35) DEFAULT NULL,
  PRIMARY KEY (`language_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table localstandard
# ------------------------------------------------------------

DROP TABLE IF EXISTS `localstandard`;

CREATE TABLE `localstandard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Locati standard name',
  `chemicalName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revisionId` int(11) NOT NULL COMMENT 'link to family revision',
  `statement` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `listed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`),
  CONSTRAINT `localstandard_ibfk_1` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Local standards data';



# Dump of table localstandardmodif
# ------------------------------------------------------------

DROP TABLE IF EXISTS `localstandardmodif`;

CREATE TABLE `localstandardmodif` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Locati standard name',
  `chemicalName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revisionId` int(11) NOT NULL COMMENT 'link to family revision',
  `statement` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `listed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`),
  CONSTRAINT `localstandardmodif_ibfk_1` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Local standards data';



# Dump of table localstandardmodif_tst
# ------------------------------------------------------------

DROP TABLE IF EXISTS `localstandardmodif_tst`;

CREATE TABLE `localstandardmodif_tst` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Locati standard name',
  `chemicalName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revisionId` int(11) NOT NULL COMMENT 'link to family revision',
  `statement` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `listed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Local standards data';



# Dump of table location_departments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `location_departments`;

CREATE TABLE `location_departments` (
  `department_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` int(10) unsigned NOT NULL DEFAULT '0',
  `department_name` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`department_id`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table location_languages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `location_languages`;

CREATE TABLE `location_languages` (
  `location_id` int(10) NOT NULL DEFAULT '0',
  `language_type_id` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_id`,`language_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table location_msds_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `location_msds_type`;

CREATE TABLE `location_msds_type` (
  `location_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_id`,`msds_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table locations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `location_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `location_name` varchar(64) NOT NULL DEFAULT '',
  `location_url` varchar(100) NOT NULL DEFAULT '',
  `location_max_num_msds` int(5) unsigned NOT NULL DEFAULT '0',
  `location_status_flag` int(10) unsigned NOT NULL DEFAULT '1',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0',
  `location_client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(10) DEFAULT NULL,
  `hide_old_docs_flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table locations_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `locations_admin`;

CREATE TABLE `locations_admin` (
  `location_id` int(10) unsigned NOT NULL DEFAULT '0',
  `admin_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`location_id`,`admin_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table manufacturer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `manufacturer`;

CREATE TABLE `manufacturer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nameAlt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Address parts except street',
  `phone` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `domainId` int(11) DEFAULT NULL,
  `logo` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `countryId` int(11) DEFAULT NULL,
  `headerDisplay` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FullIndex` (`name`,`nameAlt`,`street`,`address`),
  KEY `countryId` (`countryId`),
  CONSTRAINT `manufacturer_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `dict_countries` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Manufacturer';



# Dump of table manufacturer_sdsmaster
# ------------------------------------------------------------

DROP TABLE IF EXISTS `manufacturer_sdsmaster`;

CREATE TABLE `manufacturer_sdsmaster` (
  `productId` int(11) NOT NULL,
  `contactId` int(11) NOT NULL,
  `jurisdictionId` char(4) DEFAULT 'dflt',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productId` (`productId`,`contactId`,`jurisdictionId`),
  KEY `contactId` (`contactId`),
  KEY `jurisdictionId` (`jurisdictionId`),
  CONSTRAINT `manufacturer_sdsmaster_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `manufacturer_sdsmaster_ibfk_2` FOREIGN KEY (`contactId`) REFERENCES `manufacturer` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `manufacturer_sdsmaster_ibfk_3` FOREIGN KEY (`jurisdictionId`) REFERENCES `dict_jurisdictions` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table manufacturer_statement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `manufacturer_statement`;

CREATE TABLE `manufacturer_statement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturerId` int(11) NOT NULL,
  `statement` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `manufacturerId` (`manufacturerId`),
  CONSTRAINT `manufacturer_statement_ibfk_1` FOREIGN KEY (`manufacturerId`) REFERENCES `manufacturer` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table manufacturers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `manufacturers`;

CREATE TABLE `manufacturers` (
  `manufacturer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `manufacturer_name` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`manufacturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table manufacturers_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `manufacturers_history`;

CREATE TABLE `manufacturers_history` (
  `manufacturer_id` int(10) unsigned NOT NULL,
  `manufacturer_name` varchar(80) NOT NULL,
  PRIMARY KEY (`manufacturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table mhub_healthcheck
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mhub_healthcheck`;

CREATE TABLE `mhub_healthcheck` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) NOT NULL DEFAULT '',
  `appName` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(2500) NOT NULL DEFAULT '',
  `status` enum('ok','error','unknown') NOT NULL DEFAULT 'unknown',
  `lastRunTs` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table mhub_healthcheck_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mhub_healthcheck_log`;

CREATE TABLE `mhub_healthcheck_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `healthCheckId` int(11) unsigned NOT NULL,
  `httpCode` tinyint(3) NOT NULL,
  `responseBody` text,
  `startTs` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finishTs` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `healthCheckId` (`healthCheckId`),
  CONSTRAINT `mhub_healthcheck_log_ibfk_1` FOREIGN KEY (`healthCheckId`) REFERENCES `mhub_healthcheck` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table mhub_healthcheck_notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mhub_healthcheck_notifications`;

CREATE TABLE `mhub_healthcheck_notifications` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `subscriptionId` int(11) unsigned NOT NULL,
  `healthCheckId` int(11) unsigned NOT NULL,
  `sentTs` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `subscriptionId` (`subscriptionId`),
  KEY `healthCheckId` (`healthCheckId`),
  CONSTRAINT `mhub_healthcheck_notifications_ibfk_1` FOREIGN KEY (`subscriptionId`) REFERENCES `mhub_healthcheck_subscriptions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mhub_healthcheck_notifications_ibfk_2` FOREIGN KEY (`healthCheckId`) REFERENCES `mhub_healthcheck` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table mhub_healthcheck_subscriptions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mhub_healthcheck_subscriptions`;

CREATE TABLE `mhub_healthcheck_subscriptions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `healthCheckId` int(11) unsigned DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `healthCheckId` (`healthCheckId`),
  CONSTRAINT `mhub_healthcheck_subscriptions_ibfk_1` FOREIGN KEY (`healthCheckId`) REFERENCES `mhub_healthcheck` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table mhub_report_subscriptions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mhub_report_subscriptions`;

CREATE TABLE `mhub_report_subscriptions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `report` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table msds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds`;

CREATE TABLE `msds` (
  `msds_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gsm_id` varchar(20) NOT NULL DEFAULT '',
  `manufacturer_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_name` text NOT NULL,
  `tracking_id` varchar(80) DEFAULT NULL,
  `msds_status_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `starting_effective_dt` date NOT NULL DEFAULT '0000-00-00',
  `ending_effective_dt` date NOT NULL DEFAULT '0000-00-00',
  `submitting_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `submitting_client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `assigned_to_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `last_editted_dt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `aliases` varchar(8000) NOT NULL DEFAULT '',
  `notes` mediumtext NOT NULL,
  `submitting_dt` date DEFAULT NULL,
  `approved_dt` date DEFAULT NULL,
  `approved_flag` tinyint(4) DEFAULT NULL,
  `proper_shipping_name` varchar(80) DEFAULT NULL,
  `un_na` varchar(80) DEFAULT NULL,
  `class_transportation` varchar(20) DEFAULT NULL,
  `packing_group` varchar(30) DEFAULT NULL,
  `product_id` text,
  `dsl_list` varchar(5) DEFAULT NULL,
  `ndsl_list` varchar(5) DEFAULT NULL,
  `dsl_classification_info` varchar(80) DEFAULT NULL,
  `whmis_class` varchar(240) DEFAULT NULL,
  `review_dt` date NOT NULL DEFAULT '0000-00-00',
  `webservice_id` varchar(2048) NOT NULL,
  `sds_publisher` int(1) NOT NULL DEFAULT '0',
  `ghs_flag` tinyint(1) NOT NULL DEFAULT '0',
  `sp_location_id` int(11) DEFAULT NULL COMMENT 'Id of location to which record originally assigned',
  `rr_hide` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `rr_haps` decimal(10,5) DEFAULT NULL,
  `rr_ph_upper` decimal(10,5) DEFAULT NULL,
  `rr_ph_lower` decimal(10,5) DEFAULT NULL,
  `rr_flashpoint_f` decimal(10,5) DEFAULT NULL,
  `rr_flashpoint_c` decimal(10,5) DEFAULT NULL,
  `rr_density` decimal(10,5) DEFAULT NULL,
  `rr_density_units` varchar(20) DEFAULT NULL,
  `rr_solids` decimal(10,5) DEFAULT NULL,
  `rr_voc` decimal(10,5) DEFAULT NULL,
  `rr_reactive` tinyint(1) unsigned DEFAULT NULL,
  `rr_incompatible_materials` text,
  `restrict_update` tinyint(1) NOT NULL DEFAULT '0',
  `rr_cpds_report` int(1) DEFAULT '0',
  `rr_vhaps` decimal(10,5) DEFAULT NULL,
  `rr_rcra` varchar(255) DEFAULT NULL,
  `rr_haps_units` varchar(50) DEFAULT NULL,
  `rr_vhaps_units` varchar(50) DEFAULT NULL,
  `rr_sara_311_312_acute` smallint(1) DEFAULT '0',
  `rr_sara_311_312_chronic` smallint(1) DEFAULT '0',
  `rr_sara_311_312_fire` smallint(1) DEFAULT '0',
  `rr_sara_311_312_pressure` smallint(1) DEFAULT '0',
  `rr_voc_wo_water_units` varchar(50) DEFAULT NULL,
  `rr_sara_311_312_reactive` smallint(1) DEFAULT '0',
  `rr_solids_units` varchar(50) DEFAULT NULL,
  `rr_voc_units` varchar(50) DEFAULT NULL,
  `rr_voc_wo_water` decimal(10,5) DEFAULT NULL,
  `error_message` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `unpublish` tinyint(1) DEFAULT NULL,
  `sp_client_id` int(11) DEFAULT NULL,
  `sdsp_id` int(11) DEFAULT NULL COMMENT 'SDSP doc id',
  PRIMARY KEY (`msds_id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  KEY `submitting_client_id` (`submitting_client_id`),
  KEY `msds_status_id` (`msds_status_id`),
  KEY `starting_effective_dt` (`starting_effective_dt`),
  KEY `gsm_id` (`gsm_id`),
  KEY `assigned_to_user_id` (`assigned_to_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_clients
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_clients`;

CREATE TABLE `msds_clients` (
  `client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_obsolete` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'is obsolete for client',
  PRIMARY KEY (`client_id`,`msds_id`),
  KEY `msds_id` (`msds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_departments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_departments`;

CREATE TABLE `msds_departments` (
  `msds_id` int(10) unsigned NOT NULL DEFAULT '0',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`msds_id`,`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_hazmat_label
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_hazmat_label`;

CREATE TABLE `msds_hazmat_label` (
  `msds_id` int(11) NOT NULL DEFAULT '0',
  `nfpa_display` tinyint(4) NOT NULL DEFAULT '1',
  `nfpa_health` tinyint(4) NOT NULL DEFAULT '-1',
  `nfpa_flam` tinyint(4) NOT NULL DEFAULT '-1',
  `nfpa_reac` tinyint(4) NOT NULL DEFAULT '-1',
  `nfpa_spec` varchar(30) NOT NULL DEFAULT '',
  `hmis_display` tinyint(4) NOT NULL DEFAULT '1',
  `hmis_name` varchar(50) NOT NULL DEFAULT '',
  `hmis_health` tinyint(4) NOT NULL DEFAULT '-1',
  `hmis_flam` tinyint(4) NOT NULL DEFAULT '-1',
  `hmis_phys` tinyint(4) NOT NULL DEFAULT '-1',
  `hmis_pprot` char(4) NOT NULL DEFAULT '',
  `hmis_note` text NOT NULL,
  `hmis_coex` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`msds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_history`;

CREATE TABLE `msds_history` (
  `msds_id` int(10) unsigned NOT NULL,
  `manufacturer_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`msds_id`,`manufacturer_id`),
  KEY `manufacturer_id` (`manufacturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_label_restore
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_label_restore`;

CREATE TABLE `msds_label_restore` (
  `msds_id` int(11) NOT NULL DEFAULT '0',
  `nfpa_display` tinyint(4) NOT NULL DEFAULT '1',
  `nfpa_health` tinyint(4) NOT NULL DEFAULT '-1',
  `nfpa_flam` tinyint(4) NOT NULL DEFAULT '-1',
  `nfpa_reac` tinyint(4) NOT NULL DEFAULT '-1',
  `nfpa_spec` varchar(30) NOT NULL DEFAULT '',
  `hmis_display` tinyint(4) NOT NULL DEFAULT '1',
  `hmis_name` varchar(50) NOT NULL DEFAULT '',
  `hmis_health` tinyint(4) NOT NULL DEFAULT '-1',
  `hmis_flam` tinyint(4) NOT NULL DEFAULT '-1',
  `hmis_phys` tinyint(4) NOT NULL DEFAULT '-1',
  `hmis_pprot` char(4) NOT NULL DEFAULT '',
  `hmis_note` text NOT NULL,
  `hmis_coex` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`msds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_locations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_locations`;

CREATE TABLE `msds_locations` (
  `msds_id` int(10) unsigned NOT NULL DEFAULT '0',
  `location_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_status_flag` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`msds_id`,`location_id`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_restore
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_restore`;

CREATE TABLE `msds_restore` (
  `msds_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gsm_id` varchar(20) NOT NULL DEFAULT '',
  `manufacturer_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_name` text NOT NULL,
  `tracking_id` varchar(80) DEFAULT NULL,
  `msds_status_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `starting_effective_dt` date NOT NULL DEFAULT '0000-00-00',
  `ending_effective_dt` date NOT NULL DEFAULT '0000-00-00',
  `submitting_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `submitting_client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `assigned_to_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `last_editted_dt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `aliases` varchar(8000) NOT NULL DEFAULT '',
  `notes` mediumtext NOT NULL,
  `submitting_dt` date DEFAULT NULL,
  `approved_dt` date DEFAULT NULL,
  `approved_flag` tinyint(4) DEFAULT NULL,
  `proper_shipping_name` varchar(80) DEFAULT NULL,
  `un_na` varchar(80) DEFAULT NULL,
  `class_transportation` varchar(20) DEFAULT NULL,
  `packing_group` varchar(30) DEFAULT NULL,
  `product_id` text,
  `dsl_list` varchar(5) DEFAULT NULL,
  `ndsl_list` varchar(5) DEFAULT NULL,
  `dsl_classification_info` varchar(80) DEFAULT NULL,
  `whmis_class` varchar(240) DEFAULT NULL,
  `review_dt` date NOT NULL DEFAULT '0000-00-00',
  `webservice_id` varchar(2048) NOT NULL,
  `sds_publisher` int(1) NOT NULL DEFAULT '0',
  `ghs_flag` tinyint(1) NOT NULL DEFAULT '0',
  `sp_location_id` int(11) DEFAULT NULL COMMENT 'Id of location to which record originally assigned',
  `rr_hide` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `rr_haps` decimal(10,5) DEFAULT NULL,
  `rr_ph_upper` decimal(10,5) DEFAULT NULL,
  `rr_ph_lower` decimal(10,5) DEFAULT NULL,
  `rr_flashpoint_f` decimal(10,5) DEFAULT NULL,
  `rr_flashpoint_c` decimal(10,5) DEFAULT NULL,
  `rr_density` decimal(10,5) DEFAULT NULL,
  `rr_density_units` varchar(20) DEFAULT NULL,
  `rr_solids` decimal(10,5) DEFAULT NULL,
  `rr_voc` decimal(10,5) DEFAULT NULL,
  `rr_reactive` tinyint(1) unsigned DEFAULT NULL,
  `rr_incompatible_materials` text,
  `restrict_update` tinyint(1) NOT NULL DEFAULT '0',
  `rr_cpds_report` int(1) DEFAULT '0',
  `rr_vhaps` decimal(10,5) DEFAULT NULL,
  `rr_rcra` varchar(255) DEFAULT NULL,
  `rr_haps_units` varchar(50) DEFAULT NULL,
  `rr_vhaps_units` varchar(50) DEFAULT NULL,
  `rr_sara_311_312_acute` smallint(1) DEFAULT '0',
  `rr_sara_311_312_chronic` smallint(1) DEFAULT '0',
  `rr_sara_311_312_fire` smallint(1) DEFAULT '0',
  `rr_sara_311_312_pressure` smallint(1) DEFAULT '0',
  `rr_voc_wo_water_units` varchar(50) DEFAULT NULL,
  `rr_sara_311_312_reactive` smallint(1) DEFAULT '0',
  `rr_solids_units` varchar(50) DEFAULT NULL,
  `rr_voc_units` varchar(50) DEFAULT NULL,
  `rr_voc_wo_water` decimal(10,5) DEFAULT NULL,
  `error_message` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `unpublish` tinyint(1) DEFAULT NULL COMMENT 'Temporary',
  `sp_client_id` int(11) DEFAULT NULL,
  `sdsp_id` int(11) DEFAULT NULL COMMENT 'SDSP doc id',
  PRIMARY KEY (`msds_id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  KEY `submitting_client_id` (`submitting_client_id`),
  KEY `msds_status_id` (`msds_status_id`),
  KEY `starting_effective_dt` (`starting_effective_dt`),
  KEY `gsm_id` (`gsm_id`),
  KEY `assigned_to_user_id` (`assigned_to_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Data to restore in case of SDSP unpublish';



# Dump of table msds_scans
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_scans`;

CREATE TABLE `msds_scans` (
  `msds_scan_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msds_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `language_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `file_name` varchar(4000) NOT NULL DEFAULT '',
  `starting_effective_dt` date DEFAULT NULL,
  PRIMARY KEY (`msds_scan_id`),
  KEY `msds_id` (`msds_id`),
  KEY `msds_type_id` (`msds_type_id`),
  KEY `language_type_id` (`language_type_id`),
  KEY `lang_type` (`language_type_id`,`msds_type_id`),
  KEY `complex_1` (`msds_id`,`msds_type_id`,`language_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_status`;

CREATE TABLE `msds_status` (
  `msds_status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msds_status_name` varchar(24) NOT NULL DEFAULT '',
  PRIMARY KEY (`msds_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_status_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_status_history`;

CREATE TABLE `msds_status_history` (
  `msds_status_hist_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msds_id` int(10) unsigned DEFAULT NULL,
  `msds_status_change_dt` datetime DEFAULT NULL,
  `msds_status_id` int(10) unsigned DEFAULT NULL,
  `submitting_user_id` int(10) unsigned DEFAULT NULL,
  `assign_to_user_id` int(10) unsigned DEFAULT NULL,
  `msds_status_notes` text,
  PRIMARY KEY (`msds_status_hist_id`),
  KEY `msds_id` (`msds_id`),
  KEY `submitting_user_id` (`submitting_user_id`),
  KEY `assign_to_user_id` (`assign_to_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_subst_restore
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_subst_restore`;

CREATE TABLE `msds_subst_restore` (
  `msds_id` int(10) unsigned NOT NULL DEFAULT '0',
  `substance_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sub_concentration` varchar(20) DEFAULT NULL,
  `sub_max` varchar(8) DEFAULT NULL,
  `sub_min` varchar(8) DEFAULT NULL,
  `msds_substance_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`msds_substance_id`),
  KEY `substance_id` (`substance_id`),
  KEY `msds_id` (`msds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_substances
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_substances`;

CREATE TABLE `msds_substances` (
  `msds_id` int(10) unsigned NOT NULL DEFAULT '0',
  `substance_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sub_concentration` varchar(20) DEFAULT NULL,
  `sub_max` varchar(8) DEFAULT NULL,
  `sub_min` varchar(8) DEFAULT NULL,
  `msds_substance_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`msds_substance_id`),
  KEY `substance_id` (`substance_id`),
  KEY `msds_id` (`msds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table msds_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `msds_type`;

CREATE TABLE `msds_type` (
  `msds_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `msds_type_name` varchar(24) NOT NULL DEFAULT '',
  PRIMARY KEY (`msds_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table newhazardcomponent
# ------------------------------------------------------------

DROP TABLE IF EXISTS `newhazardcomponent`;

CREATE TABLE `newhazardcomponent` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `componentMasterId` varchar(255) DEFAULT '',
  `listComponent` tinyint(1) NOT NULL DEFAULT '0',
  `listEinecs` tinyint(1) NOT NULL DEFAULT '0',
  `nameToDisplay` varchar(1024) DEFAULT NULL,
  `casToDisplay` varchar(255) DEFAULT NULL,
  `isDisplayable` tinyint(1) DEFAULT '1',
  `changeSection2` tinyint(1) DEFAULT '0',
  `changeSection3` tinyint(1) DEFAULT '0',
  `changeSection8` tinyint(1) DEFAULT '0',
  `changeSection11` tinyint(1) DEFAULT '0',
  `changeSection12` tinyint(1) DEFAULT '0',
  `changeSection15` tinyint(1) DEFAULT '0',
  `percentInProduct` float(5,2) DEFAULT NULL,
  `rangeToDisplay1` float(5,2) DEFAULT NULL,
  `rangeToDisplay2` float(5,2) DEFAULT NULL,
  `componentType` enum('governmental','supplier') DEFAULT NULL,
  `componentSource` varchar(255) DEFAULT NULL,
  `componentProductId` varchar(255) DEFAULT NULL,
  `componentCAS` varchar(255) DEFAULT NULL,
  `componentName` varchar(1024) DEFAULT NULL,
  `componentEINECS` varchar(255) DEFAULT NULL,
  `componentCommonName` varchar(1024) DEFAULT NULL,
  `componentPreferenceName` varchar(1024) DEFAULT NULL,
  `componentListEC` enum('yes','no') DEFAULT NULL,
  `componentListAdditionalIds` enum('yes','no') DEFAULT 'no',
  `componentReportThreshold` varchar(50) DEFAULT NULL,
  `componentHazardList` varchar(5210) DEFAULT NULL,
  `componentShow` enum('yes','no') DEFAULT 'no',
  `rangeMin` decimal(5,2) DEFAULT '0.00',
  `rangeMax` decimal(5,2) DEFAULT '0.00',
  `useInCalculation` tinyint(1) DEFAULT '1',
  `revisionId` int(11) NOT NULL,
  `cMasterId` int(11) unsigned DEFAULT NULL,
  `jurisdictions` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisionId` (`revisionId`,`cMasterId`),
  KEY `fk-revision_id-comm` (`revisionId`),
  KEY `cMasterId` (`cMasterId`),
  KEY `componentMasterId_2` (`componentMasterId`),
  CONSTRAINT `fk-revision_id-comm` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `newhazardcomponent_ibfk_1` FOREIGN KEY (`cMasterId`) REFERENCES `client_component_masters` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table newhazardcomponentmodif
# ------------------------------------------------------------

DROP TABLE IF EXISTS `newhazardcomponentmodif`;

CREATE TABLE `newhazardcomponentmodif` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `componentMasterId` varchar(255) NOT NULL DEFAULT '',
  `listComponent` tinyint(1) NOT NULL DEFAULT '0',
  `listEinecs` tinyint(1) NOT NULL DEFAULT '0',
  `nameToDisplay` text,
  `casToDisplay` varchar(255) DEFAULT NULL,
  `isDisplayable` tinyint(1) DEFAULT '1',
  `changeSection2` tinyint(1) DEFAULT '0',
  `changeSection3` tinyint(1) DEFAULT '0',
  `changeSection8` tinyint(1) DEFAULT '0',
  `changeSection11` tinyint(1) DEFAULT '0',
  `changeSection12` tinyint(1) DEFAULT '0',
  `changeSection15` tinyint(1) DEFAULT '0',
  `percentInProduct` float(5,2) DEFAULT NULL,
  `rangeToDisplay1` float(5,2) DEFAULT NULL,
  `rangeToDisplay2` float(5,2) DEFAULT NULL,
  `componentType` enum('governmental','supplier') DEFAULT NULL,
  `componentSource` varchar(255) DEFAULT NULL,
  `componentProductId` varchar(255) DEFAULT NULL,
  `componentCAS` varchar(255) DEFAULT NULL,
  `componentName` varchar(1024) DEFAULT NULL,
  `componentEINECS` varchar(255) DEFAULT NULL,
  `componentCommonName` varchar(1024) DEFAULT NULL,
  `componentPreferenceName` varchar(1024) DEFAULT NULL,
  `componentListEC` enum('yes','no') DEFAULT NULL,
  `componentListAdditionalIds` enum('yes','no') DEFAULT 'no',
  `componentReportThreshold` varchar(50) DEFAULT NULL,
  `componentHazardList` varchar(5210) DEFAULT NULL,
  `componentShow` enum('yes','no') DEFAULT 'no',
  `rangeMin` decimal(5,2) DEFAULT '0.00',
  `rangeMax` decimal(5,2) DEFAULT '0.00',
  `useInCalculation` tinyint(1) DEFAULT '1',
  `revisionId` int(11) NOT NULL,
  `cMasterId` int(11) unsigned DEFAULT NULL,
  `jurisdictions` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisionId` (`revisionId`,`cMasterId`),
  KEY `fk-modif-revision_id-comm` (`revisionId`),
  KEY `cMasterId` (`cMasterId`),
  KEY `componentMasterId` (`componentMasterId`),
  CONSTRAINT `fk-modif-revision_id-comm` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `newhazardcomponentmodif_ibfk_1` FOREIGN KEY (`cMasterId`) REFERENCES `client_component_masters` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table not_translated
# ------------------------------------------------------------

DROP TABLE IF EXISTS `not_translated`;

CREATE TABLE `not_translated` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `revisionId` int(11) NOT NULL,
  `masterId` int(11) NOT NULL,
  `message` text NOT NULL,
  `md5` varchar(255) NOT NULL DEFAULT '',
  `language` char(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisionId` (`revisionId`,`masterId`,`md5`),
  KEY `fk-master_id_not_translated` (`masterId`),
  CONSTRAINT `fk-master_id_not_translated` FOREIGN KEY (`masterId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk-revision_id_not_translated` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ops_tracking
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ops_tracking`;

CREATE TABLE `ops_tracking` (
  `trackingId` int(11) NOT NULL COMMENT 'Tracking id',
  `msdsId` int(11) DEFAULT NULL COMMENT 'MSDS id',
  PRIMARY KEY (`trackingId`),
  KEY `msdsId` (`msdsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tracking ids entered by Ops';



# Dump of table parent_hazard_component
# ------------------------------------------------------------

DROP TABLE IF EXISTS `parent_hazard_component`;

CREATE TABLE `parent_hazard_component` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `componentMasterId` varchar(255) NOT NULL DEFAULT '',
  `listComponent` tinyint(1) NOT NULL DEFAULT '0',
  `listEinecs` tinyint(1) NOT NULL DEFAULT '0',
  `nameToDisplay` varchar(1024) DEFAULT NULL,
  `casToDisplay` varchar(255) DEFAULT NULL,
  `isDisplayable` tinyint(1) DEFAULT '1',
  `changeSection2` tinyint(1) DEFAULT '0',
  `changeSection3` tinyint(1) DEFAULT '0',
  `changeSection8` tinyint(1) DEFAULT '0',
  `changeSection11` tinyint(1) DEFAULT '0',
  `changeSection12` tinyint(1) DEFAULT '0',
  `changeSection15` tinyint(1) DEFAULT '0',
  `percentInProduct` float(5,2) DEFAULT NULL,
  `rangeToDisplay1` float(5,2) DEFAULT NULL,
  `rangeToDisplay2` float(5,2) DEFAULT NULL,
  `componentType` enum('governmental','supplier') DEFAULT NULL,
  `componentSource` varchar(255) DEFAULT NULL,
  `componentProductId` varchar(255) DEFAULT NULL,
  `componentCAS` varchar(255) DEFAULT NULL,
  `componentName` varchar(1024) DEFAULT NULL,
  `componentEINECS` varchar(255) DEFAULT NULL,
  `componentCommonName` varchar(1024) DEFAULT NULL,
  `componentPreferenceName` varchar(1024) DEFAULT NULL,
  `componentListEC` enum('yes','no') DEFAULT NULL,
  `componentListAdditionalIds` enum('yes','no') DEFAULT NULL,
  `componentReportThreshold` varchar(50) DEFAULT NULL,
  `componentHazardList` varchar(5210) DEFAULT NULL,
  `componentShow` enum('yes','no') DEFAULT NULL,
  `masterCasToDisplay` varchar(255) DEFAULT NULL,
  `masterNameToDisplay` varchar(1024) DEFAULT NULL,
  `masterIsDisplayable` tinyint(1) DEFAULT '1',
  `masterComponentListEC` enum('yes','no') DEFAULT NULL,
  `masterRangeToDisplay1` float(5,2) DEFAULT NULL,
  `masterRangeToDisplay2` float(5,2) DEFAULT NULL,
  `rangeMin` decimal(5,2) DEFAULT '0.00',
  `rangeMax` decimal(5,2) DEFAULT '0.00',
  `useInCalculation` tinyint(1) DEFAULT '1',
  `revisionId` int(11) NOT NULL,
  `masterId` int(11) NOT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `cMasterId` int(11) unsigned DEFAULT NULL,
  `jurisdictions` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisionId` (`revisionId`,`masterId`,`cMasterId`),
  KEY `fk-revision_id-comm` (`revisionId`),
  KEY `fk-master_id-345458` (`masterId`),
  KEY `cMasterId` (`cMasterId`),
  CONSTRAINT `fk-master_id-345458` FOREIGN KEY (`masterId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk-revision_id-123123123` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parent_hazard_component_ibfk_1` FOREIGN KEY (`cMasterId`) REFERENCES `client_component_masters` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table parent_sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `parent_sections`;

CREATE TABLE `parent_sections` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `masterId` int(11) NOT NULL,
  `revisionId` int(11) NOT NULL,
  `appearance` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `odor` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `odorThreshold` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `phValue` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `meltingPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `boilingPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `flashPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `evaporationRate` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `flammability` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `explosionLimitLower` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `explosionLimitUpper` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `vaporPressure` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `densityVapor` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `densityRelative` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `partitionCoefficient` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `autoIgnition` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `decomposition` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `viscosityDynamic` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `viscosityKinematic` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `unNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `properShippingName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `packingGroup` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `density` tinytext COLLATE utf8_unicode_ci,
  `section14tunnelRestrictionCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14transportCategory` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14segregationGroups` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14dangerCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14emsNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14marinePollutant` tinyint(1) DEFAULT NULL,
  `section14reportableQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14limitedQuantityException` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14limitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14groundLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14groundExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14airExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14airLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14seaLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14seaExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section9ExplosiveProperties` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `section9OxidizingProperties` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `masterAppearance` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterOdor` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterOdorThreshold` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterPhValue` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterMeltingPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterBoilingPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterFlashPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterEvaporationRate` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterFlammability` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterExplosionLimitLower` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterExplosionLimitUpper` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterVaporPressure` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterDensityVapor` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterDensityRelative` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterPartitionCoefficient` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterAutoIgnition` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterDecomposition` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterViscosityDynamic` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterViscosityKinematic` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterUnNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterProperShippingName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterPackingGroup` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterDensity` tinytext COLLATE utf8_unicode_ci,
  `masterSection14tunnelRestrictionCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14transportCategory` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14segregationGroups` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14dangerCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14emsNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14marinePollutant` tinyint(1) DEFAULT NULL,
  `masterSection14reportableQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14limitedQuantityException` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14limitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14groundLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14groundExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14airExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14airLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14seaLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection14seaExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `masterSection9ExplosiveProperties` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `masterSection9OxidizingProperties` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `json_data` json NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parent-revision` (`masterId`,`revisionId`),
  KEY `revisionId` (`revisionId`),
  CONSTRAINT `parent_sections_ibfk_1` FOREIGN KEY (`masterId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parent_sections_ibfk_2` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=8 COMMENT='Base data for SDS revision';



# Dump of table parentquerystatus
# ------------------------------------------------------------

DROP TABLE IF EXISTS `parentquerystatus`;

CREATE TABLE `parentquerystatus` (
  `execId` int(11) NOT NULL,
  `outerId` varchar(50) NOT NULL,
  `errorText` text,
  `hasErrors` tinyint(1) NOT NULL,
  `startTs` datetime NOT NULL,
  `finishTs` datetime NOT NULL,
  UNIQUE KEY `exectId` (`execId`,`outerId`),
  CONSTRAINT `parentquerystatus_ibfk_1` FOREIGN KEY (`execId`) REFERENCES `cronexec` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Status of parent children processing';



# Dump of table pdf_backup_run
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pdf_backup_run`;

CREATE TABLE `pdf_backup_run` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domainId` int(11) NOT NULL,
  `templateId` int(11) DEFAULT NULL,
  `languageIso` varchar(10) DEFAULT NULL,
  `startDate` timestamp NULL DEFAULT NULL,
  `userId` int(11) NOT NULL,
  type ENUM('publish', 'disconnect', 'backup_cp', 'backup_s3') DEFAULT 'publish' NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pdf_single_statement
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pdf_single_statement`;

CREATE TABLE `pdf_single_statement` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `revisionId` int(11) NOT NULL,
  `collectionKey` varchar(255) NOT NULL DEFAULT '',
  `statement` varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`),
  CONSTRAINT `pdf_single_statement_ibfk_1` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pdf_single_statement_modif
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pdf_single_statement_modif`;

CREATE TABLE `pdf_single_statement_modif` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `revisionId` int(11) NOT NULL,
  `collectionKey` varchar(255) NOT NULL DEFAULT '',
  `statement` varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `revisionId` (`revisionId`),
  CONSTRAINT `pdf_single_statement_modif_ibfk_1` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pdfgen_access_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pdfgen_access_log`;

CREATE TABLE `pdfgen_access_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `level` int(2) DEFAULT NULL,
  `accessTime` datetime NOT NULL,
  `application` varchar(255) DEFAULT NULL,
  `userIdentity` varchar(255) DEFAULT NULL,
  `ip` varchar(25) DEFAULT NULL,
  `userAgent` varchar(255) DEFAULT NULL,
  `referer` varchar(255) DEFAULT NULL,
  `requestUri` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table pdftemplatetext
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pdftemplatetext`;

CREATE TABLE `pdftemplatetext` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` int(10) unsigned NOT NULL,
  `phrase` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table physical_masters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `physical_masters`;

CREATE TABLE `physical_masters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `legacyId` varchar(255) DEFAULT NULL,
  `name` varchar(500) NOT NULL,
  `effectiveDate` date NOT NULL,
  `jsonData` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `legacy_id` (`legacyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_cache`;

CREATE TABLE `product_cache` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `productId` int(11) NOT NULL,
  `revisionId` int(11) NOT NULL,
  `data` json NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_ProductId_Cache` (`productId`),
  KEY `fk_ProductId` (`productId`),
  KEY `fk_RevisionId_Cache` (`revisionId`),
  CONSTRAINT `fk_ProductId` FOREIGN KEY (`productId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_RevisionId_Cache` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product_master_final
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_master_final`;

CREATE TABLE `product_master_final` (
  `id` int(10) unsigned NOT NULL,
  `json_data` json NOT NULL,
  `modifiedDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product_master_modif
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_master_modif`;

CREATE TABLE `product_master_modif` (
  `id` int(10) unsigned NOT NULL,
  `json_data` json NOT NULL,
  `modifiedDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product_masters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_masters`;

CREATE TABLE `product_masters` (
  `id` int(10) NOT NULL,
  `json_data` json NOT NULL,
  `modifiedDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `ids` FOREIGN KEY (`id`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product_masters_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_masters_cache`;

CREATE TABLE `product_masters_cache` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `revisionId` int(11) NOT NULL,
  `data` json NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_RevisionId` (`revisionId`),
  CONSTRAINT `fk_RevisionId` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table product_masters_modif
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_masters_modif`;

CREATE TABLE `product_masters_modif` (
  `id` int(10) NOT NULL,
  `json_data` json NOT NULL,
  `modifiedDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `product_masters_modif_ibfk_1` FOREIGN KEY (`id`) REFERENCES `product_masters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table progress_bar
# ------------------------------------------------------------

DROP TABLE IF EXISTS `progress_bar`;

CREATE TABLE `progress_bar` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `val` double DEFAULT NULL,
  `guid` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table publish_backup_tasks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `publish_backup_tasks`;

CREATE TABLE `publish_backup_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `domainId` int(11) NOT NULL,
  `masterId` int(11) NOT NULL,
  `revisionId` int(11) NOT NULL,
  `templateId` int(10) unsigned NOT NULL,
  `languageIso` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `effectiveDate` date DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finishedAt` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `errorMessage` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fileName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filePath` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cpMsdsId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `publish_backup_tasks_masterId_fkey` (`masterId`),
  KEY `publish_backup_tasks_revisionId_fkey` (`revisionId`),
  KEY `publish_backup_tasks_templateId_fkey` (`templateId`),
  CONSTRAINT `publish_backup_tasks_masterId_fkey` FOREIGN KEY (`masterId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publish_backup_tasks_revisionId_fkey` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `publish_backup_tasks_templateId_fkey` FOREIGN KEY (`templateId`) REFERENCES `dict_pdftemplate` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table report_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `report_type`;

CREATE TABLE `report_type` (
  `report_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `report_type_name` varchar(24) NOT NULL DEFAULT '',
  PRIMARY KEY (`report_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table sdadminpanel_logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdadminpanel_logs`;

CREATE TABLE `sdadminpanel_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` varchar(128) DEFAULT NULL,
  `category` varchar(128) DEFAULT NULL,
  `logtime` int(11) DEFAULT NULL,
  `message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sdsdetailview
# ------------------------------------------------------------

DROP VIEW IF EXISTS `sdsdetailview`;

CREATE TABLE `sdsdetailview` (
   `masterId` INT(11) NOT NULL DEFAULT '0',
   `outerId` VARCHAR(255) NOT NULL,
   `parentId` INT(11) NULL DEFAULT NULL,
   `cpMsdsId` INT(11) NULL DEFAULT NULL,
   `revisionId` INT(11) NULL DEFAULT '0',
   `id` INT(11) NULL DEFAULT '0',
   `familyId` INT(11) NULL DEFAULT NULL,
   `effectiveDate` DATETIME NULL DEFAULT NULL,
   `modifiedDate` TIMESTAMP NULL DEFAULT '0000-00-00 00:00:00',
   `section3AdditionalInformation` TEXT NULL DEFAULT NULL,
   `section3Description` TEXT NULL DEFAULT NULL,
   `section3ChemicalCharacterization` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
   `section4GeneralInformation` TEXT NULL DEFAULT NULL,
   `published` TINYINT(4) NULL DEFAULT '0',
   `isModified` TINYINT(4) NULL DEFAULT '0',
   `hash` VARCHAR(50) NULL DEFAULT NULL,
   `kitOuterId` VARCHAR(255) NULL DEFAULT NULL,
   `manufacturerName` VARCHAR(255) NULL DEFAULT NULL,
   `manufacturerNameAlt` VARCHAR(255) NULL DEFAULT NULL,
   `manufacturerAddress` VARCHAR(255) NULL DEFAULT NULL,
   `manufacturerStreet` VARCHAR(255) NULL DEFAULT NULL,
   `manufacturerPhone` VARCHAR(100) NULL DEFAULT NULL,
   `manufacturerWebsite` VARCHAR(255) NULL DEFAULT NULL,
   `manufacturerEmail` VARCHAR(255) NULL DEFAULT NULL,
   `manufacturerLogo` VARCHAR(500) NULL DEFAULT NULL,
   `supplierName` VARCHAR(255) NULL DEFAULT NULL,
   `supplierNameAlt` VARCHAR(255) NULL DEFAULT NULL,
   `supplierAddress` VARCHAR(255) NULL DEFAULT NULL,
   `supplierStreet` VARCHAR(255) NULL DEFAULT NULL,
   `supplierPhone` VARCHAR(100) NULL DEFAULT NULL,
   `supplierWebsite` VARCHAR(255) NULL DEFAULT NULL,
   `supplierEmail` VARCHAR(255) NULL DEFAULT NULL,
   `name` TEXT NULL DEFAULT NULL,
   `tradeName` VARCHAR(255) NULL DEFAULT NULL,
   `usage` TEXT NULL DEFAULT NULL,
   `usageAdvisedAgainst` TEXT NULL DEFAULT NULL,
   `reasonsAdvisedAgainst` TEXT NULL DEFAULT NULL,
   `synonyms` VARCHAR(500) NULL DEFAULT NULL,
   `docEffectiveDate` DATETIME NULL DEFAULT NULL,
   `additionalInfo` VARCHAR(500) NULL DEFAULT NULL,
   `appearance` VARCHAR(255) NULL DEFAULT NULL,
   `odor` VARCHAR(255) NULL DEFAULT NULL,
   `odorThreshold` VARCHAR(255) NULL DEFAULT NULL,
   `phValue` VARCHAR(255) NULL DEFAULT NULL,
   `meltingPoint` VARCHAR(255) NULL DEFAULT NULL,
   `boilingPoint` VARCHAR(255) NULL DEFAULT NULL,
   `flashPoint` VARCHAR(255) NULL DEFAULT NULL,
   `evaporationRate` VARCHAR(255) NULL DEFAULT NULL,
   `flammability` VARCHAR(255) NULL DEFAULT NULL,
   `explosionLimitLower` VARCHAR(255) NULL DEFAULT NULL,
   `explosionLimitUpper` VARCHAR(255) NULL DEFAULT NULL,
   `vaporPressure` VARCHAR(255) NULL DEFAULT NULL,
   `densityVapor` VARCHAR(255) NULL DEFAULT NULL,
   `densityRelative` VARCHAR(255) NULL DEFAULT NULL,
   `partitionCoefficient` VARCHAR(255) NULL DEFAULT NULL,
   `autoIgnition` VARCHAR(255) NULL DEFAULT NULL,
   `decomposition` VARCHAR(255) NULL DEFAULT NULL,
   `viscosityDynamic` VARCHAR(255) NULL DEFAULT NULL,
   `viscosityKinematic` VARCHAR(255) NULL DEFAULT NULL,
   `unNumber` VARCHAR(255) NULL DEFAULT NULL,
   `properShippingName` VARCHAR(255) NULL DEFAULT NULL,
   `packingGroup` VARCHAR(255) NULL DEFAULT NULL,
   `density` VARCHAR(255) NULL DEFAULT NULL,
   `section14tunnelRestrictionCode` VARCHAR(255) NULL DEFAULT NULL,
   `section14transportCategory` VARCHAR(255) NULL DEFAULT NULL,
   `section14segregationGroups` VARCHAR(255) NULL DEFAULT NULL,
   `section14dangerCode` VARCHAR(255) NULL DEFAULT NULL,
   `section14emsNumber` VARCHAR(255) NULL DEFAULT NULL,
   `section14marinePollutant` INT(4) NULL DEFAULT NULL,
   `section14reportableQuantity` VARCHAR(255) NULL DEFAULT NULL,
   `section14limitedQuantityException` VARCHAR(255) NULL DEFAULT NULL,
   `section14limitedQuantity` VARCHAR(255) NULL DEFAULT NULL,
   `section14groundLimitedQuantity` VARCHAR(255) NULL DEFAULT NULL,
   `section14groundExceptionQuantity` VARCHAR(255) NULL DEFAULT NULL,
   `section14airExceptionQuantity` VARCHAR(255) NULL DEFAULT NULL,
   `section14airLimitedQuantity` VARCHAR(255) NULL DEFAULT NULL,
   `section14seaLimitedQuantity` VARCHAR(255) NULL DEFAULT NULL,
   `section14seaExceptionQuantity` VARCHAR(255) NULL DEFAULT NULL,
   `lastModifiedDate` TIMESTAMP NULL DEFAULT NULL
) ENGINE=MyISAM;

# Dump of table sdsfamily
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsfamily`;

CREATE TABLE `sdsfamily` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note` text,
  `domainId` int(11) DEFAULT NULL COMMENT 'Domain',
  `parentPhysicalId` varchar(50) DEFAULT NULL,
  `creatorUserId` int(11) DEFAULT NULL COMMENT 'Creator User ID',
  `physicalMasterId` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domainId` (`domainId`),
  KEY `parentPhysicalId` (`parentPhysicalId`),
  KEY `physicalMasterId` (`physicalMasterId`),
  CONSTRAINT `sdsfamily_ibfk_1` FOREIGN KEY (`domainId`) REFERENCES `domain` (`id`),
  CONSTRAINT `sdsfamily_ibfk_2` FOREIGN KEY (`physicalMasterId`) REFERENCES `client_physical_masters` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SDS family';



# Dump of table sdsfamilyparents
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsfamilyparents`;

CREATE TABLE `sdsfamilyparents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `familyId` int(11) DEFAULT NULL,
  `revisionId` int(11) NOT NULL,
  `parentId` varchar(50) DEFAULT NULL,
  `healthMasterId` int(11) unsigned DEFAULT NULL,
  `type` enum('physical','health','component') NOT NULL DEFAULT 'component',
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisionId` (`revisionId`,`parentId`,`type`),
  KEY `healthMasterId` (`healthMasterId`),
  KEY `parentId` (`parentId`),
  CONSTRAINT `sdsfamilyparents_ibfk_1` FOREIGN KEY (`revisionId`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sdsfamilyparents_ibfk_2` FOREIGN KEY (`healthMasterId`) REFERENCES `client_health_masters` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sdsfamilyrevision
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsfamilyrevision`;

CREATE TABLE `sdsfamilyrevision` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `appearance` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `odor` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `odorThreshold` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `phValue` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `meltingPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `boilingPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `flashPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `evaporationRate` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `flammability` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `explosionLimitLower` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `explosionLimitUpper` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `vaporPressure` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `densityVapor` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `densityRelative` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `partitionCoefficient` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `autoIgnition` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `decomposition` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `viscosityDynamic` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `viscosityKinematic` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `unNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `properShippingName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `packingGroup` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `familyId` int(11) NOT NULL COMMENT 'Id of family',
  `effectiveDate` datetime NOT NULL,
  `modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `density` tinytext COLLATE utf8_unicode_ci,
  `section3AdditionalInformation` text COLLATE utf8_unicode_ci,
  `section3Description` text COLLATE utf8_unicode_ci,
  `section3ChemicalCharacterization` tinyint(1) unsigned DEFAULT NULL,
  `section4GeneralInformation` text COLLATE utf8_unicode_ci COMMENT 'section 4 general info',
  `section14tunnelRestrictionCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14transportCategory` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14segregationGroups` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14dangerCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14emsNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14marinePollutant` tinyint(1) DEFAULT NULL,
  `section14reportableQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14limitedQuantityException` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14limitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14groundLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `section14groundExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `section14airExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `section14airLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `section14seaLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `section14seaExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'If revision published',
  `isModified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'has UI modifications',
  `section9ExplosiveProperties` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `section9OxidizingProperties` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `familyId` (`familyId`),
  CONSTRAINT `sdsfamilyrevision_ibfk_1` FOREIGN KEY (`familyId`) REFERENCES `sdsfamily` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Base data for SDS revision';



# Dump of table sdshistory
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdshistory`;

CREATE TABLE `sdshistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sdsId` int(11) NOT NULL,
  `execId` int(11) DEFAULT NULL COMMENT 'Execution session id',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `action` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source` enum('api','gui') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sdsId` (`sdsId`),
  KEY `sessionId` (`execId`),
  CONSTRAINT `sdshistory_ibfk_1` FOREIGN KEY (`sdsId`) REFERENCES `sdsstatus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sdshistory_ibfk_2` FOREIGN KEY (`execId`) REFERENCES `cronexec` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='SDS history';



# Dump of table sdsjsoncache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsjsoncache`;

CREATE TABLE `sdsjsoncache` (
  `kitId` int(11) NOT NULL,
  `json` text COLLATE utf8_unicode_ci NOT NULL,
  `typeId` int(11) NOT NULL,
  `languageId` int(11) NOT NULL,
  `versionDate` varchar(12) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `section` int(11) NOT NULL,
  PRIMARY KEY (`kitId`,`typeId`,`languageId`,`versionDate`,`section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Cached JSON sections of SDS detail';



# Dump of table sdslanguage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdslanguage`;

CREATE TABLE `sdslanguage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Languages';



# Dump of table sdsmaster
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsmaster`;

CREATE TABLE `sdsmaster` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Internal Id',
  `outerId` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'OuterId',
  `parentId` int(11) DEFAULT NULL COMMENT 'paren master Id',
  `familyId` int(11) NOT NULL COMMENT 'Id of family',
  `childRevisionDate` datetime DEFAULT NULL COMMENT 'Newest revision date of child product',
  `revisionDate` datetime DEFAULT NULL COMMENT 'Revision date of this product',
  `cpMsdsId` int(11) DEFAULT NULL COMMENT 'MSDS id in CP storage',
  `creatorUserId` int(11) DEFAULT NULL COMMENT 'ID of creator user',
  `isArchived` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag for soft delete',
  `notes` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`),
  KEY `familyId` (`familyId`),
  CONSTRAINT `sdsmaster_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sdsmaster_ibfk_2` FOREIGN KEY (`familyId`) REFERENCES `sdsfamily` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Sds master table';



# Dump of table sdsmaster_emergency_contact
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsmaster_emergency_contact`;

CREATE TABLE `sdsmaster_emergency_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `masterId` int(11) NOT NULL,
  `emergencyContactId` int(11) NOT NULL,
  `jurisdictionId` char(4) DEFAULT 'dflt',
  PRIMARY KEY (`id`),
  UNIQUE KEY `masterEmergencyJurisdiction` (`masterId`,`emergencyContactId`,`jurisdictionId`),
  KEY `masterId` (`masterId`),
  KEY `emergencyContactId` (`emergencyContactId`),
  KEY `jurisdictionId` (`jurisdictionId`),
  CONSTRAINT `sdsmaster_emergency_contact_ibfk_1` FOREIGN KEY (`masterId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sdsmaster_emergency_contact_ibfk_2` FOREIGN KEY (`emergencyContactId`) REFERENCES `emergencycontact` (`id`),
  CONSTRAINT `sdsmaster_emergency_contact_ibfk_3` FOREIGN KEY (`jurisdictionId`) REFERENCES `dict_jurisdictions` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sdsmaster_emergency_contact_copy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsmaster_emergency_contact_copy`;

CREATE TABLE `sdsmaster_emergency_contact_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `masterId` int(11) NOT NULL,
  `emergencyContactId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `masterIdemergencyContactId` (`masterId`,`emergencyContactId`),
  KEY `masterId` (`masterId`),
  KEY `emergencyContactId` (`emergencyContactId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sdsphrase
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsphrase`;

CREATE TABLE `sdsphrase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `languageId` int(11) NOT NULL,
  `translation` text COLLATE utf8_unicode_ci NOT NULL,
  `sectionId` int(11) DEFAULT NULL COMMENT 'id of section',
  `hash` binary(16) NOT NULL COMMENT 'phrase hash',
  PRIMARY KEY (`id`),
  UNIQUE KEY `languageId_2` (`languageId`,`hash`),
  KEY `languageId` (`languageId`),
  CONSTRAINT `sdsphrase_ibfk_1` FOREIGN KEY (`languageId`) REFERENCES `sdslanguage` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Translations';



# Dump of table sdsrevisionmodif
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsrevisionmodif`;

CREATE TABLE `sdsrevisionmodif` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `appearance` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `odor` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `odorThreshold` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `phValue` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `meltingPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `boilingPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `flashPoint` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `evaporationRate` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `flammability` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `explosionLimitLower` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `explosionLimitUpper` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `vaporPressure` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `densityVapor` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `densityRelative` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `density` tinytext COLLATE utf8_unicode_ci,
  `partitionCoefficient` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `autoIgnition` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `decomposition` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `viscosityDynamic` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `viscosityKinematic` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `unNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `properShippingName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `packingGroup` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `section3AdditionalInformation` text COLLATE utf8_unicode_ci,
  `section3Description` text COLLATE utf8_unicode_ci,
  `section3ChemicalCharacterization` tinyint(1) unsigned DEFAULT NULL,
  `section4GeneralInformation` text COLLATE utf8_unicode_ci COMMENT 'section 4 general info',
  `section14tunnelRestrictionCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14transportCategory` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14segregationGroups` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14dangerCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14emsNumber` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14marinePollutant` tinyint(1) DEFAULT NULL,
  `section14reportableQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14limitedQuantityException` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14limitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14groundLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14groundExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14airExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14airLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14seaLimitedQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section14seaExceptionQuantity` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `section9ExplosiveProperties` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `section9OxidizingProperties` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `sdsrevisionmodif_ibfk_1` FOREIGN KEY (`id`) REFERENCES `sdsfamilyrevision` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Revision changes';



# Dump of table sdssection1
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdssection1`;

CREATE TABLE `sdssection1` (
  `id` int(11) NOT NULL COMMENT 'Internal Id',
  `name` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'SDS name',
  `modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'modified date',
  `typeId` int(11) NOT NULL COMMENT 'SDS type id',
  `tradeName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `usage` text COLLATE utf8_unicode_ci NOT NULL,
  `usageAdvisedAgainst` text COLLATE utf8_unicode_ci COMMENT 'Usage advised against',
  `reasonsAdvisedAgainst` text COLLATE utf8_unicode_ci COMMENT 'Reasons advised against',
  `manufacturerId` int(11) DEFAULT NULL,
  `supplierId` int(11) DEFAULT NULL,
  `manufacturerProductId` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `synonyms` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `revisionDate` datetime DEFAULT NULL,
  `effectiveDate` datetime NOT NULL COMMENT 'doc effective date',
  `additional` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reachId` text COLLATE utf8_unicode_ci COMMENT 'REACH ID',
  `chineseName` text COLLATE utf8_unicode_ci,
  `accessToSds` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `manufacturerId` (`manufacturerId`),
  KEY `supplierId` (`supplierId`),
  CONSTRAINT `sdssection1_ibfk_1` FOREIGN KEY (`id`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sdssection1_ibfk_2` FOREIGN KEY (`manufacturerId`) REFERENCES `manufacturer` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `sdssection1_ibfk_3` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Sds section 1 data';



# Dump of table sdsstatus
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdsstatus`;

CREATE TABLE `sdsstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `outerId` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('created','updated','deleted') COLLATE utf8_unicode_ci NOT NULL,
  `modifiedDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='SDS status';



# Dump of table sdstype
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sdstype`;

CREATE TABLE `sdstype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `alias` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Type alias',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='SDS types';



# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varbinary(128) NOT NULL,
  `data` blob NOT NULL,
  `time` int(10) unsigned NOT NULL,
  `lifetime` mediumint(9) NOT NULL,
  `expire` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



# Dump of table settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `settings`;

CREATE TABLE `settings` (
  `client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `msds_expiration_years` tinyint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table substances
# ------------------------------------------------------------

DROP TABLE IF EXISTS `substances`;

CREATE TABLE `substances` (
  `substance_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `substance_name` varchar(80) NOT NULL DEFAULT '',
  `cas_number` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`substance_id`),
  KEY `cas_number` (`cas_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table substances_regulatory_reporting
# ------------------------------------------------------------

DROP TABLE IF EXISTS `substances_regulatory_reporting`;

CREATE TABLE `substances_regulatory_reporting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cas_number` varchar(80) NOT NULL,
  `sara_302` tinyint(1) DEFAULT NULL,
  `sara_311_312_acute` tinyint(1) DEFAULT NULL,
  `sara_311_312_chronic` tinyint(1) DEFAULT NULL,
  `sara_311_312_fire` tinyint(1) DEFAULT NULL,
  `sara_311_312_presure` tinyint(1) DEFAULT NULL,
  `sara_311_312_reactive` tinyint(1) DEFAULT NULL,
  `sara_313` tinyint(1) DEFAULT NULL,
  `rcra_p` tinyint(1) DEFAULT NULL,
  `rcra_u` tinyint(1) DEFAULT NULL,
  `rcra_k` tinyint(1) DEFAULT NULL,
  `rcra_f` tinyint(1) DEFAULT NULL,
  `rcra_d` tinyint(1) DEFAULT NULL,
  `haps` tinyint(1) DEFAULT NULL,
  `cercla_rq` int(11) DEFAULT NULL,
  `302_tpq` text,
  `304_rq` text,
  `112_tq` text,
  `p65_cancer` tinyint(1) DEFAULT NULL,
  `p65_developmental` tinyint(1) DEFAULT NULL,
  `p65_m_reproductive` tinyint(1) DEFAULT NULL,
  `p65_f_reproductive` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cas_number` (`cas_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table substances_regulatory_reporting_copy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `substances_regulatory_reporting_copy`;

CREATE TABLE `substances_regulatory_reporting_copy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cas_number` varchar(80) NOT NULL,
  `sara_302` tinyint(1) DEFAULT NULL,
  `sara_311_312_acute` tinyint(1) DEFAULT NULL,
  `sara_311_312_chronic` tinyint(1) DEFAULT NULL,
  `sara_311_312_fire` tinyint(1) DEFAULT NULL,
  `sara_311_312_presure` tinyint(1) DEFAULT NULL,
  `sara_311_312_reactive` tinyint(1) DEFAULT NULL,
  `sara_313` tinyint(1) DEFAULT NULL,
  `rcra_p` tinyint(1) DEFAULT NULL,
  `rcra_u` tinyint(1) DEFAULT NULL,
  `rcra_k` tinyint(1) DEFAULT NULL,
  `rcra_f` tinyint(1) DEFAULT NULL,
  `rcra_d` tinyint(1) DEFAULT NULL,
  `haps` tinyint(1) DEFAULT NULL,
  `cercla_rq` int(11) DEFAULT NULL,
  `302_tpq` decimal(10,0) DEFAULT NULL,
  `304_rq` decimal(10,0) DEFAULT NULL,
  `112_tq` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cas_number` (`cas_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table supplier
# ------------------------------------------------------------

DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nameAlt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Address parts except street',
  `phone` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `domainId` int(11) DEFAULT NULL,
  `countryId` int(11) DEFAULT NULL,
  `headerDisplay` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FullIndex` (`name`,`nameAlt`,`street`,`address`),
  KEY `countryId` (`countryId`),
  CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `dict_countries` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Supplier';



# Dump of table supplier_id
# ------------------------------------------------------------

DROP TABLE IF EXISTS `supplier_id`;

CREATE TABLE `supplier_id` (
  `id` int(11) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table supplier_sdsmaster
# ------------------------------------------------------------

DROP TABLE IF EXISTS `supplier_sdsmaster`;

CREATE TABLE `supplier_sdsmaster` (
  `productId` int(11) NOT NULL,
  `contactId` int(11) NOT NULL,
  `jurisdictionId` char(4) DEFAULT 'dflt',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productId` (`productId`,`contactId`,`jurisdictionId`),
  KEY `contactId` (`contactId`),
  KEY `jurisdictionId` (`jurisdictionId`),
  CONSTRAINT `supplier_sdsmaster_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `sdsmaster` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `supplier_sdsmaster_ibfk_2` FOREIGN KEY (`contactId`) REFERENCES `supplier` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `supplier_sdsmaster_ibfk_3` FOREIGN KEY (`jurisdictionId`) REFERENCES `dict_jurisdictions` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table temp_scan
# ------------------------------------------------------------

DROP TABLE IF EXISTS `temp_scan`;

CREATE TABLE `temp_scan` (
  `id` int(11) NOT NULL COMMENT 'Scan id',
  `userId` int(11) NOT NULL COMMENT 'User id',
  `typeId` int(11) NOT NULL COMMENT 'MSDS Type id',
  `langId` int(11) NOT NULL COMMENT 'Language id',
  `msdsId` int(11) NOT NULL COMMENT 'MSDS id',
  PRIMARY KEY (`id`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Temporary scan data';



# Dump of table templatelanguage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatelanguage`;

CREATE TABLE `templatelanguage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `templateId` int(10) unsigned NOT NULL,
  `languageId` int(10) unsigned NOT NULL,
  `languageCode` char(5) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `templateId` (`templateId`,`languageCode`),
  KEY `fk_lang_code` (`languageCode`),
  KEY `fk_lang_id` (`languageId`),
  CONSTRAINT `fk_lang_code` FOREIGN KEY (`languageCode`) REFERENCES `dict_language` (`alias`),
  CONSTRAINT `fk_lang_id` FOREIGN KEY (`languageId`) REFERENCES `dict_language` (`id`),
  CONSTRAINT `fk_template` FOREIGN KEY (`templateId`) REFERENCES `dict_pdftemplate` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templates
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templates`;

CREATE TABLE `templates` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template_name` varchar(80) DEFAULT NULL,
  `client_id` int(10) unsigned DEFAULT NULL,
  `border_color_code` varchar(7) DEFAULT NULL,
  `outter_background_color_code` varchar(7) DEFAULT NULL,
  `inner_background_color_code` varchar(7) DEFAULT NULL,
  `table_header_background_color_code` varchar(7) DEFAULT NULL,
  `table_row1_background_color_code` varchar(7) DEFAULT NULL,
  `table_row2_background_color_code` varchar(7) DEFAULT NULL,
  `template_images_flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table text_replace_report
# ------------------------------------------------------------

DROP TABLE IF EXISTS `text_replace_report`;

CREATE TABLE `text_replace_report` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entity` varchar(255) NOT NULL DEFAULT '',
  `entityClass` varchar(255) NOT NULL DEFAULT '',
  `entityId` varchar(255) NOT NULL DEFAULT '',
  `familyId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `string` varchar(500) NOT NULL DEFAULT '',
  `replace` varchar(500) NOT NULL DEFAULT '',
  `dt` datetime NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `domainId` int(11) DEFAULT NULL,
  `cas` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table translation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `translation`;

CREATE TABLE `translation` (
  `id` int(10) unsigned NOT NULL,
  `md5` char(32) DEFAULT NULL,
  `language` char(5) NOT NULL,
  `translation` text NOT NULL,
  UNIQUE KEY `idLang` (`id`,`language`),
  UNIQUE KEY `id` (`id`,`language`),
  KEY `langId` (`language`,`id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table translationsource
# ------------------------------------------------------------

DROP TABLE IF EXISTS `translationsource`;

CREATE TABLE `translationsource` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `md5` char(32) DEFAULT NULL,
  `category` varchar(20) DEFAULT NULL,
  `message` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5` (`md5`),
  KEY `categoryMessage` (`category`,`message`(128)),
  KEY `message` (`message`(128))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fullname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pwd` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT 'MD5 of password',
  `roleId` int(11) NOT NULL,
  `invitationDate` datetime DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `domainId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='User';



# Dump of table user_invitation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_invitation`;

CREATE TABLE `user_invitation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creationDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `uniqueHash` varchar(100) NOT NULL,
  `userId` int(11) NOT NULL,
  `consumed` int(1) NOT NULL DEFAULT '0',
  `active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueHash_UNIQUE` (`uniqueHash`),
  UNIQUE KEY `id` (`id`,`uniqueHash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Registration of invitations';



# Dump of table user_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_type`;

CREATE TABLE `user_type` (
  `user_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_type_name` varchar(24) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_email` varchar(80) NOT NULL DEFAULT '',
  `user_password` varchar(64) NOT NULL DEFAULT '',
  `user_first_name` varchar(80) NOT NULL DEFAULT '',
  `user_last_name` varchar(80) NOT NULL DEFAULT '',
  `user_phone` varchar(80) NOT NULL DEFAULT '',
  `user_status_flag` tinyint(1) NOT NULL DEFAULT '1',
  `user_screen_lock_flag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table webservice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `webservice`;

CREATE TABLE `webservice` (
  `ws_id` int(11) NOT NULL AUTO_INCREMENT,
  `webservice_id` varchar(128) NOT NULL,
  `scan_count` tinyint(4) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ws_id`),
  UNIQUE KEY `webservice_id` (`webservice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table webservice_msds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `webservice_msds`;

CREATE TABLE `webservice_msds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `webservice_id` varchar(128) NOT NULL,
  `msds_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `webservice_id` (`webservice_id`),
  KEY `msds_id` (`msds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table webservice_msds_BAK
# ------------------------------------------------------------

DROP TABLE IF EXISTS `webservice_msds_BAK`;

CREATE TABLE `webservice_msds_BAK` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `webservice_id` varchar(128) NOT NULL,
  `msds_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `webservice_id` (`webservice_id`),
  KEY `msds_id` (`msds_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table webservice_msds_scan
# ------------------------------------------------------------

DROP TABLE IF EXISTS `webservice_msds_scan`;

CREATE TABLE `webservice_msds_scan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ws_id` int(11) NOT NULL,
  `msds_scan_id` int(11) NOT NULL,
  `sort_order` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `webservice_id` (`ws_id`,`msds_scan_id`),
  KEY `msds_scan_id` (`msds_scan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table worker_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `worker_log`;

CREATE TABLE `worker_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `startTs` datetime NOT NULL,
  `finishTs` datetime DEFAULT NULL,
  `output` mediumtext NOT NULL,
  `finished` tinyint(1) NOT NULL,
  `errors` mediumtext NOT NULL,
  `hasErrors` tinyint(1) NOT NULL,
  `lastProcessedId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table workerlog_aux
# ------------------------------------------------------------

DROP TABLE IF EXISTS `workerlog_aux`;

CREATE TABLE `workerlog_aux` (
  `id` int(11) NOT NULL,
  `output` mediumtext NOT NULL,
  `trace` mediumtext NOT NULL,
  `error` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `workerlog_aux_ibfk_1` FOREIGN KEY (`id`) REFERENCES `workerlog_main` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Aux worker log data';



# Dump of table workerlog_main
# ------------------------------------------------------------

DROP TABLE IF EXISTS `workerlog_main`;

CREATE TABLE `workerlog_main` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `startTs` datetime NOT NULL,
  `finishTs` datetime DEFAULT NULL,
  `heartbeatTs` datetime DEFAULT NULL,
  `processedNumber` int(11) DEFAULT NULL,
  `lastProcessedId` int(11) DEFAULT NULL,
  `tags` varchar(100) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `finished` tinyint(4) DEFAULT NULL,
  `hasErrors` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Replace placeholder table for sdsdetailview with correct view syntax
# ------------------------------------------------------------

DROP TABLE `sdsdetailview`;

CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `sdsdetailview`
AS SELECT
   `m`.`accessToSds` AS `accessToSds`,
   `m`.`chineseName` AS `chineseName`,
   `t`.`id` AS `masterId`,
   `t`.`outerId` AS `outerId`,
   `t`.`parentId` AS `parentId`,
   `t`.`cpMsdsId` AS `cpMsdsId`,
   `r`.`id` AS `revisionId`,
   `r`.`id` AS `id`,
   `r`.`familyId` AS `familyId`,
   `r`.`effectiveDate` AS `effectiveDate`,
   `r`.`modifiedDate` AS `modifiedDate`,
   `r`.`section3AdditionalInformation` AS `section3AdditionalInformation`,
   `r`.`section3Description` AS `section3Description`,
   `r`.`section3ChemicalCharacterization` AS `section3ChemicalCharacterization`,
   `r`.`section4GeneralInformation` AS `section4GeneralInformation`,
   `r`.`published` AS `published`,
   `r`.`isModified` AS `isModified`,
   `d`.`hash` AS `hash`,
   `k`.`outerId` AS `kitOuterId`,
   `mf`.`name` AS `manufacturerName`,
   `mf`.`nameAlt` AS `manufacturerNameAlt`,
   `mf`.`address` AS `manufacturerAddress`,
   `mf`.`street` AS `manufacturerStreet`,
   `mf`.`phone` AS `manufacturerPhone`,
   `mf`.`website` AS `manufacturerWebsite`,
   `mf`.`email` AS `manufacturerEmail`,
   `mf`.`logo` AS `manufacturerLogo`,
   `s`.`name` AS `supplierName`,
   `s`.`nameAlt` AS `supplierNameAlt`,
   `s`.`address` AS `supplierAddress`,
   `s`.`street` AS `supplierStreet`,
   `s`.`phone` AS `supplierPhone`,
   `s`.`website` AS `supplierWebsite`,
   `s`.`email` AS `supplierEmail`,
   `m`.`name` AS `name`,
   `m`.`tradeName` AS `tradeName`,
   `m`.`usage` AS `usage`,
   `m`.`usageAdvisedAgainst` AS `usageAdvisedAgainst`,
   `m`.`reasonsAdvisedAgainst` AS `reasonsAdvisedAgainst`,
   `m`.`synonyms` AS `synonyms`,
   `m`.`effectiveDate` AS `docEffectiveDate`,
   `m`.`additional` AS `additionalInfo`,if(isnull(`f`.`parentPhysicalId`),`r`.`appearance`,
   `ps`.`appearance`) AS `appearance`,if(isnull(`f`.`parentPhysicalId`),`r`.`odor`,
   `ps`.`odor`) AS `odor`,if(isnull(`f`.`parentPhysicalId`),`r`.`odorThreshold`,
   `ps`.`odorThreshold`) AS `odorThreshold`,if(isnull(`f`.`parentPhysicalId`),`r`.`phValue`,
   `ps`.`phValue`) AS `phValue`,if(isnull(`f`.`parentPhysicalId`),`r`.`meltingPoint`,
   `ps`.`meltingPoint`) AS `meltingPoint`,if(isnull(`f`.`parentPhysicalId`),`r`.`boilingPoint`,
   `ps`.`boilingPoint`) AS `boilingPoint`,if(isnull(`f`.`parentPhysicalId`),`r`.`flashPoint`,
   `ps`.`flashPoint`) AS `flashPoint`,if(isnull(`f`.`parentPhysicalId`),`r`.`evaporationRate`,
   `ps`.`evaporationRate`) AS `evaporationRate`,if(isnull(`f`.`parentPhysicalId`),`r`.`flammability`,
   `ps`.`flammability`) AS `flammability`,if(isnull(`f`.`parentPhysicalId`),`r`.`explosionLimitLower`,
   `ps`.`explosionLimitLower`) AS `explosionLimitLower`,if(isnull(`f`.`parentPhysicalId`),`r`.`explosionLimitUpper`,
   `ps`.`explosionLimitUpper`) AS `explosionLimitUpper`,if(isnull(`f`.`parentPhysicalId`),`r`.`vaporPressure`,
   `ps`.`vaporPressure`) AS `vaporPressure`,if(isnull(`f`.`parentPhysicalId`),`r`.`densityVapor`,
   `ps`.`densityVapor`) AS `densityVapor`,if(isnull(`f`.`parentPhysicalId`),`r`.`densityRelative`,
   `ps`.`densityRelative`) AS `densityRelative`,if(isnull(`f`.`parentPhysicalId`),`r`.`partitionCoefficient`,
   `ps`.`partitionCoefficient`) AS `partitionCoefficient`,if(isnull(`f`.`parentPhysicalId`),`r`.`autoIgnition`,
   `ps`.`autoIgnition`) AS `autoIgnition`,if(isnull(`f`.`parentPhysicalId`),`r`.`decomposition`,
   `ps`.`decomposition`) AS `decomposition`,if(isnull(`f`.`parentPhysicalId`),`r`.`viscosityDynamic`,
   `ps`.`viscosityDynamic`) AS `viscosityDynamic`,if(isnull(`f`.`parentPhysicalId`),`r`.`viscosityKinematic`,
   `ps`.`viscosityKinematic`) AS `viscosityKinematic`,if(isnull(`f`.`parentPhysicalId`),`r`.`unNumber`,
   `ps`.`unNumber`) AS `unNumber`,if(isnull(`f`.`parentPhysicalId`),`r`.`properShippingName`,
   `ps`.`properShippingName`) AS `properShippingName`,if(isnull(`f`.`parentPhysicalId`),`r`.`packingGroup`,
   `ps`.`packingGroup`) AS `packingGroup`,if(isnull(`f`.`parentPhysicalId`),`r`.`density`,
   `ps`.`density`) AS `density`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14tunnelRestrictionCode`,
   `ps`.`section14tunnelRestrictionCode`) AS `section14tunnelRestrictionCode`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14transportCategory`,
   `ps`.`section14transportCategory`) AS `section14transportCategory`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14segregationGroups`,
   `ps`.`section14segregationGroups`) AS `section14segregationGroups`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14dangerCode`,
   `ps`.`section14dangerCode`) AS `section14dangerCode`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14emsNumber`,
   `ps`.`section14emsNumber`) AS `section14emsNumber`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14marinePollutant`,
   `ps`.`section14marinePollutant`) AS `section14marinePollutant`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14reportableQuantity`,
   `ps`.`section14reportableQuantity`) AS `section14reportableQuantity`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14limitedQuantityException`,
   `ps`.`section14limitedQuantityException`) AS `section14limitedQuantityException`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14limitedQuantity`,
   `ps`.`section14limitedQuantity`) AS `section14limitedQuantity`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14groundLimitedQuantity`,
   `ps`.`section14groundLimitedQuantity`) AS `section14groundLimitedQuantity`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14groundExceptionQuantity`,
   `ps`.`section14groundExceptionQuantity`) AS `section14groundExceptionQuantity`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14airExceptionQuantity`,
   `ps`.`section14airExceptionQuantity`) AS `section14airExceptionQuantity`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14airLimitedQuantity`,
   `ps`.`section14airLimitedQuantity`) AS `section14airLimitedQuantity`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14seaLimitedQuantity`,
   `ps`.`section14seaLimitedQuantity`) AS `section14seaLimitedQuantity`,if(isnull(`f`.`parentPhysicalId`),`r`.`section14seaExceptionQuantity`,
   `ps`.`section14seaExceptionQuantity`) AS `section14seaExceptionQuantity`,if((`m`.`modifiedDate` > `r`.`modifiedDate`),`m`.`modifiedDate`,
   `r`.`modifiedDate`) AS `lastModifiedDate`
FROM (((((((((`sdsmaster` `t` left join `sdssection1` `m` on((`m`.`id` = `t`.`id`)))
    left join `sdsfamily` `f` on((`t`.`familyId` = `f`.`id`)))
    left join `sdsfamilyrevision` `r` on((`r`.`familyId` = `f`.`id`)))
    left join `parent_sections` `ps` on((`t`.`id` = `ps`.`masterId`)))
    left join `kitsdsmaster` `ks` on((`ks`.`masterId` = `m`.`id`)))
    left join `kit` `k` on((`k`.`id` = `ks`.`kitId`)))
    left join `domain` `d` on((`d`.`id` = `k`.`domainId`)))
     left join `manufacturer` `mf` on((`mf`.`id` = `m`.`manufacturerId`)))
     left join `supplier` `s` on((`s`.`id` = `m`.`supplierId`)))
     where ((`r`.`published` = 1) and (`t`.`isArchived` = 0))
     order by if((`m`.`modifiedDate` > `r`.`modifiedDate`),`m`.`modifiedDate`,`r`.`modifiedDate`) desc;

DROP TABLE IF EXISTS `jurisdiction_templates`;

CREATE TABLE `jurisdiction_templates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `jurisdictionId` char(4) NOT NULL DEFAULT '',
  `templateId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `templateId` (`templateId`,`jurisdictionId`),
  KEY `jurisdictionId` (`jurisdictionId`),
  CONSTRAINT `jurisdiction_template_ibfk_1` FOREIGN KEY (`jurisdictionId`) REFERENCES `dict_jurisdictions` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `jurisdiction_template_ibfk_2` FOREIGN KEY (`templateId`) REFERENCES `dict_pdftemplate` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ghs_label_element_health_priorities`;

CREATE TABLE `ghs_label_element_health_priorities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `classification` varchar(500) NOT NULL,
  `healthHazardRules` JSON NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classification` (`classification`),
  CONSTRAINT `ghs_label_element_health_priorities_ibfk_1` FOREIGN KEY (`classification`) REFERENCES `dict_ghs_label_element` (`statement`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
