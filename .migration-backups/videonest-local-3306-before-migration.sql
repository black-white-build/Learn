-- MySQL dump 10.13  Distrib 9.6.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: videonest
-- ------------------------------------------------------
-- Server version	9.6.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '110ca7fa-1e19-11f1-9969-02509256cf9e:1-841';

--
-- Table structure for table `backup_media_20260813_notification`
--

DROP TABLE IF EXISTS `backup_media_20260813_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_media_20260813_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_id` varchar(64) NOT NULL,
  `recipient_id` bigint NOT NULL COMMENT '接收通知的用户',
  `actor_id` bigint NOT NULL COMMENT '触发事件的用户',
  `type` varchar(20) NOT NULL COMMENT 'FOLLOW/COMMENT/REPLY',
  `video_id` bigint DEFAULT NULL,
  `comment_id` bigint DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `is_read` tinyint NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_notification_event` (`event_id`),
  UNIQUE KEY `uk_notification_event_id` (`event_id`),
  KEY `idx_recipient_read_time` (`recipient_id`,`is_read`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_media_20260813_notification`
--

LOCK TABLES `backup_media_20260813_notification` WRITE;
/*!40000 ALTER TABLE `backup_media_20260813_notification` DISABLE KEYS */;
INSERT INTO `backup_media_20260813_notification` VALUES (1,'69ba8af7-5396-4062-8b42-f9f807da77c0',1,2,'COMMENT',1,2081413660336320513,'RabbitMQ 评论通知测试',1,'2026-07-27 00:17:42'),(2,'a746cddc-be18-46b2-9d0d-f1c0e349be0e',2,1,'COMMENT',18,2081728459196649473,'666',1,'2026-07-27 21:08:36'),(3,'cc44edf6-6b96-4f71-8169-456fbe463697',2,1,'COMMENT',18,2081734561640509442,'ferferffer',0,'2026-07-27 21:32:51'),(4,'710fe849-5b1e-4081-a90d-3bd4f0df02b2',2,1,'COMMENT',18,2081735053657538561,'测试',1,'2026-07-27 21:34:48'),(5,'c22816ef-d366-4a99-bc26-ad82ee5cf9db',2,1,'COMMENT',18,2081742244586237954,'测试平陵qwdqwdqwd',1,'2026-07-27 22:03:22'),(6,'2f1bccd9-8622-4fa2-ac5e-e207c6227869',2,1,'COMMENT',18,2081765833477820418,'测试通知',0,'2026-07-27 23:37:06'),(7,'333fd664-8036-4e94-a030-42d112868b11',1,2,'LIKE',1,NULL,'点赞了你的视频',1,'2026-07-29 22:27:56'),(8,'6afccd02-2068-4d00-9a6c-f021fc17cd2d',1,2,'FAVORITE',1,NULL,'收藏了你的视频',1,'2026-07-29 22:27:57'),(9,'25d5e34c-040b-44d0-9df2-888b4f55728b',1,2,'FOLLOW',NULL,NULL,'关注了你',0,'2026-07-29 22:27:59');
/*!40000 ALTER TABLE `backup_media_20260813_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_media_20260813_video`
--

DROP TABLE IF EXISTS `backup_media_20260813_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_media_20260813_video` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '视频ID',
  `author_id` bigint NOT NULL COMMENT '投稿用户ID',
  `category_id` bigint NOT NULL COMMENT '分区ID',
  `title` varchar(100) NOT NULL COMMENT '视频标题',
  `description` varchar(2000) DEFAULT NULL COMMENT '视频简介',
  `cover_url` varchar(500) DEFAULT NULL COMMENT '封面地址',
  `original_cover_url` varchar(500) DEFAULT NULL COMMENT '用户上传的原始封面对象名，不直接返回给浏览器',
  `cover_list_url` varchar(500) DEFAULT NULL COMMENT '400px 列表封面对象名',
  `cover_detail_url` varchar(500) DEFAULT NULL COMMENT '1080px 详情封面对象名',
  `video_url` varchar(500) DEFAULT NULL COMMENT '视频地址',
  `original_video_url` varchar(500) DEFAULT NULL COMMENT '用户上传的原始视频对象名',
  `video_480p_url` varchar(500) DEFAULT NULL COMMENT '480P video object name',
  `video_720p_url` varchar(500) DEFAULT NULL COMMENT '720P video object name',
  `video_1080p_url` varchar(500) DEFAULT NULL COMMENT '1080P video object name',
  `duration` int NOT NULL DEFAULT '0' COMMENT '时长，单位秒',
  `status` varchar(20) NOT NULL DEFAULT 'DRAFT' COMMENT 'DRAFT/PENDING/PUBLISHED/REJECTED',
  `reject_reason` varchar(500) DEFAULT NULL COMMENT '审核驳回原因',
  `process_error` varchar(1000) DEFAULT NULL COMMENT '转码失败原因',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除标记：0正常，1已删除',
  `deleted_at` datetime DEFAULT NULL COMMENT '进入回收站时间',
  `deleted_by` bigint DEFAULT NULL COMMENT '执行软删除的用户ID',
  `purge_after` datetime DEFAULT NULL COMMENT '允许永久清理资源的时间',
  `purge_attempts` int NOT NULL DEFAULT '0' COMMENT '资源清理尝试次数',
  `purge_error` varchar(1000) DEFAULT NULL COMMENT '最近一次资源清理失败原因',
  `review_deadline` datetime DEFAULT NULL COMMENT '审核超时时间',
  `review_timeout_notified` tinyint NOT NULL DEFAULT '0' COMMENT '审核超时通知标记',
  `view_count` bigint NOT NULL DEFAULT '0' COMMENT '播放量',
  `like_count` bigint NOT NULL DEFAULT '0' COMMENT '点赞数',
  `favorite_count` bigint NOT NULL DEFAULT '0' COMMENT '收藏数',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment_count` int NOT NULL DEFAULT '0' COMMENT '评论数',
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='视频表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_media_20260813_video`
--

LOCK TABLES `backup_media_20260813_video` WRITE;
/*!40000 ALTER TABLE `backup_media_20260813_video` DISABLE KEYS */;
INSERT INTO `backup_media_20260813_video` VALUES (1,1,4,'Spring Boot 从零搭建视频平台','VideoNest 项目后端开发记录。','https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',NULL,NULL,NULL,'https://www.w3schools.com/html/mov_bbb.mp4',NULL,NULL,NULL,NULL,600,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,163,20,7,'2026-07-24 18:08:53','2026-07-24 18:08:53','2026-07-29 22:28:20',0),(2,1,6,'Vue 3 登录注册页面开发','使用 Vue 3、TypeScript、Element Plus 完成登录注册。','https://images.unsplash.com/photo-1499750310107-5fef28a66643?auto=format&fit=crop&w=800&q=80',NULL,NULL,NULL,'https://www.w3schools.com/html/mov_bbb.mp4',NULL,NULL,NULL,NULL,420,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,102,12,3,'2026-07-24 18:08:53','2026-07-24 18:08:53','2026-07-26 18:19:23',0),(4,2,4,'我的第一个投稿视频','这是我的第一个视频。','cover/2026-07-25/1d8c5294-40b2-4a49-b875-adb7dab6181d.jpg',NULL,NULL,NULL,'video/2026-07-25/44a0c4f1-0b10-403c-b807-3b898cae7fe6.mp4',NULL,NULL,NULL,NULL,120,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,18,0,0,'2026-07-25 09:48:01','2026-07-25 09:46:17','2026-07-27 21:42:59',0),(6,2,5,'测试审核的视频','测试审核','cover/2026-07-25/2163b747-1ae9-4f88-8dd8-bf5583730f80.jpg',NULL,NULL,NULL,'video/2026-07-25/62a45fcd-394b-486c-b1b5-52ea7e7429d7.mp4',NULL,NULL,NULL,NULL,19,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,6,1,1,'2026-07-26 18:20:45','2026-07-25 18:07:59','2026-07-29 22:27:51',0),(8,2,2,'测试驳回信息的视频','3333','cover/2026-07-25/d1c6db2f-58ca-4c58-a4cd-ad842b52eb0a.png',NULL,NULL,NULL,'video/2026-07-25/5a66f388-9c87-44a4-acd7-d63ff1a8b44e.mp4',NULL,NULL,NULL,NULL,18,'REJECTED','视频封面不清晰，请更换清晰的 16:9 封面后重新投稿。',NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,NULL,'2026-07-25 20:43:52','2026-07-25 20:45:43',0),(9,1,3,'cs','cscscs','cover/2026-07-26/2283d1eb-f746-49b0-8078-180399384d82.jpg',NULL,NULL,NULL,'video/2026-07-26/1df6349a-ad65-414f-8e0d-547d2b0ac689.mp4',NULL,NULL,NULL,NULL,25,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,13,0,0,'2026-07-26 18:20:50','2026-07-26 01:10:06','2026-07-27 21:44:43',0),(10,2,3,'212','666','cover/2026-07-26/dd64a977-5b4e-4247-8f21-80b54781d06b.jpg',NULL,NULL,NULL,'video/2026-07-26/cd30e579-aa91-4b12-ad99-d1a10196ab07.mp4',NULL,NULL,NULL,NULL,8,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,2,0,0,'2026-07-27 22:04:54','2026-07-26 17:29:18','2026-07-27 22:05:18',0),(11,1,1,'管理员的','观看i元','cover/2026-07-26/ce5416d8-995c-46a1-b134-6cb0347bc541.jpg',NULL,NULL,NULL,'video/2026-07-26/56c9876f-3bdf-46ce-9375-1efa5c9158d4.mp4',NULL,NULL,NULL,NULL,18,'REJECTED','6666',NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,NULL,'2026-07-26 21:25:03','2026-07-27 22:04:58',0),(18,2,3,'11111','1111','cover/2026-07-27/c637e2fc-5c8c-4e16-9026-fc625554f06b.jpg',NULL,NULL,NULL,'processed/18/720p.mp4','video/2026-07-27/2aa20f5c-c142-4087-b4bf-67a4c94a747c.mp4','processed/18/480p.mp4','processed/18/720p.mp4','processed/18/1080p.mp4',16,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,32,1,2,'2026-07-27 20:45:01','2026-07-27 20:42:42','2026-07-27 23:38:42',0),(19,2,3,'333','3386786','cover/2026-07-27/97e390ed-562b-450b-8bf2-5e9fb1ca8eb0.jpg',NULL,NULL,NULL,'processed/19/720p.mp4','video/2026-07-27/7d2a7eb7-24c7-45fb-981f-b4d727e773c2.mp4','processed/19/480p.mp4','processed/19/720p.mp4','processed/19/1080p.mp4',8,'PENDING',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,NULL,'2026-07-27 20:43:50','2026-07-27 22:06:37',0),(20,2,2,'321','312','cover/2026-07-27/d528354f-96de-49a0-99b4-e52fce501eb6.jpg',NULL,NULL,NULL,'processed/20/720p.mp4','video/2026-07-27/5b345840-1c9b-4eac-ac90-696b821ed991.mp4','processed/20/480p.mp4','processed/20/720p.mp4','processed/20/1080p.mp4',19,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,'2026-07-27 22:08:02','2026-07-27 22:06:02','2026-07-27 22:08:02',0);
/*!40000 ALTER TABLE `backup_media_20260813_video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_media_20260813_video_comment`
--

DROP TABLE IF EXISTS `backup_media_20260813_video_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_media_20260813_video_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `video_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '0代表一级评论',
  `root_id` bigint NOT NULL DEFAULT '0' COMMENT '所属一级评论ID；一级评论为0',
  `content` varchar(500) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1正常，0已删除',
  `deleted_at` datetime DEFAULT NULL COMMENT 'soft delete time',
  `cascade_deleted_root_id` bigint DEFAULT NULL COMMENT '因一级评论删除而被级联删除时记录根评论ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_video_created` (`video_id`,`created_at`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_comment_deleted_at` (`deleted_at`),
  KEY `idx_comment_video_root_status_time` (`video_id`,`root_id`,`status`,`created_at`,`id`),
  KEY `idx_comment_video_parent_status_time` (`video_id`,`parent_id`,`status`,`created_at`,`id`),
  KEY `idx_comment_parent_status` (`parent_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2081765833477820419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_media_20260813_video_comment`
--

LOCK TABLES `backup_media_20260813_video_comment` WRITE;
/*!40000 ALTER TABLE `backup_media_20260813_video_comment` DISABLE KEYS */;
INSERT INTO `backup_media_20260813_video_comment` VALUES (2081321556314501121,1,2,0,0,'这是一条测试评论',0,'2026-07-26 18:14:38',NULL,'2026-07-26 18:11:42','2026-07-27 21:33:51'),(2081321652154347521,1,2,0,0,'这是一条测试评论',1,NULL,NULL,'2026-07-26 18:12:05','2026-07-26 18:12:05'),(2081321655463653378,1,2,0,0,'这是一条测试评论',1,NULL,NULL,'2026-07-26 18:12:06','2026-07-26 18:12:06'),(2081321658097676289,1,2,0,0,'这是一条测试评论',1,NULL,NULL,'2026-07-26 18:12:07','2026-07-26 18:12:07'),(2081321660568121345,1,2,0,0,'这是一条测试评论',1,NULL,NULL,'2026-07-26 18:12:07','2026-07-26 18:12:07'),(2081377491795914753,1,1,0,0,'666',1,NULL,NULL,'2026-07-26 21:53:58','2026-07-26 21:53:58'),(2081379559457804289,9,1,0,0,'666',1,NULL,NULL,'2026-07-26 22:02:11','2026-07-26 22:02:11'),(2081381568437104641,1,1,2081377491795914753,2081377491795914753,'这是 Postman 测试回复',1,NULL,NULL,'2026-07-26 22:10:10','2026-08-11 00:35:44'),(2081382243573248001,9,1,2081379559457804289,2081379559457804289,'111',1,NULL,NULL,'2026-07-26 22:12:51','2026-08-11 00:35:44'),(2081382507990560770,4,2,0,0,'57857',1,NULL,NULL,'2026-07-26 22:13:54','2026-07-26 22:13:54'),(2081382516219785218,4,2,0,0,'578575',0,'2026-07-26 22:23:21',NULL,'2026-07-26 22:13:56','2026-07-27 21:33:51'),(2081382554769633282,1,2,0,0,'1111111',0,'2026-07-26 22:14:11',NULL,'2026-07-26 22:14:05','2026-07-27 21:33:51'),(2081382569357422594,1,2,0,0,'11111',1,NULL,NULL,'2026-07-26 22:14:09','2026-07-26 22:14:09'),(2081413660336320513,1,2,0,0,'RabbitMQ 评论通知测试',1,NULL,NULL,'2026-07-27 00:17:42','2026-07-27 00:17:42'),(2081421856207638529,6,2,0,0,'你真牛逼',1,NULL,NULL,'2026-07-27 00:50:16','2026-07-27 00:50:16'),(2081728459196649473,18,1,0,0,'666',1,NULL,NULL,'2026-07-27 21:08:35','2026-07-27 21:08:35'),(2081734561640509442,18,1,0,0,'ferferffer',0,'2026-07-27 21:35:08',NULL,'2026-07-27 21:32:50','2026-07-27 21:35:08'),(2081735053657538561,18,1,0,0,'测试',1,NULL,NULL,'2026-07-27 21:34:48','2026-07-27 21:34:48'),(2081742244586237954,18,1,0,0,'测试平陵qwdqwdqwd',1,NULL,NULL,'2026-07-27 22:03:22','2026-07-27 22:03:22'),(2081765833477820418,18,1,0,0,'测试通知',1,NULL,NULL,'2026-07-27 23:37:06','2026-07-27 23:37:06');
/*!40000 ALTER TABLE `backup_media_20260813_video_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_media_20260813_video_favorite`
--

DROP TABLE IF EXISTS `backup_media_20260813_video_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_media_20260813_video_favorite` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `video_id` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_video_favorite` (`user_id`,`video_id`),
  KEY `idx_video_id` (`video_id`),
  KEY `idx_favorite_user_page` (`user_id`,`id`,`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_media_20260813_video_favorite`
--

LOCK TABLES `backup_media_20260813_video_favorite` WRITE;
/*!40000 ALTER TABLE `backup_media_20260813_video_favorite` DISABLE KEYS */;
INSERT INTO `backup_media_20260813_video_favorite` VALUES (3,1,1,'2026-07-26 21:53:48'),(4,2,6,'2026-07-27 00:50:08'),(5,1,18,'2026-07-27 23:37:00'),(6,2,18,'2026-07-27 23:38:42'),(7,2,1,'2026-07-29 22:27:57');
/*!40000 ALTER TABLE `backup_media_20260813_video_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_media_20260813_video_like`
--

DROP TABLE IF EXISTS `backup_media_20260813_video_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `backup_media_20260813_video_like` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `video_id` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_video_like` (`user_id`,`video_id`),
  KEY `idx_video_id` (`video_id`),
  KEY `idx_like_user_page` (`user_id`,`id`,`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_media_20260813_video_like`
--

LOCK TABLES `backup_media_20260813_video_like` WRITE;
/*!40000 ALTER TABLE `backup_media_20260813_video_like` DISABLE KEYS */;
INSERT INTO `backup_media_20260813_video_like` VALUES (4,1,1,'2026-07-26 21:53:46'),(5,2,6,'2026-07-27 00:50:07'),(6,1,18,'2026-07-27 23:36:59'),(7,2,1,'2026-07-29 22:27:56');
/*!40000 ALTER TABLE `backup_media_20260813_video_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dead_letter_record`
--

DROP TABLE IF EXISTS `dead_letter_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dead_letter_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `queue_name` varchar(128) NOT NULL COMMENT '死信来源队列',
  `message_type` varchar(32) NOT NULL COMMENT '业务消息类型',
  `business_id` varchar(64) DEFAULT NULL COMMENT '关联业务ID',
  `payload` text NOT NULL COMMENT '原始消息体',
  `failure_reason` varchar(500) DEFAULT NULL COMMENT '死信原因',
  `status` varchar(20) NOT NULL DEFAULT 'PENDING' COMMENT 'PENDING/RETRIED/IGNORED',
  `operator_id` bigint DEFAULT NULL COMMENT '最后处理管理员ID',
  `handled_at` datetime DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_dead_letter_status_time` (`status`,`create_time`),
  KEY `idx_dead_letter_business` (`message_type`,`business_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='RabbitMQ死信处理记录';
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
  `version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `script` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` int DEFAULT NULL,
  `installed_by` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `flyway_schema_history_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flyway_schema_history`
--

LOCK TABLES `flyway_schema_history` WRITE;
/*!40000 ALTER TABLE `flyway_schema_history` DISABLE KEYS */;
INSERT INTO `flyway_schema_history` VALUES (1,'3','<< Flyway Baseline >>','BASELINE','<< Flyway Baseline >>',NULL,'root','2026-08-12 17:24:47',0,1),(2,'4','hot upload query hardening','SQL','V4__hot_upload_query_hardening.sql',-1929547773,'root','2026-08-12 17:24:48',131,1),(3,'5','media delivery','SQL','V5__media_delivery.sql',-1552852556,'root','2026-08-12 17:24:48',11,1),(4,'6','add comment root id','SQL','V6__add_comment_root_id.sql',-1327195583,'root','2026-08-12 17:24:48',15,1),(5,'7','transactional outbox','SQL','V7__transactional_outbox.sql',-1785858285,'root','2026-08-12 17:24:48',11,1);
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
  `event_id` varchar(64) NOT NULL,
  `recipient_id` bigint NOT NULL COMMENT '接收通知的用户',
  `actor_id` bigint NOT NULL COMMENT '触发事件的用户',
  `type` varchar(20) NOT NULL COMMENT 'FOLLOW/COMMENT/REPLY',
  `video_id` bigint DEFAULT NULL,
  `comment_id` bigint DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `is_read` tinyint NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_notification_event` (`event_id`),
  UNIQUE KEY `uk_notification_event_id` (`event_id`),
  KEY `idx_recipient_read_time` (`recipient_id`,`is_read`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (9,'25d5e34c-040b-44d0-9df2-888b4f55728b',1,2,'FOLLOW',NULL,NULL,'关注了你',0,'2026-07-29 22:27:59'),(10,'4c3762be-3f1f-4fec-9b9e-57bb65bb3676',2,4,'COMMENT',5,2087599008582029314,'666',0,'2026-08-13 01:56:04');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='事务消息发件箱';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbox_event`
--

LOCK TABLES `outbox_event` WRITE;
/*!40000 ALTER TABLE `outbox_event` DISABLE KEYS */;
INSERT INTO `outbox_event` VALUES (1,'4c3762be-3f1f-4fec-9b9e-57bb65bb3676','NOTIFICATION','videonest.notification.exchange','videonest.notification','{\"eventId\":\"4c3762be-3f1f-4fec-9b9e-57bb65bb3676\",\"recipientId\":2,\"actorId\":4,\"type\":\"COMMENT\",\"videoId\":5,\"commentId\":2087599008582029314,\"content\":\"666\"}','SENT',0,'2026-08-13 01:56:04',NULL,'2026-08-13 01:56:04','2026-08-13 01:56:04','2026-08-13 01:56:04');
/*!40000 ALTER TABLE `outbox_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(32) NOT NULL COMMENT '用户名',
  `password` varchar(100) NOT NULL COMMENT 'BCrypt加密密码',
  `nickname` varchar(32) NOT NULL COMMENT '昵称',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：1正常，0禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `role` varchar(50) DEFAULT 'USER' COMMENT '用户角色',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'test001','$2a$10$idDLIkKc9w50mrQ11GuXReXwAHhJ24fso8SCUTmHpqjFDzPNsJiEO','测试用户',1,'2026-07-23 20:13:59','2026-07-25 17:53:38','ADMIN'),(2,'1111','$2a$10$mcBFpHxt2VGJwnH91FOICuhV/IRJj6tJArgPcAWLUqveww9RRvDcu','1111',1,'2026-07-23 21:09:45','2026-07-23 21:09:45','USER'),(3,'2222','$2a$10$89IuP2NgvhFaDOGbibBQ5uO9RkrcbhqQxKxIFThhp1pdFDKCtyS8.','2222',1,'2026-08-13 01:11:52','2026-08-13 01:11:52','USER'),(4,'3333','$2a$10$aTTbim5VUQn1aQG8d/pBY.kTESn46dmPNA2KCc7panPMTKJRbI.5a','3333',1,'2026-08-13 01:28:54','2026-08-13 01:36:46','ADMIN');
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
  `follower_id` bigint NOT NULL COMMENT '发起关注的用户 ID',
  `followee_id` bigint NOT NULL COMMENT '被关注的用户 ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_follower_followee` (`follower_id`,`followee_id`),
  KEY `idx_followee_created` (`followee_id`,`created_at`),
  KEY `idx_follower_created` (`follower_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户关注关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_follow`
--

LOCK TABLES `user_follow` WRITE;
/*!40000 ALTER TABLE `user_follow` DISABLE KEYS */;
INSERT INTO `user_follow` VALUES (2,1,2,'2026-07-26 21:21:27'),(3,2,1,'2026-07-29 22:27:59');
/*!40000 ALTER TABLE `user_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video`
--

DROP TABLE IF EXISTS `video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '视频ID',
  `author_id` bigint NOT NULL COMMENT '投稿用户ID',
  `category_id` bigint NOT NULL COMMENT '分区ID',
  `title` varchar(100) NOT NULL COMMENT '视频标题',
  `description` varchar(2000) DEFAULT NULL COMMENT '视频简介',
  `cover_url` varchar(500) DEFAULT NULL COMMENT '封面地址',
  `original_cover_url` varchar(500) DEFAULT NULL COMMENT '用户上传的原始封面对象名，不直接返回给浏览器',
  `cover_list_url` varchar(500) DEFAULT NULL COMMENT '400px 列表封面对象名',
  `cover_detail_url` varchar(500) DEFAULT NULL COMMENT '1080px 详情封面对象名',
  `video_url` varchar(500) DEFAULT NULL COMMENT '视频地址',
  `original_video_url` varchar(500) DEFAULT NULL COMMENT '用户上传的原始视频对象名',
  `video_480p_url` varchar(500) DEFAULT NULL COMMENT '480P video object name',
  `video_720p_url` varchar(500) DEFAULT NULL COMMENT '720P video object name',
  `video_1080p_url` varchar(500) DEFAULT NULL COMMENT '1080P video object name',
  `duration` int NOT NULL DEFAULT '0' COMMENT '时长，单位秒',
  `status` varchar(20) NOT NULL DEFAULT 'DRAFT' COMMENT 'DRAFT/PENDING/PUBLISHED/REJECTED',
  `reject_reason` varchar(500) DEFAULT NULL COMMENT '审核驳回原因',
  `process_error` varchar(1000) DEFAULT NULL COMMENT '转码失败原因',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除标记：0正常，1已删除',
  `deleted_at` datetime DEFAULT NULL COMMENT '进入回收站时间',
  `deleted_by` bigint DEFAULT NULL COMMENT '执行软删除的用户ID',
  `purge_after` datetime DEFAULT NULL COMMENT '允许永久清理资源的时间',
  `purge_attempts` int NOT NULL DEFAULT '0' COMMENT '资源清理尝试次数',
  `purge_error` varchar(1000) DEFAULT NULL COMMENT '最近一次资源清理失败原因',
  `review_deadline` datetime DEFAULT NULL COMMENT '审核超时时间',
  `review_timeout_notified` tinyint NOT NULL DEFAULT '0' COMMENT '审核超时通知标记',
  `view_count` bigint NOT NULL DEFAULT '0' COMMENT '播放量',
  `like_count` bigint NOT NULL DEFAULT '0' COMMENT '点赞数',
  `favorite_count` bigint NOT NULL DEFAULT '0' COMMENT '收藏数',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `comment_count` int NOT NULL DEFAULT '0' COMMENT '评论数',
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='视频表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video`
--

LOCK TABLES `video` WRITE;
/*!40000 ALTER TABLE `video` DISABLE KEYS */;
INSERT INTO `video` VALUES (1,1,4,'Spring Boot 从零搭建视频平台','VideoNest 项目后端开发记录。','https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',NULL,NULL,NULL,'https://www.w3schools.com/html/mov_bbb.mp4',NULL,NULL,NULL,NULL,600,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,130,0,0,'2026-07-30 00:07:43','2026-07-30 00:07:43','2026-08-13 01:46:29',0),(2,1,6,'Vue 3 登录注册页面开发','使用 Vue 3、TypeScript、Element Plus 完成登录注册。','https://images.unsplash.com/photo-1499750310107-5fef28a66643?auto=format&fit=crop&w=800&q=80',NULL,NULL,NULL,'https://www.w3schools.com/html/mov_bbb.mp4',NULL,NULL,NULL,NULL,420,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,100,0,0,'2026-07-30 00:07:43','2026-07-30 00:07:43','2026-08-13 01:46:29',0),(3,1,5,'我的 Java 后端实习项目记录','记录一个视频社区平台从零开发的过程。','https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=800',NULL,NULL,NULL,'https://www.w3schools.com/html/mov_bbb.mp4',NULL,NULL,NULL,NULL,300,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,76,0,0,'2026-07-30 00:07:43','2026-07-30 00:07:43','2026-08-13 01:46:29',0),(4,2,2,'1','11111','cover/processed/4/detail-1080.jpg','cover/2026-07-29/42247732-41a9-4be3-8793-698c194996a7.jpg','cover/processed/4/list-400.jpg','cover/processed/4/detail-1080.jpg','processed/4/720p.mp4','video/2026-07-29/36bd17f3-b370-4c17-9ad2-d8ab228e1613.mp4','processed/4/480p.mp4','processed/4/720p.mp4','processed/4/1080p.mp4',25,'REJECTED','测试驳回信息',NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,NULL,'2026-07-30 00:30:23','2026-08-13 01:46:29',0),(5,2,3,'2','2222','cover/processed/5/detail-1080.jpg','cover/2026-07-29/63d31a38-ca13-4f92-ac9e-3cd23208a9b5.png','cover/processed/5/list-400.jpg','cover/processed/5/detail-1080.jpg','processed/5/720p.mp4','video/2026-07-29/ef49301f-0ae4-4d14-9a2e-8539ee1d9123.mp4','processed/5/480p.mp4','processed/5/720p.mp4','processed/5/1080p.mp4',8,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,9,0,0,'2026-07-30 00:37:57','2026-07-30 00:35:39','2026-08-13 01:43:14',0),(6,1,4,'32','323','cover/processed/6/detail-1080.jpg','cover/2026-07-29/0f7ed014-a902-4e52-9e59-d9ae14e049e7.jpg','cover/processed/6/list-400.jpg','cover/processed/6/detail-1080.jpg','processed/6/720p.mp4','video/2026-07-29/608a7d0b-ae44-4f4b-a8da-c3da8c812a7e.mp4','processed/6/480p.mp4','processed/6/720p.mp4','processed/6/1080p.mp4',25,'REJECTED','测试驳回消息',NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,NULL,'2026-07-30 00:46:51','2026-08-13 01:46:29',0),(7,2,4,'4444','4444','cover/processed/7/detail-1080.jpg','cover/2026-07-29/f5970b9b-2aca-49cf-a338-872387aed809.jpg','cover/processed/7/list-400.jpg','cover/processed/7/detail-1080.jpg','processed/7/720p.mp4','video/2026-07-29/87b9217b-5b85-4bf4-bab7-bfc9f19f653f.mp4','processed/7/480p.mp4','processed/7/720p.mp4','processed/7/1080p.mp4',19,'PENDING',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,NULL,'2026-07-30 00:47:43','2026-08-13 01:43:14',0),(8,2,5,'6666','6666','cover/processed/8/detail-1080.jpg','cover/2026-07-29/c6b16ac4-6cf8-4e57-b495-df37193ad9a0.jpg','cover/processed/8/list-400.jpg','cover/processed/8/detail-1080.jpg','processed/8/720p.mp4','video/2026-07-29/56178cfa-30d8-4129-bd7b-1addb2a537fb.mp4','processed/8/480p.mp4','processed/8/720p.mp4','processed/8/1080p.mp4',10,'REJECTED','测试',NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,NULL,'2026-07-30 01:02:28','2026-08-13 01:46:29',0),(9,2,1,'666','6666','cover/processed/9/detail-1080.jpg','cover/2026-07-29/15cd83d9-eb94-4b30-9bd6-1ecffeb581db.jpg','cover/processed/9/list-400.jpg','cover/processed/9/detail-1080.jpg','processed/9/720p.mp4','video/2026-07-29/08ae2785-5cee-43f8-bab8-94d9e07ae2ab.mp4','processed/9/480p.mp4','processed/9/720p.mp4','processed/9/1080p.mp4',24,'PUBLISHED',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,'2026-07-30 02:08:43','2026-07-30 01:49:36','2026-08-13 01:43:14',0),(10,2,1,'666','测试多消费者','cover/processed/10/detail-1080.jpg','cover/2026-07-30/9b377f9d-16bb-4046-afd8-7b75464e4ed7.jpg','cover/processed/10/list-400.jpg','cover/processed/10/detail-1080.jpg','processed/10/720p.mp4','video/2026-07-30/d44f4e6e-0566-46b0-87d2-d81d81926cd3.mp4','processed/10/480p.mp4','processed/10/720p.mp4','processed/10/1080p.mp4',19,'PENDING',NULL,NULL,0,NULL,NULL,NULL,0,NULL,NULL,0,0,0,0,NULL,'2026-07-30 10:34:43','2026-08-13 01:46:29',0);
/*!40000 ALTER TABLE `video` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `video_category`
--

DROP TABLE IF EXISTS `video_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `video_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分区ID',
  `name` varchar(32) NOT NULL COMMENT '分区名称',
  `sort_num` int NOT NULL DEFAULT '0' COMMENT '排序值，越小越靠前',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：1启用，0停用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='视频分区表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_category`
--

LOCK TABLES `video_category` WRITE;
/*!40000 ALTER TABLE `video_category` DISABLE KEYS */;
INSERT INTO `video_category` VALUES (1,'动画',1,1,'2026-07-24 00:13:57','2026-07-24 00:13:57'),(2,'音乐',2,1,'2026-07-24 00:13:57','2026-07-24 00:13:57'),(3,'游戏',3,1,'2026-07-24 00:13:57','2026-07-24 00:13:57'),(4,'知识',4,1,'2026-07-24 00:13:57','2026-07-24 00:13:57'),(5,'生活',5,1,'2026-07-24 00:13:57','2026-07-24 00:13:57'),(6,'科技',6,1,'2026-07-24 00:13:57','2026-07-24 00:13:57');
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
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '0代表一级评论',
  `root_id` bigint NOT NULL DEFAULT '0' COMMENT '所属一级评论ID；一级评论为0',
  `content` varchar(500) NOT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1正常，0已删除',
  `deleted_at` datetime DEFAULT NULL COMMENT 'soft delete time',
  `cascade_deleted_root_id` bigint DEFAULT NULL COMMENT '因一级评论删除而被级联删除时记录根评论ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_video_created` (`video_id`,`created_at`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_comment_deleted_at` (`deleted_at`),
  KEY `idx_comment_video_root_status_time` (`video_id`,`root_id`,`status`,`created_at`,`id`),
  KEY `idx_comment_video_parent_status_time` (`video_id`,`parent_id`,`status`,`created_at`,`id`),
  KEY `idx_comment_parent_status` (`parent_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2087599033332617219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_comment`
--

LOCK TABLES `video_comment` WRITE;
/*!40000 ALTER TABLE `video_comment` DISABLE KEYS */;
INSERT INTO `video_comment` VALUES (2087599008582029314,5,4,0,0,'666',1,NULL,NULL,'2026-08-13 01:56:04','2026-08-13 01:56:04'),(2087599033332617218,5,4,2087599008582029314,2087599008582029314,'444',1,NULL,NULL,'2026-08-13 01:56:09','2026-08-13 01:56:09');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_favorite`
--

LOCK TABLES `video_favorite` WRITE;
/*!40000 ALTER TABLE `video_favorite` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_like`
--

LOCK TABLES `video_like` WRITE;
/*!40000 ALTER TABLE `video_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `video_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'videonest'
--

--
-- Dumping routines for database 'videonest'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-21 23:04:27
