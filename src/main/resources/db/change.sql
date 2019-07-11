

alter table yy_device drop index barcode;  


alter table yy_device add UNIQUE index idx_uni_barcode(barcode)


INSERT INTO `yy_enumdata` (`uuid`, `status`, `description`, `groupcode`, `groupname`, `modulecode`, `sys`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('8952ca98-2b23-4c85-a318-6002251bbe6b', '1', '', 'WorkingProcedure', '工序', 'sys', '\0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:59:20', NULL, '2019-06-12 20:59:20');
INSERT INTO `yy_enumdata` (`uuid`, `status`, `description`, `groupcode`, `groupname`, `modulecode`, `sys`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('78b2e2aa-7f35-43e5-9b51-fec512f42af7', '1', '', 'MaterialClass', '物料分类', 'sys', '\0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:57:24', NULL, '2019-06-12 20:57:24');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('45c32e9d-37e7-499a-9a5c-c389571cddd8', '1', NULL, '10', '焊接', NULL, '\0', NULL, '8952ca98-2b23-4c85-a318-6002251bbe6b', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:59:20', NULL, '2019-06-12 20:59:20');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('ee2cd57d-8b19-4d92-b5a9-4e9c40431d45', '1', NULL, '30', '完工', NULL, '\0', NULL, '8952ca98-2b23-4c85-a318-6002251bbe6b', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:59:20', NULL, '2019-06-12 20:59:20');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('f39382f2-174b-49de-9640-e97d510d5467', '1', NULL, '20', '装修', NULL, '\0', NULL, '8952ca98-2b23-4c85-a318-6002251bbe6b', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:59:20', NULL, '2019-06-12 20:59:20');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('18c7c716-fbde-4f69-a6c5-20f35a767777', '1', NULL, '10', '五金配件', NULL, '\0', '1', '78b2e2aa-7f35-43e5-9b51-fec512f42af7', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:57:24', NULL, '2019-06-12 20:57:24');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('291787c9-0a9c-4cc5-95e5-96d6ad21aaca', '1', NULL, '40', '给排水', NULL, '\0', '4', '78b2e2aa-7f35-43e5-9b51-fec512f42af7', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:57:24', NULL, '2019-06-12 20:57:24');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('29e8e4ef-f908-4f7d-9155-9283036e75e5', '1', NULL, '20', 'MAS拉取物料', NULL, '\0', '2', '78b2e2aa-7f35-43e5-9b51-fec512f42af7', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:57:24', NULL, '2019-06-12 20:57:24');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('cc1848d4-5742-4649-86ff-3b8cf9cde062', '1', NULL, '50', '化工类', NULL, '\0', '5', '78b2e2aa-7f35-43e5-9b51-fec512f42af7', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:57:24', NULL, '2019-06-12 20:57:24');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('fc0974b4-65f2-4779-9760-13a46ed5bf1d', '1', NULL, '30', '隔热保温', NULL, '\0', '3', '78b2e2aa-7f35-43e5-9b51-fec512f42af7', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-12 20:57:24', NULL, '2019-06-12 20:57:24');



INSERT INTO `yy_func` (`uuid`, `status`, `create_ts`, `creator`, `modifier`, `modify_ts`, `nodepath`, `auth_type`, `description`, `fun_css`, `func_code`, `func_name`, `func_type`, `func_url`, `help_code`, `hint`, `iconcls`, `islast`, `parentid`, `permission_code`, `showorder`, `sys`, `create_time`, `modify_time`, `createtime`, `creatorname`, `modifiername`, `modifytime`, `usestatus`, `ts`) VALUES ('5fd9072a-7c2a-47e5-a808-176708e0de5d', '1', NULL, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, 'root,79f79877-5599-4b52-9e3c-e22307630fb8,5fd9072a-7c2a-47e5-a808-176708e0de5d', NULL, '', NULL, '5080', '设备列表', 'func', '@ctx@/info/device/list', NULL, NULL, '', '', '79f79877-5599-4b52-9e3c-e22307630fb8', NULL, NULL, '\0', NULL, NULL, '2019-06-13 20:54:29', '超级系统管理员', NULL, NULL, '1', '2019-06-13 20:54:29');
INSERT INTO `yy_role_func` (`uuid`, `status`, `func_id`, `role_id`, `create_time`, `creator`, `modifier`, `modify_time`, `createtime`, `creatorname`, `modifiername`, `modifytime`, `ts`) VALUES ('6b91aefb-6f37-473f-93f9-9069cc809f91', '1', '5fd9072a-7c2a-47e5-a808-176708e0de5d', 'ae39aea9-d683-4850-b557-e6d6c406201f', NULL, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, '2019-06-13 20:55:22', '超级系统管理员', NULL, NULL, '2019-06-13 20:55:22');
INSERT INTO `yy_func` (`uuid`, `status`, `create_ts`, `creator`, `modifier`, `modify_ts`, `nodepath`, `auth_type`, `description`, `fun_css`, `func_code`, `func_name`, `func_type`, `func_url`, `help_code`, `hint`, `iconcls`, `islast`, `parentid`, `permission_code`, `showorder`, `sys`, `create_time`, `modify_time`, `createtime`, `creatorname`, `modifiername`, `modifytime`, `usestatus`, `ts`) VALUES ('6cab15bb-cbc5-49ea-963a-1b5e007fde9a', '1', NULL, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, 'root,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ddb7a5f2-2591-4450-96a7-84673a1ddf5e,6cab15bb-cbc5-49ea-963a-1b5e007fde9a', NULL, '', NULL, '901098', '映射表', 'func', '@ctx@/info/mappingTable', NULL, NULL, '', '', 'ddb7a5f2-2591-4450-96a7-84673a1ddf5e', NULL, NULL, '\0', NULL, NULL, '2019-06-13 21:01:56', '超级系统管理员', NULL, NULL, '1', '2019-06-13 21:01:56');
INSERT INTO `yy_role_func` (`uuid`, `status`, `func_id`, `role_id`, `create_time`, `creator`, `modifier`, `modify_time`, `createtime`, `creatorname`, `modifiername`, `modifytime`, `ts`) VALUES ('5759e4b8-16e9-47bd-9003-996b63d979ee', '1', '6cab15bb-cbc5-49ea-963a-1b5e007fde9a', 'ae39aea9-d683-4850-b557-e6d6c406201f', NULL, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, '2019-06-13 21:02:12', '超级系统管理员', NULL, NULL, '2019-06-13 21:02:12');

INSERT INTO `yy_func` (`uuid`, `status`, `create_ts`, `creator`, `modifier`, `modify_ts`, `nodepath`, `auth_type`, `description`, `fun_css`, `func_code`, `func_name`, `func_type`, `func_url`, `help_code`, `hint`, `iconcls`, `islast`, `parentid`, `permission_code`, `showorder`, `sys`, `create_time`, `modify_time`, `createtime`, `creatorname`, `modifiername`, `modifytime`, `usestatus`, `ts`) VALUES ('8a3a89e4-e310-4a95-98d4-bbef6692f162', '1', NULL, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, 'root,4fe2a33b-85d2-43bc-9fae-f7d8c87dcfd6,ddb7a5f2-2591-4450-96a7-84673a1ddf5e,8a3a89e4-e310-4a95-98d4-bbef6692f162', NULL, '', NULL, '901099', '推送消息', 'func', '@ctx@/sys/ws/list', NULL, NULL, '', '', 'ddb7a5f2-2591-4450-96a7-84673a1ddf5e', NULL, NULL, '\0', NULL, NULL, '2019-06-14 21:45:12', '超级系统管理员', NULL, NULL, '1', '2019-06-14 21:45:12');
INSERT INTO `yy_role_func` (`uuid`, `status`, `func_id`, `role_id`, `create_time`, `creator`, `modifier`, `modify_time`, `createtime`, `creatorname`, `modifiername`, `modifytime`, `ts`) VALUES ('a3556770-1fd2-470f-adf2-aa72c7132a91', '1', '8a3a89e4-e310-4a95-98d4-bbef6692f162', 'ae39aea9-d683-4850-b557-e6d6c406201f', NULL, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, '2019-06-14 21:45:30', '超级系统管理员', NULL, NULL, '2019-06-14 21:45:30');





INSERT INTO `yy_enumdata` (`uuid`, `status`, `description`, `groupcode`, `groupname`, `modulecode`, `sys`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('590ab276-11b1-4c9b-953d-6b17774c48f8', '1', '', 'MaterialUnit', '物料单位', 'sys', '\0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-18 08:38:25', NULL, '2019-06-18 08:38:25');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('0093cca2-a6e9-4db9-892b-25610cdace47', '1', NULL, 'M', 'M', NULL, '\0', NULL, '590ab276-11b1-4c9b-953d-6b17774c48f8', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-18 08:38:25', NULL, '2019-06-18 08:38:25');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('5128de0e-3bdd-4a23-b520-2a3dcf6c9422', '1', NULL, 'L', 'L', NULL, '\0', NULL, '590ab276-11b1-4c9b-953d-6b17774c48f8', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-06-18 08:38:25', NULL, '2019-06-18 08:38:25');






CREATE TABLE `yy_job_log` (
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
  `begintime` datetime DEFAULT NULL,
  `costtime` varchar(255) DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `jobid` varchar(255) DEFAULT NULL,
  `jobname` varchar(255) DEFAULT NULL,
  `jobstatus` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

INSERT INTO `yy_enumdata` (`uuid`, `status`, `description`, `groupcode`, `groupname`, `modulecode`, `sys`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('17f94fec-b923-486f-88e6-9813e082ccab', '1', '', 'cronExpression', '定时器表达式', 'sys', '\0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:30:21', NULL, '2019-07-08 14:30:21');
INSERT INTO `yy_enumdata` (`uuid`, `status`, `description`, `groupcode`, `groupname`, `modulecode`, `sys`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('d9a752a8-a29a-4948-998e-57f90b504325', '1', '', 'jobGroup', '定时任务分组', 'sys', '\0', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:25:36', NULL, '2019-07-08 14:25:36');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('2bff6fdc-548e-4946-a2a1-4902e439994e', '1', NULL, 'day', '每天', NULL, '\0', '5', '17f94fec-b923-486f-88e6-9813e082ccab', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:30:21', NULL, '2019-07-08 14:30:21');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('57c35288-af99-4442-aa2a-e3662d37f0f0', '1', NULL, 'year', '每年', NULL, '\0', '2', '17f94fec-b923-486f-88e6-9813e082ccab', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:30:21', NULL, '2019-07-08 14:30:21');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('6bb27898-12b4-40a4-b9b1-5d4d0cc749ec', '1', NULL, 'month', '每月', NULL, '\0', '3', '17f94fec-b923-486f-88e6-9813e082ccab', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:30:21', NULL, '2019-07-08 14:30:21');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('71e7fac7-5c79-4b34-8152-4fad4050fb54', '1', NULL, 'hour', '每小时', NULL, '\0', '6', '17f94fec-b923-486f-88e6-9813e082ccab', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:30:21', NULL, '2019-07-08 14:30:21');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('a3378619-42f5-4214-bb4f-efd72b8b0fce', '1', NULL, 'once', '1次', NULL, '\0', '8', '17f94fec-b923-486f-88e6-9813e082ccab', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:30:21', NULL, '2019-07-08 14:30:21');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('a5fcefc4-fb0c-4a13-94ac-94e130d99c15', '1', NULL, 'week', '每周', NULL, '\0', '4', '17f94fec-b923-486f-88e6-9813e082ccab', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:30:21', NULL, '2019-07-08 14:30:21');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('d7a547a2-70e2-4bbe-9204-b717cea7daa7', '1', NULL, 'custom', '自定义', NULL, '\0', '1', '17f94fec-b923-486f-88e6-9813e082ccab', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:30:21', NULL, '2019-07-08 14:30:21');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('df8c61ec-3353-4f18-973b-9987959d7067', '1', NULL, 'minute', '每分钟', NULL, '\0', '7', '17f94fec-b923-486f-88e6-9813e082ccab', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:30:21', NULL, '2019-07-08 14:30:21');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('2f0bf54c-4c7b-47fe-8cfe-ea30f0606b80', '1', NULL, '01', '系统', NULL, '\0', NULL, 'd9a752a8-a29a-4948-998e-57f90b504325', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:25:36', NULL, '2019-07-08 14:25:36');
INSERT INTO `yy_enumdata_sub` (`uuid`, `status`, `description`, `enumdatakey`, `enumdataname`, `icon`, `isdefault`, `showorder`, `enumdataid`, `creator`, `modifier`, `create_time`, `modify_time`, `creatorname`, `modifiername`, `createtime`, `modifytime`, `ts`) VALUES ('b7d69cd5-e66a-4b98-af44-6da38042d12f', '1', NULL, '02', '业务', NULL, '\0', NULL, 'd9a752a8-a29a-4948-998e-57f90b504325', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, NULL, '超级系统管理员', NULL, '2019-07-08 14:25:36', NULL, '2019-07-08 14:25:36');




INSERT INTO `yy_imexlate` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `child_start_cell_num`, `coding`, `export_file_name`, `start_cell_num`, `start_row_num`, `template_name`, `ts`, `iscreate`) VALUES ('3d3fd43e-73e6-4e60-a701-8d8fb710c976', NULL, '2019-07-11 15:46:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', NULL, 'supplierExport', '厂商信息', NULL, NULL, '厂商信息', '2019-07-11 15:46:30', '1');
INSERT INTO `yy_imexlate` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `child_start_cell_num`, `coding`, `export_file_name`, `start_cell_num`, `start_row_num`, `template_name`, `ts`, `iscreate`) VALUES ('dbef6e19-0863-439a-bb91-8bf28a1c7900', NULL, '2019-07-11 15:43:51', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', NULL, 'supplierImport', '厂商导入', NULL, NULL, '厂商导入', '2019-07-11 15:43:51', '1');

INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('f7297925-ad69-4ef6-bfbd-d51c85eb38a0', NULL, '2019-07-11 15:47:20', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '备注', 'G', 'memo', '\0', 'dbef6e19-0863-439a-bb91-8bf28a1c7900', '2019-07-11 15:47:20', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('10255ca3-ab32-44a8-9e20-5959a0f9f5ed', NULL, '2019-07-11 15:46:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '备注', 'G', 'memo', '\0', '3d3fd43e-73e6-4e60-a701-8d8fb710c976', '2019-07-11 15:46:30', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('5a18d87c-35f9-438f-a73b-3a92f74255fd', NULL, '2019-07-11 15:46:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '联系人', 'C', 'contacts', '\0', '3d3fd43e-73e6-4e60-a701-8d8fb710c976', '2019-07-11 15:46:30', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('94835b7c-d6bf-417e-9f75-f66213320543', NULL, '2019-07-11 15:46:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '邮箱', 'E', 'email', '\0', '3d3fd43e-73e6-4e60-a701-8d8fb710c976', '2019-07-11 15:46:30', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('9cc6560d-6eec-4cb9-804e-30846dad41b9', NULL, '2019-07-11 15:46:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '供应商名称', 'B', 'name', '\0', '3d3fd43e-73e6-4e60-a701-8d8fb710c976', '2019-07-11 15:46:30', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('a286208a-fa09-418c-bdf6-6a589a46af8d', NULL, '2019-07-11 15:46:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '地址', 'F', 'address', '\0', '3d3fd43e-73e6-4e60-a701-8d8fb710c976', '2019-07-11 15:46:30', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('ee76ee6c-b16a-46d8-9f3d-1cfe767fffff', NULL, '2019-07-11 15:46:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '供应商编码', 'A', 'code', '\0', '3d3fd43e-73e6-4e60-a701-8d8fb710c976', '2019-07-11 15:46:30', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('fe837122-baca-4f1d-be3e-77e4523c23ca', NULL, '2019-07-11 15:46:30', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '联系电话', 'D', 'phone', '\0', '3d3fd43e-73e6-4e60-a701-8d8fb710c976', '2019-07-11 15:46:30', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('89bd1515-d1fa-44e8-82b8-afc60d0b21a6', NULL, '2019-07-11 15:43:51', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '供应商名称', 'B', 'name', '\0', 'dbef6e19-0863-439a-bb91-8bf28a1c7900', '2019-07-11 15:43:51', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('9fd12fc4-a08c-4abb-9328-9ad8e48eb7c4', NULL, '2019-07-11 15:43:51', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '供应商编码', 'A', 'code', '\0', 'dbef6e19-0863-439a-bb91-8bf28a1c7900', '2019-07-11 15:43:51', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('af65f1a6-063f-4338-a0c4-be36f11afe70', NULL, '2019-07-11 15:43:51', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '联系电话', 'D', 'phone', '\0', 'dbef6e19-0863-439a-bb91-8bf28a1c7900', '2019-07-11 15:43:51', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('e33bd0d3-48ea-4c96-aac9-96955be17f00', NULL, '2019-07-11 15:43:51', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '联系人', 'C', 'contacts', '\0', 'dbef6e19-0863-439a-bb91-8bf28a1c7900', '2019-07-11 15:43:51', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('ef89a99d-4e8e-4a80-bcba-e4625c73b755', NULL, '2019-07-11 15:43:51', '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', '超级系统管理员', NULL, NULL, NULL, NULL, '1', '邮箱', 'E', 'email', '\0', 'dbef6e19-0863-439a-bb91-8bf28a1c7900', '2019-07-11 15:43:51', NULL, '\0', NULL, NULL, NULL);
INSERT INTO `yy_imexlate_sub` (`uuid`, `create_time`, `createtime`, `creator`, `creatorname`, `modifier`, `modifiername`, `modify_time`, `modifytime`, `status`, `chinese_field`, `export_cell_num`, `field_name`, `is_main_field`, `template_id`, `ts`, `enumdata`, `isnotempty`, `qualified_value`, `datatype`, `column_width`) VALUES ('f964be02-af56-4422-a697-b3dc0b116d39', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', '地址', 'F', 'address', '\0', 'dbef6e19-0863-439a-bb91-8bf28a1c7900', '2019-07-11 15:47:20', NULL, '\0', NULL, NULL, NULL);


INSERT INTO `yy_parameter` (`uuid`, `status`, `defaultvalue`, `description`, `groudcode`, `isshow`, `paramtercode`, `paramtername`, `paramtertype`, `paramtervalue`, `showorder`, `sys`, `valuerange`, `create_time`, `creator`, `modifier`, `modify_time`, `createtime`, `creatorname`, `modifiername`, `modifytime`, `ispreset`, `ts`) VALUES ('4f5dcce3-91ef-4018-8fef-0ddddf3b2c20', '1', NULL, '', 'sys', '', 'supplierImportTemplatePath', '厂商信息导入模板', '', '/exceltemplate厂商导入.xlsx', NULL, '\0', '', NULL, '5bd60c1d-ffb3-46de-84ae-9d996d007e9f', NULL, NULL, '2019-07-11 16:07:02', '超级系统管理员', NULL, NULL, '0', '2019-07-11 16:07:02');


