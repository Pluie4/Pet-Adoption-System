/*
 Navicat Premium Dump SQL

 Source Server         : 本机MySQL
 Source Server Type    : MySQL
 Source Server Version : 50719 (5.7.19)
 Source Host           : localhost:3306
 Source Schema         : pets_adoption

 Target Server Type    : MySQL
 Target Server Version : 50719 (5.7.19)
 File Encoding         : 65001

 Date: 07/01/2026 15:28:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for adoptions
-- ----------------------------
DROP TABLE IF EXISTS `adoptions`;
CREATE TABLE `adoptions`  (
  `ado_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '领养记录id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '领养人id',
  `pet_id` int(11) NULL DEFAULT NULL COMMENT '宠物id',
  `ado_date` date NULL DEFAULT NULL COMMENT '领养时间',
  `ado_status` int(11) NULL DEFAULT NULL COMMENT '领养状态：0失败，1成功，2处理中',
  `ado_note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息，领养情况',
  PRIMARY KEY (`ado_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of adoptions
-- ----------------------------
INSERT INTO `adoptions` VALUES (13, 1000000019, 1000000015, '2026-01-07', 0, NULL);
INSERT INTO `adoptions` VALUES (14, 1000000020, 1000000005, '2026-01-07', 0, '用户被冻结，领养失败。');
INSERT INTO `adoptions` VALUES (15, 1000000020, 1000000005, '2026-01-07', 0, NULL);
INSERT INTO `adoptions` VALUES (16, 1000000020, 1000000005, '2026-01-07', 1, NULL);
INSERT INTO `adoptions` VALUES (17, 1000000020, 1000000015, '2025-12-25', 0, NULL);
INSERT INTO `adoptions` VALUES (18, 1000000019, 1000000015, '2025-12-21', 0, '用户取消领养');
INSERT INTO `adoptions` VALUES (19, 1000000020, 1000000015, '2025-12-21', 0, '用户取消领养');
INSERT INTO `adoptions` VALUES (20, 1000000020, 1000000015, '2026-01-03', 1, NULL);
INSERT INTO `adoptions` VALUES (21, 1000000019, 1000000009, '2026-01-07', 1, NULL);
INSERT INTO `adoptions` VALUES (22, 1000000019, 1000000010, '2025-12-20', 0, NULL);
INSERT INTO `adoptions` VALUES (23, 1000000019, 1000000010, '2026-01-05', 0, '领养失败！');
INSERT INTO `adoptions` VALUES (24, 1000000020, 1000000010, '2025-12-04', 1, '领养成功！');
INSERT INTO `adoptions` VALUES (25, 1000000021, 1000000011, '2025-11-30', 1, '领养成功！');
INSERT INTO `adoptions` VALUES (26, 1000000019, 1000000012, '2025-12-21', 1, '领养成功！');
INSERT INTO `adoptions` VALUES (27, 1000000019, 1000000013, '2025-12-21', 0, '用户取消领养');
INSERT INTO `adoptions` VALUES (28, 1000000022, 1000000017, '2025-11-12', 1, '领养成功！');
INSERT INTO `adoptions` VALUES (29, 1000000023, 1000000013, '2026-01-02', 2, NULL);

-- ----------------------------
-- Table structure for notices
-- ----------------------------
DROP TABLE IF EXISTS `notices`;
CREATE TABLE `notices`  (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告编号',
  `notice_type` int(11) NULL DEFAULT NULL COMMENT '公告类型：1公示，2领养日志',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '发布人编号',
  `notice_date` date NULL DEFAULT NULL COMMENT '发布时间',
  `nottice_title` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `notice_context` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '内容',
  `user_realname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发布人姓名',
  `notice_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公告图片',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notices
-- ----------------------------
INSERT INTO `notices` VALUES (1, 1, 1, '2025-12-20', '2025年宠物领养日活动公告', '我们将于2025年12月25日举办年度宠物领养日活动，届时将有超过50只可爱的猫咪和狗狗等待领养。活动现场还有专业的宠物医生提供免费咨询服务。', '管理员', 'activity_2025.jpg');
INSERT INTO `notices` VALUES (2, 2, 1, '2025-12-18', '系统升级维护通知', '为了提供更好的服务体验，我们将于2025年12月20日凌晨2:00-6:00进行系统升级维护。在此期间，系统将暂停服务，请各位用户提前做好准备。', '管理员', 'system_update.jpg');
INSERT INTO `notices` VALUES (3, 3, 2, '2025-12-15', 'Max的幸福新生活', '还记得那只可爱的拉布拉多Max吗？他在今年10月被李先生一家领养。现在，Max已经完全适应了新环境，成为了家庭的开心果。', '用户1', 'max_story.jpg');
INSERT INTO `notices` VALUES (4, 1, 1, '2025-12-10', '第一届宠物摄影大赛开始报名', '为了记录宠物与主人的美好时光，我们将举办第一届宠物摄影大赛。欢迎所有宠物家庭参加，优秀作品将有机会获得丰厚奖品和展出机会。', '管理员', 'photo_contest.jpg');
INSERT INTO `notices` VALUES (5, 2, 1, '2025-12-05', '新功能上线：宠物健康档案', '我们很高兴地宣布，宠物健康档案功能正式上线！现在，领养宠物的用户可以在系统中记录和管理宠物的健康信息，包括疫苗接种、体检记录等。', '管理员', 'health_record.jpg');

-- ----------------------------
-- Table structure for pets
-- ----------------------------
DROP TABLE IF EXISTS `pets`;
CREATE TABLE `pets`  (
  `pet_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '宠物编号',
  `pet_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '宠物昵称',
  `pet_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '宠物品种',
  `pet_sex` int(11) NULL DEFAULT NULL COMMENT '宠物性别：1雄，0雌',
  `pet_age` date NULL DEFAULT NULL COMMENT '宠物生日，用于获取年龄',
  `pet_indata` date NULL DEFAULT NULL COMMENT '宠物入园时间',
  `pet_image` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '宠物照片文件名',
  `pet_introduction` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '宠物简介',
  `pet_personality` int(11) NULL DEFAULT NULL COMMENT '宠物性格：1外向，0内向',
  `pet_status` int(11) NULL DEFAULT NULL COMMENT '宠物状态：0待领养，1被领养，2被申领，3离世',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '领养人id',
  PRIMARY KEY (`pet_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000000018 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of pets
-- ----------------------------
INSERT INTO `pets` VALUES (1000000000, '奶茶', '马尔泰', 1, '2024-04-26', '2025-03-26', '奶茶.jpg', '非常可爱1', 0, 0, NULL);
INSERT INTO `pets` VALUES (1000000005, '小兔子', '兔子', 1, '2023-03-28', '2023-03-26', '4aad4d0f-acc8-49f1-b649-2b5dd86e24b2.jpg', '可爱的小兔子', 0, 1, NULL);
INSERT INTO `pets` VALUES (1000000009, '雪球', '萨摩耶', 0, '2023-05-28', '2023-03-26', '50efe419-b672-4a23-b3bf-812f443b4d23.jpg', '非常可爱修狗', 1, 1, NULL);
INSERT INTO `pets` VALUES (1000000010, '团团', '金丝熊', 1, '2024-04-10', '2023-03-26', '1f7b5949-934a-4292-9245-d8478cee9b89.jpg', '一个仓鼠宝宝，好像不太聪明的样子', 1, 1, NULL);
INSERT INTO `pets` VALUES (1000000011, '屁屁', '侏儒兔', 1, '2024-09-18', '2023-03-26', '21fe878a-eb58-4b8f-89ed-aa3bf88edc47.jpg', '屁屁小兔叽，调皮宝宝', 0, 1, NULL);
INSERT INTO `pets` VALUES (1000000012, '露西', '巴西龟', 0, '2024-08-26', '2023-03-26', '8f681507-092a-4856-8d50-d8892334c1db.jpg', '焦糖变巴的天花板，奶白背甲+粉嫩肉肉+魔眼的小可爱', 0, 1, NULL);
INSERT INTO `pets` VALUES (1000000013, '小呱', '树蛙', 1, '2024-07-13', '2023-03-26', 'ec8d7a19-d95a-4aea-8b03-36f0cfaf5bf4.jpg', '是一只小可爱呀，呱~', 0, 2, NULL);
INSERT INTO `pets` VALUES (1000000014, '皮皮', '牡丹鹦鹉', 1, '2025-03-06', '2023-03-26', 'e4420511-f549-452a-be9b-3911b9d39724.jpg', '嘴馋的小东西', 1, 0, NULL);
INSERT INTO `pets` VALUES (1000000015, 'fufu', '短毛蓝金渐层', 1, '2023-09-28', '2023-03-27', '8310bad6-569a-4460-b496-3fb25cdd67df.jpg', '超级可爱的小猫，nini是它姐姐', 1, 1, NULL);
INSERT INTO `pets` VALUES (1000000017, 'nini', '长毛蓝金渐层', 0, '2023-07-12', '2023-03-30', '22a85b55-bd12-4508-bcec-855d11ebd391.jpg', '超级可爱的小猫\n   可是ksks可是这和我是一个冷酷的复读机又有什么关系呢？\n我丢\n可是这和我是一个冷酷的复读机又有什么关系呢？', 0, 1, NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户账户',
  `user_password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `user_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `user_sex` int(11) NULL DEFAULT NULL COMMENT '用户性别:1男，0女，2未设置',
  `user_introduction` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户简介',
  `user_registertime` date NULL DEFAULT NULL COMMENT '用户注册时间',
  `user_realname` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户真实姓名',
  `user_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户手机号',
  `user_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户地址',
  `user_status` int(11) NULL DEFAULT NULL COMMENT '用户状态，0未申领，1申领中，2领养后未按规发布领养日志，3暂停使用',
  `user_type` int(11) NULL DEFAULT NULL COMMENT '用户类型，0普通用户，1管理员，2领养人',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `users_pk`(`user_account`) USING BTREE,
  UNIQUE INDEX `users_pk2`(`user_phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000000025 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1000000014, 'lurenjia', '1111', '大美女', 1, '资深宠物领养志愿者，已成功帮助10+宠物找到新家，擅长猫咪习性科普', '2025-12-30', '复读机', '17674185013', '福建省福州市鼓楼区杨桥西路50号', 0, 1);
INSERT INTO `users` VALUES (1000000019, 'ccc', '111', 'ccc', 2, '刚加入领养社区的爱心人士，喜欢柯基犬，正在学习养宠知识', '2025-12-30', '真实姓名', '17670844220', '福建省福州市鼓楼区杨桥西路50号', 3, 2);
INSERT INTO `users` VALUES (1000000020, 'qwq', 'qwq', 'qwq', 2, '一个普通用户', '2025-12-30', 'qwq', '16356356663', '福建省福州市鼓楼区杨桥西路50号', 3, 2);
INSERT INTO `users` VALUES (1000000021, 'zhangmeini', 'zhangmeini', 'rrr', 0, '宠物店店员，熟悉各类宠物用品，能给出专业的养宠装备建议', '2025-12-30', '张美妮', '17676738442', '福建省福州市鼓楼区杨桥西路50号', 0, 1);
INSERT INTO `users` VALUES (1000000022, 'yangxinrui', 'yangxinrui', 'cccc', 0, '兽医专业学生，擅长基础宠物健康护理，可解答常见的宠物生病问题', '2025-12-30', '杨馨睿', '17676787441', '福建省福州市鼓楼区杨桥西路50号', 0, 1);
INSERT INTO `users` VALUES (1000000023, 'yaohui', 'yaohui', 'Pluie', 0, '上班族铲屎官，养了一只布偶猫，日常分享打工人与宠物的相处日常', '2025-12-30', '姚慧', '17676722221', '福建省福州市鼓楼区杨桥西路50号', 1, 1);
INSERT INTO `users` VALUES (1000000024, 'zhanghongxin', '123456', 'zhanghx', 0, '退休教师，时间充裕，希望领养一只温顺的老年宠物陪伴生活', '2025-12-30', '张洪欣', '15632665187', '福建省福州市鼓楼区杨桥西路50号', 0, 1);

SET FOREIGN_KEY_CHECKS = 1;
