-- MySQL dump 10.13  Distrib 9.6.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: videonest
-- ------------------------------------------------------
-- Server version	8.4.11

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dead_letter_record`
--

DROP TABLE IF EXISTS `dead_letter_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dead_letter_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `queue_name` varchar(128) NOT NULL COMMENT 'æ­»ä¿¡æ¥æºé˜Ÿåˆ—',
  `message_type` varchar(32) NOT NULL COMMENT 'ä¸šåŠ¡æ¶ˆæ¯ç±»åž‹',
  `business_id` varchar(64) DEFAULT NULL COMMENT 'å…³è”ä¸šåŠ¡ID',
  `payload` text NOT NULL COMMENT 'åŽŸå§‹æ¶ˆæ¯ä½“',
  `failure_reason` varchar(500) DEFAULT NULL COMMENT 'æ­»ä¿¡åŽŸå› ',
  `status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING/RETRIED/IGNORED',
  `operator_id` bigint DEFAULT NULL COMMENT 'æœ€åŽå¤„ç†ç®¡ç†å‘˜ID',
  `handled_at` datetime DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_dead_letter_status_time` (`status`,`create_time`),
  KEY `idx_dead_letter_business` (`message_type`,`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='RabbitMQæ­»ä¿¡å¤„ç†è®°å½•';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dead_letter_record`
--

LOCK TABLES `dead_letter_record` WRITE;
/*!40000 ALTER TABLE `dead_letter_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `dead_letter_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flyway_schema_history`
--

DROP TABLE IF EXISTS `flyway_schema_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flyway_schema_history` (
  `installed_rank` int NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `flyway_schema_history_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flyway_schema_history`
--

LOCK TABLES `flyway_schema_history` WRITE;
/*!40000 ALTER TABLE `flyway_schema_history` DISABLE KEYS */;
INSERT INTO `flyway_schema_history` VALUES (1,'3','<< Flyway Baseline >>','BASELINE','<< Flyway Baseline >>',NULL,'root','2026-08-21 15:00:10',0,1),(2,'4','hot upload query hardening','SQL','V4__hot_upload_query_hardening.sql',-1929547773,'root','2026-08-21 15:00:10',109,1),(3,'5','media delivery','SQL','V5__media_delivery.sql',-1552852556,'root','2026-08-21 15:00:10',16,1),(4,'6','add comment root id','SQL','V6__add_comment_root_id.sql',-1327195583,'root','2026-08-21 15:00:10',60,1),(5,'7','transactional outbox','SQL','V7__transactional_outbox.sql',-1785858285,'root','2026-08-21 15:00:10',35,1);
/*!40000 ALTER TABLE `flyway_schema_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_id` varchar(64) NOT NULL COMMENT 'æ¶ˆæ¯å¹‚ç­‰ä¸šåŠ¡é”®',
  `recipient_id` bigint NOT NULL COMMENT 'é€šçŸ¥æŽ¥æ”¶ç”¨æˆ·ID',
  `actor_id` bigint NOT NULL COMMENT 'è§¦å‘é€šçŸ¥ç”¨æˆ·ID',
  `type` varchar(32) NOT NULL COMMENT 'é€šçŸ¥ç±»åž‹',
  `video_id` bigint DEFAULT NULL,
  `comment_id` bigint DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `is_read` tinyint NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_notification_event_id` (`event_id`),
  KEY `idx_notification_recipient_read_time` (`recipient_id`,`is_read`,`create_time`),
  KEY `idx_notification_video_id` (`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='ç«™å†…é€šçŸ¥è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (1,'18e8d257-54e5-405d-93e6-4e21d56e7aa5',1,5,'LIKE',2,NULL,'点赞了你的视频',0,'2026-07-30 00:35:48'),(2,'df346651-0cfa-4827-89de-8e2c6a51aecc',1,5,'FAVORITE',2,NULL,'收藏了你的视频',0,'2026-07-30 00:35:48'),(3,'a8b90c9c-a1de-488e-80cb-cd27429f684e',1,5,'FOLLOW',NULL,NULL,'关注了你',0,'2026-07-30 00:35:49'),(4,'a05a5d21-50be-4da6-96db-68d71f598857',1,5,'COMMENT',2,2082505401594187778,'111',0,'2026-07-30 00:35:53'),(5,'86beb9b4-177d-4e27-88a1-1e0b0f5d8ff6',5,1,'LIKE',5,NULL,'点赞了你的视频',0,'2026-07-30 00:38:02'),(6,'b4a37e31-f447-4220-9eaf-964f8e3339ce',5,1,'FAVORITE',5,NULL,'收藏了你的视频',0,'2026-07-30 00:38:03'),(7,'4eb0a857-8d10-4283-98d8-87f1194bdc8a',5,1,'COMMENT',5,2082505960585859074,'6666',0,'2026-07-30 00:38:06'),(8,'0166d7dd-5dc0-4c06-9e5a-82ef432b8103',1,1,'VIDEO_REJECTED',6,NULL,'测试驳回消息',0,'2026-07-30 00:50:39'),(9,'befd0554-b3e1-45d4-b510-92e0da14d5ff',5,1,'VIDEO_REJECTED',8,NULL,'测试',0,'2026-07-30 01:03:01'),(10,'8ace5219-e80e-4956-a6d7-6b7b1f713ccd',1,5,'COMMENT',2,2082524108516544514,'666',0,'2026-07-30 01:50:13'),(11,'4ef491f7-32a0-4ece-8db6-c46ec3958a06',1,5,'LIKE',2,NULL,'点赞了你的视频',0,'2026-07-30 01:50:16'),(12,'d32b8f98-f2d7-439c-9afd-9160569e04ae',5,1,'FOLLOW',NULL,NULL,'关注了你',0,'2026-07-30 01:55:02'),(13,'fa4d8512-25d2-48a0-bab0-f70c8a856bb5',5,5,'REVIEW_TIMEOUT',10,NULL,'你的视频等待审核已超时，管理员会尽快处理',0,'2026-08-02 14:14:53');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbox_event`
--

DROP TABLE IF EXISTS `outbox_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outbox_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_id` varchar(64) NOT NULL,
  `event_type` varchar(64) NOT NULL,
  `exchange_name` varchar(128) NOT NULL,
  `routing_key` varchar(128) NOT NULL,
  `payload` text NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'PENDING',
  `retry_count` int NOT NULL DEFAULT '0',
  `next_retry_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_error` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sent_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_outbox_event_id` (`event_id`),
  KEY `idx_outbox_pending` (`status`,`next_retry_at`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='事务消息发件箱';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbox_event`
--

LOCK TABLES `outbox_event` WRITE;
/*!40000 ALTER TABLE `outbox_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `outbox_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ç”¨æˆ·ID',
  `username` varchar(32) NOT NULL COMMENT 'ç”¨æˆ·å',
  `password` varchar(100) NOT NULL COMMENT 'BCryptåŠ å¯†å¯†ç ',
  `nickname` varchar(32) NOT NULL COMMENT 'æ˜µç§°',
  `role` varchar(20) NOT NULL DEFAULT 'USER' COMMENT 'è§’è‰²ï¼šUSERã€ADMIN',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT 'çŠ¶æ€ï¼š1æ­£å¸¸ï¼Œ0ç¦ç”¨',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='ç”¨æˆ·è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','$2a$10$NutmnMSrIZW1L3ysym0TY.Nux/2ka/FhP8Yj0F4.Q5Ta4KsNslYXG','系统管理员','ADMIN',1,'2026-07-30 00:15:09','2026-07-30 00:22:39'),(2,'user01','$2a$10$xG.xGGQiJs0E06uWuVK/RulFKvJY/wcewh.vAh6Te1FNYSygc9Hni','测试用户一','USER',1,'2026-07-30 00:15:09','2026-07-30 00:15:09'),(3,'user02','$2a$10$G4voi4957.P68/gHQNwvdOkr8uFprGrONyjVW3zgjQ.A3UnCijs1S','测试用户二','USER',1,'2026-07-30 00:15:09','2026-07-30 00:15:09'),(5,'1111','$2a$10$XJ0PRUdBLdm0u384KKZbKOkleoon/nhJ8Ta1Rm1X3el0cBJb9SubC','1111','USER',1,'2026-07-30 00:23:16','2026-07-30 00:23:16');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_follow`
--

DROP TABLE IF EXISTS `user_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_follow` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `follower_id` bigint NOT NULL COMMENT 'å‘èµ·å…³æ³¨çš„ç”¨æˆ· ID',
  `followee_id` bigint NOT NULL COMMENT 'è¢«å…³æ³¨çš„ç”¨æˆ· ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_follower_followee` (`follower_id`,`followee_id`),
  KEY `idx_followee_created` (`followee_id`,`created_at`),
  KEY `idx_follower_created` (`follower_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='ç”¨æˆ·å…³æ³¨å…³ç³»è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_follow`
--

LOCK TABLES `user_follow` WRITE;
/*!40000 ALTER TABLE `user_follow` DISABLE KEYS */;
INSERT INTO `user_follow` VALUES (1,5,1,'2026-07-30 00:35:49'),(2,1,5,'2026-07-30 01:55:02');
/*!40000 ALTER TABLE `user_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video`
--

DROP TABLE IF EXISTS `video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'è§†é¢‘ID',
  `author_id` bigint NOT NULL COMMENT 'æŠ•ç¨¿ç”¨æˆ·ID',
  `category_id` bigint NOT NULL COMMENT 'åˆ†åŒºID',
  `title` varchar(100) NOT NULL COMMENT 'è§†é¢‘æ ‡é¢˜',
  `description` varchar(2000) DEFAULT NULL COMMENT 'è§†é¢‘ç®€ä»‹',
  `cover_url` varchar(500) DEFAULT NULL COMMENT 'å°é¢åœ°å€',
  `original_cover_url` varchar(500) DEFAULT NULL COMMENT '用户上传的原始封面对象名，不直接返回给浏览器',
  `cover_list_url` varchar(500) DEFAULT NULL COMMENT '400px 列表封面对象名',
  `cover_detail_url` varchar(500) DEFAULT NULL COMMENT '1080px 详情封面对象名',
  `video_url` varchar(500) DEFAULT NULL COMMENT 'è§†é¢‘åœ°å€',
  `original_video_url` varchar(500) DEFAULT NULL COMMENT 'ç”¨æˆ·ä¸Šä¼ çš„åŽŸå§‹è§†é¢‘å¯¹è±¡å',
  `video_480p_url` varchar(500) DEFAULT NULL COMMENT '480P è§†é¢‘å¯¹è±¡å',
  `video_720p_url` varchar(500) DEFAULT NULL COMMENT '720P è§†é¢‘å¯¹è±¡å',
  `video_1080p_url` varchar(500) DEFAULT NULL COMMENT '1080P è§†é¢‘å¯¹è±¡å',
  `duration` int NOT NULL DEFAULT '0' COMMENT 'æ—¶é•¿ï¼Œå•ä½ç§’',
  `status` varchar(20) NOT NULL DEFAULT 'DRAFT' COMMENT 'DRAFT/PENDING/PUBLISHED/REJECTED',
  `reject_reason` varchar(500) DEFAULT NULL COMMENT 'å®¡æ ¸é©³å›žåŽŸå› ',
  `process_error` varchar(1000) DEFAULT NULL COMMENT 'è½¬ç å¤±è´¥åŽŸå› ',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT 'é€»è¾‘åˆ é™¤æ ‡è®°ï¼š0æ­£å¸¸ï¼Œ1å·²åˆ é™¤',
  `deleted_at` datetime DEFAULT NULL COMMENT 'è¿›å…¥å›žæ”¶ç«™æ—¶é—´',
  `deleted_by` bigint DEFAULT NULL COMMENT 'æ‰§è¡Œè½¯åˆ é™¤çš„ç”¨æˆ·ID',
  `purge_after` datetime DEFAULT NULL COMMENT 'å…è®¸æ°¸ä¹…æ¸…ç†èµ„æºçš„æ—¶é—´',
  `purge_attempts` int NOT NULL DEFAULT '0' COMMENT 'èµ„æºæ¸…ç†å°è¯•æ¬¡æ•°',
  `purge_error` varchar(1000) DEFAULT NULL COMMENT 'æœ€è¿‘ä¸€æ¬¡èµ„æºæ¸…ç†å¤±è´¥åŽŸå› ',
  `review_deadline` datetime DEFAULT NULL COMMENT 'å®¡æ ¸è¶…æ—¶æ—¶é—´',
  `review_timeout_notified` tinyint NOT NULL DEFAULT '0' COMMENT 'å®¡æ ¸è¶…æ—¶é€šçŸ¥æ ‡è®°',
  `view_count` bigint NOT NULL DEFAULT '0' COMMENT 'æ’­æ”¾é‡',
  `like_count` bigint NOT NULL DEFAULT '0' COMMENT 'ç‚¹èµžæ•°',
  `favorite_count` bigint NOT NULL DEFAULT '0' COMMENT 'æ”¶è—æ•°',
  `publish_time` datetime DEFAULT NULL COMMENT 'å‘å¸ƒæ—¶é—´',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_video_original_object` (`original_video_url`),
  KEY `idx_video_category_publish` (`category_id`,`publish_time`),
  KEY `idx_video_author` (`author_id`),
  KEY `idx_video_status_publish` (`status`,`publish_time`),
  KEY `idx_video_deleted_purge` (`is_deleted`,`purge_after`),
  KEY `idx_video_review_timeout` (`status`,`review_deadline`,`review_timeout_notified`),
  KEY `idx_video_publish_feed` (`status`,`is_deleted`,`publish_time`,`id`),
  KEY `idx_video_category_feed` (`category_id`,`status`,`is_deleted`,`publish_time`,`id`),
  KEY `idx_video_author_feed` (`author_id`,`is_deleted`,`create_time`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='è§†é¢‘è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video`
--

LOCK TABLES `video` WRITE;
/*!40000 ALTER TABLE `video` DISABLE KEYS */;
INSERT INTO `video` VALUES (1,1,4,'Spring Boot 从零搭建视频平台','VideoNest 项目后端开发记录。','https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',NULL,NULL,NULL,'https://www.w3schools.com/html/mov_bbb.mp4',NULL,NULL,NULL,NULL,600,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,130,18,5,'2026-07-30 00:07:43','2026-07-30 00:07:43','2026-07-30 01:58:05'),(2,1,6,'Vue 3 登录注册页面开发','使用 Vue 3、TypeScript、Element Plus 完成登录注册。','https://images.unsplash.com/photo-1499750310107-5fef28a66643?auto=format&fit=crop&w=800&q=80',NULL,NULL,NULL,'https://www.w3schools.com/html/mov_bbb.mp4',NULL,NULL,NULL,NULL,420,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,100,13,4,'2026-07-30 00:07:43','2026-07-30 00:07:43','2026-07-30 01:50:16'),(3,1,5,'我的 Java 后端实习项目记录','记录一个视频社区平台从零开发的过程。','https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=800',NULL,NULL,NULL,'https://www.w3schools.com/html/mov_bbb.mp4',NULL,NULL,NULL,NULL,300,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,76,9,2,'2026-07-30 00:07:43','2026-07-30 00:07:43','2026-07-30 00:38:10'),(5,5,3,'2','2222','cover/processed/5/detail-1080.jpg','cover/2026-07-29/63d31a38-ca13-4f92-ac9e-3cd23208a9b5.png','cover/processed/5/list-400.jpg','cover/processed/5/detail-1080.jpg','processed/5/720p.mp4','video/2026-07-29/ef49301f-0ae4-4d14-9a2e-8539ee1d9123.mp4','processed/5/480p.mp4','processed/5/720p.mp4','processed/5/1080p.mp4',8,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,'2026-07-30 16:35:56',0,9,1,1,'2026-07-30 00:37:57','2026-07-30 00:35:39','2026-08-21 23:01:15'),(6,1,4,'32','323','cover/processed/6/detail-1080.jpg','cover/2026-07-29/0f7ed014-a902-4e52-9e59-d9ae14e049e7.jpg','cover/processed/6/list-400.jpg','cover/processed/6/detail-1080.jpg','processed/6/720p.mp4','video/2026-07-29/608a7d0b-ae44-4f4b-a8da-c3da8c812a7e.mp4','processed/6/480p.mp4','processed/6/720p.mp4','processed/6/1080p.mp4',25,'REJECTED','测试驳回消息',NULL,0,NULL,NULL,NULL,0,NULL,'2026-07-30 16:47:34',0,0,0,0,NULL,'2026-07-30 00:46:51','2026-08-21 23:01:15'),(8,5,5,'6666','6666','cover/processed/8/detail-1080.jpg','cover/2026-07-29/c6b16ac4-6cf8-4e57-b495-df37193ad9a0.jpg','cover/processed/8/list-400.jpg','cover/processed/8/detail-1080.jpg','processed/8/720p.mp4','video/2026-07-29/56178cfa-30d8-4129-bd7b-1addb2a537fb.mp4','processed/8/480p.mp4','processed/8/720p.mp4','processed/8/1080p.mp4',10,'REJECTED','测试',NULL,0,NULL,NULL,NULL,0,NULL,'2026-07-30 17:02:35',0,0,0,0,NULL,'2026-07-30 01:02:28','2026-08-21 23:01:15'),(9,5,1,'666','6666','cover/processed/9/detail-1080.jpg','cover/2026-07-29/15cd83d9-eb94-4b30-9bd6-1ecffeb581db.jpg','cover/processed/9/list-400.jpg','cover/processed/9/detail-1080.jpg','processed/9/720p.mp4','video/2026-07-29/08ae2785-5cee-43f8-bab8-94d9e07ae2ab.mp4','processed/9/480p.mp4','processed/9/720p.mp4','processed/9/1080p.mp4',24,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,'2026-07-30 17:49:59',0,0,0,0,'2026-07-30 02:08:43','2026-07-30 01:49:36','2026-08-21 23:01:15'),(10,5,1,'666','测试多消费者','cover/processed/10/detail-1080.jpg','cover/2026-07-30/9b377f9d-16bb-4046-afd8-7b75464e4ed7.jpg','cover/processed/10/list-400.jpg','cover/processed/10/detail-1080.jpg','processed/10/720p.mp4','video/2026-07-30/d44f4e6e-0566-46b0-87d2-d81d81926cd3.mp4','processed/10/480p.mp4','processed/10/720p.mp4','processed/10/1080p.mp4',19,'PENDING',NULL,NULL,0,NULL,NULL,NULL,0,NULL,'2026-07-31 02:35:13',1,0,0,0,NULL,'2026-07-30 10:34:43','2026-08-21 23:01:15');
/*!40000 ALTER TABLE `video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_category`
--

DROP TABLE IF EXISTS `video_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'åˆ†åŒºID',
  `name` varchar(32) NOT NULL COMMENT 'åˆ†åŒºåç§°',
  `sort_num` int NOT NULL DEFAULT '0' COMMENT 'æŽ’åºå€¼ï¼Œè¶Šå°è¶Šé å‰',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT 'çŠ¶æ€ï¼š1å¯ç”¨ï¼Œ0åœç”¨',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='è§†é¢‘åˆ†åŒºè¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_category`
--

LOCK TABLES `video_category` WRITE;
/*!40000 ALTER TABLE `video_category` DISABLE KEYS */;
INSERT INTO `video_category` VALUES (1,'动画',1,1,'2026-07-30 00:24:45','2026-07-30 00:24:45'),(2,'音乐',2,1,'2026-07-30 00:24:45','2026-07-30 00:24:45'),(3,'游戏',3,1,'2026-07-30 00:24:45','2026-07-30 00:24:45'),(4,'知识',4,1,'2026-07-30 00:24:45','2026-07-30 00:24:45'),(5,'生活',5,1,'2026-07-30 00:24:45','2026-07-30 00:24:45'),(6,'科技',6,1,'2026-07-30 00:24:45','2026-07-30 00:24:45');
/*!40000 ALTER TABLE `video_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_comment`
--

DROP TABLE IF EXISTS `video_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `video_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '0ä»£è¡¨ä¸€çº§è¯„è®º',
  `root_id` bigint NOT NULL DEFAULT '0' COMMENT '所属一级评论ID；一级评论为0',
  `content` varchar(500) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1æ­£å¸¸ï¼Œ0å·²åˆ é™¤',
  `deleted_at` datetime DEFAULT NULL COMMENT 'è½¯åˆ é™¤æ—¶é—´ï¼ŒNULLè¡¨ç¤ºæœªåˆ é™¤',
  `cascade_deleted_root_id` bigint DEFAULT NULL COMMENT '因一级评论删除而被级联删除时记录根评论ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_video_created` (`video_id`,`created_at`),
  KEY `idx_comment_deleted_at` (`deleted_at`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_comment_video_parent_status_time` (`video_id`,`parent_id`,`status`,`created_at`,`id`),
  KEY `idx_comment_parent_status` (`parent_id`,`status`),
  KEY `idx_comment_video_root_status_time` (`video_id`,`root_id`,`status`,`created_at`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2082524108516544515 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_comment`
--

LOCK TABLES `video_comment` WRITE;
/*!40000 ALTER TABLE `video_comment` DISABLE KEYS */;
INSERT INTO `video_comment` VALUES (2082505401594187778,2,5,0,0,'111',0,'2026-07-30 00:38:20',NULL,'2026-07-30 00:35:53','2026-07-30 00:38:20'),(2082505424222457858,2,5,2082505401594187778,2082505401594187778,'323',0,'2026-07-30 00:38:20',NULL,'2026-07-30 00:35:58','2026-08-21 23:00:10'),(2082505436637597698,2,5,2082505401594187778,2082505401594187778,'323',0,'2026-07-30 00:38:20',NULL,'2026-07-30 00:36:01','2026-08-21 23:00:10'),(2082505960585859074,5,1,0,0,'6666',1,NULL,NULL,'2026-07-30 00:38:06','2026-07-30 00:38:06'),(2082524108516544514,2,5,0,0,'666',1,NULL,NULL,'2026-07-30 01:50:13','2026-07-30 01:50:13');
/*!40000 ALTER TABLE `video_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_favorite`
--

DROP TABLE IF EXISTS `video_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_favorite` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `video_id` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_video_favorite` (`user_id`,`video_id`),
  KEY `idx_video_id` (`video_id`),
  KEY `idx_favorite_user_page` (`user_id`,`id`,`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_favorite`
--

LOCK TABLES `video_favorite` WRITE;
/*!40000 ALTER TABLE `video_favorite` DISABLE KEYS */;
INSERT INTO `video_favorite` VALUES (1,5,2,'2026-07-30 00:35:48'),(2,1,5,'2026-07-30 00:38:03');
/*!40000 ALTER TABLE `video_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_like`
--

DROP TABLE IF EXISTS `video_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_like` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `video_id` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_video_like` (`user_id`,`video_id`),
  KEY `idx_video_id` (`video_id`),
  KEY `idx_like_user_page` (`user_id`,`id`,`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_like`
--

LOCK TABLES `video_like` WRITE;
/*!40000 ALTER TABLE `video_like` DISABLE KEYS */;
INSERT INTO `video_like` VALUES (2,1,5,'2026-07-30 00:38:02'),(3,5,2,'2026-07-30 01:50:16');
/*!40000 ALTER TABLE `video_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'videonest'
--

--
-- Dumping routines for database 'videonest'
--
--
-- WARNING: can't read the INFORMATION_SCHEMA.libraries table. It's most probably an old server 8.4.11.
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-21 23:04:27
