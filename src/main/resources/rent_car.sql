/*
 Navicat Premium Data Transfer

 Source Server         : mysql5.7.40
 Source Server Type    : MySQL
 Source Server Version : 50740 (5.7.40-log)
 Source Host           : localhost:3306
 Source Schema         : rent_car

 Target Server Type    : MySQL
 Target Server Version : 50740 (5.7.40-log)
 File Encoding         : 65001

 Date: 18/06/2024 14:22:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单id',
  `uid` bigint(64) NOT NULL COMMENT '订单用户id',
  `vehicle_id` bigint(64) NOT NULL COMMENT '租赁车辆id',
  `start` datetime(6) NOT NULL COMMENT '租赁开始日期',
  `end` datetime(6) NOT NULL COMMENT '租赁结束日期',
  `return_time` datetime(6) NULL DEFAULT NULL COMMENT '车辆归还日期',
  `total_cost` decimal(30, 2) NULL DEFAULT NULL COMMENT '总租金费用',
  `status` tinyint(4) NOT NULL COMMENT '订单状态(0: 未支付 1: 已支付 2: 已完成 3: 已取消 4: 订单异常 5：已修改)',
  `illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单信息(备注)',
  `gmt_create` datetime(6) NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(6) NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新着',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `vehicle_id`(`vehicle_id`) USING BTREE,
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('1213121', 1, 1, '2023-11-17 08:56:29.000000', '2023-11-29 08:56:32.000000', NULL, NULL, 0, NULL, '2023-11-17 08:56:43.000000', '2023-11-17 08:56:46.000000', '1', '1', 0);
INSERT INTO `order` VALUES ('1700183434268', 1, 1, '2023-11-18 08:00:00.000000', '2023-11-28 08:00:00.000000', NULL, NULL, 0, 'test', '2023-11-17 09:09:39.077000', '2023-11-17 09:09:39.077000', '1', NULL, 0);
INSERT INTO `order` VALUES ('1700183445031', 1, 1, '2023-11-18 08:00:00.000000', '2023-11-28 08:00:00.000000', NULL, NULL, 0, 'test', '2023-11-17 09:09:16.956000', '2023-11-17 09:09:16.956000', '1', NULL, 0);
INSERT INTO `order` VALUES ('1700183532081', 1, 2, '2023-11-18 08:00:00.000000', '2023-11-28 08:00:00.000000', NULL, NULL, 0, 'test11', '2023-11-17 09:10:45.194000', '2023-11-17 09:10:45.194000', '1', NULL, 0);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `avater` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户所在地址',
  `type` tinyint(2) NOT NULL COMMENT '用户类型(0：管理员 1：VIP用户  2：普通用户)',
  `state` tinyint(2) NULL DEFAULT 1 COMMENT '用户状态(0：禁用 1：启用，默认为1)',
  `gmt_create` datetime(6) NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(6) NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新着',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除(0：未删除 1：已删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '2e7aea220cf51ddd', '', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311171434600.png', '', '', 0, 0, NULL, '2023-11-17 14:52:43.299000', NULL, '1', 0);
INSERT INTO `user` VALUES (4, '1111111', '1111111', '1111111', '1111111', '1111111', '1111111', 1, 1, NULL, NULL, NULL, NULL, 0);
INSERT INTO `user` VALUES (5, 'testest', '43c2499e41ae7a34', '', '', '', '', 1, 1, '2023-11-03 09:24:10.680000', '2023-12-24 15:17:28.623000', '1', '1', 0);
INSERT INTO `user` VALUES (6, 'teset', 'c55a7663a7cfc37f', 'teset', '', '', '', 0, 0, '2023-12-24 15:13:55.593000', '2023-12-24 15:15:01.456000', '1', '1', 1);

-- ----------------------------
-- Table structure for vehicle
-- ----------------------------
DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE `vehicle`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '车辆id',
  `brand` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '车辆品牌',
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '车辆型号',
  `license` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '车牌号',
  `type` tinyint(2) NOT NULL COMMENT '车辆类型(0: 轿车 1: 客车 2: 货车)',
  `daily_rate` decimal(25, 2) NOT NULL COMMENT '车辆日租金',
  `illustrate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆信息描述',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆图片',
  `available` tinyint(2) NOT NULL DEFAULT 1 COMMENT '车辆可用性状态(0:已租出 1:未租出 2:车辆异常)',
  `gmt_create` datetime(6) NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime(6) NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `is_deleted` int(1) NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vehicle
-- ----------------------------
INSERT INTO `vehicle` VALUES (1, '沃尔沃', 'S90', '京A987SU', 0, 298.00, '长轴距豪华轿车', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311030847684.jpeg', 0, '2023-11-03 08:50:39.000000', '2023-11-17 09:09:39.098000', '1', '1', 0);
INSERT INTO `vehicle` VALUES (2, '红旗', 'L5', '京B90K86', 0, 375.00, '国产顶级豪车', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311030913841.jpeg', 0, '2023-11-03 09:22:40.677000', '2023-11-17 09:10:45.239000', '1', '1', 0);
INSERT INTO `vehicle` VALUES (3, '奔驰', 'E级', '京B90K86', 0, 286.00, '国产顶级豪车', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031028525.jpeg', 1, '2023-11-03 11:00:34.597000', '2023-11-03 11:00:34.597000', '1', NULL, 0);
INSERT INTO `vehicle` VALUES (4, '奔驰', 'S级', '京B08276', 0, 189.00, '', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031103372.jpeg', 1, '2023-11-03 11:03:53.007000', '2023-11-03 11:03:53.007000', '1', NULL, 0);
INSERT INTO `vehicle` VALUES (5, '比亚迪', '海豹', '京C69OI2', 0, 159.00, '', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031104822.png', 1, '2023-11-03 11:05:25.175000', '2023-11-03 11:05:25.175000', '1', NULL, 0);
INSERT INTO `vehicle` VALUES (6, '奔驰', 'SUV', '京E72683', 0, 218.00, '奔驰GLE轿跑SUV', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031106426.jpeg', 1, '2023-11-03 11:07:51.454000', '2023-11-03 11:07:51.454000', '1', NULL, 0);
INSERT INTO `vehicle` VALUES (7, '宇通客车', 'ZK6107H', '京A7P083', 1, 579.00, '', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031108312.png', 1, '2023-11-03 11:10:19.766000', '2023-11-03 11:10:19.766000', '1', NULL, 0);
INSERT INTO `vehicle` VALUES (8, '宇通客车', 'ZK6799HD', '京B60OK2', 1, 536.00, '', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031110378.png', 1, '2023-11-03 11:11:58.527000', '2023-11-03 11:11:58.527000', '1', NULL, 0);
INSERT INTO `vehicle` VALUES (9, '青年客车', 'JNP6900E', '京B59KP4', 1, 481.00, '柴油国三23-39座', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031117421.png', 1, '2023-11-03 11:19:13.902000', '2023-11-03 11:19:13.902000', '1', NULL, 0);
INSERT INTO `vehicle` VALUES (10, '东风商用车', '天锦KR', '京B59KP4', 2, 379.00, '245马力 4X2 6.75米 国五排半仓栅式载货车', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031122802.png', 1, '2023-11-03 11:25:15.232000', '2023-11-03 11:25:15.232000', '1', NULL, 0);
INSERT INTO `vehicle` VALUES (11, '一汽解放', 'J6F', '京C70QL8', 2, 385.00, '', 'https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031131359.png', 1, '2023-11-03 11:33:48.767000', '2023-11-03 11:33:48.767000', '1', NULL, 0);
INSERT INTO `vehicle` VALUES (12, 'test', 'test', '', 0, 0.00, '', '', 0, '2023-11-15 15:43:53.392000', '2023-11-15 15:56:43.393000', '1', '1', 1);

SET FOREIGN_KEY_CHECKS = 1;
