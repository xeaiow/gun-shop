-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- 主機: 127.0.0.1
-- 產生時間： 2016-06-24 19:30:10
-- 伺服器版本: 10.1.13-MariaDB
-- PHP 版本： 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `jsp_project`
--

-- --------------------------------------------------------

--
-- 資料表結構 `advertising`
--

CREATE TABLE `advertising` (
  `id` int(11) NOT NULL COMMENT '編號',
  `title` varchar(300) NOT NULL COMMENT '標題',
  `content` varchar(500) NOT NULL COMMENT '內容',
  `image` varchar(300) NOT NULL COMMENT '圖片'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 資料表的匯出資料 `advertising`
--

INSERT INTO `advertising` (`id`, `title`, `content`, `image`) VALUES
(1, '註冊就送折抵優惠券', '還不快加入會員購物嗎？凡註冊即可馬上獲得折抵券哦！', '//i.imgur.com/57PvQ8L.png'),
(2, '全館商品 85 折優惠', '夏季全館商品出清大優惠', '//i.imgur.com/IYPrU4C.png'),
(3, '消費滿8萬塊隨機贈送手槍', '6/17 ~ 7/17 凡購物滿8萬元，就隨機贈送手槍一支', '//i.imgur.com/0px8idJ.png');

-- --------------------------------------------------------

--
-- 資料表結構 `area`
--

CREATE TABLE `area` (
  `id` int(11) NOT NULL COMMENT '編號',
  `name` varchar(20) NOT NULL COMMENT '名稱'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 資料表的匯出資料 `area`
--

INSERT INTO `area` (`id`, `name`) VALUES
(1, '臺北市'),
(2, '新北市'),
(3, '桃園市'),
(4, '臺中市'),
(5, '臺南市'),
(6, '高雄市'),
(7, '新竹市'),
(8, '基隆市'),
(9, '嘉義市'),
(10, '新竹縣'),
(11, '苗栗縣'),
(12, '彰化縣'),
(13, '南投縣'),
(14, '雲林縣'),
(15, '嘉義縣'),
(16, '屏東縣'),
(17, '宜蘭縣'),
(18, '花蓮縣'),
(19, '臺東縣'),
(20, '澎湖縣'),
(21, '海外');

-- --------------------------------------------------------

--
-- 資料表結構 `arsenal`
--

CREATE TABLE `arsenal` (
  `id` int(11) NOT NULL COMMENT '編號',
  `username` varchar(45) NOT NULL COMMENT '使用者',
  `item` int(11) NOT NULL COMMENT '商品',
  `date` date NOT NULL COMMENT '時間',
  `price` int(10) NOT NULL COMMENT '價錢',
  `counts` int(5) DEFAULT NULL COMMENT '數量',
  `card_type` int(1) DEFAULT NULL COMMENT '付款方式',
  `card_number` int(50) NOT NULL COMMENT '卡號',
  `bought` int(1) DEFAULT NULL COMMENT '是否購買',
  `paid` int(1) DEFAULT NULL COMMENT '是否付款',
  `less` int(1) DEFAULT NULL COMMENT '完成寄出',
  `returns` int(1) DEFAULT NULL COMMENT '退貨',
  `recipient` varchar(45) DEFAULT NULL COMMENT '接收者',
  `address` varchar(400) DEFAULT NULL COMMENT '地址',
  `remark` varchar(500) DEFAULT NULL COMMENT '備註',
  `order_form` varchar(10) DEFAULT NULL COMMENT '訂單編號'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 資料表的匯出資料 `arsenal`
--

INSERT INTO `arsenal` (`id`, `username`, `item`, `date`, `price`, `counts`, `card_type`, `card_number`, `bought`, `paid`, `less`, `returns`, `recipient`, `address`, `remark`, `order_form`) VALUES
(1, 'xeaiow', 2, '2016-06-17', 12600, 1, 1, 1111111111, 1, 1, 1, NULL, '吳冠興', '範例街98號', '', '66061235'),
(2, 'xeaiow', 3, '2016-06-17', 51200, 1, 1, 1111111111, 1, 1, 0, NULL, '吳冠興', '範例街98號', '', '66061235');

-- --------------------------------------------------------

--
-- 資料表結構 `commodity`
--

CREATE TABLE `commodity` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `meta` varchar(100) NOT NULL COMMENT '簡介',
  `type` int(2) NOT NULL,
  `subtype` int(2) NOT NULL COMMENT '子類別',
  `content` varchar(500) NOT NULL,
  `model` varchar(30) NOT NULL COMMENT '機型',
  `inch` int(2) NOT NULL COMMENT '吋',
  `length` int(5) NOT NULL COMMENT '長度',
  `weight` int(5) NOT NULL COMMENT '重量',
  `material` varchar(50) NOT NULL COMMENT '材質',
  `speed` int(4) NOT NULL COMMENT '初速',
  `clip` int(5) NOT NULL COMMENT '裝彈數',
  `price` int(6) NOT NULL,
  `pic` varchar(200) NOT NULL,
  `pre` varchar(3) DEFAULT NULL,
  `stock` int(5) DEFAULT NULL COMMENT '庫存'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 資料表的匯出資料 `commodity`
--

INSERT INTO `commodity` (`id`, `name`, `meta`, `type`, `subtype`, `content`, `model`, `inch`, `length`, `weight`, `material`, `speed`, `clip`, `price`, `pic`, `pre`, `stock`) VALUES
(2, 'AMOEBA(ARES)M4 Carbine AEG電動槍 沙色', '材質：Full Metal Alloy, Aluminum, Nylon', 2, 3, '系統：CO2 Cylinder/Semi Auto\r\n材質：Full Metal Alloy, Aluminum, Nylon\r\n重量：2700g\r\n裝彈數：7+1 Rounds', 'KCB-42AHN', 5, 215, 895, '全金屬', 110, 830, 12600, '//fs1.shop123.com.tw/200520/upload/product/2005206681pic_big_693948.jpg', '1', 47),
(3, 'APS CAM870 CO2 散彈槍 -海軍版', '材質：Full Metal Alloy, Aluminum, Nylon', 2, 3, '系統：CO2 Cylinder/Semi Auto\r\n材質：Full Metal Alloy, Aluminum, Nylon\r\n重量：2700g\r\n裝彈數：7+1 Rounds', 'KCB-42AHA', 4, 198, 760, '全木質', 95, 500, 51200, '//fs1.shop123.com.tw/200520/upload/product/2005206586pic_big_853206.jpg', '1', 12),
(5, 'APS CAM870 CO2 散彈槍-SAI Custom版', '材質：Full Metal Alloy, Aluminum, Nylon', 2, 3, '系統：CO2 Cylinder/Semi Auto\n材質：Full Metal Alloy, Aluminum, Nylon\n重量：4500g\n裝彈數：6+1 Rounds', 'KCB-43AHA', 6, 200, 765, '金屬', 96, 550, 12600, '//118.163.252.179/photo/image/GAPS-CAM870%20SAI-C/1.jpg', NULL, 100),
(6, 'RAM APS CAM870 M870散彈槍CO2跳殼/拋殼實木長版散彈槍', '材質：金屬、實木', 2, 3, '品牌：A.P.S.\n長度：1000mm\n重量：5000g\n材質：金屬、實木\n裝彈數：6+1發彈殼\n每顆彈殼可裝填12發6mm BB彈\n動力來源：CO2\n初速：約200FPS\n射擊模式：拉一打一\nHOP-UP：可調式', 'APS CAM870', 6, 198, 720, '木質', 220, 300, 64500, '//118.163.252.179/photo/image/GAPS-CAM870MP/1.jpg', NULL, 100),
(8, 'MARUI DESERT WARRIOR', '日本原裝進口', 2, 1, '重量：220 g\n材質：Aluminum\n顏色：沙漠色/Lacquer Coating', 'MARUI', 3, 55, 102, 'Aluminum', 75, 30, 8000, '//www.kui.com.tw/data/product/21370_2.jpeg', NULL, 50),
(9, 'ACU色~FMA CP Helmet 斯巴達', '含墨魚干', 2, 5, '', 'AFR-236', 15, 165, 328, '鐵', 0, 0, 9000, '//www.kui.com.tw/data/product/20948.jpeg', NULL, 100);

-- --------------------------------------------------------

--
-- 資料表結構 `manager`
--

CREATE TABLE `manager` (
  `id` int(11) NOT NULL COMMENT '編號',
  `username` varchar(45) NOT NULL COMMENT '帳號',
  `password` varchar(45) NOT NULL COMMENT '密碼',
  `fullname` varchar(30) NOT NULL COMMENT '稱呼'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 資料表的匯出資料 `manager`
--

INSERT INTO `manager` (`id`, `username`, `password`, `fullname`) VALUES
(1, 'xeaiow', 'a9b9c8d1', '冠興');

-- --------------------------------------------------------

--
-- 資料表結構 `member`
--

CREATE TABLE `member` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `tel` varchar(10) NOT NULL COMMENT '電話',
  `email` varchar(150) NOT NULL COMMENT 'email',
  `gender` int(1) NOT NULL COMMENT '性別',
  `birth` date NOT NULL COMMENT '生日',
  `area` int(2) NOT NULL COMMENT '行政區',
  `address` varchar(200) NOT NULL COMMENT '地址',
  `regdate` date NOT NULL COMMENT '註冊日'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 資料表結構 `reply`
--

CREATE TABLE `reply` (
  `id` int(11) NOT NULL COMMENT '編號',
  `username` varchar(45) NOT NULL COMMENT '留言人',
  `item` int(4) NOT NULL COMMENT '產品編號',
  `content` varchar(500) NOT NULL COMMENT '內容',
  `date` date NOT NULL COMMENT '時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 資料表的匯出資料 `reply`
--

INSERT INTO `reply` (`id`, `username`, `item`, `content`, `date`) VALUES
(1, 'xeaiow', 1, 'H\ni', '2016-06-12'),
(2, 'xeaiow', 1, '哈哈沒有啦', '2016-06-12'),
(3, 'xeaiow', 3, '爛槍', '2016-06-12'),
(4, 'opspeed', 3, '很好好嗎', '2016-06-12'),
(5, 'xeee', 3, '管你們', '2016-06-12'),
(6, 'xeaiow', 1, '好窩', '2016-06-12'),
(7, 'xeaiow', 1, '安安', '2016-06-12'),
(8, 'xeaiow', 2, '123', '2016-06-12'),
(9, 'xeaiow', 1, '12345\n', '2016-06-12'),
(10, 'xeaiow', 1, '123456', '2016-06-12'),
(11, '123456', 1, 'sssss', '2016-06-12'),
(12, 'xeaiow', 1, '000', '2016-06-15'),
(13, 'opspeed', 9, '好嗎', '2016-06-25');

-- --------------------------------------------------------

--
-- 資料表結構 `subtype`
--

CREATE TABLE `subtype` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '分類名稱',
  `url` varchar(10) NOT NULL COMMENT '英文分類',
  `type` int(2) NOT NULL COMMENT '父類別'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 資料表的匯出資料 `subtype`
--

INSERT INTO `subtype` (`id`, `name`, `url`, `type`) VALUES
(1, '手槍', 'gun-1', 1),
(2, '步槍', 'gun-2', 1),
(3, '散彈槍', 'gun-3', 1),
(4, '狙擊槍', 'gun-4', 1),
(5, '頭盔', 'helmet', 2),
(6, '戰術背心', 'vest', 2),
(7, '戰靴', 'boots', 2);

-- --------------------------------------------------------

--
-- 資料表結構 `type`
--

CREATE TABLE `type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL COMMENT '分類名稱',
  `url` varchar(20) NOT NULL COMMENT '英文編號'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 資料表的匯出資料 `type`
--

INSERT INTO `type` (`id`, `name`, `url`) VALUES
(1, '武器 Weapon', 'weapon'),
(2, '裝備 Equipment', 'equipment');

-- --------------------------------------------------------

--
-- 資料表結構 `visitors`
--

CREATE TABLE `visitors` (
  `id` int(11) NOT NULL COMMENT '編號',
  `username` varchar(45) NOT NULL COMMENT '使用者',
  `date` varchar(10) NOT NULL COMMENT '日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 資料表的匯出資料 `visitors`
--

INSERT INTO `visitors` (`id`, `username`, `date`) VALUES
(1, '440724654', '2016-06-16'),
(4, '426764354', '2016-06-16'),
(5, '468914395', '2016-06-16'),
(6, '576941762', '2016-06-17'),
(7, '539207996', '2016-06-17'),
(8, '539881539', '2016-06-17'),
(9, 'null', '2016-06-18'),
(10, '652688138', '2016-06-18'),
(11, '213303961', '2016-06-19'),
(13, '561564955', '2016-06-21'),
(14, '445588527', '2016-06-21'),
(15, '358948243', '2016-06-21'),
(16, '186203394', '2016-06-21'),
(17, '311001822', '2016-06-21'),
(18, '913120974', '2016-06-21'),
(19, '968881937', '2016-06-21'),
(20, '885174346', '2016-06-21'),
(21, '711095504', '2016-06-21'),
(22, '582945364', '2016-06-22'),
(23, '450217938', '2016-06-25'),
(24, '832861356', '2016-06-25');

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `advertising`
--
ALTER TABLE `advertising`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `arsenal`
--
ALTER TABLE `arsenal`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `commodity`
--
ALTER TABLE `commodity`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `manager`
--
ALTER TABLE `manager`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `reply`
--
ALTER TABLE `reply`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `subtype`
--
ALTER TABLE `subtype`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`id`);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT `advertising`
--
ALTER TABLE `advertising`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '編號', AUTO_INCREMENT=4;
--
-- 使用資料表 AUTO_INCREMENT `area`
--
ALTER TABLE `area`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '編號', AUTO_INCREMENT=22;
--
-- 使用資料表 AUTO_INCREMENT `arsenal`
--
ALTER TABLE `arsenal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '編號', AUTO_INCREMENT=3;
--
-- 使用資料表 AUTO_INCREMENT `commodity`
--
ALTER TABLE `commodity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- 使用資料表 AUTO_INCREMENT `manager`
--
ALTER TABLE `manager`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '編號', AUTO_INCREMENT=2;
--
-- 使用資料表 AUTO_INCREMENT `member`
--
ALTER TABLE `member`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- 使用資料表 AUTO_INCREMENT `reply`
--
ALTER TABLE `reply`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '編號', AUTO_INCREMENT=14;
--
-- 使用資料表 AUTO_INCREMENT `subtype`
--
ALTER TABLE `subtype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- 使用資料表 AUTO_INCREMENT `type`
--
ALTER TABLE `type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用資料表 AUTO_INCREMENT `visitors`
--
ALTER TABLE `visitors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '編號', AUTO_INCREMENT=25;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
