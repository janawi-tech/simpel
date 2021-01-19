-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2021 at 11:25 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bpfkbanj_simpel`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `func_inc_var_session` () RETURNS INT(11) NO SQL
BEGIN

  SET @var := IFNULL(@var,0) + 1;
  return @var;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_alat` (`InId` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN
  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT nama from lab_alat WHERE id=InId);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_customer` (`nOrder` VARCHAR(20), `idOrder` INT(11)) RETURNS VARCHAR(100) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci NO SQL
BEGIN

DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT pemilik from lab_customer WHERE no_order=nOrder AND id_order=idOrder);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_fungsi` (`InId` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT fungsi from lab_fungsi WHERE id=InId);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_groups` (`InId` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT groups from lab_admins_group WHERE id=InId);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_jenis` (`provid` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT jenis from lab_jenis WHERE id=provid);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_jumlah` (`nOrder` VARCHAR(20), `alatId` VARCHAR(100), `ptgId` INT) RETURNS INT(11) NO SQL
BEGIN

DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT sum(lo.jumlah) as jumlah from lab_detail_order lo JOIN lab_orderan la ON la.no_order=lo.no_order JOIN lab_spk ls ON ls.no_order=lo.no_order WHERE lo.alat_id IN (alatId) AND ls.petugas_id=ptgId and lo.no_order=nOrder);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_kab` (`kabid` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT name from lab_kabupaten WHERE kabupaten_id=kabid);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_kainstalasi` (`InId` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT nama from lab_instalasi WHERE id=InId);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_laik_pakai` (`alatId` VARCHAR(100)) RETURNS INT(11) NO SQL
BEGIN

DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT COUNT(ldo.id_order) as laik_pakai FROM lab_detail_order ldo WHERE ldo.catatan LIKE '%Laik Pakai' AND ldo.alat_id=alatId GROUP BY YEAR(ldo.updated_at),ldo.alat_id ORDER BY ldo.id_order DESC );

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_nama` (`InId` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT name from admins WHERE id=InId);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_prov` (`provid` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT name from lab_provinsi WHERE provinsi_id=provid);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_status` (`InId` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT setatus from lab_status WHERE id=InId);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_tarif` (`InId` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT tarif from lab_alat WHERE id=InId);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_tempat` (`InId` INT) RETURNS VARCHAR(100) CHARSET utf8 NO SQL
BEGIN

  DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT laboratorium from lab_laboratorium WHERE id=InId);

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_tidak_laik` (`alatId` VARCHAR(100)) RETURNS INT(11) NO SQL
BEGIN

DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT COUNT(ldo.id_order) as laik_pakai FROM lab_detail_order ldo WHERE ldo.catatan LIKE '%Tidak Laik Pakai' AND ldo.alat_id=alatId GROUP BY YEAR(ldo.updated_at),ldo.alat_id ORDER BY ldo.id_order DESC );

  RETURN MyOutput;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_total` (`nOrder` VARCHAR(20), `idOrder` INT(11)) RETURNS INT(11) NO SQL
BEGIN

DECLARE MyOutput varchar(100);
	SET MyOutput = (SELECT sum((la.tarif)*(lo.jumlah)) as total from lab_detail_order lo JOIN lab_alat la ON la.id=lo.alat_id where lo.no_order=nOrder AND lo.id_order=idOrder);

  RETURN MyOutput;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `groups` int(11) NOT NULL,
  `nip` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lvl` int(2) NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `groups`, `nip`, `lvl`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'Moch. Arif Afianto', 'afiantoarif78@gmail.com', 1, '1', 0, '$2y$10$X4btsmaSzYWfljcP26i4yOoTLM.WssFVMNvvzTLUCT77qyQFZfSZq', '7FxwI7WVDl48VbHXz6jIQnQdlYLwWzMY2PxgnM70IBMwDHxo1fr5NwA9ffzo', '2018-03-21 01:56:36', '2019-01-22 15:35:27'),
(4, 'Yuni Irnawati, SKM', NULL, 2, '197806222002122001', 0, NULL, NULL, NULL, NULL),
(5, 'Dany Firmanto', NULL, 3, '198112092009121003', 0, NULL, NULL, NULL, NULL),
(6, 'Rangga Setya Hantoko', NULL, 3, '198308252009121001', 0, NULL, NULL, NULL, NULL),
(7, 'Choirul Huda', NULL, 3, '198112092009121003', 1, NULL, NULL, NULL, NULL),
(9, 'Donny Martha', 'donny_lpfk', 3, '198103112010121001', 0, '$2y$10$DlEZRgHyp0G/Zk83hbXNwe0.AC7hGnTnSWJGCxIDxa98Y6kk2X1BO', 'kLkv0X1zQWaMRn50kl0ACDO6JyV8iF69hj41EQO5V9dET9QtT3xKHYosyjaw', NULL, '2019-01-24 15:24:43'),
(10, 'Isra Mahensa', NULL, 3, '199206142015031006', 0, NULL, NULL, NULL, NULL),
(11, 'Muhammad Arrizal Septiawan', NULL, 3, '199309262015031003', 0, NULL, NULL, NULL, NULL),
(12, 'Muhammad Zaenuri Sugiasmoro', NULL, 3, '199301042015031001', 0, NULL, NULL, NULL, NULL),
(13, 'Hamdan Syarif', NULL, 3, '199306292018011001', 0, NULL, NULL, NULL, NULL),
(16, 'Muhammad Irfan Husnuzhzhan', NULL, 3, '199501312019021001', 0, NULL, NULL, NULL, NULL),
(17, 'Fatimah Novrianisa', 'fatimah0953', 3, NULL, 0, '$2y$10$opmnDd81aHESUYJf4.emXevjKC4yPBZDRPwpGxfuf6YZlTjgszynW', '02icUaHU1Pv0gfVqaWZdNStvBb4TXyMgKCSi6FMdIeeQTlpLgDimxHpPRmba', NULL, NULL),
(18, 'Septia Khairunnisa', 'septi01802', 3, NULL, 0, '$2y$10$Q1Q0Tt.pOwoexZfnTOSJxOWvq2Epl2R./W.0dVy7wU6BM9i4NgZ1K', 'DaGgn2KvfAtLaLw3EnbFbTsgAfFO5MReCHUpePyPBWUpVKfpMIYiQZ3wG0YH', NULL, NULL),
(19, 'Sri Mawarni, SE', 'srilokabjb18', 5, '198610172009122001', 0, '$2y$10$3aEHMbqcO2/Xs8rreXacZuMHHgunPt6On30yrtbrw9p1dyfmXspgu', 'LHzo8L02dRywYgdbtdogQWZqJwZkFK8c0xOaVyot4nk6v9uug11BPcHV6G0K', NULL, '2019-01-20 16:35:36'),
(20, 'Hary Ernanto', 'haryer', 3, '198710222010011005', 0, '$2y$10$AT8KZOUEcM35wJsBUvOPUeFo9sxUrro7JY/PBMiiRjcqUOhSClM/2', NULL, NULL, NULL),
(21, 'Gusti Arya Dinata', NULL, 3, '199608272019021001', 0, NULL, NULL, NULL, NULL),
(22, 'Venna Filosofia', '', 3, NULL, 0, '', 'ULUs1IldzrObI0xXptW0USUGCMVdFxA9q9BCQOdyLLKQVSh4J1npnTk4oJIL', NULL, NULL),
(25, 'Fikry Faradina', 's', 3, NULL, 0, '', 'ULUs1IldzrObI0xXptW0USUGCMVdFxA9q9BCQOdyLLKQVSh4J1npnTk4oJIL', NULL, NULL),
(27, 'Muhammad Iqbal Saiful Rahman', 'a', 3, NULL, 0, '', 'ULUs1IldzrObI0xXptW0USUGCMVdFxA9q9BCQOdyLLKQVSh4J1npnTk4oJIL', NULL, NULL),
(28, 'Wardimanul Abrar', 'z', 3, NULL, 0, '', 'ULUs1IldzrObI0xXptW0USUGCMVdFxA9q9BCQOdyLLKQVSh4J1npnTk4oJIL', NULL, NULL),
(29, 'Taufik Priawan', 'h', 3, NULL, 0, '', 'ULUs1IldzrObI0xXptW0USUGCMVdFxA9q9BCQOdyLLKQVSh4J1npnTk4oJIL', NULL, NULL),
(30, 'Achmad Fauzan Adzim', 'c', 3, NULL, 0, '', 'ULUs1IldzrObI0xXptW0USUGCMVdFxA9q9BCQOdyLLKQVSh4J1npnTk4oJIL', NULL, NULL),
(31, 'Muhammad Alpian Hadi', 'o', 3, NULL, 0, '', 'ULUs1IldzrObI0xXptW0USUGCMVdFxA9q9BCQOdyLLKQVSh4J1npnTk4oJIL', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lab_admins_group`
--

CREATE TABLE `lab_admins_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `groups` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_admins_group`
--

INSERT INTO `lab_admins_group` (`id`, `groups`, `created_at`, `updated_at`) VALUES
(1, 'Admnistrator', NULL, NULL),
(2, 'Kepala LPFK', NULL, NULL),
(3, 'Teknisi Elektromedis', NULL, NULL),
(4, 'Pengolah Data', NULL, NULL),
(5, 'Bendahara', NULL, NULL),
(6, 'TU', NULL, NULL),
(7, 'Staf Teknis', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lab_alat`
--

CREATE TABLE `lab_alat` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tarif` int(11) NOT NULL,
  `layanan` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_alat`
--

INSERT INTO `lab_alat` (`id`, `nama`, `tarif`, `layanan`, `created_at`, `updated_at`) VALUES
(1, 'Flow Meter', 192000, 1, NULL, NULL),
(2, 'Thermometer Klinik', 216000, 1, NULL, NULL),
(3, 'Vaporizer ( tanpa gas anaesthesi )', 396000, 1, NULL, NULL),
(4, 'Vaporizer dg gas Desflurane', 2076000, 1, NULL, NULL),
(5, 'Vaporizer dg gas Enflurane', 2076000, 1, NULL, NULL),
(6, 'Vaporizer dg gas Halothane', 2076000, 1, NULL, NULL),
(7, 'Vaporizer dg ga Isoflurane', 2076000, 1, NULL, NULL),
(8, 'Vaporizer dg gas Sevoflurane', 2076000, 1, NULL, NULL),
(9, 'Timbangan Bayi', 180000, 1, NULL, NULL),
(10, 'Mikropipet Fix', 288000, 1, NULL, NULL),
(11, 'Mikropipet Multi Channel', 288000, 1, NULL, NULL),
(12, 'Mikropipet Variabel', 384000, 1, NULL, NULL),
(13, 'Analytical Balance', 180000, 1, NULL, NULL),
(14, 'Film Badge', 50000, 2, NULL, NULL),
(15, 'TLD', 150000, 2, NULL, NULL),
(16, 'Instalasi Listrik Medis', 1100000, 2, NULL, NULL),
(17, 'Grounding / Pentanahan', 348000, 2, NULL, NULL),
(18, 'Head Lamp', 44000, 2, NULL, NULL),
(19, 'Examination Lamp', 144000, 2, NULL, NULL),
(20, 'Lampu Operasi', 192000, 2, NULL, NULL),
(21, 'Nebulizer', 228000, 2, NULL, NULL),
(22, 'O2 Concentrator', 288000, 2, NULL, NULL),
(23, 'Photo Therapy Unit / Blue Light', 204000, 2, NULL, NULL),
(24, 'UV Lamp', 156000, 2, NULL, NULL),
(25, 'UV Sterilizer', 180000, 2, NULL, NULL),
(26, 'Alat Hisap Medik / Suction Pump ', 144000, 3, NULL, NULL),
(27, 'Suction Wall', 96000, 3, NULL, NULL),
(28, 'Autoclave', 312000, 3, NULL, NULL),
(29, 'Anaesthesi Ventilator', 396000, 3, NULL, NULL),
(30, 'Audiometer', 396000, 3, NULL, NULL),
(31, 'Baby Incubator / Inkubator Perawatan', 324000, 3, NULL, NULL),
(32, 'Bedside Monitor/ Patient Monitor', 588000, 3, NULL, NULL),
(33, 'Blood Bank', 252000, 3, NULL, NULL),
(34, 'Blood Pressure Monitor', 162000, 3, NULL, NULL),
(35, 'Centrifuge', 240000, 3, NULL, NULL),
(36, 'CPAP', 396000, 3, NULL, NULL),
(37, 'Defibrillator', 156000, 3, NULL, NULL),
(38, 'Defibrillator With ECG', 300000, 3, NULL, NULL),
(39, 'Defibrillator Monitor ', 300000, 3, NULL, NULL),
(40, 'Dental Unit', 168000, 3, NULL, NULL),
(41, 'Doppler / Foetal Detector ', 156000, 3, NULL, NULL),
(42, 'ECG Recorder', 180000, 3, NULL, NULL),
(43, 'Elektro Stimulator / EST', 288000, 3, NULL, NULL),
(44, 'ESU', 348000, 3, NULL, NULL),
(45, 'Haemodialisa', 216000, 3, NULL, NULL),
(46, 'Heart Rate Monitor', 300000, 3, NULL, NULL),
(47, 'Infant Warmer', 240000, 3, NULL, NULL),
(48, 'Infusion Pump', 288000, 3, NULL, NULL),
(49, 'Laboratorium Incubator', 252000, 3, NULL, NULL),
(50, 'Laboratorium Refrigerator', 252000, 3, NULL, NULL),
(51, 'Laboratorium Rotator', 144000, 3, NULL, NULL),
(52, 'Mesin Anaesthesi tanpa Vaporizer tanpa Ventilator', 228000, 3, NULL, NULL),
(53, 'Oven', 396000, 3, NULL, NULL),
(54, 'Paraffin Bath', 252000, 3, NULL, NULL),
(55, 'Pulse Oximetri/ SPO2 Monitor', 180000, 3, NULL, NULL),
(56, 'Short Wave Diathermi', 312000, 3, NULL, NULL),
(57, 'Sphygmomanometer', 84000, 3, NULL, NULL),
(58, 'Tensimeter Semi Digital', 162000, 3, NULL, NULL),
(59, 'Spirometer', 156000, 3, NULL, NULL),
(60, 'Sterilisator Basah ', 204000, 3, NULL, NULL),
(61, 'Sterilisator Kering', 204000, 3, NULL, NULL),
(62, 'Syringe Pump', 288000, 3, NULL, NULL),
(63, 'Traksi', 168000, 3, NULL, NULL),
(64, 'Treadmill', 168000, 3, NULL, NULL),
(65, 'Ultrasound Therapy', 216000, 3, NULL, NULL),
(66, 'USG', 300000, 3, NULL, NULL),
(67, 'Vacuum Extractor', 168000, 3, NULL, NULL),
(68, 'Ventilator', 660000, 3, NULL, NULL),
(69, 'Water Bath', 216000, 3, NULL, NULL),
(70, 'Centrifuge Refrigerator', 420000, 3, NULL, NULL),
(71, 'Stirer', 156000, 3, NULL, NULL),
(72, 'Medical Freezer', 396000, 3, NULL, NULL),
(73, 'Blood Warmer', 216000, 3, NULL, NULL),
(74, 'General Purpose', 1032000, 4, NULL, NULL),
(75, 'Mobile X Ray', 876000, 4, NULL, NULL),
(76, 'Dental X Ray', 950000, 4, NULL, NULL),
(77, 'Dental Panoramic', 600000, 4, NULL, NULL),
(78, 'Dental Panoramic with Chepalometric', 700000, 4, NULL, NULL),
(79, 'CT Scan', 1044000, 4, NULL, NULL),
(80, 'Penggantian Holder', 275000, 5, NULL, NULL),
(81, 'General Purpose', 1872000, 6, NULL, NULL),
(82, 'Mobile X Ray', 1400000, 6, NULL, NULL),
(83, 'Dental X Ray', 1400000, 6, NULL, NULL),
(84, 'Dental Panoramic', 1400000, 6, NULL, NULL),
(85, 'Treadmill with ECG', 250000, 1, NULL, NULL),
(86, 'Cardiotocograph (CTG)', 168000, 3, NULL, NULL),
(87, 'EEG', 420000, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lab_bukti`
--

CREATE TABLE `lab_bukti` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `no_order` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alat_id` text COLLATE utf8mb4_unicode_ci,
  `tgl_serah` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `penyerah` int(11) NOT NULL,
  `penerima` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `p1` int(11) DEFAULT '0',
  `p2` int(11) DEFAULT '0',
  `p3` int(11) DEFAULT '0',
  `p4` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_bukti`
--

INSERT INTO `lab_bukti` (`id`, `id_order`, `no_order`, `alat_id`, `tgl_serah`, `penyerah`, `penerima`, `p1`, `p2`, `p3`, `p4`, `created_at`, `updated_at`) VALUES
(2, 3, 'E - 002 Dt', '[\"34\"]', '2019-01-28', 17, 'Kasripin', 1, 0, 0, 1, '2019-01-24 09:21:08', '2019-01-24 09:21:08'),
(4, 4, 'E - 004 Dt', '[\"15\"]', '2019-02-01', 17, 'Muhammad Irwan', 1, 0, 0, 1, '2019-01-31 10:40:19', '2019-01-31 10:40:19'),
(7, 6, 'E - 006 Dt', '[\"20\"]', '2019-02-06', 17, 'Sunusi', 1, 0, 0, 1, '2019-02-06 11:42:02', '2019-02-06 11:42:02'),
(8, 5, 'E - 005 Dt', '[\"18\"]', '2019-02-07', 17, 'Syukur Yakub', 1, 0, 0, 1, '2019-02-06 15:22:52', '2019-02-06 15:22:52'),
(12, 6, 'E - 006 Dt', '[\"19,21,22,23\"]', '2019-02-08', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-02-07 11:16:27', '2019-02-07 11:16:27'),
(13, 9, 'E - 009 Dt', '[\"32\"]', '2019-02-20', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-02-19 11:56:50', '2019-02-19 11:56:50'),
(14, 7, 'E - 007 Dt', '[\"24\"]', '2019-02-21', 17, 'Nur Huda', 1, NULL, NULL, NULL, '2019-02-20 19:23:32', '2019-02-20 19:23:32'),
(15, 8, 'E - 008 Dt', '[\"25,26,27,28,29,30,31\"]', '2019-02-25', 18, 'Fathur Rahman', 1, 1, NULL, 1, '2019-02-24 17:29:42', '2019-02-24 17:31:23'),
(16, 11, 'E - 010 Dt', '[\"35,36,37,38,39\"]', '2019-03-04', 18, 'Arief Pramono', 1, 1, NULL, 1, '2019-03-03 22:18:42', '2019-03-03 22:18:42'),
(17, 15, 'E - 013 Dt', '[\"46,47,48,49\"]', '2019-03-06', 17, 'Bara Rianto', 1, NULL, NULL, 1, '2019-03-05 17:14:23', '2019-03-05 17:15:32'),
(18, 14, 'E - 012 Dt', '[\"45\"]', '2019-03-05', 18, 'Muhammad Irwan', 1, 1, NULL, 1, '2019-03-05 21:05:33', '2019-03-05 21:05:33'),
(19, 17, 'E - 015 Dt', '[\"51\"]', '2019-03-13', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-03-12 18:21:59', '2019-03-12 18:21:59'),
(20, 18, 'E - 016 Dt', '[\"52\"]', '2019-03-13', 18, 'Muhammad Irwan', 1, 1, NULL, 1, '2019-03-12 18:22:40', '2019-03-12 18:22:40'),
(21, 19, 'E - 017 Dt', '[\"53,54,55\"]', '2019-03-13', 17, 'Rizky Riadi Saputra', 1, NULL, NULL, 1, '2019-03-12 23:12:07', '2019-03-12 23:15:23'),
(25, 12, 'E - 011 Dt', '[\"15,40,41,79\"]', '2019-03-14', 17, 'Sari', 1, NULL, NULL, 1, '2019-03-14 15:19:01', '2019-03-14 15:19:01'),
(26, 20, 'E - 018 Dt', '[\"56\"]', '2019-03-19', 18, 'Muhammad Irwan', 1, 1, NULL, 1, '2019-03-18 18:51:01', '2019-03-18 18:51:01'),
(27, 21, 'E - 019 Dt', '[\"57,59,60,61,62,63,66,67,68,69,70,71,72,73,76,77,86\"]', '2019-03-20', 17, 'Mira', 1, NULL, NULL, 1, '2019-03-19 19:00:14', '2019-03-19 19:00:14'),
(28, 32, 'E - 033 Dt', '[\"141,143,144,146,149,151\"]', '2019-03-28', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-03-28 02:34:50', '2019-03-28 02:34:50'),
(29, 53, 'E - 046 Dt', '[\"271,263,260,268,264,262,269,272,270,258,259,266,267,265,261\"]', '2019-04-02', 17, 'Giovanni Anggre D., S.ST', 1, NULL, NULL, 1, '2019-04-02 02:01:41', '2019-04-02 02:02:08'),
(30, 54, 'E - 047 Dt', '[\"274,275,273\"]', '2019-04-12', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-04-12 02:47:44', '2019-04-12 02:47:44'),
(31, 16, 'E - 014 Dt', '[\"140,139,138,137,136,134,133\"]', '2019-04-18', 17, 'Wijanati', 1, 1, NULL, 1, '2019-04-18 06:28:56', '2019-04-18 06:28:56'),
(32, 56, 'E - 049 Dt', '[\"278,279\"]', '2019-04-18', 18, 'Indriana Sagita', 1, NULL, NULL, 1, '2019-04-18 07:21:33', '2019-04-18 07:21:33'),
(33, 23, 'E - 022 Dt', '[\"80\"]', '2019-05-14', 17, 'Sari', 1, 1, NULL, 1, '2019-04-24 08:23:30', '2019-05-14 00:31:34'),
(34, 22, 'E - 020 Dt', '[\"78\"]', '2019-04-25', 18, 'DIKIRIM', 1, 1, NULL, NULL, '2019-04-24 08:28:37', '2019-04-24 08:28:37'),
(35, 26, 'E - 023 Dt', '[\"93,97,99,123,88,122,109,108,92,91,90,96,98,105,104,103,102,101,89,100,107,106,94\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:01:41', '2019-04-25 01:01:41'),
(36, 27, 'E - 024 Dt', '[\"117,116,118,115,114,113,112,111\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:02:25', '2019-04-25 01:02:25'),
(37, 28, 'E - 025 Dt', '[\"119\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:02:52', '2019-04-25 01:02:52'),
(38, 29, 'E - 026 Dt', '[\"121,120\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:03:11', '2019-04-25 01:03:11'),
(39, 30, 'E - 027 Dt', '[\"132,131,130,135,129,128,127,126,125,124\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:03:28', '2019-04-25 01:03:28'),
(40, 31, 'E - 028 Dt', '[\"145,142,150,148,147\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:03:42', '2019-04-25 01:03:42'),
(41, 33, 'E - 029 Dt', '[\"166,157,154,153,152,160,162\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:03:56', '2019-04-25 01:03:56'),
(42, 34, 'E - 030 Dt', '[\"158,156,155,168,169,167,165,164,161,159,170\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:04:10', '2019-04-25 01:04:10'),
(43, 36, 'E - 031 Dt', '[\"171,174,172,180,176\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:04:24', '2019-04-25 01:04:24'),
(44, 37, 'E - 032 Dt', '[\"179,178,177,175,173,183,182,181,184,186,185\"]', '2019-04-25', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-04-25 01:04:40', '2019-04-25 01:04:40'),
(45, 56, 'E - 049 Dt', '[\"280,281\"]', '2019-04-26', 18, 'Adi', 1, NULL, NULL, 1, '2019-04-26 06:32:48', '2019-04-26 06:39:48'),
(46, 55, 'E - 048 Dt', '[\"277,276\"]', '2019-04-30', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-04-30 01:26:47', '2019-04-30 01:26:47'),
(47, 50, 'E - 044 Dt', '[\"250\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 00:53:24', '2019-05-02 00:53:24'),
(48, 49, 'E - 043 Dt', '[\"248\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 00:54:34', '2019-05-02 00:54:34'),
(49, 48, 'E - 042 Dt', '[\"241,242,243\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 01:00:22', '2019-05-02 01:00:22'),
(50, 38, 'E - 034 Dt', '[\"188,189,187\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 01:01:28', '2019-05-02 01:01:28'),
(51, 39, 'E - 035 Dt', '[\"192,195,194,196,197,201,200,199,198,193\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 01:11:18', '2019-05-02 01:11:18'),
(52, 43, 'E - 036 Dt', '[\"205,206,208\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 01:17:09', '2019-05-02 01:17:09'),
(53, 44, 'E - 037 Dt', '[\"216,214,215,218,212,239\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 01:18:12', '2019-05-02 01:18:12'),
(54, 45, 'E - 038 Dt', '[\"225,226,224,245,227,223,222,220,228,221,244\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 01:18:46', '2019-05-02 01:18:46'),
(55, 42, 'E - 039 Dt', '[\"207,211,203,210,213\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 01:19:35', '2019-05-02 01:19:35'),
(56, 46, 'E - 040 Dt', '[\"251,233,230,232,231\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 01:20:06', '2019-05-02 01:20:06'),
(57, 47, 'E - 041 Dt', '[\"235,238,236,234\"]', '2019-05-02', 17, 'Arie', 1, NULL, NULL, 1, '2019-05-02 01:20:53', '2019-05-02 01:20:53'),
(58, 52, 'E - 045 Dt', '[\"252,253,255,254\"]', '2019-05-09', 17, 'Primos', 1, 1, NULL, 1, '2019-05-09 03:00:49', '2019-05-09 03:00:49'),
(59, 61, 'E - 054 Dt', '[\"325\"]', '2019-05-27', 17, 'Didi', 1, NULL, NULL, 1, '2019-05-10 02:42:34', '2019-05-27 04:38:40'),
(60, 62, 'E - 055 Dt', '[\"327,326\"]', '2019-05-27', 17, 'Didi', 1, NULL, NULL, 1, '2019-05-10 02:44:51', '2019-05-27 04:39:04'),
(61, 63, 'E - 056 Dt', '[\"331,330,329,328\"]', '2019-05-27', 17, 'Didi', 1, NULL, NULL, 1, '2019-05-10 02:45:05', '2019-05-27 04:39:26'),
(62, 64, 'E - 057 Dt', '[\"334,333,332\"]', '2019-05-27', 17, 'Didi', 1, NULL, NULL, 1, '2019-05-10 02:47:25', '2019-05-27 04:39:41'),
(63, 65, 'E - 058 Dt', '[\"335\"]', '2019-05-27', 17, 'Didi', 1, NULL, NULL, 1, '2019-05-10 02:49:28', '2019-05-27 04:40:02'),
(64, 66, 'E - 059 Dt', '[\"336\"]', '2019-05-27', 17, 'Didi', 1, NULL, NULL, 1, '2019-05-10 02:50:57', '2019-05-27 04:41:08'),
(65, 67, 'E- 060 Dt', '[\"337\"]', '2019-05-27', 17, 'Didi', 1, NULL, NULL, 1, '2019-05-10 02:52:02', '2019-05-27 04:41:25'),
(66, 25, 'E - 021 Dt', '[\"85,84\"]', '2019-05-10', 18, 'Dikirim', 1, 1, NULL, NULL, '2019-05-10 05:43:06', '2019-05-10 05:43:20'),
(67, 76, 'E - 068 Dt', '[\"394,390,392,382,380,379\"]', '2019-05-14', 17, 'Duta Setyawan', 1, 1, NULL, 1, '2019-05-14 02:37:39', '2019-06-28 06:14:52'),
(68, 68, 'E - 061 Dt', '[\"338,343,342,341,340,339,345,344\"]', '2019-05-16', 18, 'Nyoman Dwi Astuti', 1, NULL, NULL, 1, '2019-05-14 23:40:35', '2019-05-16 00:28:23'),
(69, 73, 'E - 065 Dt', '[\"372,368,366,367,373,371,369\"]', '2019-05-15', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-05-15 00:52:11', '2019-05-15 00:52:11'),
(70, 74, 'E - 066 Dt', '[\"376,375,374\"]', '2019-05-15', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-05-15 00:52:35', '2019-05-15 00:52:35'),
(71, 58, 'E - 051 Dt', '[\"303,304,307,301,300,319,289,305,321,306,296,295,294,290\"]', '2019-05-16', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-05-16 01:52:55', '2019-05-16 01:52:55'),
(72, 59, 'E - 052 Dt', '[\"324,323,313,308,309\"]', '2019-05-16', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-05-16 01:53:21', '2019-05-16 01:53:21'),
(73, 58, 'E - 051 Dt', '[\"299\"]', '2019-05-16', 18, 'Wiwin', 1, NULL, 1, NULL, '2019-05-16 01:53:46', '2019-05-16 01:53:46'),
(74, 60, 'E - 053 Dt', '[\"315,317,316,314,318\"]', '2019-05-16', 18, 'Wiwin', 1, NULL, NULL, 1, '2019-05-16 01:54:01', '2019-05-16 01:54:01'),
(75, 75, 'E - 067 Dt', '[\"377\"]', '2019-05-20', 17, 'Nurul', 1, NULL, NULL, 1, '2019-05-20 03:14:41', '2019-05-20 03:14:41'),
(76, 70, 'E - 063 Dt', '[\"352,353,355,354\"]', '2019-05-27', 17, 'Hj. Mursidah', 1, NULL, NULL, 1, '2019-05-27 04:46:19', '2019-05-27 04:46:19'),
(78, 69, 'E - 062 Dt', '[\"351,349,346,348,347\"]', '2019-05-27', 18, 'Hj. Mursidah', 1, NULL, NULL, 1, '2019-05-27 04:47:08', '2019-05-27 04:47:08'),
(79, 71, 'E - 064 Dt', '[\"358,362,361,359,360,356,363,357\"]', '2019-05-27', 17, 'Hj. Mursidah', 1, NULL, NULL, 1, '2019-05-27 05:08:17', '2019-05-27 05:08:17'),
(80, 71, 'E - 064 Dt', '[\"364\"]', '2019-05-27', 17, 'Hj. Mursidah', 1, NULL, 1, NULL, '2019-05-27 05:08:56', '2019-05-27 05:08:56'),
(81, 83, 'E - 074 Dt', '[\"422\"]', '2019-05-29', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-05-29 02:30:30', '2019-05-29 02:30:30'),
(82, 80, 'E - 072 Dt', '[\"409,410,414,413,412\"]', '2019-05-29', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-05-29 02:30:49', '2019-05-29 02:30:49'),
(83, 79, 'E - 071 Dt', '[\"405\"]', '2019-05-29', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-05-29 02:31:15', '2019-05-29 02:31:15'),
(84, 79, 'E - 071 Dt', '[\"406,408,407,411\"]', '2019-05-29', 17, 'DIKIRIM', 1, NULL, NULL, 1, '2019-05-29 05:36:42', '2019-05-29 05:36:42'),
(85, 84, 'E - 075 Dt', '[\"424,423\"]', '2019-06-17', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-06-17 03:07:22', '2019-06-17 03:07:22'),
(86, 85, 'E - 076 Dt', '[\"426\"]', '2019-06-19', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-06-19 02:03:37', '2019-06-19 02:03:37'),
(87, 88, 'E - 079 Dt', '[\"454,451,448,446,445,450,443,442,441,452,444\"]', '2019-06-21', 17, 'Tri Mulyanto', 1, NULL, NULL, 1, '2019-06-21 06:59:40', '2019-06-21 06:59:40'),
(88, 96, 'E - 086 Dt', '[\"480\"]', '2019-06-25', 17, 'Heffy Erlina', 1, NULL, NULL, 1, '2019-06-25 06:56:47', '2019-06-25 06:56:47'),
(89, 91, 'E - 082 Dt', '[\"456\"]', '2019-06-26', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-06-26 03:57:05', '2019-06-26 03:57:05'),
(90, 97, 'E - 087 Dt', '[\"481,495,494,487,492,488,483,485,490\"]', '2019-06-28', 17, 'Dr Shinta', 1, NULL, NULL, 1, '2019-06-28 02:58:02', '2019-06-28 02:58:02'),
(92, 76, 'E - 068 Dt', '[\"383,388,387,384,393,391,389,385,386,378\"]', '2019-06-28', 17, 'Kautsar', 1, 1, NULL, 1, '2019-06-28 06:16:32', '2019-06-28 06:16:32'),
(93, 87, 'E - 078 Dt', '[\"429,438,437,436,435,434,433,432,431,430,440,439\"]', '2019-07-02', 17, 'Dikirim', 1, NULL, NULL, NULL, '2019-07-02 05:56:22', '2019-07-02 05:56:22'),
(95, 98, 'E - 088 Dt', '[\"497,496,498\"]', '2019-07-02', 18, 'Dikirim', 1, NULL, NULL, NULL, '2019-07-02 06:02:12', '2019-07-02 06:02:12'),
(96, 95, 'E - 085 Dt', '[\"477,473,472,499,478,475,474\"]', '2019-07-02', 17, 'Fahmi', 1, NULL, NULL, 1, '2019-07-02 06:55:05', '2019-07-02 06:55:05'),
(97, 89, 'E - 080 Dt', '[\"455\"]', '2019-07-03', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-07-03 06:27:12', '2019-07-03 06:27:12'),
(98, 93, 'E - 081 Dt', '[\"463,466,465,462,467\"]', '2019-07-03', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-07-03 06:27:50', '2019-07-03 06:28:46'),
(99, 94, 'E - 084 Dt', '[\"469,468\"]', '2019-07-03', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-07-03 06:32:50', '2019-07-03 06:32:50'),
(100, 85, 'E - 076 Dt', '[\"425\"]', '2019-07-03', 18, 'Fauzan', 1, NULL, NULL, 1, '2019-07-03 06:46:33', '2019-07-03 06:46:33'),
(101, 86, 'E - 077 Dt', '[\"427,428\"]', '2019-07-03', 18, 'Fauzan', 1, NULL, NULL, 1, '2019-07-03 06:51:20', '2019-07-03 06:51:20'),
(102, 82, 'E - 073 Dt', '[\"421,420,419,418,417,416,415\"]', '2019-07-03', 17, 'Erwan', 1, NULL, NULL, 1, '2019-07-03 07:56:45', '2019-07-03 07:56:45'),
(103, 95, 'E - 085 Dt', '[\"471,470\"]', '2019-07-09', 17, 'Fahmi', 1, NULL, NULL, 1, '2019-07-09 07:36:40', '2019-07-09 07:36:40'),
(104, 92, 'E - 083 Dt', '[\"461,460,459,458,457\"]', '2019-07-11', 17, 'Aulia Rahman', 1, NULL, NULL, 1, '2019-07-11 05:17:34', '2019-07-11 05:17:34'),
(105, 78, 'E - 070 Dt', '[\"396,400,399,404,398\"]', '2019-07-12', 17, 'Ahmad Hidayat', 1, 1, NULL, 1, '2019-07-12 05:54:35', '2019-07-12 05:54:35'),
(106, 99, 'E - 089 Dt', '[\"500,504,503,502,501\"]', '2019-07-18', 18, 'Eka', 1, NULL, NULL, 1, '2019-07-18 01:42:04', '2019-07-18 01:42:04'),
(107, 100, 'E - 090 Dt', '[\"512,506,511,510,509,508,507\"]', '2019-07-18', 18, 'Eka', 1, NULL, NULL, 1, '2019-07-18 01:43:16', '2019-07-18 01:43:16'),
(108, 101, 'E - 091 Dt', '[\"505,514,513\"]', '2019-07-18', 18, 'Eka', 1, NULL, NULL, 1, '2019-07-18 01:44:09', '2019-07-18 01:44:09'),
(109, 77, 'E - 069 Dt', '[\"395\"]', '2019-05-22', 17, 'Supriatin', 1, 1, NULL, 1, '2019-07-18 03:53:09', '2019-07-18 03:53:09'),
(110, 57, 'E - 050 Dt', '[\"288,287,282,286,285,283\"]', '2019-05-11', 17, 'Dikirim', 1, NULL, NULL, 1, '2019-07-18 03:54:52', '2019-07-18 03:54:52'),
(112, 103, 'E - 093 Dt', '[\"534,532,535,530,536,528,527,526,525,524,531\"]', '2019-07-31', 17, 'Purnomo', 1, NULL, NULL, 1, '2019-07-31 03:49:52', '2019-07-31 03:49:52'),
(113, 108, 'E - 098 Dt', '[\"574,575\"]', '2019-08-01', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-08-01 02:51:02', '2019-08-01 02:51:02'),
(114, 110, 'E - 100 Dt', '[\"579,577,581,582,578,580\"]', '2019-08-06', 17, 'Sadam', 1, NULL, NULL, 1, '2019-08-05 06:50:06', '2019-08-06 02:37:28'),
(115, 107, 'E - 097 Dt', '[\"573\"]', '2019-08-06', 17, 'Adi', 1, NULL, NULL, 1, '2019-08-06 02:06:46', '2019-08-06 02:06:46'),
(116, 112, 'E - 102 Dt', '[\"590,591\"]', '2019-08-07', 17, 'Sadam', 1, NULL, NULL, 1, '2019-08-07 03:30:22', '2019-08-07 03:30:22'),
(117, 109, 'E - 099 Dt', '[\"576\"]', '2019-08-08', 17, 'Tika', 1, NULL, NULL, 1, '2019-08-08 05:01:32', '2019-08-08 05:18:55'),
(118, 104, 'E - 094 Dt', '[\"563,552,546,545,544,543,542,541,551,550,549,548,537,547,557,554,559,556,562,560,558,540,539,538,565,564,555,553,561\"]', '2019-07-29', 17, 'M. Khaironi', 1, NULL, NULL, 1, '2019-08-08 05:03:40', '2019-08-08 05:03:40'),
(119, 104, 'E - 094 Dt', '[\"567,566\"]', '2019-08-08', 17, 'Tika', 1, NULL, NULL, 1, '2019-08-08 05:04:13', '2019-08-08 05:18:41'),
(120, 102, 'E - 092 Dt', '[\"522,521,519,518,517,516,515,523\"]', '2019-08-09', 18, 'Daniel', 1, 1, NULL, 1, '2019-08-09 05:43:48', '2019-08-09 05:43:48'),
(121, 113, 'E - 103 Dt', '[\"596,595\"]', '2019-08-23', 17, 'Eka', 1, NULL, NULL, 1, '2019-08-14 00:48:36', '2019-08-23 03:45:26'),
(122, 114, 'E - 104 Dt', '[\"594\"]', '2019-08-23', 17, 'Eka', 1, NULL, NULL, 1, '2019-08-14 00:49:04', '2019-08-23 03:45:34'),
(123, 115, 'E - 105 Dt', '[\"593,592\"]', '2019-08-23', 17, 'Eka', 1, NULL, NULL, 1, '2019-08-14 00:49:24', '2019-08-23 03:45:41'),
(124, 116, 'E - 106 Dt', '[\"597,598\"]', '2019-08-21', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-08-14 00:51:02', '2019-08-21 02:42:41'),
(125, 119, 'E - 109 Dt', '[\"609\"]', '2019-08-21', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-08-14 00:54:04', '2019-08-21 02:42:31'),
(126, 117, 'E - 107 Dt', '[\"599\"]', '2019-08-14', 17, 'Tri Mulyanto', 1, NULL, NULL, 1, '2019-08-14 00:58:12', '2019-08-14 00:58:12'),
(127, 88, 'E - 079 Dt', '[\"447,449,453\"]', '2019-08-14', 17, 'Tri Mulyanto', 1, NULL, NULL, 1, '2019-08-14 01:00:14', '2019-08-14 01:00:14'),
(128, 111, 'E - 101 Dt', '[\"583,587,589,588,586,584,585\"]', '2019-08-16', 17, 'Dikirim', 1, NULL, NULL, 1, '2019-08-16 02:09:35', '2019-08-16 02:09:35'),
(129, 105, 'E - 095 Dt', '[\"569,568\"]', '2019-08-16', 17, 'Dikirim', 1, NULL, NULL, 1, '2019-08-16 02:14:06', '2019-08-16 02:14:06'),
(130, 106, 'E - 096 Dt', '[\"571,570,572\"]', '2019-08-16', 17, 'Dikirim', 1, NULL, NULL, 1, '2019-08-16 02:15:32', '2019-08-16 02:15:32'),
(131, 124, 'E - 114 Dt', '[\"616\"]', '2019-08-27', 17, 'Dr. Waluyo', 1, NULL, NULL, 1, '2019-08-27 03:36:27', '2019-08-27 03:36:27'),
(132, 122, 'E - 112 Dt', '[\"612,615\"]', '2019-08-29', 17, 'Dina Mara Diana', 1, NULL, NULL, 1, '2019-08-29 06:10:48', '2019-08-29 06:10:48'),
(133, 121, 'E - 111 Dt', '[\"611\"]', '2019-09-03', 17, 'Adi', 1, NULL, NULL, 1, '2019-09-03 02:07:19', '2019-09-03 02:07:19'),
(134, 126, 'E - 116 Dt', '[\"618\"]', '2019-09-02', 17, 'Yuni Irmawati', 1, NULL, NULL, 1, '2019-09-03 02:14:12', '2019-09-03 02:14:12'),
(135, 130, 'E - 119 Dt', '[\"624\"]', '2019-09-06', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-09-06 05:56:25', '2019-09-06 05:56:25'),
(136, 129, 'E - 118 Dt', '[\"623\"]', '2019-10-08', 17, 'Eka', 1, NULL, NULL, 1, '2019-09-10 01:30:40', '2019-10-08 02:34:53'),
(138, 133, 'E - 122 Dt', '[\"643\"]', '2019-09-10', 17, 'Muhammad Adibaj', 1, NULL, NULL, 1, '2019-09-10 07:48:16', '2019-09-10 07:48:16'),
(139, 123, 'E - 113 Dt', '[\"614\"]', '2019-09-13', 17, '-', 1, 1, NULL, 1, '2019-09-13 08:46:58', '2019-09-13 08:46:58'),
(140, 120, 'E - 110 Dt', '[\"610\"]', '2019-09-13', 17, 'Dikirim', 1, 1, NULL, NULL, '2019-09-13 09:26:01', '2019-09-13 09:26:01'),
(141, 128, 'E - 117 Dt', '[\"622,621,620,619\"]', '2019-09-17', 18, 'Sigit', 1, NULL, NULL, 1, '2019-09-17 03:48:27', '2019-09-17 03:48:27'),
(142, 132, 'E - 121 Dt', '[\"638,637,636,635,634,633,632,631,639,642,641,640\"]', '2019-09-18', 18, 'H. Abdul Samad', 1, NULL, NULL, 1, '2019-09-18 02:47:25', '2019-09-18 02:47:25'),
(143, 134, 'E - 123 Dt', '[\"648\"]', '2019-09-18', 18, 'Fauzan', 1, NULL, NULL, 1, '2019-09-18 06:16:34', '2019-09-18 06:16:34'),
(144, 136, 'E - 124 Dt', '[\"652\"]', '2019-09-23', 18, 'Hadi Sungkono', 1, NULL, NULL, 1, '2019-09-23 03:47:58', '2019-09-23 03:47:58'),
(145, 134, 'E - 123 Dt', '[\"645,646,647,644\"]', '2019-09-25', 18, 'Fauzan', 1, NULL, NULL, 1, '2019-09-23 04:21:54', '2019-09-25 05:43:46'),
(146, 136, 'E - 124 Dt', '[\"650,651,649,653\"]', '2019-09-24', 18, 'Hadi Sungkono', 1, NULL, NULL, 1, '2019-09-24 04:39:25', '2019-09-24 04:39:25'),
(147, 131, 'E - 120 Dt', '[\"630,629,628,627,626,625\"]', '2019-12-18', 18, 'Dikirim', 1, 1, NULL, NULL, '2019-09-25 00:07:06', '2019-12-18 00:01:39'),
(148, 141, 'E - 129 Dt', '[\"695,698,688,693,692,690,689,691,694,697,696\"]', '2019-09-30', 17, 'Iwan', 1, NULL, NULL, 1, '2019-09-26 08:34:30', '2019-09-26 08:34:30'),
(149, 143, 'E - 131 Dt', '[\"712,713\"]', '2019-10-02', 17, 'Daniel PE Rembeth', 1, NULL, NULL, 1, '2019-10-02 02:11:29', '2019-10-02 02:11:29'),
(150, 139, 'E - 127 Dt', '[\"687,686\"]', '2019-10-03', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-03 02:54:29', '2019-10-03 02:54:29'),
(151, 156, 'E - 143 Dt', '[\"766\"]', '2019-10-04', 17, 'Joko', 1, NULL, NULL, 1, '2019-10-04 01:02:36', '2019-10-04 01:02:36'),
(152, 118, 'E - 108 Dt', '[\"607,608,600,603,602,601,606,605,604\"]', '2019-10-04', 18, 'Daniel', 1, 1, NULL, 1, '2019-10-04 09:25:12', '2019-10-04 09:25:12'),
(153, 137, 'E - 125 Dt', '[\"661,657,655,654,673,662,672,660,659,658,656,665,664,663,671,670,669,668,667,666\"]', '2019-10-10', 17, 'Wiza Narti', 1, NULL, NULL, 1, '2019-10-10 00:38:25', '2019-10-10 00:38:25'),
(154, 140, 'E - 128 Dt', '[\"674,680,676,678,684,683,681\"]', '2019-10-10', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-10 05:39:14', '2019-10-10 05:39:14'),
(155, 138, 'E - 126 Dt', '[\"677\"]', '2019-10-10', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-10 05:40:24', '2019-10-10 05:40:24'),
(156, 138, 'E - 126 Dt', '[null]', '2019-10-09', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-10 05:45:14', '2019-10-10 05:45:14'),
(157, 153, 'E - 140 Dt', '[\"750,749\"]', '2019-10-10', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-10 05:45:48', '2019-10-10 05:47:18'),
(158, 154, 'E - 141 Dt', '[\"748\"]', '2019-10-10', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-10 05:46:40', '2019-10-10 05:46:40'),
(159, 139, 'E - 127 Dt', '[\"685,679,682\"]', '2019-10-10', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-10 06:01:38', '2019-10-10 06:01:38'),
(160, 155, 'E - 142 Dt', '[\"747\"]', '2019-10-11', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-11 02:34:20', '2019-10-11 02:34:20'),
(161, 138, 'E - 126 Dt', '[\"675\"]', '2019-10-11', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-11 02:34:52', '2019-10-11 02:34:52'),
(162, 162, 'E - 148 Dt', '[\"811\"]', '2019-10-11', 18, 'Abdurrahim', 1, NULL, NULL, 1, '2019-10-11 07:17:45', '2019-10-11 07:17:45'),
(164, 158, 'E - 145 Dt', '[\"788\"]', '2019-10-16', 17, 'Muradi', 1, NULL, NULL, 1, '2019-10-16 08:13:15', '2019-10-16 08:13:15'),
(165, 163, 'E - 149 Dt', '[\"812\"]', '2019-10-17', 18, 'Fauzan', 1, NULL, NULL, 1, '2019-10-17 05:56:03', '2019-10-17 06:05:40'),
(166, 125, 'E - 115 Dt', '[\"617\"]', '2019-10-18', 17, 'Sari', 1, NULL, NULL, 1, '2019-10-18 03:06:32', '2019-10-18 03:06:32'),
(167, 142, 'E - 130 Dt', '[\"704,706,705,711,710,709,701,700,699,708,707,703,702\"]', '2019-10-22', 18, 'Gono', 1, NULL, NULL, 1, '2019-10-18 08:39:58', '2019-10-22 05:35:58'),
(168, 145, 'E - 132 Dt', '[\"718,720,719,717,716,715\"]', '2019-10-29', 18, 'Basuki Rahmad', 1, NULL, NULL, 1, '2019-10-18 08:46:59', '2019-10-29 03:52:17'),
(169, 146, 'E - 133 Dt', '[\"722,721\"]', '2019-10-29', 18, 'Basuki Rahmad', 1, NULL, NULL, 1, '2019-10-18 08:49:59', '2019-10-29 03:52:04'),
(170, 147, 'E - 134 Dt', '[\"727,726,725,724,723,728\"]', '2019-10-29', 18, 'Basuki Rahmad', 1, NULL, NULL, 1, '2019-10-18 08:52:54', '2019-10-29 03:51:48'),
(171, 148, 'E - 135 Dt', '[\"729\"]', '2019-10-29', 18, 'Basuki Rahmad', 1, NULL, NULL, 1, '2019-10-18 08:58:55', '2019-10-29 03:51:37'),
(172, 149, 'E - 136 Dt', '[\"733,732,731,730\"]', '2019-10-29', 18, 'Basuki Rahmad', 1, NULL, NULL, 1, '2019-10-18 09:02:06', '2019-10-29 03:51:23'),
(173, 150, 'E - 137 Dt', '[\"734,737,736,735,746,739,738\"]', '2019-10-29', 18, 'Basuki Rahmad', 1, NULL, NULL, 1, '2019-10-18 09:10:34', '2019-10-29 03:51:12'),
(174, 150, 'E - 137 Dt', '[null]', '2019-10-29', 18, 'Basuki Rahmad', 1, NULL, NULL, 1, '2019-10-18 09:16:09', '2019-10-29 03:51:02'),
(175, 152, 'E - 139 Dt', '[\"745,744,743\"]', '2019-10-29', 18, 'Basuki Rahmad', 1, NULL, NULL, 1, '2019-10-18 09:20:59', '2019-10-29 03:50:42'),
(176, 159, 'E - 146 Dt', '[\"790,789\"]', '2019-10-21', 18, 'Aulia Rahman', 1, NULL, NULL, 1, '2019-10-18 09:27:56', '2019-10-18 09:27:56'),
(177, 167, 'E - 153 Dt', '[\"825\"]', '2019-10-23', 17, 'Fauzan', 1, NULL, NULL, 1, '2019-10-23 05:15:29', '2019-10-23 05:15:29'),
(178, 172, 'E - 158 Dt', '[\"845,848,844,846,843,847,842,841,840,839\"]', '2019-10-24', 17, 'Taufikku Rahman', 1, NULL, NULL, 1, '2019-10-24 05:03:46', '2019-10-24 05:03:46'),
(179, 176, 'E - 161 Dt', '[\"852,854,853\"]', '2019-10-24', 17, 'Taufikku Rahman', 1, NULL, NULL, 1, '2019-10-24 05:04:15', '2019-10-24 05:04:15'),
(180, 171, 'E -157 Dt', '[\"865\"]', '2019-10-25', 17, 'dikirim', 1, NULL, NULL, 1, '2019-10-24 23:59:32', '2019-10-24 23:59:32'),
(181, 156, 'E - 143 Dt', '[\"755,765,774,754,753,752,751,773,763,764,761,772,759,757,756,762,760,769,768\"]', '2019-10-24', 17, '-', 1, NULL, NULL, 1, '2019-10-25 01:33:34', '2019-10-25 01:33:34'),
(182, 156, 'E - 143 Dt', '[\"755,765,774,751,754,753,752,773,763,761,764,772,762,760,759,757,756,769,768\"]', '2019-10-25', 17, 'Harzan', 1, NULL, NULL, 1, '2019-10-25 01:47:16', '2019-10-25 01:47:16'),
(183, 168, 'E-154 Dt', '[\"826\"]', '2019-10-28', 17, 'Agus Mujahidin', 1, NULL, NULL, 1, '2019-10-28 03:47:28', '2019-10-28 03:47:28'),
(184, 169, 'E - 155 Dt', '[\"827\"]', '2019-10-28', 17, 'Agus Mujahidin', 1, NULL, NULL, 1, '2019-10-28 03:48:07', '2019-10-28 03:48:07'),
(185, 165, 'E - 151 Dt', '[\"821,822\"]', '2019-10-28', 17, 'Dewi Badriati', 1, NULL, NULL, 1, '2019-10-28 03:55:36', '2019-10-28 03:55:36'),
(186, 157, 'E - 144 Dt', '[\"777,782,786,784,783,779,778,781,780,785,776,775,787\"]', '2019-10-28', 17, 'Ridha Rahmatullah', 1, NULL, NULL, 1, '2019-10-28 03:56:26', '2019-10-28 03:56:26'),
(187, 151, 'E - 138 Dt', '[\"742,741,740\"]', '2019-10-29', 18, 'Basuki Rahmad', 1, NULL, NULL, 1, '2019-10-29 03:56:54', '2019-10-29 03:56:54'),
(188, 182, 'E - 165 Dt', '[\"869\"]', '2019-10-30', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-10-30 05:23:58', '2019-10-30 05:23:58'),
(189, 175, 'E - 160 Dt', '[\"851\"]', '2019-11-07', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-11-05 02:31:36', '2019-11-07 02:29:06'),
(190, 166, 'E - 152 Dt', '[\"823,824\"]', '2019-11-07', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-11-05 02:31:52', '2019-11-07 02:22:40'),
(191, 179, 'E - 164 Dt', '[\"866\"]', '2019-11-08', 18, 'Muhammd Irwan', 1, NULL, NULL, 1, '2019-11-08 01:50:16', '2019-11-08 01:50:16'),
(192, 185, 'E - 170 Dt', '[\"891\"]', '2019-11-11', 17, 'Fajar', 1, NULL, NULL, 1, '2019-11-11 00:10:30', '2019-11-11 00:11:15'),
(193, 189, 'E - 172 Dt', '[\"915,917,916\"]', '2019-11-11', 17, 'Dwi Noriyati', 1, NULL, NULL, 1, '2019-11-11 03:21:45', '2019-11-11 03:21:45'),
(194, 170, 'E - 156 Dt', '[\"828,835,832,833,834,831,829,830,837,836,838\"]', '2019-11-12', 18, 'Yuni', 1, NULL, NULL, 1, '2019-11-11 08:46:39', '2019-11-12 06:57:19'),
(196, 164, 'E - 150 Dt', '[\"818,820,815,814,816,817,819,813\"]', '2019-11-12', 18, 'Qulsum', 1, NULL, NULL, 1, '2019-11-12 05:26:04', '2019-11-12 05:26:04'),
(197, 161, 'E - 147 Dt', '[\"809,806,794,793,792,800,796,791,810,808,797,795,804,807,805,803,802,801,799,798\"]', '2019-12-04', 18, 'Dikirim', 1, NULL, NULL, NULL, '2019-11-12 06:40:02', '2019-12-04 07:44:06'),
(198, 191, 'E - 174 Dt', '[\"919\"]', '2019-11-13', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-11-13 01:41:29', '2019-11-13 01:41:29'),
(199, 186, 'E - 168 Dt', '[\"900,899,898,897,892,901,896,895,894,893\"]', '2019-11-14', 18, 'Dikirim', 1, NULL, NULL, NULL, '2019-11-14 01:24:20', '2019-11-14 01:27:22'),
(200, 188, 'E - 169 Dt', '[\"902,908,907,906,905,904,903\"]', '2019-11-14', 18, 'Dikirim', 1, NULL, NULL, NULL, '2019-11-14 01:27:12', '2019-11-14 01:27:12'),
(201, 187, 'E - 171 Dt', '[\"911,909,910,914,912,913\"]', '2019-11-15', 17, 'Eka', 1, NULL, NULL, 1, '2019-11-15 07:27:29', '2019-11-15 07:27:29'),
(202, 183, 'E - 166 Dt', '[\"872,874,870,871,873\"]', '2019-11-18', 18, 'Halfian', 1, NULL, NULL, 1, '2019-11-18 02:40:57', '2019-11-18 02:40:57'),
(203, 174, 'E - 159 Dt', '[\"850,849\"]', '2019-11-25', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-11-22 04:47:17', '2019-11-25 02:15:22'),
(204, 190, 'E - 173 Dt', '[\"918\"]', '2019-11-27', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-11-27 01:54:10', '2019-11-27 01:54:10'),
(205, 202, 'E - 185 Dt', '[\"967,965,963\"]', '2019-11-29', 17, 'Budi Wijaya', 1, NULL, NULL, 1, '2019-11-29 06:16:48', '2019-11-29 06:16:48'),
(206, 194, 'E - 177 Dt', '[\"935\"]', '2019-12-02', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-12-02 03:17:24', '2019-12-02 03:17:24'),
(207, 195, 'E - 178 Dt', '[\"937\"]', '2019-12-02', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-12-02 03:39:01', '2019-12-02 03:39:01'),
(208, 196, 'E - 179 Dt', '[\"938\"]', '2019-12-02', 17, 'Muhammad Irwan', NULL, NULL, 1, 1, '2019-12-02 03:39:52', '2019-12-02 03:39:52'),
(209, 201, 'E - 184 Dt', '[\"955\"]', '2019-12-02', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-12-02 03:42:28', '2019-12-02 03:42:28'),
(210, 177, 'E - 162 Dt', '[\"860,859,858,857,856,861,855\"]', '2019-12-05', 18, 'Hj. Andriyani A.Md. Farm', 1, NULL, NULL, 1, '2019-12-05 05:55:11', '2019-12-05 05:58:06'),
(211, 178, 'E - 163 Dt', '[\"863,862,864\"]', '2019-12-05', 18, 'Hj. Andriyani A.Md. Farm', 1, NULL, NULL, 1, '2019-12-05 05:55:31', '2019-12-05 05:58:22'),
(212, 192, 'E - 175 Dt', '[\"921,920\"]', '2019-12-06', 17, 'Heffy Erlina', 1, NULL, NULL, 1, '2019-12-06 07:16:51', '2019-12-06 07:16:51'),
(213, 198, 'E - 181 Dt', '[\"945,948,949,946,944,947\"]', '2019-12-12', 18, 'dikirim', 1, NULL, NULL, 1, '2019-12-12 00:42:17', '2019-12-12 00:42:17'),
(214, 200, 'E - 183 Dt', '[\"953,954\"]', '2019-12-12', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-12-12 03:17:40', '2019-12-12 03:17:40'),
(215, 209, 'E - 192 Dt', '[\"1003,1002\"]', '2019-12-13', 17, 'Fajar', 1, NULL, NULL, 1, '2019-12-13 00:52:53', '2019-12-13 00:57:12'),
(216, 199, 'E - 182 Dt', '[\"952,951,950\"]', '2019-12-16', 17, 'Dikirim', 1, NULL, NULL, NULL, '2019-12-16 01:36:06', '2019-12-16 01:36:06'),
(217, 184, 'E - 167 Dt', '[\"881,885,887,886,875,883,882,880,879,890,878,877,876,889,888\"]', '2019-12-19', 17, 'Ardiansyah', 1, 1, NULL, 1, '2019-12-19 01:34:16', '2019-12-19 01:34:16'),
(218, 202, 'E - 185 Dt', '[\"961,960,958,957,956,966,964,962,959,969,968\"]', '2019-12-19', 17, 'Budi', 1, NULL, NULL, 1, '2019-12-19 02:16:51', '2019-12-19 02:16:51'),
(219, 208, 'E - 191 Dt', '[\"999,998,1000,997,996,995,994,993,992,1001\"]', '2019-12-20', 18, 'Alda Surahmah A. Md', 1, NULL, NULL, 1, '2019-12-20 02:54:24', '2019-12-20 02:54:24'),
(220, 214, 'E - 197 Dt', '[\"1024,1023,1022,1020,1025,1021,1019,1018\"]', '2019-12-20', 18, 'Rahmat', 1, NULL, NULL, 1, '2019-12-20 06:33:39', '2019-12-20 06:33:39'),
(221, 193, 'E - 176 Dt', '[\"933,929,922,930,932,931,934,923,925,928,927,924\"]', '2019-12-23', 18, 'Yuni', 1, 1, NULL, 1, '2019-12-23 04:33:53', '2019-12-23 04:33:53'),
(222, 197, 'E - 180 Dt', '[\"939,941,942,940,943\"]', '2019-12-23', 18, 'Yuni', 1, 1, NULL, 1, '2019-12-23 04:34:12', '2019-12-23 04:34:12'),
(223, 210, 'E - 193 Dt', '[\"1012,1004,1009,1010,1008,1006,1011,1005\"]', '2019-12-26', 17, 'dikirim', 1, NULL, NULL, NULL, '2019-12-26 01:49:41', '2019-12-26 01:49:41'),
(224, 213, 'E - 196 Dt', '[\"1017\"]', '2019-12-27', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2019-12-27 02:13:10', '2019-12-27 02:13:10'),
(225, 215, 'E - 198 Dt', '[\"1034,1033,1038,1037,1036,1035,1031,1041,1040,1039,1043,1042,1032,1030,1029,1028,1027,1026\"]', '2019-12-27', 18, 'Dewi', 1, NULL, NULL, 1, '2019-12-27 06:08:23', '2019-12-27 06:08:48'),
(228, 204, 'E - 187 Dt', '[\"977,981,980,979,978,982\"]', '2020-01-06', 17, 'Dikirim', 1, NULL, NULL, NULL, '2020-01-06 07:31:23', '2020-01-06 07:31:23'),
(229, 205, 'E - 188 Dt', '[\"983,984\"]', '2020-01-06', 17, 'Dikirim', 1, NULL, NULL, NULL, '2020-01-06 07:32:20', '2020-01-06 07:32:20'),
(230, 206, 'E - 189 Dt', '[\"985,988,987,989,986\"]', '2020-01-06', 17, 'Dikirim', 1, NULL, NULL, NULL, '2020-01-06 07:32:42', '2020-01-06 07:32:42'),
(231, 207, 'E - 190 Dt', '[\"990,991\"]', '2020-01-06', 18, 'Dikirim', 1, NULL, NULL, NULL, '2020-01-06 07:35:46', '2020-01-06 07:35:46'),
(232, 211, 'E - 194 Dt', '[\"1013,1015,1014\"]', '2020-01-06', 18, 'Dikirim', 1, NULL, NULL, NULL, '2020-01-06 08:03:59', '2020-01-06 08:03:59'),
(233, 212, 'E - 195 Dt', '[\"1016\"]', '2020-01-06', 18, 'Dikirim', 1, NULL, NULL, NULL, '2020-01-06 08:05:45', '2020-01-06 08:05:45'),
(234, 219, 'E - 002 Dt', '[\"1046\"]', '2020-01-15', 17, 'Kasripin', 1, NULL, NULL, 1, '2020-01-20 00:31:47', '2020-01-20 00:31:47'),
(235, 203, 'E - 186 Dt', '[\"970,976,971,972,975,974,973\"]', '2020-01-17', 18, 'Daniel', 1, NULL, NULL, 1, '2020-01-20 00:37:59', '2020-01-20 00:37:59'),
(236, 220, 'E - 003 Dt', '[\"1047,1050,1049,1048,1055,1054,1053,1052,1051\"]', '2020-01-21', 17, 'dr. Edward', 1, NULL, NULL, 1, '2020-01-21 04:17:57', '2020-01-21 04:17:57'),
(237, 221, 'E - 004 Dt', '[\"1057\"]', '2020-01-21', 18, 'Dr. Edward', 1, NULL, NULL, 1, '2020-01-21 05:42:44', '2020-01-21 05:42:44'),
(238, 222, 'E - 005 Dt', '[\"1059,1060,1058,1067,1065,1064,1061\"]', '2020-01-24', 17, 'Hadi Sungkono', 1, NULL, NULL, 1, '2020-01-24 05:54:00', '2020-01-24 05:54:00'),
(239, 222, 'E - 005 Dt', '[\"1071,1070,1069\"]', '2020-01-28', 17, 'Dikirim', 1, NULL, NULL, NULL, '2020-01-28 06:56:03', '2020-01-28 06:56:03'),
(240, 223, 'E - 006 Dt', '[\"1072,1074,1073\"]', '2020-02-06', 17, 'Saiful Bahri', 1, NULL, NULL, 1, '2020-02-06 04:58:29', '2020-02-06 04:58:29'),
(241, 226, 'E - 008 Dt', '[\"1081,1080,1079,1078\"]', '2020-02-25', 18, 'Fauzan', 1, NULL, NULL, 1, '2020-02-25 05:36:55', '2020-02-25 05:36:55'),
(242, 229, 'E - 011 Dt', '[\"1089,1088,1087,1086,1091,1090,1093,1092\"]', '2020-02-26', 18, 'Arief Pramono', 1, 1, NULL, 1, '2020-02-26 02:46:54', '2020-02-26 02:46:54'),
(245, 234, 'E - 016 Dt', '[\"1111,1112,1114,1113\"]', '2020-03-03', 18, 'Hamdan Burhanuddin', 1, NULL, NULL, 1, '2020-03-03 03:36:20', '2020-03-03 03:36:20'),
(246, 235, 'E - 017 Dt', '[\"1116,1118,1117,1121,1120,1119\"]', '2020-03-05', 17, '-', 1, NULL, NULL, 1, '2020-03-05 00:58:29', '2020-03-05 00:58:29'),
(247, 236, '236', '[\"1122,1126,1123,1124,1128,1125\"]', '2020-03-18', 17, '-', 1, NULL, NULL, 1, '2020-03-06 04:06:05', '2020-03-18 02:50:17'),
(248, 237, 'E - 019 Dt', '[\"1131,1130,1129,1133,1132\"]', '2020-03-06', 18, 'Iptu Pangat Supriyadi', 1, NULL, NULL, 1, '2020-03-06 08:56:49', '2020-03-06 08:56:49'),
(249, 228, 'E - 010 Dt', '[\"1084,1085\"]', '2020-03-09', 17, '-', 1, NULL, NULL, 1, '2020-03-09 03:12:05', '2020-03-09 03:12:05'),
(250, 233, 'E - 015 Dt', '[\"1109,1110\"]', '2020-03-10', 17, '-', 1, NULL, NULL, 1, '2020-03-10 03:19:27', '2020-03-10 03:19:27'),
(254, 230, 'E - 012 Dt', '[\"1096,1095,1099,1098,1097,1101,1100,1103,1094,1102\"]', '2020-03-11', 17, 'dikirim', 1, NULL, NULL, NULL, '2020-03-11 01:00:20', '2020-03-11 01:00:20'),
(255, 232, 'E - 014 Dt', '[\"1108,1107,1106\"]', '2020-03-17', 17, '-', 1, NULL, NULL, 1, '2020-03-17 01:49:55', '2020-03-17 01:49:55'),
(256, 227, 'E - 009 Dt', '[\"1083,1082\"]', '2020-02-27', 17, 'dikirim', 1, NULL, NULL, NULL, '2020-03-17 02:18:38', '2020-03-17 02:18:38'),
(257, 236, 'E - 018 Dt', '[\"1122,1126,1123,1124,1128,1125\"]', '2020-03-18', 28, '-', 1, 1, NULL, 1, '2020-03-18 03:12:41', '2020-03-18 03:12:41'),
(258, 231, 'E - 013 Dt', '[\"1105,1104\"]', '2020-03-19', 25, '-', 1, 1, NULL, 1, '2020-03-19 06:18:41', '2020-03-19 06:18:41'),
(260, 238, 'E - 020 Dt', '[\"1134\"]', '2020-03-19', 25, 'Fauzan', 1, NULL, NULL, 1, '2020-03-19 06:30:50', '2020-03-19 06:30:50'),
(261, 239, 'E - 021 Dt', '[\"1135\"]', '2020-03-20', 17, 'Aries', 1, NULL, NULL, 1, '2020-03-20 01:39:36', '2020-03-20 01:39:36'),
(263, 240, 'E - 022 Dt', '[\"1136\"]', '2020-04-08', 18, '-', 1, NULL, NULL, 1, '2020-04-08 03:23:19', '2020-04-08 03:23:19'),
(269, 246, 'E - 028 Dt', '[\"1165,1157\"]', '2020-06-25', 18, 'Maulana', 1, NULL, NULL, 1, '2020-06-25 07:28:22', '2020-06-25 07:28:22'),
(271, 249, 'E - 031 Dt', '[\"1187\"]', '2020-07-01', 18, 'dikirim', 1, NULL, NULL, NULL, '2020-06-30 01:09:38', '2020-06-30 01:09:38'),
(272, 247, 'E - 029 Dt', '[\"1186\"]', '2020-06-30', 18, 'Irwan', 1, NULL, NULL, 1, '2020-06-30 03:13:53', '2020-06-30 03:13:53'),
(273, 245, 'E - 027 Dt', '[\"1162,1169,1158\"]', '2020-06-30', 18, 'Irwan', 1, NULL, NULL, 1, '2020-06-30 03:15:13', '2020-06-30 03:15:13'),
(274, 244, 'E - 026 Dt', '[\"1150,1151,1153,1152,1156\"]', '2020-06-30', 18, 'Irwan', 1, NULL, NULL, 1, '2020-06-30 03:22:37', '2020-06-30 03:22:37'),
(275, 241, 'E - 023 Dt', '[\"1159,1146,1145,1138,1137,1147,1144,1141,1140,1143\"]', '2020-06-30', 18, 'Irwan', 1, NULL, NULL, 1, '2020-06-30 03:24:52', '2020-06-30 03:24:52'),
(276, 242, 'E - 024 Dt', '[\"1166,1149,1168,1163\"]', '2020-06-30', 18, 'Irwan', 1, NULL, NULL, 1, '2020-06-30 03:26:39', '2020-06-30 03:26:39'),
(277, 243, 'E - 025 Dt', '[\"1161,1160\"]', '2020-06-30', 18, 'Irwan', 1, NULL, NULL, 1, '2020-06-30 03:28:12', '2020-06-30 03:28:12'),
(279, 250, 'E - 032 Dt', '[\"1193,1196,1195,1194,1209,1192,1191,1190,1189,1188,1197\"]', '2020-07-14', 17, 'Dikirim', 1, NULL, NULL, NULL, '2020-07-14 02:03:28', '2020-07-14 02:03:28'),
(281, 252, 'E - 034 Dt', '[\"1210\"]', '2020-07-28', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2020-07-28 02:44:12', '2020-07-28 02:44:12'),
(282, 251, 'E - 033 Dt', '[\"1199,1208,1207,1206,1205,1204,1203,1202,1201,1200\"]', '2020-07-30', 17, 'dikirim', 1, 1, NULL, NULL, '2020-07-30 01:23:05', '2020-07-30 01:23:05'),
(284, 255, 'E - 037 Dt', '[\"1224,1220,1223,1222,1221\"]', '2020-07-30', 18, '-', 1, NULL, NULL, 1, '2020-07-30 04:22:27', '2020-07-30 04:22:27'),
(285, 253, 'E - 035 Dt', '[\"1216,1215,1214,1212,1213,1211\"]', '2020-08-06', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2020-08-06 03:19:17', '2020-08-06 03:19:17'),
(286, 248, 'E - 030 Dt', '[\"1174,1184,1183,1185,1175,1179,1178,1177,1181,1180,1173,1182,1172,1171,1170,1176\"]', '2020-08-11', 17, '-', 1, NULL, NULL, 1, '2020-08-11 00:23:55', '2020-08-11 00:23:55'),
(287, 254, 'E - 036 Dt', '[\"1219,1217,1218\"]', '2020-08-11', 17, '-', 1, NULL, NULL, 1, '2020-08-11 00:36:12', '2020-08-11 00:36:12'),
(288, 256, 'E - 038 Dt', '[\"1231,1229,1228,1230,1226,1225,1227\"]', '2020-08-14', 18, 'dikirim', 1, NULL, NULL, NULL, '2020-08-14 06:37:13', '2020-08-14 06:37:13'),
(289, 274, 'E - 053 Dt', '[\"1342\"]', '2020-08-19', 17, 'Linda', 1, NULL, NULL, 1, '2020-08-19 04:02:43', '2020-08-19 04:02:43'),
(290, 273, 'E - 054 Dt', '[\"1336,1335,1334,1333,1338\"]', '2020-08-24', 17, 'dikirim', 1, NULL, NULL, NULL, '2020-08-24 03:17:56', '2020-08-24 03:17:56'),
(291, 271, 'E - 052 Dt', '[\"1305,1304,1306,1307\"]', '2020-08-25', 18, '-', 1, 1, NULL, 1, '2020-08-25 03:53:49', '2020-08-25 03:53:49'),
(292, 270, 'E - 051 Dt', '[\"1356,1371,1366,1365,1364,1352,1351,1375,1378,1377,1379,1370,1355,1369,1372,1363,1362,1357,1361,1360,1359,1358,1376,1368,1367,1345,1350,1349,1348,1347,1346,1353,1373,1374\"]', '2020-08-27', 17, 'Joko', 1, NULL, NULL, 1, '2020-08-27 01:20:10', '2020-08-27 01:20:10'),
(293, 276, 'E - 056 Dt', '[\"1401\"]', '2020-08-27', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2020-08-27 04:26:20', '2020-08-27 04:26:20'),
(296, 278, 'E - 058 Dt', '[\"1406,1410,1407,1409,1408\"]', '2020-08-28', 18, 'Muhammad Irwan (Dikirim)', 1, NULL, NULL, NULL, '2020-08-28 02:17:09', '2020-08-28 02:17:09'),
(297, 277, 'E - 057 Dt', '[\"1403,1402,1405,1404\"]', '2020-08-28', 18, 'Muhammad Irwan (Dikirim)', 1, NULL, NULL, NULL, '2020-08-28 02:19:34', '2020-08-28 02:19:34'),
(298, 281, 'E - 059 Dt', '[\"1412,1414,1411,1413\"]', '2020-08-28', 18, 'Muhammad Irwan (Dikirim)', 1, NULL, NULL, NULL, '2020-08-28 02:20:31', '2020-08-28 02:20:31'),
(300, 276, 'E - 056 Dt', '[\"1399,1394,1396,1395,1398,1397\"]', '2020-08-28', 18, 'Muhammad Irwan (Dikirim)', 1, NULL, NULL, NULL, '2020-08-28 02:21:56', '2020-08-28 02:21:56'),
(301, 257, 'E - 039 Dt', '[\"1232,1238,1237,1236,1235,1234,1233,1239\"]', '2020-08-28', 18, 'Tiwi', 1, NULL, NULL, 1, '2020-08-28 05:44:33', '2020-08-28 05:44:33'),
(302, 282, 'E - 060 Dt', '[\"1416,1419,1417,1415\"]', '2020-08-28', 18, 'Dikirim', 1, NULL, NULL, NULL, '2020-08-28 08:57:39', '2020-08-28 08:57:39'),
(303, 258, 'E - 040 Dt', '[\"1240\"]', '2020-08-31', 17, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:37:49', '2020-08-31 01:37:49'),
(304, 259, 'E - 041 Dt', '[\"1243,1309,1308,1245,1244,1241,1242\"]', '2020-08-31', 17, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:39:15', '2020-08-31 01:39:15'),
(305, 272, 'E - 042 Dt', '[\"1318,1319,1320,1321\"]', '2020-08-31', 17, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:39:38', '2020-08-31 01:39:38'),
(306, 262, 'E - 043 Dt', '[\"1249,1252,1246,1247,1248,1253,1250,1251\"]', '2020-08-31', 17, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:42:27', '2020-08-31 01:42:27'),
(307, 263, 'E - 044 Dt', '[\"1262,1261,1260,1259,1258,1255\"]', '2020-08-31', 18, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:43:31', '2020-08-31 01:43:31'),
(308, 264, 'E - 045 Dt', '[\"1297,1298,1299,1303,1312,1311,1302,1301,1300\"]', '2020-08-31', 18, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:44:11', '2020-08-31 01:44:11'),
(309, 265, 'E - 046 Dt', '[\"1266,1264,1263,1282,1265,1310\"]', '2020-08-31', 18, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:45:27', '2020-08-31 01:45:27'),
(310, 266, 'E - 047 Dt', '[\"1271,1274,1272,1315,1313,1341,1269,1268,1267,1344,1343,1275\"]', '2020-08-31', 18, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:46:10', '2020-08-31 01:46:10'),
(314, 267, 'E - 048 Dt', '[\"1316,1276,1277\"]', '2020-08-31', 18, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:49:21', '2020-08-31 01:49:21'),
(315, 268, 'E - 049 dT', '[\"1278,1279,1280,1281\"]', '2020-08-31', 18, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:50:05', '2020-08-31 01:50:05'),
(316, 269, 'E - 050 Dt', '[\"1289,1283,1284,1285,1286,1288,1287,1290,1291\"]', '2020-08-31', 18, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 01:51:48', '2020-08-31 01:51:48'),
(317, 284, 'E - 062 Dt', '[\"1426\"]', '2020-08-31', 17, 'Susanti', 1, NULL, NULL, 1, '2020-08-31 03:42:19', '2020-08-31 03:42:19'),
(318, 283, 'E - 061 Dt', '[\"1424,1423,1421,1420,1425,1422\"]', '2020-09-03', 18, '-', 1, NULL, NULL, 1, '2020-09-03 05:58:02', '2020-09-03 05:58:02'),
(319, 286, 'E - 064 Dt', '[\"1428\"]', '2020-09-08', 18, 'Muhammad Irwan', 1, NULL, NULL, 1, '2020-09-08 03:09:19', '2020-09-08 03:09:19'),
(320, 285, 'E - 063 Dt', '[\"1427\"]', '2020-09-09', 17, 'dikirim', 1, NULL, NULL, NULL, '2020-09-09 05:55:24', '2020-09-09 05:55:24'),
(321, 275, 'E - 055 Dt', '[\"1388,1391,1393,1389,1392,1387,1385,1384,1383,1382,1386,1380,1390\"]', '2020-09-09', 17, 'Dikirim', 1, NULL, NULL, NULL, '2020-09-09 05:57:42', '2020-09-09 05:57:42'),
(322, 276, 'E - 056 Dt', '[\"1400\"]', '2020-09-09', 17, 'dikirim', 1, NULL, NULL, NULL, '2020-09-09 05:58:44', '2020-09-09 05:58:44'),
(324, 224, 'E - 007 Dt', '[\"1077,1076\"]', '2020-09-10', 17, 'Sari', 1, 1, NULL, 1, '2020-09-10 01:27:58', '2020-09-10 01:27:58'),
(326, 295, 'E - 073 Dt', '[\"1431,1441,1440,1438,1430\"]', '2020-09-11', 17, 'dikirim', 1, NULL, NULL, NULL, '2020-09-11 09:25:00', '2020-09-11 09:25:00'),
(327, 287, 'E - 065 Dt', '[\"1429\"]', '2020-09-17', 17, 'Cahyo', 1, NULL, NULL, 1, '2020-09-17 04:51:44', '2020-09-17 04:51:44'),
(328, 298, 'E - 076 Dt', '[\"1499,1498,1497,1496,1495,1494,1493,1492,1502,1501,1500,1503,1505,1504\"]', '2020-09-23', 17, 'Titi Fajriati', 1, NULL, NULL, 1, '2020-09-23 03:18:25', '2020-09-23 03:18:25'),
(329, 294, 'E - 072 Dt', '[\"1481,1480,1479,1478\"]', '2020-09-23', 17, 'Mariyatul', 1, NULL, NULL, 1, '2020-09-23 03:32:28', '2020-09-23 03:32:28'),
(330, 297, 'E - 075 Dt', '[\"1524,1523,1522,1529,1528,1519,1521,1520,1532,1525,1517,1516,1515,1514,1513,1512,1511,1510,1509,1518,1531,1530,1527,1526,1533\"]', '2020-09-24', 18, 'Erlita Astuti', 1, NULL, NULL, 1, '2020-09-24 00:45:37', '2020-09-24 00:45:37'),
(334, 300, 'E - 078 Dt', '[\"1537,1536,1538\"]', '2020-09-24', 22, 'AL', 1, NULL, NULL, 1, '2020-09-24 05:28:25', '2020-09-24 05:28:25'),
(335, 296, 'E - 074 Dt', '[\"1534,1491,1490,1488,1487,1486,1485,1489,1484,1483,1482\"]', '2020-09-24', 18, 'Mustafa', 1, NULL, NULL, 1, '2020-09-24 06:40:18', '2020-09-24 06:40:18'),
(336, 301, 'E - 079 Dt', '[\"1539\"]', '2020-09-29', 17, 'Yatin', 1, NULL, NULL, 1, '2020-09-29 05:47:40', '2020-09-29 05:47:40'),
(337, 304, 'E - 087 Dt', '[\"1569,1561,1570,1563,1562,1565,1564,1568,1567,1566\"]', '2020-10-02', 17, 'Anto Wibowo', 1, NULL, NULL, 1, '2020-10-02 02:55:42', '2020-10-02 02:55:42'),
(338, 302, 'E - 080 Dt', '[\"1540,1541\"]', '2020-10-02', 17, 'Ibnu Saib', 1, NULL, NULL, 1, '2020-10-02 06:02:22', '2020-10-02 06:02:22'),
(339, 317, 'E - 095 Dt', '[\"1677,1676,1668,1666,1664,1663,1671,1675,1674,1673,1672,1658,1661,1660,1659,1670,1669,1667\"]', '2020-10-02', 18, 'Iwan', 1, NULL, NULL, 1, '2020-10-02 06:47:22', '2020-10-02 06:47:22'),
(340, 303, 'E - 081 Dt', '[\"1547,1546,1545,1544,1543,1559,1542,1560,1548,1557,1553,1552,1551,1550,1558,1556,1555,1554,1549\"]', '2020-10-06', 17, 'Nadiah', 1, NULL, NULL, 1, '2020-10-06 02:53:18', '2020-10-06 02:53:18'),
(341, 334, 'E - 111 Dt', '[\"1734\"]', '2020-10-09', 18, 'Sukma', 1, NULL, NULL, 1, '2020-10-09 02:11:50', '2020-10-09 02:11:50'),
(342, 319, 'E - 097 Dt', '[\"1688,1690,1689,1691\"]', '2020-10-09', 17, 'Karim', 1, NULL, NULL, 1, '2020-10-09 08:08:57', '2020-10-09 08:08:57'),
(343, 318, 'E - 096 Dt', '[\"1678,1684,1682,1679,1681,1680,1683\"]', '2020-10-12', 17, 'Daniel', 1, NULL, NULL, 1, '2020-10-12 06:22:16', '2020-10-12 06:22:16'),
(344, 320, 'E - 098 Dt', '[\"1686,1685\"]', '2020-10-14', 18, 'Fajar', 1, NULL, NULL, 1, '2020-10-14 01:34:18', '2020-10-14 01:34:18'),
(345, 288, 'E - 066 Dt', '[\"1508,1507,1437,1436,1435,1432,1506,1442,1434,1433\"]', '2020-10-14', 17, 'Wiwin', 1, NULL, NULL, 1, '2020-10-14 03:44:19', '2020-10-14 03:44:19'),
(346, 289, 'E - 067 Dt', '[\"1443,1445,1444\"]', '2020-10-14', 17, 'Wiwin', 1, NULL, NULL, 1, '2020-10-14 03:44:49', '2020-10-14 03:44:49'),
(347, 290, 'E - 068 Dt', '[\"1446,1452,1451,1450,1449,1448,1447\"]', '2020-10-14', 17, 'Wiwin', 1, NULL, NULL, 1, '2020-10-14 03:45:36', '2020-10-14 03:45:36'),
(348, 291, 'E - 069 Dt', '[\"1453,1455,1454\"]', '2020-10-14', 17, 'Wiwin', 1, NULL, NULL, 1, '2020-10-14 03:46:07', '2020-10-14 03:46:07'),
(349, 292, 'E - 070 Dt', '[\"1460,1456,1457,1459,1458\"]', '2020-10-14', 17, 'Wiwin', 1, NULL, NULL, 1, '2020-10-14 03:46:33', '2020-10-14 03:46:33'),
(350, 293, 'E - 071 Dt', '[\"1472,1461,1471,1470,1469,1468,1467,1477,1466,1476,1465,1475,1464,1474,1463,1473,1462\"]', '2020-10-14', 17, 'Wiwin', 1, NULL, NULL, 1, '2020-10-14 03:47:04', '2020-10-14 03:47:04'),
(351, 305, 'E - 082 Dt', '[\"1571\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 07:57:45', '2020-10-15 07:57:45'),
(352, 306, 'E - 083 Dt', '[\"1572\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 07:58:04', '2020-10-15 07:58:04'),
(353, 307, 'E - 084 Dt', '[\"1598,1603,1583,1582,1581,1599,1585,1584,1593,1595,1594,1592,1590,1589,1588,1587,1586,1597,1596,1573,1580,1579,1578,1577,1576,1575,1602\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 07:58:20', '2020-10-15 07:58:20'),
(354, 308, 'E - 085 Dt', '[\"1604,1605\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 08:01:03', '2020-10-15 08:01:03'),
(355, 309, 'E - 086 Dt', '[\"1610,1608,1609,1607,1611,1606\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 08:01:14', '2020-10-15 08:01:14'),
(356, 310, 'E - 088 Dt', '[\"1619,1615,1618,1617,1616,1612,1613,1614\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 08:03:15', '2020-10-15 08:03:15'),
(357, 311, 'E - 089 Dt', '[\"1622,1621,1630,1629,1628,1627,1623,1626,1625,1624,1620\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 08:03:28', '2020-10-15 08:03:28'),
(358, 312, 'E - 090 Dt', '[\"1631,1633,1632\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 08:03:42', '2020-10-15 08:03:42'),
(359, 313, 'E - 091 Dt', '[\"1636,1638,1634,1635,1639,1640,1637\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 08:03:54', '2020-10-15 08:03:54'),
(360, 314, 'E - 092 Dt', '[\"1644,1643,1645,1646,1641,1642\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 08:04:06', '2020-10-15 08:04:06'),
(361, 315, 'E - 093 Dt', '[\"1649,1650,1648\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 08:04:22', '2020-10-15 08:04:22'),
(362, 316, 'E - 094 Dt', '[\"1653,1656,1655,1652\"]', '2020-10-15', 18, 'Fauzan Hakim', 1, NULL, NULL, 1, '2020-10-15 08:04:32', '2020-10-15 08:04:32'),
(363, 332, 'E - 109 Dt', '[\"1732,1730,1731\"]', '2020-10-20', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2020-10-20 02:19:03', '2020-10-20 02:19:03'),
(364, 342, 'E - 119 Dt', '[\"1766,1767\"]', '2020-10-26', 18, 'Dr. Widi', 1, NULL, NULL, 1, '2020-10-26 02:25:31', '2020-10-26 02:25:31'),
(365, 340, 'E - 117 Dt', '[\"1757,1755,1756\"]', '2020-11-02', 17, 'Muhammad Irwan', 1, NULL, NULL, 1, '2020-11-02 02:14:03', '2020-11-02 02:14:03'),
(367, 343, 'E - 120 Dt', '[\"1769,1768\"]', '2020-11-03', 18, 'drh. Arya T. Sarjananto', 1, NULL, NULL, 1, '2020-11-02 07:18:39', '2020-11-02 07:18:39'),
(368, 345, 'E - 121 Dt', '[\"1773,1772,1771,1770\"]', '2020-11-02', 17, 'Arif (dikirim)', 1, NULL, NULL, NULL, '2020-11-02 07:19:10', '2020-11-02 07:19:10');

-- --------------------------------------------------------

--
-- Table structure for table `lab_customer`
--

CREATE TABLE `lab_customer` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `pemilik` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setatus` int(11) NOT NULL DEFAULT '1',
  `jenis` int(11) DEFAULT NULL,
  `provinsi_id` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kabupaten_id` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telepon` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_order` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_customer`
--

INSERT INTO `lab_customer` (`id`, `id_order`, `pemilik`, `setatus`, `jenis`, `provinsi_id`, `kabupaten_id`, `alamat`, `telepon`, `cp`, `hp`, `no_order`, `created_at`, `updated_at`) VALUES
(3, 3, 'Laboratorium Klinik Kimia Farma Banjarbaru', 2, 6, '63', '6372', 'Jl. A. Yani KM. 34 No. 10, Banjarbaru', '0511-6749021', '-', '081528440581', 'E - 002 Dt', '2019-01-24 09:12:28', '2019-02-19 23:19:43'),
(4, 4, 'KLINIK TIRTA MEDICAL CENTRE BALIKPAPAN', 2, 6, '64', '6471', 'Jl. Ruhuy Rahayu RT.37 No.121 Kel. Gunung Bahagia Kec. Balikpapan Selatan', '-', 'Amalia Tanjung', '081375836328', 'E - 004 Dt', '2019-01-30 10:15:57', '2019-02-19 23:20:18'),
(5, 5, 'Mendawai Are Clinic', 2, 6, '64', '6471', 'JL. Letkol H. M. Asnawi Arbain Kel. Gunung Bahagia  RT. 45 No. 40 Balikpapan, Kalimantan Timur', '-', 'Basuki Rahmat', '081545719619', 'E - 005 Dt', '2019-02-03 11:04:37', '2019-02-19 23:20:45'),
(6, 6, 'PT E-TIRTA MEDICAL CENTRE', 2, 6, '62', '6205', 'Jl. Jendral Sudirman RT.017 Kel. Lanjas Kec. Teweh Tengah Kab. Barito Utara Kalimantan Tengah', '-', 'Sunusi', '081250435909', 'E - 006 Dt', '2019-02-05 09:49:33', '2019-02-19 23:21:13'),
(7, 7, 'Nur Huda', 2, 8, '63', '6372', 'Sungai Tiung RT 017 RW 006 Kel. Sungai Tiung, Kec. Cempaka, Kota Banjarbaru, Kalimantan Selatan', '085252677670', 'Nur Huda', '085252677670', 'E - 007 Dt', '2019-02-11 10:11:05', '2019-02-19 23:21:53'),
(8, 8, 'Yayasan Kesehatan Pegawai Telkom', 2, 3, '64', '6471', 'Jl. MT. Haryono No. 169, Balikpapan, Kalimantan Timur', '0542 875476 / 0542 875478', 'Fathur', '085246172300', 'E - 008 Dt', '2019-02-11 14:39:49', '2019-02-19 23:22:13'),
(9, 9, 'E-Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan Ir. P.H.M. Noor RT 001 Ruko 5,6,7 Kel. Mabuún , Kec. Murung Pudak, Kab. Tabalong. Kalimantan Selatan', '05262022882', 'Muhammad Irwan', '088705128452', 'E - 009 Dt', '2019-02-17 13:20:43', '2019-02-19 23:22:29'),
(11, 11, 'Polda Kalimantan Selatan', 1, 2, '63', '6371', 'Jl. D.I. Panjaitan No. 37, Banjarmasin, Kalimantan Selatan', '-', 'Arief Pramono', '0811506200', 'E - 010 Dt', '2019-02-18 12:07:10', '2019-02-19 23:22:42'),
(12, 12, 'BBTKLPP Banjarbaru', 1, 8, '63', '6372', 'Jalan H. Mistar Cokrokusumo No. 2A Banjarbaru', '0511-478043', 'Sari', '08115012781', 'E - 011 Dt', '2019-02-19 14:07:50', '2019-02-19 23:27:22'),
(14, 14, 'Tirta Medical Centre Balikpapan', 2, 6, '64', '6471', 'Jl. Ruhui Rahayu RT.37, Kel. Gunung Bahagia, Kec. Balikpapan Selatan, Balikpapan, Kalimantan Timur', '081348583141', 'Muhammad Irwan', '088705128452', 'E - 012 Dt', '2019-02-24 21:05:30', '2019-03-03 18:10:33'),
(15, 15, 'Klinik Permata Bunda', 2, 6, '63', '6310', 'Jl. Provinsi Rt. 02 RW 01 Desa Mekar Jaya Kec. Angsana Kab. Tanah Bumbu, Kalimantan Selatan', '085350844873', 'Bara Rianto', '081386284312', 'E - 013 Dt', '2019-02-27 00:38:26', '2019-02-27 00:38:26'),
(16, 16, 'UPT. Puskesmas Martapura', 1, 5, '63', '6303', 'Jalan Puskesmas No. 22', '-', 'Wiza Narti', '085248195544', 'E - 014 Dt', '2019-03-03 22:21:37', '2019-03-20 20:07:57'),
(17, 17, 'Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan Ir. P.H.M. Noor RT 001 Ruko 5,6,7. Kel. Mabuún, Kec. Murung Pudak', '05262022882', 'Muhammad Irwan', '088705128452', 'E - 015 Dt', '2019-03-05 21:18:14', '2019-03-05 21:18:14'),
(18, 18, 'Tirta Medical Centre Berau', 2, NULL, '64', '6405', 'Jalan Pulau Semama No. 785 RT 08 Tanjung Redep, Berau', '055422010', 'Muhammad Irwan', '088705128452', 'E - 016 Dt', '2019-03-05 21:22:22', '2019-03-05 21:22:22'),
(19, 19, 'Klinik Permata Bunda', 2, 6, '63', '6310', 'Jalan Provinsi RT.9/03 Desa Sungai Cuka Kec. Satui Kab. Tanah Bumbu', '-', 'Bara Riyanto', '-', 'E - 017 Dt', '2019-03-07 23:45:38', '2019-03-07 23:57:39'),
(20, 20, 'Tirta Medical Centre Muara Teweh', 2, 6, '62', '6205', 'Jalan Jendral Sudirman RT. 017, Kel. Lanjas, Kec. Teweh Tengah, Kab. Barito Utara, Kalimantan Tengah', '-', 'Muhammad Irwan', '088705128452', 'E - 018 Dt', '2019-03-13 17:37:02', '2019-03-13 17:38:45'),
(21, 21, 'Rumah Sakit Islam Banjarmasin', 2, 4, '63', '6371', 'Jalan Letjend S. Parman No. 88 Banjarmasin Kalimantan Selatan', '05113354896/05113350332/05113350335', 'Mira', '083150405882', 'E - 019 Dt', '2019-03-13 19:10:21', '2019-03-13 19:26:40'),
(22, 22, 'Klinik Panacea', 2, 6, '64', '6471', 'Komp. Mall Balikpapan Baru, Blok AB 2, No. 17-20,25, Balikpapan, Kalimantan Timur, Indonesia', '0542-8778980/0542-877641', '-', '-', 'E - 020 Dt', '2019-03-13 21:59:51', '2019-03-13 21:59:51'),
(23, 23, 'BBTKLPP Banjarbaru', 1, 8, '63', '6372', 'Jalan H. Mistar Cokrokusumo No. 2A Banjarbaru', '0511-478043', 'Sari', '08115012781', 'E - 022 Dt', '2019-03-13 22:39:58', '2019-03-13 22:39:58'),
(25, 25, 'Klinik ANNISA', 2, 6, '63', '6309', 'Jalan A. Yani, Kel. Mabu\'un, Kec. Murung Pudak, Kab. Tabalong, Kalimantan Selatan', '082317359666', 'Tri Sutisno', '082161220198', 'E - 021 Dt', '2019-03-14 19:57:44', '2019-03-14 19:57:44'),
(26, 26, 'Puskesmas Haur Gading', 1, 5, '63', '6308', 'Jalan Raya Desa Sungai Limas RT.03 N0. 12 Kec. Haur Gading, Kab. Hulu Sungai Utara', '-', 'Wiwin', '081348882010', 'E - 023 Dt', '2019-03-20 17:47:38', '2019-03-20 17:47:38'),
(27, 27, 'Puskesmas Pasar Sabtu', 1, 5, '63', '6308', 'Jalan Tiga Desember, Desa BAnua Hanyar RT.02, Kec. Sungai Tabukan, Kab. Hulu Sungai Utara', '-', 'Wiwin', '081348882010', 'E - 024 Dt', '2019-03-20 19:16:58', '2019-03-20 19:16:58'),
(28, 28, 'Puskesmas Paminggir', 1, 5, '63', NULL, 'Jalan Murung Keramat RT. 02 Desa Paminggir Kec. Paminggir,', '-', 'Wiwin', '081348882010', 'E - 025 Dt', '2019-03-20 19:36:31', '2019-03-20 19:36:31'),
(29, 29, 'Dinkes Hulu Sungai Utara', 1, 8, NULL, NULL, 'Jalan Kurdiyusni No. 66, Kec. Amuntai Tengah', '-', 'Wiwin', '081348882010', 'E - 026 Dt', '2019-03-20 19:41:10', '2019-03-20 19:41:10'),
(30, 30, 'Puskesmas Danau Panggang', 1, 5, NULL, NULL, 'Jalan Suka Ramai RT.03, Kec. Danau Panggang', '-', 'Wiwin', '081348882010', 'E - 027 Dt', '2019-03-20 19:55:49', '2019-03-20 19:55:49'),
(31, 31, 'Puskesmas Babirik', 1, NULL, NULL, NULL, 'Jalan Tembok Baru No.50 RT.03 Desa Murung Panti Hilir, Kec, Babirik', '-', 'Wiwin', '081248882010', 'E - 028 Dt', '2019-03-20 20:17:28', '2019-03-20 20:17:28'),
(32, 32, 'Tirta Medical Centre Samarinda', 2, 6, '64', '6472', 'Jalan Kadrie Oening, Kel. Air Hitam, Kec. Samarinda Ulu, Samarinda. Kalimantan Timur', '05412086849', 'Madonna S.', '081320029326', 'E - 033 Dt', '2019-03-20 20:17:48', '2019-03-20 20:17:48'),
(33, 33, 'Puskesmas Guntung', 1, NULL, NULL, NULL, 'Jalan Guntung - Lampihong RT.02', '-', 'Wiwin', '081348882010', 'E - 029 Dt', '2019-03-20 20:27:04', '2019-03-20 20:27:04'),
(34, 34, 'Puskesmas Amuntai Selatan', 1, 5, '63', '6308', 'Jalan Gaya Baru Desa Telaga Silaba, Kec. Amuntai Selatan', '-', 'Wiwin', '081348882010', 'E - 030 Dt', '2019-03-20 20:32:39', '2019-03-20 20:32:39'),
(35, 36, 'Puskemesmas Banjang', 1, NULL, NULL, NULL, 'jalan Jermani Husin KM.07 simpang 3, Kecamatan Banjang', '-', 'Wiwin', '081348882010', 'E - 031 Dt', '2019-03-20 20:49:49', '2019-03-20 20:49:49'),
(36, 37, 'Puskesmas Sungai Malang', 1, NULL, NULL, NULL, 'Jalan Negara Dipa RT VII Kel. Sungai Malang Kec. Amuntai Tengah', '-', 'Wiwin', '081348882010', 'E - 032 Dt', '2019-03-20 20:52:17', '2019-03-20 20:52:17'),
(37, 38, 'Puskesmas Batulicin', 1, NULL, NULL, NULL, 'Jalan Pemerintahan No.19 RT.05 Kecd. Batulicin', '-', 'Eka Dinasti', '081254436512', 'E - 034 Dt', '2019-03-20 21:51:45', '2019-03-20 21:51:45'),
(38, 39, 'Puskesmas Darul Azhar', 1, 5, '63', '6310', 'Jalan Batu Benawa RT.09 Desa Bersujud Kec. Simpang Empat', '-', 'Eka Dinasti', '081254435612', 'E - 035 Dt', '2019-03-20 22:04:40', '2019-03-20 22:25:17'),
(39, 42, 'Puskesmas Pagatan', 1, 5, '63', '6310', 'Jalan Arif Rahman Hakim No.68, Desa  Pasar Baru  Kec. Kusan Hilir', '-', 'Eka Dinasti', '081254436512', 'E - 039 Dt', '2019-03-20 22:42:46', '2019-03-20 22:57:36'),
(40, 43, 'Puskesmas Batulicin I', 1, 5, '63', '6310', 'Jalan Transmigrasi KM 13,5 Desa Manunggal, Kec. Karang Bintang', '-', 'Eka Dinasti', '081254436512', 'E - 036 Dt', '2019-03-20 22:43:33', '2019-03-20 23:10:39'),
(41, 44, 'Puskesmas Mantewe', 1, 5, '63', '6310', 'Jalan Kodeco KM. 42 Kec. Mantewe', '-', 'Eka Dinasti', '081254436512', 'E - 037 Dt', '2019-03-20 22:50:22', '2019-03-20 23:03:31'),
(42, 45, 'Puskesmas Sebamban II', 1, 5, '63', '6310', 'Jalan Propinsi KM. 194 Ds. Karang Indah, Kec. Angsana', '-', 'Eka Dinasti', '081254436512', 'E - 038 Dt', '2019-03-20 23:03:34', '2019-03-20 23:12:52'),
(43, 46, 'Puskesmas Giri Mulya', 1, 5, '63', NULL, 'Jalan Transmigrasi Sebamban VI, Blok B, Desa Giriu Mulya RT. 06 Kec. Kurangi', '-', 'Eka Dinasti', '081254436512', 'E - 040 Dt', '2019-03-20 23:09:14', '2019-03-21 15:46:48'),
(44, 47, 'Puskesmas Lasung', 1, 5, '63', NULL, 'Jalan Pemerintahan No. 02, Desa Binawara, Kec. Kusan Hulu', '-', 'Eka Dinasti', '081254436512', 'E - 041 Dt', '2019-03-20 23:19:02', '2019-03-21 15:46:35'),
(45, 48, 'Puskesmas Karang Bintang', 1, 5, '63', NULL, 'Jalan Gentara RT.10 RW.05 Desa Karang Bintang Kec. Karang Bintang', '-', 'Eka Dinasti', '081254436512', 'E - 042 Dt', '2019-03-20 23:43:03', '2019-03-21 15:46:22'),
(46, 49, 'Puskesmas Teluk Kepayang', 1, 5, '63', NULL, 'Jalan Valgaosons  RT.01 Desa Teluk Kepayang Kec. Kusan Hulu', '-', 'Eka Dinasti', '081254436512', 'E - 043 Dt', '2019-03-21 00:00:23', '2019-03-21 15:46:05'),
(47, 50, 'Puskesmas Pulau Tanjung', 1, 5, '63', NULL, 'Jalan Tepian Sei. Kusan RT.03 Ds. Pulau Tanjung Kec. Kusan Hilir', '-', 'Eka Dinasti', '081254436512', 'E - 044 Dt', '2019-03-21 00:05:42', '2019-03-21 15:45:36'),
(48, 52, 'Polda Kalimantan Selatan', 1, 8, '63', '6371', 'Jl. D.I. Panjaitan No. 37,', '-', 'Arief Pramono', '0811506200', 'E - 045 Dt', '2019-03-21 19:38:29', '2019-03-21 19:38:29'),
(49, 53, 'RSUD Daha Sejahtera', 1, 1, '63', '6306', 'Jalan Pahanin Raya, Desa Pahanin Raya, Kec. Daha Selatan', '-', 'Giovanni Anggre. D. S. ST', '081703755444', 'E - 046 Dt', '2019-04-01 00:15:26', '2019-04-01 00:15:26'),
(50, 54, 'Klinik Tirta Medical Centre Muara Teweh', 2, 6, '62', '6205', 'Jalan Jendral Sudirman RT 017 Kel. Lanjas, Kec. Teweh Tengah', '-', 'Muhammad Irwan', '088705128452', 'E - 047 Dt', '2019-04-05 03:02:55', '2019-04-05 03:02:55'),
(51, 55, 'Klinik Tirta Medical Centre Berau', 2, 6, '64', '6405', 'Jalan Pulo Semama No. 789, Tanjung Redep, Berau, Kalimantan Timur', '055422010/085251552895', 'Muhammad Irwan', '088705128452', 'E - 048 Dt', '2019-04-12 02:42:02', '2019-04-12 02:42:02'),
(52, 56, 'Instalasi Laboratorium Rumah Sakit Sari Mulia', 2, 4, '63', '6371', 'Jalan Pangeran Antasari No. 139 Banjarmasin', '05113274178', 'Wandi', '081235810401', 'E - 049 Dt', '2019-04-16 06:30:26', '2019-04-16 06:38:09'),
(53, 57, 'RSUD Brigjend H. Hasan Basri', 1, 1, '63', '6306', 'Jalan Jendral Sudirman No. 26A Kandangan', '-', 'Muhammad Rizani', '081251733939', 'E - 050 Dt', '2019-04-18 07:06:00', '2019-04-18 07:06:00'),
(54, 58, 'Puskesmas Sungai Karias', 1, 5, '63', '6308', 'Jalan Bihman Villa RT 03 No. 33, Kec. Amuntai Tengah', '-', 'Wiwin', '081348882010', 'E - 051 Dt', '2019-04-25 01:07:49', '2019-04-25 02:42:30'),
(55, 59, 'Puskesmas Sapala', 1, 5, '63', '6308', 'Jalan Pandan Lurus RT 1 Desa Sepala Kec Paminggir', '-', 'Wiwin', '081348882010', 'E - 052 Dt', '2019-04-25 01:08:52', '2019-04-25 02:45:18'),
(56, 60, 'Puskesmas Sungai Turak', 1, 5, '63', '6308', 'Jalan Simpang Tiga Sungai Turah No. 03 RT 02, Kec. Amuntai Utara', '-', 'Wiwin', '081348882010', 'E - 053 Dt', '2019-04-25 01:09:49', '2019-04-25 02:46:30'),
(57, 61, 'Puskesmas Angkinang', 1, 5, '63', '6306', 'Jalan A. Yani Km. 8,5 No. 18 Desa Angkinang, Kec. Angkinang', '-', 'Basuki rahmad, S. Kep', '08125022327', 'E - 054 Dt', '2019-04-29 01:58:00', '2019-04-29 01:58:00'),
(58, 62, 'Puskesmas Batang Kulur', 1, NULL, NULL, NULL, 'Desa Batang Kulur Tengah, Kec. Sungai Raya', '-', 'Basuki Rahmad, S.Kep', '08125022327', 'E - 055 Dt', '2019-04-29 02:05:15', '2019-04-29 02:05:15'),
(59, 63, 'Puskesmas Bayanan', 1, NULL, NULL, NULL, 'Jalan Negara Kandangan KM. 1 Ds. Banjarbaru Kec. Daha Selatan', '-', 'Basuki Rahmad, S.Kep', '08125022327', 'E - 056 Dt', '2019-04-29 02:14:43', '2019-04-29 02:14:43'),
(60, 64, 'Puskesmas Kandangan', 1, NULL, NULL, NULL, 'Kel. Kandangan Utara Kec. Kandangan', '-', 'Basuki Rahmad, S.Kep', '08125022327', 'E - 057 Dt', '2019-04-29 02:16:59', '2019-04-29 02:16:59'),
(61, 65, 'Puskesmas Loksado', 1, 5, '63', '6306', 'Ds Loksado, Kec. Loksado', '-', 'Basuki Rahmad, S.Kep', '08125022327', 'E - 058 Dt', '2019-04-29 02:29:49', '2019-04-29 02:29:49'),
(62, 66, 'Puskesmas Malinau', 1, NULL, NULL, NULL, 'Jalan Trans Kandangan - Batulicin KM. 32,5 Desa Malinau Kec. Lokasdo', '-', 'Basuki Rahmad, S.Kep', '08125022327', 'E - 059 Dt', '2019-04-29 02:34:47', '2019-04-29 02:34:47'),
(63, 67, 'Puskesmas Wasah', 1, 5, '63', '6306', 'Desa Wasah Hulu, Kec. Simpur', '-', 'Basuki Rahmad, S.Kep', '08125022327', 'E- 060 Dt', '2019-04-29 02:37:25', '2019-04-29 02:39:10'),
(64, 68, 'Puskesmas Banjarbaru Utara', 1, 5, '63', '6372', 'Jalan Karang Anyar II', '-', 'Wahidah', '0811505027', 'E - 061 Dt', '2019-04-30 03:50:32', '2019-04-30 03:50:32'),
(65, 69, 'Puskesmas Paringin Selatan', 1, 6, '63', '6311', 'Jalan Tumenggung Jalil, Muara Pitap No.2 Kel. Batu Piring, Kec. Paringin Selatan', '0526 202848', 'Hj.Mursidah', '085249912725', 'E - 062 Dt', '2019-05-02 01:35:05', '2019-05-02 02:09:42'),
(66, 70, 'Puskesmas Pirsus', 1, 5, NULL, NULL, 'Jalan Desa Sumber Rejeki RT.14 RW.04 Kec. Juai', '-', 'Hj. Mursidah', '085249912725', 'E - 063 Dt', '2019-05-02 01:37:52', '2019-05-02 01:39:06'),
(67, 71, 'Puskesmas Paringin', 1, 5, NULL, NULL, 'Jalan Jendral Basuki Rahmat RT.1 RW.1 No.5 Kec. Paringin', '-', 'Hj. Mursidah', '085249912725', 'E - 064 Dt', '2019-05-02 02:13:17', '2019-05-02 02:13:17'),
(69, 73, 'Klinik Tirta Medical Centre Banjarmasin', 2, 6, '63', '6371', 'Jalan Jendral Ahmad Yani KM. 5,7 No.7 RT / RW. 08 / 01, Banjarmasin', '-', 'Muhammad Irwan', '088705128452', 'E - 065 Dt', '2019-05-03 02:11:05', '2019-05-03 02:11:05'),
(70, 74, 'Klinik Tirta Medical Centre Tabalong', 2, NULL, '63', '6309', 'Jalan IR. P.H.M Noor RT. 01 Ruko 5,6,7 Kel. Mabu\'un, Kec. Murung Pudak', '-', 'Muhammad Irwan', '088705128452', 'E - 066 Dt', '2019-05-03 02:15:38', '2019-05-03 02:15:38'),
(71, 75, 'Klinik Kimia Farma Banjarmasin', 2, 6, '63', '6371', 'Jalan Letjend S. Parman No. 42 Banjarmasin (Samping POLDA Kalsel)', '-', 'Widianto', '087716560888', 'E - 067 Dt', '2019-05-10 06:54:29', '2019-05-10 06:54:29'),
(72, 76, 'PT. SMART, Tbk Unit Refinery Tarjun', 2, 7, '63', '6302', 'Klumpang Hilir', '-', 'Duta Setyawan', '082158927905', 'E - 068 Dt', '2019-05-13 00:44:48', '2019-05-13 00:44:48'),
(73, 77, 'Supriatin', 2, 8, '63', '6372', 'Cindai Alus', '-', 'Supriatin', '-', 'E - 069 Dt', '2019-05-20 02:09:47', '2019-05-20 02:48:14'),
(74, 78, 'Maritim Barito Perkasa', 2, 7, '63', '6371', 'Jalan Tembus Pelabuhan MTP Baru RT 25 No. 26 Mantuil', '-', 'Mas\'ud', '08115007593', 'E - 070 Dt', '2019-05-21 03:13:55', '2019-05-21 03:13:55'),
(75, 79, 'Tirta Medical Centre Angsana', 2, 6, '63', '6310', 'Jalan Desa Karang Indah RT. 11 Angsana', '+625122541812', 'Muhammad Irwan', '088705128452', 'E - 071 Dt', '2019-05-23 02:24:09', '2019-05-23 02:24:09'),
(76, 80, 'Klinik Tirta Medical Centre Balikpapan', 2, 6, '64', '6471', 'Jalan Ruhui Rahayu Bahagia, Kel. Gunung Bahagia, Kec. Balikpapan Selatan', '+62542873810', 'Muhammad Irwan', '088705128452', 'E - 072 Dt', '2019-05-23 02:28:04', '2019-05-23 02:28:04'),
(77, 81, 'Lab. Suhu LPFK Banjarbaru', 1, 8, '63', '6372', '-', '-', '-', '-', 'I - 001 Dt', '2019-05-24 07:49:09', '2019-05-24 07:49:09'),
(78, 82, 'RSUD Sukamara', 1, 1, '62', '6206', 'Jalan Tjilik Riwut KM. 5,5 Kabupaten Sukamara', '-', 'Lahmudin', '085231868009', 'E - 073 Dt', '2019-05-27 01:35:58', '2019-05-27 01:35:58'),
(79, 83, 'Klinik Tirta Medical Centre Batu Sopang', 2, 6, '64', '6401', 'Jalan Negara RT.06 Desa Songka Kec. Batu Sopang', '081349554990', 'Muhammad Irwan', '088705128452', 'E - 074 Dt', '2019-05-28 02:23:40', '2019-05-28 02:23:40'),
(80, 84, 'Klinik Tirta Medical Centre Banjarmasin', 2, 6, '63', '6371', 'Jalan Jendral Ahmad Yani KM 5,7 No. 7 RT/RW 08/01', '05116742680', 'Muhammad Irwan', '088705128452', 'E - 075 Dt', '2019-06-11 02:12:39', '2019-06-11 02:12:39'),
(81, 85, 'Klinik Tirta Medical Centre Angsana', 2, 6, '63', '6310', 'Jalan Desa Karang Indah RT. 11 Angsana', '+625122541812', 'Muhammad Irwan', '088705128452', 'E - 076 Dt', '2019-06-17 03:22:51', '2019-06-17 03:29:40'),
(82, 86, 'Klinik Tirta Medical Centre Tabalong', 2, NULL, '63', '6309', 'Jalan IR. P.H.M Noor RT. 01 Ruko 5,6,7 Kel. Mabu\'un, Kec.\r\nMurung Pudak', '-', 'Muhammad Irwan', '088705128452', 'E - 077 Dt', '2019-06-17 03:29:24', '2019-06-17 03:29:24'),
(83, 87, 'Laboratorium Klinik & Radiologi NUR ASIH', 2, NULL, '64', '6472', 'Jalan KH. Agus Salim No. 38 A', '0541201744', 'Dikirim', '-', 'E - 078 Dt', '2019-06-17 03:55:49', '2019-06-17 03:55:49'),
(84, 88, 'RSUD Pulang Pisau', 1, 1, '62', '6210', 'Jalan W.A.D Duha Komp. Perkantoran Rey IV, Kel. Mentaren, Kec. Kahayan Ilir', '-', 'Tri Mulyanto', '0811585335', 'E - 079 Dt', '2019-06-17 07:08:30', '2019-06-17 07:08:30'),
(85, 89, 'Klinik Tirta Medical Centre Banjarmasin', 2, 6, '63', '6371', 'Jalan Jendral Ahmad Yani KM 5,7 No. 7 RT/RW 08/01', '05116742680', 'Muhammad Irwan', '088705128452', 'E - 080 Dt', '2019-06-19 01:50:27', '2019-06-19 01:50:27'),
(86, 91, 'Klinik Tirta Medical Centre Angsana', 2, 6, '63', '6310', 'Jalan Desa Karang Indah RT. 11 Angsana', '+625122541812', 'Muhammad Irwan', '088705128452', 'E - 082 Dt', '2019-06-19 01:59:28', '2019-06-19 01:59:28'),
(87, 92, 'RSUD Lamandau', 1, 1, '62', '6207', 'Jalan Trans Kalimantan KM.4 Kel. Nanga Bulik, Kec. Bulik', '-', 'Aulia Rahman', '085386636363', 'E - 083 Dt', '2019-06-19 02:58:35', '2019-06-19 02:58:35'),
(88, 93, 'Klinik Tirta Medical Centre Batu Sopang', 2, 6, '64', '6401', 'Jalan Negara RT.06 Desa Songka Kec. Batu Sopang', '081349554990', 'Muhammad Irwan', '088705128452', 'E - 081 Dt', '2019-06-20 01:57:55', '2019-06-20 01:57:55'),
(89, 94, 'Klinik Tirta Medical Centre Balikpapan', 2, NULL, '64', '6471', 'Jalan Ruhui Rahayu Bahagia, Kel. Gunung Bahagia, Kec.\r\nBalikpapan Selatan', '+62542873810', 'Muhammad Irwan', '088705128452', 'E - 084 Dt', '2019-06-20 02:36:30', '2019-06-20 02:36:30'),
(90, 95, 'PT. Putra Perkasa Abadi - Site BIB', 2, 7, '63', '6310', 'Sebamban II Blok F Desa Karang Indah Rt.08/RW.02 Kec. Angsana', '-', 'Fahmi', '085822957677', 'E - 085 Dt', '2019-06-21 03:03:03', '2019-06-21 03:06:20'),
(91, 96, 'PT Borneo Medika', 2, 7, '63', '6309', 'Jalan Ir. P. H. M. Noor, Tanjung Putri RT. 07 Pembataan, Kec. Murung Pudak', '082352034666', 'Heffy Erlina', '082350280261', 'E - 086 Dt', '2019-06-25 01:42:19', '2019-06-25 01:42:19'),
(92, 97, 'KKP Banjarmasin', 1, 8, '63', '6371', 'Jalan Belitung Darat 118, Kel. Belitung Selatan, Kec. Banjarmasin Barat', '-', 'Dr Shinta', '082350711110', 'E - 087 Dt', '2019-06-25 02:12:29', '2019-06-25 02:12:29'),
(93, 98, 'Primera Clinica', 2, 6, '63', '6309', 'Perumahan Propernas Green Village Ruko A No. 20, 21-22, Jalan Mabu\'un Raya, Kec. Murung Pudak - Tanjung', '-', 'Bella (dikirim)', '081549233026', 'E - 088 Dt', '2019-06-26 02:12:12', '2019-06-26 02:12:12'),
(94, 99, 'Laboratorium Prodia Banjarmasin', 2, 6, '63', '6371', 'Jalan Jendral Achmad Yani KM 3.5 No. 131-133', '-', 'Eka', '081351739983', 'E - 089 Dt', '2019-07-04 03:34:16', '2019-07-04 03:34:16'),
(95, 100, 'Laboratorium Prodia Balikpapan', 2, 6, '64', '6471', 'Komplek Pertokoan Bandar Klandasan Blok D-11 Jalan Jend. Sudirman', '0542739337', 'Eka', '081351739983', 'E - 090 Dt', '2019-07-04 03:36:47', '2019-07-04 03:36:47'),
(96, 101, 'Laboratorium Prodia Samarinda', 2, NULL, '64', '6472', 'Komplek Cendrawasih Trade Center Blok A5-6 Jalan Jend. Achmad Yani', '-', 'Eka', '081351739983', 'E - 091 Dt', '2019-07-04 03:39:23', '2019-07-04 03:39:23'),
(97, 102, 'Klinik PT Bumi Sawit Kencana', 2, 6, '62', '6202', 'Jalan Jendral Sudirman Km. 86, Kec. Sampit', '-', 'Daniel', '081336230632', 'E - 092 Dt', '2019-07-04 07:20:02', '2019-07-04 07:20:02'),
(98, 103, 'UPTD Puskesmas Kuaro', 1, 5, '64', '6401', 'Jalan Jendral A. Yani RT05/05 Kel. Kuaro, Kec. Kuaro', '-', 'Ika Diar Agustina, Amd. Far', '085640802228', 'E - 093 Dt', '2019-07-09 01:41:27', '2019-07-09 01:41:27'),
(99, 104, 'RS Borneo Citra Medika', 2, 4, '63', '6301', 'Jalan A. Yani RT. 7B RW. 03 Kel. Angsau, Kec. Pelaihari', '05122021002', 'M. Khaironi', '081258476886', 'E - 094 Dt', '2019-07-22 05:56:44', '2019-07-22 05:56:44'),
(100, 105, 'Puskesmas Kereng Bangkirai', 1, 5, '62', '6271', 'Jalan Mangkuraya, Kel. Kereng Bangkirai, Kec. Sebangau', '-', 'Dikirim', '05363231393', 'E - 095 Dt', '2019-07-24 02:22:34', '2019-07-24 02:22:34'),
(101, 106, 'Puskesmas Kelampangan', 1, NULL, NULL, NULL, 'Jalan Mahir Mahar KM 18,5 Gang Mawar, Kel. Kelampangan, Kec. Sebangau', '-', 'Dikirim', '05363231393', 'E - 096 Dt', '2019-07-24 02:26:37', '2019-07-24 02:26:37'),
(102, 107, 'PT. Wahana Baratama Mining', 2, 7, '63', '6310', 'Komplek Jetty PT. WBM Desa Sungai Cuka Kec. Satui', '051261805', 'Adi', '082137800199', 'E - 097 Dt', '2019-07-26 03:26:55', '2019-07-26 03:26:55'),
(103, 108, 'Klinik Tirta Medical Centre Angsana', 2, 6, '63', '6310', 'Jalan Desa Karang Indah RT. 11 , Angsana', '-', 'Muhammad Irwan', '088705128452', 'E - 098 Dt', '2019-07-29 02:44:23', '2019-07-29 03:00:52'),
(104, 109, 'RS Borneo Citra Medika', 2, 4, '63', '6310', 'Jalan A. Yani RT.  7B RW. 03 Kel. Angsau,  Kec. Pelaihari', '05122021002', 'M.  Khaironi', '081258476886', 'E - 099 Dt', '2019-07-29 06:50:57', '2019-07-29 06:54:11'),
(105, 110, 'PT.  Petrosea', 2, 7, '63', '6305', 'Jalan Ahmad Yani,  Kec. Tungkap', '-', 'Anggit', '081333666599', 'E - 100 Dt', '2019-07-31 05:52:29', '2019-07-31 05:55:33'),
(106, 111, 'Yayasan Kesehatan Pegawai Telkom', 2, 6, '64', '6471', 'jalan MT. Haryono No.  169', '0542875476', 'Fathur Rachman', '085246192300', 'E - 101 Dt', '2019-08-05 01:59:51', '2019-08-05 02:47:19'),
(107, 112, 'PT. Petrosea', 2, 7, '63', '6305', 'Jalan Ahmad Yani Kec, Tungkap', '-', 'Sadam', '-', 'E - 102 Dt', '2019-08-06 02:39:54', '2019-08-06 02:50:29'),
(108, 113, 'Klinik Laboratorium Prodia Banjarmasin', 2, 6, '63', '6371', 'Jalan Jendral Achmad Yani KM 3.5 No. 131-133', '-', 'Eka', '081351739983', 'E - 103 Dt', '2019-08-06 03:00:08', '2019-08-06 03:00:08'),
(109, 114, 'Klinik Laboratorium Prodia Balikpapan', 2, NULL, '64', '6471', 'Komplek Pertokoan Bandar Klandasan Blok D-11 Jalan Jend. Sudirman', '-', 'Eka', '081351739983', 'E - 104 Dt', '2019-08-06 03:01:52', '2019-08-06 03:01:52'),
(110, 115, 'Klinik Laboratorium Prodia Samarinda', 2, NULL, '64', '6472', 'Komplek Cendrawasih Trade Center Blok A5-6 Jalan Jend. Achmad Yani', '-', 'Eka', '081351739983', 'E - 105 Dt', '2019-08-06 03:03:09', '2019-08-06 03:03:09'),
(111, 116, 'Klinik Tirta Medical Centre Balikpapan', 2, 6, '64', '6471', 'Jalan Ruhui Rahayu Kel. Gunung Bahagia, Kec. Balikpapan Selatan', '0542873810', 'Muhammad Irwan', '088705128452', 'E - 106 Dt', '2019-08-07 01:25:47', '2019-08-07 01:26:14'),
(112, 117, 'RSUD Pulang Pisau', 1, 1, '62', '6210', 'Jalan W.A.D Duha Komplek Perkantoran Rey IV Kel. Mentaren Kec. Kahayan Ilir', '-', 'Tri Mulyanto', '0811585335', 'E - 107 Dt', '2019-08-07 04:02:14', '2019-08-07 04:02:14'),
(113, 118, 'PT Karunia Kencana Permaisejati', 2, 7, '62', '6202', 'Jalan Jendral Sudirman Km. 86, Kec. Sampit', '-', 'Daniel', '081336230632', 'E - 108 Dt', '2019-08-09 07:46:06', '2019-08-09 08:05:48'),
(114, 119, 'Tirta Medical Centre Angsana', 2, 6, '63', '6310', 'Jl. Desa Karang Indah RT. 11, Angsana', '(0512) 2541812', 'Muhammad Irwan', '088705128452', 'E - 109 Dt', '2019-08-13 01:14:17', '2019-08-13 01:17:04'),
(115, 120, 'PT Wahana Baratama Mining', 2, 7, '63', '6310', 'Komplek Jetty PT. WBM Desa Sungai Cuka Kec. Satui', '051261805', 'Adi', '082137800199', 'E - 110 Dt', '2019-08-22 02:49:23', '2019-08-22 02:49:23'),
(116, 121, 'Instalasi Laboratorium Rumah Sakit Sari Mulia', 2, 6, '63', '6371', 'Jalan Pangeran Antasari No. 139 Banjarmasin', '05113274178', 'Adi', '081250657629', 'E - 111 Dt', '2019-08-22 06:03:33', '2019-08-22 06:03:33'),
(117, 122, 'Klinik Simpang', 2, 6, '63', '6310', 'Jalan Gawe Sabumi RT.08 No. 83 Desa Bersujud Kec. Simpang 4', '-', 'Dina Mara Diana', '08115193300', 'E - 112 Dt', '2019-08-23 02:27:44', '2019-08-23 02:28:38'),
(118, 123, 'Rumah Sakit Damanhuri Barabai', 1, 1, '63', '6307', 'Jalan Murakata No. 4 Kel. Barabai Barat, Kec. Barabai', '-', 'Nur Rahmah Ismail', '082151214785', 'E - 113 Dt', '2019-08-23 02:40:19', '2019-08-23 02:40:19'),
(119, 124, 'Klinik Permata Husada', 2, 6, '64', '6402', 'Jalan Moh. Hatta RT. 19 Melak Ulu, Kec. Melak.', '-', 'Dr. Waluyo', '08115819928', 'E - 114 Dt', '2019-08-27 01:40:05', '2019-08-27 01:40:05'),
(120, 125, 'BBTKLPP Banjarbaru', 1, 8, '63', '6372', 'Jalan H. Mistar Cokrokusumo No. 2A Banjarbaru', '0511-478043', 'Ika', '081335276707', 'E - 115 Dt', '2019-08-28 07:03:17', '2019-08-28 07:04:42'),
(121, 126, 'Yuni Irmawati', 2, 8, '63', '6372', 'Komplek Griya Al Munawar Asri Blok B No. 10', '-', 'Yuni Irmawati', '-', 'E - 116 Dt', '2019-09-02 00:21:32', '2019-09-02 00:36:39'),
(122, 128, 'Puskesmas Guntung Payung', 1, NULL, NULL, NULL, 'Jalan Sapta Marga, Kel. Guntung Payung, Kec. Landasan Ulin', '-', 'Sigit', '085393395008', 'E - 117 Dt', '2019-09-03 02:33:32', '2019-09-03 02:33:32'),
(123, 129, 'Laboratorium Klinik Prodia Banjarmasin', 1, 6, '63', '6371', 'Jalan Jend. A. Yani Km. 3,5 No 131-133', '-', 'Eka', '081351739983', 'E - 118 Dt', '2019-09-03 02:46:43', '2019-09-03 02:46:43'),
(124, 130, 'Klinik Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan IR. P.H.M Noor RT. 01 Ruko 5,6,7 Kel. Mabu\'un, Kec.\r\nMurung Pudak', '-', 'Muhammad Irwan', '088705128452', 'E - 119 Dt', '2019-09-03 02:56:30', '2019-09-03 02:56:30'),
(125, 131, 'RSUD Taman Husada Bontang', 1, 1, '64', '6474', 'Jalan S. Parman No. 1 Bontang', '-', 'Dikirim', '-', 'E - 120 Dt', '2019-09-03 05:34:49', '2019-09-06 02:48:14'),
(126, 132, 'Kantor Kesehatan Pelabuhan Kelas II Samarinda', 1, 8, '64', '6472', 'Jalan Kapten AJ. Soedjono Samarinda', '0541742564', 'Abdul Samad', '08125000673', 'E - 121 Dt', '2019-09-05 03:16:25', '2019-09-05 03:16:25'),
(127, 133, 'Jelina', 2, 8, '63', '6310', 'Jalan Bumi Datar Laga Blok B No. 025, Batu Licin', '-', 'Jelina', '082151813997', 'E - 122 Dt', '2019-09-05 06:04:26', '2019-09-05 06:04:26'),
(128, 134, 'Klinik Tirta Medical Centre Balikpapan', 2, NULL, '64', '6471', 'Jalan Ruhui Rahayu Kel. Gunung Bahagia, Kec. Balikpapan Selatan', '-', 'Muhammad Irwan', '088705128452', 'E - 123 Dt', '2019-09-18 02:14:12', '2019-09-18 03:04:03'),
(130, 136, 'Kusuma Medical Center', 2, 6, '64', '6471', 'Jalan mayjend sutoyo no. 38 rt.48 kec. Gunung malang', '05428800020', 'Hadi sungkono', '089690204730', 'E - 124 Dt', '2019-09-23 00:21:34', '2019-09-23 00:21:34'),
(131, 137, 'Puskesmas Martapura 1', 1, 5, '63', '6303', 'Jalan puskesmas no. 22', '-', 'Wika Narti', '085248195544', 'E - 125 Dt', '2019-09-25 03:46:10', '2019-09-25 04:09:27'),
(132, 138, 'Klinik Tirta Medical Centre Banjarmasin', 2, 6, '63', '6371', 'Jalan Jendral Ahmad Yani KM 5,7 No. 7 RT/RW 08/01', '05116742680', 'Fauzan', '-', 'E - 126 Dt', '2019-09-25 05:58:19', '2019-09-25 05:58:19'),
(133, 139, 'Klinik Tirta Medical Centre Tabalong', 2, NULL, '63', '6309', 'Jalan IR. P.H.M Noor RT. 01 Ruko 5,6,7 Kel. Mabu\'un, Kec.\r\nMurung Pudak', '-', 'Fauzan', '-', 'E - 127 Dt', '2019-09-25 06:00:04', '2019-09-25 06:00:04'),
(134, 140, 'Klinik Tirta Medical Centre Berau', 2, NULL, '64', '6405', 'Jalan Pulo Semama No. 789, Tanjung Redep, Berau, Kalimantan Timur', '055422010/085251552895', 'Fauzan', '-', 'E - 128 Dt', '2019-09-25 06:01:31', '2019-09-25 06:01:31'),
(135, 141, 'PT. Tunas Inti Abadi Site Sembamban', 2, 7, '63', '6310', 'Jalan propinsi KM 204 DesA Sebamban baru Kec. Sungai Loban', '-', 'Iwan', '081251929525', 'E - 129 Dt', '2019-09-26 00:51:07', '2019-09-26 00:51:07'),
(136, 142, 'Dinas kesehatan kabupaten katingan', 1, 8, '62', '6209', 'Jalan Ahmad Yani Komp. Perkantoran PEMDA', '05364043577', 'Gono', '081288881869', 'E - 130 Dt', '2019-09-26 06:36:33', '2019-09-26 06:36:33'),
(137, 143, 'PT. Indonesia Multi Purpose Terminal', 2, 7, '63', '6371', 'Jalan Kapten Pierre Tendean No. 180 RT 17 (Jakarta : Jalan H.R. Rasuna Said)', '-', 'Daniel PE Rembeth', '082255558469', 'E - 131 Dt', '2019-09-30 01:09:40', '2019-09-30 01:32:17'),
(139, 145, 'Puskesmas Jambu Hilir', 1, 5, '63', '6306', 'Jalan Piere Tendean Kel. Jambu Hilir Kec. Kandangan', '-', 'Basuki Rahmad', '08125022327', 'E - 132 Dt', '2019-10-02 02:27:50', '2019-10-02 03:57:11'),
(140, 146, 'Puskesmas Batang Kulur', 1, 5, '63', '6306', 'Jalan Batang Kulur Tangah Kec. Sungai Raya', '-', 'Basuki Rahmad', '08125022327', 'E - 133 Dt', '2019-10-02 04:01:07', '2019-10-02 04:01:07'),
(141, 147, 'Puskesmas Sungai Raya', 1, NULL, NULL, NULL, 'Jalan Jendral Sudirman KM. 6,5 Kec. Sungai Raya', '-', '08125022327', 'Basuki Rahmad', 'E - 134 Dt', '2019-10-02 04:10:19', '2019-10-02 04:10:19'),
(142, 148, 'Puskesmas Simpur', 1, NULL, NULL, NULL, 'Desa Simpur Jalan Pamujaan Kec. Simpur', '-', 'Basuki Rahmad', '08125022327', 'E - 135 Dt', '2019-10-02 04:13:03', '2019-10-02 04:13:03'),
(143, 149, 'Puskesmas Bamban', 1, NULL, NULL, NULL, 'Jalan Ahmad Yani km. 8,5  Kec. Angkinang', '-', 'Basuki Rahmad', '08125022327', 'E - 136 Dt', '2019-10-02 04:14:37', '2019-10-02 04:22:33'),
(144, 150, 'Puskesmas Kandangan', 1, NULL, NULL, NULL, 'Jalan Kamboja No. 1 Kel. Kandangan Utara', '-', 'Basuki Rahmad', '08125022327', 'E - 137 Dt', '2019-10-02 04:16:22', '2019-10-02 04:16:22'),
(145, 151, 'Puskesmas Sungai Pinang', 1, NULL, NULL, NULL, 'Jalan Inpres RT. 4 RK. II Desa Sungai Pinang Kec. Daha Selatan', '-', 'Basuki Rahmad', '08125022327', 'E - 138 Dt', '2019-10-02 04:19:38', '2019-10-02 04:19:38'),
(146, 152, 'Puskesmas Gambah', 1, NULL, NULL, NULL, 'Jalan Ahmad Yani Desab Bamban Luar Kec. Kandangan', '-', 'Basuki Rahmad', '08125022327', 'E - 139 Dt', '2019-10-02 04:21:36', '2019-10-02 04:21:36'),
(147, 153, 'Klinik Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan IR. P.H.M Noor RT. 01 Ruko 5,6,7 Kel. Mabu\'un, Kec.\r\nMurung Pudak', '-', 'Muhammad Irwan', '088705128452', 'E - 140 Dt', '2019-10-03 03:05:46', '2019-10-03 03:05:46'),
(148, 154, 'Klinik Tirta Medical Centre Batu Sopang', 2, 6, '64', '6401', 'Jalan Negara RT.06 Desa Songka Kec. Batu Sopang', '081349554990', 'Muhammad Irwan', '088705128452', 'E - 141 Dt', '2019-10-03 03:07:11', '2019-10-03 03:07:43'),
(149, 155, 'Klinik Tirta Medical Centre Muara Teweh', 2, 6, '62', '6205', 'Jalan Jendral Sudirman RT 017 Kel. Lanjas, Kec. Teweh Tengah', '-', 'Muhammad Irwan', '088705128452', 'E - 142 Dt', '2019-10-03 03:09:20', '2019-10-03 03:09:20'),
(150, 156, 'Kantor Kesehatan Pelabuhan Kelas II Balikpapan', 1, 8, '64', '6471', 'Jalan Pelita RT. 11 Kel. Sepinggir Raya', '-', 'Joko', '08115970048', 'E - 143 Dt', '2019-10-03 05:36:12', '2019-10-03 08:02:14'),
(151, 157, 'PT Buana Karya Bhakti', 2, 7, '63', '6310', 'Desa Sumber Makmur Kec. Satui', '-', 'Ridha Rahmatullah', '081348061109', 'E - 144 Dt', '2019-10-07 02:19:07', '2019-10-07 02:19:07'),
(152, 158, 'Muradi', 2, 8, '63', '6308', 'Desa Ambahai Kec. Paminggir', '0811511310', 'Muradi', '0811511310', 'E - 145 Dt', '2019-10-07 06:08:52', '2019-10-07 06:08:52'),
(153, 159, 'RSUD Lamandau', 1, 1, '62', '6207', 'Jalan Trans Kalimantan KM.4 Kel. Nanga Bulik, Kec. Bulik', '-', 'Aulia Rahman', '085386636363', 'E - 146 Dt', '2019-10-09 01:07:00', '2019-10-09 01:07:00'),
(154, 161, 'Puskesmas Lolo', 1, 5, '64', '6401', 'Jalan Sawit RT. 5, Desa Keluang Paser Jaya, Kec. Koaro', '-', 'Norvia Diannita', '082150241397', 'E - 147 Dt', '2019-10-11 01:33:45', '2019-10-11 01:33:45'),
(155, 162, 'Klinik Spesialis Rafisa Dahlia', 2, 6, '63', '6371', 'Jalan Dahlia Raya No. 41 Banjarmasin', '(0511) 3358900', 'Abdurrahim', '081253133885', 'E - 148 Dt', '2019-10-11 02:16:24', '2019-10-11 02:16:24'),
(156, 163, 'Klinik Tirta Medical Centre Muara Teweh', 2, 6, '62', '6205', 'Jalan Jendral Sudirman RT 017 Kel. Lanjas, Kec. Teweh Tengah', '-', 'Muhammad Irwan', '088705128452', 'E - 149 Dt', '2019-10-11 02:52:19', '2019-10-11 02:52:19'),
(157, 164, 'Puskesmas Telaga Bauntung', 1, 5, '63', '6303', 'Jalan LIDA RT 001 Desa Rantau Bujur Kec. Telaga Bauntung', '-', 'Qulsum', '085252499055', 'E - 150 Dt', '2019-10-17 02:44:34', '2019-10-17 02:44:34'),
(158, 165, 'Klinik Insani Muara Teweh', 2, 6, '62', '6205', 'Jalan Tumenggung Surapati No. 76 Kel. Melayu, Kec. Teweh Tengah', '-', 'Yuni', '085249031904', 'E - 151 Dt', '2019-10-17 03:56:11', '2019-10-17 03:56:11'),
(159, 166, 'Klinik Tirta Medical Centre Batu Sopang', 2, 6, '64', '6401', 'Jalan Negara RT.06 Desa Songka Kec. Batu Sopang', '-', 'Jemy', '082150149416', 'E - 152 Dt', '2019-10-17 06:16:30', '2019-11-05 02:32:46'),
(160, 167, 'Klinik Tirta Medical Centre Banjarmasin', 2, 6, '63', '6371', 'Jalan Jendral Ahmad Yani KM 5,7 No. 7 RT/RW 08/01', '-', 'Jemy', '082150149416', 'E - 153 Dt', '2019-10-17 06:21:27', '2019-10-17 06:21:27'),
(161, 168, 'Agus Mujahidin', 2, 8, '63', '6303', 'Jalan SMP 3, Desa Indrasari, Kec. Martapura', '-', 'Agus Mujahidin', '081350441151', 'E-154 Dt', '2019-10-21 05:32:31', '2019-10-21 05:32:31'),
(162, 169, 'Normala Santi', 2, 8, '63', '6305', 'Jalan Banua Padang, Rantau', '-', 'Normala Santi', '085346211624', 'E - 155 Dt', '2019-10-21 05:39:28', '2019-10-21 05:44:08'),
(163, 170, 'Puskesmas Sungai Tabuk', 1, 5, '63', '6303', 'Jakan Gerilya RT.03 , Desa Sungai Tabuk Keramat, Kec. Sungai Tabuk', '-', 'Yuni', '08125454658', 'E - 156 Dt', '2019-10-22 06:30:29', '2019-10-22 06:30:29'),
(164, 171, 'Klinik Grand Medica Indonesia', 2, 6, '64', '6471', 'Jalan Marsma R. Iswah Yudi Blok ART 8 No.19 Kel. Sungai Nangka', '-', 'dikirim', '-', 'E -157 Dt', '2019-10-23 02:57:21', '2019-10-25 01:18:51'),
(165, 172, 'RSJ Kalawa Atei', 1, NULL, '62', '6210', 'Jalan Trans Palangka Raya - Kuala Kurun Km. 16 Desa Bukit Rawi', '-', 'Taufikku Rahman', '0811520444', 'E - 158 Dt', '2019-10-23 04:22:15', '2019-10-23 04:22:15'),
(166, 174, 'Klinik Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan IR. P.H.M Noor RT. 01 Ruko 5,6,7 Kel. Mabu\'un, Kec.\r\nMurung Pudak', '-', 'Fauzan', '-', 'E - 159 Dt', '2019-10-23 05:39:15', '2019-10-23 05:39:15'),
(167, 175, 'Klinik Tirta Medical Centre Banjarmasin', 2, 6, '63', '6371', 'Jalan Jendral Ahmad Yani KM 5,7 No. 7 RT/RW 08/01', '05116742680', 'Fauzan', '-', 'E - 160 Dt', '2019-10-23 05:43:07', '2019-10-23 05:43:07'),
(168, 176, 'RSJ Kalawa Atei', 1, 1, '62', '6210', 'Jalan Trans Palangka Raya - Kuala Kurun Km. 16, Desa Bukit Rawi', '-', 'Taufikku Rahman', '0811520444', 'E - 161 Dt', '2019-10-24 00:32:52', '2019-10-24 00:32:52'),
(169, 177, 'Puskesmas Tanjung', 1, 5, '63', '6309', 'Jl. A. Yani, Km.8,5 Ds. Pamaranan Kiwa, Kec. Tanjung', '-', 'Ibu Andriyani', '08125121520', 'E - 162 Dt', '2019-10-24 01:43:39', '2019-10-24 02:06:11'),
(170, 178, 'Puskesmas Mungkur', 1, 5, '63', '6309', 'Jl. A. Yani Km.3 Ds. Karangan Putih, Kec. Kelua', '-', 'Ibu Andriyani', '08125121520', 'E - 163 Dt', '2019-10-24 02:05:58', '2019-10-24 02:05:58'),
(171, 179, 'Klinik Tirta Medical Centre Balikpapan', 2, 6, '64', '6471', 'Jalan Ruhui Rahayu Kel. Gunung Bahagia, Kec. Balikpapan\r\nSelatan', '-', 'Muhammad Irwan', '088705128452', 'E - 164 Dt', '2019-10-25 02:17:36', '2019-10-25 02:17:36'),
(174, 182, 'Klinik Tirta Medical Centre Batu Sopang', 2, 6, '64', '6401', 'Jalan Negara RT. 06 Desa Songka Kec. Batu Sopang', '-', 'Muhammad Irwan', '-', 'E - 165 Dt', '2019-10-29 04:17:31', '2019-10-29 04:17:31'),
(175, 183, 'Rumah Sakit Mulia Amuntai', 2, 4, '63', '6308', 'Jalan Norman Umar Kebun Sari, Amuntai', '052763559', 'Hanafi', '081349301440', 'E - 166 Dt', '2019-11-01 03:04:52', '2019-11-01 03:05:56'),
(176, 184, 'Puskesmas Rawat Inap Muser', 1, 5, '64', '6401', 'Jalan Anwar No. 43 RT. 04 Desa Muser, Kec. Muara Samu', '082352257576', 'Ardiansyah, S. Kep', '081347128667', 'E - 167 Dt', '2019-11-04 02:36:44', '2019-11-04 03:15:29'),
(177, 185, 'Laboratorium K3 Provinsi Kalimantan Selatan', 1, 8, '63', '6371', 'Jalan Brigjen H. Hasan Basry No. 56 Banjarmasin', '05113304312', 'Dani', '081348436817', 'E - 170 Dt', '2019-11-05 00:49:57', '2019-11-05 01:09:45'),
(178, 186, 'UPTD. Laboratorium Kesehatan Prov. Kalimantan Timur', 1, 8, '64', '6472', 'Jalan KH Ahmad Dahlan No. 27', '0541205754', 'Dikirim', '-', 'E - 168 Dt', '2019-11-05 02:00:10', '2019-11-05 02:00:10'),
(179, 187, 'RS TNI AU SJAMSUDIN NOOR', 1, 2, '63', '6372', 'Jalan Hercules No. 17 Banjarbaru', '05114705118', 'Eka', '081251306208', 'E - 171 Dt', '2019-11-05 02:08:55', '2019-11-05 02:21:02'),
(180, 188, 'BNN Tanah Merah', 1, 8, '64', '6472', 'Jalan Ruas Samarinda Bontang KM. 6 Kel. Tanah Merah, Kec. Samarinda Utara', '-', 'Dikirim', '-', 'E - 169 Dt', '2019-11-05 02:11:07', '2019-11-06 00:07:24'),
(181, 189, 'UPTD Puskesmas Sababilah', 1, 5, '62', '6204', 'Jalan Soekarno Hatta Km. 14 RT.04 RW.02 Kec. Dusun Selatan', '-', 'Dwi Noriyati', '081258015803', 'E - 172 Dt', '2019-11-05 03:48:53', '2019-11-05 05:23:19'),
(182, 190, 'Klinik Tirta Medical Centre Samarinda', 2, 6, '64', '6472', 'Jalan Kadrie Oening, Kel. Air Hitam, Kec. Samarinda Ulu', '+625412086849', 'Muhammad Irwan', '088705128452', 'E - 173 Dt', '2019-11-07 02:34:11', '2019-11-27 01:49:27'),
(183, 191, 'Klinik Tirta Medical Centre Banjarmasin', 2, NULL, NULL, NULL, 'Jalan Jendral Ahmad Yani KM 5,7 No. 7 RT/RW 08/01', '-', 'Muhammad Irwan', '-', 'E - 174 Dt', '2019-11-08 01:42:07', '2019-11-08 01:42:07'),
(184, 192, 'Borneo Medical Services', 2, 6, '63', '6309', 'Jalan Ir. P. H. M. Noor, Tanjung Putri RT.07 Pembataan, Kec. Murung Pudak', '-', 'Heffy Erlina', '082352034666', 'E - 175 Dt', '2019-11-11 05:29:31', '2019-11-11 05:29:31'),
(185, 193, 'Puskesmas Sungai Tabuk', 1, 5, '63', '6303', 'Jalan Gerilya RT.03 , Desa Sungai Tabuk Keramat, Kec. Sungai Tabuk', '-', 'Yuni', '08125454658', 'E - 176 Dt', '2019-11-12 07:09:57', '2019-11-12 07:09:57'),
(186, 194, 'Klinik Tirta Medical Centre Batu Sopang', 2, 6, '64', '6401', 'Jalan Negara RT. 06 Desa Songka Kec. Batu Sopang', '-', 'Muhammad Irwan', '-', 'E - 177 Dt', '2019-11-13 01:44:25', '2019-11-13 01:44:25'),
(187, 195, 'Klinik Tirta Medical Centre Tabalong', 2, NULL, '63', '6309', 'Jalan IR. P.H.M Noor RT. 01 Ruko 5,6,7 Kel. Mabu\'un, Kec.\r\nMurung Pudak', '-', 'Muhammad Irwan', '-', 'E - 178 Dt', '2019-11-13 01:50:37', '2019-11-13 01:50:37'),
(188, 196, 'Klinik Tirta Medical Centre Balikpapan', 2, 6, '64', '6471', 'Jalan Ruhui Rahayu Kel. Gunung Bahagia, Kec. Balikpapan\r\nSelatan', '-', 'Muhammad Irwan', '-', 'E - 179 Dt', '2019-11-13 01:55:42', '2019-11-13 01:55:42'),
(189, 197, 'Puskesmas Sungai Tabuk', 1, 5, '63', '6303', 'Jalan Gerilya RT.03 , Desa Sungai Tabuk Keramat, Kec. Sungai Tabuk', '-', 'Yuni', '08125454658', 'E - 180 Dt', '2019-11-15 02:03:42', '2019-11-15 02:03:42'),
(190, 198, 'PT Mandiri Inti Perkasa', 2, 7, '65', '6508', 'Site Krassi, Desa Tanggul, Kec. Sembakung', '-', 'Dikirim', '-', 'E - 181 Dt', '2019-11-18 00:26:47', '2019-11-18 00:26:47'),
(191, 199, 'Klinik Polda Kalimantan Timur', 1, 6, '64', '6471', 'Jalan Syarifuddin Yoes No. 99, Kel. Sepinggan, Kec. Balikpapan Selatan,', '-', 'Dikirim', '-', 'E - 182 Dt', '2019-11-18 06:26:28', '2019-11-18 06:26:28'),
(192, 200, 'Klinik Tirta Medical Centre Batu Sopang', 2, 6, '64', '6401', 'Jalan Negara RT. 06 Desa Songka Kec. Batu Sopang', '-', 'Muhammad Irwan', '088705128452', 'E - 183 Dt', '2019-11-25 02:20:12', '2019-11-25 02:20:12'),
(193, 201, 'Klinik Tirta Medical Centre Banjarmasin', 2, 6, '63', '6371', 'Jalan Jendral Ahmad Yani KM 5,7 No. 7 RT/RW 08/01', '-', 'Muhammad Irwan', '-', 'E - 184 Dt', '2019-11-27 02:21:49', '2019-11-27 02:21:49'),
(194, 202, 'Puskesmas Pahandut', 1, 5, '62', '6271', 'Pahandut, Kec. Jekan Raya', '-', 'Budi Wijaya', '085251609887', 'E - 185 Dt', '2019-11-29 01:02:11', '2019-11-29 01:02:11'),
(195, 203, 'PT. Mentaya Sawit Mas', 2, 7, '62', '6202', 'Jalan Jendral Sudirman Km. 86', '-', 'Daniel', '081336230632', 'E - 186 Dt', '2019-12-02 05:18:22', '2019-12-02 05:18:22'),
(196, 204, 'Puskesmas Bontang Selatan 1', 1, 5, '64', '6474', 'Jalan Cumi-cumi No. 8 Kel. Tanjung Laut Indah, Kec. Bontang Selatan', '-', 'Dikirim', '-', 'E - 187 Dt', '2019-12-05 06:34:54', '2019-12-06 01:36:34'),
(197, 205, 'Puskesmas Bontang Utara 1', 1, 5, '64', '6474', 'Jalan Ahmad Yani RT. 13 Kel. Bontang Baru, Kec. Bontang Utara', '-', 'Dikirim', '-', 'E - 188 Dt', '2019-12-05 06:44:54', '2019-12-06 01:43:41'),
(198, 206, 'Puskesmas Bontang Barat', 1, 5, '64', '6474', 'Jalan Damai No. 41, Kel. Kanaan, Kec. Bontang Bar', '-', 'Dikirim', '-', 'E - 189 Dt', '2019-12-05 06:50:23', '2019-12-06 01:45:13'),
(199, 207, 'Puskesmas Bontang Selatan 2', 1, 5, '64', '6474', 'Jalan Hayam Wuruk RT 18 No 01 Berbas Tengah Selatan, Kel. Berbas Tengah, Kec. Bontang Selatan', '-', 'Dikirim', '-', 'E - 190 Dt', '2019-12-05 07:01:49', '2019-12-06 01:38:33'),
(200, 208, 'UPT Puskesmas Martapura Barat', 1, NULL, '63', '6303', 'Jalan Martapura Lama Desa Sungai Rangas Hambuku', '-', 'Aida Surahmah, A.Md', '081351104202', 'E - 191 Dt', '2019-12-06 01:33:54', '2019-12-06 01:33:54'),
(201, 209, 'Laboratorium Kesehatan dan Keselamatan Kerja Banjarmasin', 1, 8, '63', '6371', 'Jalan Brigjend H, Hasan Basry No. 56', '05113304312', 'Dani', '081348436817', 'E - 192 Dt', '2019-12-06 06:47:44', '2019-12-06 06:47:44'),
(202, 210, 'Klinik Kusuma Medical Centre Batu Kajang', 2, 6, '64', '6401', 'Jalan Negara KM. 141 RT 09, Batu Kajang', '-', 'Habib Al- Ichrom', '-', 'E - 193 Dt', '2019-12-09 00:22:12', '2019-12-09 00:22:12'),
(203, 211, 'Klinik Pegawai Pemkot Bontang', 1, NULL, NULL, NULL, 'Jalan Jendral A. Yani No. 13, Api-api, bontang utara, kota bontang, kalimantan timur', '-', 'dikirim', '-', 'E - 194 Dt', '2019-12-09 06:41:51', '2019-12-09 06:41:51'),
(204, 212, 'Puskesmas Bontang Utara 1', 1, 5, '64', '6474', 'Jalan Ahmad Yani RT. 13 Kel. Bontang Baru, Kec. Bontang Utara', '-', '-', '-', 'E - 195 Dt', '2019-12-09 07:30:15', '2019-12-09 07:31:26'),
(205, 213, 'Klinik Tirta Medical Centre Batu Sopang', 2, 5, '64', '6401', 'Jalan Negara RT. 06 Desa Songka Kec. Batu Sopang', '-', 'Muhammad Irwan', '088705128452', 'E - 196 Dt', '2019-12-13 02:35:28', '2019-12-13 02:35:28'),
(206, 214, 'Puskesmas Simpang Empat 1', 1, 5, '63', '6303', 'Jalan A. Yani , Takuti, Simpang Empat,', '-', 'Rahmat', '081351141870', 'E - 197 Dt', '2019-12-19 07:53:09', '2019-12-19 07:53:09'),
(207, 215, 'Puskesmas Tanah Grogot', 1, 5, '64', '6401', 'Jalan Anden Gedang, Tana Paser', '0543-21485', 'Dewi', '083144127643', 'E - 198 Dt', '2019-12-23 02:42:50', '2019-12-23 02:54:27'),
(208, 216, 'Klinik Polda Kalimantan Timur', 1, 6, '64', '6471', 'Jalan Syarifuddin Yoes No. 99, Kel. Sepinggan, Kec. Balikpapan Selatan,', '-', 'dikirim', '-', 'E - 001 Dt', '2020-01-02 01:59:53', '2019-12-31 01:59:53'),
(211, 219, 'Kimia Farma Seratus Sebelas', 2, 6, '63', '6372', 'Jalan Ahmad Yani Km. 34 No. 10', '-', 'Kasripin', '-', 'E - 002 Dt', '2020-01-06 02:15:09', '2020-01-06 02:15:09'),
(212, 220, 'PT Putra perkasa abadi', 2, 7, '63', '6310', 'Sebamban2 blok F Desa karang indah RT.8 RW.2, Kec. Angsana', '-', 'Dr. Edward', '082141892909', 'E - 003 Dt', '2020-01-20 04:52:52', '2020-01-20 04:52:52'),
(213, 221, 'PT Putra Perkasa Abadi', 2, 7, '63', '6310', 'Sebamban2 blok F Desa karang indah RT.8 RW.2, Kec. Angsana', '-', 'Dr. Edward', '082141892909', 'E - 004 Dt', '2020-01-21 04:26:27', '2020-01-21 04:26:27'),
(214, 222, 'Klinik Kusuma Medical Center Balikpapan', 2, 6, '64', '6471', 'Jalan Mayjend Sutoyo No. 38 Rt.48 Kec. Gunung Malang', '05428800020', 'Hadi Sungkono', '089690204730', 'E - 005 Dt', '2020-01-22 02:26:57', '2020-01-22 02:26:57'),
(215, 223, 'PMI Banjarmasin', 1, 8, '63', '6371', 'Jalan S. Parman No. 14 RT. 02 RW. 01, Kel. Antasan Besar, Kec. Banjarmasin Tengah', '0511 6723725', 'Saiful Bahri', '082154100054', 'E - 006 Dt', '2020-01-28 07:37:32', '2020-01-28 07:37:32'),
(216, 224, 'BBTKLPP Banjarbaru', 1, 8, '63', '6372', 'Jalan H. Mistar Cokrokusumo No.2A Banjarbaru', '(0511) 4780343', 'Bu Sari', '08115012781', 'E - 007 Dt', '2020-02-06 02:42:42', '2020-02-06 02:42:42'),
(217, 226, 'Klinik Tirta Medical Centre Balikpapan', 2, NULL, NULL, NULL, 'Jalan Ruhui Rahayu Bahagia, Kel. Gunung Bahagia, Kec. Balikpapan Selatan', '-', 'Fauzan', '082258804992', 'E - 008 Dt', '2020-02-11 06:10:42', '2020-02-11 06:31:59'),
(218, 227, 'PT. Antareja Mahada Makmur', 2, 8, '64', '6403', 'Jalan Poros Samarinda - Tenggarong, Loa Kulu', '=', 'dikirim', '082154955537', 'E - 009 Dt', '2020-02-11 07:56:59', '2020-02-11 07:56:59'),
(219, 228, 'Klinik POLRESTA Banjarmasin', 1, 6, '63', '6371', 'Jalan A. Yani Km. 3,5, Banjarmasin Timur', '-', 'Syairil Ihsan', '081348503243', 'E - 010 Dt', '2020-02-12 04:55:31', '2020-02-12 05:01:49'),
(220, 229, 'Biddokkes Polda Kalsel', 1, 8, '63', '6371', 'Jl. D. I. Panjaitan No.37, Antasan Besar, Kec. Banjarmasin Tengah', '-', 'Arief Pramono', '08115191200', 'E - 011 Dt', '2020-02-13 05:40:04', '2020-02-13 05:58:28'),
(221, 230, 'Yayasan Kesehatan Pegawai Telkom', 2, 3, '64', '6471', 'Jl. MT. Haryono No. 169, Balikpapan, Kalimantan Timur', '0542 875476 / 0542 875478', 'Fathur', '085246172300', 'E - 012 Dt', '2020-02-24 07:24:09', '2020-02-24 07:24:09'),
(222, 231, 'Klinik Tirta Medical Centre Balikpapan', 2, 6, '64', '6471', 'Jalan Ruhui Rahayu Bahagia, Kel. Gunung Bahagia, Kec. Balikpapan Selatan', '-', 'Fauzan', '082258804992', 'E - 013 Dt', '2020-02-25 05:47:00', '2020-02-25 05:47:00'),
(223, 232, 'Badan Narkotika Nasional Kota Banjarbaru', 1, 8, '63', '6372', 'Jalan Trikora Nomor 1 Banjarbaru', '0511-4773693', 'dr. Daryl', '081357467300', 'E - 014 Dt', '2020-02-27 06:42:00', '2020-02-27 06:42:00'),
(224, 233, 'Klinik Annisa Tanjung', 2, 6, '63', '6309', 'Jalan Ahmad Yani RT.03 / RW. 01 Kel. Mabuún, Kec. Murung Pudak', '-', 'Alvinda Pradita Wardana', '085849713277', 'E - 015 Dt', '2020-03-02 02:31:53', '2020-03-02 02:31:53'),
(225, 234, 'Klinik Kusuma Medical Center', 2, 6, '64', '6471', 'Jalan Mayjend Sutoyo No. 38 RT. 48 Kel. Klandasan Ilir, Kec. Gunung Malang', '-', 'Hamdan Burhanuddin', '085230821102', 'E - 016 Dt', '2020-03-02 02:35:23', '2020-03-02 02:35:23'),
(226, 235, 'Aesculap Medical Center', 2, 7, '64', '6471', 'Jalan Indrakila (Start 03) No. 17', '0542 - 440404', 'Misna', '085249629918', 'E - 017 Dt', '2020-03-02 07:07:21', '2020-03-02 07:07:21'),
(227, 236, 'PT THIESS', 2, 7, '63', '6301', 'Sungai Cuka, Kec. Satui', '-', 'Syaiful Azmi', '085393055557', 'E - 018 Dt', '2020-03-05 01:18:56', '2020-03-05 01:18:56'),
(228, 237, 'Biddokkes Polda Kalimantan Tengah', 1, 2, '62', '6271', 'Jalan Tjilik Riwut Km. 1', '-', 'Iptu Pangat Supriyadi', '081255520804', 'E - 019 Dt', '2020-03-06 06:42:30', '2020-03-06 06:42:30'),
(229, 238, 'Tirta Medial Center Muara Teweh', 2, 6, '62', '6205', 'Jalan Jendral Sudirman, RT 017, Melayu, Kec. Teweh Tengah,', '-', '-', '-', 'E - 020 Dt', '2020-03-12 05:47:38', '2020-03-12 06:03:12'),
(230, 239, 'Dinas Kesehatan Kota Banjarbaru', 1, 8, '63', '6372', 'Jalan Palang Merah No.2, Kel. Loktabat Utara, Kec. Banjarbaru Utara', '-', 'Nor Asiah', '082148813962', 'E - 021 Dt', '2020-03-13 03:44:28', '2020-03-13 03:44:28'),
(231, 240, 'Klinik Annisa Tanjung', 2, 6, '63', '6309', 'Jalan Ahmad Yani RT.03 / RW. 01 Kel. Mabuún, Kec. Murung Pudak', '-', 'dikirim', '08522576308', 'E - 022 Dt', '2020-04-07 02:34:05', '2020-04-07 02:41:35'),
(232, 241, 'Klinik Tirta Medical Centre Balikpapan', 2, 6, '64', '6471', 'Jalan Ruhui Rahayu Bahagia, Kel. Gunung Bahagia, Kec. Balikpapan Selatan', '-', 'Maulana', '082195483890', 'E - 023 Dt', '2020-06-15 07:41:23', '2020-06-15 09:11:05'),
(233, 242, 'Klinik Tirta Medical Centre Samarinda', 2, 6, '64', '6472', 'Jalan Kadrie Oening, Kel. Air Hitam, Kec. Samarinda Ulu', '-', 'Maulana', '082195483890', 'E - 024 Dt', '2020-06-15 07:58:30', '2020-06-15 09:09:13'),
(234, 243, 'Klinik Tirta Medical Centre Derawan', 2, 6, '64', '6405', 'Jalan Pulo Dermawan RT. 31, Kec. Tanjung Redeb, Kel. Tanjung Redeb', '-', 'Maulana', '082195483890', 'E - 025 Dt', '2020-06-15 08:02:15', '2020-06-15 09:09:42'),
(235, 244, 'Klinik Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan Mabu\'un Raya RT. 004 Kel. Mabu\'un Raya, Kec. Murung Pudak, Kab. Tabalong, Kalimantan Selatan', '-', 'Maulana', '082195483890', 'E - 026 Dt', '2020-06-15 08:08:08', '2020-06-19 04:32:29'),
(236, 245, 'Klinik Tirta Medical Centre Teweh', 2, NULL, '62', '6205', 'Jalan Jendral Sudirman, RT 017, Melayu, Kec. Teweh Tengah,', '-', 'Maulana', '082195483890', 'E - 027 Dt', '2020-06-15 08:17:35', '2020-06-15 09:11:52'),
(237, 246, 'Klinik Tirta Medical Centre Batu Sopang', 2, NULL, '64', '6401', 'Jalan Negara RT. 06 Desa Songka Kec. Batu Sopang', '-', 'Maulana', '082195483890', 'E - 028 Dt', '2020-06-15 08:27:52', '2020-06-15 09:12:16'),
(238, 247, 'Klinik Tirta Medical Centre Teweh', 2, 6, '62', '6205', 'Jalan Jendral Sudirman, RT 017, Melayu, Kec. Teweh Tengah,', '-', 'Maulana', '082195483890', 'E - 029 Dt', '2020-06-25 03:12:56', '2020-06-25 03:12:56'),
(239, 248, 'PT SMART TBK TARJUN', 2, NULL, '63', '6302', 'Desa Langadai Kec. Kelumpang Hilir', '-', 'Ana', '085273515536', 'E - 030 Dt', '2020-06-25 03:16:21', '2020-06-25 03:16:21'),
(240, 249, 'Klinik Piramida Jaya', 2, 6, '64', '6471', 'Jalan Jendral A. Yani No. 1 Kel. Gunung Sari Ilir', '0542732270', 'Alpiannor Rozikin', '-', 'E - 031 Dt', '2020-06-30 01:00:10', '2020-06-30 01:00:10'),
(241, 250, 'Klinik Kusuma Medical Center Balikpapan', 2, 6, '64', '6471', 'Jalan Mayjend Sutoyo No. 38 RT. 48 Kel. Klandasan Ilir, Kec. Gunung Malang', '0542 8800020', 'Wiwien Widyaningrum S.', '-', 'E - 032 Dt', '2020-07-02 06:09:54', '2020-07-02 06:09:54'),
(242, 251, 'Laboratorium Klinik & Radiologi NUR ASIH', 2, 6, '64', '6472', 'Laboratorium Klinik & Radiologi NUR ASIH', '0541201744', 'dikirim', '-', 'E - 033 Dt', '2020-07-06 07:56:39', '2020-07-06 07:56:39'),
(243, 252, 'Klinik Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan Mabu\'un Raya RT. 004 Kel. Mabu\'un Raya, Kec. Murung Pudak, Kab. Tabalong, Kalimantan Selatan', '-', 'Muhammad Irwan', '-', 'E - 034 Dt', '2020-07-10 00:57:54', '2020-07-22 00:56:50');
INSERT INTO `lab_customer` (`id`, `id_order`, `pemilik`, `setatus`, `jenis`, `provinsi_id`, `kabupaten_id`, `alamat`, `telepon`, `cp`, `hp`, `no_order`, `created_at`, `updated_at`) VALUES
(244, 253, 'Klinik Tirta Medical Centre Teweh', 2, 6, '62', '6205', 'Jalan Jendral Sudirman, RT 017, Melayu, Kec. Teweh Tengah,', '-', 'Muhammad Irwan', '-', 'E - 035 Dt', '2020-07-22 02:18:29', '2020-07-22 02:18:29'),
(245, 254, 'PT THIESS', 2, 7, '63', '6301', 'Sungai Cuka, Kec. Satui', '-', 'Dikirim', '-', 'E - 036 Dt', '2020-07-22 03:11:00', '2020-07-22 03:11:00'),
(246, 255, 'Instalasi Laboratorium RSU Sari Mulia Banjarmasin', 2, 4, '63', '6371', 'Jalan Pangeran Antasari No. 139 Banjarmasin', '-', 'April', '087852588540', 'E - 037 Dt', '2020-07-22 03:23:43', '2020-07-22 03:55:47'),
(247, 256, 'Yayasan Kesehatan Pegawai Telkom', 2, 6, '64', '6471', 'Jalan MT. Haryono No. 169', '0542-875476', 'Ayu Indrawari', '08125802964', 'E - 038 Dt', '2020-07-30 04:26:08', '2020-07-30 04:26:08'),
(248, 257, 'UPT. Laboratorium Kesehatan Daerah Kota Banjarmasin', 1, 8, '63', '6371', 'Jalan Pramuka Komplek Tirtha Dharma (PDAM) KM.6', '051142811291', 'Dikirim', '-', 'E - 039 Dt', '2020-08-03 07:02:10', '2020-08-03 07:02:10'),
(249, 258, 'Puskesmas Babai', 1, 5, '62', '6204', 'Desa Babai, Kec. Karau Kuala', '-', 'Dinkes Barito Selatan', '-', 'E - 040 Dt', '2020-08-06 00:38:16', '2020-08-06 00:56:31'),
(250, 259, 'Puskesmas Mengkatip', 1, 5, '62', '6204', 'Kel. Mengkatip, Kec. Dusun Hilir', '-', 'Dinkes Barito Selatan', '-', 'E - 041 Dt', '2020-08-06 00:42:33', '2020-08-06 01:03:19'),
(252, 261, 'Puskemas Buntok', 1, NULL, NULL, NULL, 'Jalan Pahlawan No. 29 RT. 37/IV, Kec. Dusun Selatan', '-', 'Dinkes Barito Selatan', '-', 'E - 043 Dt', '2020-08-06 01:09:23', '2020-08-06 01:09:23'),
(253, 262, 'Puskesmas Buntok', 1, NULL, NULL, NULL, 'Jalan Pahlawan No. 29 RT. 37/IV, Kec. Dusun Selatan', '-', 'Dinkes Barito Selatan', '-', 'E - 043 Dt', '2020-08-06 01:11:57', '2020-08-06 01:11:57'),
(254, 263, 'Puskesmas Jenamas', 1, 4, '62', '6204', 'Jalan Karya Bakti RT. 06 RW. 03 No. 1  Kec. Jenamas', '-', 'Dinkes Barito Selatan', '-', 'E - 044 Dt', '2020-08-06 02:54:57', '2020-08-06 02:54:57'),
(255, 264, 'Puskemas Kalahien', 1, 5, '62', '6204', 'Jalan Padat Karya RT.7 / II, Kec. Dusun Selatan', '-', 'Dinkes Barito Selatan', '-', 'E - 045 Dt', '2020-08-06 05:53:48', '2020-08-06 05:53:48'),
(256, 265, 'Puskesmas Bangkuang', 1, 5, '62', '6204', 'Jalan Pelabuhan RT. 22/1, Kel. Bengkuang, Kec. Karau Kuala', '-', 'Dinkes Barito Selatan', '-', 'E - 046 Dt', '2020-08-06 06:14:17', '2020-08-06 08:11:01'),
(257, 266, 'Puskesmas Pendang', 1, 5, '62', '6204', 'Jalan Pembangunan RT. 13 RW. VI, Kel. nO. 33 Pendang, Kec. Dusun Utara', '-', 'Dinkes Barito Selatan', '-', 'E - 047 Dt', '2020-08-06 07:06:21', '2020-08-19 05:27:22'),
(258, 267, 'Puskesmas Tabak Kanilan', 1, NULL, NULL, NULL, 'Jalan Km. 9 Desa Tabak Kanilan, Kec. Gunung Bintang Awal', '-', 'Dinkes Barito Selatan', '-', 'E - 048 Dt', '2020-08-06 07:50:35', '2020-08-06 07:50:35'),
(259, 268, 'Puskesmas Sababilah', 1, 5, '62', '6204', 'Jalan Soekarno Hatta KM. 14, Kec. Dusun Selatan', '-', 'Dinkes Barito Selatan', '-', 'E - 049 dT', '2020-08-06 08:03:25', '2020-08-06 08:03:25'),
(260, 269, 'Puskesmas Bantai Bambure', 1, 5, '62', '6204', 'Jalan Ampah-Muara Teweh Desa Bantai Bambure, RT/RW 11/05, No. 209', '-', 'Dinkes Barito Selatan', '-', 'E - 050 Dt', '2020-08-06 08:14:45', '2020-08-06 08:14:45'),
(261, 270, 'Kantor Kesehatan Pelabuhan Kelas II Balikpapan', 1, 6, '64', '6471', 'Jalan Pelita RT. 11, Kel. Sepinggan Raya', '-', 'Abdurrahman', '081253035559', 'E - 051 Dt', '2020-08-10 05:49:46', '2020-08-19 07:08:13'),
(262, 271, 'Klinik UIN Antasari Banjarmasin', 1, 6, '63', '6371', 'Jalan Ahmad Yani KM. 4,5 Kota Banjarmasin', '05113257627', 'Uswatun', '082151509493', 'E - 052 Dt', '2020-08-11 08:58:36', '2020-08-11 08:58:36'),
(263, 272, 'Puskesmas Baru', 1, 5, '62', '6204', 'jalan Asmawi Gani RT. 08 RW. II Desa Baru Kec. Dusun Selatan', '-', 'Dinkes Barito Selatan', '-', 'E - 042 Dt', '2020-08-18 05:21:22', '2020-08-18 05:30:54'),
(264, 273, 'Borneo Medical Services', 2, 6, '64', '6471', 'Ruko Balikpapan Baru Blok AA No. 4 Jalan Sungai Ampal, Kel. Damai, Kec. Balikpapan Kota,', '-', 'Suhermato', '082153779945', 'E - 054 Dt', '2020-08-18 05:36:50', '2020-08-18 05:36:50'),
(265, 274, 'Klinik Annisa Tanjung', 2, 6, '63', '6309', 'Jalan Ahmad Yani RT.03 / RW. 01 Kel. Mabuún, Kec. Murung Pudak', '-', 'Linda', '082226669995', 'E - 053 Dt', '2020-08-18 06:08:47', '2020-08-18 06:08:47'),
(266, 275, 'Klinik Tirta Medical Center Angsana', 2, 6, '63', '6310', 'Jl. Desa Karang Indah RT. 11, Angsana', '-', '-', '-', 'E - 055 Dt', '2020-08-24 07:52:10', '2020-08-24 07:52:42'),
(267, 276, 'Klinik Tirta Medical Center Balikpapan', 2, NULL, NULL, NULL, 'Jalan Mayjend Sutoyo No. 38 RT. 48 Kel. Klandasan Ilir, Kec. Gunung Malang', '-', '-', '-', 'E - 056 Dt', '2020-08-24 08:15:23', '2020-08-24 08:15:23'),
(268, 277, 'Klinik Tirta Medical Center Berau', 2, NULL, '64', '6405', 'Jalan Pulo Semama No. 789, Tanjung Redep, Berau, Kalimantan Timur', '-', '-', '-', 'E - 057 Dt', '2020-08-24 08:29:52', '2020-08-24 08:29:52'),
(269, 278, 'Klinik Tirta Medical Center Banjarmasin', 2, NULL, '63', '6371', 'Jalan Jendral Ahmad Yani KM 5,7 No. 7 RT/RW 08/01', '-', '-', '-', 'E - 058 Dt', '2020-08-24 08:35:29', '2020-08-24 08:35:29'),
(271, 281, 'Klinik Tirta Medical Center Tabalong', 2, 6, '63', '6309', 'Jalan Mabu\'un Raya RT. 004 Kel. Mabu\'un Raya, Kec. Murung Pudak, Kab. Tabalong, Kalimantan Selatan', '-', '-', '-', 'E - 059 Dt', '2020-08-25 03:46:16', '2020-08-25 03:46:16'),
(272, 282, 'Primera Clinica', 2, 6, '63', '6309', 'Perum Proper Green Village Ruko A No. 22 - 22 Jalan Mabuun Raya, Kec. Murung Pudak', '-', 'Bella', '081549233026', 'E - 060 Dt', '2020-08-26 02:59:28', '2020-08-26 02:59:28'),
(273, 283, 'Puskesmas Landasan Ulin', 1, 5, '63', '6372', 'Jalan Ahmad Yani KM. 23,5 Komplek Sinar Lestari RT.001 RW.003 Kel. Landasan Ulin Kec, Liang Anggang', '-', 'Mariyatul', '081253008005', 'E - 061 Dt', '2020-08-28 07:16:15', '2020-08-28 07:40:33'),
(274, 284, 'Puskesmas Pendang', 1, 5, '62', '6204', 'Jalan Pembangunan RT. 13 RW. VI, Kel. nO. 33 Pendang, Kec. Dusun Utara', '-', 'Dinkes Barito Selatan', '-', 'E - 062 Dt', '2020-08-31 01:57:41', '2020-08-31 01:57:41'),
(275, 285, 'Klinik Tirta Medical Centre Angsana', 2, 6, '63', '6310', 'Jalan Desa Karang Indah RT. 11, Kec. Angsana, Kab. Tanah Bumbu, Kalimantan Selatan', '-', 'Muhammad Irwan', '-', 'E - 063 Dt', '2020-09-01 07:50:41', '2020-09-01 07:50:41'),
(276, 286, 'Klinik Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan Mabu\'un Raya RT. 004 Kel. Mabu\'un Raya, Kec. Murung Pudak, Kab. Tabalong, Kalimantan Selatan', '-', '-', '-', 'E - 064 Dt', '2020-09-04 08:50:00', '2020-09-04 08:50:00'),
(277, 287, 'Laboratorium Klinik Kimia Farma Banjarmasin', 2, NULL, NULL, NULL, 'Jalan S. Parman No. 42,', '0511 336211', 'Wiwik', '082351255505', 'E - 065 Dt', '2020-09-07 08:19:21', '2020-09-09 00:27:56'),
(278, 288, 'Puskesmas Sungai Karias', 1, NULL, NULL, NULL, 'Jalan Bihman Villa RT 03 No. 33, Kec. Amuntai Tengah', '-', 'Wiwin', '081348882010', 'E - 066 Dt', '2020-09-09 01:04:03', '2020-09-09 01:04:03'),
(279, 289, 'Puskesmas Amuntai Selatan', 1, NULL, NULL, NULL, 'Jalan Gaya Baru Desa Telaga Silaba, Kec. Amuntai Selatan', '-', 'Wiwin', '081348882010', 'E - 067 Dt', '2020-09-09 01:05:33', '2020-09-09 01:05:33'),
(280, 290, 'Puskesmas Alabio', 1, NULL, NULL, NULL, 'Jalan Istirahat No. 037, Desa Sungai Pandan Tengah, Kec. Sungai Pandan', '-', 'Wiwin', '081348882010', 'E - 068 Dt', '2020-09-09 01:09:21', '2020-09-09 01:09:21'),
(281, 291, 'Puskesmas Sungai Turak', 1, NULL, NULL, NULL, 'Jalan Simpang Tiga Sungai Turah No. 03 RT 02, Kec. Amuntai Utara', '-', 'Wiwin', '081348882010', 'E - 069 Dt', '2020-09-09 01:11:03', '2020-09-09 01:11:03'),
(282, 292, 'Puskesmas Babirik', 1, 5, '63', '6308', 'Jalan Tembok Baru No.50 RT.03 Desa Murung Panti Hilir, Kec, Babirik', '-', 'Wiwin', '081248882010', 'E - 070 Dt', '2020-09-09 06:34:11', '2020-09-09 06:34:11'),
(283, 293, 'Dinas Kesehatan Hulu Sungai Utara', 1, 8, NULL, NULL, 'Jalan Sukmarga No. 312, Sungai Malang, Kec. Amuntai Tengah', '-', 'Wiwin', '081248882010', 'E - 071 Dt', '2020-09-09 06:36:21', '2020-09-09 06:36:21'),
(284, 294, 'Puskesmas Landasan Ulin', 1, 5, '63', '6372', 'Jalan Ahmad Yani KM. 23,5 Komplek Sinar Lestari RT.001 RW.003 Kel. Landasan Ulin Kec, Liang Anggang', '-', 'Mariyatul', '081253008005', 'E - 072 Dt', '2020-09-09 06:40:03', '2020-09-11 01:40:39'),
(285, 295, 'RS Marina Permata Batu Licin', 2, 4, '63', '6310', 'Sari Gadung, Simpang Empat', '-', 'Bahran', '081348192337', 'E - 073 Dt', '2020-09-09 06:53:12', '2020-09-09 06:53:12'),
(286, 296, 'Puskesmas Landasan Ulin Timur', 1, 5, '63', '6372', 'Jalan Kenanga, Kel. Landasan Ulin Timur, Kec. Landasan Ulin', '-', 'Mustafa', '-', 'E - 074 Dt', '2020-09-10 08:29:13', '2020-09-24 03:48:37'),
(287, 297, 'Puskesmas Cempaka', 1, 5, '63', '6372', 'Jalan Mistar Cokrokusumo, RT.29/RW.09, Kel. Sungai Tiung, Kec. Cempaka', '-', 'Erlita Astuti', '-', 'E - 075 Dt', '2020-09-10 08:40:28', '2020-09-24 00:38:47'),
(288, 298, 'Puskesmas Guntung Payung', 1, 5, '63', '6372', 'Jalan Sapta Marga, Kel. Guntung Payung, Kec. Landasan Ulin', '-', 'Dinkes Kota Banjarbaru', '-', 'E - 076 Dt', '2020-09-10 08:43:49', '2020-09-10 08:43:49'),
(289, 299, 'Puskesmas Cempaka', 1, 5, '63', '6372', 'Jalan Mistar Cokrokusumo, RT.29/RW.09 Kel. Sungai Tiung, Kec. Cempaka', '-', 'Erlita Astuti', '-', 'E - 077 Dt', '2020-09-18 07:24:52', '2020-09-24 00:38:04'),
(290, 300, 'Klinik Permata Bunda Angsana', 2, 6, '63', '6310', 'Jalan Provinsi RT.9/03 Desa Sungai Cuka Kec. Satui Kab. Tanah Bumbu', '-', 'Bara Riyanto', '081386284312', 'E - 078 Dt', '2020-09-21 06:48:09', '2020-09-21 06:48:09'),
(291, 301, 'Rumah Sakit Mawar Banjarbaru', 2, 4, '63', '6372', 'Jalan Panglima Batur Timur No. 52, Kel. Loktabat Utara, Kec. Banjarbaru Utara', '-', 'Yatin', '085249489685', 'E - 079 Dt', '2020-09-28 07:19:42', '2020-09-28 07:19:42'),
(292, 302, 'PT Wahana Baratama Mining', 2, 7, '63', '6310', 'Komplek Jetty PT. WBM Desa Sungai Cuka, Kec. Satui', '6251261805', 'Frans Hernugroho', '-', 'E - 080 Dt', '2020-09-28 07:25:22', '2020-09-28 07:25:22'),
(293, 303, 'Puskesmas Liang Anggang', 1, 5, '63', '6372', 'Jalan Sukamaju No.11, Kel. Landasan Ulin Barat, Kec. Liang Anggang', '-', 'Dinkes Banjarbaru', '-', 'E - 081 Dt', '2020-09-28 07:29:40', '2020-09-28 07:29:40'),
(294, 304, 'PT. Tunas Inti Abadi Site Sebamban', 2, 7, '63', '6310', 'Jalan propinsi KM 204 DesA Sebamban baru Kec. Sungai Loban', '-', 'Iwan Budiono', '081251929525', 'E - 087 Dt', '2020-09-28 08:05:56', '2020-09-28 08:05:56'),
(295, 305, 'Puskesmas Awang Besar', 1, 5, '63', '6307', 'Jalan Desa Awang Besar RT. 05 RW. 05, Kel. Awang Besar, Kec. Barabai', '-', 'Dinkes HST', '-', 'E - 082 Dt', '2020-09-29 08:24:42', '2020-09-29 08:24:42'),
(296, 306, 'Puskesmas Kasarangan', 1, NULL, NULL, NULL, 'Jalan Raya Kasarangan, Kec. Labuan Amas Utara', '--', 'Dinkes HST', '-', 'E - 083 Dt', '2020-09-29 08:28:58', '2020-09-29 08:28:58'),
(297, 307, 'Puskemas Kambat Utara', 1, NULL, NULL, NULL, 'Desa Kambat Utara 01/1 Kec. Pandawan', '-', 'Dinkes HST', '-', 'E - 084 Dt', '2020-09-29 08:38:40', '2020-09-29 08:38:40'),
(298, 308, 'Puskesmas Pagat', 1, 5, '63', '6307', 'Desa Pagat Jalan Tanjung Pura, RT. 04 / RW. 02, Kec. Batu Benawa', '-', 'Dinkes HST', '-', 'E - 085 Dt', '2020-10-01 03:25:21', '2020-10-06 03:41:46'),
(299, 309, 'Puskesmas Durian Gantang', 1, NULL, NULL, NULL, 'Jalan Raya, RT. 04, RW. 02, Desa Durian Gantang, Kec. Labuan Amas Selatan', '-', 'Dinkes HST', '-', 'E - 086 Dt', '2020-10-01 03:34:39', '2020-10-01 03:34:39'),
(300, 310, 'Puskesmas Sungai Buluh', 1, NULL, NULL, NULL, 'Jalan Raya Sungai Buluh Kec. Labuan Amas Utara', '-', 'Dinkes HST', '-', 'E - 088 Dt', '2020-10-01 05:58:20', '2020-10-01 05:58:20'),
(301, 311, 'Puskesmas Barabai', 1, 5, '63', '6307', 'Jalan Hevea Baru, Kel. Barabai Barat, Kec. Barabai', '-', 'Dinkes HST', '-', 'E - 089 Dt', '2020-10-01 06:43:39', '2020-10-01 06:43:39'),
(302, 312, 'Puskesmas Rawat Inap Hantakan', 1, 5, '63', '6307', 'Jalan Brigjen Hasan Baseri Kec. Hantakan', '-', 'Dinkes HST', '-', 'E - 090 Dt', '2020-10-01 07:17:28', '2020-10-01 07:17:28'),
(303, 313, 'Puskemas Haruyan', 1, 5, '63', '6307', 'Jalan HM. Taher Desa RT.02 / RW.01, Desa Haruyan Seberang, Kec. Haruyan', '-', 'Dinkes HST', '-', 'E - 091 Dt', '2020-10-01 07:21:55', '2020-10-01 07:21:55'),
(304, 314, 'Puskesmas Pandawan', 1, 5, '63', '6307', 'Jalan Batuah RT. 003 RW. 002 Desa Pandawan Kec. Pandawan', '-', 'Dinkes HST', '-', 'E - 092 Dt', '2020-10-01 07:36:56', '2020-10-01 07:36:56'),
(305, 315, 'Puskesmas Birayang', 1, 5, '63', '6307', 'Jalan Merdeka RT. 009 Desa Lok Besar, Kec. Birayang', '-', 'Dinkes HST', '-', 'E - 093 Dt', '2020-10-01 07:50:44', '2020-10-01 07:50:44'),
(306, 316, 'Puskesmas Ilung', 1, 5, '63', '6307', 'Jalan H. Damanhuri Ilung, Kec. Batara', '-', 'Dinkes HST', '-', 'E - 094 Dt', '2020-10-01 07:59:23', '2020-10-01 07:59:23'),
(307, 317, 'Aesculap Medical Center', 2, 7, '64', '6471', 'Jalan Indrakila (start 03) No. 17', '-', '-', '-', 'E - 095 Dt', '2020-10-01 08:24:06', '2020-10-01 08:24:06'),
(308, 318, 'PT. Indonesia Multi Purpose Terminal', 2, 6, '63', '6371', 'Jalan Kapten Pierre Tendean No. 180 RT 17 (Jakarta : Jalan H.R. Rasuna Said)', '-', 'Dikirim', '-', 'E - 096 Dt', '2020-10-02 08:29:18', '2020-10-02 08:56:37'),
(309, 319, 'Klinik Permata Bunda Angsana', 1, 7, '63', '6310', 'Jalan Provinsi RT.9/03 Desa Sungai Cuka Kec. Satui', '-', 'Bara', '081386284312', 'E - 097 Dt', '2020-10-02 09:00:19', '2020-10-02 09:00:19'),
(310, 320, 'Laboratorium K3 Provinsi Kalimantan Selatan', 1, 6, '63', '6371', 'Jalan Brigjen H. Hasan Basry No. 56 Banjarmasin', '05113304312', 'Dani', '081348436817', 'E - 098 Dt', '2020-10-02 09:03:07', '2020-10-02 09:03:07'),
(311, 321, 'Puskesmas Liang Anggang', 1, 5, '63', '6372', 'Jalan Sukamaju No.11, Kel. Landasan Ulin Barat, Kec. Liang Anggang', '-', 'Dinkes Banjarbaru', '-', 'E - 099 Dt', '2020-10-06 03:22:03', '2020-10-06 03:22:03'),
(313, 323, 'Puskesmas Pirsus', 1, 5, '63', '6311', 'Jalan Desa Sumber Rejeki RT.14 RW.04 Kec. Juai', '-', 'Hj. Mursidah', '085249912725', 'E - 100 Dt', '2020-10-08 00:28:50', '2020-10-08 00:28:50'),
(314, 324, 'Puskesmas Halong', 1, 5, '63', '6311', 'Jalan Pembangunan RT. 5 No. 72, Kel. Halong, Kec. Halong', '-', 'Hj. Mursidah', '085249912725', 'E - 101 Dt', '2020-10-08 01:27:10', '2020-10-08 01:27:10'),
(315, 325, 'Puskesmas Paringin Selatan', 1, 5, '63', '6311', 'Jalan Tumenggung Jalil, Muara Pitap No.2 Kel. Batu Piring, Kec. Paringin Selatan', '-', 'Hj, Mursidah', '085249912725', 'E - 102 Dt', '2020-10-08 01:34:21', '2020-10-08 01:34:21'),
(316, 326, 'Puskesmas Paringin', 1, 5, '63', '6311', 'Jalan Jendral Basuki Rahmat RT.1 RW.1 No.5 Kec. Paringin', '-', 'Hj. Mursidah', '085249912725', 'E - 103 Dt', '2020-10-08 01:56:29', '2020-10-08 01:56:29'),
(317, 327, 'Puskesmas Tebing Tinggi', 1, 5, '63', '6311', 'Jalan Simpang Nadong Desa No.mor 1, Kel. Simpang Nadong, Kec. Tebing Tinggi', '-', 'Hj. Mursidah', '085249912725', 'E - 104 Dt', '2020-10-08 02:43:33', '2020-10-08 02:43:33'),
(318, 328, 'Puskesmas Awayan', 1, 5, '63', '6311', 'Jalan Ciputat Desa Putat Basiun, Kec. Awayan', '-', 'Hj. Mursidah', '085249912725', 'E - 105 Dt', '2020-10-08 02:48:38', '2020-10-08 02:48:38'),
(319, 329, 'Puskesmas Tanah Habang', 1, 5, '63', '6311', 'Jalan Jermani Husein, Kel. Tanah Habang Kanan, Kec. Lampihong', '-', 'Hj. Mursidah', '085249912725', 'E - 106 Dt', '2020-10-08 03:01:31', '2020-10-08 03:01:31'),
(320, 330, 'Puskesmas Uren', 1, 5, '63', '6311', 'Desa Uren, Kec. Halong', '-', 'Hj. Mursidah', '085249912725', 'E - 107 Dt', '2020-10-08 03:05:53', '2020-10-08 03:05:53'),
(321, 331, 'Puskesmas Batu Mandi', 1, 5, '63', '6311', 'Jalan Abdul Khair RT. 1 RW. 0, Kec. Batu Mandi', '-', 'Hj. Mursidah', '085249912725', 'E - 108 Dt', '2020-10-08 03:12:56', '2020-10-08 03:12:56'),
(322, 332, 'Klinik Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan Mabu\'un Raya RT. 004 Kel. Mabu\'un Raya, Kec. Murung Pudak, Kab. Tabalong, Kalimantan Selatan', '-', 'Muhammad Irwan', '-', 'E - 109 Dt', '2020-10-08 03:17:05', '2020-10-08 03:17:05'),
(323, 333, 'Klinik Tirta Medical Centre Banjarmasin', 2, 5, '63', '6371', 'Jalan Jendral Ahmad Yani KM 5,7 No. 7 RT/RW 08/01', '-', 'Muhammad Irwan', '-', 'E - 110 Dt', '2020-10-08 03:23:00', '2020-10-08 03:23:00'),
(324, 334, 'Sukma', 2, 8, '63', '6301', 'Jalan Ahmad Yani KM. 6 Desa Panggung, Kec. Pelaihari', '081295253305', 'Sukma', '081295253305', 'E - 111 Dt', '2020-10-09 00:37:18', '2020-10-09 00:37:18'),
(325, 335, 'Klinik Tirta Medical Centre Tabalong', 2, 6, '63', '6309', 'Jalan Mabu\'un Raya RT. 004 Kel. Mabu\'un Raya, Kec. Murung Pudak, Kab. Tabalong, Kalimantan Selatan', '-', 'Muhammad Irwan', '-', 'E - 112 Dt', '2020-10-13 00:56:19', '2020-10-13 00:56:19'),
(326, 336, 'Puskesmas Permata Kecubung', 1, 5, '62', '6206', 'Jalan Ajang Semantun No. 2, Kec. Permata Kecubung', '-', 'Dinkes Sukamara', '-', 'E - 113 Dt', '2020-10-14 01:52:13', '2020-10-14 01:52:13'),
(327, 337, 'Puskesmas Sukamara', 1, 5, '62', '6206', 'Jalan P. Sukarma No. 27, Mendawai, Kec. Sukamara', '-', 'Dinkes Sukamara', '-', 'E - 114 Dt', '2020-10-14 02:00:30', '2020-10-14 02:00:30'),
(328, 338, 'Puskesmas Jelai', 1, 5, '62', '6206', 'Jalan Pada Karya No. 5 Kec. Jelai', '-', 'Dinkes Sukamara', '-', 'E - 115 Dt', '2020-10-14 02:02:28', '2020-10-14 02:02:28'),
(329, 339, 'Dinas Kesehatan Kab. Sukamara', 1, 8, '62', '6206', 'Jalan Tjilik Riwut Km No.7, Natai Sedawak, Kec. Sukamara', '-', 'Dinkes Sukamara', '-', 'E - 116 Dt', '2020-10-14 02:12:11', '2020-10-14 02:12:11'),
(330, 340, 'Klinik Tirta Medical Centre Muara Teweh', 2, 6, '62', '6205', 'Jalan Jendral Sudirman, RT 017, Melayu, Kec. Teweh Tengah,', '-', 'Muhammad Irwan', '-', 'E - 117 Dt', '2020-10-15 07:30:57', '2020-10-15 07:30:57'),
(331, 341, 'PT. Indonesia Multi Purpose Terminal', 2, 7, '63', '6371', 'Jalan Kapten Pierre Tendean No. 180 RT 17 (Jakarta : Jalan H.R. Rasuna Said)', '-', 'Dikirim', '-', 'E - 118 Dt', '2020-10-20 02:44:12', '2020-10-20 02:44:12'),
(332, 342, 'Klinik Mandiri Healthy Care', 2, 6, '63', '6302', 'Jalan Raya Stagen Desa Sei Taib, RT. 05, Komp. Purnama Indah, No. 01', '-', 'Dr. Widi', '08125136470', 'E - 119 Dt', '2020-10-20 03:10:38', '2020-10-20 03:10:38'),
(333, 343, 'drh. Arya T. Sarjananto', 2, 6, '63', '6371', 'Komplek Bunyamin 3 Blok. C1 No. 6, Jalan Mahligai, Kel. Pemurus Luar, Kec. Banjarmasin Timur', '-', 'drh. Arya T. Sarjananto', '081251516969', 'E - 120 Dt', '2020-10-20 03:22:43', '2020-10-20 03:22:43'),
(334, 345, 'IBP Clinic', 2, 6, '64', '6471', 'Kampong Teluk Waru, RT. 09, Kel. Karangau, Kec. Balikpapan Barat', '-', 'Arif', '081214735496', 'E - 121 Dt', '2020-10-20 08:29:27', '2020-10-21 06:29:46'),
(335, 346, 'Puskesmas Landasan Ulin Timur', 1, 5, '63', '6372', 'Jalan Kenanga Kel. Landasan Ulin Timur', '-', 'Dinkes Banjarbaru', '-', 'E - 122 Dt', '2020-10-20 08:33:37', '2020-10-20 08:33:37'),
(336, 347, 'Puskesmas Kambat Utara', 1, 5, '63', '6307', 'Desa Kambat Utara 01/1 Kec. Pandawan', '-', 'Dinkes HST', '-', 'E - 130 Dt', '2020-10-23 01:39:10', '2020-10-23 01:39:10'),
(337, 348, 'Puskesmas Giri Mulya', 1, 5, '63', '6310', 'Jl. Sebamban VI Blok B Ds. Giri Mulya, Kec. Kuranji', '-', 'Dinkes Tanah Bumbu', '-', 'E - 123 Dt', '2020-10-27 02:56:17', '2020-10-27 02:56:17'),
(338, 349, 'Puskesmas Batu Licin', 1, 5, '63', '6310', 'Jl. Pemerintahan No.19, Kec. Batu Licin', '-', 'Dinkes Tanah Bumbu', '-', 'E - 124 Dt', '2020-10-27 03:07:17', '2020-10-27 03:07:17'),
(340, 351, 'Puskesmas Darul Azhar', 1, 5, '63', '6310', 'Jalan Batu Benawa RT.09, Kec. Simpang Empat', '-', 'Dinkes Tanah Bumbu', '-', 'E - 125 Dt', '2020-10-27 03:30:20', '2020-10-27 03:30:20'),
(341, 352, 'Puskesmas Perawatan Sebamban II', 1, 5, '63', '6310', 'Jl. Propinsi Km. 194, Ds. Karang Indah, Kec. Angsana', '-', 'Dinkes Tanah Bumbu', '-', 'E - 126 Dt', '2020-10-27 03:44:11', '2020-10-27 03:44:11'),
(342, 353, 'Puskesmas Batulicin I', 1, 5, '63', '6310', 'Jl. Transmigrasi Km.13,5, Ds. Manunggal, Kec. Karang Bintang', '-', 'Dinkes Tanah Bumbu', '-', 'E - 127 Dt', '2020-10-27 04:01:17', '2020-10-27 04:01:17'),
(344, 355, 'Puskesmas Sebamban I', 1, 5, '63', '6310', 'Jl. Blok A Ds. Sari Mulya Sebamban, Kec. Sei Loban', '-', 'Dinkes Tanah Bumbu', '-', 'E - 128 Dt', '2020-10-27 04:23:48', '2020-10-27 04:23:48'),
(345, 356, 'Puskesmas Perawatan Satui', 1, 5, '63', '6310', 'Jl. Korea Rt. 04 Makmur Mulia, Kec. Satui', '-', 'Dinkes Tanah Bumbu', '-', 'E - 129 Dt', '2020-10-27 04:31:12', '2020-10-27 04:31:12'),
(346, 362, 'efsf', 1, 1, '63', '6310', 'fsefes', '343535', '3345', '435', '23445', '2021-01-17 10:16:04', '2021-01-17 10:16:04');

-- --------------------------------------------------------

--
-- Table structure for table `lab_detail_order`
--

CREATE TABLE `lab_detail_order` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `no_order` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alat_id` int(11) NOT NULL,
  `merek` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seri` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` int(11) NOT NULL,
  `fungsi` int(11) NOT NULL DEFAULT '1',
  `kelengkapan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_registrasi` text COLLATE utf8mb4_unicode_ci,
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `ambil` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_detail_order`
--

INSERT INTO `lab_detail_order` (`id`, `id_order`, `no_order`, `alat_id`, `merek`, `model`, `seri`, `jumlah`, `fungsi`, `kelengkapan`, `keterangan`, `no_registrasi`, `catatan`, `ambil`, `created_at`, `updated_at`) VALUES
(15, 12, 'E - 011 Dt', 12, 'RAININ', 'Pipet-Lite XLS', '-', 1, 1, 'TIP (9)', '-', NULL, 'Laik Pakai', 1, '2019-01-30 10:17:31', '2019-03-14 15:19:01'),
(18, 5, 'E - 005 Dt', 30, 'AURITEC', 'AT 409', '1757', 1, 1, 'Headphone', '-', NULL, 'Tidak Laik Pakai', 1, '2019-02-03 11:10:23', '2019-02-06 15:22:52'),
(19, 6, 'E - 006 Dt', 55, 'Elitech', 'FOX-1(N)', 'FX117BB4776', 1, 1, 'Baterai Case, Box Alat', '-', NULL, 'Laik Pakai', 1, '2019-02-05 09:52:39', '2019-02-10 09:35:43'),
(20, 6, 'E - 006 Dt', 42, 'BTL', 'BTL-08 SD', '071D0B007700', 1, 1, 'Kabel Elektrode, Kabel Lead, Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-02-05 09:55:33', '2019-02-07 10:53:34'),
(21, 6, 'E - 006 Dt', 57, 'Riester', 'nova-presameter', '160962352', 1, 1, 'Manset, Bulb', '-', NULL, 'Laik Pakai', 1, '2019-02-05 09:57:12', '2019-02-10 09:38:26'),
(22, 6, 'E - 006 Dt', 59, 'CHESTROGRAPH', 'HI-101', '1136315', 1, 1, 'Mouth piece, Flow Sensor, Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-02-05 09:59:13', '2019-02-10 09:40:41'),
(23, 6, 'E - 006 Dt', 30, 'resonance', 'R27 A', 'R27A18A000699', 1, 1, 'Headphone,Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-02-05 10:01:27', '2019-02-10 09:38:15'),
(24, 7, 'E - 007 Dt', 2, 'Lotus', 'SK Normaglass', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 0, '2019-02-11 10:12:26', '2019-02-19 09:48:18'),
(25, 8, 'E - 008 Dt', 57, 'Riester', 'nova-presameter', '064457', 1, 1, 'Manset, Bulb, Keranjang, Tiang, Roda(4)', '-', NULL, 'Laik Pakai', 0, '2019-02-11 14:42:51', '2019-02-19 09:40:31'),
(26, 8, 'E - 008 Dt', 57, 'ERKA', 'SWITCH', '11037475', 1, 1, 'Manset, Bulb, Tas', '-', NULL, 'Laik Pakai', 0, '2019-02-11 14:44:58', '2019-02-19 09:42:15'),
(27, 8, 'E - 008 Dt', 34, 'Omron', 'HEM 7320', '20171100486VG', 1, 1, 'Manset, Tas, Charger, Baterai(3)', '-', NULL, 'Laik Pakai', 0, '2019-02-11 14:46:15', '2019-02-19 09:43:35'),
(28, 8, 'E - 008 Dt', 41, 'bistos', 'HI - Bebe', 'BBHB1224', 1, 1, 'Pouch', '-', NULL, 'Laik Pakai', 0, '2019-02-11 14:48:01', '2019-02-19 09:43:45'),
(29, 8, 'E - 008 Dt', 21, 'Omron', 'NE-C28', '20120510419UF', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 0, '2019-02-11 14:50:21', '2019-02-19 09:43:43'),
(30, 8, 'E - 008 Dt', 2, 'Omron', 'MC - 245', '0318UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 0, '2019-02-11 14:52:12', '2019-02-11 16:15:15'),
(31, 8, 'E - 008 Dt', 2, 'Avico', 'AVC/T-001', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 0, '2019-02-11 14:54:07', '2019-02-11 16:15:15'),
(32, 9, 'E - 009 Dt', 30, 'resonance', 'r27a', 'R27A16D000362', 1, 1, 'Headphone, Power Cable', '-', NULL, 'Laik Pakai', 0, '2019-02-17 13:22:22', '2019-02-19 09:46:24'),
(34, 3, 'E - 002 Dt', 42, 'Esaote', 'P80', '14926', 1, 2, 'Kabel Power, Kabel Lead', '-', NULL, 'Laik Pakai', 1, '2019-02-18 09:10:23', '2019-03-25 23:49:38'),
(35, 11, 'E - 010 Dt', 34, 'Omron', 'HEM-7320', '20171100680VG', 1, 1, 'Manset, Baterai', '-', NULL, 'Laik Pakai', 0, '2019-02-18 12:08:27', '2019-02-19 09:49:30'),
(36, 11, 'E - 010 Dt', 34, 'Omron', 'HEM-7320', '20171100675VG', 1, 1, 'Manset, Baterai (8)', '-', NULL, 'Laik Pakai', 0, '2019-02-18 12:09:30', '2019-02-19 09:49:32'),
(37, 11, 'E - 010 Dt', 34, 'Omron', 'HEM-7320', '20171100679VG', 1, 1, 'Manset, Baterai (8)', '-', NULL, 'Laik Pakai', 0, '2019-02-18 12:10:35', '2019-02-19 09:49:33'),
(38, 11, 'E - 010 Dt', 34, 'Omron', 'T9P (HEM-759P-C1)', '20110300033LF', 1, 1, 'Manset, Baterai (8)', '-', NULL, 'Laik Pakai', 0, '2019-02-18 12:11:50', '2019-02-19 09:49:36'),
(39, 11, 'E - 010 Dt', 34, 'Omron', 'HEM-7322', '20160601512VG', 1, 1, 'Manset, Baterai (8)', '-', NULL, 'Laik Pakai', 0, '2019-02-18 12:12:49', '2019-02-19 09:49:49'),
(40, 12, 'E - 011 Dt', 57, 'MDF', 'MDF11', '3043961', 1, 1, 'Bulb dan Manset', '-', NULL, 'Laik Pakai', 1, '2019-02-19 14:10:53', '2019-03-14 15:19:01'),
(41, 12, 'E - 011 Dt', 34, 'OMRON', 'HE,-7200', '20141101079VG', 1, 1, 'Manset dan baterai (5)', '-', NULL, 'Laik Pakai', 1, '2019-02-19 14:14:06', '2019-03-14 15:19:01'),
(45, 14, 'E - 012 Dt', 35, 'K', 'PLC-03', '1515178', 1, 1, '-', '-', NULL, 'Laik Pakai', 0, '2019-02-24 21:07:15', '2019-03-03 18:15:42'),
(46, 15, 'E - 013 Dt', 59, 'NIR', 'spirobank II', 'A23-0Y', 1, 1, 'Kabel data', '-', NULL, 'Laik Pakai', 0, '2019-02-27 00:39:56', '2019-03-04 17:25:31'),
(47, 15, 'E - 013 Dt', 9, 'LAICA', 'BF2051', 'PPO-30831501', 1, 1, '-', '-', NULL, 'Laik Pakai', 0, '2019-02-27 00:41:43', '2019-03-04 17:25:35'),
(48, 15, 'E - 013 Dt', 42, 'mindray', 'BeneHeart R3', 'FK-69009298', 1, 1, 'Kabel power, lead', '-', NULL, 'Laik Pakai', 0, '2019-02-27 00:43:46', '2019-03-03 19:02:33'),
(49, 15, 'E - 013 Dt', 30, 'Harminics', 'X3', '4010', 1, 1, 'headphone, bone', '-', NULL, 'Tidak Laik Pakai', 0, '2019-02-27 00:46:25', '2019-03-03 19:02:43'),
(51, 17, 'E - 015 Dt', 37, 'life POINT', 'PRO AED', '174080211', 1, 1, 'Elektroda', '-', NULL, 'Laik Pakai', 0, '2019-03-05 21:19:40', '2019-03-10 22:29:22'),
(52, 18, 'E - 016 Dt', 57, 'Riester', 'nova-presameter', '160660840', 1, 1, 'Meteran badan', '-', NULL, 'Laik Pakai', 0, '2019-03-05 21:23:28', '2019-03-10 22:28:40'),
(53, 19, 'E - 017 Dt', 42, 'mindray', 'BeneHeart R3', 'FK-81013380', 1, 1, 'Cable patient, cable power', '-', NULL, 'Laik Pakai', 0, '2019-03-07 23:47:58', '2019-03-28 01:55:54'),
(54, 19, 'E - 017 Dt', 59, '-', 'MSA99', 'MSA611804050', 1, 1, 'Mouthpiece, cable power', '-', NULL, 'Laik Pakai', 0, '2019-03-07 23:49:56', '2019-03-28 01:57:19'),
(55, 19, 'E - 017 Dt', 30, 'resonance', 'R27A DD45', 'R27A16L000464', 1, 1, 'Headphone, Cable Power', '-', NULL, 'Laik Pakai', 0, '2019-03-07 23:51:45', '2019-03-28 01:57:41'),
(56, 20, 'E - 018 Dt', 35, 'H-C-12', '-', 'J9008', 1, 1, '-', 'Tidak ada Kabel Power', NULL, 'Laik Pakai', 1, '2019-03-13 17:37:42', '2019-03-18 18:51:01'),
(57, 21, 'E - 019 Dt', 42, 'Bionet', 'CardioCare - 2000', 'EO - 0F0300308', 1, 1, 'Patient Cable, Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-03-13 19:12:35', '2019-03-19 19:00:14'),
(59, 21, 'E - 019 Dt', 57, 'Riester', 'nova-presameter', '074412', 1, 1, 'Manset', '-', NULL, 'Laik Pakai', 1, '2019-03-13 19:15:15', '2019-03-19 19:00:14'),
(60, 21, 'E - 019 Dt', 26, 'OneMed', 'YB-DX23B', '12N9-108', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-03-13 19:16:20', '2019-03-19 19:00:14'),
(61, 21, 'E - 019 Dt', 34, 'Omron', 'HEM - 7130', '201701218945VG', 1, 1, 'Battery (4)', '-', NULL, 'Laik Pakai', 1, '2019-03-13 19:19:50', '2019-03-19 19:00:14'),
(62, 21, 'E - 019 Dt', 34, 'Omron', 'HEM - 8712', '20150600233VG', 1, 1, 'Manset', 'Tanpa Baterai', NULL, 'Laik Pakai', 1, '2019-03-13 19:21:25', '2019-03-19 19:00:14'),
(63, 21, 'E - 019 Dt', 34, 'Omron', 'HEM - 7130', '20180108645VG', 1, 1, 'Manset', 'Tanpa Baterai', NULL, 'Laik Pakai', 1, '2019-03-13 19:22:18', '2019-03-19 19:00:14'),
(66, 21, 'E - 019 Dt', 26, 'GEA Medical', 'YB - DX23B', 'BR.12.186', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-03-13 19:24:21', '2019-03-19 19:00:14'),
(67, 21, 'E - 019 Dt', 41, 'bistos', 'HI - bebe', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-13 19:24:54', '2019-03-19 19:00:14'),
(68, 21, 'E - 019 Dt', 57, 'ABN', 'PRECISION', '639134', 1, 1, '-', 'Kunci Penutup Rusak', NULL, 'Laik Pakai', 1, '2019-03-13 19:29:27', '2019-03-19 19:00:14'),
(69, 21, 'E - 019 Dt', 48, 'Terumo', 'TE - 112', '1202000147', 1, 1, 'drip sensor', '-', NULL, 'Laik Pakai', 1, '2019-03-13 19:31:03', '2019-03-19 19:00:14'),
(70, 21, 'E - 019 Dt', 62, 'TERUMO', 'TE - 831', '1112000380', 1, 1, '-', 'Tanpa kabel power', NULL, 'Laik Pakai', 1, '2019-03-13 19:38:23', '2019-03-19 19:00:14'),
(71, 21, 'E - 019 Dt', 48, 'TERUMO', 'TE - 172', '1305000071', 1, 1, '-', 'Tanpa Drip Sensor', NULL, 'Laik Pakai', 1, '2019-03-13 19:40:11', '2019-03-19 19:00:14'),
(72, 21, 'E - 019 Dt', 62, 'TERUMO', 'TE - 331', '1304000121', 1, 1, '-', 'Tanpa Kabel power', NULL, 'Laik Pakai', 1, '2019-03-13 19:42:41', '2019-03-19 19:00:14'),
(73, 21, 'E - 019 Dt', 55, 'CONTEC', 'CMS50M', 'MZ1610202686', 1, 1, 'Bungkus', '-', NULL, 'Laik Pakai', 1, '2019-03-13 19:46:32', '2019-03-19 19:00:14'),
(75, 21, 'E - 019 Dt', 21, 'Omron', 'COMP AIR Pro', '20100800374UF', 1, 1, '-', 'Belum dilakukan pemeriksaan', NULL, 'Batal dikalibrasi', 0, '2019-03-13 19:53:19', '2019-03-19 19:50:42'),
(76, 21, 'E - 019 Dt', 21, 'Omron', 'COMP AIR Pro', '20110704027UF', 1, 1, '-', 'Belum dilakukan pemeriksaan', NULL, 'Laik Pakai', 1, '2019-03-13 19:54:14', '2019-03-19 19:00:14'),
(77, 21, 'E - 019 Dt', 32, 'Elitech', 'PM9000+', 'PM21206B0022', 1, 1, 'Manset, SPO2, Patient Cable, Kabel POwer', '-', NULL, 'Laik Pakai', 1, '2019-03-13 20:01:43', '2019-03-19 19:00:14'),
(78, 22, 'E - 020 Dt', 2, 'OMRON', 'MC-246', '0831UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-13 22:04:13', '2019-04-24 08:28:37'),
(79, 12, 'E - 011 Dt', 12, 'RAININ', 'Pipet-Lite XLS', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-13 22:31:34', '2019-03-14 15:19:01'),
(80, 23, 'E - 022 Dt', 10, 'Bibby Sterilin', '-', 'ES46427', 1, 1, 'TIP (1)', '5 uL', NULL, 'Laik Pakai', 1, '2019-03-13 22:41:23', '2019-04-24 08:23:30'),
(84, 25, 'E - 021 Dt', 57, 'Lotus', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-14 19:58:15', '2019-05-10 05:43:06'),
(85, 25, 'E - 021 Dt', 59, 'CONTEC', 'SP10', 'JE1603200156', 1, 1, 'Kotak, Charger', '-', NULL, 'Laik Pakai', 1, '2019-03-14 19:59:25', '2019-05-10 05:43:06'),
(86, 21, 'E - 019 Dt', 57, 'Riester', 'nova-presameter', '081640', 1, 1, 'Manset', '-', NULL, 'Laik Pakai', 1, '2019-03-18 17:45:50', '2019-03-19 19:00:14'),
(88, 26, 'E - 023 Dt', 41, 'Bistos', 'BT-220', 'BGEB0475', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 17:55:02', '2019-04-25 01:01:41'),
(89, 26, 'E - 023 Dt', 57, 'ABN', 'SPECTRUM', '965683', 1, 1, 'Manset Bulb', '-', NULL, 'Laik Pakai', 1, '2019-03-20 17:56:31', '2019-04-25 01:01:41'),
(90, 26, 'E - 023 Dt', 21, 'ABN', 'Compamist1', '1214656A', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 17:57:56', '2019-04-25 01:01:41'),
(91, 26, 'E - 023 Dt', 12, 'ONEMED', 'DRAGON', 'YL172AA0024709', 1, 1, '-', '50-200 uL', NULL, 'Laik Pakai', 1, '2019-03-20 17:59:46', '2019-04-25 01:01:41'),
(92, 26, 'E - 023 Dt', 12, 'ONEMED', 'DRAGON', 'YL172AA0024487', 1, 1, '-', '5-50uL', NULL, 'Laik Pakai', 1, '2019-03-20 18:00:37', '2019-04-25 01:01:41'),
(93, 26, 'E - 023 Dt', 34, 'Dr.Care', 'HL-888', '1708038600', 1, 1, 'Baterai 4 pcs', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:02:18', '2019-04-25 01:01:41'),
(94, 26, 'E - 023 Dt', 2, 'GP Care', '-', 'AKL-20901900848', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:08:44', '2019-04-25 01:01:41'),
(96, 26, 'E - 023 Dt', 55, 'ACARE', 'AH-MX', 'M21844872', 1, 1, 'Sensor SpO2, Kabel Power, Docking', 'tidak ada baterai', NULL, 'Laik Pakai', 1, '2019-03-20 18:14:35', '2019-04-25 01:01:41'),
(97, 26, 'E - 023 Dt', 35, 'K', 'PLC-05', '007305', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:16:10', '2019-04-25 01:01:41'),
(98, 26, 'E - 023 Dt', 55, 'ACARE', 'AH-MX', 'M21845774', 1, 1, 'Kabel Power, Docking, Sensor SpO2,Baterai', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:18:06', '2019-04-25 01:01:41'),
(99, 26, 'E - 023 Dt', 35, 'hanil', 'MF 50', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:19:32', '2019-04-25 01:01:41'),
(100, 26, 'E - 023 Dt', 57, 'OneMed', '-', '878277', 1, 1, 'Manset, Bulb, Tas', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:26:35', '2019-04-25 01:01:41'),
(101, 26, 'E - 023 Dt', 57, 'ABN', 'SPECTRUM', '879735', 1, 1, 'Manset, Bulb', '-', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 18:27:36', '2019-04-25 01:01:41'),
(102, 26, 'E - 023 Dt', 57, 'OneMed', '-', '089835', 1, 1, 'Manset, Bulb', '-', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 18:28:35', '2019-04-25 01:01:41'),
(103, 26, 'E - 023 Dt', 57, 'ABN', '-', '742993', 1, 1, 'Manset, Bulb', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:41:11', '2019-04-25 01:01:41'),
(104, 26, 'E - 023 Dt', 57, 'General Care', '-', '-', 1, 1, 'Manset, Bulb', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:42:18', '2019-04-25 01:01:41'),
(105, 26, 'E - 023 Dt', 57, 'General Care', '-', '-', 1, 1, 'Manset, Bulb', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:43:44', '2019-04-25 01:01:41'),
(106, 26, 'E - 023 Dt', 2, 'Dr,Care', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:45:23', '2019-04-25 01:01:41'),
(107, 26, 'E - 023 Dt', 2, 'Dr,Care', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:47:31', '2019-04-25 01:01:41'),
(108, 26, 'E - 023 Dt', 18, 'Bistos', 'BT-410', 'ECGA0061', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 18:48:23', '2019-04-25 01:01:41'),
(109, 26, 'E - 023 Dt', 41, 'JUMPER', 'JDP-100B+', '8330100B+02333', 1, 1, 'Tas, Charger, Baterai (2), Sensor SpO2', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:03:47', '2019-04-25 01:01:41'),
(111, 27, 'E - 024 Dt', 57, 'ABN', 'PRECISION', '940647', 1, 1, 'Bulb, Manset', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:19:55', '2019-04-25 01:02:25'),
(112, 27, 'E - 024 Dt', 58, 'ABN', 'DM-500', '121000530', 1, 1, 'Bulb, Manset', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:21:14', '2019-04-25 01:02:25'),
(113, 27, 'E - 024 Dt', 12, 'DRAGON', '-', 'DX66350', 1, 1, '-', '100-1000 uL', NULL, 'Laik Pakai', 1, '2019-03-20 19:22:37', '2019-04-25 01:02:25'),
(114, 27, 'E - 024 Dt', 12, 'DRAGONMED-', '-', '-', 1, 1, '-', '5-50uL', NULL, 'Laik Pakai', 1, '2019-03-20 19:23:25', '2019-04-25 01:02:25'),
(115, 27, 'E - 024 Dt', 12, 'DRAGON ONEMED', '-', 'YL16BAA0010036', 1, 1, '-', '200-1000uL', NULL, 'Laik Pakai', 1, '2019-03-20 19:24:28', '2019-04-25 01:02:25'),
(116, 27, 'E - 024 Dt', 35, 'K', 'PLC-03', '7606990', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:26:15', '2019-04-25 01:02:25'),
(117, 27, 'E - 024 Dt', 35, 'hanil', 'MF-50', 'NMOK1822076', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:27:18', '2019-04-25 01:02:25'),
(118, 27, 'E - 024 Dt', 51, 'K', 'Orbital Shakers', '1615071', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:28:05', '2019-04-25 01:02:25'),
(119, 28, 'E - 025 Dt', 35, 'K', 'PLC-03', '006498', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:37:16', '2019-04-25 01:02:52'),
(120, 29, 'E - 026 Dt', 58, 'ABN', 'DM-500', '121000590', 1, 1, 'Bulb, Manset', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:42:05', '2019-04-25 01:03:11'),
(121, 29, 'E - 026 Dt', 58, 'ABN', 'DM-500', '121000594', 1, 1, 'Manset, Bulb', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:42:45', '2019-04-25 01:03:11'),
(122, 26, 'E - 023 Dt', 41, 'bistos', 'BT-200', '-', 1, 1, 'Baterai 2 pcs', 'Tidak ada tutup baterai', NULL, 'Laik Pakai', 1, '2019-03-20 19:46:29', '2019-04-25 01:01:41'),
(123, 26, 'E - 023 Dt', 41, 'Bistos', 'BT-220', 'BFEB4238', 1, 1, 'Baterai 2pcs', '-', NULL, 'Laik Pakai', 1, '2019-03-20 19:48:26', '2019-04-25 01:01:41'),
(124, 30, 'E - 027 Dt', 12, 'ONEMED', 'DRAGON', 'YL4A038464', 1, 1, '-', '20-1000', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 19:56:54', '2019-04-25 01:03:28'),
(125, 30, 'E - 027 Dt', 12, 'ONEMED', 'DRAGON', 'YL4A038366', 1, 1, '-', '20-1000', NULL, 'Laik Pakai', 1, '2019-03-20 19:58:39', '2019-04-25 01:03:28'),
(126, 30, 'E - 027 Dt', 12, 'ONEMED', 'DRAGON', 'CU0039660', 1, 1, '-', '50-200', NULL, 'Laik Pakai', 1, '2019-03-20 19:59:27', '2019-04-25 01:03:28'),
(127, 30, 'E - 027 Dt', 12, 'DRAGON', 'ONEMED', 'YL6A143811', 1, 1, '-', '5-50uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:02:35', '2019-04-25 01:03:28'),
(128, 30, 'E - 027 Dt', 12, 'ONEMED', 'DRAGON', 'CU0039662', 1, 1, '-', '50-200uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:03:24', '2019-04-25 01:03:28'),
(129, 30, 'E - 027 Dt', 12, 'SOCOREX', 'Accura 825', '19091009', 1, 1, '-', '1-10uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:04:26', '2019-04-25 01:03:28'),
(130, 30, 'E - 027 Dt', 35, 'K', 'KHT-410E', '1603584', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:05:17', '2019-04-25 01:03:28'),
(131, 30, 'E - 027 Dt', 35, 'Digisystem', 'DSC-200A-2', '0911256', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:06:57', '2019-04-25 01:03:28'),
(132, 30, 'E - 027 Dt', 35, 'K', 'PLC-03', '007304', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:07:50', '2019-04-25 01:03:28'),
(133, 16, 'E - 014 Dt', 2, 'AVICO', '-', '-', 5, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:08:44', '2019-04-22 06:40:23'),
(134, 16, 'E - 014 Dt', 10, 'ENDO', 'PRO MICROPIPETTE', 'N11035483', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:09:25', '2019-04-22 06:40:27'),
(135, 30, 'E - 027 Dt', 51, 'K', 'VRN-210', '1316174', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:09:28', '2019-04-25 01:03:28'),
(136, 16, 'E - 014 Dt', 10, 'AccuMax', '-', '032514', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:10:02', '2019-04-22 06:40:29'),
(137, 16, 'E - 014 Dt', 10, 'AccuMax', '-', '019881', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:10:35', '2019-04-22 06:40:34'),
(138, 16, 'E - 014 Dt', 10, 'DragonLAB', '-', 'YL3K023922', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:11:29', '2019-04-22 06:40:40'),
(139, 16, 'E - 014 Dt', 10, 'DragonLAB', '-', 'YE4A263058', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:12:19', '2019-04-22 06:40:52'),
(140, 16, 'E - 014 Dt', 10, 'DragonMED', '-', 'HU17562', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:14:15', '2019-04-22 06:43:09'),
(141, 32, 'E - 033 Dt', 57, 'Riester', 'nova-presameter', '161161566', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:18:19', '2019-03-28 02:34:50'),
(142, 31, 'E - 028 Dt', 41, 'Bistos', 'BT-200', 'BD0703-16', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:18:33', '2019-04-25 01:03:42'),
(143, 32, 'E - 033 Dt', 57, 'Riester', 'nova-presameter', '161161548', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:18:52', '2019-03-28 02:34:50'),
(144, 32, 'E - 033 Dt', 55, 'Elitech', '-', 'FX117BB5968', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:19:26', '2019-03-28 02:34:50'),
(145, 31, 'E - 028 Dt', 41, 'Bistos', 'BT-200', 'BABA41380', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:20:06', '2019-04-25 01:03:42'),
(146, 32, 'E - 033 Dt', 59, 'CHEST', 'Chestgraph HI-101', '1136569', 1, 1, 'Kabel Power', 'Kalibrasi menunggu petugas datang', NULL, 'Laik Pakai', 1, '2019-03-20 20:20:40', '2019-03-28 02:34:50'),
(147, 31, 'E - 028 Dt', 57, 'ABN', 'SPECTRUM', '809581', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:20:49', '2019-04-25 01:03:42'),
(148, 31, 'E - 028 Dt', 58, 'ABN', 'DM-500', '121000534', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:21:33', '2019-04-25 01:03:42'),
(149, 32, 'E - 033 Dt', 42, 'BLT', 'E - 30', 'E066E003277', 1, 1, 'Kabel Lead, Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:21:36', '2019-03-28 02:34:50'),
(150, 31, 'E - 028 Dt', 12, 'DRAGONONEMED', '-', 'TLI6BA00191', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:22:29', '2019-04-25 01:03:42'),
(151, 32, 'E - 033 Dt', 30, 'Resonance', 'R27A DD45', 'R27A18B000715', 1, 1, 'Kabel Power, Headset', 'Kalibrasi Menunggu Petugas Datang', NULL, 'Laik Pakai', 1, '2019-03-20 20:22:31', '2019-03-28 02:34:50'),
(152, 33, 'E - 029 Dt', 12, 'SOCOREX', 'ACURA 825', '19091187', 1, 1, '-', '10-100uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:31:15', '2019-04-25 01:03:56'),
(153, 33, 'E - 029 Dt', 12, 'SOCOREX', 'ACURA 825', '19071562', 1, 1, '-', '1-10uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:32:10', '2019-04-25 01:03:56'),
(154, 33, 'E - 029 Dt', 12, 'SOCOREX', 'ACURA 825', '1901223', 1, 1, '-', '100-1000uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:33:29', '2019-04-25 01:03:56'),
(155, 34, 'E - 030 Dt', 41, 'Serenity', 'SR - 100', '8331SR10000179', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:33:33', '2019-04-25 01:04:10'),
(156, 34, 'E - 030 Dt', 41, 'Bistos', 'HI. Bebe', 'BABD42863', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:34:14', '2019-04-25 01:04:10'),
(157, 33, 'E - 029 Dt', 51, 'Digisystem', 'DSR-2800A', '0911578', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:34:49', '2019-04-25 01:03:56'),
(158, 34, 'E - 030 Dt', 41, 'bistos', 'HI.Bebe', 'BABC60234', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:34:51', '2019-04-25 01:04:10'),
(159, 34, 'E - 030 Dt', 57, 'ABN', 'PRECISION', '775983', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:35:29', '2019-04-25 01:04:10'),
(160, 33, 'E - 029 Dt', 21, '3A', 'ATOMIZER', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:35:37', '2019-04-25 01:03:56'),
(161, 34, 'E - 030 Dt', 57, 'ABN', 'PRECISION', '940859', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:36:02', '2019-04-25 01:04:10'),
(162, 33, 'E - 029 Dt', 57, 'ABN', 'SPECTRUM', '858811', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:36:20', '2019-04-25 01:03:56'),
(164, 34, 'E - 030 Dt', 57, 'ABN', 'PRECISION', '940794', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:36:26', '2019-04-25 01:04:10'),
(165, 34, 'E - 030 Dt', 57, 'ABN', 'SPECTRUM', '816785', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:36:53', '2019-04-25 01:04:10'),
(166, 33, 'E - 029 Dt', 35, 'K', 'PLC-03', '006577', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:37:13', '2019-04-25 01:03:56'),
(167, 34, 'E - 030 Dt', 57, 'ABN', 'SPECTRUM', '342075', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:37:19', '2019-04-25 01:04:10'),
(168, 34, 'E - 030 Dt', 12, 'DRAGON ONEMED', '-', 'YL16BAA0010025', 1, 1, '-', '200 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:38:12', '2019-04-25 01:04:10'),
(169, 34, 'E - 030 Dt', 12, 'DRAGON ONEMED', '-', 'YL16BAA0010112', 1, 1, '-', '50 - 200 uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:39:06', '2019-04-25 01:04:10'),
(170, 34, 'E - 030 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:39:28', '2019-04-25 01:04:10'),
(171, 36, 'E - 031 Dt', 42, 'BTL', 'BTL - 08', '0710 - B - 02369', 1, 1, 'Kabel [ower, kabel pasien', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:50:54', '2019-04-25 01:04:24'),
(172, 36, 'E - 031 Dt', 12, 'DRAGON ONEMED', '-', 'YL172AA0024473', 1, 1, '-', '5-50ul', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 20:52:03', '2019-04-25 01:04:24'),
(173, 37, 'E - 032 Dt', 41, 'Bistos', '-', 'BABC60236', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:53:00', '2019-04-25 01:04:40'),
(174, 36, 'E - 031 Dt', 12, 'DRAGON LAB', '-', 'DX66333', 1, 1, '-', '100-1000 ul', NULL, 'Laik Pakai', 1, '2019-03-20 20:53:07', '2019-04-25 01:04:24'),
(175, 37, 'E - 032 Dt', 41, 'Bistos', 'Bt- 200', 'BABD11918', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:53:28', '2019-04-25 01:04:40'),
(176, 36, 'E - 031 Dt', 9, 'kenko', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:53:42', '2019-04-25 01:04:24'),
(177, 37, 'E - 032 Dt', 41, 'Bistos', 'Bt - 200', 'BABD11920', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:54:00', '2019-04-25 01:04:40'),
(178, 37, 'E - 032 Dt', 41, 'Bistos', 'Bt - 200', 'BABC60237', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:54:35', '2019-04-25 01:04:40'),
(179, 37, 'E - 032 Dt', 26, '-', 'AC - 809', '19244', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:55:07', '2019-04-25 01:04:40'),
(180, 36, 'E - 031 Dt', 21, 'nebtime', 'UN300A', '1309020011', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:55:27', '2019-04-25 01:04:24'),
(181, 37, 'E - 032 Dt', 12, 'DRAGONMED', '-', 'DV31440', 1, 1, '-', '5 - 50 uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:55:49', '2019-04-25 01:04:40'),
(182, 37, 'E - 032 Dt', 12, 'DRAGONLAB', '-', 'DX66325', 1, 1, '-', '100 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:56:22', '2019-04-25 01:04:40'),
(183, 37, 'E - 032 Dt', 12, 'ONE MED', '-', 'CU0039571', 1, 1, '-', '50 - 200 uL', NULL, 'Laik Pakai', 1, '2019-03-20 20:58:45', '2019-04-25 01:04:40'),
(184, 37, 'E - 032 Dt', 21, 'PRIZMA', 'PRIZJET', '201617011752', 1, 1, 'Tas, Tubing, Mouthpiece (2), Tempat obat (2), Kabel power', '-', NULL, 'Laik Pakai', 1, '2019-03-20 20:59:49', '2019-04-25 01:04:40'),
(185, 37, 'E - 032 Dt', 57, 'General Care', '-', '-', 1, 1, 'Tas', 'Retak dibagian Kaca', NULL, 'Laik Pakai', 1, '2019-03-20 21:00:27', '2019-04-25 01:04:40'),
(186, 37, 'E - 032 Dt', 57, 'ABN', 'PRECISION', '742669', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 21:00:50', '2019-04-25 01:04:40'),
(187, 38, 'E - 034 Dt', 9, 'Kenko', 'DB-01', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 21:52:43', '2019-05-02 01:01:28'),
(188, 38, 'E - 034 Dt', 26, 'Elmaslar', 'LIFETIME', 'SA081500112', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 21:53:45', '2019-05-02 01:01:28'),
(189, 38, 'E - 034 Dt', 22, 'AIRSER', 'MEMLIFE', 'BUBO115120261', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 21:55:16', '2019-05-02 01:01:28'),
(192, 39, 'E - 035 Dt', 34, 'OMRON', 'HEM-7203', '20120513920VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:06:52', '2019-05-02 01:11:18'),
(193, 39, 'E - 035 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:07:30', '2019-05-02 01:11:18'),
(194, 39, 'E - 035 Dt', 41, 'Bistos', 'BT-220', 'BFEE1082', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:08:19', '2019-05-02 01:11:18'),
(195, 39, 'E - 035 Dt', 41, 'Bistos', 'BT-220', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:09:03', '2019-05-02 01:11:18'),
(196, 39, 'E - 035 Dt', 22, 'bitmos', 'oxy5000', '0517040845', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:10:08', '2019-05-02 01:11:18'),
(197, 39, 'E - 035 Dt', 61, 'CYAN', 'CL 012', '1210187', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:11:17', '2019-05-02 01:11:18'),
(198, 39, 'E - 035 Dt', 57, 'SPYGMED', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:12:44', '2019-05-02 01:11:18'),
(199, 39, 'E - 035 Dt', 57, 'ERKA', 'Erkameter 3000', '14510055', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:15:11', '2019-05-02 01:11:18'),
(200, 39, 'E - 035 Dt', 57, 'SPHYGMED', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:15:52', '2019-05-02 01:11:18'),
(201, 39, 'E - 035 Dt', 57, 'OneMed', '-', '541909', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:16:33', '2019-05-02 01:11:18'),
(203, 42, 'E - 039 Dt', 57, 'ERKA', 'Erkameter 3000', '13522201', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:44:44', '2019-05-02 01:19:35'),
(205, 43, 'E - 036 Dt', 21, 'Beurer', 'IH 25/1', 'Z28/003258', 1, 1, 'Tas, Tubing', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:45:51', '2019-05-02 01:17:09'),
(206, 43, 'E - 036 Dt', 22, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:46:31', '2019-05-02 01:17:09'),
(207, 42, 'E - 039 Dt', 42, 'MEDIGATE', 'MECA303i', 'MD095151102013', 1, 1, 'lead, kabel power, elektroda, driver', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:47:22', '2019-05-02 01:19:35'),
(208, 43, 'E - 036 Dt', 66, 'Mindray', 'PP - 20', '6R-5A002484', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:47:30', '2019-05-02 01:17:09'),
(210, 42, 'E - 039 Dt', 57, 'ERKA', 'klinikerkameter', '14301522', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:49:06', '2019-05-02 01:19:35'),
(211, 42, 'E - 039 Dt', 22, 'SANI INTEROXY', '-', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 22:50:11', '2019-05-02 01:19:35'),
(212, 44, 'E - 037 Dt', 9, 'Infant Scale', 'RGZ - 20', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:50:50', '2019-05-02 01:18:12'),
(213, 42, 'E - 039 Dt', 66, 'mindray', 'BP -20', 'GR - 5A002482', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:51:14', '2019-05-02 01:19:35'),
(214, 44, 'E - 037 Dt', 34, 'OMRON', 'M - 8712', '2018081616775VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:51:39', '2019-05-02 01:18:12'),
(215, 44, 'E - 037 Dt', 21, 'Beurer', 'IH 25/1', 'Z28/004727', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:52:46', '2019-05-02 01:18:12'),
(216, 44, 'E - 037 Dt', 34, 'Dr. Care', 'HL 888', '1708038854', 1, 1, 'Baterai 4 , Tas', '-', NULL, 'Laik Pakai', 1, '2019-03-20 22:53:21', '2019-05-02 01:18:12'),
(218, 44, 'E - 037 Dt', 57, 'ERKA', 'Erkameter 3000', '13522200', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 22:55:39', '2019-05-02 01:18:12'),
(220, 45, 'E - 038 Dt', 9, 'Serenity', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:04:09', '2019-05-02 01:18:46'),
(221, 45, 'E - 038 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:04:28', '2019-05-02 01:18:46'),
(222, 45, 'E - 038 Dt', 57, 'OneMed', '-', '1173348', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:05:13', '2019-05-02 01:18:46'),
(223, 45, 'E - 038 Dt', 57, 'ABN', 'SPECTRUM', '824336', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:05:40', '2019-05-02 01:18:46'),
(224, 45, 'E - 038 Dt', 41, 'Bistos', 'BT-200L', 'BBJ12807', 1, 1, 'kotak', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:06:16', '2019-05-02 01:18:46'),
(225, 45, 'E - 038 Dt', 34, 'Beurer', 'BM26', '2017C29/027014', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:07:07', '2019-05-02 01:18:46'),
(226, 45, 'E - 038 Dt', 41, 'Bistos', 'BT-200', 'BBH10739', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:07:45', '2019-05-02 01:18:46'),
(227, 45, 'E - 038 Dt', 57, 'OneMed', '-', '1296983', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:08:17', '2019-05-02 01:18:46'),
(228, 45, 'E - 038 Dt', 9, 'Laica', 'BF2051', 'PPO-5060305R', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:08:59', '2019-05-02 01:18:46'),
(230, 46, 'E - 040 Dt', 57, 'ABN', 'SPECTRUM', '909768', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:11:05', '2019-05-02 01:20:06'),
(231, 46, 'E - 040 Dt', 57, 'ABN', 'SPECTRUM', '817726', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 23:12:41', '2019-05-02 01:20:06'),
(232, 46, 'E - 040 Dt', 57, 'ONEMED', '-', '1188133', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:13:51', '2019-05-02 01:20:06'),
(233, 46, 'E - 040 Dt', 58, 'PRIMAMED', '1016', '1612029000257', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 23:14:51', '2019-05-02 01:20:06'),
(234, 47, 'E - 041 Dt', 9, 'Kenko', 'DB - 6101', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:20:21', '2019-05-02 01:20:53'),
(235, 47, 'E - 041 Dt', 18, 'bistos', 'BT - 410', 'ECFA0005', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:21:33', '2019-05-02 01:20:53'),
(236, 47, 'E - 041 Dt', 57, 'GEA MEDICAL', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:22:18', '2019-05-02 01:20:53'),
(238, 47, 'E - 041 Dt', 57, 'SPHYGMED MEDICAL', '-', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-03-20 23:23:51', '2019-05-02 01:20:53'),
(239, 44, 'E - 037 Dt', 66, 'mindray', 'DP - 20', '6R - 5A002477', 1, 1, 'kabel power, probe usg', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:28:36', '2019-05-02 01:18:12'),
(241, 48, 'E - 042 Dt', 22, 'Bitmos', 'OXY5000', '0917040842', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:44:11', '2019-05-02 01:00:22'),
(242, 48, 'E - 042 Dt', 57, 'ERKA', 'Erkameter 3000', '14910097', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:44:46', '2019-05-02 01:00:22'),
(243, 48, 'E - 042 Dt', 66, 'Mindray', 'DP - 20', '6R-5A002478', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:45:38', '2019-05-02 01:00:22'),
(244, 45, 'E - 038 Dt', 66, 'MIndray', 'DP - 20', '6R - 5400245', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:56:26', '2019-05-02 01:18:46'),
(245, 45, 'E - 038 Dt', 22, 'NewLife', '-', 'BUB0115420240', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-20 23:57:15', '2019-05-02 01:18:46'),
(248, 49, 'E - 043 Dt', 21, 'SANI', 'SN 402-B', '00119', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-21 00:01:39', '2019-05-02 00:54:34'),
(250, 50, 'E - 044 Dt', 66, 'Mindray', 'DP - 20', '6R-5A002476', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-21 00:06:27', '2019-05-02 00:53:24'),
(251, 46, 'E - 040 Dt', 21, 'Beurer', 'IH 25/1', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-03-21 15:52:49', '2019-05-02 01:20:06'),
(252, 52, 'E - 045 Dt', 34, 'OMRON', 'HEM-7322', '20160601516VG', 1, 1, 'Baterai 4, Tas, Charger', '-', NULL, 'Laik Pakai', 1, '2019-03-21 19:39:38', '2019-05-09 03:00:49'),
(253, 52, 'E - 045 Dt', 34, 'OMRON', 'HEM-7322', '20160601511VG', 1, 1, 'Baterai 4 pcs, Charger, Tas', '-', NULL, 'Laik Pakai', 1, '2019-03-21 19:40:56', '2019-05-09 03:00:49'),
(254, 52, 'E - 045 Dt', 42, 'Fukuda Denshi', 'Cardimax', '25060830', 1, 1, 'Charger, Lead, Elektrode, Kotak', '-', NULL, 'Laik Pakai', 1, '2019-03-21 19:41:54', '2019-05-09 03:00:49'),
(255, 52, 'E - 045 Dt', 42, 'Fukuda Denshi', 'Cardimax', '25060831', 1, 1, 'Charger, Lead, Elektrode, Kotak', '-', NULL, 'Laik Pakai', 1, '2019-03-21 19:43:06', '2019-05-09 03:00:49'),
(258, 53, 'E - 046 Dt', 62, 'B. Braun', '-', '103665', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:16:26', '2019-04-02 02:01:41'),
(259, 53, 'E - 046 Dt', 58, 'ABN', 'DM 500', '151002421', 1, 1, 'Baterai AA (2)', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:18:09', '2019-04-02 02:01:41'),
(260, 53, 'E - 046 Dt', 32, 'Dist', 'DS 7000', '7000 - MA80', 1, 1, 'Kabel ECG, SPO2, Temp, NIBP', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:19:52', '2019-04-02 02:01:41'),
(261, 53, 'E - 046 Dt', 57, 'ABN', '-', '00205887', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:20:03', '2019-04-02 02:01:41'),
(262, 53, 'E - 046 Dt', 1, 'Biomedix', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:21:35', '2019-04-02 02:01:41'),
(263, 53, 'E - 046 Dt', 26, 'Dixion', '-', '07-01-1505-0618', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:22:18', '2019-04-02 02:01:41'),
(264, 53, 'E - 046 Dt', 1, 'Biomedix', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:23:39', '2019-04-02 02:01:41'),
(265, 53, 'E - 046 Dt', 57, 'General Medical', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:23:50', '2019-04-02 02:01:41'),
(266, 53, 'E - 046 Dt', 58, 'ABN', 'DM 500', '151002429', 1, 1, 'Baterai AA (2)', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:24:24', '2019-04-02 02:01:41'),
(267, 53, 'E - 046 Dt', 57, 'ABN', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:24:49', '2019-04-02 02:01:41'),
(268, 53, 'E - 046 Dt', 39, 'Mediana', '-', '-', 1, 1, 'Kabel PAD, Kabel PAD Disposible, Kabel ECG 3 Lead, Kabel ECG 7 Lead, SPO2, NIBP', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:26:37', '2019-04-02 02:01:41'),
(269, 53, 'E - 046 Dt', 48, 'B. Braun', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:27:10', '2019-04-02 02:01:41'),
(270, 53, 'E - 046 Dt', 55, 'Solaris', 'NT1A', 'NT1A15060219', 1, 1, 'Baterai AA (4)', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:28:00', '2019-04-02 02:01:41'),
(271, 53, 'E - 046 Dt', 26, 'Ordisi 5.A.', '-', '53114', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:28:07', '2019-04-02 02:01:41'),
(272, 53, 'E - 046 Dt', 21, 'GeaMedical', '402A1', '00095', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-01 00:29:30', '2019-04-02 02:01:41'),
(273, 54, 'E - 047 Dt', 57, 'Riester', 'nova-presameter', '161161649', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-05 03:03:45', '2019-04-12 02:47:44'),
(274, 54, 'E - 047 Dt', 35, 'K', 'PLC - 03', '1712695', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-05 03:04:17', '2019-04-12 02:47:44'),
(275, 54, 'E - 047 Dt', 59, 'CHESTGRAPH', 'HI-101', '1136315', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-05 03:05:03', '2019-04-12 02:47:44'),
(276, 55, 'E - 048 Dt', 59, 'CHESTGRAPH', 'HI - 101', '1132583', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-12 02:43:08', '2019-04-30 01:26:47'),
(277, 55, 'E - 048 Dt', 42, 'BTL', 'E 30', 'E066E004694', 1, 1, 'Elektroda', '-', NULL, 'Laik Pakai', 1, '2019-04-12 02:44:03', '2019-04-30 01:26:47'),
(278, 56, 'E - 049 Dt', 57, 'Riester', 'nova ecoline', '081274110', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-16 06:39:27', '2019-04-18 07:21:33'),
(279, 56, 'E - 049 Dt', 57, 'Riester', 'nova presameter', '970984705', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-16 06:40:50', '2019-04-18 07:21:33'),
(280, 56, 'E - 049 Dt', 30, 'MAICO', 'MA 51', '0116022', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-16 06:41:16', '2019-04-26 06:34:24'),
(281, 56, 'E - 049 Dt', 42, 'idsmed', 'MAC 600', 'SP517090020PA', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-16 06:45:11', '2019-04-26 06:32:48'),
(282, 57, 'E - 050 Dt', 34, 'A&D', 'UA-2020', 'SN51802002984', 1, 1, 'TAS, Baterai AA (3)', '-', NULL, 'Laik Pakai', 1, '2019-04-18 07:08:47', '2019-07-18 03:54:52'),
(283, 57, 'E - 050 Dt', 34, 'OMRON', 'HBP-1300', '04011409LF', 1, 1, 'Manset ukuran M dan L (2)', '-', NULL, 'Laik Pakai', 1, '2019-04-18 07:10:17', '2019-07-18 03:54:52'),
(285, 57, 'E - 050 Dt', 34, 'OMRON', 'HBP-1300', '04011410LF', 1, 1, 'Manset ukuran M dan L (2)', '-', NULL, 'Laik Pakai', 1, '2019-04-18 07:15:27', '2019-07-18 03:54:52'),
(286, 57, 'E - 050 Dt', 34, 'OMRON', 'HBP-1300', '04011407LF', 1, 1, 'Manset ukuran M dan L (2)', '-', NULL, 'Laik Pakai', 1, '2019-04-18 07:15:57', '2019-07-18 03:54:52'),
(287, 57, 'E - 050 Dt', 32, 'GE', 'B40', 'SJF15293478WA', 1, 1, 'spO2, kabel ekg dan NiBP', '-', NULL, 'Laik Pakai', 1, '2019-04-18 07:25:09', '2019-07-18 03:54:52'),
(288, 57, 'E - 050 Dt', 32, 'GE', 'B40', 'SJF1529345WA', 1, 1, 'spO2, kabel ekg dan NiBP', '-', NULL, 'Laik Pakai', 1, '2019-04-18 07:27:30', '2019-07-18 03:54:52'),
(289, 58, 'E - 051 Dt', 21, 'Atomizer', '3A', '29478 - 000', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:10:16', '2019-05-16 01:52:55'),
(290, 58, 'E - 051 Dt', 2, 'ACCURATE', '-', '01', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:10:54', '2019-05-16 01:52:55'),
(294, 58, 'E - 051 Dt', 2, 'KAWE', '-', '04', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:11:04', '2019-05-16 01:52:55'),
(295, 58, 'E - 051 Dt', 2, 'KAWE', '-', '03', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:11:05', '2019-05-16 01:52:55'),
(296, 58, 'E - 051 Dt', 2, 'ACCURATE', '-', '02', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:11:08', '2019-05-16 01:52:55'),
(299, 58, 'E - 051 Dt', 18, 'Ryne', '-', '01', 1, 1, 'Kotak, Charger', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:12:06', '2019-05-16 01:53:46'),
(300, 58, 'E - 051 Dt', 18, 'Bistos', 'EYESCOPE', 'ECJ40926', 1, 1, 'Kotak, Charger', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:12:11', '2019-05-16 01:52:55'),
(301, 58, 'E - 051 Dt', 19, '-', 'MG1', '01', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:12:30', '2019-05-16 01:52:55'),
(303, 58, 'E - 051 Dt', 35, 'Tenso', '-', '01', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:13:15', '2019-05-16 01:52:55'),
(304, 58, 'E - 051 Dt', 41, 'Bistos', 'BT - 200', 'BBD60167', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:14:10', '2019-05-16 01:52:55'),
(305, 58, 'E - 051 Dt', 55, 'Bionet', 'Oxy9 Wave', 'O2S0400148', 1, 1, 'Kotak, Probe SPO2 Neonatal, Adult, Konektor', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:14:26', '2019-05-16 01:52:55'),
(306, 58, 'E - 051 Dt', 57, 'ABN', 'REGAL', '00097813', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:14:43', '2019-05-16 01:52:55'),
(307, 58, 'E - 051 Dt', 41, 'Bistos', 'BT - 220', 'BGEB0479', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:15:30', '2019-05-16 01:52:55'),
(308, 59, 'E - 052 Dt', 21, 'ATOMIZER', '3A', '29478 - 010', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:19:11', '2019-05-16 01:53:21'),
(309, 59, 'E - 052 Dt', 58, 'ABN', '-', '121000524', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:20:47', '2019-05-16 01:53:21'),
(313, 59, 'E - 052 Dt', 12, 'OneMed', 'DRAGONONEMED', 'YL182AE0023543', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:21:49', '2019-05-16 01:53:21'),
(314, 60, 'E - 053 Dt', 12, 'DRAGON LAB', '-', 'DX66343', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:22:34', '2019-05-16 01:54:01'),
(315, 60, 'E - 053 Dt', 35, 'K', '-', '007812', 1, 1, 'Charger (ada T)', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:23:15', '2019-05-16 01:54:01'),
(316, 60, 'E - 053 Dt', 41, 'bistos', 'BT - 220 C', 'BGJ10139', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:23:39', '2019-05-16 01:54:01'),
(317, 60, 'E - 053 Dt', 41, 'Serenity', 'SR - 100', '8031SR10009343', 1, 1, '-', 'Kabel Probe Terkelupas', NULL, 'Laik Pakai', 1, '2019-04-25 01:23:46', '2019-05-16 01:54:01'),
(318, 60, 'E - 053 Dt', 12, 'OneMed', 'DRAGONONEMED', 'YL182AE0023237', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 01:23:56', '2019-05-16 01:54:01'),
(319, 58, 'E - 051 Dt', 51, 'K', 'VRN-210', '1316177', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 02:30:18', '2019-05-16 01:52:55'),
(321, 58, 'E - 051 Dt', 58, 'ABN', '-', '121000586', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-25 02:36:29', '2019-05-16 01:52:55'),
(323, 59, 'E - 052 Dt', 12, 'OneMed', 'DRAGONONEMED', 'YL182AE0023248', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-04-25 03:13:16', '2019-05-16 01:53:21'),
(324, 59, 'E - 052 Dt', 12, 'OneMed', 'DRAGONONEMED', 'YL188AH0021716', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-04-25 03:14:07', '2019-05-16 01:53:21'),
(325, 61, 'E - 054 Dt', 9, '-', '-', '000102', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:00:56', '2019-05-10 02:42:34'),
(326, 62, 'E - 055 Dt', 9, 'One Med', '-', '8', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:18:54', '2019-05-10 02:44:51'),
(327, 62, 'E - 055 Dt', 57, 'ABN', 'DESK MODEL', '509262', 1, 1, 'manset, bulb', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:19:52', '2019-05-10 02:44:51'),
(328, 63, 'E - 056 Dt', 9, 'Kenko', '-', 'KIA-01', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:21:21', '2019-05-10 02:45:05'),
(329, 63, 'E - 056 Dt', 57, 'Riester', 'nova ecoline', '15041 1300', 1, 1, 'manset, bulb', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:22:22', '2019-05-10 02:45:05'),
(330, 63, 'E - 056 Dt', 57, 'Riester', 'nova ecoline', '15041 1286', 1, 1, 'manset, bulb', 'bulb rusak', NULL, 'Laik Pakai', 1, '2019-04-29 02:23:12', '2019-05-10 02:45:05'),
(331, 63, 'E - 056 Dt', 57, 'Riester', 'nova ecoline', '15041 1279', 1, 1, 'manset, bulb', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:24:14', '2019-05-10 02:45:05'),
(332, 64, 'E - 057 Dt', 57, 'Riester', 'nova ecoline', '16096 2847', 1, 1, 'manset, bulb', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:25:40', '2019-05-10 02:47:25'),
(333, 64, 'E - 057 Dt', 57, 'Riester', 'nova ecoline', '16096 2834', 1, 1, 'manset, bulb', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:26:39', '2019-05-10 02:47:25'),
(334, 64, 'E - 057 Dt', 57, 'Riester', 'nova ecoline', '15116 0989', 1, 1, 'manset, bulb', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:27:30', '2019-05-10 02:47:25'),
(335, 65, 'E - 058 Dt', 9, '-', '-', 'KIA - 01', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:30:47', '2019-05-10 02:49:28'),
(336, 66, 'E - 059 Dt', 9, 'GEA Medical', '-', 'RGZ - 20', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-04-29 02:35:39', '2019-05-10 02:50:57'),
(337, 67, 'E- 060 Dt', 35, 'Hettich', 'EBA 20', 'D-78532', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-04-29 02:38:18', '2019-05-10 02:52:02'),
(338, 68, 'E - 061 Dt', 10, 'eppendorf', 'Research', '3246527', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2019-04-30 03:52:05', '2019-05-14 23:40:35'),
(339, 68, 'E - 061 Dt', 10, 'eppendorf', 'Research', '2175908', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2019-04-30 03:52:07', '2019-05-14 23:40:35'),
(340, 68, 'E - 061 Dt', 10, 'eppendorf', 'Research', '3555335', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2019-04-30 03:52:30', '2019-05-14 23:40:35'),
(341, 68, 'E - 061 Dt', 10, 'eppendorf', 'Research', '3389177', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2019-04-30 03:53:10', '2019-05-14 23:40:35'),
(342, 68, 'E - 061 Dt', 10, 'eppendorf', 'Research', '3244097', 1, 1, '-', '50 uL', NULL, 'Laik Pakai', 1, '2019-04-30 03:53:34', '2019-05-14 23:40:35'),
(343, 68, 'E - 061 Dt', 10, 'eppendorf', '-', '2260437', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2019-04-30 03:53:54', '2019-05-14 23:40:35'),
(344, 68, 'E - 061 Dt', 12, 'eppendorf', 'Research', '1380808', 1, 1, '-', '100 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-04-30 03:55:01', '2019-05-14 23:40:35'),
(345, 68, 'E - 061 Dt', 12, 'eppendorf', 'Research', '4863457', 1, 1, '-', '20 - 200 uL', NULL, 'Laik Pakai', 1, '2019-04-30 03:55:41', '2019-05-14 23:40:35'),
(346, 69, 'E - 062 Dt', 57, 'ONE MED', '-', '1268142', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 01:40:58', '2019-05-27 04:58:47'),
(347, 69, 'E - 062 Dt', 57, 'RIESTER', 'nova ecoline', '170762131', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 01:41:01', '2019-05-27 04:58:49'),
(348, 69, 'E - 062 Dt', 57, 'ABN', 'SPECTRUM', '972151', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-05-02 01:41:39', '2019-05-27 04:58:46'),
(349, 69, 'E - 062 Dt', 42, 'FUKUDA M.E', '-', '20803227', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 01:42:38', '2019-05-27 05:01:15'),
(351, 69, 'E - 062 Dt', 41, 'EDAN', 'SDG', '110627-M12802720013', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 01:49:46', '2019-05-27 05:00:27'),
(352, 70, 'E - 063 Dt', 41, 'bistos', 'BT-200', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 01:55:16', '2019-05-27 04:46:19'),
(353, 70, 'E - 063 Dt', 41, 'bistos', 'BT-200', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 01:55:22', '2019-05-27 04:46:19'),
(354, 70, 'E - 063 Dt', 57, 'RIESTER', 'nova ecoline', '100102905', 1, 1, '-', 'bulb bocor', NULL, 'Laik Pakai', 1, '2019-05-02 01:58:25', '2019-05-27 04:46:19'),
(355, 70, 'E - 063 Dt', 57, 'ABN', 'SPECTRUM', '106138', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 01:58:28', '2019-05-27 04:46:19'),
(356, 71, 'E - 064 Dt', 57, 'onemed', '-', '1342166', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 02:14:53', '2019-05-27 05:08:17'),
(357, 71, 'E - 064 Dt', 57, 'GENERAL CARE', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 02:14:57', '2019-05-27 05:08:17'),
(358, 71, 'E - 064 Dt', 41, 'bistos', 'bt-200', 'BBH30566', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 02:15:26', '2019-05-27 05:08:17'),
(359, 71, 'E - 064 Dt', 10, 'HUMAN', 'HUMAPETTE', '04F12512', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2019-05-02 02:17:31', '2019-05-27 05:08:17'),
(360, 71, 'E - 064 Dt', 12, 'ACCUMAX', '-', 'FJ755275', 1, 1, '-', '10 - 1000 uL', NULL, 'Tidak Laik Pakai', 1, '2019-05-02 02:17:50', '2019-05-27 05:08:17'),
(361, 71, 'E - 064 Dt', 10, 'ACCUMAX', '-', '118099', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2019-05-02 02:20:19', '2019-05-27 05:08:17'),
(362, 71, 'E - 064 Dt', 10, 'ACCUMAX', '-', '168198', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2019-05-02 02:20:45', '2019-05-27 05:08:17'),
(363, 71, 'E - 064 Dt', 57, 'ABN', 'SPECTRUM', '806903', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-05-02 02:21:36', '2019-05-27 05:08:17'),
(364, 71, 'E - 064 Dt', 57, 'ABN', 'PRECISION', '651174', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-02 02:22:07', '2019-05-27 05:08:56'),
(366, 73, 'E - 065 Dt', 55, '-', 'JZK-301', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:16:16', '2019-05-15 00:52:11'),
(367, 73, 'E - 065 Dt', 55, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:16:22', '2019-05-15 00:52:11'),
(368, 73, 'E - 065 Dt', 37, 'lifePOINT', 'PRO AED', '174080208', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:18:02', '2019-05-15 00:54:48'),
(369, 73, 'E - 065 Dt', 57, 'RIESTER', 'nova-presamater', '150763231', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:18:56', '2019-05-15 00:52:11'),
(371, 73, 'E - 065 Dt', 57, 'RIESTER', 'nova-presamater', '150763261', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:19:08', '2019-05-15 00:52:11'),
(372, 73, 'E - 065 Dt', 30, 'resonance', 'R27A DD45', 'R27A17D000526', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:20:27', '2019-05-15 00:52:11'),
(373, 73, 'E - 065 Dt', 59, 'chest', 'hi-101', '1131443', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:21:26', '2019-05-15 00:52:11'),
(374, 74, 'E - 066 Dt', 57, 'RIESTER', 'nova-presameter', '150763298', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:23:00', '2019-05-15 00:52:35'),
(375, 74, 'E - 066 Dt', 59, 'CHEST', 'HI0-101', '1136568', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:23:37', '2019-05-15 00:52:35'),
(376, 74, 'E - 066 Dt', 55, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-03 02:24:10', '2019-05-15 00:52:35'),
(377, 75, 'E - 067 Dt', 42, 'SCHILLER', 'AT-1', '19056186', 1, 1, '-', 'Tutup printer tdk rapat (harus ditekan dulu sebelum di start)', NULL, 'Laik Pakai', 1, '2019-05-10 07:03:22', '2019-05-20 03:15:38'),
(378, 76, 'E - 068 Dt', 57, 'ABN', '-', '460809', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:45:53', '2019-06-28 06:16:32'),
(379, 76, 'E - 068 Dt', 57, 'ABN', '0044', '580104', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:45:56', '2019-05-14 02:37:39'),
(380, 76, 'E - 068 Dt', 57, 'ABN', '0044', '460447', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:45:57', '2019-05-14 02:37:39'),
(382, 76, 'E - 068 Dt', 21, 'Omron', 'NE-C28', '20100912504UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:48:04', '2019-05-14 02:37:39'),
(383, 76, 'E - 068 Dt', 26, 'Surgimed', 'DFX-23C.1', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:48:40', '2019-06-28 06:16:32'),
(384, 76, 'E - 068 Dt', 42, 'Bionet', 'CardioTouch', 'T2L080086', 1, 1, 'Aksesoris Lengkap', 'Kertas Habis, belum dilakukan pengecekan', NULL, 'Laik Pakai', 1, '2019-05-13 00:49:21', '2019-06-28 06:16:32'),
(385, 76, 'E - 068 Dt', 55, 'Bionet', 'CT-3000', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:49:45', '2019-06-28 06:16:32'),
(386, 76, 'E - 068 Dt', 59, 'Bionet', 'CT-3000', 'T2LU800086', 1, 1, 'Mouth Piece', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:49:47', '2019-06-28 06:16:32'),
(387, 76, 'E - 068 Dt', 34, 'Omron', 'HEM-7322', '20160300829VG', 1, 1, 'Charger', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:51:30', '2019-06-28 06:16:32'),
(388, 76, 'E - 068 Dt', 34, 'Omron', 'HEM-8712', '20181115251VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:51:39', '2019-06-28 06:16:32'),
(389, 76, 'E - 068 Dt', 1, 'Avico', '-', 'SN 2017092492', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:52:50', '2019-06-28 06:16:32'),
(390, 76, 'E - 068 Dt', 1, 'Avico', '-', 'SN 2017092446', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:52:55', '2019-05-14 02:37:39'),
(391, 76, 'E - 068 Dt', 1, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:53:09', '2019-06-28 06:16:32');
INSERT INTO `lab_detail_order` (`id`, `id_order`, `no_order`, `alat_id`, `merek`, `model`, `seri`, `jumlah`, `fungsi`, `kelengkapan`, `keterangan`, `no_registrasi`, `catatan`, `ambil`, `created_at`, `updated_at`) VALUES
(392, 76, 'E - 068 Dt', 1, 'Avico', '-', 'SN 2017092473', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:53:11', '2019-05-14 02:37:39'),
(393, 76, 'E - 068 Dt', 1, 'Avico', '-', 'SN 2017092447', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:53:12', '2019-06-28 06:16:32'),
(394, 76, 'E - 068 Dt', 37, 'Lifepak CR Plus', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-13 00:54:41', '2019-05-14 02:37:39'),
(395, 77, 'E - 069 Dt', 41, 'Cofoe', 'JPD - 100A', 'YY0448 - 2009', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-05-20 02:12:01', '2019-07-18 03:53:09'),
(396, 78, 'E - 070 Dt', 34, 'Omron', 'HEM-7051-C12', '20101016917 UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-21 03:14:59', '2019-07-12 05:54:35'),
(398, 78, 'E - 070 Dt', 2, 'Omron', 'MC-245', '20180105UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-21 03:16:57', '2019-07-12 05:54:35'),
(399, 78, 'E - 070 Dt', 55, 'Elitech', 'FOX-1(N)', 'FX1175A1961', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-05-21 03:17:38', '2019-07-12 05:54:35'),
(400, 78, 'E - 070 Dt', 21, 'Omron', 'CompAIR', '20100911970 UF', 1, 1, 'Mouthpiece', '-', NULL, 'Laik Pakai', 1, '2019-05-21 03:18:34', '2019-07-12 05:57:58'),
(404, 78, 'E - 070 Dt', 57, 'ABN', 'SPECTRUM', '291874', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-05-21 03:33:01', '2019-07-12 05:58:03'),
(405, 79, 'E - 071 Dt', 57, 'Riester', 'nova ecoline', '170162583', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-23 02:30:11', '2019-05-29 02:31:15'),
(406, 79, 'E - 071 Dt', 30, 'Resonance', 'R27e', 'R27A17C000503', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-23 02:31:05', '2019-05-29 05:40:07'),
(407, 79, 'E - 071 Dt', 37, 'Life Point', '-', '174080217', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-23 02:35:29', '2019-05-29 05:36:42'),
(408, 79, 'E - 071 Dt', 35, 'K', 'PLC - 03', '1607547', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-23 02:41:29', '2019-05-29 05:36:42'),
(409, 80, 'E - 072 Dt', 30, 'Resonance', 'R27e', 'R27A17D000525', 1, 1, '-', 'Earphone rusak', NULL, 'Laik Pakai', 1, '2019-05-23 02:45:23', '2019-05-29 02:32:50'),
(410, 80, 'E - 072 Dt', 59, 'Chest', 'HI-101', '1132166', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-23 02:45:59', '2019-05-29 02:30:49'),
(411, 79, 'E - 071 Dt', 59, 'Chest', 'HI - 101', '1132855', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-23 02:56:14', '2019-05-29 05:36:42'),
(412, 80, 'E - 072 Dt', 57, 'Riester', 'nova ecoline', '121243788', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-23 02:57:33', '2019-05-29 02:30:49'),
(413, 80, 'E - 072 Dt', 57, 'Riester', 'nova presameter', '100104238', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-05-23 02:58:32', '2019-05-29 02:30:49'),
(414, 80, 'E - 072 Dt', 57, 'Riester', 'nova ecoline', '100829130', 1, 1, '-', 'Bulb Bocor', NULL, 'Laik Pakai', 1, '2019-05-23 03:01:58', '2019-05-29 02:30:49'),
(415, 82, 'E - 073 Dt', 12, 'SOCOREX', 'Accura 825', '23031572', 1, 1, '-', '5 -50 uL', NULL, 'Laik Pakai', 1, '2019-05-27 01:38:45', '2019-07-03 07:56:45'),
(416, 82, 'E - 073 Dt', 10, 'SOCOREX', 'Accura 815', '22061564', 1, 1, '-', '1000 uL', NULL, 'Tidak Laik Pakai', 1, '2019-05-27 01:39:38', '2019-07-03 07:56:45'),
(417, 82, 'E - 073 Dt', 10, 'SOCOREX', 'Accura 815', '22031230', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2019-05-27 01:39:40', '2019-07-03 07:56:45'),
(418, 82, 'E - 073 Dt', 10, 'SOCOREX', 'Accura 815', '21111109', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2019-05-27 01:39:42', '2019-07-03 07:56:45'),
(419, 82, 'E - 073 Dt', 10, 'SOCOREX', 'Accura 815', '22061570', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2019-05-27 01:40:35', '2019-07-03 07:56:45'),
(420, 82, 'E - 073 Dt', 10, 'OneMed', '-', 'CU0039572', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2019-05-27 01:41:26', '2019-07-03 07:56:45'),
(421, 82, 'E - 073 Dt', 10, 'OneMed', 'DRAGONONEMED', 'FV00010', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2019-05-27 01:42:29', '2019-07-03 07:56:45'),
(422, 83, 'E - 074 Dt', 37, 'life POINT', '-', '174080210', 1, 1, 'Pad', '-', NULL, 'Laik Pakai', 1, '2019-05-28 02:24:24', '2019-05-29 02:30:30'),
(423, 84, 'E - 075 Dt', 10, 'Huawei', '-', '12010058', 1, 1, '-', '100 g', NULL, 'Laik Pakai', 1, '2019-06-11 02:14:10', '2019-06-17 03:07:22'),
(424, 84, 'E - 075 Dt', 10, 'Socorex', 'Acura 815', '18061011', 1, 1, '-', '', NULL, 'Laik Pakai', 1, '2019-06-11 02:14:25', '2019-06-17 03:07:22'),
(425, 85, 'E - 076 Dt', 57, 'Riester', 'nova-presameter', '160763044', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 03:23:39', '2019-07-03 06:46:33'),
(426, 85, 'E - 076 Dt', 55, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 03:27:09', '2019-06-19 02:03:37'),
(427, 86, 'E - 077 Dt', 59, 'Chestgraph', 'HI - 101', '1132528', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 03:30:58', '2019-07-03 06:52:01'),
(428, 86, 'E - 077 Dt', 57, 'Riester', 'nova-presameter', '150763370', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 03:39:22', '2019-07-03 06:53:09'),
(429, 87, 'E - 078 Dt', 10, 'Accumax', '-', 'JD498682', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2019-06-17 03:56:35', '2019-07-02 05:56:22'),
(430, 87, 'E - 078 Dt', 10, 'Accumax', '-', '323053', 1, 1, '-', '200 uL', NULL, 'Laik Pakai', 1, '2019-06-17 03:59:10', '2019-07-02 05:56:22'),
(431, 87, 'E - 078 Dt', 10, 'Accumax', '-', '140830', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2019-06-17 03:59:32', '2019-07-02 05:56:22'),
(432, 87, 'E - 078 Dt', 10, 'Accumax', '-', 'HK443594', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2019-06-17 04:00:00', '2019-07-02 05:56:22'),
(433, 87, 'E - 078 Dt', 10, 'Accumax', '-', 'FK756126', 1, 1, '-', '25 uL', NULL, 'Laik Pakai', 1, '2019-06-17 04:00:28', '2019-07-02 05:56:22'),
(434, 87, 'E - 078 Dt', 10, 'Accumax', '-', 'JD498871', 1, 1, '-', '50 uL', NULL, 'Laik Pakai', 1, '2019-06-17 04:00:48', '2019-07-02 05:56:22'),
(435, 87, 'E - 078 Dt', 10, 'Accumax', '-', '608874', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2019-06-17 04:01:05', '2019-07-02 05:56:22'),
(436, 87, 'E - 078 Dt', 10, 'Accumax', '-', 'FK757281', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2019-06-17 04:01:28', '2019-07-02 05:56:22'),
(437, 87, 'E - 078 Dt', 10, 'Accumax', '-', 'GJ383885', 1, 1, '-', '250 uL', NULL, 'Laik Pakai', 1, '2019-06-17 04:01:54', '2019-07-02 05:56:22'),
(438, 87, 'E - 078 Dt', 10, 'Accumax', '-', 'FK357484', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2019-06-17 04:02:19', '2019-07-02 05:56:22'),
(439, 87, 'E - 078 Dt', 57, 'ABN', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 04:03:38', '2019-07-02 05:56:22'),
(440, 87, 'E - 078 Dt', 57, 'Riester', 'Nova', '950379774', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 04:04:22', '2019-07-02 05:56:22'),
(441, 88, 'E - 079 Dt', 10, 'SOCOREX', '-', '13071776', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2019-06-17 07:09:34', '2019-06-21 06:59:40'),
(442, 88, 'E - 079 Dt', 10, 'Eppendorf', 'Research', '2967218', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2019-06-17 07:10:14', '2019-06-21 06:59:40'),
(443, 88, 'E - 079 Dt', 10, 'ONEMED', 'dragon', '55889', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2019-06-17 07:10:55', '2019-06-21 06:59:40'),
(444, 88, 'E - 079 Dt', 57, 'ERKA', 'Klinikerkameter', '14302398', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 07:11:46', '2019-06-21 06:59:40'),
(445, 88, 'E - 079 Dt', 42, 'BTL', 'BTL-08', '073P0B004998', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-06-17 07:23:06', '2019-06-21 06:59:40'),
(446, 88, 'E - 079 Dt', 37, 'Mindray', 'BeneHeart', 'EL-58021809', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 07:27:35', '2019-06-21 06:59:40'),
(447, 88, 'E - 079 Dt', 42, 'SCHILLER', 'Cardiovit AT-1', '190.79101', 1, 1, '-', 'belum dicek (kertas Habis), Kabel Kurang Baik (melingkar)', NULL, 'Laik Pakai', 1, '2019-06-17 07:36:14', '2019-08-14 01:00:14'),
(448, 88, 'E - 079 Dt', 37, 'INSTRAMED', 'CARDIOMAX', '30917 CM 5442', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-06-17 07:37:56', '2019-06-21 06:59:40'),
(449, 88, 'E - 079 Dt', 21, 'Prizma', 'Profi Sonic', '201635002377', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 07:48:48', '2019-08-14 01:00:14'),
(450, 88, 'E - 079 Dt', 48, 'Fresenius Kabi', 'Optima PT', '22024665', 1, 1, 'Drip Sensor', '-', NULL, 'Laik Pakai', 1, '2019-06-17 07:56:30', '2019-08-07 05:05:51'),
(451, 88, 'E - 079 Dt', 35, 'Kubota', '2420', 'S611149-N000', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-06-17 08:19:10', '2019-06-21 06:59:40'),
(452, 88, 'E - 079 Dt', 62, 'Fresenius Kabi', 'Injectomat Agilia', '21630098', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 08:19:47', '2019-06-21 06:59:40'),
(453, 88, 'E - 079 Dt', 66, 'Chison', 'Chison 8100', '81.2090506', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-17 08:25:24', '2019-08-14 01:00:14'),
(454, 88, 'E - 079 Dt', 32, 'UTAS', 'UM 300 I', 'M.651.13019.0045', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-06-17 08:51:02', '2019-06-21 06:59:40'),
(455, 89, 'E - 080 Dt', 12, 'SOCOREX', 'ACURA 825', '27021454', 1, 1, '-', '2 - 200 uL', NULL, 'Laik Pakai', 1, '2019-06-19 01:51:43', '2019-07-03 06:27:12'),
(456, 91, 'E - 082 Dt', 42, 'BTL', 'BTL-08', '071D0B007728', 1, 1, '-', 'Belum Dilakukan Pengecekan', NULL, 'Laik Pakai', 1, '2019-06-19 02:00:24', '2019-06-26 03:57:05'),
(457, 92, 'E - 083 Dt', 57, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-19 03:01:55', '2019-07-11 05:17:34'),
(458, 92, 'E - 083 Dt', 57, 'ERKA', 'klinikerkameter', '14301722', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-19 03:01:56', '2019-07-11 05:17:34'),
(459, 92, 'E - 083 Dt', 57, 'ERKA', 'klinikerkameter', '13300996', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-19 03:04:59', '2019-07-11 05:17:34'),
(460, 92, 'E - 083 Dt', 57, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-19 03:07:40', '2019-07-11 05:17:34'),
(461, 92, 'E - 083 Dt', 57, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-19 03:07:42', '2019-07-11 05:17:34'),
(462, 93, 'E - 081 Dt', 55, '-', 'JZK - 301', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-20 01:59:15', '2019-07-03 06:27:50'),
(463, 93, 'E - 081 Dt', 34, 'Omron', 'HEM - 7203', '20151101376VG', 1, 1, '-', 'Tidak ada Tutup Baterai', NULL, 'Laik Pakai', 1, '2019-06-20 02:03:01', '2019-07-03 06:27:50'),
(465, 93, 'E - 081 Dt', 12, 'DUMO', '-', 'JB489685', 1, 1, '-', '100 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-06-20 02:31:37', '2019-07-18 06:24:24'),
(466, 93, 'E - 081 Dt', 12, 'DUMO', '-', 'HH425067', 1, 1, '-', '5 - 50 uL', NULL, 'Batal Dikalibrasi', 1, '2019-06-20 02:31:45', '2019-07-18 06:24:31'),
(467, 93, 'E - 081 Dt', 57, 'Riester', 'nova-presameter', '130631241', 1, 1, '-', 'Bulb Keras', NULL, 'Laik Pakai', 1, '2019-06-20 02:33:25', '2019-07-03 06:27:50'),
(468, 94, 'E - 084 Dt', 66, 'Teknova', '-', '321B4030214', 1, 1, '-', 'Blm Dicek', NULL, 'Laik Pakai', 1, '2019-06-20 02:37:23', '2019-07-03 06:32:50'),
(469, 94, 'E - 084 Dt', 35, 'Kubota', 'Kubota 3300', 'R6 0602-F000', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-20 02:39:39', '2019-07-03 06:32:50'),
(470, 95, 'E - 085 Dt', 2, 'Magic Star', '-', '-', 1, 1, '-', '-', NULL, 'Belum dilakukan kalibrasi karena sensor pada termometer rusak', 1, '2019-06-21 03:03:42', '2019-07-09 07:40:37'),
(471, 95, 'E - 085 Dt', 2, 'Omron', 'MC-245', '20180105uf', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-21 03:04:09', '2019-07-09 07:40:49'),
(472, 95, 'E - 085 Dt', 55, 'Elitech', '-', 'FX1186A0974', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-21 03:05:04', '2019-07-02 06:55:05'),
(473, 95, 'E - 085 Dt', 55, 'Elitech', '-', 'FX1186A0934', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-21 03:05:09', '2019-07-02 06:55:05'),
(474, 95, 'E - 085 Dt', 57, 'ABN', 'SPECTRUM', '104813', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-06-21 03:06:47', '2019-07-02 06:55:05'),
(475, 95, 'E - 085 Dt', 57, 'ABN', 'SPECTRUM', '903107', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-21 03:06:51', '2019-07-02 06:55:05'),
(477, 95, 'E - 085 Dt', 55, 'iHealth', 'P03M', '160535027323109', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-21 03:09:30', '2019-07-02 06:55:05'),
(478, 95, 'E - 085 Dt', 57, 'ABN', 'SPECTRUM', '930825', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-21 03:13:10', '2019-07-02 06:55:05'),
(480, 96, 'E - 086 Dt', 42, 'Bionet', 'Cardiocare', '8809276940032', 1, 1, 'Kabel Power, Kertas Elektroda', '-', NULL, 'Laik Pakai', 1, '2019-06-25 02:02:11', '2019-06-25 06:56:47'),
(481, 97, 'E - 087 Dt', 32, 'Mindray', 'MEC - 1000', 'AQ-45206989', 1, 1, 'NIBP, SPO2, EKG', '-', NULL, 'Laik Pakai', 1, '2019-06-25 02:14:17', '2019-06-28 02:58:02'),
(483, 97, 'E - 087 Dt', 58, 'AND', 'UM101', '2050160905314', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-25 02:20:46', '2019-06-28 02:58:02'),
(485, 97, 'E - 087 Dt', 57, 'ERKA', 'klinikerkameter', '14302189', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-25 02:25:12', '2019-06-28 02:58:02'),
(487, 97, 'E - 087 Dt', 21, 'Omron', 'NE-C900', '20171200469UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-25 02:35:34', '2019-06-28 02:58:02'),
(488, 97, 'E - 087 Dt', 21, 'ABM', 'Compamist1', '014881', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-25 02:36:00', '2019-06-28 02:58:02'),
(490, 97, 'E - 087 Dt', 57, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-06-25 02:54:52', '2019-06-28 02:58:02'),
(492, 97, 'E - 087 Dt', 21, 'OMRON', 'COMP-AIR', '20100304774UF', 1, 1, '-', 'Tidak ada water trap', NULL, 'Laik Pakai', 1, '2019-06-25 03:39:39', '2019-06-28 02:58:02'),
(494, 97, 'E - 087 Dt', 1, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-25 06:21:22', '2019-06-28 02:58:02'),
(495, 97, 'E - 087 Dt', 1, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-25 08:15:17', '2019-06-28 02:58:02'),
(496, 98, 'E - 088 Dt', 57, 'Riester', 'nova - presameter', '160562708', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-26 02:13:30', '2019-07-02 06:02:12'),
(497, 98, 'E - 088 Dt', 42, 'Fukuda Denshi', 'Cardimax', '21086513', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-06-26 02:14:29', '2019-07-02 06:02:12'),
(498, 98, 'E - 088 Dt', 57, 'Riester', 'nova - presameter', '161161613', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-06-26 02:14:32', '2019-07-02 06:02:12'),
(499, 95, 'E - 085 Dt', 57, 'ABN', 'SPECTRUM', '910481', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-01 01:54:22', '2019-07-02 06:55:05'),
(500, 99, 'E - 089 Dt', 35, 'Eppendorf', '5702', '5702AR329743', 1, 1, '-', 'Tanpa Kabel Power', NULL, 'Laik Pakai', 1, '2019-07-04 03:44:14', '2019-07-18 01:42:04'),
(501, 99, 'E - 089 Dt', 57, 'Riester', 'ri - san', '170141662', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 03:51:37', '2019-07-18 01:42:04'),
(502, 99, 'E - 089 Dt', 57, 'Riester', 'bigbenround', '180148946', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 03:51:48', '2019-07-18 01:42:04'),
(503, 99, 'E - 089 Dt', 57, 'Riester', 'ri - san', '170141647', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 03:52:08', '2019-07-18 01:42:04'),
(504, 99, 'E - 089 Dt', 57, 'Riester', 'ri - san', '170141600', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 03:52:25', '2019-07-18 01:42:04'),
(505, 101, 'E - 091 Dt', 35, 'Eppendorf', '5702', '5702AM528818', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 04:04:37', '2019-07-18 01:44:09'),
(506, 100, 'E - 090 Dt', 57, 'Riester', 'Ri - san', '170543743', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 04:13:29', '2019-07-18 01:43:16'),
(507, 100, 'E - 090 Dt', 57, 'Riester', 'nova-presameter', '150203849', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 04:13:32', '2019-07-18 01:43:16'),
(508, 100, 'E - 090 Dt', 57, 'Riester', 'Ri - san', '170543879', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 04:13:35', '2019-07-18 01:43:16'),
(509, 100, 'E - 090 Dt', 57, 'Riester', 'Ri - san', '170543859', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 04:13:53', '2019-07-18 01:43:16'),
(510, 100, 'E - 090 Dt', 57, 'Riester', 'big benround', '180151229', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 04:14:37', '2019-07-18 01:43:16'),
(511, 100, 'E - 090 Dt', 57, 'Riester', 'Ri - san', '170543752', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 04:15:13', '2019-07-18 01:43:16'),
(512, 100, 'E - 090 Dt', 42, 'Kenz', 'Cardico 601', '18121617', 1, 1, '-', 'Belum ada Kertas', NULL, 'Laik Pakai', 1, '2019-07-04 04:16:30', '2019-07-18 01:43:16'),
(513, 101, 'E - 091 Dt', 57, 'Riester', 'big ben round', '180151387', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 04:17:54', '2019-07-18 01:44:09'),
(514, 101, 'E - 091 Dt', 42, 'Kenz', 'Cardico 306', '18203352', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 04:24:45', '2019-07-18 01:44:09'),
(515, 102, 'E - 092 Dt', 9, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 07:20:46', '2019-08-09 05:43:48'),
(516, 102, 'E - 092 Dt', 57, 'Riester', 'nova ecoline', '1510G1816', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 07:21:43', '2019-08-09 05:43:48'),
(517, 102, 'E - 092 Dt', 57, 'Riester', 'nova ecoline', '150513155', 1, 1, '-', 'Bulb Rusak', NULL, 'Laik Pakai', 1, '2019-07-04 07:21:49', '2019-08-09 05:43:48'),
(518, 102, 'E - 092 Dt', 1, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 07:22:50', '2019-08-09 05:43:48'),
(519, 102, 'E - 092 Dt', 1, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 07:22:54', '2019-08-09 05:43:48'),
(521, 102, 'E - 092 Dt', 19, 'KaWe', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 07:23:48', '2019-08-09 05:43:48'),
(522, 102, 'E - 092 Dt', 19, 'Dyna', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 07:25:26', '2019-08-09 05:43:48'),
(523, 102, 'E - 092 Dt', 9, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-04 07:29:14', '2019-08-09 05:43:48'),
(524, 103, 'E - 093 Dt', 57, 'ERKA', 'Erkameter 3000', '12505419', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-09 01:53:35', '2019-07-31 03:49:52'),
(525, 103, 'E - 093 Dt', 57, 'ERKA', 'Erkameter 3000', '14509746', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-09 01:54:14', '2019-07-31 03:49:52'),
(526, 103, 'E - 093 Dt', 57, 'ERKA', 'Erkameter 3000', '14509750', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-09 01:54:39', '2019-07-31 03:49:52'),
(527, 103, 'E - 093 Dt', 57, 'ERKA', 'Erkameter 3000', '14510115', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-09 01:55:13', '2019-07-31 03:49:52'),
(528, 103, 'E - 093 Dt', 57, 'ERKA', 'Erkameter 3000', '15503235', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-09 01:55:33', '2019-07-31 03:49:52'),
(530, 103, 'E - 093 Dt', 21, 'GEA', '402AI', '00126', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-09 01:58:48', '2019-07-31 03:49:52'),
(531, 103, 'E - 093 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-09 01:59:04', '2019-07-31 03:49:52'),
(532, 103, 'E - 093 Dt', 34, 'Kenko', 'Bf1112', '18050228852', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-09 02:03:29', '2019-07-31 03:49:52'),
(534, 103, 'E - 093 Dt', 34, 'OMRON', 'HEM - 7130', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-09 02:03:41', '2019-07-31 03:49:52'),
(535, 103, 'E - 093 Dt', 42, 'FUKUDA M.E', 'CARDISUNY', '20802868', 1, 1, 'Kabel power, kabel pasien', '-', NULL, 'Laik Pakai', 1, '2019-07-09 02:05:58', '2019-07-31 03:49:52'),
(536, 103, 'E - 093 Dt', 61, 'Elektro.Mag', 'M 3025 P', '09030201', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-07-09 02:35:36', '2019-07-31 03:53:11'),
(537, 104, 'E - 094 Dt', 34, 'Beurer', '-', 'B 06/391517', 1, 1, '4 baterai', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:04:37', '2019-08-08 05:03:40'),
(538, 104, 'E - 094 Dt', 55, 'Beurer', 'GmBh', 'B29/005861', 1, 1, '-', 'Tidak ada tutup', NULL, 'Laik Pakai', 1, '2019-07-22 06:06:49', '2019-08-08 05:03:40'),
(539, 104, 'E - 094 Dt', 55, 'Beurer', 'OxyOne', '-', 1, 1, '-', 'Tidak ada tutup', NULL, 'Laik Pakai', 1, '2019-07-22 06:07:33', '2019-08-08 05:03:40'),
(540, 104, 'E - 094 Dt', 55, 'Beurer', 'GmBh', 'C06/010192', 1, 1, '-', 'Tidak ada tutup', NULL, 'Laik Pakai', 1, '2019-07-22 06:09:12', '2019-08-08 05:03:40'),
(541, 104, 'E - 094 Dt', 34, 'Beurer', '-', '2017C29/020972', 1, 1, '4 baterai', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:10:04', '2019-08-08 05:03:40'),
(542, 104, 'E - 094 Dt', 34, 'Beurer', '-', 'B 18/429062', 1, 1, '4 baterai', '-', NULL, 'Laik pAKAI', 1, '2019-07-22 06:11:27', '2019-08-08 05:03:40'),
(543, 104, 'E - 094 Dt', 34, 'Beurer', '-', 'B 25/492489', 1, 1, '4 baterai', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:13:40', '2019-08-08 05:03:40'),
(544, 104, 'E - 094 Dt', 34, 'Beurer', '-', 'B 18/429224', 1, 1, '4 baterai', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:15:11', '2019-08-08 05:03:40'),
(545, 104, 'E - 094 Dt', 34, 'Beurer', '-', '2017C29/032326', 1, 1, '4 baterai', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:16:34', '2019-08-08 05:03:40'),
(546, 104, 'E - 094 Dt', 34, 'Beurer', 'BM 26', '2017C29/020605', 1, 1, '4 baterai', 'Manset tdk bisa digunakan', NULL, 'Laik Pakai', 1, '2019-07-22 06:20:40', '2019-08-08 05:03:40'),
(547, 104, 'E - 094 Dt', 34, 'Beurer', 'BM 26', 'B 06/389638', 1, 1, '4 baterai', 'Tidak ada manset', NULL, 'Laik Pakai', 1, '2019-07-22 06:21:09', '2019-08-08 05:03:40'),
(548, 104, 'E - 094 Dt', 34, 'Beurer', 'BM 26', '2018D24/011177', 1, 1, 'Baterai 4', 'Tdk ada manset', NULL, 'Laik Pakai', 1, '2019-07-22 06:22:21', '2019-08-08 05:03:40'),
(549, 104, 'E - 094 Dt', 34, 'Yuwell', 'YE680E', 'B171200150', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:23:39', '2019-08-08 05:03:40'),
(550, 104, 'E - 094 Dt', 34, 'Beurer', 'Bam 26', '2017C29/030137', 1, 1, '4 baterai', 'Tidak ada manset', NULL, 'Laik Pakai', 1, '2019-07-22 06:24:42', '2019-08-08 05:03:40'),
(551, 104, 'E - 094 Dt', 34, 'Beurer', 'BM 26', 'B 18/416690', 1, 1, '4 baterai', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:25:40', '2019-08-08 05:03:40'),
(552, 104, 'E - 094 Dt', 32, 'analogic medical', 'AM 1200', 'M013A005984', 1, 1, 'Aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:27:05', '2019-08-08 05:03:40'),
(553, 104, 'E - 094 Dt', 57, 'Anzon', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:27:40', '2019-08-08 05:03:40'),
(554, 104, 'E - 094 Dt', 41, '-', 'CR - 90', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:29:23', '2019-08-08 05:03:40'),
(555, 104, 'E - 094 Dt', 57, 'Anzon', '-', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-07-22 06:31:03', '2019-08-08 05:03:40'),
(556, 104, 'E - 094 Dt', 21, 'Beurer', 'IH 21', 'A04/001090', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:31:26', '2019-08-08 05:03:40'),
(557, 104, 'E - 094 Dt', 41, '-', 'CR-90', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:33:06', '2019-08-08 05:03:40'),
(558, 104, 'E - 094 Dt', 21, 'OMRON', 'NE - C28', '20170701755UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:33:23', '2019-08-08 05:03:40'),
(559, 104, 'E - 094 Dt', 41, 'OneMed', 'Onemed doppler', 'SZABA8200S21775', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:35:22', '2019-08-08 05:03:40'),
(560, 104, 'E - 094 Dt', 21, 'OMRON', 'NE - C29', '20140901801UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:36:05', '2019-08-08 05:03:40'),
(561, 104, 'E - 094 Dt', 9, 'Beurer', 'JBY 80', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:36:43', '2019-08-08 05:03:40'),
(562, 104, 'E - 094 Dt', 21, 'OMRON', 'NE - C29', '20140901802UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:38:15', '2019-08-08 05:03:40'),
(563, 104, 'E - 094 Dt', 32, 'Analogic medical', 'AM 1200', 'M013A004242', 1, 1, '-', 'Cuff rusak,  tdk ada kabel power', NULL, 'Laik Pakai', 1, '2019-07-22 06:40:28', '2019-08-08 05:03:40'),
(564, 104, 'E - 094 Dt', 62, 'Fresenius kabi', 'Injectomat Agilia ID', '23196898', 1, 1, '-', 'Tdk ada kabel power', NULL, 'Laik Pakai', 1, '2019-07-22 06:42:33', '2019-08-08 05:03:40'),
(565, 104, 'E - 094 Dt', 62, 'Fresenius kabi', 'Injectomat agilia ID', '22741931', 1, 1, 'Kabel power', '-', NULL, 'Laik Pakai', 1, '2019-07-22 06:44:00', '2019-08-08 05:03:40'),
(566, 104, 'E - 094 Dt', 42, 'Bionet', 'Cardiocare', 'ER1100250', 1, 1, 'Tidak ada kabel power dan lead ecg', 'Belum dicek', NULL, 'Laik Pakai', 1, '2019-07-22 06:45:17', '2019-08-08 05:04:13'),
(567, 104, 'E - 094 Dt', 42, 'Bionet', 'Cardiocare-2000', 'EO-OM0800902', 1, 1, '-tidak ada kabel lead, kertas', 'belum dicek', NULL, 'Laik Pakai', 1, '2019-07-22 06:52:07', '2019-08-08 05:04:13'),
(568, 105, 'E - 095 Dt', 12, 'OneMed', 'DRAGONONEMED', 'YL173AB0008996', 1, 1, '-', '10 - 100', NULL, 'Laik Pakai', 1, '2019-07-24 02:23:37', '2019-08-16 02:14:06'),
(569, 105, 'E - 095 Dt', 12, 'OneMed', 'DRAGONONEMED', 'YL172AA0024297', 1, 1, '-', '100 - 1000', NULL, 'Laik Pakai', 1, '2019-07-24 02:23:43', '2019-08-16 02:14:06'),
(570, 106, 'E - 096 Dt', 2, '-', '-', '-', 1, 1, '-', 'Termometer Raksa', NULL, 'Laik Pakai', 1, '2019-07-24 02:27:13', '2019-08-16 02:15:32'),
(571, 106, 'E - 096 Dt', 2, '-', '-', '-', 1, 1, '-', 'Termometer Raksa', NULL, 'Laik Pakai', 1, '2019-07-24 02:27:16', '2019-08-16 02:15:32'),
(572, 106, 'E - 096 Dt', 2, 'Dr Care', '-', '-', 1, 1, '-', 'Termometer Digital', NULL, 'Laik Pakai', 1, '2019-07-24 02:27:20', '2019-08-16 02:15:32'),
(573, 107, 'E - 097 Dt', 34, 'Omron', 'HEM - 7203', '20141102332VG', 1, 1, 'Baterai 4 buah', '-', NULL, 'Laik Pakai', 1, '2019-07-26 03:27:51', '2019-08-06 02:06:46'),
(574, 108, 'E - 098 Dt', 35, 'WAP LAB', 'WP-40125', 'LS16BAD0000040', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-29 02:47:59', '2019-08-01 02:51:45'),
(575, 108, 'E - 098 Dt', 42, 'BTL', 'E30', 'E066E003547', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-29 02:59:16', '2019-08-01 02:51:48'),
(576, 109, 'E - 099 Dt', 32, 'analogi medical', 'AM 1200', 'B811014Q273', 1, 1, 'Lengkap', '-', NULL, NULL, 1, '2019-07-29 06:55:51', '2019-08-08 05:01:32'),
(577, 110, 'E - 100 Dt', 34, 'Omron', 'HEM - 7211', '20150100229VG', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2019-07-31 05:56:51', '2019-08-05 06:50:06'),
(578, 110, 'E - 100 Dt', 55, 'Beurer', 'PO 30', 'B27/008038', 1, 1, 'Dompet', '-', NULL, 'Laik Pakai', 1, '2019-07-31 05:59:28', '2019-08-05 06:50:06'),
(579, 110, 'E - 100 Dt', 26, 'General Care', 'PHLEGM SUCTION', '2016010297', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-31 06:03:59', '2019-08-05 06:50:06'),
(580, 110, 'E - 100 Dt', 57, 'ABN', 'Spectrum', '846933', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-31 06:04:56', '2019-08-05 06:50:06'),
(581, 110, 'E - 100 Dt', 19, 'Dyna', 'DNA - 100 R', '-', 1, 1, '-', 'Tidak ada stand', NULL, 'Laik Pakai', 1, '2019-07-31 06:05:44', '2019-08-05 06:50:06'),
(582, 110, 'E - 100 Dt', 1, 'Sharp', '-', '0001787', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-07-31 06:08:34', '2019-08-05 06:50:06'),
(583, 111, 'E - 101 Dt', 41, 'Bistos', 'Hi - bebe', 'BABBC1135', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-08-05 02:09:48', '2019-08-16 02:09:35'),
(584, 111, 'E - 101 Dt', 57, 'ERKA', 'Klinikerkameter', '13300632', 1, 1, 'Stand', '-', NULL, 'Laik Pakai', 1, '2019-08-05 02:14:07', '2019-08-16 02:09:35'),
(585, 111, 'E - 101 Dt', 57, 'Riester', 'Novapresameter', '100311628', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-05 02:17:39', '2019-08-16 02:09:35'),
(586, 111, 'E - 101 Dt', 21, 'Omron', 'Comp-AIR', '6900629U', 1, 1, 'Tdk ada selang', '-', NULL, 'Laik Pakai', 1, '2019-08-05 02:22:50', '2019-08-16 02:09:35'),
(587, 111, 'E - 101 Dt', 42, 'BTL', 'BTL-08 MT Plus ecg', '08 MT - 0732744', 1, 1, '-', 'Tanpa kabel power', NULL, 'Laik Pakai', 1, '2019-08-05 02:38:01', '2019-08-16 02:09:35'),
(588, 111, 'E - 101 Dt', 1, 'NESCO O2', '-', '-', 1, 1, '-', '', NULL, 'Laik Pakai', 1, '2019-08-05 02:40:12', '2019-08-16 02:09:35'),
(589, 111, 'E - 101 Dt', 1, 'One Med', '-', '-', 1, 1, '-', '', NULL, 'Laik Pakai', 1, '2019-08-05 02:40:39', '2019-08-16 02:09:35'),
(590, 112, 'E - 102 Dt', 37, 'ZOLL', 'AEDPro', 'AA14B030918', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-06 02:48:17', '2019-08-07 03:30:22'),
(591, 112, 'E - 102 Dt', 21, 'OMRON', '-', '20110408420UF', 1, 1, 'Selang', '-', NULL, 'Laik Pakai', 1, '2019-08-06 02:52:12', '2019-08-07 03:30:22'),
(592, 115, 'E - 105 Dt', 57, 'Riester', 'Ri - san', '170543786', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-06 03:09:25', '2019-08-14 00:49:24'),
(593, 115, 'E - 105 Dt', 57, 'Riester', 'Ri - san', '180742698', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-08-06 03:09:35', '2019-08-14 00:49:24'),
(594, 114, 'E - 104 Dt', 35, 'Heraeus', 'Labofuge 200', '40231113', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-08-06 03:14:58', '2019-08-14 00:49:04'),
(595, 113, 'E - 103 Dt', 35, 'Heraeus', 'Labofuge 200', '40771758', 1, 1, 'Kabel power', '-', NULL, 'Laik Pakai', 1, '2019-08-06 03:18:33', '2019-08-14 00:48:36'),
(596, 113, 'E - 103 Dt', 30, 'Resonance', 'R27e', 'R27A19C000932', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-06 03:21:39', '2019-08-14 00:48:36'),
(597, 116, 'E - 106 Dt', 55, 'General Care', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-07 01:26:44', '2019-08-14 00:51:02'),
(598, 116, 'E - 106 Dt', 57, 'Riester', 'big ben round', '180544370', 1, 1, '-', 'tdk ada stand', NULL, 'Laik Pakai', 1, '2019-08-07 01:27:30', '2019-08-14 00:51:02'),
(599, 117, 'E - 107 Dt', 48, 'Fresenius Kabi', 'Optima PT', '21454193', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-07 04:03:55', '2019-08-14 00:58:12'),
(600, 118, 'E - 108 Dt', 21, 'ABN', 'Compamist 1', '1208942A', 1, 1, 'Mouth piece, tempat obat', '-', NULL, 'Laik Pakai', 1, '2019-08-09 07:50:16', '2019-10-04 09:25:12'),
(601, 118, 'E - 108 Dt', 57, 'Riester', 'nova-ecoline', '150516073', 1, 1, '-', 'Bulb rusak', NULL, 'Laik Pakai', 1, '2019-08-09 07:52:14', '2019-10-04 09:25:12'),
(602, 118, 'E - 108 Dt', 57, 'Riester', 'nova - ecoline', '150513190', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-09 07:53:21', '2019-10-04 09:25:12'),
(603, 118, 'E - 108 Dt', 57, 'Riester', 'nova - ecoline', '151061818', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-09 07:57:08', '2019-10-04 09:25:12'),
(604, 118, 'E - 108 Dt', 9, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-09 07:59:32', '2019-10-04 09:25:12'),
(605, 118, 'E - 108 Dt', 9, 'Sella', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-09 08:02:05', '2019-10-04 09:25:12'),
(606, 118, 'E - 108 Dt', 9, 'One Med', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-09 08:08:58', '2019-10-04 09:25:12'),
(607, 118, 'E - 108 Dt', 19, 'MASTERLIGHT', 'MR-1', '-', 1, 1, '-', 'Tdk ada Stand', NULL, 'Laik Pakai', 1, '2019-08-09 08:14:50', '2019-10-04 09:25:12'),
(608, 118, 'E - 108 Dt', 1, 'Corona', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-09 08:20:16', '2019-10-04 09:25:12'),
(609, 119, 'E - 109 Dt', 42, 'BLT', 'BLT E30', 'E066E003548', 1, 1, 'kabel lead', '-', NULL, 'Laik Pakai', 1, '2019-08-13 01:16:07', '2019-08-14 00:54:04'),
(610, 120, 'E - 110 Dt', 2, 'Beurer', 'ft 09/1', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-22 02:50:28', '2019-09-13 09:26:01'),
(611, 121, 'E - 111 Dt', 59, 'MIR', 'Spirolab III', 'A23-053.04332', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-08-22 06:04:19', '2019-09-03 02:07:19'),
(612, 122, 'E - 112 Dt', 30, 'sibelmed', 'sibelsound 400', '207-A 403', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-23 02:37:33', '2019-08-29 06:10:48'),
(614, 123, 'E - 113 Dt', 30, 'sibelmed', 'AS5-AOM', '205 D670/06', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-08-23 03:01:29', '2019-09-13 08:46:58'),
(615, 122, 'E - 112 Dt', 59, 'MIR', 'Spirobank II', 'A23-060.03983', 1, 1, 'Laptop', '-', NULL, 'Laik Pakai', 1, '2019-08-23 03:08:23', '2019-08-29 06:10:48'),
(616, 124, 'E - 114 Dt', 42, 'Comen', 'cm300', '30160940080G', 1, 1, '-', 'Tidak ada Kabel Power', NULL, 'Laik Pakai', 1, '2019-08-27 02:30:55', '2019-08-27 03:36:27'),
(617, 125, 'E - 115 Dt', 12, 'Transferpette', 'S', '-', 1, 1, '-', '10-100 uL', NULL, 'Laik Pakai', 1, '2019-08-28 07:04:19', '2019-10-18 03:06:32'),
(618, 126, 'E - 116 Dt', 57, 'OneMed', '-', '1526998', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-02 00:24:19', '2019-09-03 02:15:57'),
(619, 128, 'E - 117 Dt', 12, 'Socorex', 'Acura', '82516121421', 1, 1, '-', '5-50', NULL, 'Laik Pakai', 1, '2019-09-03 02:37:51', '2019-09-17 03:48:27'),
(620, 128, 'E - 117 Dt', 10, 'eppendorf', 'research', '2323679', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-03 02:39:11', '2019-09-17 03:48:27'),
(621, 128, 'E - 117 Dt', 51, 'K', 'VRN-360', '1203568', 1, 1, '-', 'timer tidak berfungsi', NULL, 'Laik Pakai', 1, '2019-09-03 02:40:23', '2019-09-17 03:48:27'),
(622, 128, 'E - 117 Dt', 35, 'K', 'PLC - 03', '707850', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-03 02:41:05', '2019-09-17 03:48:27'),
(623, 129, 'E - 118 Dt', 49, 'Digisystem', 'DSI - 300 D', '13060208', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-03 02:51:02', '2019-09-10 01:30:40'),
(624, 130, 'E - 119 Dt', 42, 'Fukuda Denshi', 'CardiMax', '22038913', 1, 1, 'Lengkap', '-', NULL, 'Laik Pakai', 1, '2019-09-03 02:59:03', '2019-09-06 05:56:25'),
(625, 131, 'E - 120 Dt', 10, 'eppendorf', 'Research', '4776841', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2019-09-03 06:43:39', '2019-09-25 00:07:06'),
(626, 131, 'E - 120 Dt', 10, 'socorex', 'acura', '15041023', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2019-09-03 06:44:44', '2019-09-25 00:07:06'),
(627, 131, 'E - 120 Dt', 10, 'eppendorf', 'Research', '3457181', 1, 1, '-', '50 uL', NULL, 'Tidak Laik Pakai', 1, '2019-09-03 06:44:49', '2019-09-25 00:07:06'),
(628, 131, 'E - 120 Dt', 10, 'eppendorf', 'Research', '1847412', 1, 1, '-', '25 uL', NULL, 'Laik Pakai', 1, '2019-09-03 06:45:27', '2019-09-25 00:07:06'),
(629, 131, 'E - 120 Dt', 10, 'socorex', 'acura', '13072097', 1, 1, '-', '200 uL', NULL, 'Laik Pakai', 1, '2019-09-03 06:46:36', '2019-09-25 00:07:06'),
(630, 131, 'E - 120 Dt', 10, 'socorex', 'acura', '15051492', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2019-09-03 06:48:26', '2019-09-25 00:07:06'),
(631, 132, 'E - 121 Dt', 34, 'Omron', 'HEM 7011 C1', '20100104147LF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:17:13', '2019-09-18 02:51:23'),
(632, 132, 'E - 121 Dt', 34, 'Beurer', 'BM26', 'Z52/236849', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:17:22', '2019-09-18 02:51:24'),
(633, 132, 'E - 121 Dt', 34, 'Omron', 'HEM 7117', '20150101589VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:17:24', '2019-09-18 02:51:26'),
(634, 132, 'E - 121 Dt', 34, 'Omron', 'HEM 7117', '20150101585VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:17:25', '2019-09-18 02:51:26'),
(635, 132, 'E - 121 Dt', 34, 'Beurer', 'BM26', 'Z52/251409', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:17:27', '2019-09-18 02:51:28'),
(636, 132, 'E - 121 Dt', 34, 'Beurer', 'BM26', 'A19/285780', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:17:40', '2019-09-18 02:51:30'),
(637, 132, 'E - 121 Dt', 34, 'Omron', 'HEM 7203', '20130810409VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:17:41', '2019-09-18 02:51:31'),
(638, 132, 'E - 121 Dt', 34, 'LAICA', 'BM2001', '12017706894103', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:18:02', '2019-09-18 02:51:31'),
(639, 132, 'E - 121 Dt', 57, 'Riester', 'nova ecoline', '130102869', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:18:35', '2019-09-18 02:51:32'),
(640, 132, 'E - 121 Dt', 57, 'Riester', 'nova ecoline', '130102877', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:18:39', '2019-09-18 02:51:34'),
(641, 132, 'E - 121 Dt', 57, 'Riester', 'diplomat presameter', '060320246', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 03:18:41', '2019-09-18 02:51:36'),
(642, 132, 'E - 121 Dt', 57, 'Riester', 'nova presameter', '121243245', 1, 1, '-', 'Bulb Bocor', NULL, 'Laik Pakai', 1, '2019-09-05 03:18:42', '2019-09-18 02:51:37'),
(643, 133, 'E - 122 Dt', 58, 'ABN', 'SPECTRUM', '861214', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-05 06:05:17', '2019-09-10 07:48:16'),
(644, 134, 'E - 123 Dt', 57, 'Riester', 'Nova ecoline', '131249535', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-18 02:26:26', '2019-09-23 04:21:54'),
(645, 134, 'E - 123 Dt', 37, 'LifePOINT', '-', '174080305', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-18 02:30:15', '2019-09-23 04:21:54'),
(646, 134, 'E - 123 Dt', 42, 'Fukuda denshi', 'Cardimax', '21057935', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-18 02:31:20', '2019-09-23 04:21:54'),
(647, 134, 'E - 123 Dt', 59, 'Chestgraph', 'Hi-101', '1131330', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-18 02:42:03', '2019-09-23 04:21:54'),
(648, 134, 'E - 123 Dt', 42, 'BTL', 'BTL-08 SD ecg', '071D0B007591', 1, 1, 'Kabel power', 'Menunggu probe ecg', NULL, 'Laik Pakai', 1, '2019-09-18 02:56:56', '2019-09-18 06:16:34'),
(649, 136, 'E - 124 Dt', 41, 'Bistos', 'Bt-220L', 'BFGA0250', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-23 00:22:37', '2019-09-24 04:39:25'),
(650, 136, 'E - 124 Dt', 30, 'Triveni', 'TAM-25', '10101543', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-09-23 00:24:44', '2019-09-24 04:39:25'),
(651, 136, 'E - 124 Dt', 35, 'K', 'PLC - 03', '1406568', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-23 00:34:46', '2019-09-24 04:39:25'),
(652, 136, 'E - 124 Dt', 85, 'BTL', 'BTL - 08 SD ECG', '071D - B - 02665', 1, 1, 'Pc', 'Kertas tdk ada', NULL, 'Laik Pakai', 1, '2019-09-23 00:53:26', '2019-09-23 03:47:58'),
(653, 136, 'E - 124 Dt', 59, 'BTL', 'BTL -08 Spiro', '-', 1, 1, '+ laptop + pipa', '-', NULL, 'Laik Pakai', 1, '2019-09-23 01:29:59', '2019-09-24 04:39:25'),
(654, 137, 'E - 125 Dt', 55, 'ChoiceMMed', 'MD300C15D', '171826200512', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 03:48:19', '2019-10-10 00:38:25'),
(655, 137, 'E - 125 Dt', 41, 'Lotus', '-', '-', 1, 1, 'Tas , charger', '-', NULL, 'Laik Pakai', 1, '2019-09-25 03:50:38', '2019-10-10 00:38:25'),
(656, 137, 'E - 125 Dt', 57, 'Abn', 'Spectrum', '105750', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 03:52:09', '2019-10-10 00:38:25'),
(657, 137, 'E - 125 Dt', 41, 'Bistos', 'Bt - 200', 'BBH10731', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-09-25 03:52:31', '2019-10-10 00:38:25'),
(658, 137, 'E - 125 Dt', 57, 'Abn', 'Spectrum', '173527', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 03:55:29', '2019-10-10 00:38:25'),
(659, 137, 'E - 125 Dt', 57, 'Abn', 'Spectrum', '815500', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 03:56:20', '2019-10-10 00:38:25'),
(660, 137, 'E - 125 Dt', 57, 'OneMed', '-', '1325075', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 03:57:36', '2019-10-10 00:38:25'),
(661, 137, 'E - 125 Dt', 41, 'Bistos', 'Bt - 200', 'BBG31332', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-09-25 03:58:03', '2019-10-10 00:38:25'),
(662, 137, 'E - 125 Dt', 57, 'Abn', 'Spectrum', '967455', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 03:58:45', '2019-10-10 00:38:25'),
(663, 137, 'E - 125 Dt', 2, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:01:21', '2019-10-10 00:38:25'),
(664, 137, 'E - 125 Dt', 2, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:01:40', '2019-10-10 00:38:25'),
(665, 137, 'E - 125 Dt', 2, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:01:43', '2019-10-10 00:38:25'),
(666, 137, 'E - 125 Dt', 2, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:01:47', '2019-10-10 00:38:25'),
(667, 137, 'E - 125 Dt', 2, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:01:52', '2019-10-10 00:38:25'),
(668, 137, 'E - 125 Dt', 2, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:02:01', '2019-10-10 00:38:25'),
(669, 137, 'E - 125 Dt', 2, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:02:07', '2019-10-10 00:38:25'),
(670, 137, 'E - 125 Dt', 2, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:02:17', '2019-10-10 00:38:25'),
(671, 137, 'E - 125 Dt', 2, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:02:21', '2019-10-10 00:38:25'),
(672, 137, 'E - 125 Dt', 57, 'Abn', 'Spectrum', '895320', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:02:38', '2019-10-10 00:38:25'),
(673, 137, 'E - 125 Dt', 55, 'Mediaid', '-', 'FG12K00244', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2019-09-25 04:06:26', '2019-10-10 00:38:25'),
(674, 140, 'E - 128 Dt', 35, 'Health', 'H-c-12', '-', 1, 1, '-', 'Timer rusak', NULL, 'Laik Pakai', 1, '2019-09-25 06:04:16', '2019-10-10 05:42:24'),
(675, 138, 'E - 126 Dt', 57, 'Riester', 'nova-presameter', '160762983', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 06:04:49', '2019-11-14 00:28:57'),
(676, 140, 'E - 128 Dt', 42, 'Btl', 'Btl - 08 SD ecg', '071D - b - 05232', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 06:07:00', '2019-10-10 05:42:26'),
(677, 138, 'E - 126 Dt', 42, 'Fukuda Denshi', 'FX-7102', '22038944', 1, 1, 'Aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-09-25 06:07:08', '2019-10-10 05:40:24'),
(678, 140, 'E - 128 Dt', 55, 'General care', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 06:08:09', '2019-10-10 05:42:28'),
(679, 139, 'E - 127 Dt', 10, 'SOCOREX', 'ACURA 815', '26061964', 1, 1, '-', '1000 ul', NULL, 'Laik Pakai', 1, '2019-09-25 06:09:32', '2019-11-14 00:27:48'),
(680, 140, 'E - 128 Dt', 35, 'K', 'Plc - 03', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 06:13:50', '2019-10-10 05:42:53'),
(681, 140, 'E - 128 Dt', 57, 'Riester', 'Nova - presameter', '140974037', 1, 1, '-', 'Bulb bocor', NULL, 'Laik Pakai', 1, '2019-09-25 06:19:38', '2019-10-10 05:42:30'),
(682, 139, 'E - 127 Dt', 10, 'SOCOREX', 'ACURA 815', '26041023', 1, 1, '-', '500 ul', NULL, 'Laik Pakai', 1, '2019-09-25 06:19:43', '2019-11-14 00:27:49'),
(683, 140, 'E - 128 Dt', 57, 'Riester', 'Nova - presameter', '140153954', 1, 1, '-', '', NULL, 'Laik Pakai', 1, '2019-09-25 06:19:45', '2019-10-10 05:42:34'),
(684, 140, 'E - 128 Dt', 59, 'Chestgraph', 'Hi - 101', '1135830', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 06:21:34', '2019-10-10 05:39:14'),
(685, 139, 'E - 127 Dt', 35, 'ap lab', 'WP-40125', 'LS16BAD0000064', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-25 06:22:02', '2019-11-14 00:27:49'),
(686, 139, 'E - 127 Dt', 42, 'FUKUDA DENSHI', 'FX - 7102', '21088114', 1, 1, 'Aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-09-25 06:24:43', '2019-10-03 02:54:29'),
(687, 139, 'E - 127 Dt', 30, 'resonance', 'R27A', 'R27A17C000504', 1, 1, 'Aķsesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-09-25 06:30:15', '2019-10-03 02:54:29'),
(688, 141, 'E - 129 Dt', 42, '-', '-', 'F1182E0165', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-09-26 00:53:49', '2019-09-26 08:34:30'),
(689, 141, 'E - 129 Dt', 21, 'Omron', 'Ne - c28', '20110606277UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 00:55:10', '2019-11-14 00:49:52'),
(690, 141, 'E - 129 Dt', 21, 'Omron', 'Ne - c28', '20140808288UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 00:55:29', '2019-11-14 00:49:53'),
(691, 141, 'E - 129 Dt', 55, 'Nonin', 'Pulse Oxymeter 8500', '500586891', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 00:56:43', '2019-11-14 00:49:55'),
(692, 141, 'E - 129 Dt', 1, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 00:57:36', '2019-11-14 00:49:57'),
(693, 141, 'E - 129 Dt', 1, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 00:57:43', '2019-11-14 00:50:00'),
(694, 141, 'E - 129 Dt', 55, 'Ohmeda', 'Tuffsat', 'FCB09480030SA', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 00:57:55', '2019-11-14 00:50:48'),
(695, 141, 'E - 129 Dt', 26, 'JHAL', 'JX820Z', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 00:59:46', '2019-11-14 00:50:44'),
(696, 141, 'E - 129 Dt', 57, 'ABN', 'SpectruM', '080302', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 01:00:57', '2019-11-14 00:50:43'),
(697, 141, 'E - 129 Dt', 57, 'ABN', 'SpectruM', '106972', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 01:01:02', '2019-11-14 00:50:18'),
(698, 141, 'E - 129 Dt', 37, 'Zoll', '-', 'X12E551255', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 01:02:43', '2019-11-14 00:50:16'),
(699, 142, 'E - 130 Dt', 41, 'Soul', 'Bf-600', '60074679', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 06:38:18', '2019-10-18 08:39:58'),
(700, 142, 'E - 130 Dt', 41, 'Soul', 'Bf-600', '60074580', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 06:42:00', '2019-10-18 08:39:58'),
(701, 142, 'E - 130 Dt', 41, 'Soul', 'Bf-600', '60074573', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 06:42:55', '2019-10-18 08:39:58'),
(702, 142, 'E - 130 Dt', 9, 'Safety', 'SH-8015', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 06:45:27', '2019-10-18 08:39:58'),
(703, 142, 'E - 130 Dt', 9, 'Safety', 'SH-8015', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 06:45:31', '2019-10-18 08:39:58'),
(704, 142, 'E - 130 Dt', 26, 'Lusty', '7E-A', '19H04190659', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 06:48:36', '2019-10-18 08:39:58'),
(705, 142, 'E - 130 Dt', 26, 'Lusty', '7E-A', '19H04190263', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 06:52:38', '2019-10-18 08:39:58'),
(706, 142, 'E - 130 Dt', 26, 'Lusty', '7E-A', '19H04190257', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 06:54:02', '2019-10-18 08:39:58'),
(707, 142, 'E - 130 Dt', 19, 'Panda', 'OL-009', '19101160', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 07:00:17', '2019-10-18 08:39:58'),
(708, 142, 'E - 130 Dt', 19, 'Panda', 'OL-009', '19101158', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-26 07:00:22', '2019-10-18 08:39:58'),
(709, 142, 'E - 130 Dt', 28, '-', 'YXQ-LS50-SII', '-', 1, 1, '-', 'belum dilakukan pengecekan', NULL, 'Laik Pakai', 1, '2019-09-26 07:06:41', '2019-10-18 08:39:58'),
(710, 142, 'E - 130 Dt', 28, '-', 'YXQ-LS50-SII', '-', 1, 1, '-', 'belum dilakukan pengecekan', NULL, 'Laik Pakai', 1, '2019-09-26 07:10:06', '2019-10-18 08:39:58'),
(711, 142, 'E - 130 Dt', 28, '-', 'YXQ-LS50-SII', '-', 1, 1, '-', 'belum dilakukan pengecekan', NULL, 'Laik Pakai', 1, '2019-09-26 07:10:09', '2019-10-18 08:39:58'),
(712, 143, 'E - 131 Dt', 19, 'KaWe', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-30 01:10:37', '2019-10-02 02:11:29'),
(713, 143, 'E - 131 Dt', 61, 'MELAG', '75', '00752547', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-09-30 01:12:46', '2019-10-02 02:11:29'),
(715, 145, 'E - 132 Dt', 57, 'GEA', '-', '582133', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-10-02 03:49:12', '2019-10-18 08:46:59'),
(716, 145, 'E - 132 Dt', 57, 'General Care', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 03:49:13', '2019-10-18 08:46:59'),
(717, 145, 'E - 132 Dt', 57, 'GEA', '-', '615675', 1, 1, '-', 'manset bocor', NULL, 'Tidak Laik Pakai', 1, '2019-10-02 03:49:55', '2019-10-18 08:46:59'),
(718, 145, 'E - 132 Dt', 41, 'bistos', '-', 'BBEA2604', 1, 1, '-', 'tidak ada penutup baterai', NULL, 'Laik Pakai', 1, '2019-10-02 03:52:25', '2019-10-18 08:46:59'),
(719, 145, 'E - 132 Dt', 57, 'Riester', 'nova ecoline', '16411284', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 03:52:29', '2019-10-18 08:46:59'),
(720, 145, 'E - 132 Dt', 57, 'OneMed', '-', '683366', 1, 1, '-', 'bulb bocor', NULL, 'Laik Pakai', 1, '2019-10-02 03:53:11', '2019-10-18 08:46:59'),
(721, 146, 'E - 133 Dt', 57, 'ERKA', 'Erkameter', '13523681', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:02:32', '2019-10-18 08:49:59'),
(722, 146, 'E - 133 Dt', 21, 'Omron', 'Comp-AIR', '20150500457UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:08:46', '2019-10-18 08:49:59'),
(723, 147, 'E - 134 Dt', 57, 'Riester', 'Nova ecoline', '131253268', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:11:49', '2019-10-18 08:52:54'),
(724, 147, 'E - 134 Dt', 57, 'ABN', 'Spectrum', '00430174', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:11:52', '2019-10-18 08:52:54'),
(725, 147, 'E - 134 Dt', 57, 'Riester', 'Nova presameter', '170660101', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:12:28', '2019-10-18 08:52:54'),
(726, 147, 'E - 134 Dt', 41, 'Bistos', 'Hi - bebe', 'BAFC31412', 1, 1, '-', 'Display rusak', NULL, 'Laik Pakai', 1, '2019-10-02 04:13:43', '2019-10-18 08:52:54'),
(727, 147, 'E - 134 Dt', 41, 'VCOMIN', 'FD - 300C', '2015 - 12', 11, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:13:49', '2019-10-18 08:52:54'),
(728, 147, 'E - 134 Dt', 9, 'GEA Medical', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:14:59', '2019-10-18 08:52:54'),
(729, 148, 'E - 135 Dt', 35, 'Hettich', 'EBA 20', '0070403', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:17:00', '2019-10-18 08:58:55'),
(730, 149, 'E - 136 Dt', 9, 'One Med', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:18:59', '2019-10-18 09:02:06'),
(731, 149, 'E - 136 Dt', 57, 'General care', 'Mercurial', '-', 1, 1, '-', '-', NULL, 'Batal karena bergelembung', 1, '2019-10-02 04:19:43', '2019-10-18 09:21:36'),
(732, 149, 'E - 136 Dt', 57, 'Riester', 'Nove ecoline', '151161414', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:20:22', '2019-10-18 09:02:06'),
(733, 149, 'E - 136 Dt', 57, 'ABN', 'Spectrum', '00043740', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 04:20:59', '2019-10-18 09:02:06'),
(734, 150, 'E - 137 Dt', 41, 'Lotus', 'BF - 600+', '60072578', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:48:04', '2019-10-18 09:10:34'),
(735, 150, 'E - 137 Dt', 57, 'Riester', 'nova ecoline', '160962795', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:48:34', '2019-10-18 09:10:34'),
(736, 150, 'E - 137 Dt', 57, 'Riester', 'nova presameter', '171162768', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:48:38', '2019-10-18 09:10:34'),
(737, 150, 'E - 137 Dt', 57, 'Riester', 'nova presameter', '171160189', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:48:50', '2019-10-18 09:10:34'),
(738, 150, 'E - 137 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:49:24', '2019-10-18 09:10:34'),
(739, 150, 'E - 137 Dt', 9, 'One Med', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:49:26', '2019-10-18 09:10:34'),
(740, 151, 'E - 138 Dt', 2, 'Thermo One', 'ALPHA 3', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:50:09', '2019-10-29 03:56:54');
INSERT INTO `lab_detail_order` (`id`, `id_order`, `no_order`, `alat_id`, `merek`, `model`, `seri`, `jumlah`, `fungsi`, `kelengkapan`, `keterangan`, `no_registrasi`, `catatan`, `ambil`, `created_at`, `updated_at`) VALUES
(741, 151, 'E - 138 Dt', 57, 'ABN', 'Spectrum', '842787', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:50:33', '2019-10-29 03:56:54'),
(742, 151, 'E - 138 Dt', 35, 'nuve', 'NF200', '03-3183', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:51:04', '2019-10-29 03:56:54'),
(743, 152, 'E - 139 Dt', 9, 'One Med', 'OD 230', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:51:40', '2019-10-18 09:20:59'),
(744, 152, 'E - 139 Dt', 57, 'Riester', 'nova ecoline', '130736356', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:51:56', '2019-10-18 09:20:59'),
(745, 152, 'E - 139 Dt', 57, 'mercurial', 'ALP', '-', 1, 1, '-', 'manset dan bulb bocor', NULL, 'Batal karena bergelembung', 1, '2019-10-02 05:51:59', '2019-10-18 09:20:59'),
(746, 150, 'E - 137 Dt', 57, 'Riester', 'nova ecoline', '160962796', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-02 05:56:19', '2019-10-18 09:10:34'),
(747, 155, 'E - 142 Dt', 42, 'BLT', 'E30', 'E066E033586', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 03:17:27', '2019-10-11 02:34:20'),
(748, 154, 'E - 141 Dt', 42, 'BTL', 'BTL-08 SD ECG', '071D-B-02691', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 03:19:15', '2019-10-10 05:46:40'),
(749, 153, 'E - 140 Dt', 55, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 03:22:38', '2019-10-10 05:45:48'),
(750, 153, 'E - 140 Dt', 42, 'btl', 'btl-08 sd ecg', '071d-b-02613', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 03:29:16', '2019-10-10 05:45:48'),
(751, 156, 'E - 143 Dt', 1, 'Avico', '-', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-10-03 05:51:58', '2019-10-25 01:47:16'),
(752, 156, 'E - 143 Dt', 1, 'Gea medical', '-Yr-86-9', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 05:52:05', '2019-10-25 01:47:16'),
(753, 156, 'E - 143 Dt', 1, 'Gea', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 05:52:54', '2019-10-25 01:47:16'),
(754, 156, 'E - 143 Dt', 1, 'Biomedix', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 05:52:54', '2019-10-25 01:47:16'),
(755, 156, 'E - 143 Dt', 32, 'Bistos', 'Bt-750', 'Hd4007', 1, 1, '-', 'ecg spo2', NULL, 'Laik Pakai', 1, '2019-10-03 05:56:24', '2019-10-25 01:47:16'),
(756, 156, 'E - 143 Dt', 55, 'Elitech', 'Fox 1n', 'Fx5191a5375', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 05:57:30', '2019-10-25 01:47:16'),
(757, 156, 'E - 143 Dt', 55, 'Elitech', 'Fox 1n', 'Fx5191a5130', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 05:57:48', '2019-10-25 01:47:16'),
(759, 156, 'E - 143 Dt', 55, 'Elitech', 'Fox 1n', 'Fx5191a5266', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 06:00:20', '2019-10-25 01:47:16'),
(760, 156, 'E - 143 Dt', 55, 'Elitech', 'Fox 1n', 'Fx5191a5700', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 06:00:53', '2019-10-25 01:47:16'),
(761, 156, 'E - 143 Dt', 12, 'Socorex', 'Acura 825', '0442771', 1, 1, '-', '100 - 1000 ul', NULL, 'Laik Pakai', 1, '2019-10-03 06:01:33', '2019-10-25 01:47:16'),
(762, 156, 'E - 143 Dt', 55, 'Elitech', 'Fox 1n', 'Fx5191a4882', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 06:02:57', '2019-10-25 01:47:16'),
(763, 156, 'E - 143 Dt', 10, 'Socorex', 'Acura 815', '19061368', 1, 1, '-', '500 ul', NULL, 'Tidak Laik Pakai', 1, '2019-10-03 06:03:07', '2019-10-25 01:47:16'),
(764, 156, 'E - 143 Dt', 12, 'Socorex', 'Acura 825', '20111723', 1, 1, '-', '5 - 50 ul', NULL, 'Laik Pakai', 1, '2019-10-03 06:03:38', '2019-10-25 01:47:16'),
(765, 156, 'E - 143 Dt', 32, 'philips', 'g30', 'cn3270846', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 06:32:42', '2019-10-25 01:47:16'),
(766, 156, 'E - 143 Dt', 50, 'TWINBRID', '-', '-', 1, 1, '-', 'belum dilakukan pengecekan', NULL, 'Laik Pakai', 0, '2019-10-03 06:34:52', '2019-10-04 01:02:36'),
(768, 156, 'E - 143 Dt', 68, 'Allied', '-', '20140206003', 1, 1, '-', 'belum dilakukan pengecekan', NULL, 'Laik Pakai', 1, '2019-10-03 06:35:04', '2019-10-25 01:47:16'),
(769, 156, 'E - 143 Dt', 68, 'Allied', '-', '20091214033', 1, 1, '-', 'belum dilakukan pengecekan', NULL, 'Laik Pakai', 1, '2019-10-03 06:35:29', '2019-10-25 01:47:16'),
(772, 156, 'E - 143 Dt', 53, 'memmert', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 06:41:40', '2019-10-25 01:47:16'),
(773, 156, 'E - 143 Dt', 49, 'memmert', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 06:41:54', '2019-10-25 01:47:16'),
(774, 156, 'E - 143 Dt', 37, 'Paramedic', '-', 'AH2H0A002', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-03 06:55:33', '2019-10-25 01:47:16'),
(775, 157, 'E - 144 Dt', 57, 'Riester', 'nova-presameter', '083414', 1, 1, '-', 'roda kurang 1', NULL, 'Laik Pakai', 1, '2019-10-07 02:19:53', '2019-10-28 03:56:26'),
(776, 157, 'E - 144 Dt', 55, 'Elitech', 'FOX1', 'FX115BD4474', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-07 02:20:29', '2019-10-28 03:56:26'),
(777, 157, 'E - 144 Dt', 34, 'OMRON', 'HEM-7120', '20180303112VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-07 02:21:04', '2019-10-28 03:56:26'),
(778, 157, 'E - 144 Dt', 10, 'Accumax PRO', '-', 'L1667742', 1, 1, '-', '50ul', NULL, 'Laik Pakai', 1, '2019-10-07 02:21:58', '2019-10-28 03:56:26'),
(779, 157, 'E - 144 Dt', 10, 'Accumax PRO', '-', 'L1693470', 1, 1, '-', '100ul', NULL, 'Laik Pakai', 1, '2019-10-07 02:22:01', '2019-10-28 03:56:26'),
(780, 157, 'E - 144 Dt', 12, 'Accumax PRO', '-', 'KI593430', 1, 1, '-', '200-1000ul', NULL, 'Laik Pakai', 1, '2019-10-07 02:23:11', '2019-10-28 03:56:26'),
(781, 157, 'E - 144 Dt', 12, 'Accumax PRO', '-', 'KL602886', 1, 1, '-', '5-50ul', NULL, 'Laik Pakai', 1, '2019-10-07 02:23:14', '2019-10-28 03:56:26'),
(782, 157, 'E - 144 Dt', 35, 'WINA', '507', '5071217283', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-07 02:24:16', '2019-10-28 03:56:26'),
(783, 157, 'E - 144 Dt', 51, 'WINA', '102B', '1020717086', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-07 02:24:53', '2019-10-28 03:56:26'),
(784, 157, 'E - 144 Dt', 1, 'GEA', 'YK-86-9', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-10-07 02:25:51', '2019-10-28 03:56:26'),
(785, 157, 'E - 144 Dt', 21, 'OMRON', 'NE-C28', '20180800703UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-07 02:26:22', '2019-10-28 03:56:26'),
(786, 157, 'E - 144 Dt', 41, 'Bistos', 'Hi Bebe', 'BBJ91303', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-07 02:26:57', '2019-10-28 03:56:26'),
(787, 157, 'E - 144 Dt', 9, 'GEA Medical', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-07 02:27:19', '2019-10-28 03:56:26'),
(788, 158, 'E - 145 Dt', 57, 'OneMed', '-', '1096284', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-07 06:09:32', '2019-10-16 08:13:15'),
(789, 159, 'E - 146 Dt', 48, 'Fresenius Kabi', 'Optima VS', '22209355', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-09 01:07:33', '2019-10-18 09:27:56'),
(790, 159, 'E - 146 Dt', 48, 'Fresenius Kabi', 'Optima VS', '22920406', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-10-09 01:07:36', '2019-10-18 09:27:56'),
(791, 161, 'E - 147 Dt', 21, 'OMRON', 'NE - C28', '20141212663UF', 1, 1, 'Aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:36:19', '2019-11-12 06:40:02'),
(792, 161, 'E - 147 Dt', 41, 'MASTER', 'FD-800B', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:42:03', '2019-11-12 06:40:02'),
(793, 161, 'E - 147 Dt', 41, 'Bistos', 'BT - 220', 'BFFC0930', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:43:31', '2019-11-12 06:40:02'),
(794, 161, 'E - 147 Dt', 41, 'Bistos', 'BT - 220', 'BFFC0976', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:45:15', '2019-11-12 06:40:02'),
(795, 161, 'E - 147 Dt', 58, 'ABN', 'DM - 500', '161006144', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:48:19', '2019-11-12 06:40:02'),
(796, 161, 'E - 147 Dt', 12, 'onemed', 'Dragon onemed', 'YL173AB000829', 1, 1, '-', '10 - 100 uL', NULL, 'Laik Pakai', 1, '2019-10-11 01:48:42', '2019-11-12 06:40:02'),
(797, 161, 'E - 147 Dt', 58, 'ABN', 'DM - 500', '161006143', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:49:33', '2019-11-12 06:40:02'),
(798, 161, 'E - 147 Dt', 9, 'Rossmax', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:49:47', '2019-11-12 06:40:02'),
(799, 161, 'E - 147 Dt', 9, 'One med', 'OD230', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:51:09', '2019-11-12 06:40:02'),
(800, 161, 'E - 147 Dt', 41, 'MASTER', 'FD-800B', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:51:21', '2019-11-12 06:40:02'),
(801, 161, 'E - 147 Dt', 9, 'One med', 'OD230', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:52:07', '2019-11-12 06:40:02'),
(802, 161, 'E - 147 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-10-11 01:52:13', '2019-11-12 06:40:02'),
(803, 161, 'E - 147 Dt', 9, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:52:31', '2019-11-12 06:40:02'),
(804, 161, 'E - 147 Dt', 2, 'ThermoOne', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:52:48', '2019-11-12 06:40:02'),
(805, 161, 'E - 147 Dt', 9, 'SELLA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:52:56', '2019-11-12 06:40:02'),
(806, 161, 'E - 147 Dt', 35, 'OneMed', '0406-2', '150704', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-10-11 01:54:24', '2019-12-04 07:40:57'),
(807, 161, 'E - 147 Dt', 2, 'ThermoOne', 'ALPHA 1', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:56:37', '2019-11-12 06:40:02'),
(808, 161, 'E - 147 Dt', 58, 'ABN', 'DM - 500', '161005040', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:59:16', '2019-11-12 06:40:02'),
(809, 161, 'E - 147 Dt', 26, 'Uzumcu', 'PA-2', '16043372476', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 01:59:49', '2019-11-12 06:40:02'),
(810, 161, 'E - 147 Dt', 58, 'ABN', 'DM - 500', '161006145', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 02:00:22', '2019-11-12 06:40:02'),
(811, 162, 'E - 148 Dt', 42, 'Bionet', 'CardioCare', 'L0700027', 1, 1, 'Aksesoris lengkap', 'Kabel lead terkelupas', NULL, 'Laik Pakai (Ganti Kabel)', 1, '2019-10-11 02:18:46', '2019-10-11 07:18:32'),
(812, 163, 'E - 149 Dt', 59, 'CHEST', 'HI-101', '1135831', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-11 02:52:56', '2019-10-17 05:56:03'),
(813, 164, 'E - 150 Dt', 9, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-17 02:59:16', '2019-11-12 05:26:04'),
(814, 164, 'E - 150 Dt', 41, 'bistos', 'Hi Bebe', 'BAH70646', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-17 02:59:56', '2019-11-12 05:26:04'),
(815, 164, 'E - 150 Dt', 41, 'bistos', 'Hi Bebe', 'BAH70650', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-17 02:59:58', '2019-11-12 05:26:04'),
(816, 164, 'E - 150 Dt', 12, 'Huawei', '-', '14030731', 1, 1, '-', '10 - 100 uL', NULL, 'Laik Pakai', 1, '2019-10-17 03:01:18', '2019-11-12 05:26:04'),
(817, 164, 'E - 150 Dt', 12, 'Huawei', '-', '16050109', 1, 1, '-', '10 - 100 uL', NULL, 'Tidak Laik Pakai', 1, '2019-10-17 03:01:21', '2019-11-12 05:26:04'),
(818, 164, 'E - 150 Dt', 34, 'Omron', 'HBP-1100', '01008268LF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-17 03:02:06', '2019-11-12 05:26:04'),
(819, 164, 'E - 150 Dt', 57, 'OneMed', '-', '1346216', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-17 03:02:35', '2019-11-12 05:26:04'),
(820, 164, 'E - 150 Dt', 35, '-', '80 - 1', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-17 03:04:27', '2019-11-12 05:26:04'),
(821, 165, 'E - 151 Dt', 42, 'Bionet', 'CardioCare', 'EN-OM1100192', 1, 1, 'Lengkap', '-', NULL, 'Laik Pakai', 1, '2019-10-17 04:14:08', '2019-10-28 03:55:36'),
(822, 165, 'E - 151 Dt', 59, '-', 'MSA99', 'MSA506804007', 1, 1, '-', 'Tidak Bisa Print', NULL, 'Laik Pakai', 1, '2019-10-17 04:15:03', '2019-10-28 03:55:36'),
(823, 166, 'E - 152 Dt', 42, 'fukuda denshi', 'zardimax', '21057903', 1, 1, '-', 'layar bergaris', NULL, 'Laik Pakai', 1, '2019-10-17 06:18:11', '2019-11-05 02:31:52'),
(824, 166, 'E - 152 Dt', 57, 'riester', 'nova presameter', '150763253', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-17 06:19:01', '2019-11-05 02:31:52'),
(825, 167, 'E - 153 Dt', 59, 'CHEST', 'HI-101', '113660', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-17 06:22:13', '2019-10-23 05:15:29'),
(826, 168, 'E-154 Dt', 57, 'General Care', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-21 05:33:37', '2019-10-28 03:47:28'),
(827, 169, 'E - 155 Dt', 57, 'General Care', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-21 05:40:11', '2019-10-28 03:48:07'),
(828, 170, 'E - 156 Dt', 41, 'bistos', 'BT - 220', 'BFEB1186', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-22 06:33:23', '2019-11-11 08:46:39'),
(829, 170, 'E - 156 Dt', 55, 'ChoiceMMed', 'MD300C15D', '171826200214', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-22 06:34:20', '2019-11-11 08:46:39'),
(830, 170, 'E - 156 Dt', 57, 'One Med', 'SPHYGMOMANOMETER', '1322066', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-22 06:35:11', '2019-11-11 08:46:39'),
(831, 170, 'E - 156 Dt', 55, 'MEDIAID', '34 Pulse Oximetry', 'FG12K00265', 1, 1, 'charge', '-', NULL, 'Laik Pakai', 1, '2019-10-22 06:36:25', '2019-11-11 08:46:39'),
(832, 170, 'E - 156 Dt', 1, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-10-22 06:36:50', '2019-11-11 08:46:39'),
(833, 170, 'E - 156 Dt', 10, 'ONEMED', 'DRAGON', 'YL4A038759', 1, 1, '-', '500 ul', NULL, 'Laik Pakai', 1, '2019-10-22 06:37:44', '2019-11-11 08:46:39'),
(834, 170, 'E - 156 Dt', 12, 'ONEMED', 'DRAGON', 'AP42396', 1, 1, '-', '2 - 20 ul', NULL, 'Laik Pakai', 1, '2019-10-22 06:38:26', '2019-11-11 08:46:39'),
(835, 170, 'E - 156 Dt', 19, 'iBS', 'MR -  1', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-22 06:39:11', '2019-11-11 08:46:39'),
(836, 170, 'E - 156 Dt', 9, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-22 06:39:37', '2019-11-11 08:46:39'),
(837, 170, 'E - 156 Dt', 9, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-22 06:40:01', '2019-11-11 08:46:39'),
(838, 170, 'E - 156 Dt', 25, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-22 06:47:57', '2019-11-11 08:46:39'),
(839, 172, 'E - 158 Dt', 57, 'Riester', 'bigben Square', '190142075', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:24:41', '2019-10-24 05:03:46'),
(840, 172, 'E - 158 Dt', 57, 'AND', 'UM - 101', '51310 00330', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:25:19', '2019-10-24 05:03:46'),
(841, 172, 'E - 158 Dt', 57, 'AND', 'UM - 101', '51310 00321', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:25:48', '2019-10-24 05:03:46'),
(842, 172, 'E - 158 Dt', 57, 'AND', 'ÙM - 101', '51310 00324', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:26:15', '2019-10-24 05:03:46'),
(843, 172, 'E - 158 Dt', 42, 'BTL', 'BTL - 08 MT Plus ecg', '073P - 02625', 1, 1, 'Aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:27:44', '2019-10-24 05:03:46'),
(844, 172, 'E - 158 Dt', 35, 'Digisystem', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:28:14', '2019-10-24 05:03:46'),
(845, 172, 'E - 158 Dt', 26, 'MEDI - PUMP', '1132GL', '060300005426', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:29:16', '2019-10-24 05:03:46'),
(846, 172, 'E - 158 Dt', 39, 'PHILIPS', 'HEARTSTART MRx', 'US00587528', 1, 1, 'aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:30:44', '2019-10-24 05:03:46'),
(847, 172, 'E - 158 Dt', 21, 'OMRON', 'NE - U17', '20140900040AF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:31:23', '2019-10-24 05:03:46'),
(848, 172, 'E - 158 Dt', 34, 'beurer', 'BM 75', 'Z21/007850', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 04:57:35', '2019-10-24 05:03:46'),
(849, 174, 'E - 159 Dt', 12, 'SOCOREX', 'ACURA 825', '26062032', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 05:44:52', '2019-11-22 04:47:17'),
(850, 174, 'E - 159 Dt', 35, 'Hettich', 'MICRO 120', '0006645-07', 1, 1, '-', 'kaki hilang satu', NULL, 'Laik Pakai', 1, '2019-10-23 05:48:44', '2019-11-22 04:47:17'),
(851, 175, 'E - 160 Dt', 35, 'Wap Lab', 'WP - 4012S', 'LS16BAD0000038', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-23 05:51:24', '2019-11-05 02:31:36'),
(852, 176, 'E - 161 Dt', 10, 'SOCOREX', 'ACURA 815', '27091190', 1, 1, '-', '1000 ul', NULL, 'Laik Pakai', 1, '2019-10-24 00:33:48', '2019-10-24 05:04:15'),
(853, 176, 'E - 161 Dt', 12, 'SOCOREX', 'ACURA 825', '16042196', 1, 1, '-', '20 - 200 ul', NULL, 'Laik Pakai', 1, '2019-10-24 00:34:59', '2019-10-24 05:04:15'),
(854, 176, 'E - 161 Dt', 12, 'dumo', '-', 'MK941628', 1, 1, '-', '50 - 200 ul', NULL, 'Laik Pakai', 1, '2019-10-24 00:35:48', '2019-10-24 05:04:15'),
(855, 177, 'E - 162 Dt', 12, 'Accumax', 'Smart', 'LE247676', 1, 1, '-', '10 - 100 ul', NULL, 'Laik Pakai', 1, '2019-10-24 01:44:30', '2019-12-05 05:55:11'),
(856, 177, 'E - 162 Dt', 10, 'Accumax', 'Smart', 'II220443', 1, 1, '-', '1000 ul', NULL, 'Laik Pakai', 1, '2019-10-24 01:45:23', '2019-12-05 05:55:11'),
(857, 177, 'E - 162 Dt', 10, 'Accumax', 'Smart', 'JB225902', 1, 1, '-', '10 ul', NULL, 'Laik Pakai', 1, '2019-10-24 01:46:03', '2019-12-05 05:55:11'),
(858, 177, 'E - 162 Dt', 10, 'Accumax', 'Smart', 'LC246294', 1, 1, '-', '500 ul', NULL, 'Laik Pakai', 1, '2019-10-24 01:56:51', '2019-12-05 05:55:11'),
(859, 177, 'E - 162 Dt', 10, 'HUAWEI', 'G100', '-', 1, 1, '-', '100 ul', NULL, 'Laik Pakai', 1, '2019-10-24 01:57:33', '2019-12-05 05:55:11'),
(860, 177, 'E - 162 Dt', 10, 'HUAWEI', 'G50', '-', 1, 1, '-', '50 ul', NULL, 'Laik Pakai', 1, '2019-10-24 01:58:16', '2019-12-05 05:55:11'),
(861, 177, 'E - 162 Dt', 10, 'HUAWEI', 'G10', '-', 1, 1, '-', '10 ul', NULL, 'Tidak Laik Pakai', 1, '2019-10-24 01:58:47', '2019-12-05 05:55:11'),
(862, 178, 'E - 163 Dt', 10, 'HUAWEI', 'G10', '-', 1, 1, '-', '10 ul', NULL, 'Laik Pakai', 1, '2019-10-24 02:07:16', '2019-12-05 05:55:31'),
(863, 178, 'E - 163 Dt', 10, 'Accumax', '-', '116235', 1, 1, '-', '1000 ul', NULL, 'Laik Pakai', 1, '2019-10-24 02:07:55', '2019-12-05 05:55:31'),
(864, 178, 'E - 163 Dt', 12, 'ONEMED', 'DRAGON', 'DR30625', 1, 1, '-', '5 - 50 ul', NULL, 'Laik Pakai', 1, '2019-10-24 02:08:38', '2019-12-05 05:55:31'),
(865, 171, 'E -157 Dt', 30, 'MAICO', 'MA 51', '0116023', 1, 1, 'aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-10-24 23:54:11', '2019-10-24 23:59:32'),
(866, 179, 'E - 164 Dt', 42, 'BTL', 'BTL - 08 SD ecg', '071D0B007892', 1, 1, 'aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-10-25 02:19:01', '2019-11-08 01:50:16'),
(869, 182, 'E - 165 Dt', 30, 'Resonance', 'R27A', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-10-29 05:56:32', '2019-10-30 05:23:58'),
(870, 183, 'E - 166 Dt', 41, 'Bestman', 'BF - 600', 'BSM-BF-60065388', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-01 03:09:28', '2019-11-18 02:40:57'),
(871, 183, 'E - 166 Dt', 42, 'Bionet', 'CardioCare', 'EI0600045', 1, 1, 'aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2019-11-01 03:15:56', '2019-11-18 02:40:57'),
(872, 183, 'E - 166 Dt', 26, 'SurgimeD', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-01 03:18:21', '2019-11-18 02:40:57'),
(873, 183, 'E - 166 Dt', 61, 'memmert', '-', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-11-01 03:20:36', '2019-11-18 02:40:57'),
(874, 183, 'E - 166 Dt', 32, 'Elitech', 'PM9000+', '-', 1, 1, '-', 'knob rusak, sensor SpO2 tidak cocok', NULL, 'Laik Pakai', 1, '2019-11-01 03:44:17', '2019-11-18 02:40:57'),
(875, 184, 'E - 167 Dt', 57, 'Erkameter', '3rb', '14509744', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 02:45:02', '2019-12-19 01:34:16'),
(876, 184, 'E - 167 Dt', 57, 'ABN', 'DM500', '161005787', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 02:45:59', '2019-12-19 01:34:16'),
(877, 184, 'E - 167 Dt', 57, 'ABN', 'DM500', '161005030', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 02:48:24', '2019-12-19 01:34:16'),
(878, 184, 'E - 167 Dt', 57, 'ABN', 'DM500', '161005027', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 02:51:55', '2019-12-19 01:34:16'),
(879, 184, 'E - 167 Dt', 57, 'ABN', 'DM500', '161004905', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 02:52:47', '2019-12-19 01:34:16'),
(880, 184, 'E - 167 Dt', 57, 'ABN', 'DM500', '161005032', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 02:56:05', '2019-12-19 01:34:16'),
(881, 184, 'E - 167 Dt', 41, 'bistos', 'BT-200', 'BBG51717', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 02:58:31', '2019-12-19 01:34:16'),
(882, 184, 'E - 167 Dt', 57, 'ABN', 'Spectrum', '00057842', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 02:59:42', '2019-12-19 01:34:16'),
(883, 184, 'E - 167 Dt', 57, 'ABN', 'Spectrum', '832217', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 03:00:45', '2019-12-19 01:34:16'),
(885, 184, 'E - 167 Dt', 42, '3ray', '-', 'ECG-3303b1309013', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 03:03:35', '2019-12-19 01:34:16'),
(886, 184, 'E - 167 Dt', 61, 'elektro.mag', 'm3205p', '60601-2-21', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 03:08:39', '2019-12-19 01:34:16'),
(887, 184, 'E - 167 Dt', 21, 'Omron', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 03:08:59', '2019-12-19 01:34:16'),
(888, 184, 'E - 167 Dt', 9, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 03:09:12', '2019-12-19 01:34:16'),
(889, 184, 'E - 167 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 03:09:21', '2019-12-19 01:34:16'),
(890, 184, 'E - 167 Dt', 57, 'ABN', 'DM500', '161005028', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-04 03:12:59', '2019-12-19 01:34:16'),
(891, 185, 'E - 170 Dt', 30, 'oscilla', '-', '950 50/0709/con', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-05 00:56:13', '2019-11-11 00:10:30'),
(892, 186, 'E - 168 Dt', 12, 'eppendorf', 'Research', '4579886', 1, 1, '-', '100 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:01:01', '2019-11-14 01:24:20'),
(893, 186, 'E - 168 Dt', 12, 'Socorex', 'ACURA 825', '19101136', 1, 1, '-', '10 - 100', NULL, 'Laik Pakai', 1, '2019-11-05 02:02:37', '2019-11-14 01:24:20'),
(894, 186, 'E - 168 Dt', 12, 'Socorex', 'ACURA 825', '19121240', 1, 1, '-', '5 - 50', NULL, 'Laik Pakai', 1, '2019-11-05 02:02:42', '2019-11-14 01:24:20'),
(895, 186, 'E - 168 Dt', 12, 'Socorex', 'ACURA 825', '19121771', 1, 1, '-', '100 - 1000', NULL, 'Laik Pakai', 1, '2019-11-05 02:03:01', '2019-11-14 01:24:20'),
(896, 186, 'E - 168 Dt', 12, 'Socorex', 'ACURA 825', '20011856', 1, 1, 'Tutup Hilang', '20 - 200', NULL, 'Laik Pakai', 1, '2019-11-05 02:03:24', '2019-11-14 01:24:20'),
(897, 186, 'E - 168 Dt', 10, 'Socorex', 'ACURA 815', '19101322', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:04:13', '2019-11-14 01:24:20'),
(898, 186, 'E - 168 Dt', 10, 'Hamilton', '-', '094819', 1, 1, '-', '25 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:04:45', '2019-11-14 01:24:20'),
(899, 186, 'E - 168 Dt', 10, 'BioHIT', 'Proline', '8021057', 1, 1, '-', '50 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:06:02', '2019-11-14 01:24:20'),
(900, 186, 'E - 168 Dt', 10, 'BioHIT', 'Proline', '8029201', 1, 1, '-', '200 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:06:18', '2019-11-14 01:24:20'),
(901, 186, 'E - 168 Dt', 12, 'BioRAD', '-', '847751925', 1, 1, '-', '10 - 100', NULL, 'Laik Pakai', 1, '2019-11-05 02:07:05', '2019-11-14 01:24:20'),
(902, 188, 'E - 169 Dt', 10, 'dumo', '-', 'MB898614', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:13:07', '2019-11-14 01:27:12'),
(903, 188, 'E - 169 Dt', 12, 'NESCO', 'DRAGONLAB', 'YE6F708982', 1, 1, '-', '100 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:13:50', '2019-11-14 01:27:12'),
(904, 188, 'E - 169 Dt', 12, 'SOCOREX', 'ACURA 825', '23012006', 1, 1, '-', '20 - 200', NULL, 'Laik Pakai', 1, '2019-11-05 02:14:22', '2019-11-14 01:27:12'),
(905, 188, 'E - 169 Dt', 12, 'SOCOREX', 'ACURA 825', '23041105', 1, 1, '-', '10 - 100', NULL, 'Laik Pakai', 1, '2019-11-05 02:14:25', '2019-11-14 01:27:12'),
(906, 188, 'E - 169 Dt', 10, 'SOCOREX', 'ACURA 815', '22111327', 1, 1, '-', '100', NULL, 'Laik Pakai', 1, '2019-11-05 02:15:12', '2019-11-14 01:27:12'),
(907, 188, 'E - 169 Dt', 10, 'SOCOREX', 'ACURA 815', '23021106', 1, 1, '-', '50', NULL, 'Laik Pakai', 1, '2019-11-05 02:15:15', '2019-11-14 01:27:12'),
(908, 188, 'E - 169 Dt', 10, 'SOCOREX', 'ACURA 815', '22111423', 1, 1, '-', '10', NULL, 'Laik Pakai', 1, '2019-11-05 02:15:35', '2019-11-14 01:27:12'),
(909, 187, 'E - 171 Dt', 35, 'Nesco', '80 - 2', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-05 02:16:34', '2019-11-15 07:27:29'),
(910, 187, 'E - 171 Dt', 51, 'Wina', '-', '1011013116', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-05 02:17:00', '2019-11-15 07:27:29'),
(911, 187, 'E - 171 Dt', 86, 'Philips', 'Avalon FM20', 'DE45734908', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-05 02:17:57', '2019-11-15 07:27:29'),
(912, 187, 'E - 171 Dt', 10, 'Onemed', 'DRAGON', '73592', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:18:28', '2019-11-15 07:27:29'),
(913, 187, 'E - 171 Dt', 12, 'Hummapette', 'human', 'YL3K028887', 1, 1, '-', '5 - 50 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:19:11', '2019-11-15 07:27:29'),
(914, 187, 'E - 171 Dt', 10, 'HT', 'Clinipet', '22540010', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2019-11-05 02:20:17', '2019-11-15 07:27:29'),
(915, 189, 'E - 172 Dt', 41, 'Elitech', '-', 'FB1504200381', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-05 04:06:40', '2019-11-11 03:21:45'),
(916, 189, 'E - 172 Dt', 57, 'ABN', '-', '00087397', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-05 04:12:56', '2019-11-11 03:21:45'),
(917, 189, 'E - 172 Dt', 57, 'rk', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-05 04:12:59', '2019-11-11 03:21:45'),
(918, 190, 'E - 173 Dt', 42, 'BTL', 'BTL-08 SD ecg', '071D0B007626', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-07 02:36:49', '2019-11-27 01:54:10'),
(919, 191, 'E - 174 Dt', 57, 'ABN', 'SPECTRUM', '00063447', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-08 01:44:35', '2019-11-13 01:41:29'),
(920, 192, 'E - 175 Dt', 9, 'OneMed', 'OD 230', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-11 05:30:14', '2019-12-06 07:16:51'),
(921, 192, 'E - 175 Dt', 42, 'Fukuda Denshi', 'Cardimax', 'FX - 7102', 1, 1, '-', 'kertas habis', NULL, 'Laik Pakai', 1, '2019-11-11 05:37:11', '2019-12-06 07:16:51'),
(922, 193, 'E - 176 Dt', 41, 'bistos', 'Hi- Bebe', 'BFEB3440', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:18:23', '2019-12-23 04:33:53'),
(923, 193, 'E - 176 Dt', 55, 'bion', '-', '-', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:19:23', '2019-12-23 04:33:53'),
(924, 193, 'E - 176 Dt', 9, 'SELLA', '-', '-', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:20:00', '2019-12-23 04:33:53'),
(925, 193, 'E - 176 Dt', 57, 'ABN', 'SPECTRUM', '121293', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:20:45', '2019-12-23 04:33:53'),
(927, 193, 'E - 176 Dt', 57, 'ABN', 'SPECTRUM', '139386', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:21:29', '2019-12-23 04:33:53'),
(928, 193, 'E - 176 Dt', 57, 'ABN', 'SPECTRUM', '908256', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:22:15', '2019-12-23 04:33:53'),
(929, 193, 'E - 176 Dt', 34, 'OMRON', 'HBP-1100', '01008263LF', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:23:13', '2019-12-23 04:33:53'),
(930, 193, 'E - 176 Dt', 41, 'bistos', 'Hi- Bebe', 'BFEB1138', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:24:06', '2019-12-23 04:33:53'),
(931, 193, 'E - 176 Dt', 1, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:29:17', '2019-12-23 04:33:53'),
(932, 193, 'E - 176 Dt', 1, 'NESCO', '-', '-', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:29:22', '2019-12-23 04:33:53'),
(933, 193, 'E - 176 Dt', 34, 'LAICA', 'BM2001', '1201770464103', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:31:42', '2019-12-23 04:33:53'),
(934, 193, 'E - 176 Dt', 21, 'OMRON', 'COMP AIR', '20171101500UF', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-12 07:38:02', '2019-12-23 04:33:53'),
(935, 194, 'E - 177 Dt', 21, 'Philips', 'Respronics', '441128', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-13 01:45:17', '2019-12-02 03:17:24'),
(937, 195, 'E - 178 Dt', 35, 'Health', 'H-C-12', '3160325035', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-13 01:52:37', '2019-12-02 03:39:01'),
(938, 196, 'E - 179 Dt', 30, 'Interacoustics', 'ad226', '-', 1, 1, '-', '-', NULL, NULL, 1, '2019-11-13 01:57:09', '2019-12-02 03:39:52'),
(939, 197, 'E - 180 Dt', 1, 'PUREMED', '-', '-', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-15 02:04:01', '2019-12-23 04:34:12'),
(940, 197, 'E - 180 Dt', 55, 'BiON', '-', '-', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2019-11-15 02:04:25', '2019-12-23 04:34:12'),
(941, 197, 'E - 180 Dt', 10, 'volac', 'ultra', '-', 1, 1, '-', '-', NULL, 'Tidak Laik pakai', 1, '2019-11-15 02:04:45', '2019-12-23 04:34:12'),
(942, 197, 'E - 180 Dt', 12, 'NESCO', 'DRAGONLAB', 'YE176AF0017734', 1, 1, '-', '10 - 100 uL', NULL, 'Laik pakai', 1, '2019-11-15 02:05:31', '2019-12-23 04:34:12'),
(943, 197, 'E - 180 Dt', 57, 'ABN', 'SPECTRUM', '0045082', 1, 1, '-', 'Bulb Rusak', NULL, 'Laik pakai', 1, '2019-11-15 02:06:11', '2019-12-23 04:34:12'),
(944, 198, 'E - 181 Dt', 57, 'Riester', '-', '16061592', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-18 01:02:01', '2019-12-12 00:42:17'),
(945, 198, 'E - 181 Dt', 34, 'Omron', 'HEM-7320', '20180300028VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-18 01:03:54', '2019-12-12 00:42:17'),
(946, 198, 'E - 181 Dt', 55, 'Elitech', 'FOX-1', 'FX115BD1307', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-18 01:04:25', '2019-12-12 00:42:17'),
(947, 198, 'E - 181 Dt', 2, 'GEA', '-', '20901300028', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-18 01:05:16', '2019-12-12 00:42:17'),
(948, 198, 'E - 181 Dt', 42, 'Bionet', 'CardioCare 2000', 'ES1100102', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-18 01:05:46', '2019-12-12 00:42:17'),
(949, 198, 'E - 181 Dt', 21, 'Omron', 'NE-C28', '20130811858UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-18 01:07:36', '2019-12-12 00:42:17'),
(950, 199, 'E - 182 Dt', 2, 'ThermoONE', '-', '-', 1, 1, 'Dengan Tempat', '-', NULL, 'Laik Pakai', 1, '2019-11-18 06:27:23', '2019-12-16 01:36:06'),
(951, 199, 'E - 182 Dt', 2, 'ABN', '-', '-', 1, 1, 'Dengan Kotak', '-', NULL, 'Laik Pakai', 1, '2019-11-18 06:28:22', '2019-12-16 01:36:06'),
(952, 199, 'E - 182 Dt', 2, 'SAFETY', '-', '-', 1, 1, 'Dengan Kotak', '-', NULL, 'Laik Pakai', 1, '2019-11-18 06:29:33', '2019-12-16 01:36:06'),
(953, 200, 'E - 183 Dt', 35, 'Hettich', 'Mikro 120', '0006634-07', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2019-11-25 02:20:54', '2019-12-12 03:17:40'),
(954, 200, 'E - 183 Dt', 10, 'DRAGONLAB', '-', 'YL3K018264', 1, 1, '-', '50', NULL, 'Laik Pakai', 1, '2019-11-25 02:22:58', '2019-12-12 03:17:40'),
(955, 201, 'E - 184 Dt', 42, 'BTL', '-', '071D08007792', 1, 1, 'Kertas, kabel Power dan Kabel lead', '-', NULL, 'Laik Pakai', 1, '2019-11-27 02:23:11', '2019-12-02 03:42:28'),
(956, 202, 'E - 185 Dt', 10, 'microlit', '-', '16316782', 1, 1, '-', '1 uL', NULL, 'Laik Pakai', 1, '2019-11-29 01:10:27', '2019-12-19 02:16:51'),
(957, 202, 'E - 185 Dt', 10, 'ONEMED', 'cupp', '39580', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2019-11-29 01:10:30', '2019-12-19 02:16:51'),
(958, 202, 'E - 185 Dt', 10, 'microlit', '-', '16311257', 1, 1, '-', '100 uL', NULL, 'Tidak Laik Pakai', 1, '2019-11-29 01:13:02', '2019-12-19 02:16:51'),
(959, 202, 'E - 185 Dt', 2, 'avico', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:13:21', '2019-12-19 02:16:51'),
(960, 202, 'E - 185 Dt', 41, 'Lotus', 'lt-800+', '-', 1, 1, 'Buku manual, gel, adaptor, tas', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:13:53', '2019-12-19 02:16:51'),
(961, 202, 'E - 185 Dt', 41, 'Lotus', 'lt-800+', '-', 1, 1, 'Buku manual, gel, adaptor, tas', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:13:58', '2019-12-19 02:16:51'),
(962, 202, 'E - 185 Dt', 57, 'abn', '-', '00258157', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:18:49', '2019-12-19 02:16:51'),
(963, 202, 'E - 185 Dt', 57, 'abn', '-', '00257817', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:18:59', '2019-11-29 06:16:48'),
(964, 202, 'E - 185 Dt', 57, 'abn', '-', '00258455', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:20:45', '2019-12-19 02:16:51'),
(965, 202, 'E - 185 Dt', 57, 'abn', '-', '00258259', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:21:28', '2019-11-29 06:16:48'),
(966, 202, 'E - 185 Dt', 57, 'abn', '-', '00258667', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:23:19', '2019-12-19 02:16:51'),
(967, 202, 'E - 185 Dt', 57, 'abn', '-', '00258250', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:24:05', '2019-11-29 06:16:48'),
(968, 202, 'E - 185 Dt', 9, 'gea', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:25:26', '2019-12-19 02:16:51'),
(969, 202, 'E - 185 Dt', 9, 'sella', 'rgz-20', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-11-29 01:25:33', '2019-12-19 02:16:51'),
(970, 203, 'E - 186 Dt', 19, 'KAWE', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-02 05:39:34', '2020-01-20 00:37:59'),
(971, 203, 'E - 186 Dt', 1, 'BIOMEDIX', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-02 05:41:26', '2020-01-20 00:37:59'),
(972, 203, 'E - 186 Dt', 57, 'Riester', 'nova ecoline', '151061815', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-02 05:42:51', '2020-01-20 00:37:59'),
(973, 203, 'E - 186 Dt', 9, 'SELLA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-02 05:43:39', '2020-01-20 00:37:59'),
(974, 203, 'E - 186 Dt', 57, 'Riester', 'nova ecoline', '151061823', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-02 05:49:03', '2020-01-20 00:37:59'),
(975, 203, 'E - 186 Dt', 57, 'abn', 'spectrum', '259215', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-02 05:50:08', '2020-01-20 00:37:59'),
(976, 203, 'E - 186 Dt', 19, 'DYNA', 'SYNA 100 R', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-02 05:51:10', '2020-01-20 00:37:59'),
(977, 204, 'E - 187 Dt', 10, 'DiaLineEco', '-', 'IL476633', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:36:49', '2020-01-06 07:31:23'),
(978, 204, 'E - 187 Dt', 10, 'DiaLineEco', '-', 'IL476991', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:36:59', '2020-01-06 07:31:23'),
(979, 204, 'E - 187 Dt', 10, 'DiaLineEco', '-', 'IL476762', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:37:43', '2020-01-06 07:31:23'),
(980, 204, 'E - 187 Dt', 10, 'DiaLineEco', '-', 'IL476688', 1, 1, '-', '50 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:38:27', '2020-01-06 07:31:23'),
(981, 204, 'E - 187 Dt', 10, 'DiaLineEco', '-', 'IL476991', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:39:52', '2020-01-06 07:31:23'),
(982, 204, 'E - 187 Dt', 12, 'OneMed', '-', 'CU0036866', 1, 1, '-', '100 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:42:02', '2020-01-06 07:31:23'),
(983, 205, 'E - 188 Dt', 12, 'DRAGON ONEMED', '-', 'YL5A129665', 1, 1, '-', '5 - 50 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:46:30', '2020-01-06 07:32:20'),
(984, 205, 'E - 188 Dt', 12, 'DRAGON ONEMED', '-', 'YL5F129740', 1, 1, '-', '100 - 1000 uL', NULL, 'Tidak Laik Pakai', 1, '2019-12-05 06:46:34', '2020-01-06 07:32:20'),
(985, 206, 'E - 189 Dt', 10, 'DiaLineEco', '-', 'IL476634', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:55:48', '2020-01-06 07:32:42'),
(986, 206, 'E - 189 Dt', 12, 'OneMed', '-', 'CU0039643', 1, 1, '-', '5 - 50 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:55:56', '2020-01-06 07:32:42'),
(987, 206, 'E - 189 Dt', 10, 'DiaLineEco', '-', 'IL476731', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:56:20', '2020-01-06 07:32:42'),
(988, 206, 'E - 189 Dt', 10, 'DiaLineEco', '-', 'IL476651', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:56:32', '2020-01-06 07:32:42'),
(989, 206, 'E - 189 Dt', 12, 'OneMed', '-', 'CU0036840', 1, 1, '-', '10 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-12-05 06:58:22', '2020-01-06 07:32:42'),
(990, 207, 'E - 190 Dt', 12, 'dragon onemed', '-', 'YL5A129674', 1, 1, '-', '5 - 50 uL', NULL, 'Laik Pakai', 1, '2019-12-05 07:02:57', '2020-01-06 07:35:46'),
(991, 207, 'E - 190 Dt', 12, 'dragon onemed', '-', 'YL5F129733', 1, 1, '-', '100 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-12-05 07:03:33', '2020-01-06 07:35:46'),
(992, 208, 'E - 191 Dt', 57, 'ABN', 'Spectrum', '103074', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-06 01:39:11', '2019-12-20 02:54:24'),
(993, 208, 'E - 191 Dt', 57, 'ABN', 'Spectrum', '856994', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-12-06 01:45:29', '2019-12-20 02:54:24'),
(994, 208, 'E - 191 Dt', 57, 'ABN', 'Spectrum', '102611', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-06 01:45:42', '2019-12-20 02:54:24'),
(995, 208, 'E - 191 Dt', 57, 'ABN', 'Spectrum', '00058550', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-06 01:45:52', '2019-12-20 02:54:24'),
(996, 208, 'E - 191 Dt', 57, 'Onemed', '-', '1325949', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-06 01:46:02', '2019-12-20 02:54:24'),
(997, 208, 'E - 191 Dt', 57, 'ABN', 'Spectrum', '893323', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-06 01:47:36', '2019-12-20 02:54:24'),
(998, 208, 'E - 191 Dt', 51, 'orbital shaker', 'vrn-210', '1510855', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-06 01:50:29', '2019-12-20 02:54:24'),
(999, 208, 'E - 191 Dt', 35, 'k', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-06 01:52:32', '2019-12-20 02:54:24'),
(1000, 208, 'E - 191 Dt', 21, 'omron', 'ne-c28', '20180403159UF', 1, 1, '-', 'tdk ada aksesoris tambahan', NULL, 'Laik Pakai', 1, '2019-12-06 01:56:27', '2019-12-20 02:54:24'),
(1001, 208, 'E - 191 Dt', 25, 'gea', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-06 01:58:56', '2019-12-20 02:56:37'),
(1002, 209, 'E - 192 Dt', 12, 'Dragonlab', '-', 'YE195AL0407455', 3, 1, '-', '100 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-12-06 06:48:48', '2019-12-13 00:52:53'),
(1003, 209, 'E - 192 Dt', 34, 'Omron', 'HEM-7320', '20150800154VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-06 06:49:26', '2019-12-13 00:52:53'),
(1004, 210, 'E - 193 Dt', 35, 'WINA', '507', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-09 00:30:05', '2019-12-26 01:49:41'),
(1005, 210, 'E - 193 Dt', 2, 'AVICO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-09 00:31:19', '2019-12-26 01:49:41'),
(1006, 210, 'E - 193 Dt', 57, 'ABN', 'Spectrum', '901753', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-12-09 00:50:37', '2019-12-26 01:49:41'),
(1008, 210, 'E - 193 Dt', 57, 'ABN', 'Spectrum', '967444', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-09 00:50:55', '2019-12-26 01:49:41'),
(1009, 210, 'E - 193 Dt', 41, 'edan', 'sonotrax', '304069M12802490010', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-09 00:56:14', '2019-12-26 01:49:41'),
(1010, 210, 'E - 193 Dt', 42, 'BTL', '-', '017-D-B-02640', 1, 1, 'Kabel Ecg, Power, Lead Bulb', '-', NULL, 'Laik Pakai', 1, '2019-12-09 00:57:13', '2019-12-26 01:49:41'),
(1011, 210, 'E - 193 Dt', 59, 'BTL', '-', '0735 B 00561', 1, 1, 'Pipa panjang (3), Pipa pendek (2)', '-', NULL, 'Laik Pakai', 1, '2019-12-09 00:58:46', '2019-12-26 01:49:41'),
(1012, 210, 'E - 193 Dt', 30, 'triveni', 't-250', '15012504', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-09 02:15:47', '2019-12-26 01:49:41'),
(1013, 211, 'E - 194 Dt', 10, 'biohit', 'proline', '11109546', 1, 1, '-', '1000 ul', NULL, 'Laik Pakai', 1, '2019-12-09 06:42:50', '2020-01-06 08:03:59'),
(1014, 211, 'E - 194 Dt', 10, 'dragon onemed', '-', 'dr73341', 1, 1, '-', '10 ul', NULL, 'Laik Pakai', 1, '2019-12-09 06:43:00', '2020-01-06 08:03:59'),
(1015, 211, 'E - 194 Dt', 10, 'biohit', 'proline', '12581017', 1, 1, '-', '50 ul', NULL, 'Laik Pakai', 1, '2019-12-09 06:43:47', '2020-01-06 08:03:59'),
(1016, 212, 'E - 195 Dt', 12, 'dragon onemed', '-', 'YL5F129757', 1, 1, '-', '100 - 1000 uL', NULL, 'Laik Pakai', 1, '2019-12-11 02:40:35', '2020-01-06 08:05:45'),
(1017, 213, 'E - 196 Dt', 59, 'chestgraph', 'hi-101', '1135829', 1, 1, 'mouth piece, filter, syringe calibrator, power', '-', NULL, 'Laik Pakai', 1, '2019-12-13 02:36:08', '2019-12-27 02:13:10'),
(1018, 214, 'E - 197 Dt', 57, 'General Care', '-', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2019-12-19 07:53:50', '2019-12-20 07:17:27'),
(1019, 214, 'E - 197 Dt', 57, 'ABN', 'SPECTRUM', '00069633', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-19 07:54:11', '2019-12-20 06:33:39'),
(1020, 214, 'E - 197 Dt', 41, 'BF-500', '-', '50054909', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-19 07:55:45', '2019-12-20 06:33:39'),
(1021, 214, 'E - 197 Dt', 57, 'GEA', '-', '557399', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-19 07:55:51', '2019-12-20 06:33:39'),
(1022, 214, 'E - 197 Dt', 41, 'bistos', 'HI.bebe', 'BBG20112', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-19 07:56:46', '2019-12-20 06:33:39'),
(1023, 214, 'E - 197 Dt', 41, 'Lotus', '-', '-', 1, 1, '-', 'Belum dicek karena baterai habis (tunggu charger)', NULL, 'Laik Pakai', 1, '2019-12-19 07:58:43', '2019-12-20 06:33:39'),
(1024, 214, 'E - 197 Dt', 41, 'Lotus', '-', '-', 1, 1, '-', 'Belum dicek karena baterai habis (tunggu charger)', NULL, 'Laik Pakai', 1, '2019-12-19 07:58:49', '2019-12-20 06:33:39'),
(1025, 214, 'E - 197 Dt', 21, 'Omron', 'compAIR', '20180404492UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-19 08:00:49', '2019-12-20 06:33:39'),
(1026, 215, 'E - 198 Dt', 2, 'Omron', '-', '002.2017', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 02:53:12', '2019-12-27 06:08:23'),
(1027, 215, 'E - 198 Dt', 2, 'Omron', '-', '014.2017', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 02:53:16', '2019-12-27 06:08:23'),
(1028, 215, 'E - 198 Dt', 2, 'Omron', '-', '006.2017', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 02:53:26', '2019-12-27 06:08:23'),
(1029, 215, 'E - 198 Dt', 2, 'Omron', '-', '008.2017', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 02:53:35', '2019-12-27 06:08:23'),
(1030, 215, 'E - 198 Dt', 2, 'Omron', '-', '009.2017', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 02:53:45', '2019-12-27 06:08:23'),
(1031, 215, 'E - 198 Dt', 35, 'K', 'PLC-03', '1614306', 1, 1, 'Adaptor, Colokan', '-', NULL, 'Laik Pakai', 1, '2019-12-23 02:59:03', '2019-12-27 06:08:23'),
(1032, 215, 'E - 198 Dt', 2, 'Omron', '-', '005.2017', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 02:59:14', '2019-12-27 06:08:23'),
(1033, 215, 'E - 198 Dt', 34, 'Omron', 'HEM-7320', '20171200867VG', 1, 1, 'Baterai (8)', '-', NULL, 'Laik Pakai', 1, '2019-12-23 03:02:26', '2019-12-27 06:08:23'),
(1034, 215, 'E - 198 Dt', 34, 'Omron', 'HEM-7320', '20171200863VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 03:02:44', '2019-12-27 06:08:23'),
(1035, 215, 'E - 198 Dt', 34, 'Omron', 'HEM-7200-AP3', '20170300898XG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 03:05:53', '2019-12-27 06:08:23'),
(1036, 215, 'E - 198 Dt', 34, 'Omron', 'HEM-7200-AP3', '20170301300XG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 03:06:00', '2019-12-27 06:08:23'),
(1037, 215, 'E - 198 Dt', 34, 'Omron', 'HEM-7200-AP3', '20170300867XG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 03:06:16', '2019-12-27 06:08:23'),
(1038, 215, 'E - 198 Dt', 34, 'Omron', 'HEM-7200-AP3', '20170300847XG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 03:06:36', '2019-12-27 06:08:23'),
(1039, 215, 'E - 198 Dt', 41, 'Bistos', 'BT-200', '-', 1, 1, 'Baterai (12)', '-', NULL, 'Laik Pakai', 1, '2019-12-23 03:08:39', '2019-12-27 06:08:23'),
(1040, 215, 'E - 198 Dt', 41, 'BF-600+', '-', '60067094', 1, 1, '-', 'Konektor probe patah', NULL, 'Laik Pakai', 1, '2019-12-23 03:08:46', '2019-12-27 06:08:23'),
(1041, 215, 'E - 198 Dt', 41, 'Bistos', 'BT-250', 'BHJ40171', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 03:09:04', '2019-12-27 06:08:23'),
(1042, 215, 'E - 198 Dt', 12, 'Dragon Onemed', '-', 'YL173AB0008236', 1, 1, '-', '10 - 100 uL', NULL, 'Laik Pakai', 1, '2019-12-23 03:10:59', '2019-12-27 06:08:23'),
(1043, 215, 'E - 198 Dt', 10, 'SOCOREX', 'ACURA 815', '18091134', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2019-12-23 03:12:09', '2019-12-27 06:08:23'),
(1044, 216, 'E - 001 Dt', 2, 'AVICO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 0, '2019-12-31 02:07:12', '2020-01-06 02:37:23'),
(1046, 219, 'E - 002 Dt', 42, 'esaote', 'P80', '14296', 1, 1, 'Kabel Power , Lead ECG', '-', NULL, 'Laik Pakai', 1, '2020-01-06 02:16:45', '2020-01-20 00:31:47'),
(1047, 220, 'E - 003 Dt', 55, 'Elitech', 'FOX-1(N)', 'FX5191A0628', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-01-20 04:55:35', '2020-01-21 04:17:57'),
(1048, 220, 'E - 003 Dt', 55, 'Elitech', 'FOX-1(N)', 'FX5191A5787', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-01-20 04:55:58', '2020-01-21 04:17:57'),
(1049, 220, 'E - 003 Dt', 55, 'Elitech', 'FOX-1(N)', 'FX5191A0330', 1, 1, 'Kotak', '-', NULL, 'Laik pakai', 1, '2020-01-20 04:57:00', '2020-01-21 04:17:57'),
(1050, 220, 'E - 003 Dt', 55, 'Elitech', 'FOX-1(N)', 'FX5191A0391', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-01-20 04:58:07', '2020-01-21 04:17:57'),
(1051, 220, 'E - 003 Dt', 57, 'ABN', 'SPECTRUM', '122345', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-01-20 05:00:15', '2020-01-21 04:17:57'),
(1052, 220, 'E - 003 Dt', 57, 'Riester', 'nova ecoline', '180560794', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-01-20 05:03:02', '2020-01-21 04:17:57'),
(1053, 220, 'E - 003 Dt', 57, 'Riester', 'nova ecoline', '180560778', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-01-20 05:03:42', '2020-01-21 04:17:57'),
(1054, 220, 'E - 003 Dt', 57, 'ABN', 'SPECTRUM', '122813', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-01-20 05:04:00', '2020-01-21 04:17:57'),
(1055, 220, 'E - 003 Dt', 57, 'ABN', 'SPECTRUM', '139511', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-01-20 05:05:07', '2020-01-21 04:17:57'),
(1057, 221, 'E - 004 Dt', 57, 'ABN', 'SPECTRUM', '00230298', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-01-21 04:27:06', '2020-01-21 05:42:44'),
(1058, 222, 'E - 005 Dt', 21, 'Omron', 'Ne-C28', '20140404531UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-01-22 02:28:20', '2020-03-17 01:12:36'),
(1059, 222, 'E - 005 Dt', 30, 'Triven', 'TAM-25', '10101543', 1, 1, 'Headphone', 'Kabel Headphone terkelupas', NULL, 'Tidak Laik Pakai', 1, '2020-01-22 02:29:27', '2020-01-24 05:54:00'),
(1060, 222, 'E - 005 Dt', 42, 'Bionet', 'CardioCare', 'EQ1201002', 1, 1, 'Kabel ECG, Power, jepit (lengkap)', '-', NULL, 'Laik Pakai', 1, '2020-01-22 02:29:57', '2020-03-17 01:13:18'),
(1061, 222, 'E - 005 Dt', 2, 'ThermoONe', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-01-22 02:30:19', '2020-01-24 05:54:00'),
(1064, 222, 'E - 005 Dt', 2, 'Omron', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-01-22 02:30:33', '2020-01-24 05:54:00'),
(1065, 222, 'E - 005 Dt', 57, 'Microlife', '-', '-', 1, 1, '-', 'Manset Bocor', NULL, 'Laik Pakai', 1, '2020-01-22 02:31:04', '2020-01-24 05:54:00'),
(1067, 222, 'E - 005 Dt', 57, 'ABN', 'SPECTRUM', '851405', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-01-22 02:31:11', '2020-01-24 05:54:00'),
(1069, 222, 'E - 005 Dt', 12, 'OneMed', 'DragonOnemed', '-', 1, 1, '-', 'Belum Dicek', NULL, 'Tidak Laik Pakai', 1, '2020-01-22 03:00:25', '2020-03-17 01:13:29'),
(1070, 222, 'E - 005 Dt', 12, 'Dragon LAB', '-', '-', 1, 1, '-', 'Belum Dicek', NULL, 'Tidak Laik Pakai', 1, '2020-01-22 03:00:27', '2020-01-28 06:56:03'),
(1071, 222, 'E - 005 Dt', 12, 'OneMed', 'DragonOnemed', '-', 1, 1, '-', 'Belum Dicek', NULL, 'Tidak Laik Pakai', 1, '2020-01-22 03:00:32', '2020-01-28 06:56:03'),
(1072, 223, 'E - 006 Dt', 10, 'Accumax', '-', 'HK443645', 1, 1, '-', '25ul', NULL, 'Laik Pakai', 1, '2020-01-28 07:39:30', '2020-02-06 04:58:29'),
(1073, 223, 'E - 006 Dt', 12, 'Nesco', 'DRAGONLAB', 'YE171AA0163659', 1, 1, '-', '5-50 ul', NULL, 'Tidak Laik Pakai', 1, '2020-01-28 07:40:43', '2020-02-06 04:58:29'),
(1074, 223, 'E - 006 Dt', 12, 'DRAGON ONEMED', '-', 'YL174BA0012336', 1, 1, '-', '5-50 ul', NULL, 'Tidak Laik Pakai', 1, '2020-01-28 07:41:41', '2020-02-06 04:58:29'),
(1075, 224, 'E - 007 Dt', 12, 'Transpette', 'S DE-M 18', '18E40210', 1, 1, '-', '1 - 10 ml , menunggu tip', NULL, 'Laik Pakai', 0, '2020-02-06 02:46:32', '2020-10-27 07:53:52'),
(1076, 224, 'E - 007 Dt', 12, 'Rainin', 'pipet-lite XLS', 'B716989752', 1, 1, '-', '2 - 20 ul', NULL, 'Laik Pakai', 1, '2020-02-06 02:50:29', '2020-09-10 01:27:58'),
(1077, 224, 'E - 007 Dt', 34, 'OMRON', 'HEM-7200', '20141101079VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-06 02:51:38', '2020-09-10 01:27:58'),
(1078, 226, 'E - 008 Dt', 57, 'Riester', 'nova-presameter', '150763384', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-11 06:12:16', '2020-02-25 05:36:55'),
(1079, 226, 'E - 008 Dt', 55, 'General Care', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-11 06:13:25', '2020-02-25 05:36:55'),
(1080, 226, 'E - 008 Dt', 30, 'resonance', 'R27A DD45 Diagnostic', 'R27A16G000406', 1, 1, 'aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2020-02-11 06:16:21', '2020-02-25 05:36:55'),
(1081, 226, 'E - 008 Dt', 30, 'SIBEL', 'SIBEL SOUND', '207-A285', 1, 1, 'aksesoris lengkap', 'jack headphone goyang', NULL, 'Laik Pakai', 1, '2020-02-11 06:31:11', '2020-02-25 05:36:55'),
(1082, 227, 'E - 009 Dt', 57, 'ABN', 'SPECTRUM', '888408', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-11 07:57:44', '2020-03-17 02:18:38'),
(1083, 227, 'E - 009 Dt', 55, 'Elitech', 'FOX-1 (N)', 'FX1175A2236', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-11 07:59:08', '2020-03-17 02:18:38'),
(1084, 228, 'E - 010 Dt', 34, 'OMRON', 'HEM-7130', '20180407232VG', 1, 1, 'baterai 4 pcs', '-', NULL, 'Laik Pakai', 1, '2020-02-12 05:00:12', '2020-03-09 03:12:05'),
(1085, 228, 'E - 010 Dt', 57, 'ABN', 'SPECTRUM', '819031', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-12 05:00:54', '2020-03-09 03:12:05'),
(1086, 229, 'E - 011 Dt', 34, 'OMRON', 'HEM-7320', '20171100679 VG', 1, 1, 'kabel charger, baterai', '-', NULL, 'Laik Pakai', 1, '2020-02-13 05:42:09', '2020-02-26 02:46:54'),
(1087, 229, 'E - 011 Dt', 34, 'OMRON', 'HEM-7320', '20171100680 VG', 1, 1, 'kabel charger, baterai', '-', NULL, 'Laik Pakai', 1, '2020-02-13 05:42:37', '2020-02-26 02:46:54'),
(1088, 229, 'E - 011 Dt', 34, 'OMRON', 'HEM-7320', '20160601512 VG', 1, 1, 'kabel charger, baterai', '-', NULL, 'Laik Pakai', 1, '2020-02-13 05:43:24', '2020-02-26 02:46:54'),
(1089, 229, 'E - 011 Dt', 34, 'OMRON', 'HEM-7320', '20171100675 VG', 1, 1, 'kabel charger, baterai', '-', NULL, 'Laik Pakai', 1, '2020-02-13 05:43:55', '2020-02-26 02:46:54');
INSERT INTO `lab_detail_order` (`id`, `id_order`, `no_order`, `alat_id`, `merek`, `model`, `seri`, `jumlah`, `fungsi`, `kelengkapan`, `keterangan`, `no_registrasi`, `catatan`, `ambil`, `created_at`, `updated_at`) VALUES
(1090, 229, 'E - 011 Dt', 34, 'OMRON', 'HEM-7320', '20171100672 VG', 1, 1, 'kabel charger, baterai', '-', NULL, 'Laik Pakai', 1, '2020-02-13 05:45:36', '2020-02-26 02:46:54'),
(1091, 229, 'E - 011 Dt', 34, 'OMRON', 'HEM-7322', '20180800083 VG', 1, 1, 'kabel charger, baterai', '-', NULL, 'Laik Pakai', 1, '2020-02-13 05:46:48', '2020-02-26 02:46:54'),
(1092, 229, 'E - 011 Dt', 42, 'Fukuda Denshi', 'CardiMax', '25060830', 1, 1, 'aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2020-02-13 05:59:39', '2020-02-26 02:46:54'),
(1093, 229, 'E - 011 Dt', 42, 'Fukuda Denshi', 'CardiMax', '25060831', 1, 1, 'aksesoris lengkap', '-', NULL, 'Laik Pakai', 1, '2020-02-13 06:04:28', '2020-02-26 02:46:54'),
(1094, 230, 'E - 012 Dt', 2, 'OMRON', 'MC-245', '20170318UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-24 07:24:48', '2020-03-11 01:00:20'),
(1095, 230, 'E - 012 Dt', 41, 'bistos', 'BT-200L', 'BBHB1224', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-24 07:25:35', '2020-03-11 01:00:20'),
(1096, 230, 'E - 012 Dt', 34, 'OMRON', 'HEM-7320', '20171100486VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-24 07:26:12', '2020-03-11 01:00:20'),
(1097, 230, 'E - 012 Dt', 21, 'OMRON', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-24 07:26:34', '2020-03-11 01:00:20'),
(1098, 230, 'E - 012 Dt', 1, 'ONE MED', '-', '-', 1, 1, '-', 'botol humidifier rusak', NULL, 'Laik Pakai', 1, '2020-02-24 07:27:32', '2020-03-11 01:00:20'),
(1099, 230, 'E - 012 Dt', 1, 'GEA MEDICAL', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-24 07:27:37', '2020-03-11 01:00:20'),
(1100, 230, 'E - 012 Dt', 57, 'ABN', 'REGAL', '00220142', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-24 07:29:07', '2020-03-11 01:00:20'),
(1101, 230, 'E - 012 Dt', 57, 'RIESTER', 'E-MEGA', '180206536', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-24 07:29:14', '2020-03-11 01:00:20'),
(1102, 230, 'E - 012 Dt', 9, 'ONE MED', 'OD231B', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-24 07:29:51', '2020-03-11 01:00:20'),
(1103, 230, 'E - 012 Dt', 57, 'RIESTER', 'RI-SAN', '160541080', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-24 07:42:24', '2020-03-11 01:00:20'),
(1104, 231, 'E - 013 Dt', 42, 'BLT', 'E30', 'E066E003589', 1, 1, 'Kabel power+adaptor, Koper, Cup Suction, Limb Lead', '-', NULL, 'Laik Pakai', 1, '2020-02-25 05:49:52', '2020-03-19 06:18:41'),
(1105, 231, 'E - 013 Dt', 42, 'Fukuda Denshi', 'CardiMax', '21057890', 1, 1, 'Kabel power+adaptor, Kotak Kardus, Cup Suction, Limb Lead', '-', NULL, 'Laik Pakai', 1, '2020-02-25 05:56:04', '2020-03-19 06:18:41'),
(1106, 232, 'E - 014 Dt', 57, 'riester', 'nova -ecoline', '140462155', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-27 06:47:29', '2020-03-17 01:49:55'),
(1107, 232, 'E - 014 Dt', 57, 'riester', 'nova -ecoline', '140563741', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-02-27 06:47:33', '2020-03-17 01:49:55'),
(1108, 232, 'E - 014 Dt', 21, 'Omron', 'NE-C28', '201407010170UF', 1, 1, 'selang, mouth piece, tempat obat, mask(2)', '-', NULL, 'Laik Pakai', 1, '2020-02-27 06:49:00', '2020-03-17 01:49:55'),
(1109, 233, 'E - 015 Dt', 30, 'GSI', 'GSU 18', 'GS0051202', 1, 1, 'Kabel Power, Headset', 'Belum Dicek', NULL, 'Laik Pakai', 1, '2020-03-02 02:32:38', '2020-03-10 06:19:04'),
(1110, 233, 'E - 015 Dt', 42, 'EDAn', 'SE - 300', '30230-M13C0077001', 1, 1, 'Kabel Lead, Power, Elektroda Bulb dan Jepit', '-', NULL, 'Laik Pakai', 1, '2020-03-02 02:33:35', '2020-03-10 03:19:27'),
(1111, 234, 'E - 016 Dt', 30, 'MAICO', 'MA28', 'MA9057382', 1, 1, 'Kabel Power, Headset', 'Belum Dicek', NULL, 'Laik Pakai', 1, '2020-03-02 02:36:14', '2020-03-03 03:36:20'),
(1112, 234, 'E - 016 Dt', 34, 'microlife', '-', '2019-08-1601082', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-03-02 02:36:40', '2020-03-03 03:36:20'),
(1113, 234, 'E - 016 Dt', 12, 'dragonlab', '-', 'YE195AL0408202', 1, 1, '-', '100-1000 uL', NULL, 'Laik Pakai', 1, '2020-03-02 02:37:31', '2020-03-03 03:36:20'),
(1114, 234, 'E - 016 Dt', 12, 'dragonlab', '-', 'YE195AL0408203', 1, 1, '-', '100-1000 uL', NULL, 'Laik Pakai', 1, '2020-03-02 02:37:34', '2020-03-03 03:36:20'),
(1116, 235, 'E - 017 Dt', 34, 'OMRON', 'HEM - 7130', '20161034184VG', 1, 1, 'tas', '-', NULL, 'Laik Pakai', 1, '2020-03-02 07:34:03', '2020-03-05 00:58:29'),
(1117, 235, 'E - 017 Dt', 34, 'OMRON', 'HEM - 7130', '20190810952VG', 1, 1, 'tas', '-', NULL, 'Laik Pakai', 1, '2020-03-02 07:34:31', '2020-03-05 00:58:29'),
(1118, 235, 'E - 017 Dt', 34, 'OMRON', 'HEM - 7130', '20161022051VG', 1, 1, '', '-', NULL, 'Laik Pakai', 1, '2020-03-02 07:34:35', '2020-03-05 00:58:29'),
(1119, 235, 'E - 017 Dt', 57, 'RIESTER', 'NOVA PRESAMETER', '170662454', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-03-02 07:36:06', '2020-03-05 00:58:29'),
(1120, 235, 'E - 017 Dt', 57, 'RIESTER', 'NOVA ECOLINE', '170560234', 1, 1, '-', '-', NULL, 'Laik pakai', 1, '2020-03-02 07:36:10', '2020-03-05 00:58:29'),
(1121, 235, 'E - 017 Dt', 57, 'SERENITY', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 0, '2020-03-02 07:36:45', '2020-03-05 00:58:29'),
(1122, 236, 'E - 018 Dt', 26, 'Smaf', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-03-05 01:25:02', '2020-03-18 03:12:41'),
(1123, 236, 'E - 018 Dt', 42, 'FUKUDA DENSHI', 'CardiMax', '15028176', 1, 1, 'kabel power dan kabel elektroda', '-', NULL, 'Laik Pakai', 1, '2020-03-05 01:28:25', '2020-03-18 03:12:41'),
(1124, 236, 'E - 018 Dt', 1, 'onemed', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-03-05 01:28:48', '2020-03-18 03:12:41'),
(1125, 236, 'E - 018 Dt', 57, 'OneMed', '-', '1516795', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-03-05 01:29:11', '2020-03-18 03:12:41'),
(1126, 236, 'E - 018 Dt', 37, '-', '-', '4146749', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-03-05 01:31:16', '2020-03-18 03:12:41'),
(1128, 236, 'E - 018 Dt', 55, 'DYNAMED', '3300DYN', 'BB08030855', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-03-05 01:33:08', '2020-03-18 03:12:41'),
(1129, 237, 'E - 019 Dt', 34, 'omron', 'T9P', '20091200032LF', 1, 1, 'manset. charger', '-', NULL, 'Laik Pakai', 1, '2020-03-06 06:52:59', '2020-03-06 08:56:49'),
(1130, 237, 'E - 019 Dt', 34, 'omron', 'T9P', '20091200031LF', 1, 1, 'manset.bungkus', '-', NULL, 'Laik Pakai', 1, '2020-03-06 06:53:03', '2020-03-06 08:56:49'),
(1131, 237, 'E - 019 Dt', 34, 'omron', 'T9P', '20120300257LF', 1, 1, 'manset. charger,bungkus', '-', NULL, 'Laik Pakai', 1, '2020-03-06 06:53:38', '2020-03-06 08:56:49'),
(1132, 237, 'E - 019 Dt', 42, 'Elitech', 'ECG-300G', 'EM2103A0041', 1, 1, 'elektroda, power', '-', NULL, 'Laik Pakai', 1, '2020-03-06 06:56:09', '2020-03-06 08:56:49'),
(1133, 237, 'E - 019 Dt', 42, 'EDAN', 'SE-3', '360312-M16C12760001', 1, 1, 'elektroda set, power', '-', NULL, 'Laik Pakai', 1, '2020-03-06 06:57:08', '2020-03-06 08:56:49'),
(1134, 238, 'E - 020 Dt', 30, 'resonance', 'r27a dd45', 'R27A18A000699', 1, 1, 'Headset, kabel power', '-', NULL, 'Laik Pakai', 1, '2020-03-12 06:18:21', '2020-03-19 06:30:50'),
(1135, 239, 'E - 021 Dt', 34, 'OMRON', 'HEM - 7130 - L', '20180801639VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-03-13 03:45:40', '2020-03-20 01:39:36'),
(1136, 240, 'E - 022 Dt', 59, 'CONTEC', 'SP-10', 'JE1603200156', 1, 1, 'Kabel power, CD', '-', NULL, 'Laik Pakai', 1, '2020-04-07 02:37:28', '2020-04-08 03:23:19'),
(1137, 241, 'E - 023 Dt', 51, 'Orbital Shaker', 'VRN-210', '1806253', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 07:42:30', '2020-06-30 03:24:52'),
(1138, 241, 'E - 023 Dt', 37, 'lifePoint', 'PRO AED', '183120355', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 07:44:02', '2020-06-30 03:24:52'),
(1140, 241, 'E - 023 Dt', 59, 'CHEST', 'CHESTGRAPH', '1132166', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 07:46:28', '2020-06-30 03:24:52'),
(1141, 241, 'E - 023 Dt', 57, 'Riester', 'nova-ecolie', '121243788', 1, 1, '-', 'selang dan bulb meleleh', NULL, 'Tidak Laik Pakai', 1, '2020-06-15 07:47:27', '2020-06-30 03:24:52'),
(1143, 241, 'E - 023 Dt', 66, 'TEKNOVA', 'SH-100', '321B14030214', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 07:50:59', '2020-06-30 03:24:52'),
(1144, 241, 'E - 023 Dt', 57, 'Riester', 'nova-presameter', '130631226', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 07:51:25', '2020-06-30 03:24:52'),
(1145, 241, 'E - 023 Dt', 35, 'WAP LAB', 'WP-0412', 'LD18BAP0000096', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 07:51:58', '2020-06-30 03:24:52'),
(1146, 241, 'E - 023 Dt', 30, 'resonance', 'R27 A DD45', 'R27A17C00502', 1, 1, '-', 'kabel power diisolasi', NULL, 'Laik Pakai', 1, '2020-06-15 07:53:41', '2020-06-30 03:24:52'),
(1147, 241, 'E - 023 Dt', 57, 'Riester', 'nova-ecolie', '100829130', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 07:54:52', '2020-06-30 03:24:52'),
(1149, 242, 'E - 024 Dt', 42, 'BLT', 'E30', 'E066E003277', 1, 1, '-', 'kertas habis', NULL, 'Laik Pakai', 1, '2020-06-15 08:00:20', '2020-06-30 03:26:39'),
(1150, 244, 'E - 026 Dt', 37, 'lifePoint', 'PRO AED', '174080211', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:09:09', '2020-06-30 03:22:37'),
(1151, 244, 'E - 026 Dt', 21, 'ABN', 'CN-08/Compamist2', '10017949', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:10:32', '2020-06-30 03:22:37'),
(1152, 244, 'E - 026 Dt', 55, '-', 'SONOSAT-F04T', 'F04TA8JB3799', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:11:09', '2020-06-30 03:22:37'),
(1153, 244, 'E - 026 Dt', 55, 'JZIKI', 'JZK-301', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:11:23', '2020-06-30 03:22:37'),
(1156, 244, 'E - 026 Dt', 57, 'Riester', 'nova-presameter', '150783288', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:25:36', '2020-06-30 03:22:37'),
(1157, 246, 'E - 028 Dt', 55, 'JKZ-301', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:29:17', '2020-06-25 07:28:22'),
(1158, 245, 'E - 027 Dt', 59, 'CHEST', 'CHESTGRAPH', '1136315', 1, 1, '-', 'kertas habis', NULL, 'Laik Pakai', 1, '2020-06-15 08:32:19', '2020-06-30 03:15:13'),
(1159, 241, 'E - 023 Dt', 30, 'resonance', 'r27 a', 'R27A17D000525', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:40:03', '2020-06-30 03:24:52'),
(1160, 243, 'E - 025 Dt', 9, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:43:33', '2020-06-30 03:28:12'),
(1161, 243, 'E - 025 Dt', 42, 'CARDIMAX', 'FX-7102', '22038941', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:44:11', '2020-06-30 03:28:12'),
(1162, 245, 'E - 027 Dt', 35, 'Smartcare', 'PLC-03', '1712695', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:45:40', '2020-06-30 03:15:13'),
(1163, 242, 'E - 024 Dt', 59, 'CHEST', 'CHESTGRAPH HI-101', '113659', 1, 1, '-', 'tanpa syringe kalibrator', NULL, 'Laik Pakai', 1, '2020-06-15 08:46:44', '2020-06-30 03:26:39'),
(1165, 246, 'E - 028 Dt', 12, 'dumo', '-', 'JB489685', 1, 1, '-', '100-1000uL', NULL, 'Laik Pakai', 1, '2020-06-15 08:55:46', '2020-06-25 07:28:22'),
(1166, 242, 'E - 024 Dt', 35, 'WAP LAB', 'WP 0412', 'LD18BAP0000089', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-15 08:58:40', '2020-06-30 03:26:39'),
(1168, 242, 'E - 024 Dt', 55, 'Elitech', 'FOX-1', 'FX117BB5968', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-17 07:10:21', '2020-06-30 03:26:39'),
(1169, 245, 'E - 027 Dt', 55, 'General Care', 'SONOSAT F04T', 'F04FAQJ5A819', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-19 01:29:08', '2020-06-30 03:15:13'),
(1170, 248, 'E - 030 Dt', 57, 'ABN', '0044', '460809', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:17:10', '2020-08-11 00:23:55'),
(1171, 248, 'E - 030 Dt', 57, 'ABN', '0044', '580104', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:17:13', '2020-08-11 00:23:55'),
(1172, 248, 'E - 030 Dt', 57, 'ABN', '0044', '460447', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:17:27', '2020-08-11 00:23:55'),
(1173, 248, 'E - 030 Dt', 21, 'OMRON', 'NE-C28', '20100912504UF', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:18:30', '2020-08-11 00:23:55'),
(1174, 248, 'E - 030 Dt', 26, 'Surgimed', 'DFX-23C 1', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:19:25', '2020-08-11 00:23:55'),
(1175, 248, 'E - 030 Dt', 42, 'Bionet', 'CT-3000', 'T2L0800086', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:20:36', '2020-08-11 00:23:55'),
(1176, 248, 'E - 030 Dt', 59, 'Bionet', 'CT-3000', 'T2L0800086', 1, 1, '-', 'Kertas Habis', NULL, 'Laik Pakai', 1, '2020-06-25 03:20:39', '2020-08-11 00:23:55'),
(1177, 248, 'E - 030 Dt', 1, 'AVICO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:21:58', '2020-08-11 00:23:55'),
(1178, 248, 'E - 030 Dt', 1, 'AVICO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:22:08', '2020-08-11 00:23:55'),
(1179, 248, 'E - 030 Dt', 1, 'AVICO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:22:12', '2020-08-11 00:23:55'),
(1180, 248, 'E - 030 Dt', 1, 'AVICO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:22:14', '2020-08-11 00:23:55'),
(1181, 248, 'E - 030 Dt', 1, 'AVICO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:22:16', '2020-08-11 00:23:55'),
(1182, 248, 'E - 030 Dt', 55, 'Contec', '-', '09AG107785', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:23:45', '2020-08-11 00:23:55'),
(1183, 248, 'E - 030 Dt', 34, 'OMRON', 'HEM-8712', '20181115251 VD', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:32:40', '2020-08-11 00:23:55'),
(1184, 248, 'E - 030 Dt', 34, 'OMRON', 'HEM-7322', '20160300829', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:32:53', '2020-08-11 00:23:55'),
(1185, 248, 'E - 030 Dt', 37, 'Lifepak CR Plus', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 03:34:34', '2020-08-11 00:23:55'),
(1186, 247, 'E - 029 Dt', 42, 'BTL', 'BTL-08 SD', '017D0B007700', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-25 06:07:55', '2020-06-30 03:13:53'),
(1187, 249, 'E - 031 Dt', 30, 'Inventis', 'Bell Plus TDH39', 'AU1DB15102829', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-06-30 01:03:36', '2020-06-30 01:09:38'),
(1188, 250, 'E - 032 Dt', 57, 'ABN', 'SPECTRUM', '543628', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:13:41', '2020-07-14 02:03:28'),
(1189, 250, 'E - 032 Dt', 57, 'ABN', 'SPECTRUM', '543000', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:13:51', '2020-07-14 02:03:28'),
(1190, 250, 'E - 032 Dt', 57, 'ABN', 'SPECTRUM', '00321017', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:14:29', '2020-07-14 02:03:28'),
(1191, 250, 'E - 032 Dt', 57, 'ABN', 'SPECTRUM', '0039 6785', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:15:38', '2020-07-14 02:03:28'),
(1192, 250, 'E - 032 Dt', 57, 'ABN', 'SPECTRUM', '527952', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:16:21', '2020-07-14 02:03:28'),
(1193, 250, 'E - 032 Dt', 34, 'Microlife', 'afib', '2019-11-1200361', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:19:36', '2020-07-14 02:03:28'),
(1194, 250, 'E - 032 Dt', 12, 'Dragon Lab', '-', 'YE195AL0403177', 1, 1, '0.5 - 10 uL', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:21:51', '2020-07-14 02:03:28'),
(1195, 250, 'E - 032 Dt', 10, 'Dragon Lab', '-', 'YE19BAL0604965', 1, 1, '5 uL', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:21:55', '2020-07-14 02:03:28'),
(1196, 250, 'E - 032 Dt', 42, 'Elitech', 'ECG-300G', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:24:55', '2020-07-14 02:03:28'),
(1197, 250, 'E - 032 Dt', 59, 'BTL-08', 'BTL-08 SPIRO', '08MTSO737931', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-02 06:26:15', '2020-07-14 02:03:28'),
(1199, 251, 'E - 033 Dt', 10, 'Accumax', '-', 'FX756126', 1, 1, '-', '25 uL', NULL, 'Laik Pakai', 1, '2020-07-06 07:58:08', '2020-07-30 01:23:05'),
(1200, 251, 'E - 033 Dt', 10, 'Accumax', '-', '323059', 1, 1, '-', '200 uL', NULL, 'Laik Pakai', 1, '2020-07-06 07:59:07', '2020-07-30 01:23:05'),
(1201, 251, 'E - 033 Dt', 10, 'Accumax', '-', '140830', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2020-07-06 07:59:18', '2020-07-30 01:23:05'),
(1202, 251, 'E - 033 Dt', 10, 'Accumax', '-', 'JD498682', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2020-07-06 07:59:47', '2020-07-30 01:23:05'),
(1203, 251, 'E - 033 Dt', 10, 'Accumax', '-', 'GJ383885', 1, 1, '-', '250 uL', NULL, 'Laik Pakai', 1, '2020-07-06 08:00:18', '2020-07-30 01:23:05'),
(1204, 251, 'E - 033 Dt', 10, 'Accumax', '-', '608874', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2020-07-06 08:02:14', '2020-07-30 01:23:05'),
(1205, 251, 'E - 033 Dt', 10, 'Accumax', '-', 'HK443594', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2020-07-06 08:02:38', '2020-07-30 01:23:05'),
(1206, 251, 'E - 033 Dt', 10, 'Accumax', '-', 'FK351484', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2020-07-06 08:03:03', '2020-07-30 01:23:05'),
(1207, 251, 'E - 033 Dt', 10, 'Accumax', '-', 'JD498871', 1, 1, '-', '50 uL', NULL, 'Laik Pakai', 1, '2020-07-06 08:03:26', '2020-07-30 01:23:05'),
(1208, 251, 'E - 033 Dt', 10, 'Accumax', '-', 'FK757281', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2020-07-06 08:04:15', '2020-07-30 01:23:05'),
(1209, 250, 'E - 032 Dt', 57, 'ABN', 'SPECTRUM', '543577', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-06 08:10:17', '2020-07-14 02:03:28'),
(1210, 252, 'E - 034 Dt', 59, 'CHEST', 'CHESTGRAPH HI-101', '1131443', 1, 1, 'Kabel Power, Mouth Piece', 'Pipa ada 2 (yang lama dgn yg baru)', NULL, 'Laik Pakai', 1, '2020-07-10 00:59:58', '2020-07-28 02:44:12'),
(1211, 253, 'E - 035 Dt', 55, 'Elitech', '-', '17BB4776', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 02:20:44', '2020-08-06 03:19:17'),
(1212, 253, 'E - 035 Dt', 10, 'SOCOREX', 'ACURA 815', '26051415', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2020-07-22 02:22:47', '2020-08-06 03:19:17'),
(1213, 253, 'E - 035 Dt', 12, 'SOCOREX', 'ACURA 825', '26022013', 1, 1, '-', '0.5-10 uL', NULL, 'Laik Pakai', 1, '2020-07-22 02:23:15', '2020-08-06 03:19:17'),
(1214, 253, 'E - 035 Dt', 10, 'SOCOREX', 'ACURA 815', '26021672', 1, 1, '-', '50 uL', NULL, 'Laik Pakai', 1, '2020-07-22 02:27:06', '2020-08-06 03:19:17'),
(1215, 253, 'E - 035 Dt', 51, 'Orbital Shaker', 'VRN-200', '1712742', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 02:41:20', '2020-08-06 03:19:17'),
(1216, 253, 'E - 035 Dt', 35, 'WAP-LAP', 'WP-0412', 'LD18BAP0000095', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 03:06:40', '2020-08-06 03:19:17'),
(1217, 254, 'E - 036 Dt', 32, '-', 'PC-3000', 'J4200IB00047', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 03:14:11', '2020-08-11 00:36:12'),
(1218, 254, 'E - 036 Dt', 21, 'OMRON', 'COMP-AIR', '2009010017 VK', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 03:15:15', '2020-08-11 00:36:12'),
(1219, 254, 'E - 036 Dt', 26, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 03:15:56', '2020-08-11 00:36:12'),
(1220, 255, 'E - 037 Dt', 42, 'Fukuda Denshi', 'CardiMax', '18059241', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 03:26:09', '2020-07-30 04:22:27'),
(1221, 255, 'E - 037 Dt', 57, 'Riester', 'Nova Ecoline', '091274110', 1, 1, '-', 'manset bocor', NULL, 'Laik Pakai', 1, '2020-07-22 03:27:39', '2020-07-30 04:22:27'),
(1222, 255, 'E - 037 Dt', 57, 'Riester', 'Nova Presameter', '970984705', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 03:27:42', '2020-07-30 04:22:27'),
(1223, 255, 'E - 037 Dt', 42, 'GE', 'MAC 600', 'SP517090020PA', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 03:36:41', '2020-07-30 04:22:27'),
(1224, 255, 'E - 037 Dt', 30, 'MAICO', 'MA-51', '0116022', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-07-22 03:40:18', '2020-07-30 04:22:27'),
(1225, 256, 'E - 038 Dt', 57, 'Riester', 'big ben round', '181141532', 1, 1, 'Standing', '-', NULL, 'Laik Pakai', 1, '2020-07-30 04:26:51', '2020-08-14 06:37:13'),
(1226, 256, 'E - 038 Dt', 57, 'Erkameter', 'D-83646', '11037475', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2020-07-30 04:27:23', '2020-08-14 06:37:13'),
(1227, 256, 'E - 038 Dt', 57, 'Riester', 'Exacta-1350', '190421087', 1, 1, 'Tas', '-', NULL, 'Laik Pakai', 1, '2020-07-30 04:27:51', '2020-08-14 06:37:13'),
(1228, 256, 'E - 038 Dt', 1, 'GEA Medical', '-', '-', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-07-30 04:28:14', '2020-08-14 06:37:13'),
(1229, 256, 'E - 038 Dt', 1, 'Nesco', '-', '-', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-07-30 04:28:28', '2020-08-14 06:37:13'),
(1230, 256, 'E - 038 Dt', 21, 'Omron', 'COMPAir', '6900629U', 1, 1, 'Tas', 'Tanpa Selang dan Water trap', NULL, 'Laik Pakai', 1, '2020-07-30 04:29:32', '2020-08-14 06:37:13'),
(1231, 256, 'E - 038 Dt', 41, 'Bistos', 'Hi-Bebe', 'BABBC1135', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-07-30 04:30:15', '2020-08-14 06:37:13'),
(1232, 257, 'E - 039 Dt', 10, 'SOCOREX', 'ACURA 815', '22111234', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2020-08-03 07:04:38', '2020-08-28 05:45:02'),
(1233, 257, 'E - 039 Dt', 10, 'SOCOREX', 'ACURA 815', '22101326', 1, 1, '-', '1000 uL', NULL, 'Tidak Laik Pakai', 1, '2020-08-03 07:04:40', '2020-08-28 05:44:33'),
(1234, 257, 'E - 039 Dt', 10, 'SOCOREX', 'ACURA 815', '20081192', 1, 1, '-', '1000 uL', NULL, 'Tidak Laik Pakai', 1, '2020-08-03 07:05:15', '2020-08-28 05:44:33'),
(1235, 257, 'E - 039 Dt', 10, 'SOCOREX', 'ACURA 815', '19101238', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2020-08-03 07:05:35', '2020-08-28 05:44:33'),
(1236, 257, 'E - 039 Dt', 10, 'SOCOREX', 'ACURA 835', '22101423', 1, 1, '-', '5 mL (BELUM DICEK)', NULL, 'Tidak Laik Pakai', 1, '2020-08-03 07:06:12', '2020-08-28 05:44:33'),
(1237, 257, 'E - 039 Dt', 10, 'SOCOREX', 'ACURA 815', '23011174', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2020-08-03 07:06:44', '2020-08-28 05:44:33'),
(1238, 257, 'E - 039 Dt', 10, 'labopette', '-', '6051876', 1, 1, '-', '200 uL', NULL, 'Laik Pakai', 1, '2020-08-03 07:07:54', '2020-08-28 05:44:33'),
(1239, 257, 'E - 039 Dt', 12, 'SOCOREX', 'ACURA 832', '23021021', 1, 1, '-', '1-10 mL (BELUM DICEK)', NULL, 'Laik Pakai', 1, '2020-08-03 07:12:00', '2020-08-28 05:44:33'),
(1240, 258, 'E - 040 Dt', 34, 'AND', 'UA 1020', '5180203586', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 00:40:00', '2020-08-31 01:37:49'),
(1241, 259, 'E - 041 Dt', 21, 'GEA', '403C', 'YY15090314', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 00:43:41', '2020-08-31 01:39:15'),
(1242, 259, 'E - 041 Dt', 22, '-', '-', '45090009', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 00:47:20', '2020-08-31 01:39:15'),
(1243, 259, 'E - 041 Dt', 34, 'AND', 'UAI 1020', '5180203587', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 00:48:30', '2020-08-31 01:39:15'),
(1244, 259, 'E - 041 Dt', 10, 'Hummapette', '-', '07E00154', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2020-08-06 00:49:22', '2020-08-31 01:39:15'),
(1245, 259, 'E - 041 Dt', 10, 'Hummapette', '-', '02E29190', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2020-08-06 00:49:27', '2020-08-31 01:39:15'),
(1246, 262, 'E - 043 Dt', 35, 'HEALTH', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 02:14:02', '2020-08-31 01:42:27'),
(1247, 262, 'E - 043 Dt', 41, 'MEDGYN', 'SD6', '460571-M18A01540023', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 02:15:24', '2020-08-31 01:42:27'),
(1248, 262, 'E - 043 Dt', 42, 'BTL', 'BTL-08 SD', '071D-B06294', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 02:17:42', '2020-08-31 01:42:27'),
(1249, 262, 'E - 043 Dt', 26, 'DIXION', '-', '07/06/1805/2975', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 02:20:08', '2020-08-31 01:42:27'),
(1250, 262, 'E - 043 Dt', 55, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 02:20:56', '2020-08-31 01:42:27'),
(1251, 262, 'E - 043 Dt', 57, 'ADC', '-', '18004874', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 02:21:31', '2020-08-31 01:42:27'),
(1252, 262, 'E - 043 Dt', 34, 'AND', '-', '5180202086', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 02:22:07', '2020-08-31 01:42:27'),
(1253, 262, 'E - 043 Dt', 21, 'ISAPAK', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 02:23:23', '2020-08-31 01:42:27'),
(1255, 263, 'E - 044 Dt', 21, 'Prizma', 'Prafi-2 Sonic', '201636002411', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 02:58:02', '2020-08-31 01:43:31'),
(1258, 263, 'E - 044 Dt', 12, 'DRAGONLAB', '-', 'YE187AL0023052', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 04:12:58', '2020-08-31 01:43:31'),
(1259, 263, 'E - 044 Dt', 51, 'K', 'VRN-200', '1406586', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 04:19:29', '2020-08-31 01:43:31'),
(1260, 263, 'E - 044 Dt', 34, 'kenko', '-', '18050226917', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 05:45:18', '2020-08-31 01:43:31'),
(1261, 263, 'E - 044 Dt', 34, 'Dr Care', '-', '1611083738', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 05:45:20', '2020-08-31 01:43:31'),
(1262, 263, 'E - 044 Dt', 34, 'OMRON', '-', '201507063VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 05:45:40', '2020-08-31 01:43:31'),
(1263, 265, 'E - 046 Dt', 41, 'bistos', '-', 'BABD4102', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 06:17:24', '2020-08-31 01:45:27'),
(1264, 265, 'E - 046 Dt', 41, 'Elitech', '-', 'fb1504200768', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 06:18:25', '2020-08-31 01:45:27'),
(1265, 265, 'E - 046 Dt', 21, 'prizma', 'prafil II SONIC', '201636002397', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 06:32:26', '2020-08-31 01:45:27'),
(1266, 265, 'E - 046 Dt', 26, 'Doctors Friends', '-', '9050589', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 06:44:19', '2020-08-31 01:45:27'),
(1267, 266, 'E - 047 Dt', 22, 'BRAUN', 'CRYSTAL 5-8-2', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 07:12:17', '2020-08-31 01:46:10'),
(1268, 266, 'E - 047 Dt', 42, 'BTL', '-', '017D-DD06154', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 07:16:56', '2020-08-31 01:46:10'),
(1269, 266, 'E - 047 Dt', 42, 'BTL', '-', '017D-0B007521', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 07:43:13', '2020-08-31 01:46:10'),
(1271, 266, 'E - 047 Dt', 26, 'Doctors Friend', '-', '9050992', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 07:45:38', '2020-08-31 01:46:10'),
(1272, 266, 'E - 047 Dt', 34, 'OMRON', '-', '010071461F', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 07:47:21', '2020-08-31 01:46:10'),
(1274, 266, 'E - 047 Dt', 34, 'KENKO', '-', '1805022066', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 07:47:27', '2020-08-31 01:46:10'),
(1275, 266, 'E - 047 Dt', 9, 'BABY CARE', 'RGZ-20', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 07:48:40', '2020-08-31 01:46:10'),
(1276, 267, 'E - 048 Dt', 42, 'BTL', '-', '071D0B06295', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 07:51:36', '2020-08-31 01:49:21'),
(1277, 267, 'E - 048 Dt', 57, 'ADC', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 07:52:15', '2020-08-31 01:49:21'),
(1278, 268, 'E - 049 dT', 42, 'BTL', '-', '017D-B-06280', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 08:04:40', '2020-08-31 01:50:05'),
(1279, 268, 'E - 049 dT', 19, 'BRAUN', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 08:05:16', '2020-08-31 01:50:05'),
(1280, 268, 'E - 049 dT', 12, 'NESCO', 'DRAGONLAB', 'YE4A264821', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-06 08:06:42', '2020-08-31 01:50:05'),
(1281, 268, 'E - 049 dT', 22, 'SERENITY', 'OXIGEN PRO', '-', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2020-08-06 08:10:14', '2020-08-31 01:50:05'),
(1282, 265, 'E - 046 Dt', 42, 'btl', '-', '017D-DD06174', 1, 1, '-', 'tanpa kabel elektrode', NULL, 'Laik Pakai', 1, '2020-08-06 08:11:28', '2020-08-31 01:45:27'),
(1283, 269, 'E - 050 Dt', 35, 'HEALTH', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 03:57:52', '2020-08-31 01:51:48'),
(1284, 269, 'E - 050 Dt', 42, 'BTL', '-', '017D-B-06233', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 03:59:18', '2020-08-31 01:51:48'),
(1285, 269, 'E - 050 Dt', 19, 'BRAUN', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 03:59:55', '2020-08-31 01:51:48'),
(1286, 269, 'E - 050 Dt', 1, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 04:00:27', '2020-08-31 01:51:48'),
(1287, 269, 'E - 050 Dt', 21, 'OMRON', 'NE-C29', '20100700279UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 05:43:49', '2020-08-31 01:51:48'),
(1288, 269, 'E - 050 Dt', 12, '-', '-', '-', 1, 1, '-', '100 - 100 uL', NULL, 'Laik Pakai', 1, '2020-08-10 05:44:45', '2020-08-31 01:51:48'),
(1289, 269, 'E - 050 Dt', 34, 'AND', '-', 'AKL2050113522', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 05:45:28', '2020-08-31 01:51:48'),
(1290, 269, 'E - 050 Dt', 57, '-', '-', '18005485', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 05:46:01', '2020-08-31 01:51:48'),
(1291, 269, 'E - 050 Dt', 9, 'ONEMED', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 05:46:29', '2020-08-31 01:51:48'),
(1297, 264, 'E - 045 Dt', 35, '-', '80-24', '30711195', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 05:56:55', '2020-08-31 01:44:11'),
(1298, 264, 'E - 045 Dt', 41, 'BISTOS', 'BT-200', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 05:57:24', '2020-08-31 01:44:11'),
(1299, 264, 'E - 045 Dt', 42, 'BTL', '-', '017D-B-06293', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 05:58:08', '2020-08-31 01:44:11'),
(1300, 264, 'E - 045 Dt', 22, 'SERENITY', '-', '150900019', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 05:58:47', '2020-08-31 01:44:11'),
(1301, 264, 'E - 045 Dt', 21, 'ISAPAK', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 05:59:23', '2020-08-31 01:44:11'),
(1302, 264, 'E - 045 Dt', 12, '-', '-', 'yl4a050413', 1, 1, '-', '5-50 uL', NULL, 'Laik Pakai', 1, '2020-08-10 06:00:25', '2020-08-31 01:44:11'),
(1303, 264, 'E - 045 Dt', 51, 'k', 'vrn-200', '1407892', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-10 06:01:29', '2020-08-31 01:44:11'),
(1304, 271, 'E - 052 Dt', 21, 'ABN', 'Compamist 1', '-', 1, 1, 'Kotak, Mouthpiece, Selang,', '-', NULL, 'Laik Pakai', 1, '2020-08-11 09:00:31', '2020-08-25 03:53:49'),
(1305, 271, 'E - 052 Dt', 34, 'yuwell', 'YE660E', 'B201901519', 1, 1, 'Manset', '-', NULL, 'Laik Pakai', 1, '2020-08-11 09:01:25', '2020-08-25 03:53:49'),
(1306, 271, 'E - 052 Dt', 55, 'Beurer', 'PO 30', '-', 1, 1, 'Kotak, Dompet, Baterai (2)', '-', NULL, 'Laik Pakai', 1, '2020-08-11 09:02:09', '2020-08-25 03:53:49'),
(1307, 271, 'E - 052 Dt', 9, 'ONEMED', 'OD231B', '-', 1, 1, 'Kotak', 'Tanpa Baterai', NULL, 'Laik Pakai', 1, '2020-08-11 09:02:57', '2020-08-25 03:53:49'),
(1308, 259, 'E - 041 Dt', 10, 'Hummapette', '-', '08e11316', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2020-08-14 00:28:58', '2020-08-31 01:39:15'),
(1309, 259, 'E - 041 Dt', 10, 'Hummapette', '-', '03E47289', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2020-08-14 00:30:25', '2020-08-31 01:39:15'),
(1310, 265, 'E - 046 Dt', 22, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-14 00:36:20', '2020-08-31 01:45:27'),
(1311, 264, 'E - 045 Dt', 12, '-', '-', 'ye4a257778', 1, 1, '-', '100-1000 uL', NULL, 'Laik Pakai', 1, '2020-08-14 01:57:15', '2020-08-31 01:44:11'),
(1312, 264, 'E - 045 Dt', 12, '-', '-', 'ke0009396', 1, 1, '-', '20-200 uL', NULL, 'Laik Pakai', 1, '2020-08-14 01:57:45', '2020-08-31 01:44:11'),
(1313, 266, 'E - 047 Dt', 35, '-', 'KHT', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-14 01:59:35', '2020-08-31 01:46:10'),
(1315, 266, 'E - 047 Dt', 35, '-', '80-2a', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-14 01:59:42', '2020-08-31 01:46:10'),
(1316, 267, 'E - 048 Dt', 42, 'BTL', '-', '071D0B007465', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-14 02:00:24', '2020-08-31 01:49:21'),
(1318, 272, 'E - 042 Dt', 42, 'BLT', '-', '071D-B-06181', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-18 05:22:05', '2020-08-31 01:39:38'),
(1319, 272, 'E - 042 Dt', 21, 'ISAPAK', '-', '5172794', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-18 05:22:33', '2020-08-31 01:39:38'),
(1320, 272, 'E - 042 Dt', 57, 'Riester', 'nova ecoline', '160561746', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-18 05:23:01', '2020-08-31 01:39:38'),
(1321, 272, 'E - 042 Dt', 9, '-', 'RGZ-20', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-18 05:23:24', '2020-08-31 01:39:38'),
(1322, 273, 'E - 054 Dt', 10, 'Nesco', 'Dragonlab', 'YE176AF0018063', 1, 1, '-', '5 uL', NULL, NULL, 0, '2020-08-18 05:37:53', '2020-08-18 05:38:34'),
(1323, 273, 'E - 054 Dt', 10, 'eppendorf', 'Research', '465257', 1, 1, '-', '1000 uL', NULL, NULL, 0, '2020-08-18 05:38:03', '2020-08-18 05:41:42'),
(1324, 273, 'E - 054 Dt', 10, 'Nesco', 'Dragonlab', 'YE176AF0018000', 1, 1, '-', '10 uL', NULL, NULL, 0, '2020-08-18 05:38:35', '2020-08-18 05:38:35'),
(1325, 273, 'E - 054 Dt', 10, 'Nesco', 'Dragonlab', 'YE176AF0017891', 1, 1, '-', '50 uL', NULL, NULL, 0, '2020-08-18 05:38:57', '2020-08-18 05:38:57'),
(1327, 273, 'E - 054 Dt', 12, 'DRAGON ONEMED', '-', 'YL178AD0004875', 1, 1, '-', '200 - 1000 uL', NULL, NULL, 0, '2020-08-18 05:40:33', '2020-08-18 05:40:33'),
(1328, 273, 'E - 054 Dt', 10, 'Nesco', 'Dragonlab', 'YE176AF0017852', 1, 1, '-', '100 uL', NULL, NULL, 0, '2020-08-18 05:40:38', '2020-08-18 05:40:38'),
(1329, 273, 'E - 054 Dt', 10, 'BIOHT', 'PROLING', '5082784', 1, 1, '-', '500 uL', NULL, NULL, 0, '2020-08-18 05:41:15', '2020-08-18 05:41:15'),
(1330, 273, 'E - 054 Dt', 10, 'eppendorf', 'Research', '413673', 1, 1, '-', '50 uL', NULL, NULL, 0, '2020-08-18 05:41:48', '2020-08-18 05:42:02'),
(1331, 273, 'E - 054 Dt', 10, 'microlit', '-', '04011509', 1, 1, '-', '10 uL', NULL, NULL, 0, '2020-08-18 05:42:17', '2020-08-18 05:42:52'),
(1332, 273, 'E - 054 Dt', 10, 'BOECO', '-', 'CR56742', 1, 1, '-', '5 uL', NULL, NULL, 0, '2020-08-18 05:42:56', '2020-08-18 05:43:23'),
(1333, 273, 'E - 054 Dt', 35, 'ONEGON', 'LC-045', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-18 05:43:42', '2020-08-24 03:17:56'),
(1334, 273, 'E - 054 Dt', 35, 'ONEGON', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-18 05:43:48', '2020-08-24 03:17:56'),
(1335, 273, 'E - 054 Dt', 30, 'MAICO', 'MA-40', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-18 05:44:16', '2020-08-24 03:17:56'),
(1336, 273, 'E - 054 Dt', 30, 'COM HEAR', 'CH33', '20127273', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-18 05:44:48', '2020-08-24 03:17:56'),
(1338, 273, 'E - 054 Dt', 59, 'CHEST', 'CHESTGRAPH', '1131124', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-18 05:45:59', '2020-08-24 03:17:56'),
(1339, 273, 'E - 054 Dt', 42, 'Bionet', 'Cardiocare', 'ER1000485', 1, 1, '-', '-', NULL, NULL, 0, '2020-08-18 05:46:21', '2020-08-18 05:46:21'),
(1340, 273, 'E - 054 Dt', 42, 'Bionet', 'Cardiocare', 'EF1000556', 1, 1, '-', '-', NULL, NULL, 0, '2020-08-18 05:46:25', '2020-08-18 05:46:36'),
(1341, 266, 'E - 047 Dt', 41, 'Elitech', 'SONOTRAX B', 'FB1504200352', 1, 1, '-', 'Kabel Terkelupas', NULL, 'Laik Pakai', 1, '2020-08-18 06:05:21', '2020-08-31 01:46:10'),
(1342, 274, 'E - 053 Dt', 42, 'zoncare', '-', '6956913481082', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 00:33:28', '2020-08-19 04:02:43'),
(1343, 266, 'E - 047 Dt', 60, 'SIMC', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 04:43:59', '2020-08-31 01:46:10'),
(1344, 266, 'E - 047 Dt', 60, 'SIMC', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 04:44:27', '2020-08-31 01:46:10'),
(1345, 270, 'E - 051 Dt', 55, 'Elitech', '-', 'fx5191a5375', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:18:06', '2020-08-27 01:20:10'),
(1346, 270, 'E - 051 Dt', 55, 'ChoiceMMed', '-', '200907900229', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:18:11', '2020-08-27 01:20:10'),
(1347, 270, 'E - 051 Dt', 55, 'ChoiceMMed', '-', '200907900224', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:18:39', '2020-08-27 01:20:10'),
(1348, 270, 'E - 051 Dt', 55, 'ChoiceMMed', '-', '200907900225', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:18:48', '2020-08-27 01:20:10'),
(1349, 270, 'E - 051 Dt', 55, 'Jumper', 'JPD-500A', '8624500A005118', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:19:18', '2020-08-27 01:20:10'),
(1350, 270, 'E - 051 Dt', 55, 'ChoiceMMed', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:20:14', '2020-08-27 01:20:10'),
(1351, 270, 'E - 051 Dt', 34, 'OMRON', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:34:15', '2020-08-27 01:20:10'),
(1352, 270, 'E - 051 Dt', 34, 'OMRON', 'HEM-7011-C1', '20100104363UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:34:31', '2020-08-27 01:20:10'),
(1353, 270, 'E - 051 Dt', 57, 'GENERAL CARE', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:35:56', '2020-08-27 01:20:10'),
(1355, 270, 'E - 051 Dt', 1, 'NESCO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:37:20', '2020-08-27 01:20:10'),
(1356, 270, 'E - 051 Dt', 26, 'SIMEK', 'M2OPLUS', '90022861', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:40:01', '2020-08-27 01:20:10'),
(1357, 270, 'E - 051 Dt', 12, 'SOCOREX', 'ACURA 825', '29071730', 1, 1, '-', '10-100uL', NULL, 'Laik Pakai', 1, '2020-08-19 06:41:17', '2020-08-27 01:20:10'),
(1358, 270, 'E - 051 Dt', 12, 'SOCOREX', 'ACURA 825', '29031151', 1, 1, '-', '5-50uL', NULL, 'Laik Pakai', 1, '2020-08-19 06:41:34', '2020-08-27 01:20:10'),
(1359, 270, 'E - 051 Dt', 12, 'SOCOREX', 'ACURA 825', '0352128', 1, 1, '-', '50-200uL', NULL, 'Laik Pakai', 1, '2020-08-19 06:42:03', '2020-08-27 01:20:10'),
(1360, 270, 'E - 051 Dt', 12, 'SOCOREX', 'ACURA 825', '21021424', 1, 1, '-', '20-200uL', NULL, 'Laik Pakai', 1, '2020-08-19 06:42:34', '2020-08-27 01:20:10'),
(1361, 270, 'E - 051 Dt', 12, 'SOCOREX', 'ACURA 825', '20111723', 1, 1, '-', '100-1000uL', NULL, 'Laik Pakai', 1, '2020-08-19 06:43:02', '2020-08-27 01:20:10'),
(1362, 270, 'E - 051 Dt', 50, 'FPSC', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:44:38', '2020-08-27 01:20:10'),
(1363, 270, 'E - 051 Dt', 50, 'FPSC', '-', '-', 1, 1, '-', 'Kabel Power Basah', NULL, 'Laik Pakai', 1, '2020-08-19 06:44:43', '2020-08-27 01:20:10'),
(1364, 270, 'E - 051 Dt', 32, 'COMEN', 'C50', 'KD15112150', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:45:52', '2020-08-27 01:20:10'),
(1365, 270, 'E - 051 Dt', 32, 'PHILIPS', '-', 'CN44000367', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:45:59', '2020-08-27 01:20:10'),
(1366, 270, 'E - 051 Dt', 32, 'PHILIPS', 'GOLDWAY 630', 'CM32710846', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:46:56', '2020-08-27 01:20:10'),
(1367, 270, 'E - 051 Dt', 22, 'GEA', '-', '161000114', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:47:59', '2020-08-27 01:20:10'),
(1368, 270, 'E - 051 Dt', 22, 'GEA', '-', '161000063', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:48:11', '2020-08-27 01:20:10'),
(1369, 270, 'E - 051 Dt', 1, 'ALLIED', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:49:07', '2020-08-27 01:20:10'),
(1370, 270, 'E - 051 Dt', 42, '-', 'SE-1200 EXPRESS', '311072-M16601600001', 1, 1, '-', 'Gear kertas tidak ada', NULL, 'Laik Pakai', 1, '2020-08-19 06:50:21', '2020-08-27 01:20:10'),
(1371, 270, 'E - 051 Dt', 13, 'AND', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:51:14', '2020-08-27 01:20:10'),
(1372, 270, 'E - 051 Dt', 49, 'BINDER', '-', '07-17756', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:51:48', '2020-08-27 01:20:10'),
(1373, 270, 'E - 051 Dt', 61, 'MEMMERT', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:52:09', '2020-08-27 01:20:10'),
(1374, 270, 'E - 051 Dt', 66, 'GE', '-', '104166WX4', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:52:58', '2020-08-27 01:20:10'),
(1375, 270, 'E - 051 Dt', 35, 'HETTICH', 'EBA 20', '0110748', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:53:42', '2020-08-27 01:20:10'),
(1376, 270, 'E - 051 Dt', 21, 'OMRON', '-', '20150401229', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:54:22', '2020-08-27 01:20:10'),
(1377, 270, 'E - 051 Dt', 37, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:54:38', '2020-08-27 01:20:10'),
(1378, 270, 'E - 051 Dt', 37, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:54:43', '2020-08-27 01:20:10'),
(1379, 270, 'E - 051 Dt', 37, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-19 06:54:44', '2020-08-27 01:20:10'),
(1380, 275, 'E - 055 Dt', 57, 'Riester', 'Nova Ecoline', '170162583', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 07:53:30', '2020-09-09 05:57:42'),
(1382, 275, 'E - 055 Dt', 10, 'SOCOREX', 'acura 815', '26091756', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2020-08-24 07:55:21', '2020-09-09 05:57:42'),
(1383, 275, 'E - 055 Dt', 10, 'SOCOREX', 'acura 815', '26061130', 1, 1, '-', '20 uL', NULL, 'Laik Pakai', 1, '2020-08-24 07:55:27', '2020-09-09 05:57:42'),
(1384, 275, 'E - 055 Dt', 10, 'SOCOREX', 'acura 815', '26061793', 1, 1, '-', '50 uL', NULL, 'Laik Pakai', 1, '2020-08-24 07:59:05', '2020-09-09 05:57:42'),
(1385, 275, 'E - 055 Dt', 10, 'SOCOREX', 'acura 815', '25121181', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2020-08-24 07:59:08', '2020-09-09 05:57:42'),
(1386, 275, 'E - 055 Dt', 55, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:01:13', '2020-09-09 05:57:42'),
(1387, 275, 'E - 055 Dt', 10, 'SOCOREX', 'acura 815', '23111046', 1, 1, '-', '250 uL', NULL, 'Laik Pakai', 1, '2020-08-24 08:01:16', '2020-09-09 05:57:42'),
(1388, 275, 'E - 055 Dt', 30, 'RESONANCE', '-', 'R27A17C000503', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:03:51', '2020-09-09 05:57:42'),
(1389, 275, 'E - 055 Dt', 42, 'BLT', 'BLTE30', 'E066E003547', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:10:00', '2020-09-09 05:57:42'),
(1390, 275, 'E - 055 Dt', 59, 'CHEST', '-', '1132855', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:10:27', '2020-09-09 05:57:42'),
(1391, 275, 'E - 055 Dt', 35, 'WAPLAB', '-', 'LS16BAD0000040', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:11:02', '2020-09-09 05:57:42'),
(1392, 275, 'E - 055 Dt', 51, 'K', '-', '1612803', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:11:32', '2020-09-09 05:57:42'),
(1393, 275, 'E - 055 Dt', 35, 'K', '-', '1607457', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:11:37', '2020-09-09 05:57:42'),
(1394, 276, 'E - 056 Dt', 10, 'DRAGONMED', '-', 'AP12583', 1, 1, '-', '250 uL', NULL, 'Laik Pakai', 1, '2020-08-24 08:18:21', '2020-08-28 02:32:02'),
(1395, 276, 'E - 056 Dt', 10, 'dragonlab', '-', 'FP40489', 1, 1, '-', '1000 uL', NULL, 'Tidak Laik Pakai', 1, '2020-08-24 08:21:15', '2020-08-28 02:21:56'),
(1396, 276, 'E - 056 Dt', 10, 'HUAWEI', '-', '12120448', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2020-08-24 08:23:04', '2020-08-28 02:21:56'),
(1397, 276, 'E - 056 Dt', 59, 'CHEST', '-', '1131330', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:24:16', '2020-08-28 02:21:56'),
(1398, 276, 'E - 056 Dt', 57, 'ABN', 'SPECTRUM', '896616', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:26:03', '2020-08-28 02:21:56'),
(1399, 276, 'E - 056 Dt', 35, 'KUBOTA', '3300', 'RG 0602 - F000', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:26:50', '2020-08-28 02:21:56'),
(1400, 276, 'E - 056 Dt', 42, 'BTL', '-', '017D0B007591', 1, 1, '-', 'Tidak ada kertas', NULL, 'Laik Pakai', 1, '2020-08-24 08:27:43', '2020-09-09 05:58:44'),
(1401, 276, 'E - 056 Dt', 42, 'Cardimax', '-', '21057935', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:28:12', '2020-08-27 04:26:20'),
(1402, 277, 'E - 057 Dt', 42, 'BLT', 'E30', 'E066E003559', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:31:32', '2020-08-28 02:19:34'),
(1403, 277, 'E - 057 Dt', 35, 'WapLab', '-', 'LS16BA0000050', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:32:16', '2020-08-28 02:19:34'),
(1404, 277, 'E - 057 Dt', 42, 'FUKUDA DENSHI', '-', '21057938', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:32:52', '2020-08-28 02:19:34'),
(1405, 277, 'E - 057 Dt', 42, 'BLT', 'E30', 'E066E004694', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-24 08:32:59', '2020-08-28 02:19:34'),
(1406, 278, 'E - 058 Dt', 30, 'Resonance', '-', 'R27A17D000526', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-25 05:26:40', '2020-08-28 02:17:09'),
(1407, 278, 'E - 058 Dt', 55, 'JZIKI', 'JZK-301', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-25 05:27:13', '2020-08-28 02:17:09'),
(1408, 278, 'E - 058 Dt', 57, 'ABN', 'SPECTRUM', '00063447', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-25 05:27:35', '2020-08-28 02:17:09'),
(1409, 278, 'E - 058 Dt', 57, 'ABN', 'SPECTRUM', '144141', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-25 05:27:37', '2020-08-28 02:17:09'),
(1410, 278, 'E - 058 Dt', 37, 'LIFEPOINT', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-25 05:38:52', '2020-08-28 02:17:09'),
(1411, 281, 'E - 059 Dt', 59, 'CHEST', '-', '1132528', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-25 05:40:48', '2020-08-28 02:20:31'),
(1412, 281, 'E - 059 Dt', 21, 'OMRON', 'NE-C29', '20171000625UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-25 05:41:35', '2020-08-28 02:20:31'),
(1413, 281, 'E - 059 Dt', 59, 'CHEST', '-', '1136568', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-25 05:41:41', '2020-08-28 02:20:31'),
(1414, 281, 'E - 059 Dt', 55, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-25 05:42:35', '2020-08-28 02:20:31'),
(1415, 282, 'E - 060 Dt', 59, 'Minato', '-', '-', 1, 1, 'kabel power, pipa spiro, kabel spiro', 'belum dicek', NULL, 'Laik Pakai', 1, '2020-08-26 03:00:27', '2020-08-28 08:57:39'),
(1416, 282, 'E - 060 Dt', 42, 'Fukuda Denshi', 'FCP-7101', '-', 1, 1, '-', 'kabel power, elektroda, plat, balon', NULL, 'Laik Pakai', 1, '2020-08-26 03:01:26', '2020-08-28 08:57:39'),
(1417, 282, 'E - 060 Dt', 57, 'Riester', '-', '180560472', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-26 03:02:03', '2020-08-28 08:57:39'),
(1419, 282, 'E - 060 Dt', 57, 'Riester', '-', '160562728', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-26 03:02:10', '2020-08-28 08:57:39'),
(1420, 283, 'E - 061 Dt', 19, 'Onemed', 'OLP-2', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-28 07:16:53', '2020-09-03 05:58:02'),
(1421, 283, 'E - 061 Dt', 19, 'Onemed', 'OLP-2', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-08-28 07:16:54', '2020-09-03 05:58:02'),
(1422, 283, 'E - 061 Dt', 21, 'MEDIX', 'AC 4000', '-', 1, 1, 'Kotak, Tas, Mouthpiece', 'Tabung obat tidak berfungsi', NULL, 'Laik Pakai', 1, '2020-08-28 07:17:44', '2020-09-03 05:58:02'),
(1423, 283, 'E - 061 Dt', 34, 'Omron', 'HEM-7130', '20151102800VG', 1, 1, 'Baterai 5, tas, manset', '-', NULL, 'Laik Pakai', 1, '2020-08-28 07:17:47', '2020-09-03 05:58:02'),
(1424, 283, 'E - 061 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A1207', 1, 1, 'Manset', '-', NULL, 'Laik Pakai', 1, '2020-08-28 07:19:29', '2020-09-03 05:58:02'),
(1425, 283, 'E - 061 Dt', 21, 'Omron', 'CompAIR-Pro', '20150500483UF', 1, 1, 'Kotak, Mouthpiece', '-', NULL, 'Laik Pakai', 1, '2020-08-28 07:27:34', '2020-09-03 05:58:02'),
(1426, 284, 'E - 062 Dt', 9, '-', '-', '-', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-08-31 01:58:03', '2020-08-31 03:42:19'),
(1427, 285, 'E - 063 Dt', 42, 'BTL', 'BTL-08 SD ECG', '071D0B00728', 1, 1, 'Kabel Power, Kabel Printer, Lead ECG', 'Tidak Terdapat Kertas', NULL, 'Laik Pakai', 1, '2020-09-01 08:12:22', '2020-09-09 05:55:24'),
(1428, 286, 'E - 064 Dt', 42, 'CARDIMAX', 'FX - 7102', '22038913', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-04 08:50:43', '2020-09-08 03:09:19'),
(1429, 287, 'E - 065 Dt', 42, 'Schiller', 'AT-1', '190 - 56186', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-07 08:20:49', '2020-09-17 04:51:44'),
(1430, 295, 'E - 073 Dt', 59, 'Sibelmed', 'DATOSPIR TOUCH EASY - T', '11B - A783', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 06:54:41', '2020-09-11 09:25:00'),
(1431, 295, 'E - 073 Dt', 30, 'Sibelmed', 'SIBELSOUND 400', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 06:55:25', '2020-09-11 09:25:00'),
(1432, 288, 'E - 066 Dt', 57, 'ABN', 'SPECTRUM', '838336', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 07:46:34', '2020-10-14 03:44:19'),
(1433, 288, 'E - 066 Dt', 57, 'ABN', 'SPECTRUM', '877244', 1, 1, '-', 'Tanpa tas', NULL, 'Laik Pakai', 1, '2020-09-09 07:46:35', '2020-10-14 03:44:19'),
(1434, 288, 'E - 066 Dt', 57, 'ABN', 'PRECISION', '940644', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 07:52:06', '2020-10-14 03:44:19'),
(1435, 288, 'E - 066 Dt', 41, 'ENDO', 'SONOTRAX', '560042-M18C00170013', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 07:52:58', '2020-10-14 03:44:19'),
(1436, 288, 'E - 066 Dt', 41, 'BISTOS', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 07:53:17', '2020-10-14 03:44:19'),
(1437, 288, 'E - 066 Dt', 41, 'ENDO', 'SONOTRAX', '560042-M18C00170012', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 07:53:44', '2020-10-14 03:44:19'),
(1438, 295, 'E - 073 Dt', 57, 'ABN', 'SPECTRUM', '00227482', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 07:54:47', '2020-09-11 09:25:00'),
(1440, 295, 'E - 073 Dt', 57, 'ABN', 'SPECTRUM', '00067929', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 07:54:54', '2020-09-11 09:25:00'),
(1441, 295, 'E - 073 Dt', 57, 'ABN', 'SPECTRUM', '00225848', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 07:54:55', '2020-09-11 09:25:00'),
(1442, 288, 'E - 066 Dt', 57, 'ABN', 'SPECTRUM', '967601', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 07:58:46', '2020-10-14 03:44:19'),
(1443, 289, 'E - 067 Dt', 57, 'GEA', '-', '051016', 1, 1, '-', 'Manset bocor', NULL, 'Laik Pakai', 1, '2020-09-09 08:00:51', '2020-10-14 03:44:49'),
(1444, 289, 'E - 067 Dt', 57, 'ABN', 'PRECISION', '986938', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:00:52', '2020-10-14 03:44:49'),
(1445, 289, 'E - 067 Dt', 57, 'ABN', 'PRECISION', '986993', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:01:23', '2020-10-14 03:44:49'),
(1446, 290, 'E - 068 Dt', 41, 'BISTOS', 'BT-200', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:04:21', '2020-10-14 03:45:36'),
(1447, 290, 'E - 068 Dt', 57, 'ONEMED', '-', '1441799', 1, 1, '-', 'Manset Bocor', NULL, 'Laik Pakai', 1, '2020-09-09 08:05:01', '2020-10-14 03:45:36'),
(1448, 290, 'E - 068 Dt', 57, 'ABN', 'PRECISION', '987234', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:05:18', '2020-10-14 03:45:36'),
(1449, 290, 'E - 068 Dt', 57, 'ONEMED', '-', '166414', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:05:57', '2020-10-14 03:45:36'),
(1450, 290, 'E - 068 Dt', 57, 'ABN', 'PRECISION', '987016', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:06:22', '2020-10-14 03:45:36'),
(1451, 290, 'E - 068 Dt', 57, 'ABN', 'PRECISION', '986986', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:06:53', '2020-10-14 03:45:36');
INSERT INTO `lab_detail_order` (`id`, `id_order`, `no_order`, `alat_id`, `merek`, `model`, `seri`, `jumlah`, `fungsi`, `kelengkapan`, `keterangan`, `no_registrasi`, `catatan`, `ambil`, `created_at`, `updated_at`) VALUES
(1452, 290, 'E - 068 Dt', 57, 'ABN', 'PRECISION', '986988', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:07:07', '2020-10-14 03:45:36'),
(1453, 291, 'E - 069 Dt', 41, 'SERENITY', 'SR-100', '8031SR10009343', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:08:46', '2020-10-14 03:46:07'),
(1454, 291, 'E - 069 Dt', 57, 'ABN', 'PRECISION', '986962', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:09:42', '2020-10-14 03:46:07'),
(1455, 291, 'E - 069 Dt', 57, 'ABN', 'PRECISION', '986975', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:09:45', '2020-10-14 03:46:07'),
(1456, 292, 'E - 070 Dt', 41, 'BISTOS', 'BT-200', 'BABD11904', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:11:32', '2020-10-14 03:46:33'),
(1457, 292, 'E - 070 Dt', 41, 'JUMPER', 'UPD-100B+', '8330100B+02331', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:11:34', '2020-10-14 03:46:33'),
(1458, 292, 'E - 070 Dt', 57, 'ABN', 'SPECTRUM', '742791', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:13:23', '2020-10-14 03:46:33'),
(1459, 292, 'E - 070 Dt', 57, 'ABN', 'SPECTRUM', '145065', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:13:25', '2020-10-14 03:46:33'),
(1460, 292, 'E - 070 Dt', 34, 'CA.MI', 'MY PRESSURE', '017403', 1, 1, '-', '-', NULL, NULL, 1, '2020-09-09 08:13:52', '2020-10-14 03:46:33'),
(1461, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987236', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:15:44', '2020-10-14 03:47:04'),
(1462, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '986982', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:15:45', '2020-10-14 03:47:04'),
(1463, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987213', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:15:55', '2020-10-14 03:47:04'),
(1464, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '986998', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:16:07', '2020-10-14 03:47:04'),
(1465, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987183', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:16:23', '2020-10-14 03:47:04'),
(1466, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '986984', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:16:34', '2020-10-14 03:47:04'),
(1467, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987015', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:16:47', '2020-10-14 03:47:04'),
(1468, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987248', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:17:00', '2020-10-14 03:47:04'),
(1469, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '986992', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:17:26', '2020-10-14 03:47:04'),
(1470, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987160', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:17:54', '2020-10-14 03:47:04'),
(1471, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987244', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:18:14', '2020-10-14 03:47:04'),
(1472, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987011', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:18:25', '2020-10-14 03:47:04'),
(1473, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987035', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:18:44', '2020-10-14 03:47:04'),
(1474, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '986963', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:19:03', '2020-10-14 03:47:04'),
(1475, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '987018', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:19:20', '2020-10-14 03:47:04'),
(1476, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '986966', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:19:36', '2020-10-14 03:47:04'),
(1477, 293, 'E - 071 Dt', 57, 'ABN', 'PRECISION', '986985', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:21:32', '2020-10-14 03:47:04'),
(1478, 294, 'E - 072 Dt', 41, 'BISTOS', 'BT-200', 'BABA42117', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:22:51', '2020-09-23 03:32:28'),
(1479, 294, 'E - 072 Dt', 41, 'ULTRATEC', 'PD1+', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:22:54', '2020-09-23 03:32:28'),
(1480, 294, 'E - 072 Dt', 34, 'ELITECH', 'TENSIONE', 'BP1182A0879', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:23:47', '2020-09-23 03:32:28'),
(1481, 294, 'E - 072 Dt', 34, 'OMRON', 'JPN600', '20190601974 BF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-09 08:23:49', '2020-09-23 03:32:28'),
(1482, 296, 'E - 074 Dt', 41, 'Elitech', 'SONOTRAX B', 'FD2188A0285', 1, 1, 'Kotak, Headset, Baterai, Gel', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:30:17', '2020-09-24 06:40:18'),
(1483, 296, 'E - 074 Dt', 41, 'Elitech', 'SONOTRAX B', 'FD2188A0066', 1, 1, 'Kotak, Headset, Baterai, Gel', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:30:19', '2020-09-24 06:40:18'),
(1484, 296, 'E - 074 Dt', 41, 'Elitech', 'SONOTRAX B', 'FD2188A0281', 1, 1, 'Kotak, Headset, Baterai, Gel', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:30:27', '2020-09-24 06:40:18'),
(1485, 296, 'E - 074 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A1060', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:32:53', '2020-09-24 06:40:18'),
(1486, 296, 'E - 074 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A1289', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:32:55', '2020-09-24 06:40:18'),
(1487, 296, 'E - 074 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A1033', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:33:05', '2020-09-24 06:40:18'),
(1488, 296, 'E - 074 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A1059', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:33:16', '2020-09-24 06:40:18'),
(1489, 296, 'E - 074 Dt', 41, 'Elitech', 'SONOTRAX PRO', 'FD04191A0086', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:33:27', '2020-09-24 06:40:18'),
(1490, 296, 'E - 074 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A0894', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:33:44', '2020-09-24 06:40:18'),
(1491, 296, 'E - 074 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A0843', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:34:06', '2020-09-24 06:40:18'),
(1492, 298, 'E - 076 Dt', 35, 'K', 'PLC-03', '707850', 1, 1, 'Kabel Power', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:44:35', '2020-09-23 03:18:25'),
(1493, 298, 'E - 076 Dt', 34, 'OMRON', 'HEM - 8712', '20200329627VG', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:46:11', '2020-09-23 03:18:25'),
(1494, 298, 'E - 076 Dt', 34, 'OMRON', 'HEM - 8712', '20200329628VG', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:46:14', '2020-09-23 03:18:25'),
(1495, 298, 'E - 076 Dt', 34, 'OMRON', 'HEM - 8712', '20200329624VG', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:46:25', '2020-09-23 03:18:25'),
(1496, 298, 'E - 076 Dt', 34, 'OMRON', 'HEM - 8712', '20200329623VG', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:46:34', '2020-09-23 03:18:25'),
(1497, 298, 'E - 076 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A1279', 1, 1, 'Kotak, Charger', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:47:30', '2020-09-23 03:18:25'),
(1498, 298, 'E - 076 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A1035', 1, 1, 'Kotak, Charger', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:47:34', '2020-09-23 03:18:25'),
(1499, 298, 'E - 076 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A0836', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-10 08:47:48', '2020-09-23 03:18:25'),
(1500, 298, 'E - 076 Dt', 10, 'eppendorf', 'Research', '2326299', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2020-09-10 08:50:09', '2020-09-23 03:18:25'),
(1501, 298, 'E - 076 Dt', 10, 'eppendorf', 'Research', '2323679', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2020-09-10 08:50:25', '2020-09-23 03:18:25'),
(1502, 298, 'E - 076 Dt', 10, 'eppendorf', 'Research', '2515039', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2020-09-10 08:50:48', '2020-09-23 03:18:25'),
(1503, 298, 'E - 076 Dt', 10, 'SOCOREX', 'ACURA 815', '16101235', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2020-09-10 08:51:39', '2020-09-23 03:18:25'),
(1504, 298, 'E - 076 Dt', 12, 'SOCOREX', 'ACURA 825', '15113360', 1, 1, '-', '0.5 - 10 uL', NULL, 'Laik Pakai', 1, '2020-09-10 08:52:22', '2020-09-23 03:18:25'),
(1505, 298, 'E - 076 Dt', 12, 'SOCOREX', 'ACURA 825', '16121421', 1, 1, '-', '5 - 50 uL', NULL, 'Tidak Laik Pakai', 1, '2020-09-10 08:52:25', '2020-09-23 03:22:00'),
(1506, 288, 'E - 066 Dt', 57, 'ABN', 'PRECISION', '940661', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-11 00:32:38', '2020-10-14 03:44:19'),
(1507, 288, 'E - 066 Dt', 34, 'Kenko', 'BF1112', '18050226594', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-11 00:33:30', '2020-10-14 03:44:19'),
(1508, 288, 'E - 066 Dt', 34, 'OMRON', '1A2(HEM-7011-C1)', '20090300748LF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-11 00:33:32', '2020-10-14 03:44:19'),
(1509, 297, 'E - 075 Dt', 10, 'eppendorf', 'Research', '2366497', 1, 1, '-', '250 uL', NULL, 'Laik Pakai', 1, '2020-09-14 08:32:17', '2020-09-24 00:46:45'),
(1510, 297, 'E - 075 Dt', 10, 'eppendorf', 'Research', '4083278', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2020-09-14 08:32:19', '2020-09-24 00:45:37'),
(1511, 297, 'E - 075 Dt', 10, 'eppendorf', 'Research', '2515349', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2020-09-14 08:32:42', '2020-09-24 00:45:37'),
(1512, 297, 'E - 075 Dt', 10, 'eppendorf', 'Research', '2323649', 1, 1, '-', '100 uL', NULL, 'Laik Pakai', 1, '2020-09-14 08:32:57', '2020-09-24 00:45:37'),
(1513, 297, 'E - 075 Dt', 10, 'eppendorf', 'Reference', 'N1886 B', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2020-09-14 08:33:28', '2020-09-24 00:45:37'),
(1514, 297, 'E - 075 Dt', 10, 'eppendorf', 'Reference', '1605058', 1, 1, '-', '25 uL', NULL, 'Laik Pakai', 1, '2020-09-14 08:34:01', '2020-09-24 00:45:37'),
(1515, 297, 'E - 075 Dt', 10, 'eppendorf', 'Reference', 'N12184C', 1, 1, '-', '50 uL', NULL, 'Laik Pakai', 1, '2020-09-14 08:34:22', '2020-09-24 00:45:37'),
(1516, 297, 'E - 075 Dt', 10, 'HT', 'CLINIPET', '422088286', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2020-09-14 08:35:19', '2020-09-24 00:45:37'),
(1517, 297, 'E - 075 Dt', 10, 'ONEMED', 'DRAGONONEMED', 'YL188AH0021688', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2020-09-14 08:36:45', '2020-09-24 00:45:37'),
(1518, 297, 'E - 075 Dt', 21, 'OMRON', 'NE-C28', '20170407848UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:37:16', '2020-09-24 00:45:37'),
(1519, 297, 'E - 075 Dt', 41, 'Elitech', 'SONOTRAX', 'FD1302300226', 1, 1, 'Kotak', '-', NULL, 'Tidak Laik Pakai', 1, '2020-09-14 08:39:26', '2020-09-24 02:41:34'),
(1520, 297, 'E - 075 Dt', 41, 'Elitech', 'SONOTRAX', 'FD2164A0660', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:39:29', '2020-09-24 00:45:37'),
(1521, 297, 'E - 075 Dt', 41, 'Elitech', 'SONOTRAX B', 'FD2164A1218', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:39:45', '2020-09-24 00:45:37'),
(1522, 297, 'E - 075 Dt', 34, 'Dr. Care', 'HL888', '1611082346', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:40:45', '2020-09-24 00:45:37'),
(1523, 297, 'E - 075 Dt', 34, 'yuwell', 'YE660B', 'B202003502', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:41:09', '2020-09-24 00:45:37'),
(1524, 297, 'E - 075 Dt', 34, 'kenko', 'BF-1112', '18050224276', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:41:34', '2020-09-24 00:45:37'),
(1525, 297, 'E - 075 Dt', 51, 'K', 'VRN-360', '1203670', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:41:56', '2020-09-24 00:45:37'),
(1526, 297, 'E - 075 Dt', 55, 'elitech', 'FOX-3', 'FX314CA0070', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:42:23', '2020-09-24 00:45:37'),
(1527, 297, 'E - 075 Dt', 55, 'beurer', 'PO.30', 'A41/004359', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:42:59', '2020-09-24 00:45:37'),
(1528, 297, 'E - 075 Dt', 35, 'eppendorf', 'minispin', '5452YK249076', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:44:03', '2020-09-24 00:45:37'),
(1529, 297, 'E - 075 Dt', 35, 'K', 'PLC-05', '1612440', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:44:22', '2020-09-24 00:45:37'),
(1530, 297, 'E - 075 Dt', 21, 'LAICA', 'MD6026', '1512 0002066', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:45:54', '2020-09-24 00:45:37'),
(1531, 297, 'E - 075 Dt', 21, 'LAICA', 'MD6026', '1512 002072', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:46:02', '2020-09-24 00:45:37'),
(1532, 297, 'E - 075 Dt', 42, 'Elitech', 'ECG1200G', 'EM3191A0026', 1, 1, 'Kotak, Lead, Bulb, Capit, Kabel Power', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:49:57', '2020-09-24 00:45:37'),
(1533, 297, 'E - 075 Dt', 55, 'COVIDIEN', 'Nellcor', '-', 1, 1, 'Finger Sensor', '-', NULL, 'Laik Pakai', 1, '2020-09-14 08:52:17', '2020-09-24 00:45:37'),
(1534, 296, 'E - 074 Dt', 34, 'Elitech', 'TENSIONE', 'BP1182A0839', 1, 1, 'Kotak', '-', NULL, 'Laik Pakai', 1, '2020-09-16 00:42:07', '2020-09-24 06:40:18'),
(1535, 299, 'E - 077 Dt', 55, '-', 'JZK-01', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 0, '2020-09-18 07:25:22', '2020-09-24 06:15:52'),
(1536, 300, 'E - 078 Dt', 42, 'Mindray', 'BeneHeart R3', 'FK-69009298', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-21 06:49:31', '2020-09-24 05:28:25'),
(1537, 300, 'E - 078 Dt', 34, 'OMRON', 'HEM-7120-L', '20171104092VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-21 06:50:59', '2020-09-24 05:28:25'),
(1538, 300, 'E - 078 Dt', 59, 'MIR', 'SPIROBANK II', 'A23-0Y. 03551', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-21 06:51:34', '2020-09-24 05:28:25'),
(1539, 301, 'E - 079 Dt', 42, 'Bionet', 'Cardio7', 'T701100254', 1, 1, 'Kotak, Patient Cable, Kabel Power, dll', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:22:15', '2020-09-29 05:47:40'),
(1540, 302, 'E - 080 Dt', 34, 'Omron', 'HEM-7203', '20141102332VG', 1, 1, 'Manset', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:25:59', '2020-10-02 06:02:22'),
(1541, 302, 'E - 080 Dt', 2, 'Beurer', 'FT 09/1', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:26:29', '2020-10-02 06:02:22'),
(1542, 303, 'E - 081 Dt', 19, 'GEA', 'KD-201B', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:30:12', '2020-10-06 02:53:18'),
(1543, 303, 'E - 081 Dt', 41, 'bistos', 'BT-220', 'BFEB1230', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:30:33', '2020-10-06 02:53:18'),
(1544, 303, 'E - 081 Dt', 41, 'Elitech', 'SONOTRAX B', 'FD2164A1161', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:31:04', '2020-10-06 02:53:18'),
(1545, 303, 'E - 081 Dt', 41, 'Elitech', 'SONOTRAX B', 'FD2129D1021', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:31:07', '2020-10-06 02:53:18'),
(1546, 303, 'E - 081 Dt', 41, 'Elitech', 'SONOTRAX B', 'FD2164A1114', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:31:21', '2020-10-06 02:53:18'),
(1547, 303, 'E - 081 Dt', 41, 'Elitech', 'SONOTRAX B', 'FD2164A1116', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:31:32', '2020-10-06 02:53:18'),
(1548, 303, 'E - 081 Dt', 21, 'Omron', 'NE-C29', '20140800384UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:32:10', '2020-10-06 02:53:18'),
(1549, 303, 'E - 081 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:32:31', '2020-10-06 02:53:18'),
(1550, 303, 'E - 081 Dt', 57, 'ERKA', '-', '1802501', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:32:50', '2020-10-06 02:53:18'),
(1551, 303, 'E - 081 Dt', 57, 'ERKA', '-', '17032374', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:33:17', '2020-10-06 02:53:18'),
(1552, 303, 'E - 081 Dt', 57, 'ERKA', '-', '17038859', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:33:20', '2020-10-06 02:53:18'),
(1553, 303, 'E - 081 Dt', 57, 'ERKA', '-', '18025104', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:33:33', '2020-10-06 02:53:18'),
(1554, 303, 'E - 081 Dt', 57, 'ONEMED', '-', '1268657', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:35:50', '2020-10-06 02:53:18'),
(1555, 303, 'E - 081 Dt', 57, 'ERKA', '-', '12031531', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2020-09-28 07:35:57', '2020-10-06 02:53:18'),
(1556, 303, 'E - 081 Dt', 57, 'AND', 'UM-101', '5160901811', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:36:41', '2020-10-06 02:53:18'),
(1557, 303, 'E - 081 Dt', 55, 'Elitech', 'FOX-3', 'FX317AA0098', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:37:10', '2020-10-06 02:53:18'),
(1558, 303, 'E - 081 Dt', 57, 'ERKA', '-', '18400667', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:37:31', '2020-10-06 02:53:18'),
(1559, 303, 'E - 081 Dt', 42, 'Bionet', 'Cardiocare', 'T7Q0300043', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 07:38:04', '2020-10-06 02:53:18'),
(1560, 303, 'E - 081 Dt', 12, 'eppendorf', 'reference', '1295638', 1, 1, '-', '20 - 200 uL', NULL, 'Tidak Laik Pakai', 1, '2020-09-28 07:39:09', '2020-10-06 02:53:18'),
(1561, 304, 'E - 087 Dt', 42, '-', '-', 'F1182E0165', 1, 1, 'Power, Patient dkk', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:08:09', '2020-10-02 02:55:42'),
(1562, 304, 'E - 087 Dt', 21, 'Omron', 'NE-C28', '20110606227UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:08:44', '2020-10-02 02:55:42'),
(1563, 304, 'E - 087 Dt', 21, 'Omron', 'NE-C28', '20140808288UF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:08:46', '2020-10-02 02:55:42'),
(1564, 304, 'E - 087 Dt', 55, 'Nonin', 'Pulse Oxymeter 8500', '500856891', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:15:37', '2020-10-02 02:55:42'),
(1565, 304, 'E - 087 Dt', 55, 'Ohmeda', 'Tuffsat', 'FCB09480030SA', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:15:43', '2020-10-02 02:55:42'),
(1566, 304, 'E - 087 Dt', 57, 'ABN', '-', '940528', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:17:19', '2020-10-02 02:55:42'),
(1567, 304, 'E - 087 Dt', 57, 'ABN', '-', '080302', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:17:22', '2020-10-02 02:55:42'),
(1568, 304, 'E - 087 Dt', 57, 'ABN', '-', '824895', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:17:35', '2020-10-02 02:55:42'),
(1569, 304, 'E - 087 Dt', 26, 'JHAL', 'JX820Z', '101.B2.008', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:18:28', '2020-10-02 02:55:42'),
(1570, 304, 'E - 087 Dt', 1, 'GEA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-28 08:18:58', '2020-10-02 02:55:42'),
(1571, 305, 'E - 082 Dt', 9, 'YAMAMOTO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:25:07', '2020-10-15 07:57:45'),
(1572, 306, 'E - 083 Dt', 35, 'Hettich', 'EBA 200', '0017415-04', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:29:55', '2020-10-15 07:58:04'),
(1573, 307, 'E - 084 Dt', 57, 'ABN', 'SPECTRUM', '00058739', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:39:37', '2020-10-15 07:58:20'),
(1575, 307, 'E - 084 Dt', 57, 'ABN', 'SPECTRUM', '00056830', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:40:10', '2020-10-15 07:58:20'),
(1576, 307, 'E - 084 Dt', 57, 'ABN', '-', '323805', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:40:25', '2020-10-15 07:58:20'),
(1577, 307, 'E - 084 Dt', 57, 'Serenity', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:40:56', '2020-10-15 07:58:20'),
(1578, 307, 'E - 084 Dt', 57, 'Serenity', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:41:10', '2020-10-15 07:58:20'),
(1579, 307, 'E - 084 Dt', 57, 'ABN', '-', '323607', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:41:11', '2020-10-15 07:58:20'),
(1580, 307, 'E - 084 Dt', 57, 'Serenity', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:41:20', '2020-10-15 07:58:20'),
(1581, 307, 'E - 084 Dt', 34, 'MICROLIFE', 'BPA200', '10180677', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:42:53', '2020-10-15 07:58:20'),
(1582, 307, 'E - 084 Dt', 34, 'MICROLIFE', 'BPA200', '1018006', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:42:57', '2020-10-15 07:58:20'),
(1583, 307, 'E - 084 Dt', 34, 'MICROLIFE', 'BPA200', '15160541', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:43:19', '2020-10-15 07:58:20'),
(1584, 307, 'E - 084 Dt', 41, 'BISTOS', 'BT-200L', 'BBH80350', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:45:07', '2020-10-15 07:58:20'),
(1585, 307, 'E - 084 Dt', 41, 'TRISMED', 'DP6000', '18030500135', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:45:09', '2020-10-15 07:58:20'),
(1586, 307, 'E - 084 Dt', 10, 'EPPENDORF', 'REFERANCE 2', 'H26640G', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:47:40', '2020-10-15 07:58:20'),
(1587, 307, 'E - 084 Dt', 10, 'DRAGONONEMED', '-', 'YL6F145032', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2020-09-29 08:47:45', '2020-10-15 07:58:20'),
(1588, 307, 'E - 084 Dt', 10, 'EPPENDORF', 'REFERANCE 2', 'H26574G', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:48:06', '2020-10-15 07:58:20'),
(1589, 307, 'E - 084 Dt', 10, 'EPPENDORF', 'REFERANCE 2', 'R10611F', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2020-09-29 08:48:33', '2020-10-15 07:58:20'),
(1590, 307, 'E - 084 Dt', 10, 'EPPENDORF', 'REFERANCE 2', '528876', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2020-09-29 08:48:59', '2020-10-15 07:58:20'),
(1592, 307, 'E - 084 Dt', 10, 'DRAGONONEMED', '-', 'YL5F129875', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2020-09-29 08:50:58', '2020-10-15 07:58:20'),
(1593, 307, 'E - 084 Dt', 42, 'LABTECH', 'EC3T', 'E170523633', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:52:00', '2020-10-15 07:58:20'),
(1594, 307, 'E - 084 Dt', 19, 'KARIXA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:55:09', '2020-10-15 07:58:20'),
(1595, 307, 'E - 084 Dt', 19, 'KARIXA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:55:13', '2020-10-15 07:58:20'),
(1596, 307, 'E - 084 Dt', 21, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:55:55', '2020-10-15 07:58:20'),
(1597, 307, 'E - 084 Dt', 21, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:56:00', '2020-10-15 07:58:20'),
(1598, 307, 'E - 084 Dt', 26, 'DIXION', 'VACUS 7018', '07|01|1805|3810', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 08:57:36', '2020-10-15 07:58:20'),
(1599, 307, 'E - 084 Dt', 37, 'bexencardio', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 09:00:50', '2020-10-15 07:58:20'),
(1602, 307, 'E - 084 Dt', 9, 'elitech', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-09-29 09:01:54', '2020-10-15 07:58:20'),
(1603, 307, 'E - 084 Dt', 13, '-', '-', '-', 1, 1, '-', 'belum dicek', NULL, 'Tidak Laik Pakai', 1, '2020-09-29 09:02:18', '2020-10-15 07:58:20'),
(1604, 308, 'E - 085 Dt', 34, 'OMRON', 'HEM-7200', '20151102828A3', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 03:29:55', '2020-10-15 08:01:03'),
(1605, 308, 'E - 085 Dt', 9, 'KENKO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 03:30:17', '2020-10-15 08:01:03'),
(1606, 309, 'E - 086 Dt', 9, 'KENKO', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 03:35:06', '2020-10-15 08:01:14'),
(1607, 309, 'E - 086 Dt', 21, 'ABN', 'COMPAMIST', '1533557A', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 03:35:35', '2020-10-15 08:01:14'),
(1608, 309, 'E - 086 Dt', 41, 'BISTOS', 'HI-BEBE S', 'BFJ10047', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 03:36:11', '2020-10-15 08:01:14'),
(1609, 309, 'E - 086 Dt', 19, 'KARIXA', 'NT-50 HSS', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 03:36:48', '2020-10-15 08:01:14'),
(1610, 309, 'E - 086 Dt', 35, 'DOCTOR KINGDOM', 'DKG-100GT', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 03:37:22', '2020-10-15 08:01:14'),
(1611, 309, 'E - 086 Dt', 57, 'ONEMED', '-', '1533281', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 03:37:49', '2020-10-15 08:01:14'),
(1612, 310, 'E - 088 Dt', 57, 'ONEMED', '-', '1528052', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 05:59:21', '2020-10-15 08:03:15'),
(1613, 310, 'E - 088 Dt', 57, 'SERENITY', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 05:59:24', '2020-10-15 08:03:15'),
(1614, 310, 'E - 088 Dt', 9, '-', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 06:01:31', '2020-10-15 08:03:15'),
(1615, 310, 'E - 088 Dt', 34, 'MICROLIFE', 'AFIB', '15160814', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 06:06:31', '2020-10-15 08:03:15'),
(1616, 310, 'E - 088 Dt', 55, '-', 'OYK-80C', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 06:07:09', '2020-10-15 08:03:15'),
(1617, 310, 'E - 088 Dt', 21, 'LAICA', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 06:08:53', '2020-10-15 08:03:15'),
(1618, 310, 'E - 088 Dt', 35, 'Hettich', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 06:10:53', '2020-10-15 08:03:15'),
(1619, 310, 'E - 088 Dt', 26, 'power smile', 'KS-700', '0710022', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 06:14:55', '2020-10-15 08:03:15'),
(1620, 311, 'E - 089 Dt', 21, 'OMRON', 'NE-U780', '20170900268AF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 06:50:26', '2020-10-15 08:03:28'),
(1621, 311, 'E - 089 Dt', 41, 'vcomin', 'fd-300c', 'f300c019009989', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 06:51:03', '2020-10-15 08:03:28'),
(1622, 311, 'E - 089 Dt', 35, 'Hettich', 'eba-300', '0017402-04', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 06:55:13', '2020-10-15 08:03:28'),
(1623, 311, 'E - 089 Dt', 10, 'EPPENDORF', 'REFERENCE', 'H26647G', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2020-10-01 06:58:51', '2020-10-15 08:03:28'),
(1624, 311, 'E - 089 Dt', 12, 'socorex', 'acura 825', '19121126', 1, 1, '-', '5-50 uL', NULL, 'Laik Pakai', 1, '2020-10-01 06:59:13', '2020-10-15 08:03:28'),
(1625, 311, 'E - 089 Dt', 12, 'ONEMED', 'DRAGON', 'DR73647', 1, 1, '-', '5-50 uL', NULL, 'Laik Pakai', 1, '2020-10-01 07:00:02', '2020-10-15 08:03:28'),
(1626, 311, 'E - 089 Dt', 12, 'HUAWEI', '-', '-', 1, 1, '-', '10-1000 uL', NULL, 'Laik Pakai', 1, '2020-10-01 07:01:25', '2020-10-15 08:03:28'),
(1627, 311, 'E - 089 Dt', 10, 'HTL CLINIPET', '-', '922540214', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2020-10-01 07:02:01', '2020-10-15 08:03:28'),
(1628, 311, 'E - 089 Dt', 10, 'EPPENDORF', 'REFERENCE 2', 'I122096', 1, 1, '-', '50 uL', NULL, 'Laik Pakai', 1, '2020-10-01 07:08:50', '2020-10-15 08:03:28'),
(1629, 311, 'E - 089 Dt', 10, 'EPPENDORF', 'REFERENCE 2', 'R10571R', 1, 1, '-', '5 uL', NULL, 'Laik Pakai', 1, '2020-10-01 07:09:42', '2020-10-15 08:03:28'),
(1630, 311, 'E - 089 Dt', 10, 'EPPENDORF', 'REFERENCE 2', 'L529436', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2020-10-01 07:10:15', '2020-10-15 08:03:28'),
(1631, 312, 'E - 090 Dt', 26, 'GENERAL CARE', 'PHLEGM SUCTION 7E-Q1', '2018040489', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:18:07', '2020-10-15 08:03:42'),
(1632, 312, 'E - 090 Dt', 57, 'GENERAL CARE', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:18:25', '2020-10-15 08:03:42'),
(1633, 312, 'E - 090 Dt', 34, 'OMRON', 'HEM-8712', '20180905663VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:18:58', '2020-10-15 08:03:42'),
(1634, 313, 'E - 091 Dt', 10, 'eppendorf', 'reference 2', '152942G', 1, 1, '-', '10 uL', NULL, 'Laik Pakai', 1, '2020-10-01 07:22:44', '2020-10-15 08:03:54'),
(1635, 313, 'E - 091 Dt', 12, 'DRAGONONEMED', '-', 'YL6A184949', 1, 1, '-', '10-100 uL', NULL, 'Laik Pakai', 1, '2020-10-01 07:23:33', '2020-10-15 08:03:54'),
(1636, 313, 'E - 091 Dt', 35, 'HETTICH', 'EBA 200', '001745-04', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:24:08', '2020-10-15 08:03:54'),
(1637, 313, 'E - 091 Dt', 9, 'YAMAMOTO GIKEN', 'yb-77', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:24:44', '2020-10-15 08:03:54'),
(1638, 313, 'E - 091 Dt', 42, 'innomed', 'hs80g-l', '14232077-U', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:25:30', '2020-10-15 08:03:54'),
(1639, 313, 'E - 091 Dt', 21, 'YUWUI', '403K', '00022', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:26:01', '2020-10-15 08:03:54'),
(1640, 313, 'E - 091 Dt', 57, 'KENZ', 'NO 542', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:32:52', '2020-10-15 08:03:54'),
(1641, 314, 'E - 092 Dt', 57, 'ERKA', '-', '17031816', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:40:29', '2020-10-15 08:04:06'),
(1642, 314, 'E - 092 Dt', 57, 'ABN', 'SPECTRUM', '138022', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:40:45', '2020-10-15 08:04:06'),
(1643, 314, 'E - 092 Dt', 34, 'KENKO', 'BF1112', '19050032002', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:42:06', '2020-10-15 08:04:06'),
(1644, 314, 'E - 092 Dt', 34, 'OMRON', 'HBP-1300', '04019643LF', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:42:12', '2020-10-15 08:04:06'),
(1645, 314, 'E - 092 Dt', 35, 'HETTICH', 'EBA 200', '0017423-04', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:45:49', '2020-10-15 08:04:06'),
(1646, 314, 'E - 092 Dt', 41, 'VIKAMED', 'VKD021', '3C40 6-M14405830385', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:46:46', '2020-10-15 08:04:06'),
(1648, 315, 'E - 093 Dt', 9, 'ELITECH', 'DIGITAL-ONE BABY', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:51:30', '2020-10-15 08:04:22'),
(1649, 315, 'E - 093 Dt', 41, 'ELITECH', '-', 'FD2188A0320', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:52:49', '2020-10-15 08:04:22'),
(1650, 315, 'E - 093 Dt', 57, 'ABN', '9002200', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 07:53:24', '2020-10-15 08:04:22'),
(1652, 316, 'E - 094 Dt', 21, 'omron', 'ne-c28', '20150107662uf', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:03:58', '2020-10-15 08:04:32'),
(1653, 316, 'E - 094 Dt', 41, 'a class', 'fd-200b+', 'f200bp19040246', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:04:44', '2020-10-15 08:04:32'),
(1655, 316, 'E - 094 Dt', 12, 'onemed', 'dragon', 'dr73636', 1, 1, '-', '5 - 50 uL', NULL, 'Laik Pakai', 1, '2020-10-01 08:06:23', '2020-10-15 08:04:32'),
(1656, 316, 'E - 094 Dt', 12, 'HUAWEI', 'H1000', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:06:44', '2020-10-15 08:04:32'),
(1658, 317, 'E - 095 Dt', 57, 'erka', 'd-836476', '1100240', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:24:57', '2020-10-02 06:48:36'),
(1659, 317, 'E - 095 Dt', 57, 'abn', 'spectrum', '115282', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:25:19', '2020-10-02 06:47:22'),
(1660, 317, 'E - 095 Dt', 57, 'abn', 'spectrum', '145486', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:25:39', '2020-10-02 06:47:22'),
(1661, 317, 'E - 095 Dt', 57, 'abn', 'spectrum', '1319391', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:25:57', '2020-10-02 06:47:22'),
(1663, 317, 'E - 095 Dt', 34, 'onemed', '-', '20190810952vg', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:27:08', '2020-10-02 06:47:22'),
(1664, 317, 'E - 095 Dt', 34, 'onemed', '-', '20190810956vg', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:27:11', '2020-10-02 06:47:22'),
(1666, 317, 'E - 095 Dt', 34, 'onemed', '-', '20161022051vg', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:27:58', '2020-10-02 06:47:22'),
(1667, 317, 'E - 095 Dt', 59, 'MIR', 'SPIROBANK II', 'A23-OY-03452', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:29:00', '2020-10-02 06:47:22'),
(1668, 317, 'E - 095 Dt', 34, 'onemed', '-', '20161034184vg', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:29:02', '2020-10-02 06:47:22'),
(1669, 317, 'E - 095 Dt', 59, 'MIR', 'SPIROBANK II', 'A23-06003840', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:29:07', '2020-10-02 06:47:22'),
(1670, 317, 'E - 095 Dt', 59, 'MIR', 'SPIROBANK II', 'A23-OY-03453', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:29:35', '2020-10-02 06:47:22'),
(1671, 317, 'E - 095 Dt', 42, 'FUKUDA', 'CARDISUNNY', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:30:18', '2020-10-02 06:47:22'),
(1672, 317, 'E - 095 Dt', 42, 'FUKUDA', 'CARDISUNNY', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:30:21', '2020-10-02 06:47:22'),
(1673, 317, 'E - 095 Dt', 42, '-', 'ecg 3303b', '1701074', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:30:23', '2020-10-02 06:47:22'),
(1674, 317, 'E - 095 Dt', 42, '-', 'ecg 3303b', '1701079', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:30:47', '2020-10-02 06:47:22'),
(1675, 317, 'E - 095 Dt', 42, '-', 'ecg 3303b', '11402008', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:31:01', '2020-10-02 06:47:22'),
(1676, 317, 'E - 095 Dt', 30, 'maico', 'ma-50', '1876596', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:32:45', '2020-10-02 06:47:22'),
(1677, 317, 'E - 095 Dt', 30, 'maico', 'ma-51', '71662', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-01 08:32:50', '2020-10-02 06:47:22'),
(1678, 318, 'E - 096 Dt', 34, 'Omron', 'HBP-1100', '010196211F', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-02 08:29:50', '2020-10-12 06:22:16'),
(1679, 318, 'E - 096 Dt', 55, 'NONIN Medical', '8500', '500241795', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-02 08:30:18', '2020-10-12 06:22:16'),
(1680, 318, 'E - 096 Dt', 57, 'ABN', '-', '981934', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-02 08:30:36', '2020-10-12 06:22:16'),
(1681, 318, 'E - 096 Dt', 57, 'ABN', '-', '878916', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-02 08:30:39', '2020-10-12 06:22:16'),
(1682, 318, 'E - 096 Dt', 1, 'Sharp', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-02 08:31:01', '2020-10-12 06:22:16'),
(1683, 318, 'E - 096 Dt', 61, 'MELAG', 'Sterilisator 75', '000752547', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-02 08:31:31', '2020-10-12 06:22:16'),
(1684, 318, 'E - 096 Dt', 19, 'Masterlight', 'SE 20-018', '1149135', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-02 08:32:00', '2020-10-12 06:22:16'),
(1685, 320, 'E - 098 Dt', 59, 'MIR', 'SPIROBANK II', 'A2305303840', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-02 09:04:01', '2020-10-14 01:34:18'),
(1686, 320, 'E - 098 Dt', 34, 'OMRON', 'HEM-7320', '20150800154VG', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-02 09:06:29', '2020-10-14 01:34:18'),
(1688, 319, 'E - 097 Dt', 30, 'Resonance', 'r27A', 'R27A16L000464', 1, 1, 'Headphone, kabel power.', '-', NULL, 'Laik Pakai', 1, '2020-10-05 05:53:58', '2020-10-09 08:08:57'),
(1689, 319, 'E - 097 Dt', 42, 'mindray', 'BeneHeart R3', 'FK-81013380', 1, 1, 'Patient Set, Kabel Power', '-', NULL, 'Laik Pakai', 1, '2020-10-05 05:54:42', '2020-10-09 08:08:57'),
(1690, 319, 'E - 097 Dt', 34, 'Omron', 'HEM-7130-L', '20180801794VG', 1, 1, 'Manset', '-', NULL, 'Laik Pakai', 1, '2020-10-05 05:56:05', '2020-10-09 08:08:57'),
(1691, 319, 'E - 097 Dt', 59, 'MSA99', '-', 'MSA 611804050', 1, 1, '-', 'Filter dan Kertas tidak ada', NULL, 'Laik Pakai', 1, '2020-10-05 07:08:43', '2020-10-09 08:08:57'),
(1692, 321, 'E - 099 Dt', 57, 'ERKA', '-', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-06 03:22:30', '2020-10-06 03:22:30'),
(1694, 323, 'E - 100 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 01:17:31', '2020-10-08 01:17:31'),
(1695, 324, 'E - 101 Dt', 41, 'Bistos', '-', 'BBD60173', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 01:27:57', '2020-10-08 01:27:57'),
(1696, 324, 'E - 101 Dt', 9, 'Kenko', '-', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 01:28:31', '2020-10-08 01:28:31'),
(1697, 324, 'E - 101 Dt', 35, 'DIGISYSTEM', 'DSC-158T', '-', 1, 1, 'Kabel Power', '-', NULL, NULL, 0, '2020-10-08 01:29:35', '2020-10-08 01:29:35'),
(1698, 325, 'E - 102 Dt', 42, 'FUKUDA', 'CARDISUNY C110', '-', 1, 1, 'Power, Patient Cable', '-', NULL, NULL, 0, '2020-10-08 01:37:38', '2020-10-08 01:37:38'),
(1699, 325, 'E - 102 Dt', 57, 'ABN', 'SPECTRUM', '287976', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 01:38:10', '2020-10-08 01:38:39'),
(1700, 325, 'E - 102 Dt', 57, 'ABN', 'SPECTRUM', '287976', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 01:38:13', '2020-10-08 01:38:13'),
(1701, 325, 'E - 102 Dt', 57, 'ABN', 'SPECTRUM', '289229', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 01:38:23', '2020-10-08 01:38:23'),
(1702, 325, 'E - 102 Dt', 57, 'Onemed', '-', '1298123', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 01:39:01', '2020-10-08 01:39:01'),
(1703, 325, 'E - 102 Dt', 41, 'Bistos', 'Hi-Bebe', 'BBJ21937', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 01:40:59', '2020-10-08 01:40:59'),
(1705, 326, 'E - 103 Dt', 41, 'DIANA', 'KD - 250', '0703021', 1, 1, 'Charger', '-', NULL, NULL, 0, '2020-10-08 02:35:52', '2020-10-08 02:35:52'),
(1706, 326, 'E - 103 Dt', 10, 'Accumax', '-', '108198', 1, 1, '-', '500 uL', NULL, NULL, 0, '2020-10-08 02:37:26', '2020-10-08 02:38:01'),
(1707, 326, 'E - 103 Dt', 10, 'Accumax', '-', '118099', 1, 1, '-', '10 uL', NULL, NULL, 0, '2020-10-08 02:37:29', '2020-10-08 02:37:29'),
(1708, 326, 'E - 103 Dt', 10, 'Accumax', '-', 'F1754690', 1, 1, '-', '100 uL', NULL, NULL, 0, '2020-10-08 02:37:47', '2020-10-08 02:37:47'),
(1709, 326, 'E - 103 Dt', 12, 'Accumax', '-', 'HL212432', 1, 1, '-', '100-1000 uL', NULL, NULL, 0, '2020-10-08 02:38:38', '2020-10-08 02:38:38'),
(1710, 326, 'E - 103 Dt', 10, 'HUMAN', 'humapette', '04F12512', 1, 1, '-', '5 uL', NULL, NULL, 0, '2020-10-08 02:39:09', '2020-10-08 02:39:09'),
(1711, 327, 'E - 104 Dt', 21, 'LAICA', '-', '161512001720', 1, 1, 'Kabel Power, Selang', '-', NULL, NULL, 0, '2020-10-08 02:44:27', '2020-10-08 02:44:27'),
(1712, 327, 'E - 104 Dt', 41, 'SOUL', 'BF-600', '60073268', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 02:45:01', '2020-10-08 02:45:01'),
(1713, 328, 'E - 105 Dt', 41, 'EDAN', '-', 'KIA001', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 02:49:43', '2020-10-08 02:49:43'),
(1714, 328, 'E - 105 Dt', 57, 'ERKA', '-', '13036135', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 02:50:33', '2020-10-08 02:50:33'),
(1715, 328, 'E - 105 Dt', 10, 'Accumax', '-', '125489', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 02:51:37', '2020-10-08 02:51:37'),
(1716, 328, 'E - 105 Dt', 12, 'ONEMED', 'DRAGON ONEMED', 'YL173AB0008969', 1, 1, '-', '10-100 uL', NULL, NULL, 0, '2020-10-08 02:52:17', '2020-10-08 02:52:21'),
(1718, 328, 'E - 105 Dt', 9, 'GEA Medical', '-', 'RKA1012', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 02:53:39', '2020-10-08 02:53:39'),
(1719, 329, 'E - 106 Dt', 41, 'DIANA', 'KD-250', '0703024', 1, 1, 'Charger', '-', NULL, NULL, 0, '2020-10-08 03:02:00', '2020-10-08 03:02:00'),
(1720, 329, 'E - 106 Dt', 9, 'GEA', 'RGZ-20A', '01-KIA', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 03:02:26', '2020-10-08 03:02:26'),
(1721, 330, 'E - 107 Dt', 9, 'Safety', 'Baby Scale', '10-02-062', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 03:07:29', '2020-10-08 03:07:29'),
(1722, 330, 'E - 107 Dt', 9, 'GEA', '-', '02/062', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 03:07:33', '2020-10-08 03:07:52'),
(1723, 330, 'E - 107 Dt', 57, 'MDF', '-', '3436681', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 03:08:24', '2020-10-08 03:10:11'),
(1724, 330, 'E - 107 Dt', 57, 'ABN', 'SPECTRUM', '119490', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 03:08:54', '2020-10-08 03:08:54'),
(1725, 330, 'E - 107 Dt', 21, 'OMRON', '-', '20170709003UF', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 03:09:29', '2020-10-08 03:09:29'),
(1726, 330, 'E - 107 Dt', 41, 'SOUL', 'BF-600', '60074097', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 03:09:50', '2020-10-08 03:09:50'),
(1727, 330, 'E - 107 Dt', 57, 'MDF', '-', '3436819', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-08 03:09:55', '2020-10-08 03:09:55'),
(1728, 331, 'E - 108 Dt', 10, 'ACCUMAX', '-', 'F175404', 1, 1, '-', '1000 uL', NULL, NULL, 0, '2020-10-08 03:13:27', '2020-10-08 03:13:27'),
(1729, 331, 'E - 108 Dt', 10, 'ACCUMAX', '-', '118071', 1, 1, '-', '10 uL', NULL, NULL, 0, '2020-10-08 03:13:30', '2020-10-08 03:13:39'),
(1730, 332, 'E - 109 Dt', 10, 'SOCOREX', 'Accura 815', '26061964', 1, 1, '-', '1000 uL', NULL, 'Laik Pakai', 1, '2020-10-08 03:17:40', '2020-10-20 02:19:03'),
(1731, 332, 'E - 109 Dt', 10, 'SOCOREX', 'Accura 815', '26041023', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2020-10-08 03:17:43', '2020-10-20 02:19:03'),
(1732, 332, 'E - 109 Dt', 42, 'BTL', 'BTL-08 SD ECG', '071D-B-02613', 1, 1, 'Kabel Power, Patient Cable, Printer Cable', '-', NULL, 'Laik Pakai', 1, '2020-10-08 03:21:20', '2020-10-20 02:19:03'),
(1733, 333, 'E - 110 Dt', 12, 'SOCOREX', 'Accura 825', '27021454', 1, 1, '-', '20-200 uL', NULL, NULL, 0, '2020-10-08 03:23:33', '2020-10-08 03:23:33'),
(1734, 334, 'E - 111 Dt', 55, '-', '-', '-', 1, 1, '-', 'Penelitian', NULL, 'Laik Pakai', 1, '2020-10-09 00:37:58', '2020-10-09 02:11:50'),
(1735, 335, 'E - 112 Dt', 30, 'resonance', 'r27a', 'R27A160000362', 1, 1, 'Headphone, Charger', '-', NULL, NULL, 0, '2020-10-13 00:57:11', '2020-10-13 00:57:11'),
(1736, 336, 'E - 113 Dt', 10, 'SOCOREX', 'ACURA 815', '26061540', 1, 1, '-', '500 uL', NULL, NULL, 0, '2020-10-14 02:12:59', '2020-10-14 02:12:59'),
(1737, 336, 'E - 113 Dt', 10, 'SOCOREX', 'ACURA 815', '18051001', 1, 1, '-', '5 uL', NULL, NULL, 0, '2020-10-14 02:13:03', '2020-10-14 02:13:44'),
(1738, 336, 'E - 113 Dt', 10, 'SOCOREX', 'ACURA 815', '18051451', 1, 1, '-', '50 uL', NULL, NULL, 0, '2020-10-14 02:13:19', '2020-10-14 02:13:19'),
(1739, 336, 'E - 113 Dt', 10, 'SOCOREX', 'ACURA 815', '18011329', 1, 1, '-', '20 uL', NULL, NULL, 0, '2020-10-14 02:13:34', '2020-10-14 02:13:34'),
(1740, 336, 'E - 113 Dt', 12, 'SOCOREX', 'ACURA 825', '28041937', 1, 1, '-', '100-1000 uL', NULL, NULL, 0, '2020-10-14 02:14:20', '2020-10-14 02:14:41'),
(1741, 336, 'E - 113 Dt', 12, 'SOCOREX', 'ACURA 825', '27081082', 1, 1, '-', '0.5-10 uL', NULL, NULL, 0, '2020-10-14 02:14:24', '2020-10-14 02:14:24'),
(1742, 337, 'E - 114 Dt', 12, 'SOCOREX', 'ACURA 825', '13121585', 1, 1, '-', '5-50 uL', NULL, NULL, 0, '2020-10-14 02:15:30', '2020-10-14 02:15:30'),
(1743, 337, 'E - 114 Dt', 12, 'SOCOREX', 'ACURA 825', '28041121', 1, 1, '-', '100-1000 uL', NULL, NULL, 0, '2020-10-14 02:15:33', '2020-10-14 02:15:59'),
(1744, 337, 'E - 114 Dt', 10, 'SOCOREX', 'ACURA 815', '13072455', 1, 1, '-', '500 uL', NULL, NULL, 0, '2020-10-14 02:16:32', '2020-10-14 02:16:52'),
(1745, 337, 'E - 114 Dt', 10, 'SOCOREX', 'ACURA 815', '26061567', 1, 1, '-', '500 uL', NULL, NULL, 0, '2020-10-14 02:16:38', '2020-10-16 08:37:33'),
(1746, 337, 'E - 114 Dt', 10, 'SOCOREX', 'ACURA 811', '13071122', 1, 1, '-', '50 uL', NULL, NULL, 0, '2020-10-14 02:16:54', '2020-10-14 02:17:11'),
(1747, 338, 'E - 115 Dt', 12, 'SOCOREX', 'ACURA 825', '28041170', 1, 1, '-', '100-1000 uL', NULL, NULL, 0, '2020-10-14 02:17:55', '2020-10-14 02:17:55'),
(1748, 338, 'E - 115 Dt', 12, 'SOCOREX', 'ACURA 825', '27081084', 1, 1, '-', '0.5-10 uL', NULL, NULL, 0, '2020-10-14 02:17:58', '2020-10-14 02:18:23'),
(1749, 338, 'E - 115 Dt', 10, 'SOCOREX', 'ACURA 815', '26061554', 1, 1, '-', '500 uL', NULL, NULL, 0, '2020-10-14 02:18:55', '2020-10-14 02:18:55'),
(1751, 339, 'E - 116 Dt', 12, 'SOCOREX', 'ACURA 825', '27061319', 1, 1, '-', '0.5-10 uL', NULL, NULL, 0, '2020-10-14 02:19:39', '2020-10-14 02:20:08'),
(1752, 339, 'E - 116 Dt', 12, 'SOCOREX', 'ACURA 825', '27081081', 1, 1, '-', '0.5-10 uL', NULL, NULL, 0, '2020-10-14 02:19:59', '2020-10-14 02:19:59'),
(1755, 340, 'E - 117 Dt', 10, 'SOCOREX', 'ACURA 815', '26051617', 1, 1, '-', '500 uL', NULL, 'Laik Pakai', 1, '2020-10-15 07:31:31', '2020-11-02 02:14:03'),
(1756, 340, 'E - 117 Dt', 59, 'CHEST', 'CHESTGRAPH HI - 101', '1135831', 1, 1, 'kabel power, mouth piece, syringe', '-', NULL, 'Laik Pakai', 1, '2020-10-15 07:32:07', '2020-11-02 02:14:03'),
(1757, 340, 'E - 117 Dt', 42, 'BLT', 'E - 30', 'E066E003586', 1, 1, 'Power, Patient Cable, Koper', '-', NULL, 'Laik Pakai', 1, '2020-10-15 07:32:51', '2020-11-02 02:14:03'),
(1758, 337, 'E - 114 Dt', 10, 'SOCOREX', 'ACURA 815', '26111511', 1, 1, '-', '1000 uL', NULL, NULL, 0, '2020-10-16 08:36:58', '2020-10-16 08:36:58'),
(1759, 337, 'E - 114 Dt', 10, 'SOCOREX', 'ACURA 815', '13112896', 1, 1, '-', '1000 uL', NULL, NULL, 0, '2020-10-16 08:37:11', '2020-10-16 08:37:11'),
(1760, 337, 'E - 114 Dt', 12, 'SOCOREX', 'ACURA 825', '28041928', 1, 1, '-', '100-1000 uL', NULL, NULL, 0, '2020-10-16 08:37:48', '2020-10-16 08:37:59'),
(1761, 341, 'E - 118 Dt', 55, 'NONIN', '8500', '502743502', 1, 1, '-', '-', NULL, 'Laik pakai', 0, '2020-10-20 02:45:06', '2020-11-10 03:47:11'),
(1762, 341, 'E - 118 Dt', 57, 'Riester', 'ri-san', '180148332', 1, 1, '-', '-', NULL, 'Laik pakai', 0, '2020-10-20 02:49:10', '2020-11-10 03:47:15'),
(1763, 341, 'E - 118 Dt', 1, 'sharp', 'PS-302', '1149036', 1, 1, '-', '-', NULL, 'Laik pakai', 0, '2020-10-20 02:49:56', '2020-11-10 03:47:34'),
(1764, 341, 'E - 118 Dt', 26, 'WEINMANN', 'ACCUVAC PRO', '12123', 1, 1, '-', '-', NULL, 'Laik pakai', 0, '2020-10-20 02:50:33', '2020-11-10 03:47:43'),
(1765, 341, 'E - 118 Dt', 37, 'ZOLL', 'AEDPLUS', '-', 1, 1, '-', '-', NULL, 'Laik pakai', 0, '2020-10-20 02:51:19', '2020-11-10 03:47:51'),
(1766, 342, 'E - 119 Dt', 42, 'CONTEC', 'ecg-300g', 'F1172D0077', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-20 03:13:14', '2020-10-26 02:25:31'),
(1767, 342, 'E - 119 Dt', 59, 'CONTEC', 'SPIO', 'JE1307300171', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-20 03:13:22', '2020-10-26 02:25:31'),
(1768, 343, 'E - 120 Dt', 3, '-', '-', '-', 1, 1, '1/3 botol Isoflurane', '-', NULL, 'Laik Pakai', 1, '2020-10-20 03:32:10', '2020-11-02 07:22:43'),
(1769, 343, 'E - 120 Dt', 52, '-', 'PAU - C - V', '2016515', 1, 1, '-', '-', NULL, 'Tidak Laik Pakai', 1, '2020-10-20 03:32:53', '2020-11-02 07:22:49'),
(1770, 345, 'E - 121 Dt', 57, 'General Care', '-', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-20 08:29:49', '2020-11-02 07:20:33'),
(1771, 345, 'E - 121 Dt', 57, 'One Med', '-', '1231195', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-20 08:29:50', '2020-11-02 07:20:34'),
(1772, 345, 'E - 121 Dt', 55, 'elitech', 'fox1', '-', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-20 08:30:32', '2020-11-02 07:20:35'),
(1773, 345, 'E - 121 Dt', 37, 'ZOLL', 'AED PRO', 'AA13K030076', 1, 1, '-', '-', NULL, 'Laik Pakai', 1, '2020-10-20 08:31:08', '2020-11-02 07:20:36'),
(1774, 346, 'E - 122 Dt', 34, 'elitech', 'tensione', 'BP1191A0404', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-20 08:34:10', '2020-10-20 08:34:10'),
(1775, 346, 'E - 122 Dt', 34, 'elitech', 'tensione', 'BP1191A0319', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-20 08:34:11', '2020-10-20 08:34:43'),
(1776, 346, 'E - 122 Dt', 34, 'elitech', 'tensione', 'BP1191A0086', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-20 08:34:22', '2020-10-20 08:34:22'),
(1777, 346, 'E - 122 Dt', 34, 'elitech', 'tensione', 'BP1191A0200', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-20 08:34:32', '2020-10-20 08:34:32'),
(1778, 346, 'E - 122 Dt', 34, 'elitech', 'tensione', 'BP1191A0312', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-20 08:34:46', '2020-10-20 08:34:54'),
(1779, 346, 'E - 122 Dt', 41, 'elitech', 'sonotrax b', 'FD2188A0288', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-20 08:35:34', '2020-10-20 08:35:46'),
(1780, 346, 'E - 122 Dt', 41, 'elitech', 'sonotrax b', 'FD2188A0015', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-20 08:35:36', '2020-10-20 08:35:36'),
(1782, 347, 'E - 130 Dt', 10, 'DRAGONONEMED', '-', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-23 03:10:35', '2020-10-23 03:10:35'),
(1783, 348, 'E - 123 Dt', 41, 'bistos', 'BT-200', 'BABB2139', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 02:56:52', '2020-10-27 02:56:52'),
(1784, 348, 'E - 123 Dt', 22, '-', 'Oxy 5000', '0517040842', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:02:42', '2020-10-27 03:02:42'),
(1785, 348, 'E - 123 Dt', 57, 'ABN', 'SPECTRUM', '989768', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:04:08', '2020-10-27 03:04:08'),
(1786, 349, 'E - 124 Dt', 41, 'bistos', 'BT-200', 'BBJC0284', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:08:32', '2020-10-27 03:08:32'),
(1787, 349, 'E - 124 Dt', 41, 'bistos', 'BT-200', 'BBD60545', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:08:34', '2020-10-27 03:08:50'),
(1788, 349, 'E - 124 Dt', 34, 'OMRON', 'HEM-7130', '20171012466VG', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:09:31', '2020-10-27 03:09:31'),
(1789, 349, 'E - 124 Dt', 34, 'KENKO', 'BF1112', '19050031005', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:10:08', '2020-10-27 03:14:33'),
(1790, 349, 'E - 124 Dt', 26, 'ELMASLAR', 'LIFETIME SA 02', '0815100112', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:15:32', '2020-10-27 03:15:32'),
(1791, 349, 'E - 124 Dt', 42, 'MEDIGATE', 'MECA303i', 'MD095150601935', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:16:13', '2020-10-27 03:16:13'),
(1793, 349, 'E - 124 Dt', 1, 'FirstMed', '-', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:17:09', '2020-10-27 03:17:27'),
(1794, 349, 'E - 124 Dt', 21, 'beurer', 'z28', '003259', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:18:27', '2020-10-27 03:18:27'),
(1795, 349, 'E - 124 Dt', 66, 'mindray', 'DP-20', 'GR5A002481', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:19:07', '2020-10-27 03:19:07'),
(1796, 351, 'E - 125 Dt', 34, 'OMRON', 'HBP-1100', '01008952LF', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:32:04', '2020-10-27 03:32:04'),
(1797, 351, 'E - 125 Dt', 42, 'MEDIGATE', 'MECA3030i', 'MD095151102029', 1, 1, 'Kabel power,lead', '-', NULL, NULL, 0, '2020-10-27 03:33:27', '2020-10-27 03:33:27'),
(1798, 351, 'E - 125 Dt', 66, 'mindray', 'dp-20', '6R5A002486', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:34:13', '2020-10-27 03:34:13'),
(1799, 351, 'E - 125 Dt', 9, 'KENKO', '-', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:34:46', '2020-10-27 03:34:46'),
(1800, 351, 'E - 125 Dt', 22, 'bitmos', 'Oxy5000', 'O517040845', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:36:24', '2020-10-27 03:36:24'),
(1801, 352, 'E - 126 Dt', 34, 'beurer', '-', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:47:04', '2020-10-27 03:47:04'),
(1802, 352, 'E - 126 Dt', 19, 'KaWe', '-', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:48:09', '2020-10-27 03:48:09'),
(1803, 352, 'E - 126 Dt', 42, 'medigate', 'MeCA303i', 'MD095151102014', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:52:18', '2020-10-27 03:52:18'),
(1804, 352, 'E - 126 Dt', 21, 'COMFORT', 'KU-200', '1306024', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:52:50', '2020-10-27 03:52:50'),
(1805, 352, 'E - 126 Dt', 66, 'MINDRAY', 'DP-20', 'GR5A002485', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:54:50', '2020-10-27 03:54:50'),
(1806, 352, 'E - 126 Dt', 18, 'BISTOS', 'BT-410', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:56:08', '2020-10-27 03:56:08'),
(1807, 352, 'E - 126 Dt', 22, 'NEWLIFE', '-', 'BUB0115420240', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 03:56:41', '2020-10-27 03:56:41'),
(1808, 353, 'E - 127 Dt', 41, 'Lotus', '-', '-', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 04:02:55', '2020-10-27 04:02:55');
INSERT INTO `lab_detail_order` (`id`, `id_order`, `no_order`, `alat_id`, `merek`, `model`, `seri`, `jumlah`, `fungsi`, `kelengkapan`, `keterangan`, `no_registrasi`, `catatan`, `ambil`, `created_at`, `updated_at`) VALUES
(1809, 353, 'E - 127 Dt', 34, 'KENKO', 'BF112', '18050221472', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 04:03:29', '2020-10-27 04:03:29'),
(1810, 353, 'E - 127 Dt', 42, 'MEDIGATE', 'MECA303I', 'MD095150601939', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 04:06:37', '2020-10-27 04:06:37'),
(1811, 353, 'E - 127 Dt', 21, 'BEURER', 'IH25/1', '003258', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 04:07:15', '2020-10-27 04:07:15'),
(1812, 353, 'E - 127 Dt', 66, 'MINDRAY', 'DP-20', 'GR5A002484', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 04:08:04', '2020-10-27 04:08:04'),
(1813, 353, 'E - 127 Dt', 34, 'Dr. Family', '-', '-', 1, 1, '-', 'maset rusak', NULL, NULL, 0, '2020-10-27 04:11:48', '2020-10-27 04:12:17'),
(1814, 355, 'E - 128 Dt', 22, 'Bitmos', 'Oxy5000', 'O517040852', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 04:29:14', '2020-10-27 04:29:14'),
(1815, 356, 'E - 129 Dt', 35, 'K', 'PLC', '018219', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 04:32:27', '2020-10-27 04:32:27'),
(1816, 356, 'E - 129 Dt', 12, 'DRAGONONEMED', '-', 'A052700', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 04:33:43', '2020-10-27 04:33:43'),
(1817, 352, 'E - 126 Dt', 22, 'NEWLIFE', '-', 'BUB0115420240', 1, 1, '-', '-', NULL, NULL, 0, '2020-10-27 07:39:38', '2020-10-27 07:39:38');

-- --------------------------------------------------------

--
-- Table structure for table `lab_dokumen`
--

CREATE TABLE `lab_dokumen` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `dok1` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dok2` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_dokumen`
--

INSERT INTO `lab_dokumen` (`id`, `id_order`, `dok1`, `dok2`, `created_at`, `updated_at`) VALUES
(1, 216, 'm1J3YItrdN4cJFVdggmpSHpYG53EtKBSCGh8N6Xj.pdf', NULL, '2020-06-09 06:59:35', '2020-06-09 06:59:35'),
(2, 219, 'Ucz5LIGDLmu9l1CCwcQm1yRUCSIUOQr4oK2qSs7D.pdf', 'BJsp0kQCqTXs2xIGOA5W4u87bGQoO8otoi5Voy0j.pdf', '2020-06-09 07:00:17', '2020-06-09 07:00:17'),
(3, 220, 'DIYU8kjLKElgh3HdZOjXs7bxQg7xo3Db315YLV9F.pdf', 'kK7DwHomFiffJqTcxgJMPwnJU1E1AgqaBnwvZBsz.pdf', '2020-06-09 07:01:01', '2020-06-09 07:01:01'),
(4, 221, '8angiiyiehRfvmTYU12x8QHgpqf6e0eik2I8r4Hx.pdf', 'HPXHdYZsX2HXEjJfl3qao1t9zP1GwFRG0OHDYuZ4.pdf', '2020-06-09 07:01:23', '2020-06-09 07:01:23'),
(5, 222, '6nrksq6HgGibId9lqnmTox7SfIbK4sihQEGccd22.pdf', '2rpGuYjQvXXTSBdqEL7siUzml0qPfvCUh4MXYl3M.pdf', '2020-06-09 07:02:02', '2020-06-09 07:02:02'),
(7, 223, '7vyZoo2VxottgJJCCf7bEpuPQ7HlCs5fPItlnLCw.pdf', 'y2Dc2uwDnHWFoCPoeXaHnHnyeEiB5IXMMqEKIp0S.pdf', '2020-06-09 07:02:49', '2020-06-09 07:02:49'),
(8, 224, 'V76aNWnrZ7Li7k9Rid55HmMKezJorgkBYHw0sSd7.pdf', NULL, '2020-06-09 07:03:34', '2020-06-09 07:03:34'),
(9, 226, 'GVuGIccxhKiTmEUfVqmDi8CQWMe3tDeCrkVGvbmH.pdf', 'lGOQScyeiMzSPTBt2g0fD2pnhRD4wyJF86w9dl9o.pdf', '2020-06-09 07:03:54', '2020-06-09 07:03:54'),
(10, 227, 'DPRljYSJ4QBOInSq73I61no1w6JUmkcozVMXBgy3.pdf', '6zHDJJEnSSRxB4npBmxvkiWuYcAN9Q3MMM1bHAoz.pdf', '2020-06-09 07:04:16', '2020-06-09 07:04:16'),
(11, 228, 'QzQrHsd3GmmV4taL3B8KLPYKKsdrXeUZEqFwL6EE.pdf', 'TfZPDtbBG8hKWbysWKQheqpb2QtXpZpSc9R8SYiG.pdf', '2020-06-09 07:04:34', '2020-06-09 07:04:34'),
(12, 229, 'B0aRLG5ayrSZ3HDYYMm0WHUg65uIYD4yn31I2cYv.pdf', 'eSGtEOBVrdbNtK465ObD968Vy19xiHRCUmUnisxk.pdf', '2020-06-09 07:05:09', '2020-06-09 07:05:09'),
(13, 230, 'LqLvsgggsCogLbF2eaujufcEvqNf58kLmMt2CSgK.pdf', 'GHsfIlstxbcOrb3xT6BAJz9ofjSVY6Yp8gw2LxCN.pdf', '2020-06-09 07:05:33', '2020-06-09 07:05:33'),
(14, 231, 'd04JG69RuUoaTeJbCNaX5rL85rTx1f3ynM3mhE4c.pdf', 'en02MmdKjEvDPfgucZu18vKygmm1eMdpQBjaMotF.pdf', '2020-06-09 07:05:56', '2020-06-09 07:05:56'),
(15, 232, 'onbauJNM0pP7gYbZboKRRIu7SGPybTzurtbgVe2N.pdf', '8OdMVVLTqb6SQ10armVLkkdOFZIVKrkhc6TPBBxM.pdf', '2020-06-09 07:06:16', '2020-06-09 07:06:16'),
(16, 233, '8cSAdf65Ft49ewbe7rYF3DA2iwI5dG2XSqbd4gUz.pdf', 'eqKq3VJqjKNvrbxE2G1xSEAEZoT9DsJfI68A4aws.pdf', '2020-06-09 07:06:38', '2020-06-09 07:06:38'),
(17, 240, 'YAgs0bQMOK6bF6P14GjDq12zvUdsUGxDipVmq9vB.pdf', 'UgC1SKXF6nCsY4Q9SqGPMWaMcbMbTe6O1dg4lXUL.pdf', '2020-06-09 07:07:00', '2020-06-09 07:07:00'),
(18, 234, 'KHiZZcpKZY7EnE2a9RsVjNksco5soxdcKQuWDACD.pdf', 'vM5xFcuA86rH6atqZSgiWj0QNrSIAQU0bfWh6xll.pdf', '2020-06-09 07:14:02', '2020-06-09 07:15:25'),
(19, 235, '1wVNzii8jXUh110KKoODqYE6dAOfJnJLcT0x1GJa.pdf', 'Hxz2P1R6vp7lTVqGh3Rg7JcxKFnDJaXbpnvB9U3n.pdf', '2020-06-09 07:14:28', '2020-06-09 07:14:28'),
(20, 236, 'nO3ihb9ItXe7CBTJXK04lgsji1Y65vKQT5tc2PLG.pdf', 'SDW3iYQOSE8C99fdQVc2ZvJE4OBRyACxwSWxZzsA.pdf', '2020-06-09 07:15:51', '2020-06-09 07:15:51'),
(21, 237, '6RLBieZrWdvK9agqx584WUVwTpFrOCotuGcIZuMR.pdf', 'GsG99Zl6DoTWM6M5sEmV4sto3Rl5dtKRu7yRA1S2.pdf', '2020-06-09 07:16:09', '2020-06-09 07:16:09'),
(22, 238, '85oBCFOoqpVztEAPTsX4OcTqjIlZCwsUsf7i2TAc.pdf', 'jok6Y9PywAu0JnFUyFOCWLBH953xE5ogXaLJchCU.pdf', '2020-06-09 07:16:26', '2020-06-09 07:16:26'),
(23, 239, 'NFKQWk4a1P3v1Kvom4kDx020Xhd8EYsbXuoOs4HW.pdf', 'O1ZYIWGKv3Gu0V84NaoMnIeeVey7p8EMoM3ZCyqx.pdf', '2020-06-09 07:16:41', '2020-06-09 07:16:41');

-- --------------------------------------------------------

--
-- Table structure for table `lab_fungsi`
--

CREATE TABLE `lab_fungsi` (
  `id` int(10) UNSIGNED NOT NULL,
  `fungsi` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_fungsi`
--

INSERT INTO `lab_fungsi` (`id`, `fungsi`, `created_at`, `updated_at`) VALUES
(1, 'Baik', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'Tidak Baik', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `lab_instalasi`
--

CREATE TABLE `lab_instalasi` (
  `id` int(10) UNSIGNED NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nip` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instalasi` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_instalasi`
--

INSERT INTO `lab_instalasi` (`id`, `nama`, `nip`, `instalasi`, `created_at`, `updated_at`) VALUES
(1, 'Choirul Huda', '198112092009121003', 'Instalasi Laboratorium Pengujian dan Kalibrasi', NULL, NULL),
(2, 'Christian Philosophia Currie Nobel Peday, S.Si', '198404032015031002', 'Instalasi Laboratorium Uji kesesuaian dan Proteksi Radiasi', NULL, NULL),
(3, 'Annas Dwi Ma\'ruf, ST', '198402222010121001', 'Instalasi Laboratorium Pemantauan Dosis Personal', NULL, NULL),
(4, 'Hary Ernanto', '198710222010121005', 'Instalasi Sarana dan Prasarana', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lab_jenis`
--

CREATE TABLE `lab_jenis` (
  `id` int(10) UNSIGNED NOT NULL,
  `jenis` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_jenis`
--

INSERT INTO `lab_jenis` (`id`, `jenis`, `created_at`, `updated_at`) VALUES
(1, 'RS. Pemerintah', NULL, NULL),
(2, 'RS. TNI/POLRI', NULL, NULL),
(3, 'RS. BUMN', NULL, NULL),
(4, 'RS. Swasta', NULL, NULL),
(5, 'Puskesmas', NULL, NULL),
(6, 'Klinik', NULL, NULL),
(7, 'Perusahaan', NULL, NULL),
(8, 'Lain - Lain', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lab_kabupaten`
--

CREATE TABLE `lab_kabupaten` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `kabupaten_id` int(5) NOT NULL,
  `provinsi_id` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_kabupaten`
--

INSERT INTO `lab_kabupaten` (`id`, `name`, `kabupaten_id`, `provinsi_id`) VALUES
(1, 'Sambas', 6101, 61),
(2, 'Bengkayang', 6102, 61),
(3, 'Landak', 6103, 61),
(4, 'Mempawah', 6104, 61),
(5, 'Sanggau', 6105, 61),
(6, 'Ketapang', 6106, 61),
(7, 'Sintang', 6107, 61),
(8, 'Kapuas Hulu', 6108, 61),
(9, 'Sekadau', 6109, 61),
(10, 'Melawi', 6110, 61),
(11, 'Kayong Utara', 6111, 61),
(12, 'Kubu Raya', 6112, 61),
(13, 'Kota Pontianak', 6171, 61),
(14, 'Singkawang', 6172, 61),
(15, 'Kotawaringin Barat', 6201, 62),
(16, 'Kotawaringin Timur', 6202, 62),
(17, 'Kapuas', 6203, 62),
(18, 'Barito Selatan', 6204, 62),
(19, 'Barito Utara', 6205, 62),
(20, 'Sukamara', 6206, 62),
(21, 'Lamandau', 6207, 62),
(22, 'Seruyan', 6208, 62),
(23, 'Katingan', 6209, 62),
(24, 'Pulang Pisau', 6210, 62),
(25, 'Gunung Mas', 6211, 62),
(26, 'Barito Timur', 6212, 62),
(27, 'Murung Raya', 6213, 62),
(28, 'Palangka Raya', 6271, 62),
(29, 'Tanah Laut', 6301, 63),
(30, 'Kotabaru', 6302, 63),
(31, 'Banjar', 6303, 63),
(32, 'Barito Kuala', 6304, 63),
(33, 'Tapin', 6305, 63),
(34, 'Hulu Sungai Selatan', 6306, 63),
(35, 'Hulu Sungai Tengah', 6307, 63),
(36, 'Hulu Sungai Utara', 6308, 63),
(37, 'Tabalong', 6309, 63),
(38, 'Tanah Bumbu', 6310, 63),
(39, 'Balangan', 6311, 63),
(40, 'Banjarmasin', 6371, 63),
(41, 'Banjarbaru', 6372, 63),
(42, 'Paser', 6401, 64),
(43, 'Kutai Barat', 6402, 64),
(44, 'Kutai Kertanegara', 6403, 64),
(45, 'Kutai Timur', 6404, 64),
(46, 'Berau', 6405, 64),
(47, 'Mahakam Ulu', 6406, 64),
(48, 'Penajam Paser Utara', 6409, 64),
(49, 'Balikpapan', 6471, 64),
(50, 'Samarinda', 6472, 64),
(51, 'Bontang', 6474, 64),
(52, 'Malinau', 6506, 65),
(53, 'Bulungan', 6507, 65),
(54, 'Nunukan', 6508, 65),
(55, 'Tana Tidung', 6510, 65),
(56, 'Tarakan', 6573, 65);

-- --------------------------------------------------------

--
-- Table structure for table `lab_kuitansi`
--

CREATE TABLE `lab_kuitansi` (
  `id` int(10) UNSIGNED NOT NULL,
  `no_bukti` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_order` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_bayar` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int(11) NOT NULL,
  `dari` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_kuitansi`
--

INSERT INTO `lab_kuitansi` (`id`, `no_bukti`, `no_order`, `tgl_bayar`, `customer_id`, `dari`, `keterangan`, `created_at`, `updated_at`) VALUES
(3, '019.UMT/01/19', 'E - 004 Dt', '2019-01-31', 4, 'Andre Tanjung', 'Pembayaran tarif pengujian dan/atau kalibrasi sesuai BA No. Order E-004 DT', '2019-01-30 11:00:59', '2019-01-30 11:00:59');

-- --------------------------------------------------------

--
-- Table structure for table `lab_laboratorium`
--

CREATE TABLE `lab_laboratorium` (
  `id` int(10) UNSIGNED NOT NULL,
  `laboratorium` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_laboratorium`
--

INSERT INTO `lab_laboratorium` (`id`, `laboratorium`, `created_at`, `updated_at`) VALUES
(1, 'Laboratorium Suhu', NULL, NULL),
(2, 'Laboratorium Tekanan', NULL, NULL),
(3, 'Laboratorium Flow & Volume', NULL, NULL),
(5, 'Laboratorium Optik Akustik', NULL, NULL),
(6, 'Laboratorium Kelistrikan', NULL, NULL),
(7, 'Laboratorium Waktu dan frekuensi', NULL, NULL),
(8, 'Laboratorium Gaya Massa', NULL, NULL),
(9, 'Laboratorium Kalibrasi LPFFK Banjarbaru', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lab_layanan`
--

CREATE TABLE `lab_layanan` (
  `id` int(10) UNSIGNED NOT NULL,
  `layanan` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_layanan`
--

INSERT INTO `lab_layanan` (`id`, `layanan`, `created_at`, `updated_at`) VALUES
(1, 'Kalibrasi', NULL, NULL),
(2, 'Pengujian', NULL, NULL),
(3, 'Pengujian dan Kalibrasi', NULL, NULL),
(4, 'Pengujian, Kalibrasi & Proteksi Radiasi', NULL, NULL),
(5, 'Pelayanan Penggantian Alat', NULL, NULL),
(6, 'Pelayanan Uji Kesesuaian', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lab_orderan`
--

CREATE TABLE `lab_orderan` (
  `id` int(10) UNSIGNED NOT NULL,
  `no_order` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_terima` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `tgl_selesai` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_orderan`
--

INSERT INTO `lab_orderan` (`id`, `no_order`, `tgl_terima`, `catatan`, `tgl_selesai`, `created_at`, `updated_at`) VALUES
(3, 'E - 002 Dt', '2019-01-24', '-', '2019-02-01', '2019-01-24 09:12:28', '2019-01-24 09:12:28'),
(4, 'E - 004 Dt', '2019-01-31', '-', '2019-02-01', '2019-01-30 10:15:57', '2019-01-30 10:15:57'),
(5, 'E - 005 Dt', '2019-02-04', '-', '2019-02-07', '2019-02-03 11:04:37', '2019-02-03 11:04:37'),
(6, 'E - 006 Dt', '2019-02-06', '-', '2019-02-08', '2019-02-05 09:49:33', '2019-02-05 09:49:33'),
(7, 'E - 007 Dt', '2019-02-12', 'Dikerjakan menunggu petugas datang', '2019-02-21', '2019-02-11 10:11:05', '2019-02-11 10:11:05'),
(8, 'E - 008 Dt', '2019-02-12', 'Alat diterima via paket pengiriman', '2019-02-21', '2019-02-11 14:39:49', '2019-02-11 14:39:49'),
(9, 'E - 009 Dt', '2019-02-18', '-', '2019-02-25', '2019-02-17 13:20:43', '2019-02-17 13:20:43'),
(11, 'E - 010 Dt', '2019-02-19', '-', '2019-02-26', '2019-02-18 12:07:10', '2019-02-18 12:07:10'),
(12, 'E - 011 Dt', '2019-02-20', 'Menunggu Petugas Datang', '2019-02-28', '2019-02-19 14:07:50', '2019-02-19 14:07:50'),
(14, 'E - 012 Dt', '2019-02-25', '-', '2019-03-04', '2019-02-24 21:05:30', '2019-02-24 21:05:30'),
(15, 'E - 013 Dt', '2019-02-27', 'Menunggu petugas datang', '2019-03-07', '2019-02-27 00:38:26', '2019-02-27 00:38:26'),
(16, 'E - 014 Dt', '2019-03-21', '-', '2019-03-29', '2019-03-03 22:21:37', '2019-03-20 20:07:57'),
(17, 'E - 015 Dt', '2019-03-06', '-', '2019-03-13', '2019-03-05 21:18:14', '2019-03-05 21:18:14'),
(18, 'E - 016 Dt', '2019-03-06', '-', '2019-03-13', '2019-03-05 21:22:22', '2019-03-05 21:22:22'),
(19, 'E - 017 Dt', '2019-03-08', '-', '2019-03-15', '2019-03-07 23:45:38', '2019-03-07 23:45:38'),
(20, 'E - 018 Dt', '2019-03-14', '-', '2019-03-21', '2019-03-13 17:37:02', '2019-03-13 17:37:02'),
(21, 'E - 019 Dt', '2019-03-14', '-', '2019-03-22', '2019-03-13 19:10:21', '2019-03-13 19:10:21'),
(22, 'E - 020 Dt', '2019-03-14', '-', '2019-03-21', '2019-03-13 21:59:51', '2019-03-13 21:59:51'),
(23, 'E - 022 Dt', '2019-03-14', '-', '2019-03-21', '2019-03-13 22:39:58', '2019-03-13 22:39:58'),
(25, 'E - 021 Dt', '2019-03-15', '-', '2019-03-22', '2019-03-14 19:57:44', '2019-03-14 19:57:44'),
(26, 'E - 023 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-04-02', '2019-03-20 17:47:38', '2019-03-20 17:47:38'),
(27, 'E - 024 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-04-09', '2019-03-20 19:16:58', '2019-03-20 19:16:58'),
(28, 'E - 025 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-04-02', '2019-03-20 19:36:31', '2019-03-20 19:36:31'),
(29, 'E - 026 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-03-02', '2019-03-20 19:41:10', '2019-03-20 19:41:10'),
(30, 'E - 027 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-04-16', '2019-03-20 19:55:49', '2019-03-20 19:55:49'),
(31, 'E - 028 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-04-24', '2019-03-20 20:17:28', '2019-03-20 20:17:28'),
(32, 'E - 033 Dt', '2019-03-20', 'Kalibrasi Spiro dan Audiometer menunggu Petugas Datang', '2019-03-29', '2019-03-20 20:17:48', '2019-03-20 20:17:48'),
(33, 'E - 029 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-05-01', '2019-03-20 20:27:04', '2019-03-20 20:27:04'),
(34, 'E - 030 Dt', '2019-03-20', '-', '2019-05-08', '2019-03-20 20:32:39', '2019-03-20 20:32:39'),
(36, 'E - 031 Dt', '2019-03-21', 'menunggu petugas datang', '2019-05-15', '2019-03-20 20:49:49', '2019-03-20 20:49:49'),
(37, 'E - 032 Dt', '2019-03-20', '-', '2019-05-08', '2019-03-20 20:52:17', '2019-03-20 20:52:17'),
(38, 'E - 034 Dt', '2019-03-21', 'menunggu petugas datang', '2019-04-26', '2019-03-20 21:51:45', '2019-03-20 21:51:45'),
(39, 'E - 035 Dt', '2019-03-21', 'menunggu petugas datang', '2019-05-01', '2019-03-20 22:04:40', '2019-03-20 22:04:40'),
(42, 'E - 039 Dt', '2019-03-21', 'menunggu petugas datang', '2019-05-16', '2019-03-20 22:42:46', '2019-03-20 23:04:16'),
(43, 'E - 036 Dt', '2019-03-20', 'Menunggu Petugas Datang', '2019-05-02', '2019-03-20 22:43:33', '2019-03-20 22:43:33'),
(44, 'E - 037 Dt', '2019-03-20', 'Menunggu Petugas Datang', '2019-05-09', '2019-03-20 22:50:22', '2019-03-20 23:03:31'),
(45, 'E - 038 Dt', '2019-03-20', 'Menunggu petugas Datang', '2019-05-03', '2019-03-20 23:03:34', '2019-03-20 23:03:34'),
(46, 'E - 040 Dt', '2019-03-21', 'menunggu petugas datang', '2019-05-23', '2019-03-20 23:09:14', '2019-03-20 23:09:14'),
(47, 'E - 041 Dt', '2019-03-21', '-', '2019-05-30', '2019-03-20 23:19:02', '2019-03-20 23:19:02'),
(48, 'E - 042 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-05-31', '2019-03-20 23:43:03', '2019-03-20 23:43:03'),
(49, 'E - 043 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-05-31', '2019-03-21 00:00:23', '2019-03-21 00:00:23'),
(50, 'E - 044 Dt', '2019-03-21', 'Menunggu Petugas Datang', '2019-05-31', '2019-03-21 00:05:42', '2019-03-21 00:05:42'),
(52, 'E - 045 Dt', '2019-03-22', 'Menunggu antrian nomer order lain', '2019-05-06', '2019-03-21 19:38:29', '2019-03-21 19:38:29'),
(53, 'E - 046 Dt', '2019-04-01', '-', '2019-04-08', '2019-04-01 00:15:26', '2019-04-01 00:15:26'),
(54, 'E - 047 Dt', '2019-04-04', '-', '2019-04-12', '2019-04-05 03:02:55', '2019-04-05 03:06:19'),
(55, 'E - 048 Dt', '2019-04-12', '-', '2019-04-19', '2019-04-12 02:42:02', '2019-04-12 02:42:02'),
(56, 'E - 049 Dt', '2019-04-16', '-', '2019-04-25', '2019-04-16 06:30:26', '2019-04-16 06:30:26'),
(57, 'E - 050 Dt', '2019-04-18', '-', '2019-04-26', '2019-04-18 07:06:00', '2019-04-18 07:06:00'),
(58, 'E - 051 Dt', '2019-04-25', '-', '2019-05-03', '2019-04-25 01:07:49', '2019-04-25 01:07:49'),
(59, 'E - 052 Dt', '2019-04-25', '-', '2019-05-03', '2019-04-25 01:08:52', '2019-04-25 01:08:52'),
(60, 'E - 053 Dt', '2019-04-25', '-', '2019-05-03', '2019-04-25 01:09:49', '2019-04-25 01:09:49'),
(61, 'E - 054 Dt', '2019-04-29', '-', '2019-05-07', '2019-04-29 01:58:00', '2019-04-29 01:58:00'),
(62, 'E - 055 Dt', '2019-04-29', '-', '2019-05-21', '2019-04-29 02:05:15', '2019-04-29 02:05:15'),
(63, 'E - 056 Dt', '2019-04-29', '-', '2019-06-04', '2019-04-29 02:14:43', '2019-04-29 02:14:43'),
(64, 'E - 057 Dt', '2019-04-29', '-', '2019-06-04', '2019-04-29 02:16:59', '2019-04-29 02:16:59'),
(65, 'E - 058 Dt', '2019-04-29', '-', '2019-06-11', '2019-04-29 02:29:49', '2019-04-29 02:29:49'),
(66, 'E - 059 Dt', '2019-04-29', '-', '2019-05-14', '2019-04-29 02:34:47', '2019-04-29 02:34:47'),
(67, 'E- 060 Dt', '2019-04-29', '-', '2019-05-07', '2019-04-29 02:37:25', '2019-04-29 02:37:25'),
(68, 'E - 061 Dt', '2019-04-30', '-', '2019-05-10', '2019-04-30 03:50:32', '2019-04-30 03:57:26'),
(69, 'E - 062 Dt', '2019-05-02', '-', '2019-05-16', '2019-05-02 01:35:05', '2019-05-02 02:13:43'),
(70, 'E - 063 Dt', '2019-05-02', '-', '2019-05-09', '2019-05-02 01:37:52', '2019-05-02 01:37:52'),
(71, 'E - 064 Dt', '2019-05-02', '-', '2019-05-20', '2019-05-02 02:13:17', '2019-05-02 02:13:17'),
(73, 'E - 065 Dt', '2019-05-03', '-', '2019-05-24', '2019-05-03 02:11:05', '2019-05-03 02:11:05'),
(74, 'E - 066 Dt', '2019-05-03', '-', '2019-05-24', '2019-05-03 02:15:38', '2019-05-03 02:15:38'),
(75, 'E - 067 Dt', '2019-05-10', '-', '2019-05-17', '2019-05-10 06:54:29', '2019-05-10 06:54:29'),
(76, 'E - 068 Dt', '2019-05-13', '-', '2019-05-20', '2019-05-13 00:44:48', '2019-05-13 00:44:48'),
(77, 'E - 069 Dt', '2019-05-20', '-', '2019-05-27', '2019-05-20 02:09:47', '2019-05-20 02:09:47'),
(78, 'E - 070 Dt', '2019-05-21', '-', '2019-05-29', '2019-05-21 03:13:55', '2019-05-21 03:13:55'),
(79, 'E - 071 Dt', '2019-05-23', '-', '2019-05-30', '2019-05-23 02:24:09', '2019-05-23 02:24:09'),
(80, 'E - 072 Dt', '2019-05-23', '-', '2019-05-30', '2019-05-23 02:28:04', '2019-05-23 02:28:04'),
(81, 'I - 001 Dt', '2019-05-24', '-', '2019-05-31', '2019-05-24 07:49:09', '2019-05-24 07:49:09'),
(82, 'E - 073 Dt', '2019-05-27', '-', '2019-06-10', '2019-05-27 01:35:58', '2019-05-27 01:35:58'),
(83, 'E - 074 Dt', '2019-05-28', '-', '2019-06-12', '2019-05-28 02:23:40', '2019-05-28 02:23:40'),
(84, 'E - 075 Dt', '2019-06-11', '-', '2019-06-18', '2019-06-11 02:12:39', '2019-06-11 02:12:39'),
(85, 'E - 076 Dt', '2019-06-17', '-', '2019-06-24', '2019-06-17 03:22:51', '2019-06-17 03:22:51'),
(86, 'E - 077 Dt', '2019-06-17', '-', '2019-06-24', '2019-06-17 03:29:24', '2019-06-17 03:29:24'),
(87, 'E - 078 Dt', '2019-06-17', '-', '2019-06-24', '2019-06-17 03:55:49', '2019-06-17 03:55:49'),
(88, 'E - 079 Dt', '2019-06-17', '-', '2019-06-28', '2019-06-17 07:08:30', '2019-06-17 07:08:56'),
(89, 'E - 080 Dt', '2019-06-19', '-', '2019-06-26', '2019-06-19 01:50:27', '2019-06-19 01:50:27'),
(91, 'E - 082 Dt', '2019-06-19', '-', '2019-06-26', '2019-06-19 01:59:28', '2019-06-19 01:59:28'),
(92, 'E - 083 Dt', '2019-06-19', '-', '2019-06-26', '2019-06-19 02:58:35', '2019-06-19 02:58:35'),
(93, 'E - 081 Dt', '2019-06-20', '-', '2019-07-01', '2019-06-20 01:57:55', '2019-06-20 01:59:30'),
(94, 'E - 084 Dt', '2019-06-20', '-', '2019-07-01', '2019-06-20 02:36:30', '2019-06-20 02:36:30'),
(95, 'E - 085 Dt', '2019-06-21', '-', '2019-07-04', '2019-06-21 03:03:03', '2019-06-21 03:03:03'),
(96, 'E - 086 Dt', '2019-06-25', '-', '2019-07-05', '2019-06-25 01:42:19', '2019-06-25 01:42:19'),
(97, 'E - 087 Dt', '2019-06-25', '-', '2019-07-09', '2019-06-25 02:12:29', '2019-06-25 02:13:08'),
(98, 'E - 088 Dt', '2019-06-26', '-', '2019-07-10', '2019-06-26 02:12:12', '2019-06-26 02:12:12'),
(99, 'E - 089 Dt', '2019-07-04', '-', '2019-07-18', '2019-07-04 03:34:16', '2019-07-04 03:34:16'),
(100, 'E - 090 Dt', '2019-07-04', '-', '2019-07-18', '2019-07-04 03:36:47', '2019-07-04 03:36:47'),
(101, 'E - 091 Dt', '2019-07-04', '-', '2019-07-18', '2019-07-04 03:39:23', '2019-07-04 03:39:23'),
(102, 'E - 092 Dt', '2019-07-04', '-', '2019-07-19', '2019-07-04 07:20:02', '2019-07-04 07:20:02'),
(103, 'E - 093 Dt', '2019-07-09', 'Dana Dari Dinkes Paser', '2019-07-23', '2019-07-09 01:41:27', '2019-07-09 02:38:12'),
(104, 'E - 094 Dt', '2019-07-22', '-', '2019-08-09', '2019-07-22 05:56:44', '2019-07-22 05:56:44'),
(105, 'E - 095 Dt', '2019-07-24', 'Alat dari E - 050 .85 DLD', '2019-08-07', '2019-07-24 02:22:34', '2019-07-24 02:31:21'),
(106, 'E - 096 Dt', '2019-07-24', 'Alat dari E - 050.85 DLC', '2019-08-07', '2019-07-24 02:26:37', '2019-07-24 02:32:01'),
(107, 'E - 097 Dt', '2019-07-26', '-', '2019-08-02', '2019-07-26 03:26:55', '2019-07-26 03:26:55'),
(108, 'E - 098 Dt', '2019-07-29', '-', '2019-08-05', '2019-07-29 02:44:23', '2019-07-29 02:44:23'),
(109, 'E - 099 Dt', '2019-07-29', '-', '2019-08-12', '2019-07-29 06:50:57', '2019-07-29 06:50:57'),
(110, 'E - 100 Dt', '2019-07-31', '-', '2019-08-21', '2019-07-31 05:52:29', '2019-07-31 05:52:29'),
(111, 'E - 101 Dt', '2019-08-05', 'Dikirim', '2019-08-19', '2019-08-05 01:59:51', '2019-08-05 02:47:19'),
(112, 'E - 102 Dt', '2019-08-06', '-', '2019-08-20', '2019-08-06 02:39:54', '2019-08-06 02:39:54'),
(113, 'E - 103 Dt', '2019-08-06', '-', '2019-08-21', '2019-08-06 03:00:08', '2019-08-06 03:00:08'),
(114, 'E - 104 Dt', '2019-08-06', '-', '2019-08-21', '2019-08-06 03:01:52', '2019-08-06 03:01:52'),
(115, 'E - 105 Dt', '2019-08-06', '-', '2019-08-22', '2019-08-06 03:03:09', '2019-08-06 03:03:09'),
(116, 'E - 106 Dt', '2019-08-07', '-', '2019-08-16', '2019-08-07 01:25:47', '2019-08-07 01:25:47'),
(117, 'E - 107 Dt', '2019-08-07', '-', '2019-08-14', '2019-08-07 04:02:14', '2019-08-07 04:02:14'),
(118, 'E - 108 Dt', '2019-08-09', '-', '2019-08-23', '2019-08-09 07:46:06', '2019-08-09 07:46:06'),
(119, 'E - 109 Dt', '2019-08-13', '-', '2019-08-20', '2019-08-13 01:14:17', '2019-08-13 01:14:17'),
(120, 'E - 110 Dt', '2019-08-22', '-', '2019-08-30', '2019-08-22 02:49:23', '2019-08-22 02:49:23'),
(121, 'E - 111 Dt', '2019-08-22', '-', '2019-08-30', '2019-08-22 06:03:33', '2019-08-22 06:03:33'),
(122, 'E - 112 Dt', '2019-08-23', '-', '2019-08-30', '2019-08-23 02:27:44', '2019-08-23 02:27:44'),
(123, 'E - 113 Dt', '2019-08-23', '-', '2019-08-30', '2019-08-23 02:40:19', '2019-08-23 02:40:19'),
(124, 'E - 114 Dt', '2019-08-27', '-', '2019-09-04', '2019-08-27 01:40:05', '2019-08-27 01:40:05'),
(125, 'E - 115 Dt', '2019-08-28', '-', '2019-09-04', '2019-08-28 07:03:17', '2019-08-28 07:03:17'),
(126, 'E - 116 Dt', '2019-09-02', '-', '2019-09-09', '2019-09-02 00:21:32', '2019-09-02 00:21:32'),
(127, 'E - 117  Dt', '2019-09-03', '-', '2019-09-10', '2019-09-03 02:30:00', '2019-09-03 02:30:00'),
(128, 'E - 117 Dt', '2019-09-03', '-', '2019-09-10', '2019-09-03 02:33:32', '2019-09-03 02:33:32'),
(129, 'E - 118 Dt', '2019-09-03', '-', '2019-09-10', '2019-09-03 02:46:43', '2019-09-03 02:46:43'),
(130, 'E - 119 Dt', '2019-09-03', '-', '2019-09-10', '2019-09-03 02:56:30', '2019-09-03 02:56:30'),
(131, 'E - 120 Dt', '2019-09-03', '-', '2019-09-10', '2019-09-03 05:34:49', '2019-09-03 05:34:49'),
(132, 'E - 121 Dt', '2019-09-05', '-', '2019-09-12', '2019-09-05 03:16:25', '2019-09-05 03:16:25'),
(133, 'E - 122 Dt', '2019-09-05', '-', '2019-09-12', '2019-09-05 06:04:26', '2019-09-05 06:04:26'),
(134, 'E - 123 Dt', '2019-09-18', '-', '2019-09-26', '2019-09-18 02:14:12', '2019-09-18 02:14:12'),
(136, 'E - 124 Dt', '2019-09-23', '-', '2019-09-30', '2019-09-23 00:21:34', '2019-09-23 00:21:34'),
(137, 'E - 125 Dt', '2019-09-25', '-', '2019-10-04', '2019-09-25 03:46:10', '2019-09-25 03:46:10'),
(138, 'E - 126 Dt', '2019-09-25', '-', '2019-10-04', '2019-09-25 05:58:19', '2019-09-25 05:58:19'),
(139, 'E - 127 Dt', '2019-09-25', '-', '2019-10-04', '2019-09-25 06:00:04', '2019-09-25 06:00:04'),
(140, 'E - 128 Dt', '2019-09-25', '-', '2019-10-04', '2019-09-25 06:01:31', '2019-09-25 06:01:31'),
(141, 'E - 129 Dt', '2019-09-26', '-', '2019-10-11', '2019-09-26 00:51:07', '2019-09-26 00:51:07'),
(142, 'E - 130 Dt', '2019-09-26', '-', '2019-10-17', '2019-09-26 06:36:33', '2019-09-26 06:36:33'),
(143, 'E - 131 Dt', '2019-09-30', '-', '2019-10-14', '2019-09-30 01:09:40', '2019-09-30 01:09:40'),
(145, 'E - 132 Dt', '2019-10-02', '-', '2019-10-23', '2019-10-02 02:27:50', '2019-10-02 02:27:50'),
(146, 'E - 133 Dt', '2019-10-02', '-', '2019-10-23', '2019-10-02 04:01:07', '2019-10-02 04:01:07'),
(147, 'E - 134 Dt', '2019-10-02', '-', '2019-10-23', '2019-10-02 04:10:19', '2019-10-02 04:10:19'),
(148, 'E - 135 Dt', '2019-10-02', '-', '2019-10-23', '2019-10-02 04:13:03', '2019-10-02 04:13:03'),
(149, 'E - 136 Dt', '2019-10-02', '-', '2019-10-23', '2019-10-02 04:14:37', '2019-10-02 04:14:37'),
(150, 'E - 137 Dt', '2019-10-02', '-', '2019-10-23', '2019-10-02 04:16:22', '2019-10-02 04:16:22'),
(151, 'E - 138 Dt', '2019-10-02', '-', '2019-10-23', '2019-10-02 04:19:38', '2019-10-02 04:19:38'),
(152, 'E - 139 Dt', '2019-10-02', '-', '2019-10-23', '2019-10-02 04:21:36', '2019-10-02 04:21:36'),
(153, 'E - 140 Dt', '2019-10-03', '-', '2019-10-17', '2019-10-03 03:05:46', '2019-10-03 03:05:46'),
(154, 'E - 141 Dt', '2019-10-03', '-', '2019-10-18', '2019-10-03 03:07:11', '2019-10-03 03:07:11'),
(155, 'E - 142 Dt', '2019-10-03', '-', '2019-10-18', '2019-10-03 03:09:20', '2019-10-03 03:09:20'),
(156, 'E - 143 Dt', '2019-10-03', 'Menunggu petugas dan alat standar datang', '2019-10-31', '2019-10-03 05:36:12', '2019-10-03 05:36:12'),
(157, 'E - 144 Dt', '2019-10-07', '-', '2019-10-25', '2019-10-07 02:19:07', '2019-10-07 02:19:07'),
(158, 'E - 145 Dt', '2019-10-07', '-', '2019-10-25', '2019-10-07 06:08:52', '2019-10-07 06:08:52'),
(159, 'E - 146 Dt', '2019-10-09', '-', '2019-10-25', '2019-10-09 01:07:00', '2019-10-09 01:07:00'),
(161, 'E - 147 Dt', '2019-10-11', '-', '2019-10-31', '2019-10-11 01:33:45', '2019-10-11 01:33:45'),
(162, 'E - 148 Dt', '2019-10-11', '-', '2019-10-14', '2019-10-11 02:16:24', '2019-10-11 02:16:24'),
(163, 'E - 149 Dt', '2019-10-11', 'Menunggu petugas dan alat standar', '2019-10-31', '2019-10-11 02:52:19', '2019-10-11 02:52:19'),
(164, 'E - 150 Dt', '2019-10-17', '-', '2019-10-31', '2019-10-17 02:44:34', '2019-10-17 02:44:34'),
(165, 'E - 151 Dt', '2019-10-17', '-', '2019-11-01', '2019-10-17 03:56:11', '2019-10-17 03:56:11'),
(166, 'E - 152 Dt', '2019-10-17', '-', '2019-10-31', '2019-10-17 06:16:30', '2019-10-17 06:16:30'),
(167, 'E - 153 Dt', '2019-10-17', '-', '2019-10-31', '2019-10-17 06:21:27', '2019-10-17 06:21:27'),
(168, 'E-154 Dt', '2019-10-21', '-', '2019-10-28', '2019-10-21 05:32:31', '2019-10-21 05:32:31'),
(169, 'E - 155 Dt', '2019-10-21', '-', '2019-10-28', '2019-10-21 05:39:28', '2019-10-21 05:39:28'),
(170, 'E - 156 Dt', '2019-10-22', '-', '2019-11-05', '2019-10-22 06:30:29', '2019-10-22 06:30:29'),
(171, 'E -157 Dt', '2019-10-23', '-', '2019-10-30', '2019-10-23 02:57:21', '2019-10-23 02:57:21'),
(172, 'E - 158 Dt', '2019-10-23', '-', '2019-10-30', '2019-10-23 04:22:15', '2019-10-23 04:22:15'),
(174, 'E - 159 Dt', '2019-10-23', '-', '2019-10-30', '2019-10-23 05:39:15', '2019-10-23 05:39:15'),
(175, 'E - 160 Dt', '2019-10-23', '-', '2019-10-30', '2019-10-23 05:43:07', '2019-10-23 05:43:07'),
(176, 'E - 161 Dt', '2019-10-24', '-', '2019-10-31', '2019-10-24 00:32:52', '2019-10-24 00:32:52'),
(177, 'E - 162 Dt', '2019-10-24', '-', '2019-11-07', '2019-10-24 01:43:39', '2019-10-24 01:43:39'),
(178, 'E - 163 Dt', '2019-10-24', '-', '2019-11-07', '2019-10-24 02:05:58', '2019-10-24 02:05:58'),
(179, 'E - 164 Dt', '2019-10-25', '-', '2019-11-01', '2019-10-25 02:17:36', '2019-10-25 02:17:36'),
(182, 'E - 165 Dt', '2019-10-29', '-', '2019-11-01', '2019-10-29 04:17:31', '2019-10-29 04:17:31'),
(183, 'E - 166 Dt', '2019-11-01', '-', '2019-11-15', '2019-11-01 03:04:52', '2019-11-01 03:04:52'),
(184, 'E - 167 Dt', '2019-11-04', '-', '2019-11-18', '2019-11-04 02:36:44', '2019-11-04 02:36:44'),
(185, 'E - 170 Dt', '2019-11-05', '-', '2019-11-19', '2019-11-05 00:49:57', '2019-11-05 00:49:57'),
(186, 'E - 168 Dt', '2019-11-04', '-', '2019-11-19', '2019-11-05 02:00:10', '2019-11-05 02:00:10'),
(187, 'E - 171 Dt', '2019-11-05', '-', '2019-11-22', '2019-11-05 02:08:55', '2019-11-05 02:08:55'),
(188, 'E - 169 Dt', '2019-11-04', '-', '2019-11-12', '2019-11-05 02:11:07', '2019-11-05 02:11:07'),
(189, 'E - 172 Dt', '2019-11-05', '-', '2019-11-14', '2019-11-05 03:48:53', '2019-11-05 03:48:53'),
(190, 'E - 173 Dt', '2019-11-07', '-', '2019-11-15', '2019-11-07 02:34:11', '2019-11-07 02:34:11'),
(191, 'E - 174 Dt', '2019-11-08', '-', '2019-11-15', '2019-11-08 01:42:07', '2019-11-08 01:42:07'),
(192, 'E - 175 Dt', '2019-11-11', '-', '2019-11-29', '2019-11-11 05:29:31', '2019-11-11 05:29:31'),
(193, 'E - 176 Dt', '2019-11-12', '-', '2019-12-12', '2019-11-12 07:09:57', '2019-11-12 07:09:57'),
(194, 'E - 177 Dt', '2019-11-13', '-', '2019-11-22', '2019-11-13 01:44:25', '2019-11-13 01:44:25'),
(195, 'E - 178 Dt', '2019-11-13', '-', '2019-11-22', '2019-11-13 01:50:37', '2019-11-13 01:50:37'),
(196, 'E - 179 Dt', '2019-11-13', '-', '2019-11-22', '2019-11-13 01:55:42', '2019-11-13 01:55:42'),
(197, 'E - 180 Dt', '2019-11-15', '-', '2019-11-29', '2019-11-15 02:03:42', '2019-11-15 02:03:42'),
(198, 'E - 181 Dt', '2019-11-18', '-', '2019-12-06', '2019-11-18 00:26:47', '2019-11-18 00:26:47'),
(199, 'E - 182 Dt', '2019-11-18', '-', '2019-11-29', '2019-11-18 06:26:28', '2019-11-18 06:26:28'),
(200, 'E - 183 Dt', '2019-11-25', '-', '2019-12-06', '2019-11-25 02:20:12', '2019-11-25 02:20:12'),
(201, 'E - 184 Dt', '2019-11-27', '-', '2019-12-13', '2019-11-27 02:21:49', '2019-11-27 02:21:49'),
(202, 'E - 185 Dt', '2019-11-29', '-', '2019-12-20', '2019-11-29 01:02:11', '2019-11-29 01:02:11'),
(203, 'E - 186 Dt', '2019-12-02', '-', '2019-12-20', '2019-12-02 05:18:22', '2019-12-02 05:18:22'),
(204, 'E - 187 Dt', '2019-12-05', '-', '2019-12-31', '2019-12-05 06:34:54', '2019-12-05 06:34:54'),
(205, 'E - 188 Dt', '2019-12-05', '-', '2019-12-31', '2019-12-05 06:44:54', '2019-12-05 06:44:54'),
(206, 'E - 189 Dt', '2019-12-05', '-', '2019-12-31', '2019-12-05 06:50:23', '2019-12-05 06:50:23'),
(207, 'E - 190 Dt', '2019-12-05', '-', '2019-12-31', '2019-12-05 07:01:49', '2019-12-05 07:01:49'),
(208, 'E - 191 Dt', '2019-12-06', '-', '2019-12-27', '2019-12-06 01:33:54', '2019-12-06 01:33:54'),
(209, 'E - 192 Dt', '2019-12-06', '-', '2019-12-27', '2019-12-06 06:47:44', '2019-12-06 06:47:44'),
(210, 'E - 193 Dt', '2019-12-09', '-', '2019-12-31', '2019-12-09 00:22:12', '2019-12-09 00:22:12'),
(211, 'E - 194 Dt', '2019-12-09', '-', '2019-12-31', '2019-12-09 06:41:51', '2019-12-09 06:41:51'),
(212, 'E - 195 Dt', '2019-12-09', '-', '2019-12-31', '2019-12-09 07:30:15', '2019-12-09 07:30:15'),
(213, 'E - 196 Dt', '2019-12-13', '-', '2019-12-27', '2019-12-13 02:35:28', '2019-12-13 02:35:28'),
(214, 'E - 197 Dt', '2019-12-19', '-', '2019-12-31', '2019-12-19 07:53:09', '2019-12-19 07:53:09'),
(215, 'E - 198 Dt', '2019-12-23', '-', '2020-01-10', '2019-12-23 02:42:50', '2019-12-23 02:42:50'),
(216, 'E - 001 Dt', '2020-01-02', '-', '2020-01-03', '2020-01-02 01:59:53', '2019-12-31 02:00:16'),
(219, 'E - 002 Dt', '2020-01-06', '-', '2020-01-16', '2020-01-06 02:15:09', '2020-01-06 02:15:09'),
(220, 'E - 003 Dt', '2020-01-20', '-', '2020-01-24', '2020-01-20 04:52:52', '2020-01-20 04:52:52'),
(221, 'E - 004 Dt', '2020-01-21', '-', '2020-01-22', '2020-01-21 04:26:27', '2020-01-21 04:26:27'),
(222, 'E - 005 Dt', '2020-01-22', '-', '2020-01-31', '2020-01-22 02:26:57', '2020-01-22 02:26:57'),
(223, 'E - 006 Dt', '2020-01-28', '-', '2020-02-04', '2020-01-28 07:37:32', '2020-01-28 07:37:32'),
(224, 'E - 007 Dt', '2020-02-06', '-', '2020-02-13', '2020-02-06 02:42:42', '2020-02-06 02:42:42'),
(225, 'E - 008 Dt', '2020-02-11', '-', '2020-02-18', '2020-02-11 06:07:59', '2020-02-11 06:07:59'),
(226, 'E - 008 Dt', '2020-02-11', '-', '2020-02-18', '2020-02-11 06:10:42', '2020-02-11 06:10:42'),
(227, 'E - 009 Dt', '2020-02-11', '-', '2020-02-18', '2020-02-11 07:56:59', '2020-02-11 07:56:59'),
(228, 'E - 010 Dt', '2020-02-12', '-', '2020-02-19', '2020-02-12 04:55:31', '2020-02-12 04:55:31'),
(229, 'E - 011 Dt', '2020-02-13', '-', '2020-02-20', '2020-02-13 05:40:04', '2020-02-13 05:40:04'),
(230, 'E - 012 Dt', '2020-02-24', 'Alat diterima via paket pengiriman', '2020-03-05', '2020-02-24 07:24:09', '2020-02-24 07:24:09'),
(231, 'E - 013 Dt', '2020-02-25', '-', '2020-03-03', '2020-02-25 05:47:00', '2020-02-25 05:47:00'),
(232, 'E - 014 Dt', '2020-02-27', '-', '2020-03-06', '2020-02-27 06:42:00', '2020-02-27 06:42:00'),
(233, 'E - 015 Dt', '2020-03-02', '-', '2020-03-09', '2020-03-02 02:31:53', '2020-03-02 02:31:53'),
(234, 'E - 016 Dt', '2020-03-02', '-', '2020-03-09', '2020-03-02 02:35:23', '2020-03-02 02:35:23'),
(235, 'E - 017 Dt', '2020-03-02', '-', '2020-03-09', '2020-03-02 07:07:21', '2020-03-02 07:07:21'),
(236, 'E - 018 Dt', '2020-03-05', '-', '2020-03-12', '2020-03-05 01:18:56', '2020-03-05 01:18:56'),
(237, 'E - 019 Dt', '2020-03-06', '-', '2020-03-20', '2020-03-06 06:42:30', '2020-03-06 06:42:30'),
(238, 'E - 020 Dt', '2020-03-12', '-', '2020-03-19', '2020-03-12 05:47:38', '2020-03-12 05:47:38'),
(239, 'E - 021 Dt', '2020-03-13', '-', '2020-03-20', '2020-03-13 03:44:28', '2020-03-13 03:44:28'),
(240, 'E - 022 Dt', '2020-04-24', 'diperiksa pada tanggal 7 April 2020', '2020-05-11', '2020-04-07 02:34:05', '2020-04-07 02:34:05'),
(241, 'E - 023 Dt', '2020-06-15', 'Datang pada tanggal 5 Juni 2020', '2020-06-22', '2020-06-15 07:41:23', '2020-06-15 09:08:34'),
(242, 'E - 024 Dt', '2020-06-15', 'Datang pada tangga; 5 Juni 2020', '2020-07-06', '2020-06-15 07:58:29', '2020-06-15 07:58:29'),
(243, 'E - 025 Dt', '2020-06-15', 'Datang pada tangga; 5 Juni 2020', '2020-07-13', '2020-06-15 08:02:15', '2020-06-15 08:02:15'),
(244, 'E - 026 Dt', '2020-06-15', 'datang pada tanggal 5 juni 2020', '2020-07-13', '2020-06-15 08:08:08', '2020-06-15 09:10:21'),
(245, 'E - 027 Dt', '2020-06-15', 'diterima pada tanggal 5 Juni 2020', '2020-07-13', '2020-06-15 08:17:35', '2020-06-15 08:17:35'),
(246, 'E - 028 Dt', '2020-06-15', 'diterima pada tanggal 5 juni 2020', '2020-07-20', '2020-06-15 08:27:52', '2020-06-15 08:27:52'),
(247, 'E - 029 Dt', '2020-06-25', '-', '2020-07-02', '2020-06-25 03:12:56', '2020-06-25 03:12:56'),
(248, 'E - 030 Dt', '2020-06-25', '-', '2020-07-09', '2020-06-25 03:16:21', '2020-06-25 03:16:21'),
(249, 'E - 031 Dt', '2020-06-30', '-', '2020-07-07', '2020-06-30 01:00:10', '2020-06-30 01:00:10'),
(250, 'E - 032 Dt', '2020-07-02', '-', '2020-07-09', '2020-07-02 06:09:54', '2020-07-02 06:09:54'),
(251, 'E - 033 Dt', '2020-07-06', '-', '2020-07-20', '2020-07-06 07:56:39', '2020-07-06 07:56:39'),
(252, 'E - 034 Dt', '2020-07-10', '-', '2020-07-17', '2020-07-10 00:57:54', '2020-07-22 01:01:08'),
(253, 'E - 035 Dt', '2020-07-22', '-', '2020-07-29', '2020-07-22 02:18:29', '2020-07-22 02:18:29'),
(254, 'E - 036 Dt', '2020-07-22', '-', '2020-08-05', '2020-07-22 03:11:00', '2020-07-22 03:11:00'),
(255, 'E - 037 Dt', '2020-07-22', '-', '2020-08-12', '2020-07-22 03:23:43', '2020-07-22 03:23:43'),
(256, 'E - 038 Dt', '2020-07-30', '(Dikirim)', '2020-08-07', '2020-07-30 04:26:08', '2020-07-30 04:26:08'),
(257, 'E - 039 Dt', '2020-08-03', '-', '2020-08-14', '2020-08-03 07:02:10', '2020-08-03 07:02:10'),
(258, 'E - 040 Dt', '2020-08-06', 'ECG kurang bagus ada trilling tidak dimasukkan dalam BA', '2020-08-13', '2020-08-06 00:38:16', '2020-08-19 05:24:14'),
(259, 'E - 041 Dt', '2020-08-06', '-', '2020-08-20', '2020-08-06 00:42:33', '2020-08-06 00:42:33'),
(261, 'E - 043 Dt', '2020-08-06', '-', '2020-09-03', '2020-08-06 01:09:23', '2020-08-06 01:09:23'),
(262, 'E - 043 Dt', '2020-08-06', '-', '2020-09-24', '2020-08-06 01:11:57', '2020-08-06 01:11:57'),
(263, 'E - 044 Dt', '2020-08-06', '1. ECG tidak bisa print tidak dimasukkan ke BA', '2020-09-03', '2020-08-06 02:54:57', '2020-08-19 05:19:51'),
(264, 'E - 045 Dt', '2020-08-06', '-', '2020-09-03', '2020-08-06 05:53:48', '2020-08-06 05:53:48'),
(265, 'E - 046 Dt', '2020-08-06', 'Suction pump rusak (pressure gauge tidak berfungsi) sehingga tidak bisa dikalibrasi.', '2020-09-03', '2020-08-06 06:14:17', '2020-08-25 01:31:38'),
(266, 'E - 047 Dt', '2020-08-06', '1 Timbangan bayi rusak, 1 head lamp rusak, dan flowmeter tidak bisa dikalibrasi, tidak dimasukkan dalam BA', '2020-09-03', '2020-08-06 07:06:21', '2020-08-25 01:30:31'),
(267, 'E - 048 Dt', '2020-08-06', '-', '2020-09-03', '2020-08-06 07:50:35', '2020-08-06 07:50:35'),
(268, 'E - 049 dT', '2020-08-06', '-', '2020-09-10', '2020-08-06 08:03:25', '2020-08-06 08:03:25'),
(269, 'E - 050 Dt', '2020-08-06', '-', '2020-09-03', '2020-08-06 08:14:45', '2020-08-06 08:14:45'),
(270, 'E - 051 Dt', '2020-08-11', '-', '2020-09-04', '2020-08-10 05:49:46', '2020-08-18 05:30:37'),
(271, 'E - 052 Dt', '2020-08-11', '-', '2020-08-18', '2020-08-11 08:58:36', '2020-08-11 08:58:36'),
(272, 'E - 042 Dt', '2020-08-08', '-', '2020-09-03', '2020-08-18 05:21:22', '2020-08-18 05:21:22'),
(273, 'E - 054 Dt', '2020-08-18', 'Dikirim', '2020-09-11', '2020-08-18 05:36:50', '2020-08-18 05:36:50'),
(274, 'E - 053 Dt', '2020-08-13', 'Dikirim', '2020-08-28', '2020-08-18 06:08:47', '2020-08-18 06:08:47'),
(275, 'E - 055 Dt', '2020-08-24', 'Tensimeter ada 1 yang bergelembung tidak dicantumkan dalam BA', '2020-08-31', '2020-08-24 07:52:09', '2020-08-24 07:52:09'),
(276, 'E - 056 Dt', '2020-08-24', '-', '2020-08-31', '2020-08-24 08:15:23', '2020-08-24 08:15:23'),
(277, 'E - 057 Dt', '2020-08-24', '-', '2020-08-31', '2020-08-24 08:29:52', '2020-08-24 08:29:52'),
(278, 'E - 058 Dt', '2020-08-24', 'Spirometer display bermasalah tidak dicantumkan dalam BA', '2020-09-03', '2020-08-24 08:35:29', '2020-08-26 02:32:54'),
(280, 'E - 059 Dt', '2020-08-24', '-', '2020-09-03', '2020-08-25 03:43:48', '2020-08-25 03:43:48'),
(281, 'E - 059 Dt', '2020-08-24', '-', '2020-09-03', '2020-08-25 03:46:16', '2020-08-25 03:46:16'),
(282, 'E - 060 Dt', '2020-08-25', 'Audiometer headphone oval tidak bisa dikalibrasi tidak dicantumkan dalam BA', '2020-09-02', '2020-08-26 02:59:28', '2020-08-26 02:59:28'),
(283, 'E - 061 Dt', '2020-08-28', 'Lampu Exam (1) Batal Karena Lampu Tidak Menyala, Tensimeter Aneroid (2) Batal Karena Jarum tidak pas di 0.\r\nDibayarkan oleh Dinas Kesehatan Kota Banjarbaru', '2020-09-04', '2020-08-28 07:16:15', '2020-08-28 07:47:17'),
(284, 'E - 062 Dt', '2020-08-31', '-', '2020-09-01', '2020-08-31 01:57:41', '2020-08-31 01:57:41'),
(285, 'E - 063 Dt', '2020-09-01', 'Audiometer TMC Tabalong Tidak bisa dikalibrasi (headphone kanan tidak berfungsi)', '2020-09-04', '2020-09-01 07:50:41', '2020-09-01 07:50:41'),
(286, 'E - 064 Dt', '2020-09-03', '-', '2020-09-10', '2020-09-04 08:50:00', '2020-09-04 08:50:00'),
(287, 'E - 065 Dt', '2020-09-07', '-', '2020-09-14', '2020-09-07 08:19:21', '2020-09-07 08:19:21'),
(288, 'E - 066 Dt', '2020-09-07', '-', '2020-09-14', '2020-09-09 01:04:03', '2020-09-09 01:04:03'),
(289, 'E - 067 Dt', '2020-09-07', '-', '2020-09-21', '2020-09-09 01:05:33', '2020-09-09 01:05:33'),
(290, 'E - 068 Dt', '2020-09-07', '-', '2020-09-28', '2020-09-09 01:09:21', '2020-09-09 01:09:21'),
(291, 'E - 069 Dt', '2020-09-07', '-', '2020-09-28', '2020-09-09 01:11:03', '2020-09-09 01:11:03'),
(292, 'E - 070 Dt', '2020-09-07', '-', '2020-09-28', '2020-09-09 06:34:11', '2020-09-09 06:34:11'),
(293, 'E - 071 Dt', '2020-09-07', '-', '2020-09-28', '2020-09-09 06:36:21', '2020-09-09 06:36:21'),
(294, 'E - 072 Dt', '2020-09-07', 'Dibayarkan Oleh Dinkes Banjarbaru', '2020-09-21', '2020-09-09 06:40:03', '2020-09-11 01:40:39'),
(295, 'E - 073 Dt', '2020-09-09', '-', '2020-09-16', '2020-09-09 06:53:12', '2020-09-09 06:53:12'),
(296, 'E - 074 Dt', '2020-09-10', 'Biaya Dibayarkan Dinkes Banjarbaru', '2020-09-24', '2020-09-10 08:29:13', '2020-09-14 08:53:48'),
(297, 'E - 075 Dt', '2020-09-10', '-', '2020-09-24', '2020-09-10 08:40:28', '2020-09-10 08:40:28'),
(298, 'E - 076 Dt', '2020-09-10', 'Biaya Dibayarkan Dinkes Banjarbaru', '2020-09-24', '2020-09-10 08:43:49', '2020-09-14 08:53:22'),
(299, 'E - 077 Dt', '2020-09-18', 'Biaya dibayarkan dinkes kota banjarbaru', '2020-09-22', '2020-09-18 07:24:52', '2020-09-18 07:24:52'),
(300, 'E - 078 Dt', '2020-09-21', '-', '2020-09-28', '2020-09-21 06:48:09', '2020-09-21 06:48:09'),
(301, 'E - 079 Dt', '2020-09-28', '-', '2020-09-30', '2020-09-28 07:19:42', '2020-09-28 07:19:42'),
(302, 'E - 080 Dt', '2020-09-28', 'Dikirim', '2020-10-05', '2020-09-28 07:25:22', '2020-09-28 07:25:22'),
(303, 'E - 081 Dt', '2020-09-28', 'Dibayarkan oleh dinas kesehatan kota banjarbaru', '2020-10-09', '2020-09-28 07:29:40', '2020-09-28 07:29:40'),
(304, 'E - 087 Dt', '2020-09-28', '-', '2020-09-30', '2020-09-28 08:05:56', '2020-09-28 08:05:56'),
(305, 'E - 082 Dt', '2020-09-29', '-', '2020-10-06', '2020-09-29 08:24:42', '2020-09-29 08:24:42'),
(306, 'E - 083 Dt', '2020-09-29', '-', '2020-10-06', '2020-09-29 08:28:58', '2020-09-29 08:28:58'),
(307, 'E - 084 Dt', '2020-09-29', 'termometer 3 belum bisa, suction pump 1 rusak, exam lamp rusak 2, tensimeter anak 1 rusak, ecg 1  tidak dicantumkan dalam BA', '2020-10-06', '2020-09-29 08:38:40', '2020-10-06 03:25:26'),
(308, 'E - 085 Dt', '2020-09-29', 'Termometer digital (3) dan timbangan digital (1) belum bisa dikalibrasi tidak dicantumkan dalam BA', '2020-10-13', '2020-10-01 03:25:21', '2020-10-06 03:41:46'),
(309, 'E - 086 Dt', '2020-09-29', 'ECG 1 tidak dicantumkan dalam BA', '2020-10-14', '2020-10-01 03:34:39', '2020-10-01 06:25:47'),
(310, 'E - 088 Dt', '2020-09-29', 'centrifuge 1  rusak tidak dimasukkan dalam BA', '2020-10-13', '2020-10-01 05:58:20', '2020-10-01 06:16:25'),
(311, 'E - 089 Dt', '2020-09-29', '-', '2020-10-13', '2020-10-01 06:43:39', '2020-10-01 06:43:39'),
(312, 'E - 090 Dt', '2020-09-29', '-', '2020-10-13', '2020-10-01 07:17:28', '2020-10-01 07:17:28'),
(313, 'E - 091 Dt', '2020-09-30', '-', '2020-10-07', '2020-10-01 07:21:55', '2020-10-01 07:21:55'),
(314, 'E - 092 Dt', '2020-09-29', 'Termometer 2 tidak dicantumkan dalam BA, Timbangan Bayi Batal Kalibrasi', '2020-10-14', '2020-10-01 07:36:56', '2020-10-02 08:15:52'),
(315, 'E - 093 Dt', '2020-09-30', 'tidak terdapat centrifuge, ECG Batal Kalibrasi', '2020-10-15', '2020-10-01 07:50:44', '2020-10-02 08:16:22'),
(316, 'E - 094 Dt', '2020-09-30', 'head lamp tidak dicantumkan dalam BA', '2020-10-20', '2020-10-01 07:59:23', '2020-10-06 07:45:36'),
(317, 'E - 095 Dt', '2020-09-30', '-', '2020-10-14', '2020-10-01 08:24:06', '2020-10-01 08:24:06'),
(318, 'E - 096 Dt', '2020-10-02', '-', '2020-10-09', '2020-10-02 08:29:18', '2020-10-02 08:29:18'),
(319, 'E - 097 Dt', '2020-10-02', '-', '2020-10-16', '2020-10-02 09:00:19', '2020-10-02 09:00:19'),
(320, 'E - 098 Dt', '2020-10-02', 'Audiometer batal dikalibrasi (headphone sebelah kiri tidak berfungsi)', '2020-10-16', '2020-10-02 09:03:07', '2020-10-05 06:03:28'),
(321, 'E - 099 Dt', '2020-10-06', 'Dibayarkan oleh dinas kesehatan kota banjarbaru', '2020-10-13', '2020-10-06 03:22:03', '2020-10-06 03:22:03'),
(323, 'E - 100 Dt', '2020-10-07', 'Pembayaran dibayarkan oleh Dinkes Kab. Balangan. 1 Suction Pump Batal', '2020-10-14', '2020-10-08 00:28:50', '2020-10-08 00:28:50'),
(324, 'E - 101 Dt', '2020-10-07', 'Biaya dibayarkan Dinkes Kab. Balangan. Timbangan Bayi Batal.', '2020-10-19', '2020-10-08 01:27:10', '2020-10-08 01:27:10'),
(325, 'E - 102 Dt', '2020-10-07', 'Biaya dibayarkan Dinkes Kab. Balangan.', '2020-10-21', '2020-10-08 01:34:21', '2020-10-08 01:34:21'),
(326, 'E - 103 Dt', '2020-10-07', 'Biaya Dibayarkan Dinkes Kab. Balangan', '2020-10-23', '2020-10-08 01:56:29', '2020-10-08 01:56:29'),
(327, 'E - 104 Dt', '2020-10-07', 'Biaya Dibayarkan Dinkes Kab. Balangan', '2020-10-26', '2020-10-08 02:43:33', '2020-10-08 02:43:33'),
(328, 'E - 105 Dt', '2020-10-07', 'Biaya Dibayarkan Dinkes Kab. Balangan. Centrifuge Batal (Timer tidak bisa diatur)', '2020-10-28', '2020-10-08 02:48:38', '2020-10-08 02:57:36'),
(329, 'E - 106 Dt', '2020-10-07', 'Biaya Dibayarkan Dinkes Kab. Balangan', '2020-10-30', '2020-10-08 03:01:31', '2020-10-08 03:01:31'),
(330, 'E - 107 Dt', '2020-10-07', 'Biaya Dibayarkan Dinkes Kab. Balangan. Satu (1) Sphygmomanometer/Tensimeter Batal.', '2020-11-02', '2020-10-08 03:05:53', '2020-10-08 03:06:48'),
(331, 'E - 108 Dt', '2020-10-07', 'Biaya Dibayarkan Dinkes Kab. Balangan', '2020-11-03', '2020-10-08 03:12:56', '2020-10-08 03:12:56'),
(332, 'E - 109 Dt', '2020-10-07', '-', '2020-10-16', '2020-10-08 03:17:05', '2020-10-08 03:17:05'),
(333, 'E - 110 Dt', '2020-10-07', '-', '2020-10-16', '2020-10-08 03:23:00', '2020-10-08 03:23:00'),
(334, 'E - 111 Dt', '2020-10-09', '-', '2020-10-13', '2020-10-09 00:37:18', '2020-10-09 00:37:18'),
(335, 'E - 112 Dt', '2020-10-13', '-', '2020-10-16', '2020-10-13 00:56:19', '2020-10-13 00:56:19'),
(336, 'E - 113 Dt', '2020-10-13', 'Biaya Dibayarkan Dinkes Kab. Sukamara', '2020-10-23', '2020-10-14 01:52:13', '2020-10-14 01:52:13'),
(337, 'E - 114 Dt', '2020-10-13', 'Biaya Dibayarkan Dinkes Kab. Sukamara', '2020-10-26', '2020-10-14 02:00:30', '2020-10-14 02:00:30'),
(338, 'E - 115 Dt', '2020-10-13', 'Biaya dibayarkan Dinkes Kab, Sukamara', '2020-10-28', '2020-10-14 02:02:28', '2020-10-14 02:02:28'),
(339, 'E - 116 Dt', '2020-10-13', '-', '2020-10-29', '2020-10-14 02:12:11', '2020-10-14 02:12:11'),
(340, 'E - 117 Dt', '2020-10-14', '-', '2020-10-15', '2020-10-15 07:30:57', '2020-10-15 07:30:57'),
(341, 'E - 118 Dt', '2020-10-15', '-', '2020-10-23', '2020-10-20 02:44:12', '2020-10-20 02:44:12'),
(342, 'E - 119 Dt', '2020-10-15', 'menunggu alat standar', '2020-11-03', '2020-10-20 03:10:38', '2020-10-20 03:10:38'),
(343, 'E - 120 Dt', '2020-10-15', '-', '2020-10-27', '2020-10-20 03:22:43', '2020-10-20 03:22:43'),
(344, 'E - 121 Dt', '2020-10-20', '-', '2020-10-27', '2020-10-20 08:27:56', '2020-10-20 08:27:56'),
(345, 'E - 121 Dt', '2020-10-20', '-', '2020-10-27', '2020-10-20 08:29:27', '2020-10-20 08:29:27'),
(346, 'E - 122 Dt', '2020-10-20', '- 1 bpm rusak tidak dicantumkan dalam BA\r\n- Pembiayaan dari Dinkes', '2020-11-03', '2020-10-20 08:33:37', '2020-10-20 08:36:55'),
(347, 'E - 130 Dt', '2020-10-22', '-', '2020-10-23', '2020-10-23 01:39:10', '2020-10-23 01:39:10'),
(348, 'E - 123 Dt', '2020-11-02', '-', '2020-10-30', '2020-10-27 02:56:17', '2020-11-03 07:24:19'),
(349, 'E - 124 Dt', '2020-11-02', 'Flowmeter (fisik kurang baik), Head Lamp (lampu redup) dan nebulizer (fungsinya tidak baik) tidqak dicantumkan dalam BA', '2020-11-06', '2020-10-27 03:07:17', '2020-11-06 09:18:53'),
(351, 'E - 125 Dt', '2020-11-02', 'Suction pump dan headlamp rusak tidak dicantumkan dalam BA', '2020-11-13', '2020-10-27 03:30:20', '2020-11-03 07:23:22'),
(352, 'E - 126 Dt', '2020-11-02', '-', '2020-11-27', '2020-10-27 03:44:11', '2020-11-03 07:22:14'),
(353, 'E - 127 Dt', '2020-10-02', 'head lamp rusak tidak dicantumkan dalam BA', '2020-11-27', '2020-10-27 04:01:17', '2020-11-03 07:21:42'),
(355, 'E - 128 Dt', '2020-11-02', '-', '2020-11-27', '2020-10-27 04:23:48', '2020-11-03 07:20:56'),
(356, 'E - 129 Dt', '2020-11-02', '-', '2020-11-27', '2020-10-27 04:31:12', '2020-11-03 07:20:33'),
(357, '23445', '2021-01-17', 'gdgrdrgd', '2021-01-18', '2021-01-17 10:16:04', '2021-01-17 10:16:04');

-- --------------------------------------------------------

--
-- Table structure for table `lab_penyerahan`
--

CREATE TABLE `lab_penyerahan` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `tgl_serah` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_order` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `petugas_lab` int(11) NOT NULL,
  `petugas_yantek` int(11) NOT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_penyerahan`
--

INSERT INTO `lab_penyerahan` (`id`, `id_order`, `tgl_serah`, `no_order`, `petugas_lab`, `petugas_yantek`, `catatan`, `created_at`, `updated_at`) VALUES
(2, 3, '2019-01-25', 'E - 002 Dt', 9, 17, '', '2019-01-24 09:18:39', '2019-01-24 09:18:39'),
(3, 4, '2019-01-31', 'E - 004 Dt', 11, 17, '', '2019-01-30 14:05:28', '2019-01-30 14:05:28'),
(5, 5, '2019-02-04', 'E - 005 Dt', 10, 17, '', '2019-02-06 07:54:23', '2019-02-06 07:54:23'),
(6, 6, '2019-02-06', 'E - 006 Dt', 12, 17, '', '2019-02-10 09:33:33', '2019-02-10 09:33:33'),
(7, 6, '2019-02-06', 'E - 006 Dt', 10, 17, '', '2019-02-10 09:37:13', '2019-02-10 09:37:13'),
(8, 6, '2019-02-06', 'E - 006 Dt', 6, 17, '', '2019-02-10 09:37:33', '2019-02-10 09:37:33'),
(9, 6, '2019-02-06', 'E - 006 Dt', 9, 17, '', '2019-02-10 09:40:41', '2019-02-10 09:40:41'),
(10, 8, '2019-02-13', 'E - 008 Dt', 9, 17, '', '2019-02-19 09:42:17', '2019-02-19 09:42:17'),
(11, 8, '2019-02-14', 'E - 008 Dt', 13, 17, '', '2019-02-19 09:43:43', '2019-02-19 09:43:43'),
(12, 8, '2019-02-18', 'E - 008 Dt', 12, 17, '', '2019-02-19 09:44:33', '2019-02-19 09:44:33'),
(13, 9, '2019-02-18', 'E - 009 Dt', 10, 18, '', '2019-02-19 09:46:24', '2019-02-19 09:46:24'),
(14, 7, '2019-02-19', 'E - 007 Dt', 12, 18, '', '2019-02-19 09:48:19', '2019-02-19 09:48:19'),
(15, 11, '2019-02-19', 'E - 010 Dt', 11, 18, '', '2019-02-19 09:49:51', '2019-02-19 09:49:51'),
(16, 12, '2019-02-22', 'E - 011 Dt', 11, 17, '', '2019-02-24 23:20:20', '2019-02-24 23:20:20'),
(17, 14, '2019-02-27', 'E - 012 Dt', 9, 18, '', '2019-03-03 18:15:42', '2019-03-03 18:15:42'),
(18, 15, '2019-02-28', 'E - 013 Dt', 9, 17, '', '2019-03-03 19:04:16', '2019-03-03 19:04:16'),
(19, 15, '2019-03-04', 'E - 013 Dt', 11, 17, '', '2019-03-04 17:25:36', '2019-03-04 17:25:36'),
(20, 18, '2019-03-08', 'E - 016 Dt', 12, 17, '', '2019-03-10 22:28:45', '2019-03-10 22:28:45'),
(21, 17, '2019-03-08', 'E - 015 Dt', 12, 17, '', '2019-03-10 22:29:22', '2019-03-10 22:29:22'),
(23, 12, '2019-03-05', 'E - 011 Dt', 9, 17, '', '2019-03-13 22:28:48', '2019-03-13 22:28:48'),
(24, 20, '2019-03-14', 'E - 018 Dt', 9, 17, '', '2019-03-18 18:48:58', '2019-03-18 18:48:58'),
(25, 21, '2019-03-18', 'E - 019 Dt', 9, 17, '', '2019-03-19 18:19:41', '2019-03-19 18:19:41'),
(26, 19, '2019-03-12', 'E - 017 Dt', 9, 17, '', '2019-03-28 01:57:41', '2019-03-28 01:57:41'),
(27, 25, '2019-03-18', 'E - 021 Dt', 9, 17, '', '2019-03-28 02:02:31', '2019-03-28 02:02:31'),
(28, 22, '2019-03-19', 'E - 020 Dt', 9, 17, '', '2019-03-28 02:15:31', '2019-03-28 02:15:31'),
(29, 32, '2019-03-26', 'E - 033 Dt', 9, 17, '', '2019-03-28 02:33:59', '2019-03-28 02:33:59'),
(30, 23, '2019-03-22', 'E - 022 Dt', 9, 17, '', '2019-03-29 02:02:35', '2019-03-29 02:02:35'),
(31, 53, '2019-04-02', 'E - 046 Dt', 9, 17, '', '2019-04-02 01:57:50', '2019-04-02 01:57:50'),
(32, 16, '2019-03-08', 'E - 014 Dt', 9, 17, '', '2019-04-08 02:38:58', '2019-04-22 06:43:09'),
(33, 54, '2019-04-12', 'E - 047 Dt', 10, 17, '', '2019-04-12 02:28:50', '2019-04-12 02:28:50'),
(34, 56, '2019-04-18', 'E - 049 Dt', 10, 18, '', '2019-04-18 05:48:46', '2019-04-18 05:48:46'),
(35, 26, '2019-03-27', 'E - 023 Dt', 9, 17, '', '2019-04-22 07:07:12', '2019-04-25 03:52:17'),
(36, 27, '2019-03-27', 'E - 024 Dt', 9, 17, '', '2019-04-22 07:09:36', '2019-04-25 03:52:38'),
(37, 30, '2019-04-04', 'E - 027 Dt', 9, 18, '', '2019-04-22 07:11:25', '2019-04-25 03:55:40'),
(38, 31, '2019-03-29', 'E - 028 Dt', 9, 17, '', '2019-04-22 07:13:46', '2019-04-25 04:00:12'),
(39, 28, '2019-03-22', 'E - 025 Dt', 9, 18, '', '2019-04-22 07:15:22', '2019-04-25 03:53:26'),
(40, 29, '2019-03-22', 'E - 026 Dt', 9, 17, '', '2019-04-22 07:17:53', '2019-04-25 03:53:47'),
(41, 33, '2019-04-04', 'E - 029 Dt', 9, 18, '', '2019-04-22 07:24:45', '2019-04-25 04:00:33'),
(42, 34, '2019-04-24', 'E - 030 Dt', 9, 17, '', '2019-04-22 07:28:19', '2019-04-25 04:00:53'),
(43, 36, '2019-04-23', 'E - 031 Dt', 9, 18, '', '2019-04-22 07:29:41', '2019-04-25 04:01:11'),
(44, 37, '2019-04-01', 'E - 032 Dt', 9, 17, '', '2019-04-22 07:34:28', '2019-04-25 04:01:27'),
(45, 38, '2019-03-28', 'E - 034 Dt', 9, 17, '', '2019-04-22 08:03:18', '2019-04-22 08:03:18'),
(46, 39, '2019-03-28', 'E - 035 Dt', 9, 17, '', '2019-04-22 08:24:05', '2019-04-22 08:24:05'),
(47, 39, '2019-03-29', 'E - 035 Dt', 20, 18, '', '2019-04-22 08:24:34', '2019-04-22 08:24:34'),
(48, 43, '2019-03-27', 'E - 036 Dt', 9, 18, '', '2019-04-22 08:25:37', '2019-04-22 08:25:37'),
(49, 44, '2019-03-28', 'E - 037 Dt', 9, 17, '', '2019-04-22 08:28:29', '2019-04-22 08:28:29'),
(50, 45, '2019-03-29', 'E - 038 Dt', 9, 18, '', '2019-04-22 08:29:35', '2019-04-22 08:29:35'),
(51, 42, '2019-03-29', 'E - 039 Dt', 9, 17, '', '2019-04-22 08:30:30', '2019-04-22 08:30:30'),
(52, 46, '2019-03-29', 'E - 040 Dt', 9, 17, '', '2019-04-22 08:32:42', '2019-04-22 08:32:42'),
(53, 47, '2019-04-01', 'E - 041 Dt', 9, 17, '', '2019-04-23 02:25:55', '2019-04-23 02:25:55'),
(54, 48, '2019-03-28', 'E - 042 Dt', 9, 18, '', '2019-04-23 02:29:54', '2019-04-23 02:29:54'),
(55, 49, '2019-04-01', 'E - 043 Dt', 9, 17, '', '2019-04-23 02:31:16', '2019-04-23 02:31:16'),
(56, 50, '2019-03-28', 'E - 044 Dt', 9, 17, '', '2019-04-23 02:34:55', '2019-04-23 02:34:55'),
(57, 52, '2019-03-27', 'E - 045 Dt', 9, 18, '', '2019-04-23 02:35:56', '2019-04-23 02:35:56'),
(58, 56, '2019-04-25', 'E - 049 Dt', 11, 17, '', '2019-04-26 06:30:10', '2019-04-26 06:30:10'),
(59, 55, '2019-04-25', 'E - 048 Dt', 11, 17, '', '2019-04-30 01:24:53', '2019-04-30 01:24:53'),
(60, 55, '2019-04-15', 'E - 048 Dt', 12, 17, '', '2019-04-30 01:25:44', '2019-04-30 01:25:44'),
(61, 67, '2019-05-07', 'E- 060 Dt', 12, 17, '', '2019-05-09 02:26:46', '2019-05-09 02:26:46'),
(62, 70, '2019-05-08', 'E - 063 Dt', 10, 17, '', '2019-05-09 02:29:23', '2019-05-09 02:29:23'),
(63, 70, '2019-05-08', 'E - 063 Dt', 9, 18, '', '2019-05-09 02:29:50', '2019-05-09 02:29:50'),
(64, 71, '2019-05-08', 'E - 064 Dt', 9, 18, '', '2019-05-09 02:35:35', '2019-05-09 02:35:35'),
(65, 71, '2019-05-08', 'E - 064 Dt', 10, 18, '', '2019-05-09 02:35:54', '2019-05-09 02:35:54'),
(66, 61, '2019-05-03', 'E - 054 Dt', 12, 17, '', '2019-05-10 02:39:21', '2019-05-10 02:39:21'),
(67, 62, '2019-05-03', 'E - 055 Dt', 12, 17, '', '2019-05-10 02:42:10', '2019-05-10 02:42:10'),
(68, 63, '2019-05-03', 'E - 056 Dt', 12, 17, '', '2019-05-10 02:44:28', '2019-05-10 02:44:28'),
(69, 64, '2019-05-06', 'E - 057 Dt', 6, 17, '', '2019-05-10 02:47:06', '2019-05-10 02:47:06'),
(70, 65, '2019-05-06', 'E - 058 Dt', 12, 17, '', '2019-05-10 02:49:08', '2019-05-10 02:49:08'),
(71, 66, '2019-05-06', 'E - 059 Dt', 12, 17, '', '2019-05-10 02:50:39', '2019-05-10 02:50:39'),
(72, 76, '2019-05-21', 'E - 068 Dt', 9, 17, '', '2019-05-14 02:36:18', '2019-05-24 00:47:51'),
(73, 68, '2019-05-13', 'E - 061 Dt', 9, 17, '', '2019-05-14 23:39:15', '2019-05-14 23:39:15'),
(74, 73, '2019-05-13', 'E - 065 Dt', 10, 17, '', '2019-05-15 00:49:37', '2019-05-15 00:49:37'),
(75, 74, '2019-05-10', 'E - 066 Dt', 11, 17, '', '2019-05-15 00:50:02', '2019-05-15 00:50:02'),
(76, 74, '2019-05-10', 'E - 066 Dt', 12, 17, '', '2019-05-15 00:50:27', '2019-05-15 00:50:27'),
(77, 73, '2019-05-13', 'E - 065 Dt', 11, 18, '', '2019-05-15 00:50:46', '2019-05-15 00:50:46'),
(78, 73, '2019-05-13', 'E - 065 Dt', 12, 17, '', '2019-05-15 00:51:01', '2019-05-15 00:51:01'),
(79, 59, '2019-05-08', 'E - 052 Dt', 9, 17, '', '2019-05-16 01:13:08', '2019-05-16 01:13:08'),
(80, 58, '2019-05-07', 'E - 051 Dt', 11, 18, '', '2019-05-16 01:18:50', '2019-05-16 01:18:50'),
(81, 58, '2019-05-07', 'E - 051 Dt', 12, 17, '', '2019-05-16 01:19:53', '2019-05-16 01:19:53'),
(82, 59, '2019-05-08', 'E - 052 Dt', 11, 17, '', '2019-05-16 01:21:55', '2019-05-16 01:21:55'),
(83, 60, '2019-05-07', 'E - 053 Dt', 11, 18, '', '2019-05-16 01:23:02', '2019-05-16 01:23:02'),
(84, 60, '2019-05-08', 'E - 053 Dt', 9, 17, '', '2019-05-16 01:24:38', '2019-05-16 01:24:38'),
(85, 75, '2019-05-16', 'E - 067 Dt', 9, 18, '', '2019-05-20 03:15:54', '2019-05-20 03:15:54'),
(86, 78, '2019-05-22', 'E - 070 Dt', 10, 18, '', '2019-05-22 06:31:32', '2019-05-22 06:31:32'),
(87, 76, '2019-05-24', 'E - 068 Dt', 10, 17, '', '2019-05-24 00:38:46', '2019-05-24 00:38:46'),
(88, 69, '2019-05-08', 'E - 062 Dt', 6, 18, '', '2019-05-27 04:58:49', '2019-05-27 04:58:49'),
(89, 69, '2019-05-09', 'E - 062 Dt', 10, 17, '', '2019-05-27 05:00:27', '2019-05-27 05:00:27'),
(90, 69, '2019-05-06', 'E - 062 Dt', 11, 17, '', '2019-05-27 05:01:15', '2019-05-27 05:01:15'),
(91, 78, '2019-05-28', 'E - 070 Dt', 12, 17, '', '2019-05-28 06:48:00', '2019-05-28 06:48:00'),
(92, 83, '2019-05-29', 'E - 074 Dt', 11, 17, '', '2019-05-29 02:16:33', '2019-05-29 02:16:33'),
(93, 79, '2019-05-28', 'E - 071 Dt', 5, 18, '', '2019-05-29 02:17:38', '2019-05-29 02:17:38'),
(94, 79, '2019-05-28', 'E - 071 Dt', 9, 17, '', '2019-05-29 02:18:00', '2019-05-29 02:18:00'),
(95, 80, '2019-05-28', 'E - 072 Dt', 6, 17, '', '2019-05-29 02:18:56', '2019-05-29 02:18:56'),
(96, 80, '2019-05-29', 'E - 072 Dt', 9, 17, '', '2019-05-29 02:27:57', '2019-05-29 02:27:57'),
(97, 80, '2019-05-29', 'E - 072 Dt', 10, 18, '', '2019-05-29 02:32:50', '2019-05-29 02:32:50'),
(98, 79, '2019-05-29', 'E - 071 Dt', 10, 18, '', '2019-05-29 05:40:08', '2019-05-29 05:40:08'),
(99, 84, '2019-06-14', 'E - 075 Dt', 9, 17, '', '2019-06-17 03:06:59', '2019-06-17 03:06:59'),
(100, 85, '2019-06-18', 'E - 076 Dt', 10, 18, '', '2019-06-19 02:03:14', '2019-06-19 02:03:14'),
(101, 88, '2019-06-27', 'E - 079 Dt', 9, 17, '', '2019-06-21 01:43:38', '2019-07-18 06:34:55'),
(102, 88, '2019-06-27', 'E - 079 Dt', 11, 18, '', '2019-06-21 01:44:15', '2019-07-18 06:34:32'),
(103, 96, '2019-06-25', 'E - 086 Dt', 12, 17, '', '2019-06-25 06:55:41', '2019-07-18 06:16:18'),
(104, 93, '2019-06-24', 'E - 081 Dt', 10, 18, '', '2019-06-26 03:02:17', '2019-06-26 03:02:17'),
(105, 91, '2019-06-26', 'E - 082 Dt', 12, 17, '', '2019-06-26 03:56:08', '2019-06-26 03:56:08'),
(106, 97, '2019-06-28', 'E - 087 Dt', 9, 17, '', '2019-06-28 02:54:33', '2019-06-28 02:54:33'),
(107, 97, '2019-06-28', 'E - 087 Dt', 10, 18, '', '2019-06-28 02:55:40', '2019-06-28 02:55:40'),
(108, 98, '2019-06-26', 'E - 088 Dt', 9, 17, '', '2019-07-02 05:47:58', '2019-07-02 05:47:58'),
(109, 98, '2019-06-28', 'E - 088 Dt', 10, 18, '', '2019-07-02 05:49:11', '2019-07-02 05:49:11'),
(110, 87, '2019-06-19', 'E - 078 Dt', 10, 18, '', '2019-07-02 05:53:47', '2019-07-02 05:53:47'),
(111, 87, '2019-07-01', 'E - 078 Dt', 9, 17, '', '2019-07-02 05:55:05', '2019-07-02 05:55:05'),
(112, 95, '2019-06-26', 'E - 085 Dt', 9, 18, '', '2019-07-02 06:50:44', '2019-07-02 06:50:44'),
(113, 95, '2019-06-27', 'E - 085 Dt', 10, 18, '', '2019-07-02 06:51:55', '2019-07-02 06:51:55'),
(114, 89, '2019-06-24', 'E - 080 Dt', 9, 17, '', '2019-07-03 01:21:11', '2019-07-03 01:21:11'),
(115, 82, '2019-06-13', 'E - 073 Dt', 9, 17, '', '2019-07-03 05:29:37', '2019-07-03 05:29:37'),
(116, 92, '2019-06-27', 'E - 083 Dt', 9, 17, '', '2019-07-03 05:31:59', '2019-07-03 05:31:59'),
(117, 94, '2019-06-26', 'E - 084 Dt', 13, 18, '', '2019-07-03 06:08:29', '2019-07-03 06:08:29'),
(118, 94, '2019-06-28', 'E - 084 Dt', 5, 17, '', '2019-07-03 06:08:50', '2019-07-03 06:08:50'),
(119, 85, '2019-06-20', 'E - 076 Dt', 9, 17, '', '2019-07-03 06:45:57', '2019-07-03 06:45:57'),
(120, 86, '2019-07-02', 'E - 077 Dt', 5, 18, '', '2019-07-03 06:52:01', '2019-07-03 06:52:01'),
(121, 86, '2019-07-02', 'E - 077 Dt', 11, 18, '', '2019-07-03 06:53:09', '2019-07-03 08:05:18'),
(122, 95, '2019-07-09', 'E - 085 Dt', 12, 17, '', '2019-07-09 07:40:49', '2019-07-09 07:40:49'),
(123, 103, '2019-07-12', 'E - 093 Dt', 11, 18, '', '2019-07-11 02:54:25', '2019-07-15 01:00:00'),
(124, 103, '2019-07-11', 'E - 093 Dt', 6, 18, '', '2019-07-11 02:55:02', '2019-07-11 02:55:02'),
(125, 78, '2019-05-27', 'E - 070 Dt', 11, 17, '', '2019-07-12 05:58:08', '2019-07-12 05:58:08'),
(126, 102, '2019-07-16', 'E - 092 Dt', 12, 17, '', '2019-07-17 01:54:10', '2019-07-17 01:54:10'),
(127, 99, '2019-07-12', 'E - 089 Dt', 7, 17, '', '2019-07-17 07:29:56', '2019-07-17 07:29:56'),
(128, 100, '2019-07-16', 'E - 090 Dt', 7, 18, '', '2019-07-17 07:32:04', '2019-07-17 07:32:04'),
(129, 101, '2019-07-16', 'E - 091 Dt', 7, 18, '', '2019-07-17 07:32:50', '2019-07-17 07:32:50'),
(130, 57, '2019-04-23', 'E - 050 Dt', 10, 18, '', '2019-07-18 02:25:54', '2019-07-18 02:25:54'),
(131, 77, '2019-05-21', 'E - 069 Dt', 10, 18, '', '2019-07-18 02:28:49', '2019-07-18 02:28:49'),
(132, 93, '2019-07-04', 'E - 081 Dt', 9, 17, '', '2019-07-18 06:24:31', '2019-07-18 06:24:31'),
(133, 88, '2019-06-26', 'E - 079 Dt', 13, 17, '', '2019-07-18 06:33:54', '2019-07-18 06:33:54'),
(134, 105, '2019-07-29', 'E - 095 Dt', 9, 17, '', '2019-07-29 01:20:42', '2019-07-29 01:20:42'),
(135, 104, '2019-07-29', 'E - 094 Dt', 6, 18, '', '2019-07-29 05:36:11', '2019-07-29 05:36:11'),
(136, 107, '2019-07-29', 'E - 097 Dt', 11, 17, '', '2019-07-30 02:20:07', '2019-07-30 02:20:07'),
(137, 104, '2019-07-30', 'E - 094 Dt', 10, 17, '', '2019-07-31 01:54:22', '2019-07-31 01:54:22'),
(138, 103, '2019-07-26', 'E - 093 Dt', 10, 18, '', '2019-07-31 03:53:11', '2019-07-31 03:53:11'),
(139, 108, '2019-07-31', 'E - 098 Dt', 10, 18, '', '2019-08-01 02:51:48', '2019-08-01 02:51:48'),
(140, 106, '2019-08-01', 'E - 096 Dt', 12, 17, '', '2019-08-01 07:20:57', '2019-08-01 07:20:57'),
(141, 110, '2019-08-02', 'E - 100 Dt', 9, 17, '', '2019-08-05 05:59:02', '2019-08-05 05:59:02'),
(142, 112, '2019-08-06', 'E - 102 Dt', 11, 17, '', '2019-08-07 03:29:47', '2019-08-07 03:29:47'),
(143, 117, '2019-08-08', 'E - 107 Dt', 9, 17, '', '2019-08-08 02:45:56', '2019-08-08 02:45:56'),
(144, 116, '2019-08-14', 'E - 106 Dt', 6, 17, '', '2019-08-14 00:33:25', '2019-08-14 00:33:25'),
(145, 119, '2019-08-14', 'E - 109 Dt', 6, 17, '', '2019-08-14 00:35:02', '2019-08-14 00:35:02'),
(146, 113, '2019-08-12', 'E - 103 Dt', 10, 17, '', '2019-08-14 00:43:41', '2019-08-14 00:43:41'),
(147, 114, '2019-08-09', 'E - 104 Dt', 7, 17, '', '2019-08-14 00:44:54', '2019-08-14 00:44:54'),
(148, 115, '2019-08-14', 'E - 105 Dt', 7, 17, '', '2019-08-14 00:47:15', '2019-08-14 00:47:15'),
(149, 111, '2019-08-09', 'E - 101 Dt', 7, 17, '', '2019-08-16 02:09:02', '2019-08-16 02:09:02'),
(150, 124, '2019-08-27', 'E - 114 Dt', 7, 17, '', '2019-08-27 02:50:39', '2019-08-27 02:50:39'),
(151, 121, '2019-08-28', 'E - 111 Dt', 16, 18, '', '2019-08-28 00:30:42', '2019-08-28 00:30:42'),
(152, 122, '2019-08-28', 'E - 112 Dt', 16, 17, '', '2019-08-28 00:31:02', '2019-08-28 00:31:02'),
(153, 123, '2019-08-28', 'E - 113 Dt', 21, 18, '', '2019-08-28 00:31:21', '2019-08-28 00:31:21'),
(154, 120, '2019-08-23', 'E - 110 Dt', 12, 17, '', '2019-08-28 06:29:22', '2019-08-28 06:29:22'),
(155, 118, '2019-08-20', 'E - 108 Dt', 12, 17, '', '2019-08-28 06:50:11', '2019-08-28 06:50:11'),
(156, 118, '2019-08-19', 'E - 108 Dt', 5, 18, '', '2019-08-28 06:51:13', '2019-08-28 06:51:13'),
(157, 126, '2019-09-03', 'E - 116 Dt', 16, 17, '', '2019-09-03 02:16:08', '2019-09-03 02:16:08'),
(158, 130, '2019-09-05', 'E - 119 Dt', 11, 18, '', '2019-09-06 05:55:55', '2019-09-06 05:55:55'),
(159, 129, '2019-09-09', 'E - 118 Dt', 12, 17, '', '2019-09-10 01:29:51', '2019-09-10 01:29:51'),
(160, 133, '2019-09-09', 'E - 122 Dt', 21, 18, '', '2019-09-10 07:43:04', '2019-09-10 07:43:04'),
(161, 128, '2019-09-17', 'E - 117 Dt', 9, 17, '', '2019-09-17 00:29:45', '2019-09-17 00:29:45'),
(162, 128, '2019-09-17', 'E - 117 Dt', 16, 18, '', '2019-09-17 00:30:03', '2019-09-17 00:30:03'),
(163, 132, '2019-09-17', 'E - 121 Dt', 13, 18, '', '2019-09-18 02:51:37', '2019-09-18 02:51:37'),
(164, 134, '2019-09-18', 'E - 123 Dt', 16, 18, '', '2019-09-18 06:14:18', '2019-09-18 06:14:18'),
(165, 136, '2019-09-24', 'E - 124 Dt', 21, 18, '', '2019-09-23 03:46:58', '2019-09-24 04:38:51'),
(166, 134, '2019-09-20', 'E - 123 Dt', 21, 18, '', '2019-09-23 04:21:06', '2019-09-23 04:21:06'),
(167, 136, '2019-09-24', 'E - 124 Dt', 16, 18, '', '2019-09-24 04:38:21', '2019-09-24 04:38:21'),
(168, 131, '2019-09-20', 'E - 120 Dt', 9, 18, '', '2019-09-25 00:06:30', '2019-09-25 00:06:30'),
(169, 141, '2019-09-26', 'E - 129 Dt', 21, 18, '', '2019-09-26 08:33:09', '2019-09-26 08:33:09'),
(170, 140, '2019-09-26', 'E - 128 Dt', 21, 18, '', '2019-10-01 00:37:41', '2019-10-01 00:37:41'),
(171, 143, '2019-10-02', 'E - 131 Dt', 12, 17, '', '2019-10-02 02:09:02', '2019-10-02 02:09:02'),
(172, 139, '2019-10-02', 'E - 127 Dt', 9, 17, '', '2019-10-03 02:52:51', '2019-11-14 00:27:53'),
(173, 156, '2019-10-04', 'E - 143 Dt', 10, 17, '', '2019-10-04 01:01:32', '2019-11-14 03:09:57'),
(174, 137, '2019-10-09', 'E - 125 Dt', 12, 17, '', '2019-10-10 00:36:52', '2019-10-10 00:36:52'),
(175, 153, '2019-10-09', 'E - 140 Dt', 10, 18, '', '2019-10-10 05:30:04', '2019-10-10 05:30:04'),
(176, 154, '2019-10-09', 'E - 141 Dt', 10, 18, '', '2019-10-10 05:30:43', '2019-10-10 05:30:43'),
(177, 155, '2019-10-09', 'E - 142 Dt', 10, 18, '', '2019-10-10 05:31:19', '2019-10-10 05:31:19'),
(178, 138, '2019-10-09', 'E - 126 Dt', 10, 18, '', '2019-10-10 05:36:10', '2019-10-10 05:36:10'),
(179, 140, '2019-10-10', 'E - 128 Dt', 12, 18, '', '2019-10-10 05:42:34', '2019-10-10 05:42:34'),
(180, 140, '2019-10-10', 'E - 128 Dt', 10, 18, '', '2019-10-10 05:42:57', '2019-10-10 05:42:57'),
(181, 162, '2019-10-11', 'E - 148 Dt', 10, 18, '', '2019-10-11 07:16:30', '2019-10-11 07:16:30'),
(182, 161, '2019-11-08', 'E - 147 Dt', 10, 18, '', '2019-10-11 08:01:38', '2019-11-11 01:19:34'),
(183, 158, '2019-10-10', 'E - 145 Dt', 10, 18, '', '2019-10-16 08:12:42', '2019-10-16 08:12:42'),
(184, 163, '2019-10-16', 'E - 149 Dt', 10, 18, '', '2019-10-17 05:55:38', '2019-10-17 05:55:38'),
(185, 125, '2019-09-02', 'E - 115 Dt', 16, 18, '', '2019-10-18 03:06:07', '2019-10-18 03:06:07'),
(186, 142, '2019-10-14', 'E - 130 Dt', 12, 17, '', '2019-10-18 08:38:56', '2019-10-18 08:38:56'),
(187, 145, '2019-10-17', 'E - 132 Dt', 10, 18, '', '2019-10-18 08:45:15', '2019-10-18 08:45:15'),
(188, 146, '2019-10-16', 'E - 133 Dt', 10, 18, '', '2019-10-18 08:49:09', '2019-10-18 08:49:09'),
(189, 147, '2019-10-15', 'E - 134 Dt', 10, 18, '', '2019-10-18 08:52:21', '2019-10-18 08:52:21'),
(190, 148, '2019-10-02', 'E - 135 Dt', 10, 18, '', '2019-10-18 08:58:13', '2019-10-18 08:58:13'),
(191, 149, '2019-10-15', 'E - 136 Dt', 10, 18, '', '2019-10-18 09:01:42', '2019-10-18 09:01:42'),
(192, 150, '2019-10-17', 'E - 137 Dt', 10, 18, '', '2019-10-18 09:08:29', '2019-10-18 09:08:29'),
(193, 151, '2019-10-21', 'E - 138 Dt', 9, 18, '', '2019-10-18 09:17:20', '2019-10-18 09:17:20'),
(194, 152, '2019-10-16', 'E - 139 Dt', 10, 18, '', '2019-10-18 09:20:21', '2019-10-18 09:20:21'),
(195, 159, '2019-10-18', 'E - 146 Dt', 10, 18, '', '2019-10-18 09:27:26', '2019-11-14 03:17:26'),
(196, 167, '2019-10-22', 'E - 153 Dt', 7, 17, '', '2019-10-23 02:50:09', '2019-10-23 02:50:09'),
(197, 172, '2019-10-24', 'E - 158 Dt', 13, 17, '', '2019-10-24 05:02:44', '2019-10-24 05:02:44'),
(198, 176, '2019-10-24', 'E - 161 Dt', 9, 17, '', '2019-10-24 05:03:13', '2019-10-24 05:03:13'),
(199, 171, '2019-10-24', 'E -157 Dt', 10, 17, '', '2019-10-24 23:57:30', '2019-10-24 23:57:30'),
(200, 156, '2019-10-18', 'E - 143 Dt', 9, 17, '', '2019-10-25 01:46:40', '2019-10-25 01:46:40'),
(201, 165, '2019-10-28', 'E - 151 Dt', 10, 17, '', '2019-10-28 03:29:07', '2019-10-28 03:29:07'),
(202, 168, '2019-10-28', 'E-154 Dt', 9, 17, '', '2019-10-28 03:45:46', '2019-11-14 03:41:05'),
(203, 169, '2019-10-28', 'E - 155 Dt', 9, 17, '', '2019-10-28 03:46:33', '2019-11-14 03:42:51'),
(204, 157, '2019-10-25', 'E - 144 Dt', 9, 17, '', '2019-10-28 03:51:51', '2019-10-28 03:51:51'),
(205, 182, '2019-10-29', 'E - 165 Dt', 9, 17, '', '2019-10-29 06:01:05', '2019-10-29 06:01:05'),
(206, 175, '2019-11-04', 'E - 160 Dt', 12, 17, '', '2019-11-05 02:30:22', '2019-11-05 02:30:22'),
(207, 166, '2019-11-04', 'E - 152 Dt', 12, 17, '', '2019-11-05 02:30:47', '2019-11-05 02:30:47'),
(208, 179, '2019-11-06', 'E - 164 Dt', 12, 17, '', '2019-11-08 01:49:50', '2019-11-08 01:49:50'),
(209, 170, '2019-11-08', 'E - 156 Dt', 9, 18, '', '2019-11-10 23:59:06', '2019-11-10 23:59:06'),
(210, 185, '2019-11-08', 'E - 170 Dt', 10, 18, '', '2019-11-11 00:10:03', '2019-11-11 00:10:03'),
(211, 161, '2019-11-08', 'E - 147 Dt', 9, 17, '', '2019-11-11 01:17:58', '2019-11-11 01:17:58'),
(212, 161, '2019-11-08', 'E - 147 Dt', 12, 17, '', '2019-11-11 01:18:20', '2019-11-11 01:18:20'),
(213, 189, '2019-11-08', 'E - 172 Dt', 9, 17, '', '2019-11-11 03:20:37', '2019-11-14 04:12:58'),
(214, 164, '2019-11-08', 'E - 150 Dt', 9, 18, '', '2019-11-12 05:24:54', '2019-11-14 03:29:33'),
(215, 191, '2019-11-11', 'E - 174 Dt', 12, 18, '', '2019-11-13 01:40:53', '2019-11-13 01:40:53'),
(216, 141, '2019-09-27', 'E - 129 Dt', 12, 17, '', '2019-11-14 00:34:04', '2019-11-14 00:34:04'),
(217, 186, '2019-11-08', 'E - 168 Dt', 9, 18, '', '2019-11-14 01:23:52', '2019-11-14 01:23:52'),
(218, 188, '2019-11-08', 'E - 169 Dt', 9, 18, '', '2019-11-14 01:26:42', '2019-11-14 01:26:42'),
(219, 170, '2019-11-08', 'E - 156 Dt', 12, 17, '', '2019-11-14 03:58:04', '2019-11-14 03:58:04'),
(220, 187, '2019-11-14', 'E - 171 Dt', 9, 18, '', '2019-11-15 07:26:39', '2019-11-15 07:26:39'),
(221, 183, '2019-11-14', 'E - 166 Dt', 9, 18, '', '2019-11-18 01:32:14', '2019-11-18 01:32:14'),
(222, 174, '2019-11-06', 'E - 159 Dt', 9, 18, '', '2019-11-22 04:43:29', '2019-11-22 04:43:29'),
(223, 190, '2019-11-15', 'E - 173 Dt', 11, 18, '', '2019-11-27 01:53:10', '2019-11-27 01:53:10'),
(224, 202, '2019-11-29', 'E - 185 Dt', 11, 18, '', '2019-11-29 06:15:57', '2019-11-29 06:15:57'),
(225, 194, '2019-11-28', 'E - 177 Dt', 11, 18, '', '2019-12-02 03:16:12', '2019-12-02 03:16:12'),
(226, 195, '2019-11-29', 'E - 178 Dt', 11, 17, '', '2019-12-02 03:37:46', '2019-12-02 03:37:46'),
(227, 201, '2019-11-29', 'E - 184 Dt', 11, 17, '', '2019-12-02 03:42:01', '2019-12-02 03:42:01'),
(228, 177, '2019-11-26', 'E - 162 Dt', 9, 17, '', '2019-12-05 05:53:44', '2019-12-05 05:53:44'),
(229, 178, '2019-12-25', 'E - 163 Dt', 9, 17, '', '2019-12-05 05:54:09', '2019-12-05 05:54:09'),
(230, 192, '2019-12-04', 'E - 175 Dt', 11, 17, '', '2019-12-06 07:16:14', '2019-12-06 07:16:14'),
(231, 198, '2019-12-09', 'E - 181 Dt', 11, 17, '', '2019-12-12 00:41:30', '2019-12-12 00:41:30'),
(232, 198, '2019-12-09', 'E - 181 Dt', 12, 17, '', '2019-12-12 00:41:46', '2019-12-12 00:41:46'),
(233, 200, '2019-12-11', 'E - 183 Dt', 9, 18, '', '2019-12-12 03:17:13', '2019-12-12 03:17:13'),
(234, 209, '2019-12-12', 'E - 192 Dt', 9, 17, '', '2019-12-13 00:52:04', '2019-12-13 00:52:04'),
(235, 199, '2019-12-10', 'E - 182 Dt', 12, 17, '', '2019-12-16 01:35:41', '2019-12-16 01:35:41'),
(236, 184, '2019-12-02', 'E - 167 Dt', 12, 17, '', '2019-12-19 01:33:23', '2019-12-19 01:33:23'),
(237, 202, '2019-12-13', 'E - 185 Dt', 9, 17, '', '2019-12-19 02:08:32', '2019-12-19 02:08:32'),
(238, 202, '2019-12-13', 'E - 185 Dt', 12, 17, '', '2019-12-19 02:09:48', '2019-12-19 02:09:48'),
(239, 208, '2019-12-17', 'E - 191 Dt', 12, 17, '', '2019-12-20 02:52:14', '2019-12-20 02:52:14'),
(240, 214, '2019-12-20', 'E - 197 Dt', 9, 18, '', '2019-12-20 06:32:06', '2019-12-20 06:32:06'),
(241, 193, '2019-12-20', 'E - 176 Dt', 11, 17, '', '2019-12-23 04:32:10', '2019-12-23 04:32:10'),
(242, 197, '2019-12-20', 'E - 180 Dt', 9, 17, '', '2019-12-23 04:32:47', '2019-12-23 04:32:47'),
(243, 210, '2019-12-19', 'E - 193 Dt', 12, 17, '', '2019-12-26 01:45:24', '2019-12-26 01:45:24'),
(244, 213, '2019-12-25', 'E - 196 Dt', 12, 17, '', '2019-12-27 02:10:56', '2019-12-27 02:10:56'),
(245, 215, '2019-12-27', 'E - 198 Dt', 12, 17, '', '2019-12-27 06:06:56', '2019-12-27 06:06:56'),
(246, 215, '2019-12-27', 'E - 198 Dt', 9, 17, '', '2019-12-27 06:07:27', '2019-12-27 06:07:27'),
(249, 216, '2020-01-03', 'E - 001 Dt', 12, 17, 'LMK (1)', '2020-01-06 02:46:31', '2020-10-27 07:33:23'),
(250, 206, '2019-12-31', 'E - 189 Dt', 9, 17, '', '2020-01-06 06:45:39', '2020-01-06 06:45:39'),
(251, 205, '2019-12-31', 'E - 188 Dt', 9, 18, '', '2020-01-06 06:52:22', '2020-01-06 06:52:22'),
(252, 204, '2019-12-31', 'E - 187 Dt', 9, 17, '', '2020-01-06 06:59:43', '2020-01-06 06:59:43'),
(253, 207, '2019-12-31', 'E - 190 Dt', 9, 18, '', '2020-01-06 07:35:15', '2020-01-06 07:35:15'),
(254, 211, '2020-01-03', 'E - 194 Dt', 9, 18, '', '2020-01-06 08:03:32', '2020-01-06 08:03:32'),
(255, 212, '2020-01-03', 'E - 195 Dt', 9, 18, '', '2020-01-06 08:05:00', '2020-01-06 08:05:00'),
(256, 219, '2020-01-07', 'E - 002 Dt', 22, 18, 'LMB (1)', '2020-01-06 23:58:35', '2020-10-27 07:31:57'),
(257, 203, '2019-12-31', 'E - 186 Dt', 9, 17, '', '2020-01-20 00:37:29', '2020-01-20 00:37:29'),
(259, 220, '2020-01-21', 'E - 003 Dt', 16, 18, 'LMK (7) LMB (2)', '2020-01-21 04:16:58', '2020-10-27 07:31:33'),
(260, 221, '2020-01-21', 'E - 004 Dt', 16, 18, 'LMK (1)', '2020-01-21 05:41:25', '2020-10-27 07:30:35'),
(262, 222, '2020-01-24', 'E - 005 Dt', 17, 18, '', '2020-01-24 05:52:43', '2020-01-24 05:52:43'),
(263, 223, '2020-02-03', 'E - 006 Dt', 17, 17, 'LMK (1)', '2020-02-03 01:31:28', '2020-10-27 07:45:52'),
(264, 223, '2020-02-03', 'E - 006 Dt', 18, 17, 'LHK (1)', '2020-02-03 01:32:06', '2020-10-27 07:45:40'),
(265, 223, '2020-02-03', 'E - 006 Dt', 25, 17, 'LHK (1)', '2020-02-03 01:32:40', '2020-10-27 07:45:30'),
(266, 226, '2020-02-25', 'E - 008 Dt', 7, 18, 'LMB (1)', '2020-02-25 05:33:28', '2020-10-27 08:00:11'),
(267, 229, '2020-02-20', 'E - 011 Dt', 17, 18, '', '2020-02-26 02:45:33', '2020-02-26 02:45:33'),
(268, 227, '2020-02-12', 'E - 009 Dt', 7, 18, 'LMK (1)', '2020-02-27 00:54:22', '2020-10-27 08:06:58'),
(269, 227, '2020-02-12', 'E - 009 Dt', 22, 18, 'LMK (1)', '2020-02-27 00:55:06', '2020-10-27 08:07:06'),
(270, 234, '2020-03-03', 'E - 016 Dt', 17, 18, '', '2020-03-03 03:34:33', '2020-03-03 03:34:33'),
(271, 234, '2020-03-03', 'E - 016 Dt', 18, 17, '', '2020-03-03 03:35:30', '2020-03-03 03:35:30'),
(272, 235, '2020-03-05', 'E - 017 Dt', 22, 17, '', '2020-03-05 00:57:25', '2020-03-05 00:57:25'),
(274, 236, '2020-03-05', 'E - 018 Dt', 12, 17, '', '2020-03-06 04:04:28', '2020-03-06 04:04:28'),
(275, 236, '2020-03-05', 'E - 018 Dt', 18, 17, '', '2020-03-06 04:05:03', '2020-03-06 04:05:03'),
(276, 236, '2020-03-05', 'E - 018 Dt', 17, 18, '', '2020-03-06 04:05:32', '2020-03-06 04:05:32'),
(278, 237, '2020-03-06', 'E - 019 Dt', 22, 18, '', '2020-03-06 08:54:51', '2020-03-06 08:54:51'),
(279, 237, '2020-03-06', 'E - 019 Dt', 25, 18, '', '2020-03-06 08:55:22', '2020-03-06 08:55:22'),
(280, 228, '2020-02-14', 'E - 010 Dt', 22, 17, 'LMB (1)', '2020-03-09 03:10:44', '2020-10-27 08:08:27'),
(281, 228, '2020-02-14', 'E - 010 Dt', 7, 17, 'LMK (1)', '2020-03-09 03:11:14', '2020-10-27 08:08:14'),
(283, 233, '2020-03-10', 'E - 015 Dt', 17, 25, '', '2020-03-10 03:19:06', '2020-03-10 03:19:06'),
(284, 232, '2020-03-06', 'E - 014 Dt', 6, 17, '', '2020-03-10 03:21:25', '2020-03-10 03:21:25'),
(285, 232, '2020-03-06', 'E - 014 Dt', 18, 17, '', '2020-03-10 03:21:43', '2020-03-10 03:21:43'),
(286, 231, '2020-03-06', 'E - 013 Dt', 17, 18, '', '2020-03-10 03:23:42', '2020-03-10 03:23:42'),
(287, 230, '2020-03-09', 'E - 012 Dt', 17, 25, '', '2020-03-10 03:27:28', '2020-03-10 03:27:28'),
(288, 230, '2020-03-03', 'E - 012 Dt', 12, 17, '', '2020-03-11 00:43:19', '2020-03-11 00:43:19'),
(289, 230, '2020-03-04', 'E - 012 Dt', 22, 17, '', '2020-03-11 00:49:07', '2020-03-11 00:49:07'),
(290, 230, '2020-03-04', 'E - 012 Dt', 25, 17, '', '2020-03-11 00:49:34', '2020-03-11 00:49:34'),
(291, 239, '2020-03-16', 'E - 021 Dt', 17, 25, '', '2020-03-17 00:20:42', '2020-03-17 00:20:42'),
(292, 222, '2020-02-20', 'E - 005 Dt', 27, 17, 'LHB (1)', '2020-03-17 01:10:45', '2020-10-27 07:41:41'),
(293, 222, '2020-02-21', 'E - 005 Dt', 6, 17, 'LMK (2)', '2020-03-17 01:11:48', '2020-10-27 07:41:26'),
(294, 222, '2020-02-24', 'E - 005 Dt', 22, 17, 'LMB (1) LHK (1)', '2020-03-17 01:12:36', '2020-10-27 07:37:45'),
(295, 222, '2020-02-24', 'E - 005 Dt', 25, 17, 'LMB (1) LHK (1)', '2020-03-17 01:13:29', '2020-10-27 07:38:51'),
(296, 222, '2020-02-24', 'E - 005 Dt', 18, 17, 'LHK (1)', '2020-03-17 01:16:03', '2020-10-27 07:38:11'),
(297, 224, '2020-02-12', 'E - 007 Dt', 25, 17, 'LMK (1)', '2020-03-17 01:23:41', '2020-10-27 07:47:33'),
(298, 224, '2020-02-12', 'E - 007 Dt', 28, 17, 'LMB (1)', '2020-03-17 01:24:16', '2020-10-27 07:57:06'),
(299, 226, '2020-02-14', 'E - 008 Dt', 22, 17, 'LMK (1)', '2020-03-17 01:43:02', '2020-10-27 08:00:23'),
(300, 226, '2020-02-14', 'E - 008 Dt', 27, 17, 'LMB (2)', '2020-03-17 01:43:41', '2020-10-27 08:00:44'),
(301, 233, '2020-03-10', 'E - 015 Dt', 29, 17, '', '2020-03-17 03:24:42', '2020-03-17 03:24:42'),
(302, 235, '2020-03-05', 'E - 017 Dt', 6, 17, '', '2020-03-17 03:32:55', '2020-03-17 03:32:55'),
(303, 237, '2020-03-06', 'E - 019 Dt', 29, 17, '', '2020-03-17 05:49:06', '2020-03-17 05:49:06'),
(304, 238, '2020-03-17', 'E - 020 Dt', 25, 17, '', '2020-03-19 06:16:55', '2020-03-19 06:16:55'),
(305, 240, '2020-04-08', 'E - 022 Dt', 21, 17, '-', '2020-04-08 03:12:27', '2020-04-08 03:12:27'),
(306, 241, '2020-06-25', 'E - 023 Dt', 16, 17, '-', '2020-06-25 06:22:23', '2020-06-25 06:22:23'),
(307, 241, '2020-06-25', 'E - 023 Dt', 28, 18, '-', '2020-06-25 06:22:53', '2020-06-25 06:22:53'),
(308, 241, '2020-06-25', 'E - 023 Dt', 30, 18, 'audiometer menggunakan headphone yang sama (headphone R27A17C00502 bermasalah)', '2020-06-25 06:23:13', '2020-06-25 07:07:18'),
(309, 242, '2020-06-25', 'E - 024 Dt', 18, 17, '-', '2020-06-25 07:10:55', '2020-06-25 07:10:55'),
(310, 242, '2020-06-25', 'E - 024 Dt', 28, 17, '-', '2020-06-25 07:11:13', '2020-06-25 07:11:13'),
(311, 242, '2020-06-25', 'E - 024 Dt', 29, 18, '-', '2020-06-25 07:17:09', '2020-06-25 07:17:09'),
(312, 243, '2020-06-25', 'E - 025 Dt', 18, 17, '-', '2020-06-25 07:19:12', '2020-06-25 07:19:12'),
(313, 243, '2020-06-25', 'E - 025 Dt', 29, 18, '-', '2020-06-25 07:19:37', '2020-06-25 07:19:37'),
(314, 244, '2020-06-25', 'E - 026 Dt', 16, 18, '-', '2020-06-25 07:20:04', '2020-06-25 07:20:04'),
(315, 244, '2020-06-25', 'E - 026 Dt', 17, 18, '-', '2020-06-25 07:20:27', '2020-06-25 07:20:27'),
(316, 244, '2020-06-25', 'E - 026 Dt', 18, 17, '-', '2020-06-25 07:20:53', '2020-06-25 07:20:53'),
(317, 244, '2020-06-25', 'E - 026 Dt', 25, 18, '-', '2020-06-25 07:21:11', '2020-06-25 07:21:11'),
(318, 244, '2020-06-25', 'E - 026 Dt', 30, 18, '-', '2020-06-25 07:21:26', '2020-06-25 07:21:26'),
(319, 245, '2020-06-25', 'E - 027 Dt', 16, 18, '-', '2020-06-25 07:21:58', '2020-06-25 07:21:58'),
(320, 245, '2020-06-25', 'E - 027 Dt', 25, 18, '-', '2020-06-25 07:22:18', '2020-06-25 07:22:18'),
(321, 245, '2020-06-25', 'E - 027 Dt', 28, 18, '-', '2020-06-25 07:22:41', '2020-06-25 07:22:41'),
(322, 246, '2020-06-25', 'E - 028 Dt', 18, 17, '-', '2020-06-25 07:22:59', '2020-06-25 07:22:59'),
(323, 246, '2020-06-25', 'E - 028 Dt', 25, 17, '-', '2020-06-25 07:23:22', '2020-06-25 07:23:22'),
(324, 247, '2020-06-25', 'E - 029 Dt', 27, 18, '-', '2020-06-25 07:23:39', '2020-06-25 07:23:39'),
(325, 241, '2020-06-25', 'E - 023 Dt', 31, 18, '-', '2020-06-25 07:29:37', '2020-06-25 07:29:37'),
(326, 248, '2020-06-29', 'E - 030 Dt', 16, 18, '-', '2020-06-29 06:43:19', '2020-06-29 06:43:19'),
(327, 248, '2020-07-16', 'E - 030 Dt', 28, 18, 'Label Merah Besar (4)', '2020-06-29 06:45:16', '2020-07-16 07:30:29'),
(328, 248, '2020-06-29', 'E - 030 Dt', 29, 18, '-', '2020-06-29 06:45:38', '2020-06-29 06:45:38'),
(329, 248, '2020-06-29', 'E - 030 Dt', 30, 18, '-', '2020-06-29 06:45:58', '2020-06-29 06:45:58'),
(331, 249, '2020-06-30', 'E - 031 Dt', 30, 18, 'Label Merah 1', '2020-06-30 01:15:01', '2020-06-30 01:15:01'),
(332, 250, '2020-07-10', 'E - 032 Dt', 16, 18, 'Label Merah Kecil (6)', '2020-07-14 01:59:43', '2020-07-14 02:00:47'),
(333, 250, '2020-07-10', 'E - 032 Dt', 18, 17, 'Label Merah Besar (1)', '2020-07-14 02:00:25', '2020-07-14 02:00:25'),
(334, 250, '2020-07-10', 'E - 032 Dt', 25, 18, 'Label Merah Kecil (2)', '2020-07-14 02:01:20', '2020-07-14 02:01:20'),
(335, 250, '2020-07-10', 'E - 032 Dt', 28, 17, 'Label Merah Besar (2)', '2020-07-14 02:02:16', '2020-07-14 02:02:16'),
(336, 251, '2020-07-16', 'E - 033 Dt', 18, 17, 'Label Merah Kecil (6)', '2020-07-16 07:23:49', '2020-07-16 07:23:49'),
(337, 251, '2020-07-16', 'E - 033 Dt', 25, 17, 'Label Merah Kecil (4)', '2020-07-16 07:25:35', '2020-07-16 07:25:35'),
(338, 252, '2020-07-24', 'E - 034 Dt', 28, 17, 'Label Merah Besar (1)', '2020-07-28 02:43:40', '2020-07-28 02:43:40'),
(339, 255, '2020-07-28', 'E - 037 Dt', 21, 18, 'Label Merah Besar (3)', '2020-07-30 04:21:15', '2020-07-30 04:21:15'),
(340, 255, '2020-07-28', 'E - 037 Dt', 31, 18, 'Label Merah Besar (2)', '2020-07-30 04:21:50', '2020-07-30 04:21:50'),
(341, 253, '2020-08-02', 'E - 035 Dt', 30, 17, 'belum', '2020-08-06 03:17:04', '2020-08-06 03:17:04'),
(342, 254, '2020-08-05', 'E - 036 Dt', 30, 17, 'Label Merah (3)', '2020-08-11 00:35:41', '2020-08-11 00:35:41'),
(344, 274, '2020-08-13', 'E - 053 Dt', 31, 17, 'Label Merah Besar 1', '2020-08-19 04:02:22', '2020-08-19 04:02:22'),
(345, 273, '2020-08-24', 'E - 054 Dt', 10, 17, '-', '2020-08-24 03:17:12', '2020-08-24 03:17:12'),
(346, 256, '2020-08-13', 'E - 038 Dt', 16, 18, 'Label Merah Kecil (3)', '2020-08-25 01:18:59', '2020-08-25 01:18:59'),
(347, 256, '2020-08-13', 'E - 038 Dt', 27, 18, 'label kecil merah (1), label besar merah (1)', '2020-08-25 01:19:58', '2020-08-25 01:19:58'),
(348, 256, '2020-08-14', 'E - 038 Dt', 30, 18, 'label kecil merah (2)', '2020-08-25 01:20:27', '2020-08-25 01:20:27'),
(349, 271, '2020-08-24', 'E - 052 Dt', 9, 18, '-', '2020-08-25 03:53:23', '2020-08-25 03:53:23'),
(350, 270, '2020-08-20', 'E - 051 Dt', 30, 17, '-', '2020-08-27 01:19:27', '2020-08-27 01:19:27'),
(351, 275, '2020-08-27', 'E - 055 Dt', 30, 17, '-', '2020-08-27 02:30:59', '2020-08-27 02:30:59'),
(352, 276, '2020-08-27', 'E - 056 Dt', 30, 17, '-', '2020-08-27 02:35:29', '2020-08-27 02:35:29'),
(353, 277, '2020-08-27', 'E - 057 Dt', 30, 17, '-', '2020-08-27 02:39:55', '2020-08-27 02:39:55'),
(354, 278, '2020-08-27', 'E - 058 Dt', 30, 17, '-', '2020-08-27 02:40:21', '2020-08-27 02:40:21'),
(355, 281, '2020-08-27', 'E - 059 Dt', 30, 17, '-', '2020-08-27 02:40:57', '2020-08-27 02:40:57'),
(357, 257, '2020-08-24', 'E - 039 Dt', 17, 18, 'Label Hijau Kecil (3), Label Merah Kecil (5)', '2020-08-28 05:40:33', '2020-08-28 05:40:33'),
(358, 282, '2020-08-27', 'E - 060 Dt', 20, 18, 'LMB(1)', '2020-08-28 08:56:08', '2020-08-28 08:56:08'),
(359, 282, '2020-08-27', 'E - 060 Dt', 21, 18, 'LMB(2)', '2020-08-28 08:56:29', '2020-08-28 08:56:29'),
(360, 282, '2020-08-28', 'E - 060 Dt', 28, 18, 'LMB(1)', '2020-08-28 08:56:48', '2020-08-28 08:56:48'),
(361, 258, '2020-08-24', 'E - 040 Dt', 30, 17, '-', '2020-08-31 00:26:45', '2020-08-31 00:26:45'),
(362, 259, '2020-08-25', 'E - 041 Dt', 30, 17, '-', '2020-08-31 00:27:32', '2020-08-31 00:27:32'),
(363, 272, '2020-08-24', 'E - 042 Dt', 30, 17, '-', '2020-08-31 00:32:19', '2020-08-31 00:32:19'),
(364, 262, '2020-08-24', 'E - 043 Dt', 30, 17, '-', '2020-08-31 00:34:15', '2020-08-31 00:34:15'),
(365, 263, '2020-08-24', 'E - 044 Dt', 30, 17, '-', '2020-08-31 00:35:23', '2020-08-31 00:35:23'),
(366, 265, '2020-08-24', 'E - 046 Dt', 30, 18, '-', '2020-08-31 00:36:12', '2020-08-31 00:36:12'),
(367, 264, '2020-08-24', 'E - 045 Dt', 30, 18, '-', '2020-08-31 00:37:15', '2020-08-31 00:37:15'),
(368, 266, '2020-08-24', 'E - 047 Dt', 30, 18, '-', '2020-08-31 00:38:36', '2020-08-31 00:38:36'),
(369, 267, '2020-08-24', 'E - 048 Dt', 30, 18, '-', '2020-08-31 00:39:11', '2020-08-31 00:39:11'),
(370, 268, '2020-08-24', 'E - 049 dT', 30, 18, '-', '2020-08-31 00:40:04', '2020-08-31 00:40:04'),
(371, 269, '2020-08-24', 'E - 050 Dt', 30, 18, '-', '2020-08-31 00:43:29', '2020-08-31 00:43:29'),
(372, 284, '2020-08-31', 'E - 062 Dt', 13, 18, 'LMB', '2020-08-31 03:41:59', '2020-08-31 03:41:59'),
(373, 283, '2020-09-03', 'E - 061 Dt', 29, 18, 'LMB(4)', '2020-09-03 05:52:08', '2020-09-03 05:52:08'),
(374, 283, '2020-09-03', 'E - 061 Dt', 31, 18, 'LMB(2)', '2020-09-03 05:52:33', '2020-09-03 05:52:33'),
(375, 286, '2020-09-07', 'E - 064 Dt', 21, 17, 'LMB(1)', '2020-09-08 03:08:53', '2020-09-08 03:08:53'),
(376, 285, '2020-09-04', 'E - 063 Dt', 16, 18, 'LMB (1)', '2020-09-09 05:54:55', '2020-09-09 05:54:55'),
(377, 295, '2020-09-09', 'E - 073 Dt', 10, 17, 'LBM (1)', '2020-09-09 06:58:53', '2020-09-09 06:58:53'),
(378, 295, '2020-09-09', 'E - 073 Dt', 17, 22, 'LBM (1)', '2020-09-09 06:59:47', '2020-09-09 06:59:47'),
(379, 287, '2020-09-09', 'E - 065 Dt', 17, 22, 'LBM (1)', '2020-09-09 07:45:26', '2020-09-09 07:45:26'),
(380, 295, '2020-09-10', 'E - 073 Dt', 16, 18, 'LKM (3)', '2020-09-11 09:22:11', '2020-09-11 09:22:11'),
(381, 298, '2020-09-23', 'E - 076 Dt', 17, 18, '-', '2020-09-23 03:16:57', '2020-09-23 03:16:57'),
(382, 298, '2020-09-23', 'E - 076 Dt', 25, 17, '-', '2020-09-23 03:17:30', '2020-09-23 03:17:30'),
(383, 298, '2020-09-23', 'E - 076 Dt', 29, 17, '-', '2020-09-23 03:17:58', '2020-09-23 03:17:58'),
(384, 294, '2020-09-23', 'E - 072 Dt', 17, 18, 'LBK (1)', '2020-09-23 03:30:37', '2020-09-23 03:30:37'),
(385, 294, '2020-09-23', 'E - 072 Dt', 22, 17, 'LBM (2)', '2020-09-23 03:31:06', '2020-09-23 03:31:06'),
(386, 294, '2020-09-23', 'E - 072 Dt', 25, 17, 'LKM (1)', '2020-09-23 03:31:48', '2020-09-23 03:31:48'),
(387, 253, '2020-07-31', 'E - 035 Dt', 18, 17, 'LKM (3)', '2020-09-23 07:03:43', '2020-09-23 07:03:43'),
(388, 253, '2020-07-23', 'E - 035 Dt', 21, 18, 'LBM (1)', '2020-09-23 07:21:33', '2020-09-23 07:21:33'),
(389, 253, '2020-07-22', 'E - 035 Dt', 22, 18, 'LBM (1)', '2020-09-23 07:23:10', '2020-09-23 07:23:10'),
(390, 253, '2020-07-22', 'E - 035 Dt', 25, 18, 'LBK (1)', '2020-09-23 07:25:09', '2020-09-23 07:25:09'),
(391, 254, '2020-07-30', 'E - 036 Dt', 16, 18, 'LBH (1) LBM (1)', '2020-09-23 07:41:08', '2020-09-23 07:41:08'),
(392, 254, '2020-08-04', 'E - 036 Dt', 31, 17, 'LBM (1)', '2020-09-23 07:45:05', '2020-09-23 07:45:05'),
(393, 254, '2020-07-22', 'E - 036 Dt', 18, 17, 'LBM (1)', '2020-09-23 07:51:26', '2020-09-23 07:51:26'),
(394, 255, '2020-07-22', 'E - 037 Dt', 30, 17, 'LBM (1)', '2020-09-23 08:06:25', '2020-09-23 08:06:25'),
(395, 300, '2020-09-23', 'E - 078 Dt', 6, 17, 'LBM (1)', '2020-09-23 08:08:19', '2020-09-23 08:08:19'),
(396, 300, '2020-09-23', 'E - 078 Dt', 27, 17, 'LBM (1)', '2020-09-23 08:12:47', '2020-09-23 08:12:47'),
(397, 300, '2020-09-23', 'E - 078 Dt', 29, 17, 'LBM (1)', '2020-09-23 08:16:14', '2020-09-23 08:16:14'),
(398, 297, '2020-09-22', 'E - 075 Dt', 17, 18, '-', '2020-09-24 00:36:20', '2020-09-24 00:36:20'),
(399, 297, '2020-09-22', 'E - 075 Dt', 21, 18, '-', '2020-09-24 00:41:11', '2020-09-24 00:41:11'),
(400, 297, '2020-09-22', 'E - 075 Dt', 22, 18, '-', '2020-09-24 00:41:47', '2020-09-24 00:41:47'),
(401, 297, '2020-09-22', 'E - 075 Dt', 25, 18, '-', '2020-09-24 00:42:17', '2020-09-24 00:42:17'),
(402, 297, '2020-09-22', 'E - 075 Dt', 29, 18, '-', '2020-09-24 00:42:41', '2020-09-24 00:42:41'),
(403, 297, '2020-09-22', 'E - 075 Dt', 31, 18, '-', '2020-09-24 00:42:59', '2020-09-24 00:42:59'),
(404, 296, '2020-09-22', 'E - 074 Dt', 18, 18, '-', '2020-09-24 03:41:45', '2020-09-24 03:41:45'),
(405, 296, '2020-09-22', 'E - 074 Dt', 22, 18, '-', '2020-09-24 03:42:08', '2020-09-24 03:42:08'),
(406, 296, '2020-09-22', 'E - 074 Dt', 29, 18, '-', '2020-09-24 03:42:27', '2020-09-24 03:42:27'),
(407, 296, '2020-09-22', 'E - 074 Dt', 31, 18, '-', '2020-09-24 03:42:44', '2020-09-24 03:42:44'),
(408, 299, '2020-09-18', 'E - 077 Dt', 31, 18, 'LMK(1)', '2020-09-24 06:15:52', '2020-09-24 06:15:52'),
(409, 301, '2020-09-28', 'E - 079 Dt', 20, 18, 'LBM (1)', '2020-09-29 05:47:17', '2020-09-29 05:47:17'),
(410, 304, '2020-09-30', 'E - 087 Dt', 30, 18, 'belum', '2020-10-02 02:52:54', '2020-10-02 02:52:54'),
(411, 302, '2020-09-30', 'E - 080 Dt', 17, 18, 'blm', '2020-10-02 06:01:46', '2020-10-02 06:01:46'),
(412, 317, '2020-10-02', 'E - 095 Dt', 27, 18, '-', '2020-10-02 06:46:09', '2020-10-02 06:46:09'),
(413, 303, '2020-10-06', 'E - 081 Dt', 30, 17, 'blm', '2020-10-06 02:52:28', '2020-10-06 02:52:28'),
(414, 332, '2020-10-08', 'E - 109 Dt', 21, 18, 'LMB(1)', '2020-10-08 07:51:50', '2020-10-08 07:51:50'),
(415, 334, '2020-10-09', 'E - 111 Dt', 30, 18, 'LMB(1)', '2020-10-09 02:11:30', '2020-10-09 02:11:30'),
(416, 319, '2020-10-09', 'E - 097 Dt', 30, 17, 'blm', '2020-10-09 08:08:17', '2020-10-09 08:08:17'),
(417, 318, '2020-10-12', 'E - 096 Dt', 30, 17, 'blm', '2020-10-12 06:21:02', '2020-10-12 06:21:02'),
(418, 320, '2020-10-12', 'E - 098 Dt', 30, 17, '-', '2020-10-14 01:33:36', '2020-10-14 01:33:36'),
(419, 293, '2020-10-14', 'E - 071 Dt', 16, 17, 'blm', '2020-10-14 03:36:22', '2020-10-14 03:36:22'),
(420, 293, '2020-10-14', 'E - 071 Dt', 21, 17, 'blm', '2020-10-14 03:36:48', '2020-10-14 03:36:48'),
(421, 292, '2020-10-14', 'E - 070 Dt', 16, 17, 'blm', '2020-10-14 03:37:27', '2020-10-14 03:37:27'),
(422, 292, '2020-10-14', 'E - 070 Dt', 22, 17, 'blm', '2020-10-14 03:37:56', '2020-10-14 03:37:56'),
(423, 291, '2020-10-14', 'E - 069 Dt', 16, 17, 'blm', '2020-10-14 03:39:57', '2020-10-14 03:39:57'),
(424, 291, '2020-10-14', 'E - 069 Dt', 22, 17, 'blm', '2020-10-14 03:40:17', '2020-10-14 03:40:17'),
(425, 290, '2020-10-14', 'E - 068 Dt', 16, 17, 'blm', '2020-10-14 03:40:43', '2020-10-14 03:40:43'),
(426, 290, '2020-10-14', 'E - 068 Dt', 22, 17, 'blm', '2020-10-14 03:41:01', '2020-10-14 03:41:01'),
(427, 289, '2020-10-14', 'E - 067 Dt', 16, 17, 'blm', '2020-10-14 03:42:01', '2020-10-14 03:42:01'),
(428, 288, '2020-10-14', 'E - 066 Dt', 16, 17, 'blm', '2020-10-14 03:42:24', '2020-10-14 03:42:24'),
(429, 288, '2020-10-14', 'E - 066 Dt', 21, 17, 'blm', '2020-10-14 03:42:43', '2020-10-14 03:42:43'),
(430, 288, '2020-10-14', 'E - 066 Dt', 22, 17, 'blm', '2020-10-14 03:43:02', '2020-10-14 03:43:02'),
(431, 288, '2020-10-14', 'E - 066 Dt', 27, 17, 'blm', '2020-10-14 03:43:22', '2020-10-14 03:43:22'),
(432, 305, '2020-10-15', 'E - 082 Dt', 30, 17, 'blm', '2020-10-15 05:32:12', '2020-10-15 05:32:12'),
(433, 306, '2020-10-15', 'E - 083 Dt', 30, 18, 'blm', '2020-10-15 05:39:41', '2020-10-15 05:39:41'),
(434, 307, '2020-10-15', 'E - 084 Dt', 30, 17, 'blm', '2020-10-15 05:45:49', '2020-10-15 05:45:49'),
(435, 308, '2020-10-15', 'E - 085 Dt', 30, 18, 'blm', '2020-10-15 05:52:00', '2020-10-15 05:52:00'),
(436, 309, '2020-10-15', 'E - 086 Dt', 30, 17, 'blm', '2020-10-15 05:52:27', '2020-10-15 05:52:27'),
(437, 310, '2020-10-15', 'E - 088 Dt', 30, 18, 'blm', '2020-10-15 05:55:47', '2020-10-15 05:55:47'),
(438, 311, '2020-10-15', 'E - 089 Dt', 30, 17, 'blm', '2020-10-15 05:57:36', '2020-10-15 05:57:36'),
(439, 312, '2020-10-15', 'E - 090 Dt', 30, 17, 'blm', '2020-10-15 05:58:14', '2020-10-15 05:58:14'),
(440, 313, '2020-10-15', 'E - 091 Dt', 30, 17, 'blm', '2020-10-15 05:59:12', '2020-10-15 05:59:12'),
(441, 314, '2020-10-15', 'E - 092 Dt', 30, 18, 'blm', '2020-10-15 05:59:42', '2020-10-15 05:59:42'),
(442, 315, '2020-10-15', 'E - 093 Dt', 30, 17, 'blm', '2020-10-15 06:00:04', '2020-10-15 06:00:04'),
(443, 316, '2020-10-15', 'E - 094 Dt', 30, 17, 'blm', '2020-10-15 06:00:27', '2020-10-15 06:00:27'),
(444, 332, '2020-10-20', 'E - 109 Dt', 17, 17, 'blm', '2020-10-20 02:18:41', '2020-10-20 02:18:41'),
(445, 342, '2020-10-23', 'E - 119 Dt', 29, 18, 'LMK (1)', '2020-10-26 01:41:18', '2020-10-26 01:41:18'),
(446, 342, '2020-10-23', 'E - 119 Dt', 21, 18, 'LMB(1)', '2020-10-26 02:24:36', '2020-10-26 02:24:36'),
(447, 224, '2020-09-18', 'E - 007 Dt', 17, 18, 'LMK (1)', '2020-10-27 07:54:15', '2020-10-27 07:54:15'),
(448, 340, '2020-10-29', 'E - 117 Dt', 21, 17, 'LMB (2) LMK (1)', '2020-11-02 02:13:37', '2020-11-02 02:13:37'),
(449, 345, '2020-10-30', 'E - 121 Dt', 21, 18, 'blm', '2020-11-02 07:20:38', '2020-11-02 07:20:38'),
(450, 343, '2020-10-22', 'E - 120 Dt', 9, 18, 'blm', '2020-11-02 07:22:49', '2020-11-02 07:22:49'),
(451, 341, '2020-11-10', 'E - 118 Dt', 12, 17, 'LMB (2) LMK (3)', '2020-11-10 03:47:52', '2020-11-10 03:47:52');

-- --------------------------------------------------------

--
-- Table structure for table `lab_provinsi`
--

CREATE TABLE `lab_provinsi` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `provinsi_id` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_provinsi`
--

INSERT INTO `lab_provinsi` (`id`, `name`, `provinsi_id`) VALUES
(1, 'Kalimantan Barat', 61),
(2, 'Kalimantan Selatan', 63),
(3, 'Kalimantan Tengah', 62),
(4, 'Kalimantan Timur', 64),
(5, 'Kalimantan Utara', 65);

-- --------------------------------------------------------

--
-- Table structure for table `lab_ptg_penerimaan`
--

CREATE TABLE `lab_ptg_penerimaan` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `no_order` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ptg1` int(11) NOT NULL,
  `ptg2` int(11) NOT NULL,
  `kup` int(11) DEFAULT '0',
  `kkl` int(11) DEFAULT '0',
  `kpp` int(11) DEFAULT '0',
  `bpj` int(11) DEFAULT '0',
  `kpr` int(11) DEFAULT '0',
  `kmk` int(11) DEFAULT '0',
  `akl` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_ptg_penerimaan`
--

INSERT INTO `lab_ptg_penerimaan` (`id`, `id_order`, `no_order`, `name`, `ptg1`, `ptg2`, `kup`, `kkl`, `kpp`, `bpj`, `kpr`, `kmk`, `akl`, `created_at`, `updated_at`) VALUES
(3, 3, 'E - 002 Dt', '-', 16, 13, 1, 1, 1, 1, 1, 1, 1, '2019-01-24 09:12:28', '2019-01-24 09:12:28'),
(4, 4, 'E - 004 Dt', 'Amalia Tanjung', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-01-30 10:15:57', '2019-01-30 10:15:57'),
(5, 5, 'E - 005 Dt', 'Basuki Rahmat', 17, 13, 1, 1, 1, 1, 1, 1, 1, '2019-02-03 11:04:37', '2019-02-03 11:04:37'),
(6, 6, 'E - 006 Dt', 'Sunusi', 17, 13, 1, 1, 1, 1, 1, 1, 1, '2019-02-05 09:49:33', '2019-02-05 09:49:33'),
(7, 7, 'E - 007 Dt', 'Nur Huda', 18, 13, 1, 1, 1, 1, 1, 1, 1, '2019-02-11 10:11:05', '2019-02-11 10:11:05'),
(8, 8, 'E - 008 Dt', 'Fathur', 18, 13, 1, 1, 1, 1, 1, 1, 1, '2019-02-11 14:39:49', '2019-02-11 14:39:49'),
(9, 9, 'E - 009 Dt', 'Muhammad Irwan', 18, 10, 1, 1, 1, 1, 1, 1, 1, '2019-02-17 13:20:43', '2019-02-17 13:20:43'),
(11, 11, 'E - 010 Dt', 'Arief Pramono', 18, 11, 1, 1, 1, 1, 1, 1, 1, '2019-02-18 12:07:10', '2019-02-18 12:07:10'),
(12, 12, 'E - 011 Dt', 'Sari', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-02-19 14:07:50', '2019-02-19 14:07:50'),
(14, 14, 'E - 012 Dt', 'Muhammad Irwan', 18, 5, 1, 1, 1, 1, 1, 1, 1, '2019-02-24 21:05:30', '2019-02-24 21:05:30'),
(15, 15, 'E - 013 Dt', 'Bara Rianto', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-02-27 00:38:26', '2019-02-27 00:38:26'),
(16, 16, 'E - 014 Dt', 'Wiza Narti', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-03 22:21:37', '2019-03-20 20:07:57'),
(17, 17, 'E - 015 Dt', 'Muhammad Irwan', 18, 11, 1, 1, 1, 1, 1, 1, 1, '2019-03-05 21:18:14', '2019-03-05 21:18:14'),
(18, 18, 'E - 016 Dt', 'Muhammad Irwan', 18, 11, 1, 1, 1, 1, 1, 1, 1, '2019-03-05 21:22:22', '2019-03-05 21:22:22'),
(19, 19, 'E - 017 Dt', 'Bara Riyanto', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-07 23:45:38', '2019-03-07 23:57:39'),
(20, 20, 'E - 018 Dt', 'Muhammad Irwan', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-13 17:37:02', '2019-03-13 17:37:02'),
(21, 21, 'E - 019 Dt', 'Mira', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-13 19:10:21', '2019-03-13 19:10:21'),
(22, 22, 'E - 020 Dt', 'Dr. Yussie Andeline', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-13 21:59:51', '2019-03-13 21:59:51'),
(23, 23, 'E - 022 Dt', 'Sari', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-13 22:39:58', '2019-03-13 22:39:58'),
(25, 25, 'E - 021 Dt', 'Tri Sutisno', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-14 19:57:44', '2019-03-14 19:57:44'),
(26, 26, 'E - 023 Dt', 'Wiwin', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 17:47:38', '2019-03-20 17:47:38'),
(27, 27, 'E - 024 Dt', 'Wiwin', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 19:16:58', '2019-03-20 19:16:58'),
(28, 28, 'E - 025 Dt', 'Wiwin', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 19:36:31', '2019-03-20 19:36:31'),
(29, 29, 'E - 026 Dt', 'Wiwin', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 19:41:10', '2019-03-20 19:41:10'),
(30, 30, 'E - 027 Dt', 'Wiwin', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 19:55:49', '2019-03-20 19:55:49'),
(31, 31, 'E - 028 Dt', 'Wiwin', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 20:17:28', '2019-03-20 20:17:28'),
(32, 32, 'E - 033 Dt', 'Madonna S.', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 20:17:48', '2019-03-20 20:17:48'),
(33, 33, 'E - 029 Dt', 'Wiwin', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 20:27:04', '2019-03-20 20:27:04'),
(34, 34, 'E - 030 Dt', 'Wiwin', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 20:32:39', '2019-03-20 20:32:39'),
(35, 36, 'E - 031 Dt', 'Wiwin', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 20:49:49', '2019-03-20 20:49:49'),
(36, 37, 'E - 032 Dt', 'Wiwin', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 20:52:17', '2019-03-20 20:52:17'),
(37, 38, 'E - 034 Dt', 'Eka Dinasti', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 21:51:45', '2019-03-20 21:51:45'),
(38, 39, 'E - 035 Dt', 'Eka Dinasti', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 22:04:40', '2019-03-20 22:04:40'),
(39, 42, 'E - 039 Dt', 'Eka Dinasti', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 22:42:46', '2019-03-20 22:42:46'),
(40, 43, 'E - 036 Dt', 'Eka Dinasti', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 22:43:33', '2019-03-20 22:43:33'),
(41, 44, 'E - 037 Dt', 'Eka Dinasti', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 22:50:22', '2019-03-20 22:50:22'),
(42, 45, 'E - 038 Dt', 'Eka Dinasti', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 23:03:34', '2019-03-20 23:03:34'),
(43, 46, 'E - 040 Dt', 'Eka Dinasti', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 23:09:14', '2019-03-20 23:09:14'),
(44, 47, 'E - 041 Dt', 'Eka Dinasti', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 23:19:02', '2019-03-20 23:19:02'),
(45, 48, 'E - 042 Dt', 'Eka Dinasti', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-20 23:43:03', '2019-03-20 23:43:03'),
(46, 49, 'E - 043 Dt', 'Eka Dinasti', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-21 00:00:23', '2019-03-21 00:00:23'),
(47, 50, 'E - 044 Dt', 'Eka Dinasti', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-03-21 00:05:42', '2019-03-21 00:05:42'),
(48, 52, 'E - 045 Dt', 'Arief Pramono', 17, 10, 1, 1, 1, 1, 1, 1, 1, '2019-03-21 19:38:29', '2019-03-21 19:38:29'),
(49, 53, 'E - 046 Dt', 'Giovanni Anggre. D. S. ST', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-04-01 00:15:26', '2019-04-01 00:15:26'),
(50, 54, 'E - 047 Dt', 'Muhammad Irwan', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-04-05 03:02:55', '2019-04-05 03:02:55'),
(51, 55, 'E - 048 Dt', 'Muhammad Irwan', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-04-12 02:42:02', '2019-04-12 02:42:02'),
(52, 56, 'E - 049 Dt', 'Wandi', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-04-16 06:30:26', '2019-04-16 06:30:26'),
(53, 57, 'E - 050 Dt', 'Muhammad Rizani', 18, 10, 1, 1, 1, 1, 1, 1, 1, '2019-04-18 07:06:00', '2019-04-18 07:06:00'),
(54, 58, 'E - 051 Dt', 'Wiwin', 18, 13, 1, 1, 1, 1, 1, 1, 1, '2019-04-25 01:07:49', '2019-04-25 02:42:30'),
(55, 59, 'E - 052 Dt', 'Wiwin', 18, 13, 1, 1, 1, 1, 1, 1, 1, '2019-04-25 01:08:52', '2019-04-25 02:44:01'),
(56, 60, 'E - 053 Dt', 'Wiwin', 18, 13, 1, 1, 1, 1, 1, 1, 1, '2019-04-25 01:09:49', '2019-04-25 02:46:30'),
(57, 61, 'E - 054 Dt', 'Basuki rahmad, S. Kep', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-04-29 01:58:00', '2019-04-29 01:58:00'),
(58, 62, 'E - 055 Dt', 'Basuki Rahmad, S.Kep', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-04-29 02:05:15', '2019-04-29 02:05:15'),
(59, 63, 'E - 056 Dt', 'Basuki Rahmad, S.Kep', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-04-29 02:14:43', '2019-04-29 02:14:43'),
(60, 64, 'E - 057 Dt', 'Basuki Rahmad, S.Kep', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-04-29 02:16:59', '2019-04-29 02:16:59'),
(61, 65, 'E - 058 Dt', 'Basuki Rahmad, S.Kep', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-04-29 02:29:49', '2019-04-29 02:29:49'),
(62, 66, 'E - 059 Dt', 'Basuki Rahmad, S.Kep', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-04-29 02:34:47', '2019-04-29 02:34:47'),
(63, 67, 'E- 060 Dt', 'Basuki Rahmad, S.Kep', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-04-29 02:37:25', '2019-04-29 02:37:25'),
(64, 68, 'E - 061 Dt', 'Wahidah', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-04-30 03:50:32', '2019-04-30 03:50:32'),
(65, 69, 'E - 062 Dt', 'Hj.Mursidah', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-05-02 01:35:05', '2019-05-02 01:38:33'),
(66, 70, 'E - 063 Dt', 'Hj. Mursidah', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-05-02 01:37:52', '2019-05-02 01:39:06'),
(67, 71, 'E - 064 Dt', 'Hj. Mursidah', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-05-02 02:13:17', '2019-05-02 02:13:17'),
(69, 73, 'E - 065 Dt', 'Muhammad Irwan', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-05-03 02:11:05', '2019-05-03 02:11:05'),
(70, 74, 'E - 066 Dt', 'Muhammad Irwan', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-05-03 02:15:38', '2019-05-03 02:15:38'),
(71, 75, 'E - 067 Dt', 'Widianto', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-05-10 06:54:29', '2019-05-10 06:54:29'),
(72, 76, 'E - 068 Dt', 'Duta Setyawan', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-05-13 00:44:48', '2019-05-13 00:44:48'),
(73, 77, 'E - 069 Dt', 'Supriatin', 17, 10, 1, 1, 1, 1, 1, 1, 1, '2019-05-20 02:09:47', '2019-05-20 02:48:15'),
(74, 78, 'E - 070 Dt', 'Mas\'ud', 17, 5, 1, 1, 1, 1, 1, 1, 1, '2019-05-21 03:13:55', '2019-05-21 03:13:55'),
(75, 79, 'E - 071 Dt', 'Muhammad Irwan', 17, 10, 1, 1, 1, 1, 1, 1, 1, '2019-05-23 02:24:09', '2019-05-23 02:24:09'),
(76, 80, 'E - 072 Dt', 'Muhammad Irwan', 18, 10, 1, 1, 1, 1, 1, 1, 1, '2019-05-23 02:28:04', '2019-05-23 02:28:04'),
(77, 81, 'I - 001 Dt', '-', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-05-24 07:49:09', '2019-05-24 07:49:09'),
(78, 82, 'E - 073 Dt', 'Lahmudin', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-05-27 01:35:58', '2019-05-27 01:35:58'),
(79, 83, 'E - 074 Dt', 'Muhammad Irwan', 17, 13, 1, 1, 1, 1, 1, 1, 1, '2019-05-28 02:23:40', '2019-05-28 02:23:40'),
(80, 84, 'E - 075 Dt', 'Muhammad Irwan', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-06-11 02:12:39', '2019-06-11 02:12:39'),
(81, 85, 'E - 076 Dt', 'Muhammad Irwan', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-17 03:22:52', '2019-06-17 03:22:52'),
(82, 86, 'E - 077 Dt', 'Muhammad Irwan', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-17 03:29:24', '2019-06-17 03:29:24'),
(83, 87, 'E - 078 Dt', 'Dikirim', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-17 03:55:49', '2019-06-17 03:55:49'),
(84, 88, 'E - 079 Dt', 'Tri Mulyanto', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-17 07:08:30', '2019-06-17 07:08:30'),
(85, 89, 'E - 080 Dt', 'Muhammad Irwan', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-19 01:50:27', '2019-06-19 01:50:27'),
(86, 91, 'E - 082 Dt', 'Muhammad Irwan', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-19 01:59:28', '2019-06-19 01:59:28'),
(87, 92, 'E - 083 Dt', 'Aulia Rahman', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-19 02:58:35', '2019-06-19 02:58:35'),
(88, 93, 'E - 081 Dt', 'Muhammad Irwan', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-20 01:57:55', '2019-06-20 01:57:55'),
(89, 94, 'E - 084 Dt', 'Muhammad Irwan', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-20 02:36:30', '2019-06-20 02:36:30'),
(90, 95, 'E - 085 Dt', 'Fahmi', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-06-21 03:03:03', '2019-06-21 03:03:03'),
(91, 96, 'E - 086 Dt', 'Heffy Erlina', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-06-25 01:42:19', '2019-06-25 01:42:19'),
(92, 97, 'E - 087 Dt', 'Dr Shinta', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-06-25 02:12:29', '2019-06-25 02:12:29'),
(93, 98, 'E - 088 Dt', 'Bella (dikirim)', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-06-26 02:12:12', '2019-06-26 02:12:12'),
(94, 99, 'E - 089 Dt', 'Eka', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-07-04 03:34:16', '2019-07-04 03:34:16'),
(95, 100, 'E - 090 Dt', 'Eka', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-07-04 03:36:47', '2019-07-04 03:36:47'),
(96, 101, 'E - 091 Dt', 'Eka', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-07-04 03:39:23', '2019-07-04 03:39:23'),
(97, 102, 'E - 092 Dt', 'Daniel', 18, 20, 1, 1, 1, 1, 1, 1, 1, '2019-07-04 07:20:02', '2019-07-04 07:20:02'),
(98, 103, 'E - 093 Dt', 'Ika Diar Agustina, Amd. Far', 17, 20, 1, 1, 1, 1, 1, 1, 1, '2019-07-09 01:41:27', '2019-07-09 01:41:27'),
(99, 104, 'E - 094 Dt', 'M. Khaironi', 17, 6, 1, 1, 1, 1, 1, 1, 1, '2019-07-22 05:56:44', '2019-07-22 06:26:29'),
(100, 105, 'E - 095 Dt', 'Dikirim', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-07-24 02:22:34', '2019-07-24 02:22:34'),
(101, 106, 'E - 096 Dt', 'Dikirim', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-07-24 02:26:37', '2019-07-24 02:26:37'),
(102, 107, 'E - 097 Dt', 'Adi', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-07-26 03:26:55', '2019-07-26 03:26:55'),
(103, 108, 'E - 098 Dt', 'Muhammad Irwan', 18, 10, 1, 1, 1, 1, 1, 1, 1, '2019-07-29 02:44:23', '2019-07-29 02:44:23'),
(104, 109, 'E - 099 Dt', 'M.  Khaironi', 17, 13, 1, 1, 1, 1, 1, 1, 1, '2019-07-29 06:50:57', '2019-07-29 06:50:57'),
(105, 110, 'E - 100 Dt', 'Anggit', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-07-31 05:52:29', '2019-07-31 05:55:33'),
(106, 111, 'E - 101 Dt', 'Fathur Rachman', 17, 13, 1, 1, 1, 1, 1, 1, 1, '2019-08-05 01:59:51', '2019-08-05 02:47:19'),
(107, 112, 'E - 102 Dt', 'Sadam', 18, 11, 1, 1, 1, 1, 1, 1, 1, '2019-08-06 02:39:54', '2019-08-06 02:46:00'),
(108, 113, 'E - 103 Dt', 'Eka', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-08-06 03:00:08', '2019-08-06 03:00:08'),
(109, 114, 'E - 104 Dt', 'Eka', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-08-06 03:01:52', '2019-08-06 03:01:52'),
(110, 115, 'E - 105 Dt', 'Eka', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-08-06 03:03:09', '2019-08-06 03:03:09'),
(111, 116, 'E - 106 Dt', 'Muhammad Irwan', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-08-07 01:25:47', '2019-08-07 01:25:47'),
(112, 117, 'E - 107 Dt', 'Tri Mulyanto', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-08-07 04:02:14', '2019-08-07 04:02:14'),
(113, 118, 'E - 108 Dt', 'Daniel', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-08-09 07:46:06', '2019-08-09 07:46:06'),
(114, 119, 'E - 109 Dt', 'Muhammad Irwan', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-08-13 01:14:17', '2019-08-13 01:14:17'),
(115, 120, 'E - 110 Dt', 'Adi', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-08-22 02:49:23', '2019-08-22 02:49:23'),
(116, 121, 'E - 111 Dt', 'Adi', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-08-22 06:03:33', '2019-08-22 06:03:33'),
(117, 122, 'E - 112 Dt', 'Dina Mara Diana', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-08-23 02:27:44', '2019-08-23 02:27:44'),
(118, 123, 'E - 113 Dt', 'Nur Rahmah Ismail', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-08-23 02:40:19', '2019-08-23 02:40:19'),
(119, 124, 'E - 114 Dt', 'Dr. Waluyo', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-08-27 01:40:05', '2019-08-27 01:40:05'),
(120, 125, 'E - 115 Dt', 'Ika', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2019-08-28 07:03:17', '2019-08-28 07:03:17'),
(121, 126, 'E - 116 Dt', 'Yuni Irmawati', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2019-09-02 00:21:32', '2019-09-02 00:36:39'),
(122, 128, 'E - 117 Dt', 'Sigit', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2019-09-03 02:33:32', '2019-09-03 02:33:32'),
(123, 129, 'E - 118 Dt', 'Eka', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2019-09-03 02:46:43', '2019-09-03 02:46:43'),
(124, 130, 'E - 119 Dt', 'Muhammad Irwan', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2019-09-03 02:56:30', '2019-09-03 02:56:30'),
(125, 131, 'E - 120 Dt', 'Dikirim', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2019-09-03 05:34:49', '2019-09-03 06:42:39'),
(126, 132, 'E - 121 Dt', 'Abdul Samad', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2019-09-05 03:16:25', '2019-09-05 03:16:25'),
(127, 133, 'E - 122 Dt', 'Jelina', 17, 21, 1, 1, 1, 1, 1, 1, 1, '2019-09-05 06:04:26', '2019-09-05 06:04:26'),
(128, 134, 'E - 123 Dt', 'Muhammad Irwan', 18, 21, 1, 1, 1, 1, 1, 1, 1, '2019-09-18 02:14:12', '2019-09-18 02:14:12'),
(130, 136, 'E - 124 Dt', 'Hadi sungkono', 18, 11, 1, 1, 1, 1, 1, 1, 1, '2019-09-23 00:21:34', '2019-09-23 00:21:34'),
(131, 137, 'E - 125 Dt', 'Wika Narti', 18, 7, 1, 1, 1, 1, 1, 1, 1, '2019-09-25 03:46:10', '2019-09-25 03:46:10'),
(132, 138, 'E - 126 Dt', 'Fauzan', 18, 7, 1, 1, 1, 1, 1, 1, 1, '2019-09-25 05:58:19', '2019-09-25 05:58:19'),
(133, 139, 'E - 127 Dt', 'Fauzan', 18, 21, 1, 1, 1, 1, 1, 1, 1, '2019-09-25 06:00:04', '2019-09-25 06:00:04'),
(134, 140, 'E - 128 Dt', 'Fauzan', 18, 21, 1, 1, 1, 1, 1, 1, 1, '2019-09-25 06:01:31', '2019-09-25 06:01:31'),
(135, 141, 'E - 129 Dt', 'Iwan', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-09-26 00:51:07', '2019-09-26 00:51:07'),
(136, 142, 'E - 130 Dt', 'Gono', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-09-26 06:36:33', '2019-09-26 06:36:33'),
(137, 143, 'E - 131 Dt', 'Daniel PE Rembeth', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-09-30 01:09:40', '2019-09-30 01:32:17'),
(139, 145, 'E - 132 Dt', 'Basuki Rahmad', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-10-02 02:27:50', '2019-10-02 02:27:50'),
(140, 146, 'E - 133 Dt', 'Basuki Rahmad', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-10-02 04:01:07', '2019-10-02 04:01:07'),
(141, 147, 'E - 134 Dt', '08125022327', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-10-02 04:10:19', '2019-10-02 04:10:19'),
(142, 148, 'E - 135 Dt', 'Basuki Rahmad', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-10-02 04:13:03', '2019-10-02 04:13:03'),
(143, 149, 'E - 136 Dt', 'Basuki Rahmad', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-10-02 04:14:37', '2019-10-02 04:14:37'),
(144, 150, 'E - 137 Dt', 'Basuki Rahmad', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-10-02 04:16:22', '2019-10-02 04:16:22'),
(145, 151, 'E - 138 Dt', 'Basuki Rahmad', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-10-02 04:19:38', '2019-10-02 04:19:38'),
(146, 152, 'E - 139 Dt', 'Basuki Rahmad', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-10-02 04:21:36', '2019-10-02 04:21:36'),
(147, 153, 'E - 140 Dt', 'Muhammad Irwan', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-10-03 03:05:46', '2019-10-03 03:05:46'),
(148, 154, 'E - 141 Dt', 'Muhammad Irwan', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-10-03 03:07:11', '2019-10-03 03:07:43'),
(149, 155, 'E - 142 Dt', 'Muhammad Irwan', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-10-03 03:09:20', '2019-10-03 03:09:20'),
(150, 156, 'E - 143 Dt', 'Joko', 18, 5, 1, 1, 1, 1, 1, 1, 1, '2019-10-03 05:36:12', '2019-10-03 05:36:12'),
(151, 157, 'E - 144 Dt', 'Ridha Rahmatullah', 18, 11, 1, 1, 1, 1, 1, 1, 1, '2019-10-07 02:19:07', '2019-10-07 02:19:07'),
(152, 158, 'E - 145 Dt', 'Muradi', 17, 10, 1, 1, 1, 1, 1, 1, 1, '2019-10-07 06:08:52', '2019-10-07 06:08:52'),
(153, 159, 'E - 146 Dt', 'Aulia Rahman', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-10-09 01:07:00', '2019-10-09 01:07:00'),
(154, 161, 'E - 147 Dt', 'Norvia Diannita', 17, 10, 1, 1, 1, 1, 1, 1, 1, '2019-10-11 01:33:45', '2019-10-11 01:33:45'),
(155, 162, 'E - 148 Dt', 'Abdurrahim', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-10-11 02:16:24', '2019-10-11 02:16:24'),
(156, 163, 'E - 149 Dt', 'Muhammad Irwan', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-10-11 02:52:19', '2019-10-11 02:52:19'),
(157, 164, 'E - 150 Dt', 'Qulsum', 17, 5, 1, 1, 1, 1, 1, 1, 1, '2019-10-17 02:44:34', '2019-10-17 02:44:34'),
(158, 165, 'E - 151 Dt', 'Yuni', 17, 5, 1, 1, 1, 1, 1, 1, 1, '2019-10-17 03:56:11', '2019-10-17 03:56:11'),
(159, 166, 'E - 152 Dt', 'Jemy', 18, 10, 1, 1, 1, 1, 1, 1, 1, '2019-10-17 06:16:30', '2019-10-17 06:22:50'),
(160, 167, 'E - 153 Dt', 'Jemy', 18, 13, 1, 1, 1, 1, 1, 1, 1, '2019-10-17 06:21:27', '2019-10-17 06:21:27'),
(161, 168, 'E-154 Dt', 'Agus Mujahidin', 18, 7, 1, 1, 1, 1, 1, 1, 1, '2019-10-21 05:32:31', '2019-10-21 05:32:31'),
(162, 169, 'E - 155 Dt', 'Normala Santi', 18, 7, 1, 1, 1, 1, 1, 1, 1, '2019-10-21 05:39:28', '2019-10-21 05:39:28'),
(163, 170, 'E - 156 Dt', 'Yuni', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-10-22 06:30:29', '2019-10-22 06:30:29'),
(164, 171, 'E -157 Dt', 'dikirim', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-10-23 02:57:21', '2019-10-25 01:12:37'),
(165, 172, 'E - 158 Dt', 'Taufikku Rahman', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-10-23 04:22:15', '2019-10-23 04:22:15'),
(166, 174, 'E - 159 Dt', 'Fauzan', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-10-23 05:39:15', '2019-10-23 05:39:15'),
(167, 175, 'E - 160 Dt', 'Fauzan', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-10-23 05:43:07', '2019-10-23 05:43:07'),
(168, 176, 'E - 161 Dt', 'Taufikku Rahman', 17, 10, 1, 1, 1, 1, 1, 1, 1, '2019-10-24 00:32:52', '2019-10-24 00:32:52'),
(169, 177, 'E - 162 Dt', 'Ibu Andriyani', 17, 10, 1, 1, 1, 1, 1, 1, 1, '2019-10-24 01:43:39', '2019-10-24 01:43:39'),
(170, 178, 'E - 163 Dt', 'Ibu Andriyani', 17, 10, 1, 1, 1, 1, 1, 1, 1, '2019-10-24 02:05:58', '2019-10-24 02:05:58'),
(171, 179, 'E - 164 Dt', 'Muhammad Irwan', 17, 10, 1, 1, 1, 1, 1, 1, 1, '2019-10-25 02:17:36', '2019-10-25 02:17:36'),
(174, 182, 'E - 165 Dt', 'Muhammad Irwan', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-10-29 04:17:31', '2019-10-29 04:17:31'),
(175, 183, 'E - 166 Dt', 'Hanafi', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-11-01 03:04:52', '2019-11-01 03:05:56'),
(176, 184, 'E - 167 Dt', 'Ardiansyah, S. Kep', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-11-04 02:36:44', '2019-11-04 03:15:29'),
(177, 185, 'E - 170 Dt', 'Dani', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-11-05 00:49:57', '2019-11-05 00:49:57'),
(178, 186, 'E - 168 Dt', 'Dikirim', 17, 21, 1, 1, 1, 1, 1, 1, 1, '2019-11-05 02:00:10', '2019-11-05 02:00:10'),
(179, 187, 'E - 171 Dt', 'Eka', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-11-05 02:08:55', '2019-11-05 02:21:02'),
(180, 188, 'E - 169 Dt', 'Dikirim', 17, 21, 1, 1, 1, 1, 1, 1, 1, '2019-11-05 02:11:07', '2019-11-05 02:11:07'),
(181, 189, 'E - 172 Dt', 'Dwi Noriyati', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-11-05 03:48:53', '2019-11-05 03:48:53'),
(182, 190, 'E - 173 Dt', 'Muhammad Irwan', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-11-07 02:34:11', '2019-11-07 02:34:11'),
(183, 191, 'E - 174 Dt', 'Muhammad Irwan', 18, 10, 1, 1, 1, 1, 1, 1, 1, '2019-11-08 01:42:07', '2019-11-08 01:42:07'),
(184, 192, 'E - 175 Dt', 'Heffy Erlina', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2019-11-11 05:29:31', '2019-11-11 05:29:31'),
(185, 193, 'E - 176 Dt', 'Yuni', 18, 12, 1, 1, 1, 1, 1, 1, 1, '2019-11-12 07:09:57', '2019-11-12 07:09:57'),
(186, 194, 'E - 177 Dt', 'Muhammad Irwan', 17, 5, 1, 1, 1, 1, 1, 1, 1, '2019-11-13 01:44:25', '2019-11-13 01:44:25'),
(187, 195, 'E - 178 Dt', 'Muhammad Irwan', 17, 5, 1, 1, 1, 1, 1, 1, 1, '2019-11-13 01:50:37', '2019-11-13 01:50:37'),
(188, 196, 'E - 179 Dt', 'Muhammad Irwan', 17, 5, 1, 1, 1, 1, 1, 1, 1, '2019-11-13 01:55:42', '2019-11-13 01:55:42'),
(189, 197, 'E - 180 Dt', 'Yuni', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-11-15 02:03:42', '2019-11-15 02:03:42'),
(190, 198, 'E - 181 Dt', 'Dikirim', 18, 10, 1, 1, 1, 1, 1, 1, 1, '2019-11-18 00:26:47', '2019-11-18 00:26:47'),
(191, 199, 'E - 182 Dt', 'Dikirim', 18, 10, 1, 1, 1, 1, 1, 1, 1, '2019-11-18 06:26:28', '2019-11-18 06:26:28'),
(192, 200, 'E - 183 Dt', 'Muhammad Irwan', 17, 5, 1, 1, 1, 1, 1, 1, 1, '2019-11-25 02:20:12', '2019-11-25 02:20:12'),
(193, 201, 'E - 184 Dt', 'Muhammad Irwan', 17, 21, 1, 1, 1, 1, 1, 1, 1, '2019-11-27 02:21:49', '2019-11-27 02:21:49'),
(194, 202, 'E - 185 Dt', 'Budi Wijaya', 17, 11, 1, 1, 1, 1, 1, 1, 1, '2019-11-29 01:02:11', '2019-11-29 01:02:11'),
(195, 203, 'E - 186 Dt', 'Daniel', 18, 9, 1, 1, 1, 1, 1, 1, 1, '2019-12-02 05:18:22', '2019-12-02 05:18:22'),
(196, 204, 'E - 187 Dt', 'Dikirim', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2019-12-05 06:34:54', '2019-12-06 01:36:34'),
(197, 205, 'E - 188 Dt', 'Dikirim', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2019-12-05 06:44:54', '2019-12-06 01:43:41'),
(198, 206, 'E - 189 Dt', 'Dikirim', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2019-12-05 06:50:23', '2019-12-06 01:45:13'),
(199, 207, 'E - 190 Dt', 'Dikirim', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2019-12-05 07:01:49', '2019-12-06 01:38:33'),
(200, 208, 'E - 191 Dt', 'Aida Surahmah, A.Md', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2019-12-06 01:33:54', '2019-12-06 01:33:54'),
(201, 209, 'E - 192 Dt', 'Dani', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2019-12-06 06:47:44', '2019-12-06 06:47:44'),
(202, 210, 'E - 193 Dt', 'Habib Al- Ichrom', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-12-09 00:22:12', '2019-12-09 00:22:12'),
(203, 211, 'E - 194 Dt', 'dikirim', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-12-09 06:41:51', '2019-12-09 06:41:51'),
(204, 212, 'E - 195 Dt', '-', 17, 7, 1, 1, 1, 1, 1, 1, 1, '2019-12-09 07:30:15', '2019-12-09 07:30:15'),
(205, 213, 'E - 196 Dt', 'Muhammad Irwan', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-12-13 02:35:28', '2019-12-13 02:35:28'),
(206, 214, 'E - 197 Dt', 'Rahmat', 17, 9, 1, 1, 1, 1, 1, 1, 1, '2019-12-19 07:53:09', '2019-12-19 07:53:09'),
(207, 215, 'E - 198 Dt', 'Dewi', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2019-12-23 02:42:50', '2019-12-23 02:42:50'),
(208, 216, 'E - 001 Dt', 'dikirim', 18, 11, 1, 1, 1, 1, 1, 1, 1, '2019-12-31 01:59:53', '2019-12-31 01:59:53'),
(211, 219, 'E - 002 Dt', 'Kasripin', 17, 17, 1, 1, 1, 1, 1, 1, 1, '2020-01-06 02:15:09', '2020-01-06 02:15:09'),
(212, 220, 'E - 003 Dt', 'Dr. Edward', 18, 7, 1, 1, 1, 1, 1, 1, 1, '2020-01-20 04:52:52', '2020-01-20 04:52:52'),
(213, 221, 'E - 004 Dt', 'Dr. Edward', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2020-01-21 04:26:27', '2020-01-21 04:26:27'),
(214, 222, 'E - 005 Dt', 'Hadi Sungkono', 17, 21, 1, 1, 1, 1, 1, 1, 1, '2020-01-22 02:26:57', '2020-01-22 02:26:57'),
(215, 223, 'E - 006 Dt', 'Saiful Bahri', 17, 17, 1, 1, 1, 1, 1, 1, 1, '2020-01-28 07:37:32', '2020-01-28 07:37:32'),
(216, 224, 'E - 007 Dt', 'Bu Sari', 17, 17, 1, 1, 1, 1, 1, 1, 1, '2020-02-06 02:42:42', '2020-02-06 02:42:42'),
(217, 226, 'E - 008 Dt', 'Fauzan', 17, 25, 1, 1, 1, 1, 1, 1, 1, '2020-02-11 06:10:42', '2020-02-11 06:31:59'),
(218, 227, 'E - 009 Dt', 'dikirim', 18, 25, 1, 1, 1, 1, 1, 1, 1, '2020-02-11 07:56:59', '2020-02-11 07:56:59'),
(219, 228, 'E - 010 Dt', 'Syairil Ihsan', 17, 17, 1, 1, 1, 1, 1, 1, 1, '2020-02-12 04:55:31', '2020-02-12 04:55:31'),
(220, 229, 'E - 011 Dt', 'Arief Pramono', 17, 22, 1, 1, 1, 1, 1, 1, 1, '2020-02-13 05:40:04', '2020-02-13 05:40:04'),
(221, 230, 'E - 012 Dt', 'dikirim', 17, 18, 1, 1, 1, 1, 1, 1, 1, '2020-02-24 07:24:09', '2020-02-24 07:24:09'),
(222, 231, 'E - 013 Dt', 'Fauzan', 18, 18, 1, 1, 1, 1, 1, 1, 1, '2020-02-25 05:47:00', '2020-02-25 05:47:00'),
(223, 232, 'E - 014 Dt', 'dr. Daryl', 18, 22, 1, 1, 1, 1, 1, 1, 1, '2020-02-27 06:42:00', '2020-02-27 06:42:00'),
(224, 233, 'E - 015 Dt', 'Alvinda Pradita Wardana', 17, 5, 1, 1, 1, 1, 1, 1, 1, '2020-03-02 02:31:53', '2020-03-02 02:31:53'),
(225, 234, 'E - 016 Dt', 'Hamdan Burhanuddin', 18, 5, 1, 1, 1, 1, 1, 1, 1, '2020-03-02 02:35:23', '2020-03-02 02:35:23'),
(226, 235, 'E - 017 Dt', 'Misna', 17, 18, 1, 1, 1, 1, 1, 1, 1, '2020-03-02 07:07:21', '2020-03-02 07:07:21'),
(227, 236, 'E - 018 Dt', 'Syaiful Azmi', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2020-03-05 01:18:56', '2020-03-05 01:18:56'),
(228, 237, 'E - 019 Dt', 'Iptu Pangat Supriyadi', 18, 12, 1, 1, 1, 1, 1, 1, 1, '2020-03-06 06:42:30', '2020-03-06 06:42:30'),
(229, 238, 'E - 020 Dt', '-', 17, 25, 1, 1, 1, 1, 1, 1, 1, '2020-03-12 05:47:38', '2020-03-12 06:01:03'),
(230, 239, 'E - 021 Dt', 'Nor Asiah', 17, 25, 1, 1, 1, 1, 1, 1, 1, '2020-03-13 03:44:28', '2020-03-13 03:44:28'),
(231, 240, 'E - 022 Dt', 'dikirim', 17, 21, 1, 1, 1, 1, 1, 1, 1, '2020-04-07 02:34:05', '2020-04-07 02:41:35'),
(232, 241, 'E - 023 Dt', 'Maulana', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-06-15 07:41:23', '2020-06-15 09:08:34'),
(233, 242, 'E - 024 Dt', 'Maulana', 18, 27, 1, 1, 1, 1, 1, 1, 1, '2020-06-15 07:58:30', '2020-06-15 09:09:13'),
(234, 243, 'E - 025 Dt', 'Maulana', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2020-06-15 08:02:15', '2020-06-15 09:09:42'),
(235, 244, 'E - 026 Dt', 'Maulana', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2020-06-15 08:08:08', '2020-06-15 09:10:21'),
(236, 245, 'E - 027 Dt', 'Maulana', 18, 29, 1, 1, 1, 1, 1, 1, 1, '2020-06-15 08:17:35', '2020-06-15 09:11:52'),
(237, 246, 'E - 028 Dt', 'Maulana', 17, 25, 1, 1, 1, 1, 1, 1, 1, '2020-06-15 08:27:52', '2020-06-15 09:12:16'),
(238, 247, 'E - 029 Dt', 'Maulana', 18, 27, 1, 1, 1, 1, 1, 1, 1, '2020-06-25 03:12:56', '2020-06-25 03:12:56'),
(239, 248, 'E - 030 Dt', 'Ana', 17, 28, 1, 1, 1, 1, 1, 1, 1, '2020-06-25 03:16:21', '2020-06-25 03:16:21'),
(240, 249, 'E - 031 Dt', 'Alpiannor Rozikin', 18, 27, 1, 1, 1, 1, 1, 1, 1, '2020-06-30 01:00:10', '2020-06-30 01:00:10'),
(241, 250, 'E - 032 Dt', 'Wiwien Widyaningrum S.', 17, 28, 1, 1, 1, 1, 1, 1, 1, '2020-07-02 06:09:54', '2020-07-02 06:09:54'),
(242, 251, 'E - 033 Dt', 'dikirim', 17, 18, 1, 1, 1, 1, 1, 1, 1, '2020-07-06 07:56:39', '2020-07-06 07:56:39'),
(243, 252, 'E - 034 Dt', 'Muhammad Irwan', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-07-10 00:57:54', '2020-07-10 00:57:54'),
(244, 253, 'E - 035 Dt', 'Muhammad Irwan', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-07-22 02:18:29', '2020-07-22 02:18:29'),
(245, 254, 'E - 036 Dt', 'Dikirim', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-07-22 03:11:00', '2020-07-22 03:11:00'),
(246, 255, 'E - 037 Dt', '-', 18, 25, 1, 1, 1, 1, 1, 1, 1, '2020-07-22 03:23:43', '2020-07-22 03:23:43'),
(247, 256, 'E - 038 Dt', 'Dikirim', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-07-30 04:26:08', '2020-07-30 04:26:08'),
(248, 257, 'E - 039 Dt', 'Dikirim', 17, 18, 1, 1, 1, 1, 1, 1, 1, '2020-08-03 07:02:10', '2020-08-03 07:02:10'),
(249, 258, 'E - 040 Dt', 'Dinkes Barito Selatan', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 00:38:16', '2020-08-06 00:38:16'),
(250, 259, 'E - 041 Dt', 'Dinkes Barito Selatan', 18, 31, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 00:42:33', '2020-08-06 00:42:33'),
(252, 262, 'E - 043 Dt', 'Dinkes Barito Selatan', 17, 18, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 01:11:57', '2020-08-06 01:11:57'),
(253, 263, 'E - 044 Dt', 'Dinkes Barito Selatan', 17, 22, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 02:54:57', '2020-08-06 02:54:57'),
(254, 264, 'E - 045 Dt', 'Dinkes Barito Selatan', 17, 18, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 05:53:48', '2020-08-06 05:53:48'),
(255, 265, 'E - 046 Dt', 'Dinkes Barito Selatan', 18, 25, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 06:14:17', '2020-08-06 06:14:17'),
(256, 266, 'E - 047 Dt', 'Dinkes Barito Selatan', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 07:06:21', '2020-08-06 07:06:21'),
(257, 267, 'E - 048 Dt', 'Dinkes Barito Selatan', 17, 25, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 07:50:35', '2020-08-06 07:50:35'),
(258, 268, 'E - 049 dT', 'Dinkes Barito Selatan', 18, 17, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 08:03:25', '2020-08-06 08:03:25'),
(259, 269, 'E - 050 Dt', 'Dinkes Barito Selatan', 18, 25, 1, 1, 1, 1, 1, 1, 1, '2020-08-06 08:14:45', '2020-08-06 08:14:45'),
(260, 270, 'E - 051 Dt', 'Abdurrahman', 17, 29, 1, 1, 1, 1, 1, 1, 1, '2020-08-10 05:49:46', '2020-08-19 07:08:13'),
(261, 271, 'E - 052 Dt', 'Uswatun', 17, 18, 1, 1, 1, 1, 1, 1, 1, '2020-08-11 08:58:36', '2020-08-11 08:58:36'),
(262, 272, 'E - 042 Dt', 'Dinkes Barito Selatan', 17, 29, 1, 1, 1, 1, 1, 1, 1, '2020-08-18 05:21:22', '2020-08-18 05:21:22'),
(263, 273, 'E - 054 Dt', 'Suhermato', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-08-18 05:36:50', '2020-08-18 05:36:50'),
(264, 274, 'E - 053 Dt', 'Linda', 18, 27, 1, 1, 1, 1, 1, 1, 1, '2020-08-18 06:08:47', '2020-08-18 06:08:47'),
(265, 275, 'E - 055 Dt', '-', 17, 29, 1, 1, 1, 1, 1, 1, 1, '2020-08-24 07:52:10', '2020-08-24 07:52:10'),
(266, 276, 'E - 056 Dt', '-', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-08-24 08:15:23', '2020-08-24 08:15:23'),
(267, 277, 'E - 057 Dt', '-', 17, 16, 1, 1, 1, 1, 1, 1, 1, '2020-08-24 08:29:52', '2020-08-24 08:29:52'),
(268, 278, 'E - 058 Dt', '-', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-08-24 08:35:29', '2020-08-24 08:35:29'),
(270, 281, 'E - 059 Dt', '-', 17, 25, 1, 1, 1, 1, 1, 1, 1, '2020-08-25 03:46:16', '2020-08-25 03:46:16'),
(271, 282, 'E - 060 Dt', 'Bella', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-08-26 02:59:28', '2020-08-26 02:59:28'),
(272, 283, 'E - 061 Dt', 'Mariyatul', 18, 28, 1, 1, 1, 1, 1, 1, 1, '2020-08-28 07:16:15', '2020-08-28 07:40:33'),
(273, 284, 'E - 062 Dt', 'Dinkes Barito Selatan', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-08-31 01:57:41', '2020-08-31 01:57:41'),
(274, 285, 'E - 063 Dt', 'Muhammad Irwan', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2020-09-01 07:50:41', '2020-09-01 07:50:41'),
(275, 286, 'E - 064 Dt', '-', 18, 29, 1, 1, 1, 1, 1, 1, 1, '2020-09-04 08:50:00', '2020-09-04 08:50:00'),
(276, 287, 'E - 065 Dt', 'Wiwik', 17, 22, 1, 1, 1, 1, 1, 1, 1, '2020-09-07 08:19:21', '2020-09-07 08:19:21'),
(277, 288, 'E - 066 Dt', 'Wiwin', 18, 17, 1, 1, 1, 1, 1, 1, 1, '2020-09-09 01:04:03', '2020-09-09 01:04:03'),
(278, 289, 'E - 067 Dt', 'Wiwin', 18, 22, 1, 1, 1, 1, 1, 1, 1, '2020-09-09 01:05:33', '2020-09-09 01:05:33'),
(279, 290, 'E - 068 Dt', 'Wiwin', 18, 25, 1, 1, 1, 1, 1, 1, 1, '2020-09-09 01:09:21', '2020-09-09 01:09:21'),
(280, 291, 'E - 069 Dt', 'Wiwin', 18, 31, 1, 1, 1, 1, 1, 1, 1, '2020-09-09 01:11:03', '2020-09-09 01:11:03'),
(281, 292, 'E - 070 Dt', 'Wiwin', 17, 18, 1, 1, 1, 1, 1, 1, 1, '2020-09-09 06:34:11', '2020-09-09 06:34:11'),
(282, 293, 'E - 071 Dt', 'Wiwin', 17, 25, 1, 1, 1, 1, 1, 1, 1, '2020-09-09 06:36:21', '2020-09-09 06:36:21'),
(283, 294, 'E - 072 Dt', 'Mariyatul', 17, 31, 1, 1, 1, 1, 1, 1, 1, '2020-09-09 06:40:03', '2020-09-09 06:40:03'),
(284, 295, 'E - 073 Dt', 'Bahran', 17, 22, 1, 1, 1, 1, 1, 1, 1, '2020-09-09 06:53:12', '2020-09-09 06:53:12'),
(285, 296, 'E - 074 Dt', 'Mustafa', 18, 29, 1, 1, 1, 1, 1, 1, 1, '2020-09-10 08:29:13', '2020-09-24 03:48:37'),
(286, 297, 'E - 075 Dt', 'Erlita Astuti', 18, 29, 1, 1, 1, 1, 1, 1, 1, '2020-09-10 08:40:28', '2020-09-24 00:38:47'),
(287, 298, 'E - 076 Dt', 'Dinkes Kota Banjarbaru', 18, 29, 1, 1, 1, 1, 1, 1, 1, '2020-09-10 08:43:49', '2020-09-10 08:43:49'),
(288, 299, 'E - 077 Dt', 'Erlita Astuti', 18, 31, 1, 1, 1, 1, 1, 1, 1, '2020-09-18 07:24:52', '2020-09-24 00:38:04'),
(289, 300, 'E - 078 Dt', 'Bara Riyanto', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-09-21 06:48:09', '2020-09-21 06:48:09'),
(290, 301, 'E - 079 Dt', 'Yatin', 17, 28, 1, 1, 1, 1, 1, 1, 1, '2020-09-28 07:19:42', '2020-09-28 07:19:42'),
(291, 302, 'E - 080 Dt', 'Frans Hernugroho', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-09-28 07:25:22', '2020-09-28 07:25:22'),
(292, 303, 'E - 081 Dt', 'Dinkes Banjarbaru', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-09-28 07:29:40', '2020-09-28 07:29:40'),
(293, 304, 'E - 087 Dt', 'Iwan Budiono', 18, 29, 1, 1, 1, 1, 1, 1, 1, '2020-09-28 08:05:56', '2020-09-28 08:05:56'),
(294, 305, 'E - 082 Dt', 'Dinkes HST', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-09-29 08:24:42', '2020-09-29 08:24:42'),
(295, 306, 'E - 083 Dt', 'Dinkes HST', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-09-29 08:28:58', '2020-09-29 08:28:58'),
(296, 307, 'E - 084 Dt', 'Dinkes HST', 17, 28, 1, 1, 1, 1, 1, 1, 1, '2020-09-29 08:38:40', '2020-09-29 08:38:40'),
(297, 308, 'E - 085 Dt', '-', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 03:25:21', '2020-10-06 03:41:46'),
(298, 309, 'E - 086 Dt', 'Dinkes HST', 18, 27, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 03:34:39', '2020-10-01 03:34:39'),
(299, 310, 'E - 088 Dt', 'Dinkes HST', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 05:58:20', '2020-10-01 05:58:20'),
(300, 311, 'E - 089 Dt', 'Dinkes HST', 18, 25, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 06:43:39', '2020-10-01 06:43:39'),
(301, 312, 'E - 090 Dt', 'Dinkes HST', 18, 22, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 07:17:28', '2020-10-01 07:17:28'),
(302, 313, 'E - 091 Dt', 'Dinkes HST', 17, 25, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 07:21:55', '2020-10-01 07:21:55'),
(303, 314, 'E - 092 Dt', 'Dinkes HST', 17, 28, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 07:36:56', '2020-10-01 07:36:56'),
(304, 315, 'E - 093 Dt', 'Dinkes HST', 17, 28, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 07:50:44', '2020-10-01 07:50:44'),
(305, 316, 'E - 094 Dt', 'Dinkes HST', 17, 25, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 07:59:23', '2020-10-01 07:59:23'),
(306, 317, 'E - 095 Dt', '-', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-10-01 08:24:06', '2020-10-01 08:24:06'),
(307, 318, 'E - 096 Dt', 'Dikirim', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-10-02 08:29:18', '2020-10-02 08:45:56'),
(308, 319, 'E - 097 Dt', 'dikirim', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-02 09:00:19', '2020-10-02 09:00:19'),
(309, 320, 'E - 098 Dt', 'Dani', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-10-02 09:03:07', '2020-10-05 06:03:28'),
(310, 321, 'E - 099 Dt', '-', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-06 03:22:03', '2020-10-06 03:22:03'),
(312, 323, 'E - 100 Dt', 'Hj. Mursidah', 17, 29, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 00:28:50', '2020-10-08 00:28:50'),
(313, 324, 'E - 101 Dt', 'Hj. Mursidah', 17, 29, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 01:27:10', '2020-10-08 01:27:10'),
(314, 325, 'E - 102 Dt', 'Hj, Mursidah', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 01:34:21', '2020-10-08 01:34:21'),
(315, 326, 'E - 103 Dt', 'Hj. Mursidah', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 01:56:29', '2020-10-08 01:56:29'),
(316, 327, 'E - 104 Dt', 'Hj. Mursidah', 17, 21, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 02:43:33', '2020-10-08 02:43:33'),
(317, 328, 'E - 105 Dt', 'Hj. Mursidah', 17, 21, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 02:48:38', '2020-10-08 02:48:38'),
(318, 329, 'E - 106 Dt', 'Hj. Mursidah', 17, 28, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 03:01:31', '2020-10-08 03:01:31'),
(319, 330, 'E - 107 Dt', 'Hj. Mursidah', 17, 28, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 03:05:53', '2020-10-08 03:05:53'),
(320, 331, 'E - 108 Dt', 'Hj. Mursidah', 17, 31, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 03:12:56', '2020-10-08 03:12:56'),
(321, 332, 'E - 109 Dt', 'Muhammad Irwan', 18, 28, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 03:17:05', '2020-10-08 03:21:31'),
(322, 333, 'E - 110 Dt', 'Muhammad Irwan', 18, 22, 1, 1, 1, 1, 1, 1, 1, '2020-10-08 03:23:00', '2020-10-08 03:23:00'),
(323, 334, 'E - 111 Dt', 'Sukma', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-09 00:37:18', '2020-10-09 00:37:18'),
(324, 335, 'E - 112 Dt', 'Muhammad Irwan', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-13 00:56:19', '2020-10-13 00:56:19'),
(325, 336, 'E - 113 Dt', 'Dinkes Sukamara', 18, 22, 1, 1, 1, 1, 1, 1, 1, '2020-10-14 01:52:13', '2020-10-14 01:52:13'),
(326, 337, 'E - 114 Dt', 'Dinkes Sukamara', 18, 22, 1, 1, 1, 1, 1, 1, 1, '2020-10-14 02:00:30', '2020-10-14 02:00:30'),
(327, 338, 'E - 115 Dt', 'Dinkes Sukamara', 18, 22, 1, 1, 1, 1, 1, 1, 1, '2020-10-14 02:02:28', '2020-10-14 02:02:28'),
(328, 339, 'E - 116 Dt', 'Dinkes Sukamara', 18, 22, 1, 1, 1, 1, 1, 1, 1, '2020-10-14 02:12:11', '2020-10-14 02:12:11'),
(329, 340, 'E - 117 Dt', 'Muhammad Irwan', 18, 29, 1, 1, 1, 1, 1, 1, 1, '2020-10-15 07:30:57', '2020-10-15 07:30:57'),
(330, 341, 'E - 118 Dt', 'Dikirim', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-20 02:44:12', '2020-10-20 02:44:12'),
(331, 342, 'E - 119 Dt', 'Dr. Widi', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-20 03:10:38', '2020-10-20 03:10:38'),
(332, 343, 'E - 120 Dt', 'drh. Arya T. Sarjananto', 18, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-20 03:22:43', '2020-10-20 03:22:43'),
(333, 345, 'E - 121 Dt', 'Arif', 17, 12, 1, 1, 1, 1, 1, 1, 1, '2020-10-20 08:29:27', '2020-10-21 06:29:46'),
(334, 346, 'E - 122 Dt', '-', 18, 17, 1, 1, 1, 1, 1, 1, 1, '2020-10-20 08:33:37', '2020-10-20 08:33:37'),
(335, 347, 'E - 130 Dt', 'Dinkes HST', 17, 22, 1, 1, 1, 1, 1, 1, 1, '2020-10-23 01:39:10', '2020-10-23 01:39:10'),
(336, 348, 'E - 123 Dt', '-', 17, 30, 1, 1, 1, 1, 1, 1, 1, '2020-10-27 02:56:17', '2020-10-27 02:56:17'),
(337, 349, 'E - 124 Dt', '-', 17, 21, 1, 1, 1, 1, 1, 1, 1, '2020-10-27 03:07:17', '2020-10-27 03:07:17'),
(339, 351, 'E - 125 Dt', 'Dinkes Tanah Bumbu', 17, 27, 1, 1, 1, 1, 1, 1, 1, '2020-10-27 03:30:20', '2020-10-27 03:30:20'),
(340, 352, 'E - 126 Dt', '-', 18, 27, 1, 1, 1, 1, 1, 1, 1, '2020-10-27 03:44:11', '2020-10-27 03:44:11'),
(341, 353, 'E - 127 Dt', '-', 18, 16, 1, 1, 1, 1, 1, 1, 1, '2020-10-27 04:01:17', '2020-10-27 04:01:17'),
(343, 355, 'E - 128 Dt', 'Dinkes Tanah Bumbu', 18, 29, 1, 1, 1, 1, 1, 1, 1, '2020-10-27 04:23:48', '2020-10-27 04:23:48'),
(344, 356, 'E - 129 Dt', '-', 18, 22, 1, 1, 1, 1, 1, 1, 1, '2020-10-27 04:31:12', '2020-10-27 04:31:12'),
(345, 362, '23445', '3345', 17, 9, 1, 1, 1, NULL, NULL, NULL, NULL, '2021-01-17 10:16:04', '2021-01-17 10:16:04');

-- --------------------------------------------------------

--
-- Table structure for table `lab_spk`
--

CREATE TABLE `lab_spk` (
  `id` int(10) UNSIGNED NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `no_order` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `petugas_id` int(11) NOT NULL,
  `unit_kerja` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alat_id` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tempat` int(11) NOT NULL,
  `ka_instalasi` int(11) NOT NULL,
  `tgl_spk` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_spk`
--

INSERT INTO `lab_spk` (`id`, `id_order`, `no_order`, `petugas_id`, `unit_kerja`, `alat_id`, `tempat`, `ka_instalasi`, `tgl_spk`, `catatan`, `created_at`, `updated_at`) VALUES
(3, 3, 'E - 002 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"34\"]', 6, 1, NULL, NULL, '2019-01-24 09:16:16', '2019-02-18 09:11:13'),
(4, 4, 'E - 004 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"15\"]', 6, 1, NULL, NULL, '2019-01-30 10:55:23', '2019-01-30 10:55:23'),
(5, 5, 'E - 005 Dt', 10, 'Laboratorium Pengujian dan Kalibrasi', '[\"18\"]', 5, 1, NULL, NULL, '2019-02-03 11:18:25', '2019-02-03 11:18:25'),
(6, 6, 'E - 006 Dt', 12, 'Laboratorium Pengujian dan Kalibrasi', '[\"19,20\"]', 1, 1, NULL, NULL, '2019-02-05 11:07:52', '2019-02-10 09:35:09'),
(7, 6, 'E - 006 Dt', 10, 'Laboratorium Pengujian dan Kalibrasi', '[\"23\"]', 5, 1, NULL, NULL, '2019-02-05 11:10:53', '2019-02-05 11:10:53'),
(8, 6, 'E - 006 Dt', 6, 'Laboratorium Pengujian dan Kalibrasi', '[\"21\"]', 2, 1, NULL, 'LHK (1) LMK (1)', '2019-02-05 11:12:37', '2020-10-27 07:44:54'),
(9, 6, 'E - 006 Dt', 9, 'Laboratorium Pengujian dan Kalibrasi', '[\"22\"]', 6, 1, NULL, 'LHB (1) LMB (1)', '2019-02-05 11:13:42', '2020-10-27 07:44:26'),
(12, 8, 'E - 008 Dt', 9, 'Laboratorium Pengujian dan Kalibrasi', '[\"25,26\"]', 2, 1, NULL, NULL, '2019-02-12 08:28:52', '2019-02-12 08:28:52'),
(13, 8, 'E - 008 Dt', 13, 'Laboratorium Pengujian dan Kalibrasi', '[\"27,28,29\"]', 5, 1, NULL, NULL, '2019-02-12 08:30:51', '2019-02-12 08:30:51'),
(14, 9, 'E - 009 Dt', 10, 'Laboratorium Pengujian dan Kalibrasi', '[\"32\"]', 5, 1, NULL, NULL, '2019-02-17 13:31:23', '2019-02-17 13:31:23'),
(16, 11, 'E - 010 Dt', 11, 'Laboratorium Pengujian dan Kalibrasi', '[\"35,36,37,38,39\"]', 6, 1, NULL, NULL, '2019-02-18 12:22:57', '2019-02-18 12:22:57'),
(17, 8, 'E - 008 Dt', 12, 'Laboratorium Pengujian dan Kalibrasi', '[\"30,31\"]', 1, 1, '2019-02-18', NULL, '2019-02-19 09:35:29', '2019-02-19 09:49:50'),
(18, 7, 'E - 007 Dt', 12, 'Laboratorium Pengujian dan Kalibrasi', '[\"24\"]', 1, 1, '2019-02-18', NULL, '2019-02-19 09:38:26', '2019-02-19 09:49:26'),
(19, 12, 'E - 011 Dt', 11, 'Laboratorium Pengujian dan/atau Kalibrasi', '[\"40,41\"]', 6, 1, '2019-02-20', NULL, '2019-02-19 14:57:26', '2019-02-19 14:57:26'),
(20, 14, 'E - 012 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"45\"]', 8, 1, '2019-02-26', NULL, '2019-02-24 21:27:44', '2019-02-28 23:39:04'),
(21, 12, 'E - 011 Dt', 9, 'Laboratorium Pengujian dan Kalibrasi', '[\"15,79\"]', 3, 1, '2019-03-05', NULL, '2019-02-24 23:14:44', '2019-03-13 22:32:15'),
(22, 15, 'E - 013 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"48,49\"]', 3, 1, '2019-02-28', NULL, '2019-02-28 23:48:44', '2019-03-03 18:18:19'),
(23, 15, 'E - 013 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"46,47\"]', 6, 1, '2019-03-04', NULL, '2019-03-03 18:20:25', '2019-03-03 18:20:25'),
(24, 17, 'E - 015 Dt', 12, 'Laboratorium  Kalibrasi LPFK Banjarbaru', '[\"51\"]', 6, 1, '2019-03-08', NULL, '2019-03-05 22:27:07', '2019-03-05 22:54:05'),
(25, 19, 'E - 017 Dt', 9, 'Laboratorium Kalibrasi Pengujian dan Kalibrasi', '[\"53,54,55\"]', 3, 1, '2019-03-11', NULL, '2019-03-10 16:24:26', '2019-03-10 16:24:26'),
(26, 18, 'E - 016 Dt', 12, 'Laboratorium Pengujian dan Kalibrasi', '[\"52\"]', 1, 1, '2019-03-08', NULL, '2019-03-10 22:25:10', '2019-03-10 22:25:10'),
(27, 20, 'E - 018 Dt', 9, 'Laboratorium Pengujian dan/atau Kalibrasi', '[\"56\"]', 6, 1, '2019-03-14', NULL, '2019-03-13 18:00:07', '2019-03-13 18:00:07'),
(28, 21, 'E - 019 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"57,76,77,75\"]', 6, 1, '2019-03-18', NULL, '2019-03-18 17:43:09', '2019-03-19 19:45:51'),
(29, 21, 'E - 019 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"59,60,61,62,63,66,67,68,69,70,71,72,73,86\"]', 3, 1, '2019-03-15', NULL, '2019-03-18 17:48:04', '2019-03-18 17:48:04'),
(30, 25, 'E - 021 Dt', 9, 'Laboratorium Kalibrasi LPFK', '[\"84,85\"]', 3, 1, '2019-03-18', NULL, '2019-03-18 17:49:28', '2019-03-18 17:49:28'),
(31, 26, 'E - 023 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"88,89,90,93,94,96,97,98,99,100,101,102,103,104,105,106,107,108,109,122,123,92\"]', 9, 1, '2019-03-22', NULL, '2019-03-24 16:33:44', '2019-04-22 06:56:24'),
(32, 27, 'E - 024 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"111,112,116,117,118\"]', 9, 1, '2019-03-22', NULL, '2019-03-24 16:36:59', '2019-04-08 02:00:13'),
(33, 28, 'E - 025 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"119\"]', 7, 1, '2019-03-25', NULL, '2019-03-24 16:37:45', '2019-03-24 16:37:45'),
(34, 29, 'E - 026 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"120,121\"]', 2, 1, '2019-03-22', NULL, '2019-03-24 16:42:19', '2019-03-24 16:42:19'),
(35, 23, 'E - 022 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"80\"]', 3, 1, '2019-03-22', NULL, '2019-03-24 16:45:06', '2019-03-24 16:45:06'),
(36, 52, 'E - 045 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"252,253\"]', 2, 1, '2019-03-22', NULL, '2019-03-24 16:54:00', '2019-03-24 16:54:00'),
(37, 16, 'E - 014 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"133\"]', 1, 1, '2019-03-22', NULL, '2019-03-24 16:58:12', '2019-03-24 16:58:12'),
(38, 32, 'E - 033 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"141,143,144,149\"]', 9, 1, '2019-03-22', NULL, '2019-03-24 18:36:54', '2019-03-24 18:36:54'),
(39, 22, 'E - 020 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"78\"]', 1, 1, '2019-03-18', NULL, '2019-03-28 02:12:59', '2019-03-28 02:12:59'),
(40, 32, 'E - 033 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"146,151\"]', 5, 1, '2019-03-25', NULL, '2019-03-28 02:30:01', '2019-03-28 02:30:01'),
(41, 39, 'E - 035 Dt', 20, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"197\"]', 1, 1, '2019-03-29', NULL, '2019-03-29 00:15:54', '2019-03-29 00:15:54'),
(42, 53, 'E - 046 Dt', 9, 'Laboratorium Pengujian dan/atau Kalibrasi', '[\"271,263,260,268,262,264,269,272,270,258,259,266,261,267,265\"]', 9, 1, '2019-04-01', NULL, '2019-04-02 01:56:37', '2019-04-02 01:56:37'),
(43, 31, 'E - 028 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"145,142,148,147\"]', 9, 1, '2019-03-25', NULL, '2019-04-08 01:37:38', '2019-04-08 01:37:38'),
(44, 30, 'E - 027 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"124,125,126,127,128,129,130,131,132,135\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 01:39:24', '2019-04-22 06:58:39'),
(45, 33, 'E - 029 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"166,157,160,162\"]', 9, 1, '2019-03-22', NULL, '2019-04-08 01:42:08', '2019-04-08 01:42:08'),
(46, 34, 'E - 030 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"155,156,158,159,161,164,165,167,170\"]', 9, 1, '2019-03-25', NULL, '2019-04-08 01:42:55', '2019-04-22 07:25:58'),
(47, 36, 'E - 031 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"171,180,176\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 01:45:40', '2019-04-08 01:45:40'),
(48, 38, 'E - 034 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"188,189,187\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 01:47:12', '2019-04-08 01:47:12'),
(49, 39, 'E - 035 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"192,195,194,196,201,200,199,198,193\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 01:48:29', '2019-04-08 01:48:29'),
(50, 43, 'E - 036 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"205,206,208\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 01:49:13', '2019-04-08 01:49:13'),
(51, 44, 'E - 037 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"216,214,215,218,212,239\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 01:49:38', '2019-04-08 01:49:38'),
(52, 45, 'E - 038 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"225,226,224,245,227,223,222,228,221,220,244\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 01:50:43', '2019-04-08 01:50:43'),
(53, 46, 'E - 040 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"251,233,232,231,230\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 01:51:31', '2019-04-08 01:51:31'),
(54, 48, 'E - 042 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"241,242,243\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 01:51:56', '2019-04-08 01:51:56'),
(55, 42, 'E - 039 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"207,211,210,203,213\"]', 9, 1, '2019-03-27', NULL, '2019-04-08 01:52:30', '2019-04-08 01:52:30'),
(56, 47, 'E - 041 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"235,238,236,234\"]', 9, 1, '2019-03-27', NULL, '2019-04-08 01:53:17', '2019-04-08 01:53:17'),
(57, 50, 'E - 044 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"250\"]', 9, 1, '2019-03-27', NULL, '2019-04-08 01:54:10', '2019-04-08 01:54:10'),
(58, 49, 'E - 043 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"248\"]', 9, 1, '2019-03-28', NULL, '2019-04-08 01:55:14', '2019-04-08 01:55:14'),
(59, 27, 'E - 024 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"113,114,115\"]', 3, 1, '2019-03-25', NULL, '2019-04-08 02:01:59', '2019-04-22 06:57:35'),
(60, 37, 'E - 032 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"179,178,177,175,173,184,185,186\"]', 9, 1, '2019-03-26', NULL, '2019-04-08 02:07:54', '2019-04-08 02:07:54'),
(61, 52, 'E - 045 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"255,254\"]', 6, 1, '2019-03-27', NULL, '2019-04-08 02:29:55', '2019-04-08 02:29:55'),
(62, 54, 'E - 047 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"274,275,273\"]', 9, 1, '2019-04-05', NULL, '2019-04-08 02:53:33', '2019-04-08 02:53:33'),
(63, 55, 'E - 048 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"277\"]', 9, 1, '2019-04-15', NULL, '2019-04-16 00:06:51', '2019-04-22 00:38:23'),
(64, 56, 'E - 049 Dt', 10, 'Laboratorium Kalibrasi LFPK Banjarbaru', '[\"279,278\"]', 9, 1, '2019-04-18', NULL, '2019-04-18 05:47:50', '2019-04-18 05:47:50'),
(65, 56, 'E - 049 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"280\"]', 5, 1, '2019-04-22', NULL, '2019-04-22 00:36:03', '2019-04-22 00:36:03'),
(66, 56, 'E - 049 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"281\"]', 6, 1, '2019-04-22', NULL, '2019-04-22 00:36:45', '2019-04-22 00:36:45'),
(67, 55, 'E - 048 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"276\"]', 6, 1, '2019-04-22', NULL, '2019-04-22 00:40:55', '2019-04-22 00:40:55'),
(68, 57, 'E - 050 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru`', '[\"288,287,286,285,283,282\"]', 9, 1, '2019-04-22', NULL, '2019-04-22 00:41:45', '2019-04-22 00:41:45'),
(69, 16, 'E - 014 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"140,139,138,137,136,134\"]', 3, 1, '2019-04-04', NULL, '2019-04-22 06:35:09', '2019-04-22 06:35:09'),
(70, 26, 'E - 023 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"91\"]', 3, 1, '2019-03-25', NULL, '2019-04-22 06:55:55', '2019-04-22 06:56:15'),
(71, 31, 'E - 028 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"150\"]', 3, 1, '2019-03-26', NULL, '2019-04-22 07:12:19', '2019-04-22 07:12:19'),
(72, 33, 'E - 029 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"152,153,154\"]', 3, 1, '2019-03-26', NULL, '2019-04-22 07:22:59', '2019-04-22 07:23:33'),
(73, 37, 'E - 032 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"183,182,181\"]', 3, 1, '2019-04-08', NULL, '2019-04-22 07:32:12', '2019-04-22 07:32:12'),
(74, 34, 'E - 030 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"169,168\"]', 3, 1, '2019-04-24', NULL, '2019-04-24 23:58:31', '2019-04-24 23:58:31'),
(75, 36, 'E - 031 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"174,172\"]', 3, 1, '2019-04-02', NULL, '2019-04-24 23:59:15', '2019-04-24 23:59:15'),
(76, 58, 'E - 051 Dt', 11, 'Laboratorium Pengujian dan Kalibrasi', '[\"289,300,301,303,304,305,306,307,319,321\"]', 6, 1, '2019-04-26', NULL, '2019-04-26 01:20:48', '2019-05-20 01:21:56'),
(77, 59, 'E - 052 Dt', 11, 'Laboratorium Pengujian dan Kalibrasi', '[\"308,309\"]', 6, 1, '2019-04-26', NULL, '2019-04-26 01:29:00', '2019-04-26 01:29:00'),
(78, 60, 'E - 053 Dt', 11, 'Laboratorium Pengujian dan Kalibrasi', '[\"315,317,316\"]', 6, 1, '2019-04-26', NULL, '2019-04-26 01:39:47', '2019-04-26 01:39:47'),
(79, 58, 'E - 051 Dt', 12, 'Laboratorium Kalibrasi dan Pengujian', '[\"290,296,295,294\"]', 1, 1, '2019-04-29', NULL, '2019-04-29 00:46:06', '2019-04-29 00:46:06'),
(80, 74, 'E - 066 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"375\"]', 6, 1, '2019-05-03', NULL, '2019-05-06 00:24:55', '2019-05-06 00:24:55'),
(81, 73, 'E - 065 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"372\"]', 1, 1, '2019-05-03', NULL, '2019-05-06 00:35:52', '2019-05-06 00:35:52'),
(82, 73, 'E - 065 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"373,368\"]', 6, 1, '2019-05-03', NULL, '2019-05-06 00:38:27', '2019-05-15 00:54:34'),
(83, 64, 'E - 057 Dt', 6, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"334,333,332\"]', 2, 1, '2019-05-07', NULL, '2019-05-07 05:47:08', '2019-05-07 05:47:08'),
(84, 67, 'E- 060 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"337\"]', 1, 1, '2019-05-07', NULL, '2019-05-09 02:26:07', '2019-05-09 02:26:07'),
(85, 70, 'E - 063 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"352,353\"]', 5, 1, '2019-05-08', NULL, '2019-05-09 02:27:42', '2019-05-09 02:27:42'),
(86, 70, 'E - 063 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"354,355\"]', 3, 1, '2019-05-08', NULL, '2019-05-09 02:28:43', '2019-05-09 02:28:43'),
(87, 71, 'E - 064 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"356,363,357\"]', 3, 1, '2019-05-08', NULL, '2019-05-09 02:33:58', '2019-05-09 02:33:58'),
(88, 71, 'E - 064 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"358\"]', 5, 1, '2019-05-08', NULL, '2019-05-09 02:34:50', '2019-05-09 02:34:50'),
(89, 69, 'E - 062 Dt', 6, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"348,347,346\"]', 2, 1, '2019-05-09', NULL, '2019-05-10 00:15:34', '2019-05-10 00:15:34'),
(90, 74, 'E - 066 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"376,374\"]', 1, 1, '2019-05-10', NULL, '2019-05-10 02:01:49', '2019-05-10 02:01:49'),
(91, 61, 'E - 054 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"325\"]', 1, 1, '2019-05-03', NULL, '2019-05-10 02:38:28', '2019-05-10 02:38:28'),
(92, 62, 'E - 055 Dt', 12, 'Laboratorium kalibrasi LPFK Banjarbaru', '[\"327,326\"]', 1, 1, '2019-04-30', NULL, '2019-05-10 02:41:39', '2019-05-10 02:41:39'),
(93, 63, 'E - 056 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"331,330,329,328\"]', 1, 1, '2019-04-30', NULL, '2019-05-10 02:43:51', '2019-05-10 02:43:51'),
(94, 65, 'E - 058 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"335\"]', 1, 1, '2019-05-03', NULL, '2019-05-10 02:48:38', '2019-05-10 02:48:38'),
(95, 66, 'E - 059 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"336\"]', 1, 1, '2019-05-03', NULL, '2019-05-10 02:50:17', '2019-05-10 02:50:17'),
(96, 73, 'E - 065 Dt', 10, 'Laboratorium Kalibrasi', '[\"366,367,371,369\"]', 5, 1, '2019-05-10', NULL, '2019-05-12 23:37:13', '2019-05-12 23:37:13'),
(97, 76, 'E - 068 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"379,380,382,390,392,394\"]', 9, 1, '2019-05-13', NULL, '2019-05-14 02:34:57', '2019-05-14 02:35:04'),
(98, 68, 'E - 061 Dt', 9, 'Laboratorium Pengujian dan Kalibrasi', '[\"338,339,340,341,342,343,344,345\"]', 3, 1, '2019-05-08', NULL, '2019-05-14 23:38:28', '2019-05-16 00:27:15'),
(99, 59, 'E - 052 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"313,324,323\"]', 3, 1, '2019-04-26', NULL, '2019-05-16 01:11:35', '2019-05-16 01:11:35'),
(100, 60, 'E - 053 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"314,318\"]', 3, 1, '2019-04-26', NULL, '2019-05-16 01:12:14', '2019-05-16 01:12:14'),
(101, 77, 'E - 069 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"395\"]', 5, 1, '2019-05-20', NULL, '2019-05-20 02:14:02', '2019-05-20 02:14:02'),
(102, 75, 'E - 067 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"377\"]', 3, 1, '2019-05-15', NULL, '2019-05-20 03:15:09', '2019-05-20 03:15:09'),
(103, 76, 'E - 068 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"383,378\"]', 5, 1, '2019-05-21', NULL, '2019-05-21 01:20:40', '2019-05-21 01:20:40'),
(104, 78, 'E - 070 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"396,399\"]', 5, 1, '2019-05-22', NULL, '2019-05-22 06:30:51', '2019-05-22 06:30:51'),
(105, 76, 'E - 068 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"388,387,384,389,393,391,385\"]', 9, 1, '2019-05-13', NULL, '2019-05-24 00:46:20', '2019-05-24 00:46:20'),
(106, 76, 'E - 068 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"386\"]', 1, 1, '2019-05-27', NULL, '2019-05-24 00:49:07', '2019-05-27 03:29:11'),
(107, 79, 'E - 071 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"411\"]', 3, 1, '2019-05-27', NULL, '2019-05-27 03:29:02', '2019-05-27 03:29:02'),
(108, 80, 'E - 072 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"410\"]', 3, 1, '2019-05-27', NULL, '2019-05-27 03:29:52', '2019-05-27 03:29:52'),
(109, 78, 'E - 070 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"400,404\"]', 6, 1, '2019-05-27', NULL, '2019-05-27 04:01:48', '2019-05-27 04:01:48'),
(110, 78, 'E - 070 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"398\"]', 1, 1, '2019-05-24', NULL, '2019-05-27 04:05:11', '2019-05-28 06:44:54'),
(111, 79, 'E - 071 Dt', 5, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"408,407,405\"]', 7, 1, '2019-05-27', NULL, '2019-05-27 04:06:45', '2019-05-27 04:06:45'),
(112, 80, 'E - 072 Dt', 6, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"414,413,412\"]', 2, 1, '2019-05-27', NULL, '2019-05-27 04:07:40', '2019-05-27 04:07:40'),
(113, 71, 'E - 064 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"359,360,361,362\"]', 3, 1, '2019-05-09', NULL, '2019-05-27 04:52:06', '2019-05-27 05:03:50'),
(114, 69, 'E - 062 Dt', 10, 'Laboratorium kalibrasi LPFK Banjarbaru', '[\"351\"]', 5, 1, '2019-05-07', NULL, '2019-05-27 05:00:07', '2019-05-27 05:00:07'),
(115, 69, 'E - 062 Dt', 11, 'Laboratorium kalibrasi LPFK Banjarbaru', '[\"349\"]', 6, 1, '2019-05-03', NULL, '2019-05-27 05:00:57', '2019-05-27 05:00:57'),
(116, 83, 'E - 074 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"422\"]', 6, 1, '2019-05-28', NULL, '2019-05-28 06:49:41', '2019-05-28 06:49:41'),
(117, 80, 'E - 072 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"409\"]', 5, 1, '2019-05-27', NULL, '2019-05-29 02:32:31', '2019-05-29 02:32:31'),
(118, 79, 'E - 071 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"406\"]', 5, 1, '2019-05-27', NULL, '2019-05-29 05:39:43', '2019-05-29 05:39:43'),
(119, 84, 'E - 075 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"423,424\"]', 3, 1, '2019-06-12', NULL, '2019-06-17 03:04:51', '2019-07-18 06:39:09'),
(120, 85, 'E - 076 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"426\"]', 5, 1, '2019-06-17', NULL, '2019-06-19 02:02:42', '2019-06-19 02:02:42'),
(121, 88, 'E - 079 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"444,445,446,448,450,451,452,454,447,479\"]', 9, 1, '2019-06-19', NULL, '2019-06-21 01:41:51', '2019-07-18 06:32:46'),
(122, 88, 'E - 079 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"443,442,441\"]', 3, 1, '2019-06-18', NULL, '2019-06-21 01:42:50', '2019-06-21 01:42:50'),
(123, 97, 'E - 087 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"481,494,495,488,492,487\"]', 9, 1, '2019-06-25', NULL, '2019-06-25 06:16:03', '2019-06-28 02:53:46'),
(124, 96, 'E - 086 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"480\"]', 6, 1, '2019-06-25', NULL, '2019-06-25 06:54:09', '2019-06-26 00:20:36'),
(125, 93, 'E - 081 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"463,462,467\"]', 9, 1, '2019-06-20', NULL, '2019-06-26 03:01:48', '2019-06-26 03:01:48'),
(126, 91, 'E - 082 Dt', 12, 'Laboratorium Pengujian dan Kalibrasi', '[\"456\"]', 3, 1, '2019-06-26', NULL, '2019-06-26 03:54:28', '2019-06-26 03:54:28'),
(127, 86, 'E - 077 Dt', 5, 'Laboratorium Kalibrasi', '[\"427\"]', 7, 1, '2019-06-28', NULL, '2019-06-28 00:33:15', '2019-06-28 00:33:15'),
(128, 97, 'E - 087 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"483,485,490\"]', 5, 1, '2019-06-27', NULL, '2019-06-28 02:53:13', '2019-06-28 02:53:27'),
(129, 87, 'E - 078 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"429,430,431,432,433,434,435,436,437,438\"]', 3, 1, '2019-06-17', NULL, '2019-07-02 05:40:36', '2019-07-18 03:28:46'),
(130, 87, 'E - 078 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"439,440\"]', 5, 1, '2019-06-17', NULL, '2019-07-02 05:42:02', '2019-07-02 05:42:02'),
(131, 98, 'E - 088 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"496,498\"]', 5, 1, '2019-06-27', NULL, '2019-07-02 05:43:39', '2019-07-02 05:43:39'),
(132, 98, 'E - 088 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"497\"]', 9, 1, '2019-06-26', NULL, '2019-07-02 05:46:12', '2019-07-02 05:46:12'),
(133, 95, 'E - 085 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"499\"]', 9, 1, '2019-06-25', NULL, '2019-07-02 06:48:41', '2019-07-02 06:48:41'),
(134, 95, 'E - 085 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"477,473,472,478,475,474\"]', 5, 1, '2019-06-26', NULL, '2019-07-02 06:49:38', '2019-07-02 06:49:38'),
(135, 89, 'E - 080 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"455\"]', 3, 1, '2019-06-24', NULL, '2019-07-03 01:18:38', '2019-07-03 01:18:38'),
(136, 82, 'E - 073 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"421,420,419,418,417,416,415\"]', 3, 1, '2019-05-29', NULL, '2019-07-03 05:28:17', '2019-07-03 05:28:17'),
(137, 92, 'E - 083 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"457,461,460,459,458\"]', 9, 1, '2019-06-24', NULL, '2019-07-03 05:31:17', '2019-07-03 05:31:17'),
(138, 94, 'E - 084 Dt', 5, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"469\"]', 7, 1, '2019-06-28', NULL, '2019-07-03 06:07:24', '2019-07-03 06:07:24'),
(139, 94, 'E - 084 Dt', 13, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"468\"]', 5, 1, '2019-06-26', NULL, '2019-07-03 06:08:03', '2019-07-03 06:08:03'),
(140, 85, 'E - 076 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"425\"]', 3, 1, '2019-06-18', NULL, '2019-07-03 06:45:33', '2019-07-18 06:37:46'),
(141, 86, 'E - 077 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"428\"]', 5, 1, '2019-07-01', NULL, '2019-07-03 06:52:50', '2019-07-03 07:47:38'),
(142, 95, 'E - 085 Dt', 12, 'Laboratorium Kalibrasi', '[\"471,470\"]', 1, 1, '2019-07-05', NULL, '2019-07-09 07:38:55', '2019-07-09 07:38:55'),
(143, 103, 'E - 093 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"524,525,530\"]', 6, 1, '2019-07-10', NULL, '2019-07-11 02:47:39', '2019-07-15 00:59:36'),
(144, 103, 'E - 093 Dt', 6, 'laboratorium Kalibrasi LPFK Banjarbaru', '[\"534,532,535,528,527,526\"]', 9, 1, '2019-07-09', NULL, '2019-07-11 02:48:55', '2019-07-11 02:48:55'),
(145, 100, 'E - 090 Dt', 7, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"506,507,508,509,510,511,512\"]', 9, 1, '2019-07-09', NULL, '2019-07-11 03:01:28', '2019-07-17 07:27:51'),
(146, 101, 'E - 091 Dt', 7, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"505,514,513\"]', 6, 1, '2019-07-09', NULL, '2019-07-11 03:03:51', '2019-07-11 03:03:51'),
(147, 102, 'E - 092 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"522,521,519,518,517,516,523,515\"]', 9, 1, '2019-07-09', NULL, '2019-07-17 01:53:22', '2019-07-17 01:53:22'),
(148, 99, 'E - 089 Dt', 7, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"500,502,501,504,503\"]', 9, 1, '2019-07-08', NULL, '2019-07-17 07:27:38', '2019-07-17 07:27:38'),
(149, 93, 'E - 081 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"465,466\"]', 3, 1, '2019-07-01', NULL, '2019-07-18 06:22:19', '2019-07-18 06:23:06'),
(150, 88, 'E - 079 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"449\"]', 3, 1, '2019-06-26', NULL, '2019-07-18 06:31:09', '2019-07-18 06:31:09'),
(151, 88, 'E - 079 Dt', 13, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"453\"]', 5, 1, '2019-06-25', NULL, '2019-07-18 06:32:03', '2019-07-18 06:32:03'),
(152, 103, 'E - 093 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"536\"]', 9, 1, '2019-07-19', NULL, '2019-07-19 00:39:29', '2019-07-19 00:39:29'),
(153, 103, 'E - 093 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"531\"]', 6, 1, '2019-07-15', NULL, '2019-07-19 00:40:18', '2019-07-19 00:40:18'),
(154, 104, 'E - 094 Dt', 6, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"537,538,539,540,541,542,543,544,545,546,547,548,549,550,551,552,553,554,555,556,557,558,559,560,561,562,563,564,565\"]', 9, 1, '2019-07-23', NULL, '2019-07-24 00:23:01', '2019-07-29 05:33:38'),
(155, 105, 'E - 095 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"569,568\"]', 3, 1, '2019-07-24', NULL, '2019-07-29 01:19:48', '2019-07-29 01:19:48'),
(156, 107, 'E - 097 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"573\"]', 6, 1, '2019-07-26', NULL, '2019-07-30 02:16:57', '2019-07-30 02:16:57'),
(157, 108, 'E - 098 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"574,575\"]', 9, 1, '2019-07-30', NULL, '2019-07-30 02:26:02', '2019-07-30 02:26:02'),
(158, 104, 'E - 094 Dt', 10, 'Laboratorium Kalibrasi', '[\"567,566\"]', 5, 1, '2019-07-30', NULL, '2019-07-31 01:47:54', '2019-07-31 01:47:54'),
(159, 109, 'E - 099 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"576\"]', 6, 1, '2019-07-31', NULL, '2019-08-01 00:19:37', '2019-08-01 00:19:37'),
(160, 106, 'E - 096 Dt', 12, 'Laboratorium Kalibrasi', '[\"570,572,571\"]', 1, 1, '2019-08-01', NULL, '2019-08-01 07:19:29', '2019-08-01 07:19:29'),
(161, 110, 'E - 100 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"579,577,581,582,578,580\"]', 9, 1, '2019-07-31', NULL, '2019-08-02 00:29:08', '2019-08-02 00:29:08'),
(162, 112, 'E - 102 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"590,591\"]', 6, 1, '2019-08-05', NULL, '2019-08-07 03:29:24', '2019-08-07 03:29:24'),
(163, 113, 'E - 103 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"596,595\"]', 5, 1, '2019-08-07', NULL, '2019-08-08 02:40:09', '2019-08-08 02:40:09'),
(164, 111, 'E - 101 Dt', 7, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"583,587,589,588,586,585,584\"]', 9, 1, '2019-08-07', NULL, '2019-08-08 02:41:09', '2019-08-08 02:41:09'),
(165, 117, 'E - 107 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"599\"]', 3, 1, '2019-08-07', NULL, '2019-08-08 02:41:48', '2019-08-08 02:41:48'),
(166, 116, 'E - 106 Dt', 6, 'Laboratorium Kalibrasi', '[\"597,598\"]', 2, 1, '2019-08-14', NULL, '2019-08-14 00:29:37', '2019-08-14 00:29:37'),
(167, 119, 'E - 109 Dt', 6, 'Laboratorium Kalibrasi', '[\"609\"]', 2, 1, '2019-08-14', NULL, '2019-08-14 00:34:31', '2019-08-14 00:34:31'),
(168, 114, 'E - 104 Dt', 7, 'Laboratorium Kalibrasi', '[\"594\"]', 6, 1, '2019-08-14', NULL, '2019-08-14 00:38:10', '2019-08-14 00:38:10'),
(169, 115, 'E - 105 Dt', 7, 'Laboratorium Kalibrasi', '[\"593,592\"]', 6, 1, '2019-08-14', NULL, '2019-08-14 00:38:57', '2019-08-14 00:38:57'),
(170, 118, 'E - 108 Dt', 5, 'Laboratorium Kalibrasi', '[\"600,601,602,603,607,608\"]', 8, 1, '2019-08-14', NULL, '2019-08-15 01:22:45', '2019-08-28 06:47:57'),
(171, 124, 'E - 114 Dt', 7, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"616\"]', 6, 1, '2019-08-27', NULL, '2019-08-27 02:50:10', '2019-08-27 02:50:10'),
(172, 123, 'E - 113 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"614\"]', 5, 1, '2019-08-26', NULL, '2019-08-28 00:18:34', '2019-08-28 00:18:34'),
(173, 121, 'E - 111 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"611\"]', 3, 1, '2019-08-26', NULL, '2019-08-28 00:29:20', '2019-08-28 00:29:20'),
(174, 122, 'E - 112 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"612,615\"]', 9, 1, '2019-08-26', NULL, '2019-08-28 00:29:59', '2019-08-28 00:29:59'),
(175, 120, 'E - 110 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"610\"]', 1, 1, '2019-08-22', NULL, '2019-08-28 06:28:48', '2019-08-28 06:28:48'),
(176, 118, 'E - 108 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"606,605,604\"]', 8, 1, '2019-08-19', NULL, '2019-08-28 06:49:04', '2019-08-28 06:49:04'),
(177, 125, 'E - 115 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"617\"]', 3, 1, '2019-09-02', NULL, '2019-09-02 08:03:11', '2019-09-02 08:03:11'),
(178, 126, 'E - 116 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"618\"]', 2, 1, '2019-09-02', NULL, '2019-09-02 08:03:50', '2019-09-02 08:03:50'),
(179, 131, 'E - 120 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"630,629,628,627,626,625\"]', 3, 1, '2019-09-05', NULL, '2019-09-06 03:02:37', '2019-09-06 03:02:37'),
(180, 130, 'E - 119 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"624\"]', 6, 1, '2019-09-05', NULL, '2019-09-06 05:55:26', '2019-09-06 05:55:26'),
(181, 132, 'E - 121 Dt', 13, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"631,632,633,634,635,636,637,639,640,641,642,638\"]', 9, 1, '2019-09-06', NULL, '2019-09-10 00:39:27', '2019-09-18 02:51:02'),
(182, 129, 'E - 118 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"623\"]', 1, 1, '2019-09-03', NULL, '2019-09-10 01:28:56', '2019-09-10 01:28:56'),
(183, 133, 'E - 122 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"643\"]', 2, 1, '2019-09-06', NULL, '2019-09-10 07:41:14', '2019-09-10 07:41:14'),
(184, 128, 'E - 117 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"620\"]', 9, 1, '2019-09-05', NULL, '2019-09-17 00:27:10', '2019-09-18 23:59:35'),
(186, 128, 'E - 117 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"619,622,621\"]', 9, 1, '2019-09-06', NULL, '2019-09-17 02:22:03', '2019-09-18 23:59:45'),
(187, 134, 'E - 123 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"648,645,644\"]', 6, 1, '2019-09-18', NULL, '2019-09-18 05:21:27', '2019-09-23 04:20:35'),
(189, 134, 'E - 123 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"646,647\"]', 9, 1, '2019-09-19', NULL, '2019-09-23 04:20:22', '2019-09-23 04:20:22'),
(191, 141, 'E - 129 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"688\"]', 9, 1, '2019-09-26', NULL, '2019-09-26 08:31:49', '2019-10-10 03:56:53'),
(192, 137, 'E - 125 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"661,657,655,673,654,662,672,660,659,658,656,664,663,671,670,669,668,667,666,665\"]', 9, 1, '2019-09-25', NULL, '2019-10-01 00:34:56', '2019-10-01 00:34:56'),
(193, 140, 'E - 128 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"674,676,678,681,683\"]', 9, 1, '2019-09-26', NULL, '2019-10-01 00:36:22', '2019-10-10 03:54:12'),
(194, 140, 'E - 128 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"684\"]', 3, 1, '2019-09-26', NULL, '2019-10-01 00:37:11', '2019-10-01 00:37:11'),
(195, 143, 'E - 131 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"712,713\"]', 9, 1, '2019-10-01', NULL, '2019-10-02 02:08:38', '2019-10-02 02:08:38'),
(196, 139, 'E - 127 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"679,682,685,686,687\"]', 9, 1, '2019-10-01', NULL, '2019-10-03 02:52:25', '2019-11-14 00:22:44'),
(198, 138, 'E - 126 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"677,675\"]', 9, 1, '2019-10-04', NULL, '2019-10-10 03:52:43', '2019-10-10 03:52:43'),
(199, 140, 'E - 128 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"680\"]', 7, 1, '2019-10-07', NULL, '2019-10-10 03:54:37', '2019-10-10 03:54:37'),
(200, 141, 'E - 129 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"695,698,693,692,689,690,694,691,697,696\"]', 9, 1, '2019-09-26', NULL, '2019-10-10 03:57:19', '2019-10-10 03:57:19'),
(201, 142, 'E - 130 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"706,705,704,710,709,711,699,701,700,708,707,703,702\"]', 9, 1, '2019-10-01', NULL, '2019-10-10 03:59:10', '2019-10-10 03:59:10'),
(202, 153, 'E - 140 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"750,749\"]', 9, 1, '2019-10-08', NULL, '2019-10-10 05:28:15', '2019-10-10 05:28:15'),
(203, 154, 'E - 141 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"748\"]', 6, 1, '2019-10-08', NULL, '2019-10-10 05:28:51', '2019-10-10 05:28:51'),
(204, 155, 'E - 142 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"747\"]', 6, 1, '2019-10-08', NULL, '2019-10-10 05:29:10', '2019-10-10 05:29:10'),
(205, 162, 'E - 148 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"811\"]', 5, 1, '2019-10-11', NULL, '2019-10-11 07:15:59', '2019-10-11 07:15:59'),
(206, 161, 'E - 147 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"792,793,794,800,810,795,797,791,799,805,801,802,803,798,806,809,808\"]', 5, 1, '2019-10-11', NULL, '2019-10-11 08:01:04', '2019-11-11 01:16:51'),
(207, 136, 'E - 124 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"650,651,649,653,652\"]', 6, 1, '2019-09-23', NULL, '2019-10-11 08:33:56', '2019-10-11 08:33:56'),
(208, 158, 'E - 145 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"788\"]', 5, 1, '2019-10-10', NULL, '2019-10-16 08:11:37', '2019-10-16 08:12:09'),
(209, 163, 'E - 149 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"812\"]', 5, 1, '2019-10-16', NULL, '2019-10-17 05:55:10', '2019-10-17 05:55:10'),
(210, 145, 'E - 132 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"718,720,719,717,716,715\"]', 5, 1, '2019-10-14', NULL, '2019-10-18 08:44:05', '2019-10-18 08:44:05'),
(211, 146, 'E - 133 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"722,721\"]', 5, 1, '2019-10-02', NULL, '2019-10-18 08:48:32', '2019-10-18 08:48:32'),
(212, 147, 'E - 134 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"727,726,725,724,723,728\"]', 5, 1, '2019-10-04', NULL, '2019-10-18 08:51:42', '2019-10-18 08:51:42'),
(213, 148, 'E - 135 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"729\"]', 5, 1, '2019-10-02', NULL, '2019-10-18 08:57:22', '2019-10-18 08:57:22'),
(214, 149, 'E - 136 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"733,732,731,730\"]', 5, 1, '2019-10-21', NULL, '2019-10-18 09:00:45', '2019-10-18 09:00:45'),
(215, 150, 'E - 137 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"734,737,736,735,746,739,738\"]', 1, 1, '2019-10-02', NULL, '2019-10-18 09:04:15', '2019-10-18 09:04:15'),
(216, 151, 'E - 138 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"742,741,740\"]', 1, 1, '2019-10-21', NULL, '2019-10-18 09:16:43', '2019-10-18 09:16:43'),
(217, 152, 'E - 139 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"745,744,743\"]', 5, 1, '2019-10-14', NULL, '2019-10-18 09:18:48', '2019-10-18 09:18:48'),
(218, 159, 'E - 146 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"789,790\"]', 3, 1, '2019-10-17', NULL, '2019-10-18 09:26:41', '2019-10-21 23:42:24'),
(219, 167, 'E - 153 Dt', 7, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"825\"]', 9, 1, '2019-10-22', NULL, '2019-10-23 02:49:22', '2019-10-23 02:49:22'),
(220, 172, 'E - 158 Dt', 13, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"839,840,841,842,843,844,845,846,847,848\"]', 9, 1, '2019-10-23', NULL, '2019-10-23 23:46:16', '2019-10-24 04:59:22'),
(221, 176, 'E - 161 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"852,854,853\"]', 3, 1, '2019-10-24', NULL, '2019-10-24 05:01:01', '2019-10-24 05:01:01'),
(222, 171, 'E -157 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"865\"]', 5, 1, '2019-10-24', NULL, '2019-10-24 23:52:42', '2019-10-24 23:56:56'),
(224, 156, 'E - 143 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"751,752,753,754,755,756,757,759,760,761,762,763,764,765,768,769,772,773\"]', 9, 1, '2019-10-04', NULL, '2019-10-25 01:44:24', '2019-11-14 03:06:41'),
(225, 165, 'E - 151 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"821,822\"]', 9, 1, '2019-10-25', NULL, '2019-10-28 02:08:13', '2019-10-29 01:24:47'),
(226, 157, 'E - 144 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"777,782,786,784,783,779,778,781,780,785,776,775,787\"]', 9, 1, '2019-10-21', NULL, '2019-10-28 03:34:19', '2019-10-28 03:34:19'),
(227, 168, 'E-154 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"826\"]', 2, 1, '2019-10-28', NULL, '2019-10-28 03:44:29', '2019-10-29 01:22:25'),
(228, 169, 'E - 155 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"827\"]', 2, 1, '2019-10-28', NULL, '2019-10-28 03:45:00', '2019-10-29 01:22:15'),
(229, 182, 'E - 165 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"869\"]', 5, 1, '2019-10-28', NULL, '2019-10-29 06:00:13', '2019-10-29 06:00:13'),
(230, 166, 'E - 152 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"823,824\"]', 9, 1, '2019-10-31', NULL, '2019-11-04 01:09:51', '2019-11-04 01:09:51'),
(231, 170, 'E - 156 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"828,829,830,831,832,833,834\"]', 9, 1, '2019-10-28', NULL, '2019-11-04 01:14:36', '2019-11-14 03:56:38'),
(232, 175, 'E - 160 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"851\"]', 8, 1, '2019-11-04', NULL, '2019-11-05 02:29:27', '2019-11-05 02:29:27'),
(233, 179, 'E - 164 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"866\"]', 1, 1, '2019-11-06', NULL, '2019-11-08 01:49:20', '2019-11-08 01:49:20'),
(234, 185, 'E - 170 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"891\"]', 5, 1, '2019-11-06', NULL, '2019-11-11 00:09:26', '2019-11-11 00:09:26'),
(235, 161, 'E - 147 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"796\"]', 3, 1, '2019-10-28', NULL, '2019-11-11 01:15:11', '2019-11-11 01:15:11'),
(236, 161, 'E - 147 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"807,804\"]', 1, 1, '2019-10-17', NULL, '2019-11-11 01:17:23', '2019-11-11 01:17:23'),
(237, 189, 'E - 172 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"915,916,917\"]', 9, 1, '2019-11-07', NULL, '2019-11-11 03:18:10', '2019-11-14 04:12:50'),
(239, 164, 'E - 150 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"813,814,815,816,817,818,819,820\"]', 9, 1, '2019-11-04', NULL, '2019-11-12 05:23:17', '2019-11-14 03:29:19'),
(240, 191, 'E - 174 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"919\"]', 2, 1, '2019-11-07', NULL, '2019-11-13 01:40:18', '2019-11-13 01:40:32'),
(241, 186, 'E - 168 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"900,899,898,897,892,901,896,895,894,893\"]', 3, 1, '2019-11-04', NULL, '2019-11-14 01:23:04', '2019-11-14 01:23:04'),
(242, 188, 'E - 169 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"902,903,904,905,906,907,908\"]', 3, 1, '2019-11-04', NULL, '2019-11-14 01:25:02', '2019-11-14 01:26:54'),
(243, 156, 'E - 143 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"774,766\"]', 9, 1, '2019-10-03', NULL, '2019-11-14 03:07:15', '2019-11-14 03:07:15'),
(244, 170, 'E - 156 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"835,837,836,838\"]', 9, 1, '2019-10-31', NULL, '2019-11-14 03:57:07', '2019-11-14 03:57:07'),
(245, 187, 'E - 171 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"909,910,911,912,913,914\"]', 9, 1, '2019-11-08', NULL, '2019-11-15 07:24:26', '2019-11-15 07:24:35'),
(246, 183, 'E - 166 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"872,874,870,871,873\"]', 9, 1, '2019-11-11', NULL, '2019-11-18 01:13:25', '2019-11-18 01:13:25'),
(247, 174, 'E - 159 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"850,849\"]', 3, 1, '2019-11-04', NULL, '2019-11-22 04:42:18', '2019-11-22 04:42:18'),
(248, 190, 'E - 173 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"918\"]', 6, 1, '2019-11-07', NULL, '2019-11-27 01:52:22', '2019-11-27 01:53:26'),
(249, 202, 'E - 185 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"956,957,958,968,969\"]', 9, 1, '2019-11-29', NULL, '2019-11-29 06:13:46', '2019-12-19 02:04:48'),
(250, 194, 'E - 177 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"935\"]', 5, 1, '2019-11-26', NULL, '2019-12-02 03:15:29', '2019-12-02 03:15:29'),
(251, 195, 'E - 178 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"937\"]', 7, 1, '2019-11-27', NULL, '2019-12-02 03:35:31', '2019-12-02 03:35:31'),
(252, 201, 'E - 184 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"955\"]', 6, 1, '2019-11-27', NULL, '2019-12-02 03:41:23', '2019-12-02 03:41:23'),
(253, 177, 'E - 162 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"860,859,858,857,856,861,855\"]', 3, 1, '2019-12-25', NULL, '2019-12-05 05:51:15', '2019-12-05 05:51:15'),
(254, 178, 'E - 163 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"863,862,864\"]', 3, 1, '2019-12-11', NULL, '2019-12-05 05:52:54', '2019-12-05 05:52:54'),
(255, 192, 'E - 175 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"921,920\"]', 9, 1, '2019-11-12', NULL, '2019-12-06 07:15:41', '2019-12-06 07:15:41'),
(256, 198, 'E - 181 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"944,945,946,948,949\"]', 6, 1, '2019-11-28', NULL, '2019-12-12 00:38:15', '2020-01-03 02:36:34'),
(257, 198, 'E - 181 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"947\"]', 1, 1, '2019-12-09', NULL, '2019-12-12 00:39:53', '2019-12-12 00:39:53'),
(258, 200, 'E - 183 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"953,954\"]', 3, 1, '2019-12-10', NULL, '2019-12-12 03:16:40', '2019-12-12 03:16:40'),
(259, 209, 'E - 192 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1002,1003\"]', 9, 1, '2019-12-06', NULL, '2019-12-13 00:50:11', '2019-12-13 00:50:53'),
(260, 199, 'E - 182 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"952,951,950\"]', 1, 1, '2019-12-02', NULL, '2019-12-16 01:34:52', '2019-12-16 01:34:52'),
(261, 184, 'E - 167 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"881,885,887,886,875,883,882,880,879,890,878,877,876,889,888\"]', 9, 1, '2019-11-08', NULL, '2019-12-19 01:32:08', '2019-12-19 01:32:08'),
(263, 202, 'E - 185 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"961,960,964,963,962,967,966,965,959\"]', 9, 1, '2019-11-29', NULL, '2019-12-19 02:05:11', '2019-12-19 02:05:11'),
(264, 208, 'E - 191 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"992,993,994,995,996,997,998,999,1000,1001\"]', 1, 1, '2019-12-13', NULL, '2019-12-20 02:46:50', '2019-12-20 02:47:36'),
(265, 214, 'E - 197 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1024,1023,1022,1020,1025,1021,1019,1018\"]', 3, 1, '2019-12-20', NULL, '2019-12-20 06:30:12', '2019-12-20 06:30:12'),
(266, 193, 'E - 176 Dt', 11, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"933,929,922,930,932,931,934,923,925,928,927,924\"]', 9, 1, '2019-11-12', NULL, '2019-12-23 04:29:26', '2019-12-23 04:29:26'),
(267, 197, 'E - 180 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"939,941,942,940,943\"]', 3, 1, '2019-11-28', NULL, '2019-12-23 04:30:06', '2019-12-23 04:30:06'),
(268, 210, 'E - 193 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1012,1004,1009,1010,1008,1006,1011,1005\"]', 1, 1, '2019-12-10', NULL, '2019-12-26 01:39:55', '2019-12-26 01:39:55'),
(269, 213, 'E - 196 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1017\"]', 3, 1, '2019-12-19', NULL, '2019-12-27 02:09:43', '2019-12-27 02:11:14'),
(270, 215, 'E - 198 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1034,1033,1038,1037,1036,1035,1031,1041,1040,1039,1032,1030,1029,1028,1027,1026\"]', 1, 1, '2019-12-26', NULL, '2019-12-27 06:05:19', '2019-12-27 06:05:19'),
(271, 215, 'E - 198 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1043,1042\"]', 3, 1, '2019-12-27', NULL, '2019-12-27 06:05:48', '2019-12-27 06:05:48'),
(275, 216, 'E - 001 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1044\"]', 1, 1, '2020-01-02', 'LHK (1), LMK (1)', '2020-01-06 02:26:32', '2020-10-27 07:33:04'),
(276, 206, 'E - 189 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"985,988,987,989,986\"]', 3, 1, '2019-12-25', NULL, '2020-01-06 06:43:42', '2020-01-06 06:43:42'),
(277, 205, 'E - 188 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"983,984\"]', 3, 1, '2019-12-24', NULL, '2020-01-06 06:51:46', '2020-01-06 06:51:46'),
(278, 204, 'E - 187 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"977,981,980,979,978,982\"]', 3, 1, '2019-12-23', NULL, '2020-01-06 06:58:18', '2020-01-06 06:58:18'),
(279, 207, 'E - 190 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"990,991\"]', 3, 1, '2019-12-23', NULL, '2020-01-06 07:34:34', '2020-01-06 07:34:34'),
(280, 211, 'E - 194 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1013,1015,1014\"]', 3, 1, '2019-12-26', NULL, '2020-01-06 07:46:18', '2020-01-06 07:46:18'),
(281, 212, 'E - 195 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1016\"]', 3, 1, '2019-12-30', NULL, '2020-01-06 08:04:31', '2020-01-06 08:04:31'),
(282, 219, 'E - 002 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1046\"]', 6, 1, '2020-01-06', 'LHB (1) LMB (1)', '2020-01-06 23:55:41', '2020-10-27 07:32:46'),
(283, 203, 'E - 186 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"970,976,971,972,975,974,973\"]', 9, 1, '2019-12-12', NULL, '2020-01-20 00:34:36', '2020-01-20 00:34:36'),
(284, 220, 'E - 003 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1047,1048,1049,1050,1051,1052,1053,1054,1055\"]', 9, 1, '2020-01-20', 'LHB (2) LHK (7) LMB (2) LMK (7)', '2020-01-20 05:13:21', '2020-10-27 07:32:24'),
(285, 221, 'E - 004 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1057\"]', 9, 1, '2020-01-21', 'LHK (1) LMK (1)', '2020-01-21 05:40:32', '2020-10-27 07:31:10'),
(286, 222, 'E - 005 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1061,1064\"]', 9, 1, '2020-01-22', NULL, '2020-01-22 03:56:55', '2020-03-17 01:01:38'),
(287, 222, 'E - 005 Dt', 6, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1065,1067\"]', 9, 1, '2020-01-22', 'BHK (2) BMK (2)', '2020-01-22 03:57:32', '2020-10-27 07:36:50'),
(288, 223, 'E - 006 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1074\"]', 3, 1, '2020-01-30', 'LHK (1) LMK (1)', '2020-02-03 01:28:25', '2020-10-27 07:44:14'),
(289, 223, 'E - 006 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1072\"]', 3, 1, '2020-01-30', 'LHK (1) LMK (1)', '2020-02-03 01:28:54', '2020-10-27 07:44:08'),
(290, 223, 'E - 006 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1073\"]', 3, 1, '2020-01-30', 'LHK (1) LMK (1)', '2020-02-03 01:29:41', '2020-10-27 07:43:34'),
(291, 226, 'E - 008 Dt', 7, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1078\"]', 9, 1, '2020-02-13', 'LHB (1) LMB (1)', '2020-02-25 05:32:16', '2020-10-27 07:58:55'),
(292, 229, 'E - 011 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1086,1087,1088,1089,1090,1091\"]', 9, 1, '2020-02-14', 'LHB (6) LMB (6)', '2020-02-26 02:44:02', '2020-10-27 08:09:00'),
(293, 227, 'E - 009 Dt', 7, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1082\"]', 2, 1, '2020-02-12', 'LHK (1) LMK (1)', '2020-02-27 00:47:29', '2020-10-27 08:06:41'),
(294, 227, 'E - 009 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1083\"]', 5, 1, '2020-02-12', 'LHK (1) LMK (1)', '2020-02-27 00:48:13', '2020-10-27 08:06:46'),
(295, 234, 'E - 016 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1112\"]', 2, 1, '2020-03-02', NULL, '2020-03-03 03:33:14', '2020-03-03 03:33:14'),
(296, 234, 'E - 016 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1113,1114,1111\"]', 3, 1, '2020-03-03', NULL, '2020-03-03 03:33:39', '2020-03-03 03:34:01'),
(297, 235, 'E - 017 Dt', 6, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1119,1120,1121,1116,1117\"]', 9, 1, '2020-03-04', NULL, '2020-03-05 00:36:18', '2020-03-17 03:29:59'),
(298, 232, 'E - 014 Dt', 6, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1106,1107\"]', 9, 1, '2020-03-05', NULL, '2020-03-05 00:38:35', '2020-03-05 00:38:35'),
(299, 232, 'E - 014 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1108\"]', 9, 1, '2020-03-05', NULL, '2020-03-05 00:38:58', '2020-03-05 00:38:58'),
(300, 235, 'E - 017 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1118\"]', 9, 1, '2020-03-04', NULL, '2020-03-05 00:39:34', '2020-03-17 03:29:24'),
(301, 236, 'E - 018 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1123,1128\"]', 6, 1, '2020-03-05', NULL, '2020-03-06 03:57:03', '2020-03-17 03:34:45'),
(302, 236, 'E - 018 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1126,1124\"]', 3, 1, '2020-03-06', NULL, '2020-03-06 04:01:46', '2020-03-06 04:01:46'),
(303, 236, 'E - 018 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1122,1125\"]', 2, 1, '2020-03-05', NULL, '2020-03-06 04:02:35', '2020-03-17 03:34:39'),
(305, 237, 'E - 019 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1130,1131,1132\"]', 9, 1, '2020-03-06', NULL, '2020-03-06 08:42:37', '2020-03-17 05:45:20'),
(306, 237, 'E - 019 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1129\"]', 9, 1, '2020-03-06', NULL, '2020-03-06 08:53:42', '2020-03-06 08:53:42'),
(307, 228, 'E - 010 Dt', 7, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1085\"]', 9, 1, '2020-02-13', 'LHK (1) LMK (1)', '2020-03-09 03:09:01', '2020-10-27 08:07:44'),
(308, 228, 'E - 010 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1084\"]', 9, 1, '2020-02-13', 'LHB (1) LMB (1)', '2020-03-09 03:09:42', '2020-10-27 08:07:54'),
(309, 233, 'E - 015 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1110\"]', 6, 1, '2020-03-06', NULL, '2020-03-10 03:17:49', '2020-03-10 03:17:49'),
(310, 233, 'E - 015 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1109\"]', 5, 1, '2020-03-09', NULL, '2020-03-10 03:18:12', '2020-03-17 03:21:52'),
(311, 231, 'E - 013 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1105,1104\"]', 6, 1, '2020-03-05', NULL, '2020-03-10 03:23:15', '2020-03-10 03:23:15'),
(312, 230, 'E - 012 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1094,1102\"]', 1, 1, '2020-03-05', 'LHK (1) LMK (1) LHB (1) LMB (1)', '2020-03-10 03:26:16', '2020-10-27 08:11:44'),
(313, 230, 'E - 012 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1100,1101,1103\"]', 2, 1, '2020-03-02', 'LHK (3) LMK (3)', '2020-03-11 00:42:31', '2020-10-27 08:12:49'),
(314, 230, 'E - 012 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1096,1099\"]', 2, 1, '2020-03-03', 'LHK (1) LMK (1) LHB (1) LMB (1)', '2020-03-11 00:47:24', '2020-10-27 08:13:10'),
(315, 230, 'E - 012 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1095,1097,1098\"]', 5, 1, '2020-03-03', 'LHB (2) LMB (2) LHK (1) LMK (1)', '2020-03-11 00:48:39', '2020-10-27 08:13:36'),
(316, 239, 'E - 021 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1135\"]', 2, 1, '2020-03-16', NULL, '2020-03-17 00:20:03', '2020-03-17 00:20:03'),
(317, 222, 'E - 005 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1058,1071\"]', 3, 1, '2020-01-24', 'LHB (1) LMB (1) LHK (1) LMK (1)', '2020-03-17 01:05:51', '2020-10-27 07:37:21'),
(318, 222, 'E - 005 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1060,1069\"]', 3, 1, '2020-01-22', 'LHB (1) LMB (1) LHK (1) LMK (1)', '2020-03-17 01:07:15', '2020-10-27 07:39:28'),
(319, 222, 'E - 005 Dt', 27, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1059\"]', 5, 1, '2020-01-22', 'LMB (1) LHB (1)', '2020-03-17 01:08:38', '2020-10-27 07:39:54'),
(320, 222, 'E - 005 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1070\"]', 3, 1, '2020-01-24', NULL, '2020-03-17 01:14:55', '2020-03-17 02:40:48');
INSERT INTO `lab_spk` (`id`, `id_order`, `no_order`, `petugas_id`, `unit_kerja`, `alat_id`, `tempat`, `ka_instalasi`, `tgl_spk`, `catatan`, `created_at`, `updated_at`) VALUES
(321, 224, 'E - 007 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1076\"]', 3, 1, '2020-02-12', 'LHK (1) LMK (1)', '2020-03-17 01:21:16', '2020-10-27 07:47:05'),
(322, 224, 'E - 007 Dt', 28, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1077\"]', 2, 1, '2020-02-12', 'LHB (1) LMB (1)', '2020-03-17 01:22:41', '2020-10-27 07:47:00'),
(323, 226, 'E - 008 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1079\"]', 5, 1, '2020-02-13', 'LHK (1) LMK (1)', '2020-03-17 01:38:36', '2020-10-27 07:59:06'),
(324, 226, 'E - 008 Dt', 27, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1080,1081\"]', 5, 1, '2020-02-13', 'LHB (2) LMB (2)', '2020-03-17 01:40:17', '2020-10-27 07:59:26'),
(325, 229, 'E - 011 Dt', 27, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1092,1093\"]', 6, 1, '2020-02-19', 'LHB (2) LMB (2)', '2020-03-17 03:03:52', '2020-10-27 08:09:19'),
(326, 237, 'E - 019 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1133\"]', 6, 1, '2020-03-06', NULL, '2020-03-17 05:46:12', '2020-03-17 05:46:12'),
(327, 238, 'E - 020 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1134\"]', 9, 1, '2020-03-17', NULL, '2020-03-19 06:16:15', '2020-03-19 06:16:15'),
(328, 240, 'E - 022 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1136\"]', 9, 1, '2020-04-07', '-', '2020-04-08 03:08:54', '2020-04-08 03:08:54'),
(329, 241, 'E - 023 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1143\"]', 9, 1, '2020-06-17', '-', '2020-06-17 00:43:57', '2020-06-17 00:43:57'),
(330, 241, 'E - 023 Dt', 28, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1148,1140\"]', 9, 1, '2020-06-17', '-', '2020-06-17 00:45:20', '2020-06-17 00:45:20'),
(331, 242, 'E - 024 Dt', 28, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1163\"]', 9, 1, '2020-06-17', '-', '2020-06-17 00:46:02', '2020-06-17 00:46:02'),
(332, 241, 'E - 023 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1159,1146\"]', 9, 1, '2020-06-17', '-', '2020-06-17 00:49:17', '2020-06-17 00:49:17'),
(333, 241, 'E - 023 Dt', 31, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1137,1138\"]', 9, 1, '2020-06-17', '-', '2020-06-17 00:50:02', '2020-06-25 06:37:01'),
(334, 242, 'E - 024 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1166\"]', 9, 1, '2020-06-17', '-', '2020-06-17 00:51:28', '2020-06-25 07:15:36'),
(335, 241, 'E - 023 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1141,1144,1147,1145\"]', 9, 1, '2020-06-17', '-', '2020-06-17 00:54:01', '2020-06-25 06:37:10'),
(336, 243, 'E - 025 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1161\"]', 9, 1, '2020-06-17', '-', '2020-06-17 00:56:27', '2020-06-19 02:05:01'),
(337, 243, 'E - 025 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1160\"]', 9, 1, '2020-06-17', '-', '2020-06-19 02:05:45', '2020-06-19 02:05:45'),
(338, 242, 'E - 024 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1168,1149\"]', 9, 1, '2020-06-17', '-', '2020-06-19 02:06:24', '2020-06-25 07:16:02'),
(339, 244, 'E - 026 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1152\"]', 9, 1, '2020-06-17', '-', '2020-06-19 02:07:27', '2020-06-19 02:07:27'),
(340, 244, 'E - 026 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1153\"]', 9, 1, '2020-06-17', '-', '2020-06-19 02:08:10', '2020-06-19 02:08:10'),
(341, 245, 'E - 027 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1169\"]', 9, 1, '2020-06-17', '-', '2020-06-19 02:08:33', '2020-06-19 02:08:33'),
(342, 244, 'E - 026 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1156\"]', 9, 1, '2020-06-23', '-', '2020-06-23 07:50:57', '2020-06-23 07:50:57'),
(343, 244, 'E - 026 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1151\"]', 9, 1, '2020-06-18', '-', '2020-06-23 07:51:52', '2020-06-23 07:51:52'),
(344, 244, 'E - 026 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1150\"]', 9, 1, '2020-06-23', '-', '2020-06-23 07:52:34', '2020-06-23 07:52:34'),
(345, 245, 'E - 027 Dt', 28, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1158\"]', 9, 1, '2020-06-18', '-', '2020-06-23 07:54:13', '2020-06-23 07:54:13'),
(346, 245, 'E - 027 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1162\"]', 9, 1, '2020-06-15', '-', '2020-06-23 07:56:54', '2020-06-23 07:56:54'),
(347, 246, 'E - 028 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1165\"]', 3, 1, '2020-06-23', '-', '2020-06-23 08:06:01', '2020-06-23 08:06:01'),
(348, 246, 'E - 028 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1157\"]', 9, 1, '2020-06-17', '-', '2020-06-23 08:06:30', '2020-06-23 08:06:30'),
(349, 247, 'E - 029 Dt', 27, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1186\"]', 9, 1, '2020-06-25', '-', '2020-06-25 06:17:44', '2020-06-25 06:17:44'),
(350, 248, 'E - 030 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1174,1173,1172,1171,1170\"]', 9, 1, '2020-06-29', '-', '2020-06-29 06:35:53', '2020-06-29 06:35:53'),
(351, 248, 'E - 030 Dt', 28, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1175,1176,1183,1184\"]', 9, 1, '2020-06-29', 'Label Hijau Besar (4), Label Merah Besar (4)', '2020-06-29 06:40:17', '2020-07-16 07:29:08'),
(352, 248, 'E - 030 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1185,1178,1177\"]', 9, 1, '2020-06-29', '-', '2020-06-29 06:41:46', '2020-06-29 06:41:46'),
(353, 248, 'E - 030 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1181,1180,1179,1182\"]', 9, 1, '2020-06-29', '-', '2020-06-29 06:42:17', '2020-06-29 06:42:17'),
(354, 249, 'E - 031 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1187\"]', 5, 1, '2020-06-30', 'Label Hijau Besar 1\r\nLabel Merah Besar 1', '2020-06-30 01:07:01', '2020-06-30 01:13:59'),
(355, 250, 'E - 032 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1188,1189,1190,1191,1192,1209\"]', 9, 1, '2020-07-03', 'Label Hijau Kecil (6), Label Merah Kecil (6)', '2020-07-14 01:53:53', '2020-07-14 01:55:09'),
(356, 250, 'E - 032 Dt', 28, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1197,1193\"]', 9, 1, '2020-07-03', 'Label Hijau Besar (2), Label Merah Besar (2)', '2020-07-14 01:56:14', '2020-07-14 01:58:18'),
(357, 250, 'E - 032 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1195,1194\"]', 9, 1, '2020-07-03', 'Label Hijau Kecil (2), Label Merah Kecil (2)', '2020-07-14 01:57:24', '2020-07-14 01:57:24'),
(358, 250, 'E - 032 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1196\"]', 9, 1, '2020-07-03', 'Label Hijau Besar (1), Label Merah Besar(1)', '2020-07-14 01:58:06', '2020-07-14 01:58:06'),
(359, 251, 'E - 033 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1200,1203,1204,1206,1208,1207\"]', 3, 1, '2020-07-09', 'Label Hijau Kecil (6), Label Merah Kecil (6)', '2020-07-14 07:07:39', '2020-07-16 07:20:18'),
(360, 251, 'E - 033 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1199,1201,1202,1205\"]', 3, 1, '2020-07-09', 'Label Hijau Kecil (4), Label Merah Kecil (4)', '2020-07-14 07:09:16', '2020-07-16 07:19:57'),
(361, 252, 'E - 034 Dt', 28, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1210\"]', 9, 1, '2020-07-14', 'Label Hijau Besar (1), Label Merah Besar (1)', '2020-07-14 07:10:04', '2020-07-14 07:10:04'),
(362, 255, 'E - 037 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1221,1222,1224\"]', 9, 1, '2020-07-28', 'Label Besar Hijau (3), Label Besar Merah (3)', '2020-07-30 04:18:45', '2020-07-30 04:19:00'),
(363, 255, 'E - 037 Dt', 31, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1220\"]', 9, 1, '2020-07-28', 'LBM (1) LBH(1)', '2020-07-30 04:20:09', '2020-09-23 08:01:29'),
(364, 253, 'E - 035 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1216\"]', 9, 1, '2020-07-23', 'LBH (1), LBM (1)', '2020-08-06 03:15:44', '2020-09-23 06:59:12'),
(365, 254, 'E - 036 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1218\"]', 9, 1, '2020-07-22', 'LBH (1) LBM (1)', '2020-08-11 00:33:44', '2020-09-23 07:29:50'),
(367, 274, 'E - 053 Dt', 31, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1342\"]', 9, 1, '2020-08-14', 'Label Hijau Besar 1 dan Label merah 1', '2020-08-19 04:01:41', '2020-10-19 06:11:55'),
(368, 273, 'E - 054 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1333,1334,1335,1336,1338\"]', 9, 1, '2020-08-18', '-', '2020-08-24 03:15:43', '2020-08-24 03:16:18'),
(369, 256, 'E - 038 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1225,1226,1227\"]', 9, 1, '2020-08-03', 'Label Hijau Besar (1), Label Merah Besar (1)', '2020-08-25 01:01:25', '2020-08-25 01:02:02'),
(370, 256, 'E - 038 Dt', 27, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1231,1229\"]', 9, 1, '2020-08-03', 'Label Hijau Kecil (2), Label Hijau Merah (2)', '2020-08-25 01:03:48', '2020-08-25 01:03:48'),
(371, 256, 'E - 038 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1228,1230\"]', 9, 1, '2020-08-03', 'Label Hijau Besar (1), Kecil (1), Label Merah Besar (1), Kecil (1)', '2020-08-25 01:07:30', '2020-08-25 01:07:30'),
(372, 271, 'E - 052 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1305,1304,1306,1307\"]', 9, 1, '2020-08-19', '-', '2020-08-25 03:52:32', '2020-08-25 03:52:32'),
(373, 270, 'E - 051 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1356,1371,1366,1365,1364,1352,1351,1375,1378,1377,1379,1370,1355,1369,1372,1363,1362,1357,1361,1360,1359,1358,1376,1368,1367,1345,1350,1349,1348,1347,1346,1353,1373,1374\"]', 9, 1, '2020-08-19', '-', '2020-08-27 01:17:37', '2020-08-27 01:17:37'),
(374, 276, 'E - 056 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1399,1401,1400,1394,1396,1395,1398,1397\"]', 9, 1, '2020-08-24', '-', '2020-08-27 02:21:50', '2020-08-27 02:21:50'),
(375, 275, 'E - 055 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1388,1391,1393,1389,1392,1387,1385,1384,1383,1382,1386,1380,1390\"]', 9, 1, '2020-08-27', '-', '2020-08-27 02:22:20', '2020-08-27 02:22:20'),
(376, 277, 'E - 057 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1403,1402,1405,1404\"]', 9, 1, '2020-08-24', '-', '2020-08-27 02:24:00', '2020-08-27 02:24:00'),
(377, 278, 'E - 058 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1406,1410,1407,1409,1408\"]', 9, 1, '2020-08-24', '-', '2020-08-27 02:28:06', '2020-08-27 02:28:06'),
(378, 281, 'E - 059 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1412,1414,1411,1413\"]', 9, 1, '2020-08-24', '-', '2020-08-27 02:28:37', '2020-08-27 02:28:37'),
(380, 282, 'E - 060 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1419,1417\"]', 9, 1, '2020-08-25', 'Label Hijau Besar (2), Label Merah Besar (2)', '2020-08-28 01:43:19', '2020-08-28 01:43:19'),
(381, 257, 'E - 039 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1238,1237,1236,1235,1234,1233,1232,1239\"]', 3, 1, '2020-08-04', 'Label Hijau Kecil (8), Label Merah Kecil (8)', '2020-08-28 05:36:19', '2020-08-28 05:36:19'),
(382, 282, 'E - 060 Dt', 20, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1416\"]', 9, 1, '2020-08-25', 'LHB(1),LMB(1)', '2020-08-28 08:55:12', '2020-08-28 08:55:12'),
(383, 282, 'E - 060 Dt', 28, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1415\"]', 9, 1, '2020-08-28', 'LHB(1),LMB(1)', '2020-08-28 08:55:41', '2020-08-28 08:55:41'),
(384, 258, 'E - 040 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1240\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:19:29', '2020-08-31 00:19:29'),
(385, 259, 'E - 041 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1243,1309,1308,1245,1244,1241,1242\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:20:29', '2020-08-31 00:20:29'),
(386, 272, 'E - 042 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1318,1319,1320,1321\"]', 9, 1, '2020-08-31', '-', '2020-08-31 00:21:31', '2020-08-31 00:21:31'),
(387, 262, 'E - 043 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1249,1252,1246,1247,1248,1253,1250,1251\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:22:05', '2020-08-31 00:22:05'),
(388, 263, 'E - 044 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1262,1261,1260,1259,1258,1255\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:22:27', '2020-08-31 00:22:27'),
(389, 264, 'E - 045 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1297,1298,1299,1303,1312,1311,1302,1301,1300\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:23:13', '2020-08-31 00:23:13'),
(390, 265, 'E - 046 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1266,1263,1264,1282,1265,1310\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:23:40', '2020-08-31 00:23:40'),
(391, 266, 'E - 047 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1271,1274,1272,1315,1313,1341,1269,1268,1267,1344,1343,1275\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:24:02', '2020-08-31 00:24:02'),
(392, 267, 'E - 048 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1276,1316,1277\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:24:29', '2020-08-31 00:24:29'),
(393, 268, 'E - 049 dT', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1278,1279,1280,1281\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:24:56', '2020-08-31 00:24:56'),
(394, 269, 'E - 050 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1289,1283,1284,1285,1286,1288,1287,1290,1291\"]', 9, 1, '2020-08-24', '-', '2020-08-31 00:25:19', '2020-08-31 00:25:19'),
(395, 284, 'E - 062 Dt', 13, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1426\"]', 9, 1, '2020-08-31', 'LHB,LMB', '2020-08-31 03:41:26', '2020-08-31 03:41:26'),
(396, 283, 'E - 061 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1421,1420,1425,1422\"]', 9, 1, '2020-09-01', 'LHB (4), LMB(4)', '2020-09-03 05:50:55', '2020-09-03 05:50:55'),
(397, 283, 'E - 061 Dt', 31, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1424,1423\"]', 9, 1, '2020-09-01', 'LHB(2), LMB(2)', '2020-09-03 05:51:25', '2020-09-03 05:51:25'),
(398, 286, 'E - 064 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1428\"]', 9, 1, '2020-09-04', 'LHB(1),LMB(1)', '2020-09-08 03:08:17', '2020-09-18 06:15:38'),
(399, 285, 'E - 063 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1427\"]', 9, 1, '2020-09-02', 'LHB (1) LMB (1)', '2020-09-09 05:52:44', '2020-09-09 05:52:44'),
(400, 295, 'E - 073 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1430\"]', 9, 1, '2020-09-09', 'LBH (1) LKM (1)', '2020-09-09 06:57:28', '2020-09-09 06:57:28'),
(401, 295, 'E - 073 Dt', 10, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1431\"]', 9, 1, '2020-09-09', 'LBH (1) LBK (1)', '2020-09-09 06:58:00', '2020-09-09 06:58:00'),
(402, 287, 'E - 065 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1429\"]', 9, 1, '2020-09-09', 'LBH (1) LBM (1)', '2020-09-09 07:44:45', '2020-09-09 07:44:45'),
(403, 295, 'E - 073 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1441,1440,1438\"]', 9, 1, '2020-09-10', 'LKH (3), LKM (3)', '2020-09-11 09:21:17', '2020-09-11 09:21:17'),
(404, 288, 'E - 066 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1432,1433,1434,1506\"]', 9, 1, '2020-09-08', 'LHK(4),LMK(4)', '2020-09-18 07:41:17', '2020-09-18 07:43:34'),
(405, 288, 'E - 066 Dt', 27, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1437,1436,1435\"]', 9, 1, '2020-09-08', 'LHK(3),LMK(3)', '2020-09-18 07:42:17', '2020-09-18 07:42:17'),
(406, 288, 'E - 066 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1442\"]', 9, 1, '2020-09-08', 'LHK(1),LMK(1)', '2020-09-18 07:44:42', '2020-09-18 07:44:42'),
(407, 290, 'E - 068 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1452,1451,1450,1449,1448,1447\"]', 9, 1, '2020-09-08', 'LHK(6),LMK(6)', '2020-09-18 07:51:26', '2020-09-18 07:51:26'),
(408, 289, 'E - 067 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1445,1444,1443\"]', 9, 1, '2020-09-08', 'LHK(3),LMK(3)', '2020-09-18 07:52:49', '2020-09-18 07:52:49'),
(409, 292, 'E - 070 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1459,1458\"]', 9, 1, '2020-09-08', 'LHK(2),LMK(2)', '2020-09-18 08:01:02', '2020-09-18 08:01:02'),
(410, 292, 'E - 070 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1457,1456\"]', 9, 1, '2020-09-08', 'LHK(2),LMK(2)', '2020-09-18 08:22:03', '2020-09-18 08:22:03'),
(411, 290, 'E - 068 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1446\"]', 9, 1, '2020-09-08', 'LHK(1),LMK(1)', '2020-09-18 08:22:40', '2020-09-18 08:22:40'),
(412, 291, 'E - 069 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1455,1454\"]', 9, 1, '2020-09-08', 'LHK(2),LMK(2)', '2020-09-18 08:23:26', '2020-09-18 08:23:26'),
(413, 291, 'E - 069 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1453\"]', 9, 1, '2020-09-08', 'LHK(1).LMK(1)', '2020-09-18 08:24:03', '2020-09-18 08:24:03'),
(414, 293, 'E - 071 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1471,1470,1469,1468,1467,1477,1466,1476,1465,1475,1474,1463,1473,1462,1461\"]', 9, 1, '2020-09-08', 'LHK(15),LMK(15)', '2020-09-18 08:26:29', '2020-09-18 08:26:29'),
(415, 293, 'E - 071 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1472,1464\"]', 9, 1, '2020-09-08', 'LHK(2),LMK(2)', '2020-09-18 08:27:09', '2020-09-18 08:27:09'),
(416, 294, 'E - 072 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1479\"]', 9, 1, '2020-09-08', 'LHK(1),LMK(1)', '2020-09-18 08:28:30', '2020-09-18 08:28:30'),
(417, 294, 'E - 072 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1478\"]', 9, 1, '2020-09-08', 'LHK(1),LMK(1)', '2020-09-18 08:29:06', '2020-09-18 08:29:06'),
(418, 296, 'E - 074 Dt', 31, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1488,1487,1485\"]', 9, 1, '2020-09-10', 'LHB(3),LMB(3)', '2020-09-18 08:31:08', '2020-09-18 08:31:08'),
(419, 296, 'E - 074 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1489,1484,1483,1482\"]', 9, 1, '2020-09-10', 'LHK(4),LMK(4)', '2020-09-18 08:32:02', '2020-09-18 08:32:02'),
(420, 296, 'E - 074 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1491,1490,1486\"]', 9, 1, '2020-09-10', 'LHB(3),LMB(3)', '2020-09-18 08:33:01', '2020-09-18 08:33:01'),
(421, 296, 'E - 074 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1534\"]', 9, 1, '2020-09-10', 'LHB(1),LMB(1)', '2020-09-18 08:33:38', '2020-09-18 08:33:38'),
(422, 297, 'E - 075 Dt', 31, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1522,1527,1526\"]', 9, 1, '2020-09-10', 'LHK(2),LHB(1),LMK(2),LMB(1)', '2020-09-18 08:36:58', '2020-09-18 08:36:58'),
(423, 297, 'E - 075 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1524,1525,1529,1523\"]', 9, 1, '2020-09-10', 'LHB(4),LMB(4)', '2020-09-18 08:38:36', '2020-09-18 08:43:54'),
(424, 297, 'E - 075 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1519,1521,1520,1532,1518,1531,1530,1533\"]', 9, 1, '2020-09-10', 'LHK(4),LHB(4),LMK(4),LMB(4)', '2020-09-18 08:40:10', '2020-09-18 08:40:10'),
(425, 297, 'E - 075 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1528\"]', 9, 1, '2020-09-10', 'LHB(1),LMB(1)', '2020-09-18 08:40:52', '2020-09-18 08:40:52'),
(426, 297, 'E - 075 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1517,1516,1515,1514,1513,1510\"]', 3, 1, '2020-09-14', 'LHK(6),LMK(6)', '2020-09-18 08:46:29', '2020-09-18 08:46:29'),
(427, 297, 'E - 075 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1512,1511,1509\"]', 3, 1, '2020-09-14', 'LHK(3),LMK(3)', '2020-09-18 08:46:58', '2020-09-18 08:46:58'),
(428, 224, 'E - 007 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1075\"]', 3, 1, '2020-09-16', 'LHK(1),LMK(1)', '2020-09-18 08:47:46', '2020-09-18 08:47:46'),
(429, 288, 'E - 066 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1508,1507\"]', 9, 1, '2020-09-09', 'LHB(2),LMB(2)', '2020-09-18 08:55:58', '2020-09-18 08:55:58'),
(430, 298, 'E - 076 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1499,1498,1497,1496,1495,1494,1493,1492\"]', 9, 1, '2020-09-14', 'LHB(8),LMB(8)', '2020-09-18 09:05:00', '2020-09-18 09:05:00'),
(431, 298, 'E - 076 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1502,1501,1500\"]', 3, 1, '2020-09-14', 'LHK(3),LMK(3)', '2020-09-18 09:06:03', '2020-09-18 09:06:03'),
(432, 298, 'E - 076 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1503,1505,1504\"]', 3, 1, '2020-09-14', 'LHK(3),LMK(3)', '2020-09-18 09:06:30', '2020-09-18 09:06:30'),
(433, 299, 'E - 077 Dt', 31, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1535\"]', 9, 1, '2020-09-18', 'LHK(1).LMK(1)', '2020-09-18 09:07:23', '2020-09-18 09:07:23'),
(434, 294, 'E - 072 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1481,1480\"]', 9, 1, '2020-09-13', 'LBH (2) LBM (2)', '2020-09-23 03:29:42', '2020-09-23 03:29:42'),
(435, 253, 'E - 035 Dt', 25, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1211\"]', 9, 1, '2020-07-23', 'LKH (1) LKM (1)', '2020-09-23 07:00:27', '2020-09-23 07:00:27'),
(436, 253, 'E - 035 Dt', 22, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1215\"]', 9, 1, '2020-07-23', 'LBM (1) LBH (1)', '2020-09-23 07:01:17', '2020-09-23 07:01:17'),
(437, 253, 'E - 035 Dt', 18, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1214,1212,1213\"]', 9, 1, '2020-07-28', 'LKH (3) LKM (3)', '2020-09-23 07:02:41', '2020-09-23 07:02:41'),
(438, 254, 'E - 036 Dt', 31, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1217\"]', 9, 1, '2020-08-04', 'LBH (1) LBM (1)', '2020-09-23 07:31:07', '2020-09-23 07:31:07'),
(439, 254, 'E - 036 Dt', 16, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1219\"]', 9, 1, '2020-07-30', 'LBH (1) LBM (1)', '2020-09-23 07:32:33', '2020-09-23 07:32:33'),
(440, 255, 'E - 037 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1223\"]', 9, 1, '2020-07-22', 'LBH (1) LBM (1)', '2020-09-23 08:05:27', '2020-09-23 08:05:27'),
(441, 300, 'E - 078 Dt', 6, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1537\"]', 9, 1, '2020-09-23', 'LBM (1) LBH (1)', '2020-09-23 08:07:39', '2020-09-23 08:07:39'),
(442, 300, 'E - 078 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1538\"]', 9, 1, '2020-09-23', 'LBH (1) LBM (1)', '2020-09-23 08:09:20', '2020-09-23 08:09:20'),
(443, 300, 'E - 078 Dt', 27, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1536\"]', 9, 1, '2020-09-22', 'LBH (1) LBM (1)', '2020-09-23 08:12:20', '2020-09-23 08:12:20'),
(444, 301, 'E - 079 Dt', 20, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1539\"]', 9, 1, '2020-09-25', 'LBH (1) LBM (1)', '2020-09-29 05:46:41', '2020-09-29 05:46:41'),
(445, 304, 'E - 087 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1569,1561,1570,1563,1562,1565,1564,1568,1567,1566\"]', 9, 1, '2020-09-28', 'belum', '2020-10-02 02:51:38', '2020-10-02 02:51:38'),
(446, 302, 'E - 080 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1540,1541\"]', 9, 1, '2020-09-28', 'blm', '2020-10-02 06:00:51', '2020-10-02 06:00:51'),
(447, 317, 'E - 095 Dt', 27, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1677,1676,1668,1666,1664,1663,1671,1675,1674,1673,1672,1658,1661,1660,1659,1670,1669,1667\"]', 9, 1, '2020-10-02', '-', '2020-10-02 06:43:16', '2020-10-02 06:43:16'),
(448, 303, 'E - 081 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1542,1543,1544,1545,1546,1547,1548,1549,1550,1551,1552,1553,1554,1555,1556,1557,1558,1559,1560\"]', 9, 1, '2020-10-06', 'LHB(4),LMB(4),LHK(15),LMK(15)', '2020-10-06 02:50:48', '2020-10-27 07:59:56'),
(449, 332, 'E - 109 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1732\"]', 9, 1, '2020-10-07', 'LHB(1),LMB(1)', '2020-10-08 07:51:21', '2020-10-08 07:51:21'),
(450, 334, 'E - 111 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1734\"]', 9, 1, '2020-10-09', 'LHB(1),LMB(1)', '2020-10-09 02:11:03', '2020-10-09 02:11:03'),
(451, 319, 'E - 097 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1688,1689,1690,1691\"]', 9, 1, '2020-10-09', 'LHB(4),LMB(4),', '2020-10-09 08:07:47', '2020-10-27 07:56:36'),
(452, 318, 'E - 096 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1678,1679,1680,1681,1682,1683,1684\"]', 9, 1, '2020-10-12', 'LHB(3),LMB(3),LHK(4),LMK(4)', '2020-10-12 06:20:26', '2020-10-27 07:56:14'),
(453, 320, 'E - 098 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1685,1686\"]', 9, 1, '2020-10-05', 'LHB(2),LMB(2)', '2020-10-14 01:33:09', '2020-10-27 07:49:38'),
(454, 305, 'E - 082 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1571\"]', 9, 1, '2020-10-15', 'LHB(1),LMB(1)', '2020-10-15 04:53:25', '2020-10-27 07:49:11'),
(455, 306, 'E - 083 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1572\"]', 9, 1, '2020-10-15', 'LHB(1),LMB(1)', '2020-10-15 04:56:52', '2020-10-27 07:46:11'),
(456, 307, 'E - 084 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1573,1575,1576,1577,1578,1579,1580,1581,1582,1583,1584,1585,1586,1587,1588,1589,1590,1592,1593,1594,1595,1596,1597,1598,1599,1602,1603\"]', 9, 1, '2020-10-15', 'LHK(15),LMK(15),LHB(9),LMB(9)', '2020-10-15 04:59:50', '2020-10-27 07:45:48'),
(457, 308, 'E - 085 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1604,1605\"]', 9, 1, '2020-10-15', 'LHB(2),LMB(2)', '2020-10-15 05:00:23', '2020-10-27 07:43:42'),
(458, 309, 'E - 086 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1606,1607,1608,1609,1610,1611\"]', 9, 1, '2020-10-15', 'LHK(2),LMK(2),LHB(4),LMB(4)', '2020-10-15 05:02:51', '2020-10-27 07:43:28'),
(459, 310, 'E - 088 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1612,1613,1614,1615,1616,1617,1618,1619\"]', 9, 1, '2020-10-15', 'LHK(3),LMK(3),LHB(5),LMB(5)', '2020-10-15 05:11:14', '2020-10-27 07:42:25'),
(460, 311, 'E - 089 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1620,1621,1622,1623,1624,1625,1626,1627,1628,1629,1630\"]', 9, 1, '2020-10-15', 'LHK(9),LMK(9),LHB(2),LMB(2)', '2020-10-15 05:16:46', '2020-10-27 07:40:36'),
(461, 312, 'E - 090 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1631,1632,1633\"]', 9, 1, '2020-10-15', 'LHK(1),LMK(1),LHB(2),LMB(2)', '2020-10-15 05:17:10', '2020-10-27 07:38:24'),
(462, 313, 'E - 091 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1634,1635,1636,1637,1638,1639,1640\"]', 9, 1, '2020-10-15', 'LHK(3),LMK(3),LHB(4),LMB(4)', '2020-10-15 05:28:30', '2020-10-27 07:37:47'),
(463, 314, 'E - 092 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1641,1642,1643,1644,1645,1646\"]', 9, 1, '2020-10-15', 'LHK(3),LMK(3),LHB(3),LMB(3)', '2020-10-15 05:28:53', '2020-10-27 07:36:24'),
(464, 315, 'E - 093 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1648,1649,1650\"]', 9, 1, '2020-10-15', 'LHK(2),LMK(2),LHB(1),LMB(1)', '2020-10-15 05:29:30', '2020-10-27 07:26:45'),
(465, 316, 'E - 094 Dt', 30, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1652,1653,1655,1656\"]', 9, 1, '2020-10-15', 'LHK(3),LMK(3),LHB(1),LMH(1)', '2020-10-15 05:31:43', '2020-10-27 07:26:01'),
(466, 332, 'E - 109 Dt', 17, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1730,1731\"]', 9, 1, '2020-10-20', 'LHK(2),LMK(2)', '2020-10-20 02:18:09', '2020-10-27 07:25:16'),
(467, 342, 'E - 119 Dt', 29, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1767\"]', 9, 1, '2020-10-19', 'LHK(1),LMK(1)', '2020-10-26 01:40:20', '2020-10-27 07:24:57'),
(468, 342, 'E - 119 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1766\"]', 9, 1, '2020-10-23', 'LHB(1),LMB(1)', '2020-10-26 01:40:46', '2020-10-27 07:24:42'),
(469, 340, 'E - 117 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1757,1755,1756\"]', 9, 1, '2020-10-21', 'LHB (2) LMB (2) LHK (!) LMK (1)', '2020-11-02 02:12:44', '2020-11-02 02:12:44'),
(470, 345, 'E - 121 Dt', 21, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1773,1772,1771,1770\"]', 9, 1, '2020-10-29', 'blm', '2020-11-02 07:20:02', '2020-11-02 07:20:02'),
(471, 343, 'E - 120 Dt', 9, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1769,1768\"]', 9, 1, '2020-10-19', 'blm', '2020-11-02 07:22:06', '2020-11-02 07:22:06'),
(472, 341, 'E - 118 Dt', 12, 'Laboratorium Kalibrasi LPFK Banjarbaru', '[\"1764,1765,1763,1761,1762\"]', 9, 1, '2020-09-09', 'LHB (2) LMB (2) LHK (3) LMK (3)', '2020-11-10 03:45:22', '2020-11-10 03:45:22');

-- --------------------------------------------------------

--
-- Table structure for table `lab_status`
--

CREATE TABLE `lab_status` (
  `id` int(10) UNSIGNED NOT NULL,
  `setatus` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_status`
--

INSERT INTO `lab_status` (`id`, `setatus`, `created_at`, `updated_at`) VALUES
(1, 'Negeri', NULL, NULL),
(2, 'Swasta', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_12_29_143008_create_admins_table', 1),
(4, '2019_01_01_003336_create_customer_table', 2),
(5, '2019_01_03_054829_create_layanan_table', 3),
(6, '2019_01_03_060649_create_penerimaan_table', 4),
(7, '2019_01_03_061539_create_alat_table', 4),
(8, '2019_01_03_071107_create_orderan_table', 5),
(9, '2019_01_03_074038_create_customer_table', 6),
(10, '2019_01_03_101733_create_detail_penerimaan_table', 7),
(11, '2019_01_03_102659_create_detail_penerimaan_table', 8),
(12, '2019_01_03_102827_create_ptg_penerimaan_table', 9),
(13, '2019_01_04_223458_create_admins_group_table', 10),
(14, '2019_01_05_014734_create_lab_kondisi_table', 11),
(15, '2019_01_05_054957_create_lab_status_table', 12),
(16, '2019_01_07_002638_create_lab_kuitansi_table', 13),
(17, '2019_01_08_032633_create_lab_laboratorium_table', 14),
(18, '2019_01_08_234331_create_lab_spk_table', 15),
(19, '2019_01_09_104033_create_lab_instalasi_table', 15),
(20, '2019_01_13_000423_create_lab_penyerahan_table', 16),
(21, '2019_01_15_063406_create_lab_bukti_table', 17),
(22, '2019_02_19_071030_create_lab_jenis_table', 18),
(23, '2020_04_07_090452_create_lab_dokumen_table', 19);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('afiantoarif78@gmail.com', '$2y$10$gbrIdEmK5XL3mzOByoEFp.QieSidZzpPKLPAcQPRXJoWwZh.9YXoO', '2019-01-01 02:28:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Moch. Arif Afianto', 'afoantoarif68@gmail.com', NULL, '$2y$10$LxoEv1hpPkd6idZeM85dL.sNTbSy52nBToH.PZfQY2NAk1PiRVyKe', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_detail_order`
-- (See below for the actual view)
--
CREATE TABLE `v_detail_order` (
`id` int(10) unsigned
,`no_order` varchar(40)
,`alat_id` int(11)
,`alat` varchar(100)
,`seri` varchar(191)
,`no_registrasi` text
,`catatan` text
,`petugas_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_dokumen`
-- (See below for the actual view)
--
CREATE TABLE `v_dokumen` (
`id` int(10) unsigned
,`nomor` int(11)
,`id_order` int(11)
,`no_order` varchar(20)
,`tahun` int(4)
,`dok1` varchar(200)
,`dok2` varchar(200)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_order`
-- (See below for the actual view)
--
CREATE TABLE `v_order` (
`no` int(11)
,`no_order` varchar(20)
,`id` int(10) unsigned
,`pemilik` varchar(191)
,`alamat` varchar(191)
,`kab` varchar(100)
,`prov` varchar(100)
,`telepon` varchar(191)
,`cp` varchar(50)
,`hp` varchar(50)
,`penyerah` varchar(191)
,`setatus` varchar(100)
,`tgl_terima` varchar(12)
,`tgl_selesai` varchar(12)
,`catatan` text
,`penerima` varchar(100)
,`pemeriksa` varchar(100)
,`created_at` timestamp
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_penyerahan`
-- (See below for the actual view)
--
CREATE TABLE `v_penyerahan` (
`rownum` int(11)
,`id` int(10) unsigned
,`id_order` int(11)
,`no_order` varchar(50)
,`tgl_serah` varchar(20)
,`petugas_id` int(11)
,`petugas_lab` varchar(100)
,`petugas_yantek` varchar(100)
,`tahun` int(4)
,`catatan` text
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_rekap`
-- (See below for the actual view)
--
CREATE TABLE `v_rekap` (
`provinsi` varchar(100)
,`RS_Pemerintah` varbinary(21)
,`RS_TNI_POLRI` varbinary(21)
,`RS_BUMN` varbinary(21)
,`RS_Swasta` varbinary(21)
,`Puskesmas` varbinary(21)
,`Klinik` varbinary(21)
,`Perusahaan` varbinary(21)
,`Lain_Lain` varbinary(21)
,`tahun` int(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_rekap_alat`
-- (See below for the actual view)
--
CREATE TABLE `v_rekap_alat` (
`tahun` int(4)
,`alat_id` int(11)
,`alat` varchar(100)
,`jumlah` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_rekap_final`
-- (See below for the actual view)
--
CREATE TABLE `v_rekap_final` (
`provinsi` varchar(100)
,`RS_Pemerintah` double
,`RS_TNI_POLRI` double
,`RS_BUMN` double
,`RS_Swasta` double
,`Puskesmas` double
,`Klinik` double
,`Perusahaan` double
,`Lain_Lain` double
,`total` double
,`tahun` int(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_rekap_kab`
-- (See below for the actual view)
--
CREATE TABLE `v_rekap_kab` (
`id_order` int(11)
,`provinsi` varchar(100)
,`kabupaten` varchar(100)
,`jenis` varchar(100)
,`yankes` varchar(100)
,`instansi` varchar(100)
,`no_order` varchar(40)
,`alat` varchar(100)
,`merek` varchar(191)
,`seri` varchar(191)
,`pelaksanaan` timestamp
,`laik_pakai` varchar(1)
,`tidak_laik_pakai` int(1)
,`tahun` int(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_rekap_kab_final`
-- (See below for the actual view)
--
CREATE TABLE `v_rekap_kab_final` (
`id_order` int(11)
,`provinsi` varchar(100)
,`kabupaten` varchar(100)
,`jenis` varchar(100)
,`yankes` varchar(100)
,`instansi` varchar(100)
,`no_order` varchar(40)
,`alat` text
,`merek` text
,`seri` text
,`pelaksanaan` timestamp
,`laik_pakai` double
,`tidak_laik_pakai` decimal(32,0)
,`tahun` int(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_serahkerja`
-- (See below for the actual view)
--
CREATE TABLE `v_serahkerja` (
`nomor` int(11)
,`id` int(10) unsigned
,`id_order` int(11)
,`no_order` varchar(191)
,`pelanggan` varchar(100)
,`penyerah` varchar(100)
,`penerima` text
,`tgl_serah` varchar(20)
,`tahun` int(4)
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_spk`
-- (See below for the actual view)
--
CREATE TABLE `v_spk` (
`nomor` int(11)
,`id` int(10) unsigned
,`id_order` int(11)
,`no_order` varchar(100)
,`petugas` varchar(100)
,`kainstalasi` varchar(100)
,`petugas_id` int(11)
,`unit_kerja` varchar(100)
,`ka_instalasi` int(11)
,`alat_id` text
,`tempat` int(11)
,`tahun` int(4)
,`catatan` text
,`created_at` timestamp
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Structure for view `v_detail_order`
--
DROP TABLE IF EXISTS `v_detail_order`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_detail_order`  AS  select `ldo`.`id` AS `id`,`ldo`.`no_order` AS `no_order`,`ldo`.`alat_id` AS `alat_id`,`get_alat`(`ldo`.`alat_id`) AS `alat`,`ldo`.`seri` AS `seri`,`ldo`.`no_registrasi` AS `no_registrasi`,`ldo`.`catatan` AS `catatan`,`ls`.`petugas_id` AS `petugas_id` from (`lab_detail_order` `ldo` join `lab_spk` `ls` on((`ls`.`no_order` = `ldo`.`no_order`))) ;

-- --------------------------------------------------------

--
-- Structure for view `v_dokumen`
--
DROP TABLE IF EXISTS `v_dokumen`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_dokumen`  AS  select `ld`.`id` AS `id`,`func_inc_var_session`() AS `nomor`,`ld`.`id_order` AS `id_order`,`lo`.`no_order` AS `no_order`,year(`lo`.`created_at`) AS `tahun`,`ld`.`dok1` AS `dok1`,`ld`.`dok2` AS `dok2` from (`lab_dokumen` `ld` join `lab_orderan` `lo` on((`lo`.`id` = `ld`.`id_order`))) order by `ld`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `v_order`
--
DROP TABLE IF EXISTS `v_order`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_order`  AS  select `func_inc_var_session`() AS `no`,`lo`.`no_order` AS `no_order`,`lo`.`id` AS `id`,`lc`.`pemilik` AS `pemilik`,`lc`.`alamat` AS `alamat`,`get_kab`(`lc`.`kabupaten_id`) AS `kab`,`get_prov`(`lc`.`provinsi_id`) AS `prov`,`lc`.`telepon` AS `telepon`,`lc`.`cp` AS `cp`,`lc`.`hp` AS `hp`,`lp`.`name` AS `penyerah`,`get_status`(`lc`.`setatus`) AS `setatus`,`lo`.`tgl_terima` AS `tgl_terima`,`lo`.`tgl_selesai` AS `tgl_selesai`,`lo`.`catatan` AS `catatan`,`get_nama`(`lp`.`ptg1`) AS `penerima`,`get_nama`(`lp`.`ptg2`) AS `pemeriksa`,`lo`.`created_at` AS `created_at`,`lo`.`updated_at` AS `updated_at` from ((`lab_customer` `lc` join `lab_orderan` `lo` on((`lo`.`id` = `lc`.`id_order`))) join `lab_ptg_penerimaan` `lp` on((`lp`.`id_order` = `lo`.`id`))) order by `lo`.`tgl_terima` desc ;

-- --------------------------------------------------------

--
-- Structure for view `v_penyerahan`
--
DROP TABLE IF EXISTS `v_penyerahan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_penyerahan`  AS  select `func_inc_var_session`() AS `rownum`,`lab_penyerahan`.`id` AS `id`,`lab_penyerahan`.`id_order` AS `id_order`,`lab_penyerahan`.`no_order` AS `no_order`,`lab_penyerahan`.`tgl_serah` AS `tgl_serah`,`lab_penyerahan`.`petugas_lab` AS `petugas_id`,`get_nama`(`lab_penyerahan`.`petugas_lab`) AS `petugas_lab`,`get_nama`(`lab_penyerahan`.`petugas_yantek`) AS `petugas_yantek`,year(`lab_penyerahan`.`created_at`) AS `tahun`,`lab_penyerahan`.`catatan` AS `catatan`,`lab_penyerahan`.`created_at` AS `created_at` from `lab_penyerahan` order by `lab_penyerahan`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `v_rekap`
--
DROP TABLE IF EXISTS `v_rekap`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_rekap`  AS  select `get_prov`(`lab_customer`.`provinsi_id`) AS `provinsi`,(case when (`get_jenis`(`lab_customer`.`jenis`) = 'RS. Pemerintah') then count(`lab_customer`.`id_order`) else ' ' end) AS `RS_Pemerintah`,(case when (`get_jenis`(`lab_customer`.`jenis`) = 'RS. TNI/POLRI') then count(`lab_customer`.`id_order`) else ' ' end) AS `RS_TNI_POLRI`,(case when (`get_jenis`(`lab_customer`.`jenis`) = 'RS. BUMN') then count(`lab_customer`.`id_order`) else ' ' end) AS `RS_BUMN`,(case when (`get_jenis`(`lab_customer`.`jenis`) = 'RS. Swasta') then count(`lab_customer`.`id_order`) else ' ' end) AS `RS_Swasta`,(case when (`get_jenis`(`lab_customer`.`jenis`) = 'Puskesmas') then count(`lab_customer`.`id_order`) else ' ' end) AS `Puskesmas`,(case when (`get_jenis`(`lab_customer`.`jenis`) = 'Klinik') then count(`lab_customer`.`id_order`) else ' ' end) AS `Klinik`,(case when (`get_jenis`(`lab_customer`.`jenis`) = 'Perusahaan') then count(`lab_customer`.`id_order`) else ' ' end) AS `Perusahaan`,(case when (`get_jenis`(`lab_customer`.`jenis`) = 'Lain - Lain') then count(`lab_customer`.`id_order`) else ' ' end) AS `Lain_Lain`,year(`lab_customer`.`created_at`) AS `tahun` from `lab_customer` group by `lab_customer`.`id_order`,`lab_customer`.`jenis`,`get_prov`(`lab_customer`.`provinsi_id`) order by year(`lab_customer`.`created_at`) desc ;

-- --------------------------------------------------------

--
-- Structure for view `v_rekap_alat`
--
DROP TABLE IF EXISTS `v_rekap_alat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_rekap_alat`  AS  select year(`ldo`.`updated_at`) AS `tahun`,`ldo`.`alat_id` AS `alat_id`,`get_alat`(`ldo`.`alat_id`) AS `alat`,count(`ldo`.`id_order`) AS `jumlah` from `lab_detail_order` `ldo` group by year(`ldo`.`updated_at`),`ldo`.`alat_id` order by year(`ldo`.`updated_at`),`get_alat`(`ldo`.`alat_id`) ;

-- --------------------------------------------------------

--
-- Structure for view `v_rekap_final`
--
DROP TABLE IF EXISTS `v_rekap_final`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_rekap_final`  AS  select `v_rekap`.`provinsi` AS `provinsi`,sum(`v_rekap`.`RS_Pemerintah`) AS `RS_Pemerintah`,sum(`v_rekap`.`RS_TNI_POLRI`) AS `RS_TNI_POLRI`,sum(`v_rekap`.`RS_BUMN`) AS `RS_BUMN`,sum(`v_rekap`.`RS_Swasta`) AS `RS_Swasta`,sum(`v_rekap`.`Puskesmas`) AS `Puskesmas`,sum(`v_rekap`.`Klinik`) AS `Klinik`,sum(`v_rekap`.`Perusahaan`) AS `Perusahaan`,sum(`v_rekap`.`Lain_Lain`) AS `Lain_Lain`,sum((((((((`v_rekap`.`RS_Pemerintah` + `v_rekap`.`RS_TNI_POLRI`) + `v_rekap`.`RS_BUMN`) + `v_rekap`.`RS_Swasta`) + `v_rekap`.`Puskesmas`) + `v_rekap`.`Klinik`) + `v_rekap`.`Perusahaan`) + `v_rekap`.`Lain_Lain`)) AS `total`,`v_rekap`.`tahun` AS `tahun` from `v_rekap` group by `v_rekap`.`tahun`,`v_rekap`.`provinsi` ;

-- --------------------------------------------------------

--
-- Structure for view `v_rekap_kab`
--
DROP TABLE IF EXISTS `v_rekap_kab`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_rekap_kab`  AS  select `ldo`.`id_order` AS `id_order`,`get_prov`(`lc`.`provinsi_id`) AS `provinsi`,`get_kab`(`lc`.`kabupaten_id`) AS `kabupaten`,`get_jenis`(`lc`.`jenis`) AS `jenis`,`get_customer`(`ldo`.`no_order`,`ldo`.`id_order`) AS `yankes`,`get_status`(`lc`.`setatus`) AS `instansi`,`ldo`.`no_order` AS `no_order`,`get_alat`(`ldo`.`alat_id`) AS `alat`,`ldo`.`merek` AS `merek`,`ldo`.`seri` AS `seri`,`ldo`.`created_at` AS `pelaksanaan`,(case when (`ldo`.`catatan` = 'Laik Pakai') then 1 else '' end) AS `laik_pakai`,(case when (`ldo`.`catatan` = 'Tidak Laik Pakai') then 1 else 0 end) AS `tidak_laik_pakai`,year(`ldo`.`updated_at`) AS `tahun` from (`lab_detail_order` `ldo` join `lab_customer` `lc` on((`lc`.`no_order` = `ldo`.`no_order`))) order by `ldo`.`id_order` desc ;

-- --------------------------------------------------------

--
-- Structure for view `v_rekap_kab_final`
--
DROP TABLE IF EXISTS `v_rekap_kab_final`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_rekap_kab_final`  AS  select `v_rekap_kab`.`id_order` AS `id_order`,`v_rekap_kab`.`provinsi` AS `provinsi`,`v_rekap_kab`.`kabupaten` AS `kabupaten`,`v_rekap_kab`.`jenis` AS `jenis`,`v_rekap_kab`.`yankes` AS `yankes`,`v_rekap_kab`.`instansi` AS `instansi`,`v_rekap_kab`.`no_order` AS `no_order`,group_concat(`v_rekap_kab`.`alat` separator ',') AS `alat`,group_concat(`v_rekap_kab`.`merek` separator ',') AS `merek`,group_concat(`v_rekap_kab`.`seri` separator ',') AS `seri`,`v_rekap_kab`.`pelaksanaan` AS `pelaksanaan`,sum(`v_rekap_kab`.`laik_pakai`) AS `laik_pakai`,sum(`v_rekap_kab`.`tidak_laik_pakai`) AS `tidak_laik_pakai`,`v_rekap_kab`.`tahun` AS `tahun` from `v_rekap_kab` group by `v_rekap_kab`.`no_order` order by `v_rekap_kab`.`id_order` desc ;

-- --------------------------------------------------------

--
-- Structure for view `v_serahkerja`
--
DROP TABLE IF EXISTS `v_serahkerja`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_serahkerja`  AS  select `func_inc_var_session`() AS `nomor`,`lab_bukti`.`id` AS `id`,`lab_bukti`.`id_order` AS `id_order`,`lab_bukti`.`no_order` AS `no_order`,`get_customer`(`lab_bukti`.`no_order`,`lab_bukti`.`id_order`) AS `pelanggan`,`get_nama`(`lab_bukti`.`penyerah`) AS `penyerah`,`lab_bukti`.`penerima` AS `penerima`,`lab_bukti`.`tgl_serah` AS `tgl_serah`,year(`lab_bukti`.`created_at`) AS `tahun`,`lab_bukti`.`created_at` AS `created_at` from `lab_bukti` order by `lab_bukti`.`id` desc ;

-- --------------------------------------------------------

--
-- Structure for view `v_spk`
--
DROP TABLE IF EXISTS `v_spk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_spk`  AS  select `func_inc_var_session`() AS `nomor`,`lab_spk`.`id` AS `id`,`lab_spk`.`id_order` AS `id_order`,`lab_spk`.`no_order` AS `no_order`,`get_nama`(`lab_spk`.`petugas_id`) AS `petugas`,`get_kainstalasi`(`lab_spk`.`ka_instalasi`) AS `kainstalasi`,`lab_spk`.`petugas_id` AS `petugas_id`,`lab_spk`.`unit_kerja` AS `unit_kerja`,`lab_spk`.`ka_instalasi` AS `ka_instalasi`,`lab_spk`.`alat_id` AS `alat_id`,`lab_spk`.`tempat` AS `tempat`,year(`lab_spk`.`created_at`) AS `tahun`,`lab_spk`.`catatan` AS `catatan`,`lab_spk`.`created_at` AS `created_at`,`lab_spk`.`updated_at` AS `updated_at` from `lab_spk` order by `lab_spk`.`id` desc ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `lab_admins_group`
--
ALTER TABLE `lab_admins_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_alat`
--
ALTER TABLE `lab_alat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_bukti`
--
ALTER TABLE `lab_bukti`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_customer`
--
ALTER TABLE `lab_customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_detail_order`
--
ALTER TABLE `lab_detail_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_dokumen`
--
ALTER TABLE `lab_dokumen`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_fungsi`
--
ALTER TABLE `lab_fungsi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_instalasi`
--
ALTER TABLE `lab_instalasi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_jenis`
--
ALTER TABLE `lab_jenis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_kabupaten`
--
ALTER TABLE `lab_kabupaten`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_kuitansi`
--
ALTER TABLE `lab_kuitansi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_laboratorium`
--
ALTER TABLE `lab_laboratorium`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_layanan`
--
ALTER TABLE `lab_layanan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_orderan`
--
ALTER TABLE `lab_orderan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_penyerahan`
--
ALTER TABLE `lab_penyerahan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_provinsi`
--
ALTER TABLE `lab_provinsi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_ptg_penerimaan`
--
ALTER TABLE `lab_ptg_penerimaan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_spk`
--
ALTER TABLE `lab_spk`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lab_status`
--
ALTER TABLE `lab_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `lab_admins_group`
--
ALTER TABLE `lab_admins_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `lab_alat`
--
ALTER TABLE `lab_alat`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `lab_bukti`
--
ALTER TABLE `lab_bukti`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=369;

--
-- AUTO_INCREMENT for table `lab_customer`
--
ALTER TABLE `lab_customer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=347;

--
-- AUTO_INCREMENT for table `lab_detail_order`
--
ALTER TABLE `lab_detail_order`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1818;

--
-- AUTO_INCREMENT for table `lab_dokumen`
--
ALTER TABLE `lab_dokumen`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `lab_fungsi`
--
ALTER TABLE `lab_fungsi`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lab_instalasi`
--
ALTER TABLE `lab_instalasi`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lab_jenis`
--
ALTER TABLE `lab_jenis`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `lab_kabupaten`
--
ALTER TABLE `lab_kabupaten`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `lab_kuitansi`
--
ALTER TABLE `lab_kuitansi`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lab_laboratorium`
--
ALTER TABLE `lab_laboratorium`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `lab_layanan`
--
ALTER TABLE `lab_layanan`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `lab_orderan`
--
ALTER TABLE `lab_orderan`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=358;

--
-- AUTO_INCREMENT for table `lab_penyerahan`
--
ALTER TABLE `lab_penyerahan`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=452;

--
-- AUTO_INCREMENT for table `lab_provinsi`
--
ALTER TABLE `lab_provinsi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lab_ptg_penerimaan`
--
ALTER TABLE `lab_ptg_penerimaan`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=346;

--
-- AUTO_INCREMENT for table `lab_spk`
--
ALTER TABLE `lab_spk`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=473;

--
-- AUTO_INCREMENT for table `lab_status`
--
ALTER TABLE `lab_status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
