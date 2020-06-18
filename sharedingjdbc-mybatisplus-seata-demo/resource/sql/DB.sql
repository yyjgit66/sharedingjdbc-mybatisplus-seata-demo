CREATE DATABASE  IF NOT EXISTS `seata_order_0` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `seata_order_0`;
-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: seata_order_0
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `order_0`
--

DROP TABLE IF EXISTS `order_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_0` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户id',
  `product_id` bigint(11) DEFAULT NULL COMMENT '产品id',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `money` decimal(11,0) DEFAULT NULL COMMENT '订单金额',
  `status` int(1) DEFAULT NULL COMMENT '订单状态：0：创建中；1：已完结',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1260225579458875395 DEFAULT CHARSET=utf8 COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_0`
--

LOCK TABLES `order_0` WRITE;
/*!40000 ALTER TABLE `order_0` DISABLE KEYS */;
INSERT INTO `order_0` VALUES (1259707018369851394,1,9527,1,20,0,'2020-05-11 04:48:53'),(1259750891875995650,1,9527,1,20,0,'2020-05-11 07:43:14'),(1259768874484658178,1,9527,1,20,0,'2020-05-11 08:54:41'),(1259771164448804866,1,9527,1,20,0,'2020-05-11 09:03:46'),(1259774677186793474,1,9527,1,20,0,'2020-05-11 09:17:43'),(1259849043228540930,1,9527,1,20,0,'2020-05-11 14:13:13'),(1259862063803654146,1,9527,1,20,0,'2020-05-11 15:04:59'),(1259863305623711746,1,9527,1,20,0,'2020-05-11 15:09:55'),(1260156881767235586,1,9527,1,20,0,'2020-05-12 10:36:27'),(1260221613471703042,1,9527,1,20,0,'2020-05-12 14:53:41');
/*!40000 ALTER TABLE `order_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_1`
--

DROP TABLE IF EXISTS `order_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_1` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户id',
  `product_id` bigint(11) DEFAULT NULL COMMENT '产品id',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `money` decimal(11,0) DEFAULT NULL COMMENT '订单金额',
  `status` int(1) DEFAULT NULL COMMENT '订单状态：0：创建中；1：已完结',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_1`
--

LOCK TABLES `order_1` WRITE;
/*!40000 ALTER TABLE `order_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `branch_id` bigint(20) NOT NULL COMMENT '分支ID',
  `xid` varchar(100) NOT NULL COMMENT '全局唯一事务id',
  `rollback_info` longblob NOT NULL COMMENT '回滚信息',
  `log_status` int(11) NOT NULL COMMENT '状态',
  `log_created` datetime DEFAULT NULL COMMENT '创建时间',
  `log_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展',
  `context` varchar(100) NOT NULL COMMENT '序列化方式',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='事务回滚日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undo_log`
--

LOCK TABLES `undo_log` WRITE;
/*!40000 ALTER TABLE `undo_log` DISABLE KEYS */;
INSERT INTO `undo_log` VALUES (4,2011397346,'192.168.1.104:8091:2011397343',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"192.168.1.104:8091:2011397343\",\"branchId\":2011397346,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"INSERT\",\"tableName\":\"`order`\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords$EmptyTableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259853434769682433]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"user_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",1]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"product_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",9527]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"count\",\"keyType\":\"NULL\",\"type\":4,\"value\":1},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"money\",\"keyType\":\"NULL\",\"type\":3,\"value\":[\"java.math.BigDecimal\",20]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"status\",\"keyType\":\"NULL\",\"type\":4,\"value\":0},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"create_time\",\"keyType\":\"NULL\",\"type\":93,\"value\":[\"java.sql.Timestamp\",[1589207441000,0]]}]]}]]}}]]}',0,'2020-05-11 22:30:42','2020-05-11 22:30:42',NULL,'serializer=jackson'),(7,2011397399,'192.168.1.104:8091:2011397395',_binary '{}',1,'2020-05-11 23:05:03','2020-05-11 23:05:03',NULL,'serializer=jackson'),(10,2011455422,'10.249.42.70:8091:2011455420',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"10.249.42.70:8091:2011455420\",\"branchId\":2011455422,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"INSERT\",\"tableName\":\"`order`\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords$EmptyTableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1260156881767235586]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"user_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",1]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"product_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",9527]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"count\",\"keyType\":\"NULL\",\"type\":4,\"value\":1},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"money\",\"keyType\":\"NULL\",\"type\":3,\"value\":[\"java.math.BigDecimal\",20]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"status\",\"keyType\":\"NULL\",\"type\":4,\"value\":0},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"create_time\",\"keyType\":\"NULL\",\"type\":93,\"value\":[\"java.sql.Timestamp\",[1589279787000,0]]}]]}]]}}]]}',0,'2020-05-12 18:36:27','2020-05-12 18:36:27',NULL,'serializer=jackson'),(14,2011486644,'192.168.1.105:8091:2011486641',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"192.168.1.105:8091:2011486641\",\"branchId\":2011486644,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"INSERT\",\"tableName\":\"`order`\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords$EmptyTableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1260220551922720769]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"user_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",1]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"product_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",9527]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"count\",\"keyType\":\"NULL\",\"type\":4,\"value\":1},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"money\",\"keyType\":\"NULL\",\"type\":3,\"value\":[\"java.math.BigDecimal\",20]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"status\",\"keyType\":\"NULL\",\"type\":4,\"value\":0},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"create_time\",\"keyType\":\"NULL\",\"type\":93,\"value\":[\"java.sql.Timestamp\",[1589294969000,0]]}]]}]]}}]]}',0,'2020-05-12 22:49:29','2020-05-12 22:49:29',NULL,'serializer=jackson'),(15,2011486655,'192.168.1.105:8091:2011486653',_binary '{}',1,'2020-05-12 22:53:41','2020-05-12 22:53:41',NULL,'serializer=jackson');
/*!40000 ALTER TABLE `undo_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-12 23:40:47
CREATE DATABASE  IF NOT EXISTS `seata_order_1` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `seata_order_1`;
-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: seata_order_1
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `order_0`
--

DROP TABLE IF EXISTS `order_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_0` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户id',
  `product_id` bigint(11) DEFAULT NULL COMMENT '产品id',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `money` decimal(11,0) DEFAULT NULL COMMENT '订单金额',
  `status` int(1) DEFAULT NULL COMMENT '订单状态：0：创建中；1：已完结',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_0`
--

LOCK TABLES `order_0` WRITE;
/*!40000 ALTER TABLE `order_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_1`
--

DROP TABLE IF EXISTS `order_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_1` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户id',
  `product_id` bigint(11) DEFAULT NULL COMMENT '产品id',
  `count` int(11) DEFAULT NULL COMMENT '数量',
  `money` decimal(11,0) DEFAULT NULL COMMENT '订单金额',
  `status` int(1) DEFAULT NULL COMMENT '订单状态：0：创建中；1：已完结',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1260231791518355458 DEFAULT CHARSET=utf8 COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_1`
--

LOCK TABLES `order_1` WRITE;
/*!40000 ALTER TABLE `order_1` DISABLE KEYS */;
INSERT INTO `order_1` VALUES (1,1,9527,1,20,0,'2020-05-10 09:38:07'),(2,1,9527,1,20,0,'2020-05-10 09:38:07'),(1259397564050980865,1,9527,2,40,0,'2020-05-10 09:38:07'),(1259416212727734273,1,9527,1,20,0,'2020-05-10 09:38:07'),(1259416871791304705,1,9527,1,20,0,'2020-05-10 09:38:07'),(1259423174026711041,1,9527,1,20,0,'2020-05-10 10:00:59'),(1259693416724373505,1,9527,1,20,0,'2020-05-11 03:54:50'),(1259781028048461825,1,9527,1,20,0,'2020-05-11 09:42:58'),(1259782470062759937,1,9527,1,20,0,'2020-05-11 09:48:41'),(1259853434769682433,1,9527,1,20,0,'2020-05-11 14:30:41'),(1260157081944588289,1,9527,1,20,0,'2020-05-12 10:37:15');
/*!40000 ALTER TABLE `order_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `branch_id` bigint(20) NOT NULL COMMENT '分支ID',
  `xid` varchar(100) NOT NULL COMMENT '全局唯一事务id',
  `rollback_info` longblob NOT NULL COMMENT '回滚信息',
  `log_status` int(11) NOT NULL COMMENT '状态',
  `log_created` datetime DEFAULT NULL COMMENT '创建时间',
  `log_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展',
  `context` varchar(100) NOT NULL COMMENT '序列化方式',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='事务回滚日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undo_log`
--

LOCK TABLES `undo_log` WRITE;
/*!40000 ALTER TABLE `undo_log` DISABLE KEYS */;
INSERT INTO `undo_log` VALUES (5,2011397346,'192.168.1.104:8091:2011397343',_binary '{}',1,'2020-05-11 22:30:45','2020-05-11 22:30:45',NULL,'serializer=jackson'),(7,2011397399,'192.168.1.104:8091:2011397395',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"192.168.1.104:8091:2011397395\",\"branchId\":2011397399,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"INSERT\",\"tableName\":\"`order`\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords$EmptyTableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259862063803654146]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"user_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",1]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"product_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",9527]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"count\",\"keyType\":\"NULL\",\"type\":4,\"value\":1},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"money\",\"keyType\":\"NULL\",\"type\":3,\"value\":[\"java.math.BigDecimal\",20]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"status\",\"keyType\":\"NULL\",\"type\":4,\"value\":0},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"create_time\",\"keyType\":\"NULL\",\"type\":93,\"value\":[\"java.sql.Timestamp\",[1589209499000,0]]}]]}]]}}]]}',0,'2020-05-11 23:04:59','2020-05-11 23:04:59',NULL,'serializer=jackson'),(9,2011455395,'10.249.42.70:8091:2011455391',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"10.249.42.70:8091:2011455391\",\"branchId\":2011455395,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"INSERT\",\"tableName\":\"`order`\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords$EmptyTableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1260088871220264961]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"user_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",1]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"product_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",9527]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"count\",\"keyType\":\"NULL\",\"type\":4,\"value\":1},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"money\",\"keyType\":\"NULL\",\"type\":3,\"value\":[\"java.math.BigDecimal\",20]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"status\",\"keyType\":\"NULL\",\"type\":4,\"value\":0},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"create_time\",\"keyType\":\"NULL\",\"type\":93,\"value\":[\"java.sql.Timestamp\",[1589263574000,0]]}]]}]]}}]]}',0,'2020-05-12 14:06:14','2020-05-12 14:06:14',NULL,'serializer=jackson'),(10,2011455422,'10.249.42.70:8091:2011455420',_binary '{}',1,'2020-05-12 18:36:28','2020-05-12 18:36:28',NULL,'serializer=jackson'),(15,2011486655,'192.168.1.105:8091:2011486653',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"192.168.1.105:8091:2011486653\",\"branchId\":2011486655,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"INSERT\",\"tableName\":\"`order`\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords$EmptyTableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1260221613471703042]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"user_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",1]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"product_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",9527]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"count\",\"keyType\":\"NULL\",\"type\":4,\"value\":1},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"money\",\"keyType\":\"NULL\",\"type\":3,\"value\":[\"java.math.BigDecimal\",20]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"status\",\"keyType\":\"NULL\",\"type\":4,\"value\":0},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"create_time\",\"keyType\":\"NULL\",\"type\":93,\"value\":[\"java.sql.Timestamp\",[1589295221000,0]]}]]}]]}}]]}',0,'2020-05-12 22:53:41','2020-05-12 22:53:41',NULL,'serializer=jackson'),(16,2011486666,'192.168.1.105:8091:2011486661',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"192.168.1.105:8091:2011486661\",\"branchId\":2011486666,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"INSERT\",\"tableName\":\"`order`\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords$EmptyTableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"order\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1260225579458875394]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"user_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",1]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"product_id\",\"keyType\":\"NULL\",\"type\":-5,\"value\":[\"java.lang.Long\",9527]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"count\",\"keyType\":\"NULL\",\"type\":4,\"value\":1},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"money\",\"keyType\":\"NULL\",\"type\":3,\"value\":[\"java.math.BigDecimal\",10]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"status\",\"keyType\":\"NULL\",\"type\":4,\"value\":0},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"create_time\",\"keyType\":\"NULL\",\"type\":93,\"value\":[\"java.sql.Timestamp\",[1589296167000,0]]}]]}]]}}]]}',0,'2020-05-12 23:09:28','2020-05-12 23:09:28',NULL,'serializer=jackson');
/*!40000 ALTER TABLE `undo_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-12 23:40:48
CREATE DATABASE  IF NOT EXISTS `seata_storage_0` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `seata_storage_0`;
-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: seata_storage_0
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `storage_0`
--

DROP TABLE IF EXISTS `storage_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_0` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(11) DEFAULT NULL COMMENT '产品id',
  `total` int(11) DEFAULT NULL COMMENT '库存数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '产品单价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_0`
--

LOCK TABLES `storage_0` WRITE;
/*!40000 ALTER TABLE `storage_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `storage_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage_1`
--

DROP TABLE IF EXISTS `storage_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_1` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(11) DEFAULT NULL COMMENT '产品id',
  `total` int(11) DEFAULT NULL COMMENT '库存数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '产品单价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_1`
--

LOCK TABLES `storage_1` WRITE;
/*!40000 ALTER TABLE `storage_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `storage_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `branch_id` bigint(20) NOT NULL COMMENT '分支ID',
  `xid` varchar(100) NOT NULL COMMENT '全局唯一事务id',
  `rollback_info` longblob NOT NULL COMMENT '回滚信息',
  `log_status` int(11) NOT NULL COMMENT '状态',
  `log_created` datetime DEFAULT NULL COMMENT '创建时间',
  `log_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展',
  `context` varchar(100) NOT NULL COMMENT '序列化方式',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='事务回滚日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undo_log`
--

LOCK TABLES `undo_log` WRITE;
/*!40000 ALTER TABLE `undo_log` DISABLE KEYS */;
INSERT INTO `undo_log` VALUES (3,2011397352,'192.168.1.104:8091:2011397343',_binary '{}',1,'2020-05-11 22:30:52','2020-05-11 22:30:52',NULL,'serializer=jackson'),(5,2011397403,'192.168.1.104:8091:2011397395',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"192.168.1.104:8091:2011397395\",\"branchId\":2011397403,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"UPDATE\",\"tableName\":\"storage\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":74}]]}]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":73}]]}]]}}]]}',0,'2020-05-11 23:05:01','2020-05-11 23:05:01',NULL,'serializer=jackson'),(6,2011455400,'10.249.42.70:8091:2011455391',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"10.249.42.70:8091:2011455391\",\"branchId\":2011455400,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"UPDATE\",\"tableName\":\"storage\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":73}]]}]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":72}]]}]]}}]]}',0,'2020-05-12 14:06:17','2020-05-12 14:06:17',NULL,'serializer=jackson'),(7,2011455424,'10.249.42.70:8091:2011455420',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"10.249.42.70:8091:2011455420\",\"branchId\":2011455424,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"UPDATE\",\"tableName\":\"storage\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":72}]]}]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":71}]]}]]}}]]}',0,'2020-05-12 18:36:28','2020-05-12 18:36:28',NULL,'serializer=jackson'),(8,2011455472,'10.249.42.70:8091:2011455463',_binary '{}',1,'2020-05-12 22:41:21','2020-05-12 22:41:21',NULL,'serializer=jackson'),(9,2011486648,'192.168.1.105:8091:2011486641',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"192.168.1.105:8091:2011486641\",\"branchId\":2011486648,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"UPDATE\",\"tableName\":\"storage\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":70}]]}]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":69}]]}]]}}]]}',0,'2020-05-12 22:49:31','2020-05-12 22:49:31',NULL,'serializer=jackson'),(11,2011486657,'192.168.1.105:8091:2011486653',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"192.168.1.105:8091:2011486653\",\"branchId\":2011486657,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"UPDATE\",\"tableName\":\"storage\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":69}]]}]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":68}]]}]]}}]]}',0,'2020-05-12 22:53:41','2020-05-12 22:53:41',NULL,'serializer=jackson');
/*!40000 ALTER TABLE `undo_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-12 23:40:49
CREATE DATABASE  IF NOT EXISTS `seata_storage_1` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `seata_storage_1`;
-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: seata_storage_1
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `storage_0`
--

DROP TABLE IF EXISTS `storage_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_0` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(11) DEFAULT NULL COMMENT '产品id',
  `total` int(11) DEFAULT NULL COMMENT '库存数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '产品单价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_0`
--

LOCK TABLES `storage_0` WRITE;
/*!40000 ALTER TABLE `storage_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `storage_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage_1`
--

DROP TABLE IF EXISTS `storage_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_1` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(11) DEFAULT NULL COMMENT '产品id',
  `total` int(11) DEFAULT NULL COMMENT '库存数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '产品单价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1259363869587959811 DEFAULT CHARSET=utf8 COMMENT='库存表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_1`
--

LOCK TABLES `storage_1` WRITE;
/*!40000 ALTER TABLE `storage_1` DISABLE KEYS */;
INSERT INTO `storage_1` VALUES (1259363869587959810,9527,69,10.00);
/*!40000 ALTER TABLE `storage_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `branch_id` bigint(20) NOT NULL COMMENT '分支ID',
  `xid` varchar(100) NOT NULL COMMENT '全局唯一事务id',
  `rollback_info` longblob NOT NULL COMMENT '回滚信息',
  `log_status` int(11) NOT NULL COMMENT '状态',
  `log_created` datetime DEFAULT NULL COMMENT '创建时间',
  `log_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展',
  `context` varchar(100) NOT NULL COMMENT '序列化方式',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='事务回滚日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undo_log`
--

LOCK TABLES `undo_log` WRITE;
/*!40000 ALTER TABLE `undo_log` DISABLE KEYS */;
INSERT INTO `undo_log` VALUES (7,2011455400,'10.249.42.70:8091:2011455391',_binary '{}',1,'2020-05-12 14:06:18','2020-05-12 14:06:18',NULL,'serializer=jackson'),(9,2011455432,'10.249.42.70:8091:2011455428',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"10.249.42.70:8091:2011455428\",\"branchId\":2011455432,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"UPDATE\",\"tableName\":\"storage\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":72}]]}]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":71}]]}]]}}]]}',0,'2020-05-12 18:37:15','2020-05-12 18:37:15',NULL,'serializer=jackson'),(10,2011455446,'10.249.42.70:8091:2011455439',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"10.249.42.70:8091:2011455439\",\"branchId\":2011455446,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"UPDATE\",\"tableName\":\"storage\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":71}]]}]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":70}]]}]]}}]]}',0,'2020-05-12 22:37:02','2020-05-12 22:37:02',NULL,'serializer=jackson'),(11,2011455472,'10.249.42.70:8091:2011455463',_binary '{\"@class\":\"io.seata.rm.datasource.undo.BranchUndoLog\",\"xid\":\"10.249.42.70:8091:2011455463\",\"branchId\":2011455472,\"sqlUndoLogs\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.undo.SQLUndoLog\",\"sqlType\":\"UPDATE\",\"tableName\":\"storage\",\"beforeImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":71}]]}]]},\"afterImage\":{\"@class\":\"io.seata.rm.datasource.sql.struct.TableRecords\",\"tableName\":\"storage\",\"rows\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Row\",\"fields\":[\"java.util.ArrayList\",[{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"id\",\"keyType\":\"PRIMARY_KEY\",\"type\":-5,\"value\":[\"java.lang.Long\",1259363869587959810]},{\"@class\":\"io.seata.rm.datasource.sql.struct.Field\",\"name\":\"total\",\"keyType\":\"NULL\",\"type\":4,\"value\":70}]]}]]}}]]}',0,'2020-05-12 22:41:20','2020-05-12 22:41:20',NULL,'serializer=jackson'),(13,2011486648,'192.168.1.105:8091:2011486641',_binary '{}',1,'2020-05-12 22:49:32','2020-05-12 22:49:32',NULL,'serializer=jackson');
/*!40000 ALTER TABLE `undo_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-12 23:40:50
CREATE DATABASE  IF NOT EXISTS `seata_account_0` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `seata_account_0`;
-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: seata_account_0
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `account_0`
--

DROP TABLE IF EXISTS `account_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_0` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户id',
  `amount` decimal(10,0) DEFAULT NULL COMMENT '账户金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='账户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_0`
--

LOCK TABLES `account_0` WRITE;
/*!40000 ALTER TABLE `account_0` DISABLE KEYS */;
INSERT INTO `account_0` VALUES (4,4,2000);
/*!40000 ALTER TABLE `account_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_1`
--

DROP TABLE IF EXISTS `account_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_1` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户id',
  `amount` decimal(10,0) DEFAULT NULL COMMENT '账户金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_1`
--

LOCK TABLES `account_1` WRITE;
/*!40000 ALTER TABLE `account_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `branch_id` bigint(20) NOT NULL COMMENT '分支ID',
  `xid` varchar(100) NOT NULL COMMENT '全局唯一事务id',
  `rollback_info` longblob NOT NULL COMMENT '回滚信息',
  `log_status` int(11) NOT NULL COMMENT '状态',
  `log_created` datetime DEFAULT NULL COMMENT '创建时间',
  `log_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展',
  `context` varchar(100) NOT NULL COMMENT '序列化方式',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='事务回滚日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undo_log`
--

LOCK TABLES `undo_log` WRITE;
/*!40000 ALTER TABLE `undo_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `undo_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-12 23:40:51
CREATE DATABASE  IF NOT EXISTS `seata_account_1` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `seata_account_1`;
-- MySQL dump 10.13  Distrib 8.0.18, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: seata_account_1
-- ------------------------------------------------------
-- Server version	5.7.29-log

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
-- Table structure for table `account_0`
--

DROP TABLE IF EXISTS `account_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_0` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户id',
  `amount` decimal(10,0) DEFAULT NULL COMMENT '账户金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_0`
--

LOCK TABLES `account_0` WRITE;
/*!40000 ALTER TABLE `account_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_1`
--

DROP TABLE IF EXISTS `account_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_1` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(11) DEFAULT NULL COMMENT '用户id',
  `amount` decimal(10,0) DEFAULT NULL COMMENT '账户金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='账户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_1`
--

LOCK TABLES `account_1` WRITE;
/*!40000 ALTER TABLE `account_1` DISABLE KEYS */;
INSERT INTO `account_1` VALUES (3,1,0),(4,3,2000),(5,1259366746121359361,2000);
/*!40000 ALTER TABLE `account_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undo_log`
--

DROP TABLE IF EXISTS `undo_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `undo_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `branch_id` bigint(20) NOT NULL COMMENT '分支ID',
  `xid` varchar(100) NOT NULL COMMENT '全局唯一事务id',
  `rollback_info` longblob NOT NULL COMMENT '回滚信息',
  `log_status` int(11) NOT NULL COMMENT '状态',
  `log_created` datetime DEFAULT NULL COMMENT '创建时间',
  `log_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展',
  `context` varchar(100) NOT NULL COMMENT '序列化方式',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='事务回滚日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undo_log`
--

LOCK TABLES `undo_log` WRITE;
/*!40000 ALTER TABLE `undo_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `undo_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-12 23:40:52
