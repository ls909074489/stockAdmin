/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50627
Source Host           : 127.0.0.1:3306
Source Database       : stock_admin

Target Server Type    : MYSQL
Target Server Version : 50627
File Encoding         : 65001

Date: 2019-06-09 22:41:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('scheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for yy_alertmsg
-- ----------------------------
DROP TABLE IF EXISTS `yy_alertmsg`;
CREATE TABLE `yy_alertmsg` (
  `uuid` varchar(36) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `acode` varchar(255) NOT NULL,
  `alanguage` varchar(255) DEFAULT NULL,
  `alertmsg` varchar(1000) NOT NULL,
  `aname` varchar(255) DEFAULT NULL,
  `mcode` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `UK_99rq4ig1ww0et21yewej24lxi` (`acode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_alertmsg
-- ----------------------------
INSERT INTO `yy_alertmsg` VALUES ('085df077-d12d-4fad-9b6e-26e8c734d437', '2016-05-12 17:12:52', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-submit-relevance', '', '存在不能提交的记录！', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('0ad9a071-a21a-4b19-b8ff-8a06d71b7a02', '2016-05-12 17:15:18', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-unsubmit-relevance', '', '存在不能撤销提交的记录！', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('3a88fa3b-de2a-444b-bc17-bdc7872cfde5', '2016-05-12 16:54:09', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-submit-success', '', '提交成功', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('3c45004d-a242-424c-b926-c7a3d4ce0171', '2016-05-12 17:02:05', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-submit-http', '', '提交失败，HTTP错误。', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('46f7cf7a-053c-47d2-b235-ee5f331a86bb', '2016-05-12 17:17:27', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-unsubmit-sure', '', '确实要撤销提交吗？', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('5272a02c-c948-4017-a8b9-18187fe5dec9', '2017-05-20 15:12:21', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '系统管理员', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '系统管理员', '2017-06-13 20:07:50', '1', '2017-06-13 20:07:50', 'sys.comm.savesuccess', '', '保存成功!', '保存成功!', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('5e1b5917-d2ab-464e-a4ff-8abbcbcbfe35', '2016-05-11 15:55:41', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-delete-success', '', '删除成功。', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('6b900a77-588d-42f3-b546-d646402caa46', '2016-05-12 17:14:22', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-unsubmit-choose', '', '请选择需要撤销提交的记录', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('7d025eaa-2b61-44fb-ba6c-821f09f5f064', '2016-05-12 15:30:54', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', '2016-05-12 16:55:23', '1', null, 'sys-delete-http', '', '删除失败，HTTP错误。', '删除', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('90be8b79-b9b0-4dc9-bb43-866493c7de91', '2016-05-12 15:39:32', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', '2016-05-12 16:55:17', '1', null, 'sys-delete-choose', '', '请选择需要删除的记录', '删除', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('97f49c35-fc1f-4fd0-9da7-c4294669c06c', '2016-05-12 15:30:30', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', '2016-05-18 16:19:29', '1', null, 'sys-delete-fail', '', '删除失败，原因：', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('9e7365bc-c26b-49f6-b925-e99798071123', '2016-05-12 16:32:01', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-edit-no', '', '已经提交或者审核的数据不能修改。', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('bc1c0fe7-0877-4d39-af82-3b327d993af1', '2016-05-12 16:53:21', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-01-05 09:38:35', '1', '2018-01-05 09:38:35', 'sys-submit-sure', '', '确定要提交吗？', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('c14e9adc-bfb9-469e-b719-011496f8658a', '2017-05-20 15:13:00', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '系统管理员', null, null, null, '1', '2017-05-20 15:13:00', 'sys.comm.saveerrorhttperror', '', '保存时http错误!', '保存时http错误', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('c1de9f74-a818-4b58-93f0-b8b725e6c1da', '2017-09-10 13:45:22', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '系统管理员', null, null, null, '1', '2017-09-10 13:45:22', 'sys-submit-fail', '', '提交失败', '提交失败', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('c7388283-7b83-4bf9-8774-303e0144cca1', '2017-05-20 09:51:47', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '系统管理员', null, null, null, '1', '2017-05-20 09:51:47', 'sys-success-todo', '', '{0}成功！', '操作成功', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('ce3c9b90-cc7b-467b-8020-c1a75d2584c0', '2016-05-12 16:56:47', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys_submit-fail', '', '提交失败，原因：', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('ce7487fc-a06e-4c7d-ae28-a51db10d3da1', '2016-05-12 17:15:32', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-unsubmit-success', '', '提交成功', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('d026ea0f-0822-4201-a29d-050fceece98d', '2016-05-12 15:58:10', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', '2016-05-12 16:32:21', '1', null, 'sys-save-out', '', '确实要退出保存页面吗？', '退出保存页面', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('d2962226-4b96-4a6c-ba65-6f76026360c2', '2016-05-12 15:21:35', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-delete-sure', '', '确实要删除吗？', '删除时确认', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('d871e292-3643-4e9b-9f7d-51563d54c7ac', '2016-05-12 17:17:43', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys_unsubmit-fail', '', '撤销提交失败，原因：', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('dd280997-bf8a-4eb5-a1cb-d83a0c66fb93', '2017-05-20 09:52:25', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '系统管理员', null, null, null, '1', '2017-05-20 09:52:25', 'sys-fail-todo', '', '{0}失败，原因：', '操作失败', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('e2f21b1c-dd14-4748-87ae-61cdf76ead02', '2016-05-31 12:39:15', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2017-12-01 15:28:00', '1', '2017-12-01 15:28:00', 'sys-delete-check', '', '存在不能删除的记录。', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('e8e863d3-5ddb-4cb0-a128-5101b2ead8cc', '2016-05-12 15:13:20', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-delete-relevance', '', '存在关联不能删除', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('f1580bc9-2fbb-4534-be3a-d6488b8bb356', '2016-05-11 15:54:25', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', '2016-05-11 15:56:33', '1', null, 'sys-save-success', '', '保存成功。', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('fbf78c56-926f-4df1-9c82-050b307a76c8', '2016-05-12 17:12:24', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-submit-choose', '', '请选择需要提交的记录', '', 'sys', null);
INSERT INTO `yy_alertmsg` VALUES ('fe5effdd-907c-425e-959c-2d80b7c3d8df', '2016-05-12 17:14:48', 'd4859015-7452-4139-888e-8320a5d04f90', '管理员', null, null, null, '1', null, 'sys-unsubmit-http', '', '撤销提交失败，HTTP错误。', '', 'sys', null);

-- ----------------------------
-- Table structure for yy_attachment
-- ----------------------------
DROP TABLE IF EXISTS `yy_attachment`;
CREATE TABLE `yy_attachment` (
  `uuid` varchar(36) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `atta_type` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `entity_type` varchar(100) NOT NULL,
  `entity_uuid` varchar(50) NOT NULL,
  `file_class` varchar(20) DEFAULT NULL,
  `file_memo` varchar(250) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_size` varchar(255) DEFAULT NULL,
  `file_type` varchar(255) NOT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `preurl` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `upload_date` datetime DEFAULT NULL,
  `upload_user_id` varchar(255) NOT NULL,
  `upload_user_name` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_attachment
-- ----------------------------
INSERT INTO `yy_attachment` VALUES ('b07448ee-f908-43a5-9853-6461a68ff471', '2018-08-07 17:04:11', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-08-07 17:04:11', '0', null, 'noticeEntity', 'http://app.weishiao.com:8080/localserv/uploadFile', null, null, 'JVM-2.png', '1211311', 'PNG', null, null, null, '2018-08-07 17:04:11', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', 'uploadfiles\\noticeEntity\\20180807\\b07448ee-f908-43a5-9853-6461a68ff471.png');
INSERT INTO `yy_attachment` VALUES ('e5829306-4afe-4bee-9927-4ca5dd5a1b70', '2018-08-07 10:41:56', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-08-07 10:41:56', '0', null, 'purchase', '28', null, null, 'JVM-2.png', '1211311', 'PNG', null, null, null, '2018-08-07 10:41:56', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', 'uploadfiles\\purchase\\20180807\\e5829306-4afe-4bee-9927-4ca5dd5a1b70.png');

-- ----------------------------
-- Table structure for yy_channel
-- ----------------------------
DROP TABLE IF EXISTS `yy_channel`;
CREATE TABLE `yy_channel` (
  `uuid` varchar(36) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `argument` varchar(36) DEFAULT NULL,
  `channel_type` varchar(36) DEFAULT NULL,
  `memo` varchar(250) DEFAULT NULL,
  `name` varchar(250) DEFAULT NULL,
  `station_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `FK_fx7n87pvro27h7ouxv29k4rbu` (`station_id`),
  CONSTRAINT `FK_fx7n87pvro27h7ouxv29k4rbu` FOREIGN KEY (`station_id`) REFERENCES `yy_org` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_channel
-- ----------------------------

-- ----------------------------
-- Table structure for yy_department
-- ----------------------------
DROP TABLE IF EXISTS `yy_department`;
CREATE TABLE `yy_department` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) NOT NULL,
  `nodepath` varchar(500) DEFAULT NULL,
  `active` varchar(255) DEFAULT NULL,
  `code` varchar(20) NOT NULL,
  `created_date` varchar(255) DEFAULT NULL,
  `creater` varchar(50) DEFAULT NULL,
  `islast` bit(1) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `parentid` varchar(100) DEFAULT NULL,
  `verified_date` varchar(255) DEFAULT NULL,
  `verifier` varchar(50) DEFAULT NULL,
  `is_direct` varchar(255) DEFAULT NULL,
  `memo` varchar(2000) DEFAULT NULL,
  `pk_corp` varchar(36) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `UK_f2xvkirfo21ctcas4ctr86tsa` (`code`),
  KEY `FK_85m1sx08pf4banolutsd7cms1` (`pk_corp`),
  CONSTRAINT `FK_85m1sx08pf4banolutsd7cms1` FOREIGN KEY (`pk_corp`) REFERENCES `yy_org` (`uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_department
-- ----------------------------

-- ----------------------------
-- Table structure for yy_enumdata
-- ----------------------------
DROP TABLE IF EXISTS `yy_enumdata`;
CREATE TABLE `yy_enumdata` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `groupcode` varchar(50) NOT NULL,
  `groupname` varchar(100) NOT NULL,
  `modulecode` varchar(255) DEFAULT NULL,
  `sys` bit(1) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `UK_d700awgw3dnc3ylfhu0odoc15` (`groupcode`),
  UNIQUE KEY `UK_cfp2yd1n29e5mnj5ni92f2nl9` (`groupname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_enumdata
-- ----------------------------
INSERT INTO `yy_enumdata` VALUES ('0caf7864-dcff-42e2-84b9-0e734dbcaa01', '1', '', 'BillStatusNew', '单据状态-无审批态', 'sys', '\0', null, null, null, null, null, null, null, null, '2017-05-31 22:27:39');
INSERT INTO `yy_enumdata` VALUES ('1b902fd9-4efd-4022-87b4-a0c7bcbdb4c0', '1', '', 'NoticeCategory', '通知分类', '系统管理', '\0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-12 23:55:21', null, '系统管理员', null, null, null, null);
INSERT INTO `yy_enumdata` VALUES ('27f395f9-992d-4da6-a62a-c29a75d25428', '1', '', 'UserType', '用户类型', 'sys', '\0', null, null, null, null, null, null, null, null, '2017-11-16 19:19:38');
INSERT INTO `yy_enumdata` VALUES ('351d61a8-751a-4f9d-bef9-4c6863906db6', '1', '', 'BooleanType', '是否类型', '系统管理', '\0', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata` VALUES ('46d364f3-c1f1-4fa3-a7d7-d2667e5968f1', '1', '', 'BillStatus', '单据状态', 'sys', '\0', null, null, null, '2016-03-13 02:59:21', null, null, null, null, '2017-05-16 20:53:41');
INSERT INTO `yy_enumdata` VALUES ('4ce661ed-c637-497a-9cbd-2d84b82f4536', '1', '', 'Education', '学历', 'sys', '\0', null, null, null, null, null, null, null, null, '2016-12-03 11:32:39');
INSERT INTO `yy_enumdata` VALUES ('4ffb5f5b-325b-4531-9005-badf32ec9e9a', '1', '', 'OrgType', '机构类型', 'sys', '\0', null, null, null, null, null, null, null, null, '2017-11-16 19:35:17');
INSERT INTO `yy_enumdata` VALUES ('512fd4f8-f677-45f3-b7e9-8c33c7379d4d', '1', '', 'sys_moudule', '系统模块', 'sys', '\0', null, null, null, null, null, null, null, null, '2017-11-16 16:48:37');
INSERT INTO `yy_enumdata` VALUES ('b3dfe008-7602-46f1-924b-051dee7aa038', '1', '', 'BillApplyStatus', '单据申请状态', 'sys', '\0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, '系统管理员', null, '2017-05-16 20:58:08', null, '2017-05-16 20:58:08');
INSERT INTO `yy_enumdata` VALUES ('b53ceec1-c8d3-4330-8957-fd8085230842', '1', '', 'CommonMenus', '普通头顶菜单', '01', '\0', null, null, null, null, null, null, null, null, '2018-10-22 20:55:59');
INSERT INTO `yy_enumdata` VALUES ('baeee465-8ae5-499c-a6e4-d48e576f0c4c', '1', '', 'OrgLevel', '组织架构级别', 'sys', '\0', null, null, null, null, null, null, null, null, '2016-11-26 09:36:45');
INSERT INTO `yy_enumdata` VALUES ('c8a5d779-9435-46db-89e6-c67285809268', '1', '', 'Usestatus', '使用状态', '系统管理', '\0', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-08 21:50:43', null, '系统管理员', null, null, null);
INSERT INTO `yy_enumdata` VALUES ('d1e4ebd9-d43f-44d3-a320-6bb9f2bc3572', '1', '', 'functype', '功能类型', '系统管理', '\0', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata` VALUES ('d705262d-356b-48bc-8b17-7c82a30901c2', '1', '', 'sys_sex', '性别', 'sys', '\0', null, null, null, null, null, null, null, null, '2016-12-14 17:19:04');
INSERT INTO `yy_enumdata` VALUES ('f24dec95-9b54-4353-9ae7-9e1ee33e7845', '1', '', 'ApplyStatus', '申请状态', 'sys', '\0', null, null, null, null, null, null, null, null, '2016-12-03 11:32:35');

-- ----------------------------
-- Table structure for yy_enumdata_sub
-- ----------------------------
DROP TABLE IF EXISTS `yy_enumdata_sub`;
CREATE TABLE `yy_enumdata_sub` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `enumdatakey` varchar(50) DEFAULT NULL,
  `enumdataname` varchar(50) NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `isdefault` bit(1) DEFAULT NULL,
  `showorder` smallint(6) DEFAULT NULL,
  `enumdataid` varchar(36) NOT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `FK_i6t6t56wkxcm4qcy9xnjrvrc7` (`enumdataid`),
  CONSTRAINT `FK_i6t6t56wkxcm4qcy9xnjrvrc7` FOREIGN KEY (`enumdataid`) REFERENCES `yy_enumdata` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_enumdata_sub
-- ----------------------------
INSERT INTO `yy_enumdata_sub` VALUES ('08191ae0-dea3-4a5d-8848-1798bc65fdf1', '1', null, '08', '博士后', null, '\0', null, '4ce661ed-c637-497a-9cbd-2d84b82f4536', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('09a6378d-93d5-49b4-ba5e-2b2fb7003d89', '1', null, '10', '学校', null, '\0', '1', 'baeee465-8ae5-499c-a6e4-d48e576f0c4c', null, null, null, null, null, null, null, null, '2016-11-26 09:36:45');
INSERT INTO `yy_enumdata_sub` VALUES ('153bac32-0d2c-4e5b-8ca9-3cd4b9cb4a6d', '1', null, '4', '被退回', null, '\0', '5', '46d364f3-c1f1-4fa3-a7d7-d2667e5968f1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-03-13 02:59:21', null, '系统管理员', null, '2016-03-13 02:59:21', null);
INSERT INTO `yy_enumdata_sub` VALUES ('172c6619-f0b8-48d4-ac28-25c151fcf535', '1', null, '1', '普通', null, '\0', '2', '27f395f9-992d-4da6-a62a-c29a75d25428', null, null, null, null, null, null, null, null, '2017-01-30 09:44:16');
INSERT INTO `yy_enumdata_sub` VALUES ('1942d027-56ea-4bdf-9ea8-cb587c4bd4a3', '1', null, '04', '大专', null, '\0', null, '4ce661ed-c637-497a-9cbd-2d84b82f4536', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('1faffb72-e278-4fe7-b61b-523be828545e', '1', null, '2', '已提交', null, '\0', '2', '0caf7864-dcff-42e2-84b9-0e734dbcaa01', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, '系统管理员', null, '2017-05-26 19:06:54', null, '2017-05-26 19:06:54');
INSERT INTO `yy_enumdata_sub` VALUES ('23c069d4-cd72-4a33-9c67-38ffd9b81c47', '1', null, '5', '已审核', null, '\0', '4', '0caf7864-dcff-42e2-84b9-0e734dbcaa01', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, '系统管理员', null, '2017-05-26 19:06:54', null, '2017-05-26 19:06:54');
INSERT INTO `yy_enumdata_sub` VALUES ('25be360e-81a6-48df-bef2-b9d53ac47952', '1', '4,5', '2b1e6e6e-8af8-4ec7-abfd-c07a637193e2', '订单', '/info/purchase/list', '\0', '2', 'b53ceec1-c8d3-4330-8957-fd8085230842', null, null, null, null, null, null, null, null, '2018-10-14 15:55:17');
INSERT INTO `yy_enumdata_sub` VALUES ('27d936a2-1b2b-49af-88a8-9a564f726812', '1', null, 'sys', '系统管理', null, '\0', '0', '512fd4f8-f677-45f3-b7e9-8c33c7379d4d', null, null, null, null, null, null, null, null, '2016-12-03 11:31:53');
INSERT INTO `yy_enumdata_sub` VALUES ('28701914-6869-488e-91f6-59fa1f304866', '1', null, '5', '审批不通过', null, '\0', null, 'f24dec95-9b54-4353-9ae7-9e1ee33e7845', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-27 09:26:54', null, '系统管理员', null, '2016-02-27 09:26:54', null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('2b535072-0033-4112-833e-642be4c59ead', '1', null, '0', '禁用', null, '\0', null, 'c8a5d779-9435-46db-89e6-c67285809268', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-08 21:50:43', null, '系统管理员', null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('2b7ed885-5547-4ab5-a3cd-f93ae8f33d45', '1', null, '01', '管控系统', null, '\0', '1', '512fd4f8-f677-45f3-b7e9-8c33c7379d4d', null, null, null, null, null, null, null, null, '2017-11-16 16:48:37');
INSERT INTO `yy_enumdata_sub` VALUES ('2cf87350-6a33-40f1-ad8e-3e1a1c503405', '1', null, '20', '审批通过', null, '\0', null, 'f24dec95-9b54-4353-9ae7-9e1ee33e7845', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-27 09:26:54', null, '系统管理员', null, '2016-02-27 09:26:54', null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('32335028-4805-4dd3-ba9a-decde943de6e', '1', null, '07', '博士', null, '\0', null, '4ce661ed-c637-497a-9cbd-2d84b82f4536', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('32b789a7-e2f0-4825-b20d-ccc27ad7186a', '1', null, '3', '紧急通知', null, '\0', '3', '1b902fd9-4efd-4022-87b4-a0c7bcbdb4c0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-12 23:55:21', null, '系统管理员', null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('375d16df-0b8c-4924-876e-3843856ac0e2', '1', null, '2', '重要通知', null, '\0', '2', '1b902fd9-4efd-4022-87b4-a0c7bcbdb4c0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-12 23:55:21', null, '系统管理员', null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('381095a6-4113-4d39-9978-5c7edc656e7a', '1', '2,3', 'f1803123-07aa-4f1d-a2ff-b22fba030b05', '样品', '/info/sample/list', '\0', '1', 'b53ceec1-c8d3-4330-8957-fd8085230842', null, null, null, null, null, null, null, null, '2018-08-30 22:32:04');
INSERT INTO `yy_enumdata_sub` VALUES ('3b503b2b-6c42-4ca8-951a-689ff18b3b4b', '1', null, '06', '硕士', null, '\0', null, '4ce661ed-c637-497a-9cbd-2d84b82f4536', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('3dce5cbd-d105-48c8-9189-d808e7c039a6', '1', null, '1', '男', null, '\0', '1', 'd705262d-356b-48bc-8b17-7c82a30901c2', null, null, null, null, null, null, null, null, '2016-12-14 17:18:58');
INSERT INTO `yy_enumdata_sub` VALUES ('41b3df87-7010-4c94-a2bb-0335cadcb0e5', '1', null, '40', '班级', null, '\0', '4', 'baeee465-8ae5-499c-a6e4-d48e576f0c4c', null, null, null, null, null, null, null, null, '2016-11-26 09:36:45');
INSERT INTO `yy_enumdata_sub` VALUES ('4fd84912-5656-45b7-a284-1932de4e03fc', '1', '1', '80baf566-4187-4173-ab9f-195ed290b7af', '仓库', '/info/stock/list', '\0', '0', 'b53ceec1-c8d3-4330-8957-fd8085230842', null, null, null, null, null, null, null, null, '2018-08-28 21:12:23');
INSERT INTO `yy_enumdata_sub` VALUES ('61147f1d-b48f-451a-b8d2-e6215725f467', '1', null, 'func', '功能', null, '\0', null, 'd1e4ebd9-d43f-44d3-a320-6bb9f2bc3572', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('6f87eb26-2f64-480e-b080-b64cc1b4314b', '1', null, 'sys', '系统', null, '\0', null, 'd1e4ebd9-d43f-44d3-a320-6bb9f2bc3572', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('7068596d-e976-4d47-93bf-287648154228', '1', null, '1', '启用', null, '\0', null, 'c8a5d779-9435-46db-89e6-c67285809268', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-08 21:50:43', null, '系统管理员', null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('7453a196-1157-428b-8460-a2b4f29ac6ad', '1', null, '1', '总公司', null, '\0', '1', '4ffb5f5b-325b-4531-9005-badf32ec9e9a', null, null, null, null, null, null, null, null, '2017-11-16 19:35:17');
INSERT INTO `yy_enumdata_sub` VALUES ('814b380b-5236-4931-86bf-baffd4dbc2a6', '1', null, '30', '专业', null, '\0', '3', 'baeee465-8ae5-499c-a6e4-d48e576f0c4c', null, null, null, null, null, null, null, null, '2016-11-26 09:36:45');
INSERT INTO `yy_enumdata_sub` VALUES ('8a65ad54-777b-4943-85da-941d62a22f9c', '1', null, '02', '已提交', null, '\0', '2', 'b3dfe008-7602-46f1-924b-051dee7aa038', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, '系统管理员', null, '2017-05-16 20:58:08', null, '2017-05-16 20:58:08');
INSERT INTO `yy_enumdata_sub` VALUES ('8ffa48ea-295e-4546-823f-f3f39f109bcc', '1', null, '5', '已审核', null, '\0', '4', '46d364f3-c1f1-4fa3-a7d7-d2667e5968f1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-03-13 02:59:21', null, '系统管理员', null, '2016-03-13 02:59:21', null);
INSERT INTO `yy_enumdata_sub` VALUES ('9242f4aa-15db-4913-8edc-41fd289b1612', '1', null, '1', '未提交', null, '\0', '1', '0caf7864-dcff-42e2-84b9-0e734dbcaa01', null, null, null, null, null, null, null, null, '2017-05-31 22:27:39');
INSERT INTO `yy_enumdata_sub` VALUES ('9a0e6a49-8011-4e7f-82bd-da60ea15587c', '1', '999', '0cb472fe-fc25-4db3-914e-b30390ea57cd', '料号规格', '/info/stuff/list', '\0', '5', 'b53ceec1-c8d3-4330-8957-fd8085230842', null, null, null, null, null, null, null, null, '2018-10-22 20:55:59');
INSERT INTO `yy_enumdata_sub` VALUES ('a1053da5-db9b-4abc-ac8d-e4368e110be9', '1', null, '20', '学院', null, '\0', '2', 'baeee465-8ae5-499c-a6e4-d48e576f0c4c', null, null, null, null, null, null, null, null, '2016-11-26 09:36:45');
INSERT INTO `yy_enumdata_sub` VALUES ('a39ad480-472e-477c-b592-0c0177f9e0ad', '1', null, '4', '被退回', null, '\0', '3', '0caf7864-dcff-42e2-84b9-0e734dbcaa01', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, '系统管理员', null, '2017-05-26 19:06:54', null, '2017-05-26 19:06:54');
INSERT INTO `yy_enumdata_sub` VALUES ('a70e71a8-de8a-41e8-b18e-28cef29be0ad', '1', null, '2', '分公司', null, '\0', '2', '4ffb5f5b-325b-4531-9005-badf32ec9e9a', null, null, null, null, null, null, null, null, '2017-11-16 19:35:17');
INSERT INTO `yy_enumdata_sub` VALUES ('a86f25b2-46ae-4a28-8f02-404931ebad46', '1', null, '03', '高中', null, '\0', null, '4ce661ed-c637-497a-9cbd-2d84b82f4536', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('ad05b64f-9666-4fee-93ad-bf455e3bc63e', '1', null, '01', '未提交', null, '\0', '1', 'b3dfe008-7602-46f1-924b-051dee7aa038', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, '系统管理员', null, '2017-05-16 20:58:08', null, '2017-05-16 20:58:08');
INSERT INTO `yy_enumdata_sub` VALUES ('ad38e959-a3b4-4a02-b290-96001527de44', '1', null, '02', '初中', null, '\0', null, '4ce661ed-c637-497a-9cbd-2d84b82f4536', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('b268d8b0-4f6c-40c9-9c8d-1a010f82f854', '1', null, '10', '审批中', null, '\0', null, 'f24dec95-9b54-4353-9ae7-9e1ee33e7845', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-26 21:38:16', null, '系统管理员', null, '2016-02-26 21:38:16', null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('b8c28d2b-4f79-49c8-bdd7-4b9d034088a5', '1', null, '01', '小学', null, '\0', null, '4ce661ed-c637-497a-9cbd-2d84b82f4536', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('bae7662f-a853-46b0-9e70-c15a4c778eef', '1', null, '3', '审核中', null, '\0', '3', '46d364f3-c1f1-4fa3-a7d7-d2667e5968f1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-03-13 02:59:21', null, '系统管理员', null, '2016-03-13 02:59:21', null);
INSERT INTO `yy_enumdata_sub` VALUES ('bbe43595-6b3b-46a3-a78b-03685a605394', '1', null, '0', '申请中', null, '\0', null, 'f24dec95-9b54-4353-9ae7-9e1ee33e7845', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-26 21:38:16', null, '系统管理员', null, '2016-02-26 21:38:16', null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('bc391ce4-6aa6-4757-8667-fb51af9195ac', '1', null, '1', '未提交', null, '\0', '1', '46d364f3-c1f1-4fa3-a7d7-d2667e5968f1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-03-13 02:59:21', null, '系统管理员', null, '2016-03-13 02:59:21', null);
INSERT INTO `yy_enumdata_sub` VALUES ('bd8bef94-d946-4349-ab79-b3f5d33ec7c4', '1', null, 'module', '模块', null, '\0', null, 'd1e4ebd9-d43f-44d3-a320-6bb9f2bc3572', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('bf3127b7-c267-44c6-80aa-da56b460587a', '1', null, '1', '常规通知', null, '\0', '1', '1b902fd9-4efd-4022-87b4-a0c7bcbdb4c0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-02-12 23:55:21', null, '系统管理员', null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('bf7009c3-53dd-4234-951e-d473e0c9e9ad', '1', null, '04', '被退回', null, '\0', '4', 'b3dfe008-7602-46f1-924b-051dee7aa038', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, '系统管理员', null, '2017-05-16 20:58:08', null, '2017-05-16 20:58:08');
INSERT INTO `yy_enumdata_sub` VALUES ('c39c2bb3-7afb-4672-ad9a-923743b922c6', '1', null, '0', '否', null, '\0', '2', '351d61a8-751a-4f9d-bef9-4c6863906db6', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-01-26 09:55:09', null, '系统管理员', null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('d8a876e3-3e9d-4e2a-8d56-5ce2db72f9ad', '1', null, '03', '已审核', null, '\0', '3', 'b3dfe008-7602-46f1-924b-051dee7aa038', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, '系统管理员', null, '2017-05-16 20:58:08', null, '2017-05-16 20:58:08');
INSERT INTO `yy_enumdata_sub` VALUES ('d9fe03ef-d554-42b5-8ffc-f92e679ad58a', '1', null, '2', '管理', null, '\0', '1', '27f395f9-992d-4da6-a62a-c29a75d25428', null, null, null, null, null, null, null, null, '2017-01-30 09:44:16');
INSERT INTO `yy_enumdata_sub` VALUES ('dd2ec302-86b9-46e1-9d52-fe5238cc9abb', '1', null, '1', '是', null, '', '1', '351d61a8-751a-4f9d-bef9-4c6863906db6', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-01-26 09:55:09', null, '系统管理员', null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('dd843803-5440-4ba6-85d5-d61c81d3b0bb', '1', null, '0', '女', null, '\0', '2', 'd705262d-356b-48bc-8b17-7c82a30901c2', null, null, null, null, null, null, null, null, '2016-12-14 17:18:58');
INSERT INTO `yy_enumdata_sub` VALUES ('e3e17069-a6b0-46ab-a5a6-487fac1282e5', '1', null, 'space', '虚节点', null, '\0', null, 'd1e4ebd9-d43f-44d3-a320-6bb9f2bc3572', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('e44cad69-9d95-4a2b-a00c-7d57d00889b8', '1', '999', 'a7c68d79-8a4e-4b61-b41d-121a2c23a692', '客户名称', '/info/customer/list', '\0', '4', 'b53ceec1-c8d3-4330-8957-fd8085230842', null, null, null, null, null, null, null, null, '2018-10-22 20:55:59');
INSERT INTO `yy_enumdata_sub` VALUES ('eeecf5ca-bcf0-4fa0-b783-b40b1058126c', '1', '0', '4d3c235b-786c-4d8f-a826-13dff2f646ef', '退货', '/info/reject/list', '\0', '3', 'b53ceec1-c8d3-4330-8957-fd8085230842', null, null, null, null, null, null, null, null, '2018-08-14 22:42:50');
INSERT INTO `yy_enumdata_sub` VALUES ('ef231f33-8f9e-4656-8fc1-7cc6c1ce3d53', '1', null, '05', '本科', null, '\0', null, '4ce661ed-c637-497a-9cbd-2d84b82f4536', null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_enumdata_sub` VALUES ('f219c6a6-6719-49f5-99cd-8979e294b044', '1', null, '2', '已提交', null, '\0', '2', '46d364f3-c1f1-4fa3-a7d7-d2667e5968f1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-03-13 02:59:21', null, '系统管理员', null, '2016-03-13 02:59:21', null);

-- ----------------------------
-- Table structure for yy_func
-- ----------------------------
DROP TABLE IF EXISTS `yy_func`;
CREATE TABLE `yy_func` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `create_ts` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_ts` datetime DEFAULT NULL,
  `nodepath` varchar(500) DEFAULT NULL,
  `auth_type` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `fun_css` varchar(100) DEFAULT NULL,
  `func_code` varchar(20) NOT NULL,
  `func_name` varchar(50) NOT NULL,
  `func_type` varchar(50) DEFAULT NULL,
  `func_url` varchar(500) DEFAULT NULL,
  `help_code` varchar(500) DEFAULT NULL,
  `hint` varchar(255) DEFAULT NULL,
  `iconcls` varchar(50) DEFAULT NULL,
  `islast` bit(1) DEFAULT NULL,
  `parentid` varchar(255) DEFAULT NULL,
  `permission_code` varchar(255) DEFAULT NULL,
  `showorder` smallint(6) DEFAULT NULL,
  `sys` bit(1) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `usestatus` varchar(255) NOT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `UK_5diiopyc3xa9bpiexr8uaek17` (`func_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_func
-- ----------------------------
INSERT INTO `yy_func` VALUES ('0cb472fe-fc25-4db3-914e-b30390ea57cd', '1', null, null, null, null, 'root,2c90e4d74917c191014917c3cf1d0000,79f79877-5599-4b52-9e3c-e22307630fb8,0cb472fe-fc25-4db3-914e-b30390ea57cd', null, '', null, '5060', '产品料号', 'func', '@ctx@/info/stuff/list', null, null, '', '', '79f79877-5599-4b52-9e3c-e22307630fb8', null, null, '\0', null, null, null, null, null, null, '1', '2018-10-11 09:49:18');
INSERT INTO `yy_func` VALUES ('20b906b3-7cf3-4603-9fc2-3677d264cf89', '1', '2015-12-25 11:43:21', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 11:20:17', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,20b906b3-7cf3-4603-9fc2-3677d264cf89', null, '', null, '0000', '机构管理', 'space', '', null, null, 'fa fa-sitemap', '\0', '4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6', null, null, '\0', null, '2016-02-13 10:46:01', null, null, '系统管理员', null, '1', '2017-11-17 10:51:48');
INSERT INTO `yy_func` VALUES ('27f86078-4190-4770-9312-acea5c1beb1d', '1', '2015-12-11 16:31:56', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 11:20:17', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,20b906b3-7cf3-4603-9fc2-3677d264cf89,27f86078-4190-4770-9312-acea5c1beb1d', null, '', null, '001010', '组织机构', 'func', '@ctx@/sys/org', null, null, '', '', '20b906b3-7cf3-4603-9fc2-3677d264cf89', null, null, '\0', null, '2016-03-04 20:56:05', null, null, '系统管理员', '2016-03-04 20:56:05', '1', '2017-11-17 10:51:48');
INSERT INTO `yy_func` VALUES ('2b1e6e6e-8af8-4ec7-abfd-c07a637193e2', '1', null, null, null, null, 'root,2c90e4d74917c191014917c3cf1d0000,79f79877-5599-4b52-9e3c-e22307630fb8,2b1e6e6e-8af8-4ec7-abfd-c07a637193e2', null, '', null, '5030', '订购管理', 'func', '@ctx@/info/purchase/list', null, null, '', '', '79f79877-5599-4b52-9e3c-e22307630fb8', null, null, '\0', null, null, null, null, null, null, '1', '2018-09-05 15:40:05');
INSERT INTO `yy_func` VALUES ('2c90e4d74917c191014917c3cf1d0000', '1', '2014-10-16 15:02:29', null, null, '2016-01-05 10:42:26', 'root,2c90e4d74917c191014917c3cf1d0000', null, '', null, 'xzjy', '功能注册', 'sys', '', null, null, '/assets/szgzw/img/system/10.jpg', '\0', 'root', null, '2', '\0', null, null, null, null, null, null, '1', '2018-09-05 15:40:04');
INSERT INTO `yy_func` VALUES ('4d3c235b-786c-4d8f-a826-13dff2f646ef', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, 'root,2c90e4d74917c191014917c3cf1d0000,79f79877-5599-4b52-9e3c-e22307630fb8,4d3c235b-786c-4d8f-a826-13dff2f646ef', null, '', null, '5040', '退货', 'func', '@ctx@/info/reject/list', null, null, '', '', '79f79877-5599-4b52-9e3c-e22307630fb8', null, null, '\0', null, null, '2018-08-14 22:37:58', '超级系统管理员', null, null, '1', '2018-08-14 22:37:58');
INSERT INTO `yy_func` VALUES ('4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6', '1', null, null, null, '2016-01-05 10:42:28', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6', null, '', null, '90', '系统管理', 'module', '', null, null, 'icon-settings', '\0', '2c90e4d74917c191014917c3cf1d0000', null, '0', '\0', null, null, null, null, null, null, '1', '2016-12-03 16:47:37');
INSERT INTO `yy_func` VALUES ('5b1047f9-05d3-4b6d-9f38-94b32ef32bfa', '1', '2015-12-11 13:26:20', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:31', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ddb7a5f2-2591-4450-96a7-84673a1ddf5e,5b1047f9-05d3-4b6d-9f38-94b32ef32bfa', null, '', null, '901020', '枚举数据', 'func', '@ctx@/sys/enumdata', null, null, '', '', 'ddb7a5f2-2591-4450-96a7-84673a1ddf5e', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('78ec0591-0f64-4041-8fe9-8798fa4830ec', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ddb7a5f2-2591-4450-96a7-84673a1ddf5e,78ec0591-0f64-4041-8fe9-8798fa4830ec', null, '', null, '901090', '提示语信息维护', 'func', '@ctx@/sys/alertmsg', null, null, '', '', 'ddb7a5f2-2591-4450-96a7-84673a1ddf5e', null, null, '\0', null, null, '2017-05-20 10:05:51', '系统管理员', null, null, '1', '2017-05-20 10:05:51');
INSERT INTO `yy_func` VALUES ('79f79877-5599-4b52-9e3c-e22307630fb8', '1', null, null, null, null, 'root,2c90e4d74917c191014917c3cf1d0000,79f79877-5599-4b52-9e3c-e22307630fb8', null, '', null, '50', '基础档案', 'module', '', null, null, 'fa fa-file', '\0', '2c90e4d74917c191014917c3cf1d0000', null, null, '\0', null, null, null, null, null, null, '1', '2017-11-17 16:27:40');
INSERT INTO `yy_func` VALUES ('80baf566-4187-4173-ab9f-195ed290b7af', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, 'root,2c90e4d74917c191014917c3cf1d0000,79f79877-5599-4b52-9e3c-e22307630fb8,80baf566-4187-4173-ab9f-195ed290b7af', null, '', null, '5050', '仓库', 'func', '@ctx@/info/stock/list', null, null, '', '', '79f79877-5599-4b52-9e3c-e22307630fb8', null, null, '\0', null, null, '2018-08-14 22:38:57', '超级系统管理员', null, null, '1', '2018-08-14 22:38:57');
INSERT INTO `yy_func` VALUES ('82c42da6-7ab1-4f14-a272-d7121dbf33db', '1', '2015-12-11 13:35:31', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:31', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ddb7a5f2-2591-4450-96a7-84673a1ddf5e,82c42da6-7ab1-4f14-a272-d7121dbf33db', null, '', null, '901030', '功能注册', 'func', '@ctx@/sys/func', null, null, '', '', 'ddb7a5f2-2591-4450-96a7-84673a1ddf5e', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('97729cd0-8091-4438-887c-7e8fa5fbc6db', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ddb7a5f2-2591-4450-96a7-84673a1ddf5e,97729cd0-8091-4438-887c-7e8fa5fbc6db', null, '', null, '901070', '导出导入模板设置', 'func', '@ctx@/sys/imexlate', null, null, '', '', 'ddb7a5f2-2591-4450-96a7-84673a1ddf5e', null, null, '\0', '2016-12-03 08:58:52', null, '2016-12-03 08:58:52', '系统管理员', null, null, '1', '2016-12-03 08:58:52');
INSERT INTO `yy_func` VALUES ('9ce5e0d4-7456-475a-96c9-a13640117b24', '1', '2015-12-11 13:40:54', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:30', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,be379538-5e81-4b5c-9794-6d29e11a0f6c,9ce5e0d4-7456-475a-96c9-a13640117b24', null, '', null, '902030', '用户管理', 'func', '@ctx@/sys/user', null, null, '', '', 'be379538-5e81-4b5c-9794-6d29e11a0f6c', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('a2647c60-4396-43bc-8869-4e1b79917e53', '1', '2015-12-11 13:40:29', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:30', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,be379538-5e81-4b5c-9794-6d29e11a0f6c,a2647c60-4396-43bc-8869-4e1b79917e53', null, '', null, '902020', '角色管理', 'func', '@ctx@/sys/role', null, null, '', '', 'be379538-5e81-4b5c-9794-6d29e11a0f6c', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('a7c68d79-8a4e-4b61-b41d-121a2c23a692', '1', null, null, null, null, 'root,2c90e4d74917c191014917c3cf1d0000,79f79877-5599-4b52-9e3c-e22307630fb8,a7c68d79-8a4e-4b61-b41d-121a2c23a692', null, '', null, '5070', '客户姓名', 'func', '@ctx@/info/customer/list', null, null, '', '', '79f79877-5599-4b52-9e3c-e22307630fb8', null, null, '\0', null, null, null, null, null, null, '1', '2018-10-11 09:49:26');
INSERT INTO `yy_func` VALUES ('b45e5d4c-38dc-4be3-9cbf-9d5262878348', '1', '2015-12-11 16:25:15', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:30', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ca9acb60-5300-44df-ae44-01f78748aff0,b45e5d4c-38dc-4be3-9cbf-9d5262878348', null, '', null, '906010', '系统日志', 'func', '@ctx@/sys/log', null, null, '', '', 'ca9acb60-5300-44df-ae44-01f78748aff0', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('be379538-5e81-4b5c-9794-6d29e11a0f6c', '1', '2015-12-17 10:31:24', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:30', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,be379538-5e81-4b5c-9794-6d29e11a0f6c', null, '', null, '9020', '权限管理', 'space', '', null, null, 'fa fa-child', '\0', '4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('ca9acb60-5300-44df-ae44-01f78748aff0', '1', '2015-12-11 16:24:51', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:30', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ca9acb60-5300-44df-ae44-01f78748aff0', null, '', null, '9060', '系统监控', 'space', '', null, null, 'fa fa-video-camera', '\0', '4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('da595c92-0a64-4804-9887-8becc103ccd1', '1', '2015-12-17 16:57:32', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:31', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,da595c92-0a64-4804-9887-8becc103ccd1', null, '', null, '9080', '消息管理', 'space', '@ctx@/', null, null, 'fa fa-comments', '\0', '4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('ddb7a5f2-2591-4450-96a7-84673a1ddf5e', '1', '2015-12-11 11:49:10', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:31', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ddb7a5f2-2591-4450-96a7-84673a1ddf5e', null, '', null, '9010', '系统设置', 'space', '', null, null, 'fa fa-wrench', '\0', '4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('e33e2576-ed05-4386-8cc0-d582d0c9fae3', '1', '2015-12-11 13:16:26', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:32', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ddb7a5f2-2591-4450-96a7-84673a1ddf5e,e33e2576-ed05-4386-8cc0-d582d0c9fae3', null, '', null, '901010', '系统参数', 'func', '@ctx@/sys/param', null, null, '', '', 'ddb7a5f2-2591-4450-96a7-84673a1ddf5e', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('f1803123-07aa-4f1d-a2ff-b22fba030b05', '1', null, null, null, null, 'root,2c90e4d74917c191014917c3cf1d0000,79f79877-5599-4b52-9e3c-e22307630fb8,f1803123-07aa-4f1d-a2ff-b22fba030b05', null, '', null, '5020', '样品', 'func', '@ctx@/info/sample/list', null, null, '', '', '79f79877-5599-4b52-9e3c-e22307630fb8', null, null, '\0', null, null, null, null, null, null, '1', '2018-07-31 10:14:41');
INSERT INTO `yy_func` VALUES ('f9c02e15-9809-4a2a-8a0f-f780a6f10d80', '1', '2015-12-17 16:57:46', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:31', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,da595c92-0a64-4804-9887-8becc103ccd1,f9c02e15-9809-4a2a-8a0f-f780a6f10d80', null, '', null, '908010', '通知公告', 'func', '@ctx@/sys/notice', null, null, '', '', 'da595c92-0a64-4804-9887-8becc103ccd1', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('fad556f2-1007-4f41-95fa-43a866ea1543', '1', '2015-12-11 13:40:10', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-01-05 10:42:30', 'root,2c90e4d74917c191014917c3cf1d0000,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,be379538-5e81-4b5c-9794-6d29e11a0f6c,fad556f2-1007-4f41-95fa-43a866ea1543', null, '', null, '902010', '角色组', 'func', '@ctx@/sys/roleGroup', null, null, '', '', 'be379538-5e81-4b5c-9794-6d29e11a0f6c', null, null, '\0', null, '2016-02-05 18:25:59', null, null, '系统管理员', null, '1', '2016-09-21 17:15:04');
INSERT INTO `yy_func` VALUES ('root', '1', null, null, null, '2015-12-11 11:11:11', 'root', '1', null, null, 'root', '系统功能', null, null, null, null, 'icon-cogs', '\0', null, null, null, '\0', null, null, null, null, null, null, '1', null);

-- ----------------------------
-- Table structure for yy_func_action
-- ----------------------------
DROP TABLE IF EXISTS `yy_func_action`;
CREATE TABLE `yy_func_action` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `create_ts` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_ts` datetime DEFAULT NULL,
  `actioncode` varchar(20) NOT NULL,
  `actionname` varchar(50) NOT NULL,
  `showorder` smallint(6) DEFAULT NULL,
  `func_id` varchar(36) NOT NULL,
  `approver_ts` datetime DEFAULT NULL,
  `approvers` varchar(50) DEFAULT NULL,
  `approver` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `approver_time` datetime DEFAULT NULL,
  `auditstatus` int(11) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `FK_n16yypfhw6cbww47l26rn01n6` (`func_id`),
  CONSTRAINT `FK_n16yypfhw6cbww47l26rn01n6` FOREIGN KEY (`func_id`) REFERENCES `yy_func` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_func_action
-- ----------------------------

-- ----------------------------
-- Table structure for yy_func_param
-- ----------------------------
DROP TABLE IF EXISTS `yy_func_param`;
CREATE TABLE `yy_func_param` (
  `uuid` varchar(36) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `param` varchar(255) DEFAULT NULL,
  `paramcode` varchar(20) NOT NULL,
  `paramname` varchar(50) NOT NULL,
  `showorder` smallint(6) DEFAULT NULL,
  `func_id` varchar(36) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `FK_a55vff891l7k1bm7nd209jjcg` (`func_id`),
  CONSTRAINT `FK_a55vff891l7k1bm7nd209jjcg` FOREIGN KEY (`func_id`) REFERENCES `yy_func` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_func_param
-- ----------------------------

-- ----------------------------
-- Table structure for yy_imexlate
-- ----------------------------
DROP TABLE IF EXISTS `yy_imexlate`;
CREATE TABLE `yy_imexlate` (
  `uuid` varchar(36) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `child_start_cell_num` int(11) DEFAULT NULL,
  `coding` varchar(255) DEFAULT NULL,
  `export_file_name` varchar(255) DEFAULT NULL,
  `start_cell_num` int(11) DEFAULT NULL,
  `start_row_num` int(11) DEFAULT NULL,
  `template_name` varchar(255) DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  `iscreate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `UK_r57q3qg0nwe8cn35qwk2tfab7` (`coding`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_imexlate
-- ----------------------------
INSERT INTO `yy_imexlate` VALUES ('0000331c-e68c-41b4-8b63-63b115c9f5d1', null, '2018-01-19 17:16:39', null, null, null, null, null, null, '1', null, 'ycExp', '遥测', null, null, '遥测导出模板', '2018-01-18 17:16:39', '1');
INSERT INTO `yy_imexlate` VALUES ('00043483-0c1d-44fc-988b-e2770e3cbcd8', null, '2018-01-20 17:16:39', null, null, null, null, null, null, '1', null, 'ykExp', '遥控', null, null, '遥控导出模板', '2018-01-18 17:16:52', '1');
INSERT INTO `yy_imexlate` VALUES ('000bdbbd-e4c5-4d89-9731-fd978458facc', null, '2018-01-21 17:16:39', null, null, null, null, null, null, '1', null, 'ytExp', '遥调', null, null, '遥调导出模板', '2018-01-18 17:17:14', '1');
INSERT INTO `yy_imexlate` VALUES ('00106dd4-dcd6-4e90-ae54-a0dfed86714e', null, '2018-01-22 17:16:39', null, null, null, null, null, null, '1', null, 'txExp', '特殊遥信', null, null, '特殊遥信导出模板', '2018-01-18 17:18:17', '1');
INSERT INTO `yy_imexlate` VALUES ('001498f8-f94f-49eb-bed3-7a9d7de95bb1', null, '2018-01-23 17:16:39', null, null, null, null, null, null, '1', null, 'tcExp', '特殊遥测', null, null, '特殊遥测导出模板', '2018-01-18 17:18:46', '1');
INSERT INTO `yy_imexlate` VALUES ('a200ed71-8876-4a14-8a02-8f7ffb88ed94', null, '2018-01-24 17:16:39', null, null, null, null, null, null, '1', null, 'tkExp', '特殊遥控', null, null, '特殊遥控导出模板', '2018-01-18 17:18:56', '1');
INSERT INTO `yy_imexlate` VALUES ('a204ec02-b654-4ce6-a5d1-9289e828e58f', null, '2018-01-25 17:16:39', null, null, null, null, null, null, '1', null, 'ttExp', '特殊遥调', null, null, '特殊遥调导出模板', '2018-01-18 17:19:07', '1');
INSERT INTO `yy_imexlate` VALUES ('ec65b161-404a-4abf-ab14-28dfe0f7ca4a', null, '2018-01-18 17:16:39', null, null, null, null, null, null, '1', null, 'yxExp', '遥信', null, null, '遥信导出模板', '2018-01-19 09:45:38', '1');

-- ----------------------------
-- Table structure for yy_imexlate_sub
-- ----------------------------
DROP TABLE IF EXISTS `yy_imexlate_sub`;
CREATE TABLE `yy_imexlate_sub` (
  `uuid` varchar(36) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `chinese_field` varchar(255) DEFAULT NULL,
  `export_cell_num` varchar(255) DEFAULT NULL,
  `field_name` varchar(255) DEFAULT NULL,
  `is_main_field` bit(1) DEFAULT NULL,
  `template_id` varchar(36) DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  `enumdata` varchar(255) DEFAULT NULL,
  `isnotempty` bit(1) DEFAULT NULL,
  `qualified_value` varchar(255) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `FK_63epsgnis79441tpwjc1fvuww` (`template_id`),
  CONSTRAINT `FK_63epsgnis79441tpwjc1fvuww` FOREIGN KEY (`template_id`) REFERENCES `yy_imexlate` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_imexlate_sub
-- ----------------------------
INSERT INTO `yy_imexlate_sub` VALUES ('00003d41-8584-4862-ad49-d41da5a1550a', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '描述', 'B', 'bdesc', '\0', '0000331c-e68c-41b4-8b63-63b115c9f5d1', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('000047df-e15c-482e-9471-def2e0614218', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '类型', 'C', 'btype', '\0', '0000331c-e68c-41b4-8b63-63b115c9f5d1', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('00030f34-8cb4-493d-bf93-b3c9575eaac9', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '点号', 'A', 'pointno', '\0', '0000331c-e68c-41b4-8b63-63b115c9f5d1', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('0005802a-dd75-44ec-8171-ea0632cf5707', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '描述', 'B', 'bdesc', '\0', '00043483-0c1d-44fc-988b-e2770e3cbcd8', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('000a14ba-8ebd-449b-985f-2ba97c93c99e', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '类型', 'C', 'btype', '\0', '00043483-0c1d-44fc-988b-e2770e3cbcd8', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('000bd2e5-deab-4ed0-8749-6e1b26acc9d2', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '点号', 'A', 'pointno', '\0', '00043483-0c1d-44fc-988b-e2770e3cbcd8', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('000cab67-47c3-4da4-b666-f9732a58c6b5', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '描述', 'B', 'bdesc', '\0', '000bdbbd-e4c5-4d89-9731-fd978458facc', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('000db2a6-0bb4-42d8-9ef3-92354899bec6', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '类型', 'C', 'btype', '\0', '000bdbbd-e4c5-4d89-9731-fd978458facc', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('000fcb51-0cde-410f-aa96-84b2f5ef82b8', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '点号', 'A', 'pointno', '\0', '000bdbbd-e4c5-4d89-9731-fd978458facc', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('0010d312-cf53-419c-b4c4-50addf861c4c', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '描述', 'B', 'bdesc', '\0', '00106dd4-dcd6-4e90-ae54-a0dfed86714e', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('0013c2f0-31b5-4232-b555-0116380e8e82', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '类型', 'C', 'btype', '\0', '00106dd4-dcd6-4e90-ae54-a0dfed86714e', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('0013c61e-7e70-468f-80db-8467bd771739', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '点号', 'A', 'pointno', '\0', '00106dd4-dcd6-4e90-ae54-a0dfed86714e', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('0014a5b7-887a-4ddb-8f30-eb1d108703f1', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '描述', 'B', 'bdesc', '\0', '001498f8-f94f-49eb-bed3-7a9d7de95bb1', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('0014f369-6a52-41cf-8f51-7a4f5ff29333', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '类型', 'C', 'btype', '\0', '001498f8-f94f-49eb-bed3-7a9d7de95bb1', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('00166e57-689f-4d4a-ae4e-41431ba999f3', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '点号', 'A', 'pointno', '\0', '001498f8-f94f-49eb-bed3-7a9d7de95bb1', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('7cdc4992-151f-4351-be64-f3c5b6847b95', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '描述', 'B', 'bdesc', '\0', 'ec65b161-404a-4abf-ab14-28dfe0f7ca4a', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('a2026fc4-16ee-4278-b5ba-80d2a953f0a3', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '描述', 'B', 'bdesc', '\0', 'a200ed71-8876-4a14-8a02-8f7ffb88ed94', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('a20459d5-d83e-4b67-b91a-60204266862f', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '类型', 'C', 'btype', '\0', 'a200ed71-8876-4a14-8a02-8f7ffb88ed94', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('a2047107-9ca4-41e1-b0d7-20a8050aefc5', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '点号', 'A', 'pointno', '\0', 'a200ed71-8876-4a14-8a02-8f7ffb88ed94', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('a2053bdf-c5fb-451d-82a3-fe30cc6ac552', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '描述', 'B', 'bdesc', '\0', 'a204ec02-b654-4ce6-a5d1-9289e828e58f', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('a2099a21-f80c-4890-b06a-64ca3174b412', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '类型', 'C', 'btype', '\0', 'a204ec02-b654-4ce6-a5d1-9289e828e58f', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('a20a0f41-738d-4f80-89d2-ca4bad384cb3', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '点号', 'A', 'pointno', '\0', 'a204ec02-b654-4ce6-a5d1-9289e828e58f', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('dbfcfa69-85db-4e18-ab95-7076ac10982c', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '类型', 'C', 'btype', '\0', 'ec65b161-404a-4abf-ab14-28dfe0f7ca4a', '2018-01-17 22:29:33', null, '\0', null, null);
INSERT INTO `yy_imexlate_sub` VALUES ('f1128860-e618-412d-a072-2fd3048a53fb', null, '2018-01-17 22:29:33', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '点号', 'A', 'pointno', '\0', 'ec65b161-404a-4abf-ab14-28dfe0f7ca4a', '2018-01-17 22:29:33', null, '\0', null, null);

-- ----------------------------
-- Table structure for yy_log
-- ----------------------------
DROP TABLE IF EXISTS `yy_log`;
CREATE TABLE `yy_log` (
  `uuid` varchar(36) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `contents` varchar(2000) DEFAULT NULL,
  `exdetail` varchar(2000) DEFAULT NULL,
  `func` varchar(256) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `method` varchar(200) DEFAULT NULL,
  `params` varchar(1000) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `useragent` varchar(200) DEFAULT NULL,
  `userid` varchar(36) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_log
-- ----------------------------

-- ----------------------------
-- Table structure for yy_log_login
-- ----------------------------
DROP TABLE IF EXISTS `yy_log_login`;
CREATE TABLE `yy_log_login` (
  `uuid` varchar(36) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `deptid` varchar(50) DEFAULT NULL,
  `is_suc` varchar(2) DEFAULT NULL,
  `is_valid` varchar(2) DEFAULT NULL,
  `loginname` varchar(50) DEFAULT NULL,
  `orgid` varchar(50) DEFAULT NULL,
  `personid` varchar(50) DEFAULT NULL,
  `request_ip` varchar(50) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_log_login
-- ----------------------------
INSERT INTO `yy_log_login` VALUES ('04f31703-cb43-417d-ad0e-7d9e2d025b30', '2018-07-30 16:40:02', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-30 16:40:02', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('0a9ebee7-6987-4bab-bb23-0d68e010efaf', '2018-09-08 17:09:29', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:09:29', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('0b96d6f1-053d-4954-aa6f-8e40de77045f', '2018-07-31 10:17:11', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:17:11', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('138606a2-a542-42ee-8ceb-b869b2da1ed4', '2018-09-08 17:23:46', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:23:46', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('18006584-95e0-405f-afd1-10c9af45b7fd', '2018-09-07 09:53:55', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-07 09:53:55', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('19425b73-0929-4a86-a6c7-81dde6339d04', '2018-09-08 17:41:19', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:41:19', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('1b791086-0619-4df5-8e1c-67139b0d7bcd', '2019-06-08 23:11:39', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2019-06-08 23:11:39', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('22838f41-ea77-4729-bd51-f2e6f5b65250', '2018-09-08 17:26:53', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:26:53', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('228eaaa5-a9cf-4f22-bfa2-1aa19808e634', '2018-09-08 17:24:42', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:24:42', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('233957d5-3f5c-41f1-93c7-f6c4e5cbacd1', '2018-09-08 17:04:55', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:04:55', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('2672c3cd-46f6-453d-b473-d7bacb5d3b06', '2018-09-07 10:11:21', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-07 10:11:21', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('2f035e2c-67a5-4a8f-a70d-420af051c523', '2018-07-31 13:42:00', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-07-31 13:42:00', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('2f18f01b-b0ee-4d19-975e-84b631eab0cb', '2019-06-09 21:21:52', null, null, null, null, null, '1', '2019-06-09 21:21:52', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', null, 'lius');
INSERT INTO `yy_log_login` VALUES ('2fa1840f-958d-4572-b237-5057e84ef522', '2018-09-07 12:46:00', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-07 12:46:00', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('400f2890-b98e-4567-abdf-159d2938ce7d', '2019-06-09 21:53:30', null, null, null, null, null, '1', '2019-06-09 21:53:30', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('402db3cc-6e49-4766-9dec-af87ad748afc', '2018-09-08 17:05:51', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:05:51', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('4193f244-ac4e-4816-b61d-44cfe5cfa728', '2018-09-08 17:04:04', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:04:04', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('42690132-2662-4628-93d5-da6e2e48cb72', '2018-09-04 17:22:43', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-04 17:22:43', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('43067e9b-9e5f-4055-a742-4bb972176f63', '2018-07-30 23:35:20', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-07-30 23:35:20', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('461de1b2-5e74-438f-a04b-7aa0d69d0e25', '2018-09-08 17:17:23', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:17:23', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('4c8cfeb5-fb94-43b2-8c0e-ffbbaad29c6e', '2019-06-09 21:20:56', null, null, null, null, null, '1', '2019-06-09 21:20:56', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('544c8270-f411-44af-9946-97167917b371', '2018-07-30 16:15:42', null, null, null, null, null, '1', '2018-07-30 16:15:42', null, '0', '0', null, null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('56941bee-bbe0-48a5-84f6-579b1e361202', '2019-06-09 21:52:34', null, null, null, null, null, '1', '2019-06-09 21:52:34', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('5831a58b-1dac-41ec-9cd2-f80d750225f2', '2018-09-08 12:33:58', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 12:33:58', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('58cbb7a1-c946-4dac-a153-f1d822f713d8', '2019-06-09 21:21:05', null, null, null, null, null, '1', '2019-06-09 21:21:05', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('594d4085-3f53-4600-b846-71581844e263', '2018-07-31 13:42:15', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-07-31 13:42:15', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('5e9a1eaf-ea57-4b37-b3cf-080db6b6b7d8', '2018-08-14 22:34:39', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-08-14 22:34:39', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('66799f4f-3109-40a3-bf37-43f34131006c', '2018-07-30 23:22:03', null, null, null, null, null, '1', '2018-07-30 23:22:03', null, '0', '0', null, null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75 Safari/537.36', null, 'shiao');
INSERT INTO `yy_log_login` VALUES ('69470b28-e4b7-4ab7-b001-dbbf84938341', '2019-06-09 21:55:09', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2019-06-09 21:55:09', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('6aa9eda3-e8bb-4feb-8bed-217259df9d00', '2018-09-08 17:06:57', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:06:57', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('6b14a44e-0c6e-44bf-9bd3-14792e5f31d3', '2018-09-08 17:33:32', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:33:32', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('74da86c9-76cc-4c24-8195-be3c9f1ec701', '2018-09-08 17:03:42', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:03:42', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('7ea7b5d4-764f-410d-9f71-db0aa9bb7834', '2018-07-30 17:51:31', null, null, null, null, null, '1', '2018-07-30 17:51:31', null, '0', '0', null, null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('84c61ff4-3464-4eaa-b357-119780d40a88', '2019-06-08 22:52:34', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2019-06-08 22:52:34', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('8570e38f-507b-4552-8010-e859458daddb', '2018-07-31 10:24:03', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:24:03', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('8c07ef4c-1549-48ce-a23e-2c24ea05c1e2', '2018-07-30 16:51:13', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-30 16:51:13', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('8ee775c6-339b-4704-a8d5-16f68295197f', '2018-07-30 23:35:34', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-07-30 23:35:34', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('8f2d8412-032a-4d34-af64-4d2d0204f5b0', '2018-08-01 20:08:15', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-08-01 20:08:15', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.75 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('8f39480b-6806-4fe7-a1db-1ef2dafc041f', '2018-09-08 17:09:54', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:09:54', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('91f4e991-0a0a-4981-9310-d503f21178ac', '2018-09-07 12:43:23', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-07 12:43:23', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('926b781d-6d28-4446-a47c-874eadca70b2', '2018-09-07 09:53:34', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-07 09:53:34', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('955382f7-dff6-4a22-b180-57db2fcc649f', '2018-07-31 10:20:22', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:20:22', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('9787449a-7683-4899-9858-78f419ccef40', '2018-07-31 10:25:01', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:25:01', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('99e0f5ec-bbcb-4ec9-bdc3-8507819bdd67', '2018-07-30 18:03:01', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-30 18:03:01', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('9c34c8fd-734e-4680-bc1d-28a1559eb539', '2018-09-08 17:15:16', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:15:16', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('a2e9c98e-5861-4688-9749-a501982fd6b4', '2018-07-31 10:22:03', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:22:03', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('a74fe773-7549-4da2-add8-8a27a8ba3748', '2018-07-31 10:23:05', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:23:05', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('a9dec93e-1735-4986-a3f6-5ce831c0b23a', '2018-09-08 17:36:10', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:36:10', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('af4c5611-5b7e-49f7-b76b-9991674a642a', '2018-08-06 15:54:10', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-08-06 15:54:10', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('affa2841-bf02-4ebf-9b6d-47d0f79e40e4', '2018-07-31 10:22:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:22:30', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('b1563d8b-3fdd-4673-9909-663d594107e1', '2018-07-31 10:18:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:18:30', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('b4f39f0b-7187-4a25-a6ff-def34133a928', '2018-08-06 15:53:57', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-08-06 15:53:57', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('b8281059-4294-4ceb-ab68-db11c27c0d5a', '2019-06-08 16:52:57', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2019-06-08 16:52:57', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('b950cb86-c7e3-4545-9c54-fe7320fe21c9', '2019-06-08 23:11:48', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2019-06-08 23:11:48', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('bb5f261e-a60a-4501-a3ba-8192dbe2328c', '2018-09-07 10:15:32', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-07 10:15:32', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('bdaddace-4fd2-461d-8f4f-9c650b3abb60', '2018-09-07 12:22:23', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-07 12:22:23', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('c55cd0da-4bbe-4257-a23d-ae2214d17212', '2018-09-04 17:07:49', null, null, null, null, null, '1', '2018-09-04 17:07:49', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', null, 'shiao');
INSERT INTO `yy_log_login` VALUES ('c68f8010-2ae6-4884-9be4-6eafed61fe2d', '2019-06-08 23:15:37', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2019-06-08 23:15:37', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('c90e2cae-0a9f-477b-82da-3ab08d1aebd3', '2018-09-07 12:30:46', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-07 12:30:46', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('c99ae13a-c1bd-4ac1-91e9-83be4d351d18', '2019-06-09 21:53:39', null, null, null, null, null, '1', '2019-06-09 21:53:39', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('d11811c4-3d19-4828-9e02-a844617b5f36', '2018-09-08 17:18:58', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:18:58', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('d27c1fb2-6c40-4f98-980b-44c7613a7725', '2018-09-08 12:46:03', null, null, null, null, null, '1', '2018-09-08 12:46:03', null, '0', '0', null, null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', null, 'shiao');
INSERT INTO `yy_log_login` VALUES ('d438a832-8c05-4505-bc1a-1782468ee1a2', '2019-06-09 21:20:39', null, null, null, null, null, '1', '2019-06-09 21:20:39', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', null, 'shiao');
INSERT INTO `yy_log_login` VALUES ('d83211a8-5c62-4ed0-99e3-ea01f6a5a761', '2018-07-31 10:11:46', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:11:46', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('d8c59923-12ff-4ab2-a720-229d3f110dfc', '2018-07-31 10:35:05', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 10:35:05', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('d923a15a-927b-44b3-8fa5-cf7535255cd5', '2018-09-08 17:40:33', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:40:33', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('dc59ccaf-b98a-4d2c-936b-fa9b95d833bb', '2018-09-08 17:39:46', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:39:46', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('dd8a2973-a811-42cd-aa9f-ac272d57fcf0', '2019-06-08 22:50:16', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2019-06-08 22:50:16', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('e1f4fbbb-9b23-4bb6-a546-ac71fabd7dd4', '2019-06-09 21:54:46', null, null, null, null, null, '1', '2019-06-09 21:54:46', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('e677b40a-92c5-42e7-8eed-ca2dc3c83ad7', '2018-07-31 09:14:30', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-07-31 09:14:30', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('ead7a694-54f9-4342-804e-cfd8e8f098d2', '2019-06-09 21:54:01', null, null, null, null, null, '1', '2019-06-09 21:54:01', null, '0', '0', null, null, null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('eaf215d0-6b00-4e42-abf6-aebd51288795', '2018-09-07 12:29:05', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-07 12:29:05', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('ec86ddc0-252a-4a8e-b1ce-6162bef8a022', '2018-07-30 16:15:38', null, null, null, null, null, '1', '2018-07-30 16:15:38', null, '0', '0', null, null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', null, '1');
INSERT INTO `yy_log_login` VALUES ('ececd4d6-7aec-4d62-925d-3cdf13220204', '2019-06-08 23:15:48', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2019-06-08 23:15:48', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('ed829b54-6823-4440-8d79-6a41a8e3852f', '2018-09-08 17:37:35', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-09-08 17:37:35', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('effda4a2-6a33-4125-bb20-271134357e85', '2018-07-31 09:26:51', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, '1', '2018-07-31 09:26:51', '', '1', '1', '1', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员');
INSERT INTO `yy_log_login` VALUES ('f00131e8-8aa8-48a6-9718-9b21e1062ef5', '2018-07-30 16:40:36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-07-30 16:40:36', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('f1577de0-92c2-465b-82d3-60c68e118dfa', '2018-09-08 12:44:38', null, null, null, null, null, '1', '2018-09-08 12:44:38', null, '0', '0', null, null, null, '0:0:0:0:0:0:0:1', 'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36', null, 'shiao');
INSERT INTO `yy_log_login` VALUES ('f5791691-ca4b-4698-9069-94791eae7cf6', '2018-07-31 10:46:37', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2018-07-31 10:46:37', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');
INSERT INTO `yy_log_login` VALUES ('f89f5d6a-1d1a-4988-9129-0b9b9794304d', '2019-06-08 22:52:38', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao', null, null, null, '1', '2019-06-08 22:52:38', null, '1', '1', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36', '46f15957-48e5-44ad-9df9-9de9ef935411', 'shiao');

-- ----------------------------
-- Table structure for yy_message
-- ----------------------------
DROP TABLE IF EXISTS `yy_message`;
CREATE TABLE `yy_message` (
  `uuid` varchar(36) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `billid` varchar(255) DEFAULT NULL,
  `billtype` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `dealresult` varchar(255) DEFAULT NULL,
  `dealtime` datetime DEFAULT NULL,
  `flowid` varchar(255) DEFAULT NULL,
  `flowname` varchar(255) DEFAULT NULL,
  `isdeal` varchar(255) DEFAULT NULL,
  `isnew` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `msgtype` varchar(255) DEFAULT NULL,
  `open_type` varchar(2) DEFAULT NULL,
  `receiver` varchar(255) DEFAULT NULL,
  `receivername` varchar(255) DEFAULT NULL,
  `receivetime` datetime DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `sendername` varchar(255) DEFAULT NULL,
  `sendtime` datetime DEFAULT NULL,
  `suggestion` varchar(2000) DEFAULT NULL,
  `tab_data_index` varchar(50) DEFAULT NULL,
  `tab_name` varchar(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `orgid` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_message
-- ----------------------------
INSERT INTO `yy_message` VALUES ('0027cd3d-8693-42ee-89f1-f67552849ed9', null, '2018-06-27 14:35:07', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '2018-06-27 14:35:31', '690b4e93-9325-401b-914d-502086e2e9df', 'VersionInfoLog', '超级系统管理员 提交', '超级系统管理员已核查', '2018-06-27 14:35:31', null, null, '1', '0', '/ver/slaveapprove/slaveCheckList?approveType=0', '2', '1', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-27 14:35:07', null, '33055f27-c0ee-406c-afc4-36285820c7a0', '信息点表核查（子站）', '版本审核日志', '33d8de74-e242-4536-bfdc-3312703f62b1');
INSERT INTO `yy_message` VALUES ('1513a863-d20c-474f-b6ce-e18f1e2bd208', null, '2018-06-28 11:21:26', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '2018-06-28 11:21:26', '7c14f915-8e24-42bd-8f71-20d63ebd1f56', 'VersionInfoLog', '超级系统管理员 提交', null, null, null, null, '0', '0', '/ver/slaveapprove/slaveCheckList?approveType=1', '2', '1', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-28 11:21:26', null, 'bd6bd436-e256-4c96-9828-80ebbc2f5bad', '信息点表核查', '版本审核日志', '33d8de74-e242-4536-bfdc-3312703f62b1');
INSERT INTO `yy_message` VALUES ('1f30f96c-0db8-4154-a50c-b15003bcdc17', null, '2018-06-27 14:35:31', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '2018-06-27 14:35:31', '690b4e93-9325-401b-914d-502086e2e9df', 'VersionInfoLog', '超级系统管理员 核查通过', null, null, null, null, '0', '0', '/ver/slaveapprove/slaveCheckList', '2', '1', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-27 14:35:31', null, 'cf8f95ac-e41c-4365-8491-8922d6c1e54e', '信息点表审批（子站）', '版本审核日志', '33d8de74-e242-4536-bfdc-3312703f62b1');
INSERT INTO `yy_message` VALUES ('22482937-1fa9-4afe-92cb-d0a33ea35602', null, '2018-06-22 17:09:11', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '2018-06-22 17:09:16', '1', '2018-06-22 17:09:27', 'e62aa959-328e-48b2-8321-4e7de8385ad0', 'VersionInfoLog', '超级系统管理员 提交', '超级系统管理员已审批', '2018-06-22 17:09:27', null, null, '1', '1', '/ver/slaveapprove/slaveCheckList?approveType=1', '2', '1', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-22 17:09:11', null, 'cda9387b-6b85-4325-bd93-190543a449b9', '信息点表核查', '版本审核日志', '2930ead5-cbc2-4140-abec-bb90c2e9bcfb');
INSERT INTO `yy_message` VALUES ('38ff78ac-51d7-4ed7-92cc-af29bc2718ed', null, '2018-06-27 14:34:31', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '2018-06-27 14:35:31', '690b4e93-9325-401b-914d-502086e2e9df', 'VersionInfoLog', '超级系统管理员 退回:555', '超级系统管理员已核查', '2018-06-27 14:35:31', null, null, '1', '0', null, '2', '0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-27 14:34:31', null, null, null, '版本审核日志', '33d8de74-e242-4536-bfdc-3312703f62b1');
INSERT INTO `yy_message` VALUES ('6d1fc6a9-8416-4eab-afda-e54c1d62dff6', null, '2018-06-22 17:03:27', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '2018-06-22 17:04:57', '1', '2018-06-22 17:09:27', 'e62aa959-328e-48b2-8321-4e7de8385ad0', 'VersionInfoLog', '超级系统管理员 提交', '超级系统管理员已审批', '2018-06-22 17:09:27', null, null, '1', '1', '/ver/slaveapprove/slaveCheckList?approveType=1', '2', '1', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-22 17:03:27', null, 'bd6bd436-e256-4c96-9828-80ebbc2f5bad', '信息点表核查', '版本审核日志', '2930ead5-cbc2-4140-abec-bb90c2e9bcfb');
INSERT INTO `yy_message` VALUES ('78c28ef9-79bd-4dd8-af8b-2a2dd7e0a19a', null, '2018-06-22 17:59:25', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '2018-06-22 21:03:30', '1', '2018-06-22 21:03:30', '3296871d-1e77-4072-bbea-51adb8c93c85', 'VersionInfoLog', '超级系统管理员 提交', null, null, null, null, '0', '1', '/ver/slaveapprove/slaveCheckList?approveType=1', '2', '1', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-22 17:59:25', null, 'bd6bd436-e256-4c96-9828-80ebbc2f5bad', '信息点表核查', '版本审核日志', '2930ead5-cbc2-4140-abec-bb90c2e9bcfb');
INSERT INTO `yy_message` VALUES ('ac99a978-8d4d-4cd2-a3ee-609a679cd7bc', null, '2018-06-27 14:35:49', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '2018-06-27 14:35:49', '690b4e93-9325-401b-914d-502086e2e9df', 'VersionInfoLog', '超级系统管理员 退回:555555555', null, null, null, null, '0', '0', null, '2', '0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-27 14:35:49', null, null, null, '版本审核日志', '33d8de74-e242-4536-bfdc-3312703f62b1');
INSERT INTO `yy_message` VALUES ('ad3457f4-a7db-4829-ad09-368796a604d7', null, '2018-06-22 17:06:21', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '2018-06-22 17:07:11', '1', '2018-06-22 17:09:27', 'e62aa959-328e-48b2-8321-4e7de8385ad0', 'VersionInfoLog', '超级系统管理员 提交', '超级系统管理员已审批', '2018-06-22 17:09:27', null, null, '1', '1', '/ver/slaveapprove/slaveCheckList?approveType=1', '2', '1', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-22 17:06:21', null, 'cda9387b-6b85-4325-bd93-190543a449b9', '信息点表核查', '版本审核日志', '2930ead5-cbc2-4140-abec-bb90c2e9bcfb');
INSERT INTO `yy_message` VALUES ('b70cd817-381c-4305-9ba9-2bfe3c9013d5', null, '2018-06-27 14:35:31', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '2018-06-27 14:35:31', '690b4e93-9325-401b-914d-502086e2e9df', 'VersionInfoLog', '超级系统管理员 核查通过', null, null, null, null, '0', '0', '/ver/slaveapprove/slaveCheckList', '2', '1', '419027c7-548a-488f-9dbd-4dfadea7f214', 'test3', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-27 14:35:31', null, 'cf8f95ac-e41c-4365-8491-8922d6c1e54e', '信息点表审批（子站）', '版本审核日志', '33d8de74-e242-4536-bfdc-3312703f62b1');
INSERT INTO `yy_message` VALUES ('b8f4ddb6-f12a-4269-a5c9-74eda04af432', null, '2018-06-27 14:35:31', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '2018-06-27 14:35:31', '690b4e93-9325-401b-914d-502086e2e9df', 'VersionInfoLog', '超级系统管理员 核查通过', null, null, null, null, '0', '0', '/ver/slaveapprove/slaveCheckList', '2', '1', 'a785f137-9de2-41b7-aa33-2f1708f5a851', '系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-27 14:35:31', null, 'cf8f95ac-e41c-4365-8491-8922d6c1e54e', '信息点表审批（子站）', '版本审核日志', '33d8de74-e242-4536-bfdc-3312703f62b1');
INSERT INTO `yy_message` VALUES ('cd887804-9a38-4368-a2c6-b0c912097fab', null, '2018-06-22 17:08:37', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '2018-06-22 17:08:44', '1', '2018-06-22 17:09:27', 'e62aa959-328e-48b2-8321-4e7de8385ad0', 'VersionInfoLog', '超级系统管理员 提交', '超级系统管理员已审批', '2018-06-22 17:09:27', null, null, '1', '1', '/ver/slaveapprove/slaveCheckList?approveType=1', '2', '1', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-22 17:08:37', null, 'cda9387b-6b85-4325-bd93-190543a449b9', '信息点表核查', '版本审核日志', '2930ead5-cbc2-4140-abec-bb90c2e9bcfb');
INSERT INTO `yy_message` VALUES ('ef3453a6-b05d-434e-84d9-2dad80311216', null, '2018-06-28 11:21:26', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, null, null, null, '1', '2018-06-28 11:21:26', '7c14f915-8e24-42bd-8f71-20d63ebd1f56', 'VersionInfoLog', '超级系统管理员 添加', null, null, null, null, '1', '1', null, '2', '0', null, null, null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-28 11:21:26', null, null, null, '版本审核日志', '33d8de74-e242-4536-bfdc-3312703f62b1');
INSERT INTO `yy_message` VALUES ('fc5dc025-4808-453b-95e0-f071d762eb2f', null, '2018-06-22 17:08:54', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '2018-06-22 17:09:00', '1', '2018-06-22 17:09:27', 'e62aa959-328e-48b2-8321-4e7de8385ad0', 'VersionInfoLog', '超级系统管理员 提交', '超级系统管理员已审批', '2018-06-22 17:09:27', null, null, '1', '1', '/ver/slaveapprove/slaveCheckList?approveType=1', '2', '1', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', '2018-06-22 17:08:54', null, 'cda9387b-6b85-4325-bd93-190543a449b9', '信息点表核查', '版本审核日志', '2930ead5-cbc2-4140-abec-bb90c2e9bcfb');

-- ----------------------------
-- Table structure for yy_notice
-- ----------------------------
DROP TABLE IF EXISTS `yy_notice`;
CREATE TABLE `yy_notice` (
  `uuid` varchar(36) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `issue_date` varchar(255) DEFAULT NULL,
  `notice_category` varchar(50) DEFAULT NULL,
  `notice_content` longtext,
  `notice_status` varchar(50) DEFAULT NULL,
  `notice_title` varchar(200) DEFAULT NULL,
  `notice_type` varchar(2) DEFAULT NULL,
  `publisher` varchar(50) DEFAULT NULL,
  `system_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_notice
-- ----------------------------

-- ----------------------------
-- Table structure for yy_org
-- ----------------------------
DROP TABLE IF EXISTS `yy_org`;
CREATE TABLE `yy_org` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `create_ts` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_ts` datetime DEFAULT NULL,
  `nodepath` varchar(500) DEFAULT NULL,
  `active` varchar(255) DEFAULT NULL,
  `created_date` varchar(255) DEFAULT NULL,
  `creater` varchar(50) DEFAULT NULL,
  `islast` bit(1) DEFAULT NULL,
  `org_code` varchar(20) NOT NULL,
  `org_name` varchar(100) NOT NULL,
  `parentid` varchar(100) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `orgtype` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  `orglevel` varchar(255) DEFAULT NULL,
  `sketch` varchar(250) DEFAULT NULL,
  `sketch_url` varchar(250) DEFAULT NULL,
  `org_index` varchar(50) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `UK_6t0ok0gaej3mj5hew18x0x75u` (`org_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_org
-- ----------------------------
INSERT INTO `yy_org` VALUES ('200fad77-9a81-4842-bf34-0411141def0c', '1', '2015-12-17 11:26:48', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2015-12-25 13:31:35', '200fad77-9a81-4842-bf34-0411141def0c', '1', '2017-03-14', '', '\0', 'jlbc', '总机构', '', null, '2017-11-16 09:35:44', null, null, '系统管理员', '2016-11-26 09:35:44', '1', '', '2017-12-29 16:54:46', '10', null, null, '');
INSERT INTO `yy_org` VALUES ('2930ead5-cbc2-4140-abec-bb90c2e9bcfb', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '200fad77-9a81-4842-bf34-0411141def0c,2930ead5-cbc2-4140-abec-bb90c2e9bcfb', '1', null, null, '\0', '500', '机构A', '200fad77-9a81-4842-bf34-0411141def0c', null, null, '2018-01-23 17:56:54', '超级系统管理员', '超级系统管理员', '2018-07-19 23:46:43', '1', '', '2018-07-19 23:46:43', null, null, null, '500');
INSERT INTO `yy_org` VALUES ('3b1a3986-50df-42ea-90a7-3b91f238c7dd', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '200fad77-9a81-4842-bf34-0411141def0c,3b1a3986-50df-42ea-90a7-3b91f238c7dd', '1', null, null, '', 'bcb', '机构B', '200fad77-9a81-4842-bf34-0411141def0c', null, null, '2018-01-15 22:59:04', '超级系统管理员', '超级系统管理员', '2018-07-31 10:35:19', '2', '', '2018-07-31 10:35:19', null, null, null, '5');
INSERT INTO `yy_org` VALUES ('cfab33c1-f59e-4ae2-aafb-03c3890fa421', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '200fad77-9a81-4842-bf34-0411141def0c,2930ead5-cbc2-4140-abec-bb90c2e9bcfb,cfab33c1-f59e-4ae2-aafb-03c3890fa421', '1', null, null, '', 'wgweg', '机构名称111', '2930ead5-cbc2-4140-abec-bb90c2e9bcfb', null, null, '2018-06-27 19:17:16', '超级系统管理员', null, null, '', '', '2018-06-27 19:17:16', null, null, null, '3423');

-- ----------------------------
-- Table structure for yy_parameter
-- ----------------------------
DROP TABLE IF EXISTS `yy_parameter`;
CREATE TABLE `yy_parameter` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) NOT NULL,
  `defaultvalue` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `groudcode` varchar(255) DEFAULT NULL,
  `isshow` bit(1) DEFAULT NULL,
  `paramtercode` varchar(50) NOT NULL,
  `paramtername` varchar(200) NOT NULL,
  `paramtertype` varchar(255) DEFAULT NULL,
  `paramtervalue` varchar(255) DEFAULT NULL,
  `showorder` smallint(6) DEFAULT NULL,
  `sys` bit(1) DEFAULT NULL,
  `valuerange` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `ispreset` varchar(2) DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `UK_q4419n0fnuy0m89mkibtuje0p` (`paramtercode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_parameter
-- ----------------------------
INSERT INTO `yy_parameter` VALUES ('183cd862-ae78-443e-918b-2e1e9566fd5c', '1', null, '', 'sys', '', 'ExportMaxCount', '导出excel最大条数', '', '20000', null, '\0', '', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2017-06-07 18:57:27', '系统管理员', null, null, '0', '2017-06-07 18:57:27');
INSERT INTO `yy_parameter` VALUES ('29b6498a-99bc-454f-a555-41d336387684', '1', null, null, 'sys', '', 'file_save_type', '附件管理模式', '', 'LOCAL', null, '\0', '', '2016-03-22 03:00:22', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2016-03-22 03:00:22', '系统管理员', null, null, null, null);
INSERT INTO `yy_parameter` VALUES ('2cb57a22-6b04-4f36-88b2-f75a9bb9db4e', '1', null, '', 'sys', '', 'DEFAULT_PWD', '用户的默认密码', '123456', '123456', null, '\0', '', '2016-03-04 17:31:40', 'd4859015-7452-4139-888e-8320a5d04f90', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-04-17 01:19:12', '2016-03-04 17:31:40', '管理员', '系统管理员', '2016-04-17 01:19:12', null, null);
INSERT INTO `yy_parameter` VALUES ('3a67c950-f134-4b53-8037-c602dad753a1', '1', null, '', 'sys', '', 'attachment_path', '附件存放路径', '', 'D:\\\\lsinstall\\\\apache-tomcat-8.0.33-jlbc\\\\webapps\\\\wtpwebapps\\\\', null, '\0', '', '2016-03-22 02:57:34', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '46f15957-48e5-44ad-9df9-9de9ef935411', null, '2016-03-22 02:57:34', '系统管理员', 'shiao', '2018-08-07 10:37:48', null, '2018-08-07 10:37:48');
INSERT INTO `yy_parameter` VALUES ('6d29143c-ab1a-4a71-9c25-6368ec51e265', '1', null, '', 'sys', '', 'yy_logo_imge', '系统logo图片位置', '图片', '/assets/yy/img/logn1.jpg', null, '\0', '', '2016-02-01 22:52:20', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '46f15957-48e5-44ad-9df9-9de9ef935411', '2016-02-01 23:27:57', null, '系统管理员', 'shiao', '2018-09-04 17:25:10', null, '2018-09-04 17:25:10');
INSERT INTO `yy_parameter` VALUES ('6ff558f4-2650-4e3b-aee3-af584f250f86', '1', null, '', 'sys', '', 'yy_logo_title', 'logo标题', '', '信息管理系统', null, '\0', '', '2016-02-01 22:53:43', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-11-29 15:49:10', null, '系统管理员', '超级系统管理员', '2018-05-21 19:20:39', null, '2018-05-21 19:20:39');
INSERT INTO `yy_parameter` VALUES ('7e1b4c73-00d4-46fd-a030-4782eb70936b', '1', null, '', 'sys', '', 'yy_footer_title', 'foot显示文字', '', '2018 © 信息管控管理系统 by ls2008', null, '\0', '', null, null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-09-21 17:08:57', null, null, '超级系统管理员', '2018-05-21 19:20:54', null, '2018-05-21 19:20:54');
INSERT INTO `yy_parameter` VALUES ('a0beb046-5922-484b-8a39-3241e4d2f741', '1', null, 'http://app.weishiao.com:8080/qjb\nhttp://120.79.187.231:8080/qjb', 'sys', '', 'apiurl', '地址', '', 'http://120.79.187.231:8080/qjb', null, '\0', '', null, '46f15957-48e5-44ad-9df9-9de9ef935411', 'e9b18937-e476-4961-9be2-74f29a7472a0', null, '2018-08-31 21:48:16', 'shiao', 'yrgly', '2018-10-14 11:54:50', '0', '2018-10-14 11:54:50');
INSERT INTO `yy_parameter` VALUES ('abe4cdf3-1f0d-4a60-9053-01fbe50961e5', '1', null, '', 'sys', '', 'yy_excel', '导出导入EXCEL文件暂放地址', '', '/exceltemplate/excel', null, '\0', '', '2016-04-24 14:54:03', 'd4859015-7452-4139-888e-8320a5d04f90', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-04-24 14:54:03', '管理员', '超级系统管理员', '2017-12-29 15:41:21', '0', '2017-12-29 15:41:21');
INSERT INTO `yy_parameter` VALUES ('c7bd1e44-a92c-4cd8-8b77-a62d2f32b3bc', '1', null, 'C:\\\\cpp\\\\apache-tomcat-7.0.68\\\\webapps\\\\ROOT\\\\upfile\\\\\nC:\\\\cpp\\\\apache-tomcat-7.0.68\\\\webapps\\\\ROOT\\\\upfile\\\\', 'sys', '', 'UploadFilePath', '附件上传的路径', '', 'D:\\\\lsinstall\\\\apache-tomcat-8.0.33-jlbc\\\\webapps\\\\wtpwebapps\\\\', null, '\0', '', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '46f15957-48e5-44ad-9df9-9de9ef935411', null, '2017-06-13 12:34:21', '系统管理员', 'shiao', '2018-08-07 10:38:49', '0', '2018-08-07 10:38:49');
INSERT INTO `yy_parameter` VALUES ('cc4b3b46-039b-4311-bdc7-786ad4eeabab', '1', null, 'http://app.weishiao.com:8080/localserv/uploadFiles\nhttp://120.79.187.231:8080/localserv/uploadFiles', 'sys', '', 'apiuploadUrl', '附件上传地址', '', 'http://120.79.187.231:8080/localserv/uploadFiles', null, '\0', '', null, '46f15957-48e5-44ad-9df9-9de9ef935411', 'e9b18937-e476-4961-9be2-74f29a7472a0', null, '2018-08-07 15:52:33', 'shiao', 'yrgly', '2018-10-14 11:54:31', '0', '2018-10-14 11:54:31');
INSERT INTO `yy_parameter` VALUES ('e04e12f8-1c12-4fa5-a302-b62598b62f45', '1', null, '系统首先显示的名称，标题名称', 'sys', '', 'yy_title', '系统首页显示名称', '', '管理系统', null, '\0', '', '2016-04-14 17:20:35', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2016-11-29 15:49:20', '2016-04-14 17:20:35', '系统管理员', '超级系统管理员', '2018-05-21 19:20:32', '0', '2018-05-21 19:20:32');
INSERT INTO `yy_parameter` VALUES ('f8d739da-ffba-4a3b-a1cc-1badce7c8c40', '1', null, '用于获取表的外键查询的数据库名', 'sys', '', 'SCHEMA', '数据库名', '', 'ems', null, '\0', '', '2016-11-30 22:20:11', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '2016-11-30 22:20:11', '系统管理员', '系统管理员', '2017-11-16 19:03:10', '0', '2017-11-16 19:03:10');
INSERT INTO `yy_parameter` VALUES ('fd473500-3c9d-4049-88d2-42e553e77480', '1', null, '', 'sys', '', 'yy_exceltemplate', '导出导入模板地址', null, '/exceltemplate', null, '\0', '', '2016-04-24 14:54:37', 'd4859015-7452-4139-888e-8320a5d04f90', null, null, '2016-04-24 14:54:37', '管理员', null, null, '0', null);

-- ----------------------------
-- Table structure for yy_role
-- ----------------------------
DROP TABLE IF EXISTS `yy_role`;
CREATE TABLE `yy_role` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `create_ts` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_ts` datetime DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `rolegroup_id` varchar(36) NOT NULL,
  `approver_ts` datetime DEFAULT NULL,
  `approvers` varchar(50) DEFAULT NULL,
  `approver` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `approver_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `UK_7wmwy2o0pwgk7xfj3rfiohah6` (`code`),
  KEY `FK_sqo0wqr87mqn8iveisehh1fuv` (`rolegroup_id`),
  CONSTRAINT `FK_sqo0wqr87mqn8iveisehh1fuv` FOREIGN KEY (`rolegroup_id`) REFERENCES `yy_rolegroup` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_role
-- ----------------------------
INSERT INTO `yy_role` VALUES ('6096d46d-7b8d-45f6-9b67-f75583dcf316', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '', '管理员', '8bcf4832-f43f-483b-8e6c-01d6053beb83', null, null, null, null, null, null, '2017-11-16 19:39:19', '系统管理员', null, null, '20', '2017-11-16 19:39:19');
INSERT INTO `yy_role` VALUES ('ae39aea9-d683-4850-b557-e6d6c406201f', '1', null, null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '', '系统超级管理员', '8bcf4832-f43f-483b-8e6c-01d6053beb83', null, null, null, null, null, null, null, null, '系统管理员', '2017-11-16 19:39:10', '10', '2017-11-16 19:39:10');

-- ----------------------------
-- Table structure for yy_rolefunc_action
-- ----------------------------
DROP TABLE IF EXISTS `yy_rolefunc_action`;
CREATE TABLE `yy_rolefunc_action` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) NOT NULL,
  `func_action_id` varchar(36) DEFAULT NULL,
  `rolefunc_id` varchar(36) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `FK_6qmgw14tvsskc0q2au3eww4e7` (`func_action_id`),
  KEY `FK_krx840hna2vqxkirc0ct6buxy` (`rolefunc_id`),
  CONSTRAINT `FK_6qmgw14tvsskc0q2au3eww4e7` FOREIGN KEY (`func_action_id`) REFERENCES `yy_func_action` (`uuid`),
  CONSTRAINT `FK_krx840hna2vqxkirc0ct6buxy` FOREIGN KEY (`rolefunc_id`) REFERENCES `yy_role_func` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_rolefunc_action
-- ----------------------------

-- ----------------------------
-- Table structure for yy_rolegroup
-- ----------------------------
DROP TABLE IF EXISTS `yy_rolegroup`;
CREATE TABLE `yy_rolegroup` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `create_ts` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_ts` datetime DEFAULT NULL,
  `nodepath` varchar(500) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `rolegroup_code` varchar(20) NOT NULL,
  `rolegroup_name` varchar(50) NOT NULL,
  `showorder` smallint(6) DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `sys` bit(1) DEFAULT NULL,
  `iconcls` varchar(50) DEFAULT NULL,
  `rolegroup_css` varchar(100) DEFAULT NULL,
  `islast` bit(1) DEFAULT NULL,
  `parentid` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `UK_cja5burhqsdlyt7r9qae0ra2f` (`rolegroup_code`),
  KEY `FK_bx14irenpn5wf07726i23k9d1` (`parent_id`),
  CONSTRAINT `FK_bx14irenpn5wf07726i23k9d1` FOREIGN KEY (`parent_id`) REFERENCES `yy_rolegroup` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_rolegroup
-- ----------------------------
INSERT INTO `yy_rolegroup` VALUES ('8bcf4832-f43f-483b-8e6c-01d6053beb83', '1', '2015-12-16 11:44:31', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2015-12-16 13:22:20', 'root,8bcf4832-f43f-483b-8e6c-01d6053beb83', '', '10', '系统用户组', null, null, '\0', null, null, '', 'root', null, null, null, null, '超级系统管理员', '2018-01-21 17:21:29', '2018-01-21 17:21:29');
INSERT INTO `yy_rolegroup` VALUES ('root', '1', '2015-12-15 11:18:07', null, null, '2015-12-15 14:08:47', 'root', null, 'root', '角色组', null, null, '\0', 'icon-cogs', null, '\0', null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for yy_role_func
-- ----------------------------
DROP TABLE IF EXISTS `yy_role_func`;
CREATE TABLE `yy_role_func` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `func_id` varchar(36) NOT NULL,
  `role_id` varchar(36) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `FK_kms7arqdxf3wtdf7j9htemkai` (`func_id`),
  KEY `FK_d6thcgqeq7vamidmm9bdoayg1` (`role_id`),
  CONSTRAINT `FK_d6thcgqeq7vamidmm9bdoayg1` FOREIGN KEY (`role_id`) REFERENCES `yy_role` (`uuid`),
  CONSTRAINT `FK_kms7arqdxf3wtdf7j9htemkai` FOREIGN KEY (`func_id`) REFERENCES `yy_func` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_role_func
-- ----------------------------
INSERT INTO `yy_role_func` VALUES ('025f9dd5-1da0-4833-80f5-91fcca327a87', '1', 'root', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('0b39d766-11d8-4b5d-bc05-e6025172eeda', '1', '20b906b3-7cf3-4603-9fc2-3677d264cf89', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('0b66fad5-eff2-4a83-a8c9-889b3b22afa4', '1', 'b45e5d4c-38dc-4be3-9cbf-9d5262878348', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('0ff2397a-82eb-4f22-a8d9-80f6c44d1d63', '1', '82c42da6-7ab1-4f14-a272-d7121dbf33db', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('22566b3d-72ec-49e1-a870-15fb691f1911', '1', 'be379538-5e81-4b5c-9794-6d29e11a0f6c', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('3d2b17b2-6fc2-4db4-ab4b-dfc197df726a', '1', 'e33e2576-ed05-4386-8cc0-d582d0c9fae3', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('3e394cee-6f81-4991-ae76-734ba5532d96', '1', '78ec0591-0f64-4041-8fe9-8798fa4830ec', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('49162746-e2e4-477f-9559-5bb51255dae7', '1', 'ca9acb60-5300-44df-ae44-01f78748aff0', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('4a9ecd93-bf70-4d58-bcf7-2064b1713679', '1', 'da595c92-0a64-4804-9887-8becc103ccd1', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('5714bc55-9694-4622-861c-d63fdc790dbb', '1', '2b1e6e6e-8af8-4ec7-abfd-c07a637193e2', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-31 10:17:02', '超级系统管理员', null, null, '2018-07-31 10:17:02');
INSERT INTO `yy_role_func` VALUES ('5bdee700-07bd-40c5-bcb8-e8bdbe7009d6', '1', 'fad556f2-1007-4f41-95fa-43a866ea1543', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('67422d55-45de-4eec-85da-bd13dbdcdf23', '1', '27f86078-4190-4770-9312-acea5c1beb1d', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('69805c69-d0a6-4f3c-86ba-13315343adf0', '1', '79f79877-5599-4b52-9e3c-e22307630fb8', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-31 10:17:02', '超级系统管理员', null, null, '2018-07-31 10:17:02');
INSERT INTO `yy_role_func` VALUES ('76d46b50-e982-4b57-b978-b4e8d5bd800c', '1', '2c90e4d74917c191014917c3cf1d0000', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('85d32424-ed9b-4bbb-8831-5ddff15e66bc', '1', 'f9c02e15-9809-4a2a-8a0f-f780a6f10d80', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('96c32a28-c86e-46f3-a8c6-516d28e6ef22', '1', 'a2647c60-4396-43bc-8869-4e1b79917e53', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('b847ed45-be85-4215-88fa-5d6f38e46975', '1', 'f1803123-07aa-4f1d-a2ff-b22fba030b05', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-31 10:17:02', '超级系统管理员', null, null, '2018-07-31 10:17:02');
INSERT INTO `yy_role_func` VALUES ('b919a69a-2a4a-4bc0-854a-7b8807383063', '1', '4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('b98df7d3-5ad4-435d-bf91-1b4117673ea7', '1', '5b1047f9-05d3-4b6d-9f38-94b32ef32bfa', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('df800b0e-c65e-496f-b01e-ad1b1736aca5', '1', 'ddb7a5f2-2591-4450-96a7-84673a1ddf5e', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('e9fd5bfe-b1f3-4fde-94e6-97cb1f5c927d', '1', '9ce5e0d4-7456-475a-96c9-a13640117b24', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');
INSERT INTO `yy_role_func` VALUES ('ff61c4a4-eb56-4145-b649-021163dbc87b', '1', '97729cd0-8091-4438-887c-7e8fa5fbc6db', 'ae39aea9-d683-4850-b557-e6d6c406201f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2018-07-19 23:48:51', '超级系统管理员', null, null, '2018-07-19 23:48:51');

-- ----------------------------
-- Table structure for yy_user
-- ----------------------------
DROP TABLE IF EXISTS `yy_user`;
CREATE TABLE `yy_user` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `create_ts` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_ts` datetime DEFAULT NULL,
  `deptid` varchar(50) DEFAULT NULL,
  `deptname` varchar(256) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `invaliddate` datetime DEFAULT NULL,
  `last_ip` varchar(50) DEFAULT NULL,
  `last_time` datetime DEFAULT NULL,
  `loginname` varchar(20) NOT NULL,
  `orgid` varchar(50) DEFAULT NULL,
  `orgname` varchar(256) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `personid` varchar(50) DEFAULT NULL,
  `personname` varchar(256) DEFAULT NULL,
  `pwdanswer` varchar(255) DEFAULT NULL,
  `pwdproblem` varchar(255) DEFAULT NULL,
  `showorder` int(11) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `usertype` int(11) NOT NULL,
  `validdate` datetime DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `plainpassword` varchar(255) DEFAULT NULL,
  `mailbox` varchar(20) DEFAULT NULL,
  `mobilephone` varchar(20) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `address` varchar(20) DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `remark` varchar(20) DEFAULT NULL,
  `jobnumber` varchar(100) DEFAULT NULL,
  `approver_ts` datetime DEFAULT NULL,
  `approvers` varchar(50) DEFAULT NULL,
  `approver` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `approver_time` datetime DEFAULT NULL,
  `userrole` varchar(255) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `is_use` varchar(20) DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  `changepwd` bigint(20) DEFAULT NULL,
  `login_fail_count` bigint(20) DEFAULT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `birthaddress` varchar(250) DEFAULT NULL,
  `idcard` varchar(50) DEFAULT NULL,
  `nation` varchar(50) DEFAULT NULL,
  `pk_corp` varchar(255) DEFAULT NULL,
  `user_refid` varchar(50) DEFAULT NULL,
  `user_refname` varchar(100) DEFAULT NULL,
  `campus` varchar(100) DEFAULT NULL,
  `classes` varchar(255) DEFAULT NULL,
  `college` varchar(100) DEFAULT NULL,
  `departments` varchar(100) DEFAULT NULL,
  `grade` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `loginname` (`loginname`) USING BTREE,
  UNIQUE KEY `jobnumber` (`jobnumber`),
  KEY `FK_py64pgl45a0ttx48cbbb073qp` (`pk_corp`),
  KEY `index_user_refid` (`user_refid`),
  CONSTRAINT `FK_py64pgl45a0ttx48cbbb073qp` FOREIGN KEY (`pk_corp`) REFERENCES `yy_org` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_user
-- ----------------------------
INSERT INTO `yy_user` VALUES ('220a6226-7e52-4845-9713-1a4816f98648', '1', null, null, null, null, null, null, null, null, null, null, 'yrscy', null, null, '1e74fe3b92d4192dda59870515ca3875ba890871', null, null, null, null, null, 'yrscy', '1', null, '1370457ac65e7109', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-10-13 16:17:12', null, null, null, '1', '2018-10-13 16:17:12', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('3976eb5f-42cd-4db0-866c-bf87c9939bf6', '1', null, null, null, null, null, null, null, null, null, null, 'cty@yaorundz.com', null, null, 'd66c829c4aab0b94a25f2cd996fa47332c153f3f', null, null, null, null, null, 'cty@yaorundz.com', '1', null, '63c465787c2752d4', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-10-20 10:21:48', null, null, null, '1', '2018-10-20 10:21:48', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('46f15957-48e5-44ad-9df9-9de9ef935411', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, null, '', null, '127.0.0.1', '2019-06-08 23:15:48', 'shiao', '200fad77-9a81-4842-bf34-0411141def0c', null, '8d7d641240b7734c45e4fb061e7244b81936c0fc', null, null, null, null, null, 'shiao', '1', null, '13c78ca7e11d3028', null, null, '', null, null, null, null, null, null, null, null, null, null, null, null, '2018-07-24 21:08:06', '超级系统管理员', null, null, '1', '2019-06-09 21:20:39', '1', '1', '1', null, null, null, '200fad77-9a81-4842-bf34-0411141def0c', null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('49bb56f2-c065-4145-9f07-bcbb8e2fc24a', '1', null, null, null, null, null, null, null, null, null, null, 'yrgdy2', null, null, '79d31741681017794cd3b51744c96ad8ffcd6789', null, null, null, null, null, 'yrgdy2', '1', null, 'a7ac283a4e48b41c', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-09-09 13:00:20', null, null, null, '1', '2018-09-09 13:00:20', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('4a9a7c4a-c81c-4e76-9320-f3079dd055e0', '1', null, null, null, null, null, null, null, null, null, null, 'suzhishao', null, null, '30a61cea7a0d0e2bbf0c0c21f929dffc1893bbf0', null, null, null, null, null, 'suzhishao', '1', null, '83f8725715f2ff40', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-09-01 21:54:23', null, null, null, '1', '2018-09-01 21:54:23', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('56b856eb-261a-44c0-9011-6f2472d4d536', '1', null, null, null, null, null, null, null, null, null, null, 'yrxsy1', null, null, '0932a7b3eb3b8e0867c50cc40e842b9fbc63c1e1', null, null, null, null, null, 'yrxsy1', '1', null, '77752d98d29daa37', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-09-09 12:54:19', null, null, null, '1', '2018-09-09 12:54:19', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '1', '2015-12-23 15:15:12', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '2015-12-23 15:15:12', '', '', '', null, '127.0.0.1', '2019-06-09 21:55:09', '1', '200fad77-9a81-4842-bf34-0411141def0c', '', 'fdaf3bb0942403d5cf4230521c47275b4ffd87a8', '', '', null, null, null, '超级系统管理员', '2', null, '50f252a69d4c743d', '1', null, '', '', null, '2016-11-09 00:00:00', '', '888888', null, null, null, null, '2016-11-26 12:07:08', null, null, null, '', '系统管理员', '2017-11-19 20:08:27', '1', '2019-06-09 21:55:09', '1', '0', '1', '广东省珠海市', '23213', '汉族', '200fad77-9a81-4842-bf34-0411141def0c', '', '', null, '', '', null, '2015');
INSERT INTO `yy_user` VALUES ('97d39361-424a-45c3-9638-f7b4efdddab8', '1', null, null, null, null, null, null, null, null, null, null, 'yrgcb', null, null, '0fc6cc7b7653b4ba01197f2c7278f194f2fbe4cf', null, null, null, null, null, 'yrgcb', '1', null, 'd85c7be0b0416579', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-09-09 12:59:01', null, null, null, '1', '2018-09-09 12:59:01', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('a785f137-9de2-41b7-aa33-2f1708f5a851', '1', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, null, '', null, '0:0:0:0:0:0:0:1', '2017-11-17 16:28:28', 'system', '200fad77-9a81-4842-bf34-0411141def0c', null, '2583a9d00fbe64843ced41fff36ecca345d4164a', null, null, null, null, null, '系统管理员', '2', '2017-11-16 00:00:00', '0aaa01a841188c55', null, null, '', null, null, null, null, 'admin', null, null, null, null, null, null, null, '2017-11-16 19:39:59', '系统管理员', '超级系统管理员', '2018-01-23 20:26:50', '1', '2018-01-23 20:26:50', '1', '0', '1', null, null, null, '200fad77-9a81-4842-bf34-0411141def0c', null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('b757f6f9-ed21-412b-a0fd-9ec6dd440f56', '1', null, null, null, null, null, null, null, null, null, null, 'yrxsy2', null, null, 'bb3745f346f832b2b2ab4471bfd986a7bcf38ba4', null, null, null, null, null, 'yrxsy2', '1', null, '1d909c0a5b070bda', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-09-09 12:54:47', null, null, null, '1', '2018-09-09 12:54:47', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('bdead14b-af1c-42a9-9dc9-b3571e4a07b1', '1', null, null, null, null, null, null, null, null, null, null, 'lius', null, null, '8b8449f362477c31bde785c5e715989c210fcade', null, null, null, null, null, 'lius', '1', null, '53c168f361a8cc94', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-08-23 11:22:01', null, null, null, '1', '2019-06-09 21:21:52', '0', '1', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('e9b18937-e476-4961-9be2-74f29a7472a0', '1', null, null, null, null, null, null, null, null, null, null, 'yrgly', null, null, '6faa109a64a804eec2353ba3c6feacc31bf149b8', null, null, null, null, null, 'yrgly', '1', null, '850c4202bd052dac', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-09-09 12:54:02', null, null, null, '1', '2018-09-09 12:54:02', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('f84c3390-5eaa-4a4e-9b03-c6ae9d7bba58', '1', null, null, null, null, null, null, null, null, null, null, 'rinbow', null, null, 'ebfdf6f19ec30aff811a680e51bf54de1cfa8370', null, null, null, null, null, 'rinbow', '1', null, '41ac779453b86472', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-08-28 20:21:39', null, null, null, '1', '2018-08-28 20:21:39', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('fbb4fd29-a32d-4f78-9f9e-8f1acd323afe', '1', null, null, null, null, null, null, null, null, null, null, 'shiao2', null, null, '62f3c1529b5644013dcb32a84878daec818c4fb9', null, null, null, null, null, 'shiao2', '1', null, '95a2a9607fae5f47', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-08-26 19:27:20', null, null, null, '1', '2018-08-26 19:27:20', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `yy_user` VALUES ('fc8a0069-2523-41fd-b08a-cce1affcab87', '1', null, null, null, null, null, null, null, null, null, null, 'yrgdy1', null, null, 'ae3af114d3a7240eb02d72a06744530c5ee8813d', null, null, null, null, null, 'yrgdy1', '1', null, 'ea23c54c421f4ee0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-09-09 12:59:56', null, null, null, '1', '2018-09-09 12:59:56', '0', '0', null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for yy_usermenu
-- ----------------------------
DROP TABLE IF EXISTS `yy_usermenu`;
CREATE TABLE `yy_usermenu` (
  `uuid` varchar(36) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `funcid` varchar(255) DEFAULT NULL,
  `funcname` varchar(255) DEFAULT NULL,
  `funcurl` varchar(255) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_usermenu
-- ----------------------------

-- ----------------------------
-- Table structure for yy_userrole
-- ----------------------------
DROP TABLE IF EXISTS `yy_userrole`;
CREATE TABLE `yy_userrole` (
  `uuid` varchar(36) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `role_id` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `modifier` varchar(50) DEFAULT NULL,
  `modify_time` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  KEY `FK_fiwoulh457v2pwr914ht83wyt` (`role_id`),
  KEY `FK_afbn10w97awamqk3hfd0a8dta` (`user_id`),
  CONSTRAINT `FK_afbn10w97awamqk3hfd0a8dta` FOREIGN KEY (`user_id`) REFERENCES `yy_user` (`uuid`),
  CONSTRAINT `FK_fiwoulh457v2pwr914ht83wyt` FOREIGN KEY (`role_id`) REFERENCES `yy_role` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_userrole
-- ----------------------------
INSERT INTO `yy_userrole` VALUES ('d1285b20-1cb2-4953-beb3-14ba543c9da8', '1', 'ae39aea9-d683-4850-b557-e6d6c406201f', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2017-03-04 09:25:56', '系统管理员', null, null, '2017-03-04 09:25:56');
INSERT INTO `yy_userrole` VALUES ('fce42636-9253-4964-b923-e9d9daa625e0', '1', '6096d46d-7b8d-45f6-9b67-f75583dcf316', 'a785f137-9de2-41b7-aa33-2f1708f5a851', null, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', null, null, '2017-11-16 19:44:27', '系统管理员', null, null, '2017-11-16 19:44:27');

-- ----------------------------
-- Table structure for yy_user_org
-- ----------------------------
DROP TABLE IF EXISTS `yy_user_org`;
CREATE TABLE `yy_user_org` (
  `uuid` varchar(36) NOT NULL,
  `createtime` datetime DEFAULT NULL,
  `creator` varchar(36) DEFAULT NULL,
  `creatorname` varchar(200) DEFAULT NULL,
  `modifier` varchar(36) DEFAULT NULL,
  `modifiername` varchar(200) DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `ts` datetime DEFAULT NULL,
  `pk_corp` varchar(36) DEFAULT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yy_user_org
-- ----------------------------
