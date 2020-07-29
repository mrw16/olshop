-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 04, 2020 at 02:55 PM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.0.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tokoku`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_detail_pembelian`
--

CREATE TABLE `tbl_detail_pembelian` (
  `id_detail_pembelian` int(11) NOT NULL,
  `id_pembelian` int(11) NOT NULL,
  `kode_produk` char(3) NOT NULL,
  `jml_beli` mediumint(9) NOT NULL,
  `keterangan` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_detail_pembelian`
--

INSERT INTO `tbl_detail_pembelian` (`id_detail_pembelian`, `id_pembelian`, `kode_produk`, `jml_beli`, `keterangan`) VALUES
(1, 1, 'P05', 2, 'Hitam + Biru'),
(2, 2, 'P05', 1, '-'),
(3, 3, 'P05', 2, '-'),
(4, 3, 'p03', 1, '-'),
(5, 4, 'P05', 89, 'Gc ya njing!');

--
-- Triggers `tbl_detail_pembelian`
--
DELIMITER $$
CREATE TRIGGER `kurangi_stok` AFTER INSERT ON `tbl_detail_pembelian` FOR EACH ROW BEGIN
	UPDATE tbl_produk SET tbl_produk.jml_beli=tbl_produk.jml_beli-new.jml_beli WHERE tbl_produk.kode_produk=new.kode_produk;	
    end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_inbox`
--

CREATE TABLE `tbl_inbox` (
  `id_inbox` int(11) NOT NULL,
  `nama_pengirim` varchar(100) NOT NULL,
  `email_pengirim` varchar(150) NOT NULL,
  `waktu_kirim` datetime NOT NULL,
  `isi_pesan` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_konfirmasi`
--

CREATE TABLE `tbl_konfirmasi` (
  `id_pembelian` int(11) NOT NULL,
  `waktu_konfirmasi` datetime NOT NULL,
  `bukti_pembayaran` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_konfirmasi`
--

INSERT INTO `tbl_konfirmasi` (`id_pembelian`, `waktu_konfirmasi`, `bukti_pembayaran`) VALUES
(1, '2019-02-12 12:58:02', '1-bukti_transfer.jpeg'),
(2, '2019-03-05 02:04:15', '2-bukti-transfer-ranto-jasa-skripsi-5-WA0011.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pembelian`
--

CREATE TABLE `tbl_pembelian` (
  `id_pembelian` int(11) NOT NULL,
  `tanggal_pembelian` datetime NOT NULL,
  `email` varchar(200) NOT NULL,
  `status_pembelian` enum('selesai','pending') NOT NULL DEFAULT 'pending',
  `rek_tujuan` tinyint(4) NOT NULL,
  `jasa_kurir` tinyint(4) NOT NULL,
  `alamat_tujuan` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_pembelian`
--

INSERT INTO `tbl_pembelian` (`id_pembelian`, `tanggal_pembelian`, `email`, `status_pembelian`, `rek_tujuan`, `jasa_kurir`, `alamat_tujuan`) VALUES
(1, '2019-02-12 12:55:34', 'iqbal@yahoo.com', 'selesai', 1, 1, 'Kadugede'),
(2, '2019-03-04 07:55:11', 'galih@yahoo.com', 'selesai', 1, 1, 'Kuningan'),
(3, '2019-03-05 02:02:34', 'galih@yahoo.com', 'selesai', 1, 1, 'Kuningan'),
(4, '2020-05-19 14:52:04', 'rifqiwahyudi16@gmail.com', 'selesai', 1, 2, 'Jl. Tmn pagelaran blok G.16 no.04');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_produk`
--

CREATE TABLE `tbl_produk` (
  `kode_produk` char(3) NOT NULL,
  `nama_produk` varchar(150) NOT NULL,
  `merk` varchar(100) NOT NULL,
  `tgl_beli` date NOT NULL,
  `harga_beli` mediumint(9) NOT NULL,
  `harga_jual` mediumint(9) NOT NULL,
  `jml_beli` mediumint(9) NOT NULL,
  `photo_produk` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_produk`
--

INSERT INTO `tbl_produk` (`kode_produk`, `nama_produk`, `merk`, `tgl_beli`, `harga_beli`, `harga_jual`, `jml_beli`, `photo_produk`) VALUES
('p01', 'Tas Backpaker Anti Air', 'Eiger', '2019-01-02', 400000, 475000, 15, 'p01.jpg'),
('P02', 'Tas Gendong', 'Eiger', '2019-01-05', 250000, 300000, 10, 'p02.jpg'),
('p03', 'Celana Gunung', 'Eiger', '2019-01-10', 175000, 210000, 23, 'p03.jpg'),
('P04', 'Sepatu', 'Adidas', '2019-06-02', 100000, 150000, 10, 'P04.jpg'),
('P05', 'Topi', 'Cresida', '2019-07-02', 50000, 75000, -84, 'P05.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `email` varchar(200) NOT NULL,
  `nama_lengkap` varchar(150) NOT NULL,
  `password` char(32) NOT NULL,
  `alamat` mediumtext NOT NULL,
  `handphone` varchar(20) NOT NULL,
  `waktu_daftar` datetime NOT NULL,
  `level` enum('administrator','member') NOT NULL DEFAULT 'member'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`email`, `nama_lengkap`, `password`, `alamat`, `handphone`, `waktu_daftar`, `level`) VALUES
('admin1@admin.com', 'Rifqi Wahyudi', 'admin12345', 'Pagelaran', '', '2020-07-04 07:08:02', 'administrator'),
('admin@admin.com', 'Oya Suryana', '202cb962ac59075b964b07152d234b70', 'Kuningan', '', '2019-01-12 04:59:35', 'administrator'),
('ardanava16@gmail.com', 'Ardanava', 'e6fea635a6e2ffc7313dfbb3ae72a9b0', 'Planet Bumi', '', '2019-02-07 04:39:03', 'member'),
('dani@google.com', 'dani', '202cb962ac59075b964b07152d234b70', 'Jalaksana', '', '2019-02-07 04:29:18', 'member'),
('galih@yahoo.com', 'Galih', '202cb962ac59075b964b07152d234b70', 'Kuningan', '', '2019-01-15 00:36:18', 'member'),
('iqbal@yahoo.com', 'Iqbal', '202cb962ac59075b964b07152d234b70', 'Kadugede', '', '2019-01-25 02:26:00', 'member'),
('irma@gmail.com', 'irmayanti', '202cb962ac59075b964b07152d234b70', 'ciherang, kadugede, kuningan', '', '2019-02-07 02:27:04', 'member'),
('lutfi@yahoo.com', 'M. Lutfhi', '202cb962ac59075b964b07152d234b70', 'Kuningan', '', '2019-01-14 03:53:36', 'member'),
('nurman@google.com', 'Nurman', '202cb962ac59075b964b07152d234b70', 'Kadugede', '', '2019-01-25 03:47:56', 'member'),
('nurmanfauzan001@gmail.com', 'nurman fauzan hidayana', '202cb962ac59075b964b07152d234b70', 'sindang jawa', '', '2019-01-28 06:43:19', 'member'),
('rifqi@yahoo.com', 'Rifqi Wahyudi', '44cdc514b27fde0d2fe39d25771c77d7', 'pagelaran anjay', '', '2020-07-04 11:40:06', 'member'),
('rifqiwahyudi16@gmail.com', 'Rifqi Wahyudi', '44cdc514b27fde0d2fe39d25771c77d7', 'Jl. Tmn pagelaran blok G.16 no.04', '', '2020-05-19 14:51:05', 'member'),
('rika.widianingsih@yahoo.com', 'Rika Widianingsih', '602755dcc0177f7ab9fd73d86bc9eb54', 'Bayuning - Kuningan', '083435464531', '2019-01-12 05:02:06', 'member'),
('rizky@google.com', 'Rizky', '202cb962ac59075b964b07152d234b70', 'Garawangi', '', '2019-02-06 01:08:39', 'member'),
('shelasyawalita@gmail.com', 'Shela', '202cb962ac59075b964b07152d234b70', 'Ds. Mekarwangi Kec. Lebakwangi', '', '2019-01-26 15:44:25', 'member'),
('tresna@yahoo.com', 'tresna', 'e10adc3949ba59abbe56e057f20f883e', 'cileuluey', '', '2019-04-04 06:08:04', 'member'),
('trisukma761@gmail.com', 'Tri Sukma Wijaya', '202cb962ac59075b964b07152d234b70', 'Cibeureum-Kuningan', '', '2019-02-01 04:09:35', 'member'),
('ucuniek@yahoo.com', 'Nunik Nurdiati', '202cb962ac59075b964b07152d234b70', 'Cigadung', '', '2019-01-14 13:41:31', 'member');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_detail_pembelian`
--
ALTER TABLE `tbl_detail_pembelian`
  ADD PRIMARY KEY (`id_detail_pembelian`);

--
-- Indexes for table `tbl_inbox`
--
ALTER TABLE `tbl_inbox`
  ADD PRIMARY KEY (`id_inbox`);

--
-- Indexes for table `tbl_konfirmasi`
--
ALTER TABLE `tbl_konfirmasi`
  ADD PRIMARY KEY (`id_pembelian`);

--
-- Indexes for table `tbl_pembelian`
--
ALTER TABLE `tbl_pembelian`
  ADD PRIMARY KEY (`id_pembelian`);

--
-- Indexes for table `tbl_produk`
--
ALTER TABLE `tbl_produk`
  ADD PRIMARY KEY (`kode_produk`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_detail_pembelian`
--
ALTER TABLE `tbl_detail_pembelian`
  MODIFY `id_detail_pembelian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_inbox`
--
ALTER TABLE `tbl_inbox`
  MODIFY `id_inbox` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_pembelian`
--
ALTER TABLE `tbl_pembelian`
  MODIFY `id_pembelian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
