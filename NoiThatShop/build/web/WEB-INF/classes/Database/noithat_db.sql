-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 12, 2025 lúc 07:03 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `noithat_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chi_tiet_don_hang`
--

CREATE TABLE `chi_tiet_don_hang` (
  `id` int(11) NOT NULL,
  `id_don_hang` int(11) DEFAULT NULL,
  `id_san_pham` int(11) DEFAULT NULL,
  `so_luong` int(11) DEFAULT NULL,
  `don_gia` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danh_muc`
--

CREATE TABLE `danh_muc` (
  `id` int(11) NOT NULL,
  `ten_danh_muc` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `danh_muc`
--

INSERT INTO `danh_muc` (`id`, `ten_danh_muc`) VALUES
(1, 'Sofa'),
(2, 'Bàn ghế'),
(3, 'Giường ngủ'),
(4, 'Tủ & Kệ'),
(5, 'Trang trí');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `don_hang`
--

CREATE TABLE `don_hang` (
  `id` int(11) NOT NULL,
  `id_nguoi_dung` int(11) DEFAULT NULL,
  `tong_tien` decimal(12,2) DEFAULT NULL,
  `trang_thai` varchar(50) DEFAULT 'Chờ xử lý',
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lien_he`
--

CREATE TABLE `lien_he` (
  `id` int(11) NOT NULL,
  `ho_ten` varchar(255) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `so_dien_thoai` varchar(50) DEFAULT NULL,
  `noi_dung` text DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(100) NOT NULL,
  `ho_ten` varchar(255) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `so_dien_thoai` varchar(30) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `token_expiry` datetime DEFAULT NULL,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`id`, `ten_dang_nhap`, `ho_ten`, `email`, `so_dien_thoai`, `dia_chi`, `mat_khau`, `reset_token`, `token_expiry`, `ngay_tao`) VALUES
(1, 'tutai', 'Từ Tú Tài', 'tutaiyb2411@gmail.com', '0344076552', 'Yên Bái', 'tutai123', NULL, NULL, '2025-11-08 09:00:20'),
(2, 'tutaiyb', 'Từ Tú Tài', 'tttai.dhti16a1cl@sv.uneti.edu.vn', '0344076552', 'Yên Bái', '2412004tt', NULL, NULL, '2025-11-12 04:26:04'),
(3, 'hung', 'Nguyễn Mạnh Hùng', 'hungnguyennn16012004@gmail.com', '0325413210', 'Hải Phòng', 'hung123', NULL, NULL, '2025-11-12 06:00:39'),
(4, 'tuan', 'Đào Minh Tuấn', 'tutaiyb24112004@gmail.com', '0354648521', 'Hải Phòng', 'tuan1', NULL, NULL, '2025-11-12 06:01:09');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `san_pham`
--

CREATE TABLE `san_pham` (
  `id` int(11) NOT NULL,
  `id_danh_muc` int(11) DEFAULT NULL,
  `ma_san_pham` varchar(50) DEFAULT NULL,
  `ten_san_pham` varchar(255) NOT NULL,
  `mo_ta` text DEFAULT NULL,
  `gia` decimal(12,2) NOT NULL,
  `hinh_anh` varchar(255) DEFAULT NULL,
  `moi` tinyint(1) DEFAULT 0,
  `noi_bat` tinyint(1) DEFAULT 0,
  `giam_gia` tinyint(1) DEFAULT 0,
  `ngay_tao` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `san_pham`
--

INSERT INTO `san_pham` (`id`, `id_danh_muc`, `ma_san_pham`, `ten_san_pham`, `mo_ta`, `gia`, `hinh_anh`, `moi`, `noi_bat`, `giam_gia`, `ngay_tao`) VALUES
(1, 1, 'SF001', 'Sofa Da 3 Chỗ Oslo', 'Sofa da thật 3 chỗ, màu xám, phong cách Bắc Âu', 8990000.00, 'images/sofa_olso.jpg', 1, 1, 0, '2025-10-21 12:22:15'),
(2, 1, 'SF002', 'Sofa Góc L Shape', 'Sofa góc L cho phòng khách rộng, bọc nỉ cao cấp', 12990000.00, 'images/sofa_goc_L.jpg', 1, 0, 1, '2025-10-21 12:22:15'),
(3, 1, 'SF003', 'Ghế Đôn Milan', 'Ghế đôn nhỏ gọn, dùng làm ghế phụ', 450000.00, 'images/ghe_don.jpg', 0, 0, 0, '2025-10-21 12:22:15'),
(4, 1, 'SF004', 'Sofa Băng 2 Chỗ Oslo Mini', 'Sofa băng 2 chỗ, phù hợp không gian nhỏ', 4990000.00, 'images/sofa_olso_doi.jpg', 1, 0, 0, '2025-10-21 12:22:15'),
(5, 1, 'SF005', 'Sofa Bed Tiện Dụng', 'Sofa có thể mở thành giường, đa năng', 7490000.00, 'images/sofa_bed.jpg', 1, 1, 0, '2025-10-21 12:22:15'),
(6, 2, 'BT001', 'Bàn Ăn Gỗ Sồi 6 Chỗ', 'Bàn ăn gỗ sồi tự nhiên cho 6 người', 7590000.00, 'images/ban_go_soi_6_nguoi.jpg', 0, 1, 0, '2025-10-21 12:22:15'),
(7, 2, 'BT002', 'Bộ Bàn Trà Scandi', 'Bàn trà phong cách Bắc Âu', 1290000.00, 'images/ban_tra_scandi.jpg', 1, 0, 1, '2025-10-21 12:22:15'),
(8, 2, 'BT003', 'Bàn Làm Việc Aries', 'Bàn làm việc đơn giản, kèm ngăn kéo', 2090000.00, 'images/Ban_Aries.jpg', 0, 0, 0, '2025-10-21 12:22:15'),
(9, 2, 'BT004', 'Bàn Trang Điểm Lily', 'Bàn trang điểm kèm gương, màu trắng', 1690000.00, 'images/ban_trang_diem.jpg', 0, 0, 1, '2025-10-21 12:22:15'),
(10, 2, 'BT005', 'Ghế Ăn Eames', 'Ghế ăn phong cách hiện đại, chân gỗ', 290000.00, 'images/ghe_eames.jpg', 0, 1, 0, '2025-10-21 12:22:15'),
(11, 2, 'BT006', 'Bàn Hộc Kéo Marco', 'Bàn phụ có hộc kéo tiện dụng', 980000.00, 'images/ban_hoc_keo.jpg', 0, 0, 0, '2025-10-21 12:22:15'),
(12, 2, 'BT007', 'Bàn Vi Tính Compact', 'Bàn vi tính nhỏ gọn, tiện lợi', 599000.00, 'images/ban_vi_tinh.jpg', 0, 1, 0, '2025-10-21 12:22:15'),
(13, 3, 'G01', 'Giường Gỗ King Size', 'Giường gỗ công nghiệp MDF chống ẩm, 1.8mx2m', 8990000.00, 'images/giuong_go_kingsize.jpg', 1, 0, 0, '2025-10-21 12:22:15'),
(14, 3, 'G02', 'Giường 1m2 Perfect', 'Giường nhỏ cho căn hộ 1-2 người', 3490000.00, 'images/giuong_1m2.jpg', 0, 0, 1, '2025-10-21 12:22:15'),
(15, 3, 'G03', 'Tấm Nệm Foam 20cm', 'Nệm foam 20cm êm ái, thoáng mát', 2190000.00, 'images/nem_foam.jpg', 0, 1, 0, '2025-10-21 12:22:15'),
(16, 3, 'G04', 'Bộ Giường + Tủ 1.2m', 'Set giường + tủ nhỏ gọn cho phòng bé', 6390000.00, 'images/giuong_tu.jpg', 1, 0, 0, '2025-10-21 12:22:15'),
(17, 3, 'G05', 'Đầu Giường Bọc Nỉ', 'Đầu giường bọc nỉ êm ái', 1290000.00, 'images/giuong_ngu_boc_ni.jpg', 0, 0, 1, '2025-10-21 12:22:15'),
(18, 3, 'G06', 'Giường tầng bé yêu', 'Giường tầng 2 tầng có cầu thang, phù hợp trẻ em', 1290000.00, 'images/giuong_2_tang.jpg', 1, 1, 1, '2025-10-21 12:22:15'),
(19, 4, 'TU01', 'Tủ Quần Áo 2 Cánh', 'Tủ quần áo cửa lùa, 2 cánh, gỗ MDF chống ẩm', 5590000.00, 'images/tu_qao_2_canh.jpg', 1, 0, 0, '2025-10-21 12:22:15'),
(20, 4, 'TU02', 'Tủ Trang Trí Kệ Modular', 'Tủ modular nhiều ngăn, hiện đại', 4290000.00, 'images/tu_modular.JPG', 0, 0, 1, '2025-10-21 12:22:15'),
(21, 4, 'TU03', 'Tủ giày 3 ngăn', 'Tủ giày nhỏ gọn, cửa gỗ màu sáng', 1290000.00, 'images/tu_giay.jpg', 0, 0, 1, '2025-10-21 12:22:15'),
(22, 4, 'KE01', 'Kệ Tivi Nordic', 'Kệ tivi phong cách Bắc Âu, đơn giản hiện đại', 1990000.00, 'images/tu_tivi.jpg', 0, 1, 0, '2025-10-21 12:22:15'),
(23, 4, 'KE02', 'Kệ Sách Thấp', 'Kệ sách thấp trang trí phòng khách', 890000.00, 'images/tu_sach_thap.jpg', 0, 0, 0, '2025-10-21 12:22:15'),
(24, 4, 'KE03', 'Kệ Góc Phòng', 'Kệ góc thông minh tiết kiệm diện tích', 690000.00, 'images/ke_goc_tuong.jpg', 0, 0, 0, '2025-10-21 12:22:15'),
(25, 5, 'TD01', 'Đèn Bàn Trang Trí', 'Đèn bàn LED trang trí, ánh sáng vàng ấm', 390000.00, 'images/den_led_de_ban.jpg', 1, 0, 1, '2025-10-21 12:22:15'),
(26, 5, 'TD02', 'Tranh Treo Tường Bộ 3', 'Tranh canvas bộ 3 cho phòng khách', 550000.00, 'images/tranh_canvas.jpg', 0, 1, 0, '2025-10-21 12:22:15'),
(27, 5, 'TD03', 'Thảm Chùi Chân Len', 'Thảm len trang trí nhỏ gọn', 299000.00, 'images/tham_chui_chan.jpg', 0, 0, 0, '2025-10-21 12:22:15'),
(28, 5, 'TD04', 'Bình Hoa Gốm Sứ', 'Bình hoa gốm trang trí nhỏ', 199000.00, 'images/binh_gom.jpg', 0, 0, 0, '2025-10-21 12:22:15'),
(29, 5, 'TD05', 'Gương Treo Tường', 'Gương khung gỗ decor hiện đại', 450000.00, 'images/guong_treo_tuong.jpg', 0, 1, 0, '2025-10-21 12:22:15'),
(30, 5, 'TD06', 'Đèn Trần Hiện Đại', 'Đèn trần phong cách hiện đại', 1250000.00, 'images/den_tran.jpg', 0, 0, 0, '2025-10-21 12:22:15');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_don_hang` (`id_don_hang`),
  ADD KEY `id_san_pham` (`id_san_pham`);

--
-- Chỉ mục cho bảng `danh_muc`
--
ALTER TABLE `danh_muc`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_nguoi_dung` (`id_nguoi_dung`);

--
-- Chỉ mục cho bảng `lien_he`
--
ALTER TABLE `lien_he`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Chỉ mục cho bảng `san_pham`
--
ALTER TABLE `san_pham`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_danh_muc` (`id_danh_muc`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `danh_muc`
--
ALTER TABLE `danh_muc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `lien_he`
--
ALTER TABLE `lien_he`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `san_pham`
--
ALTER TABLE `san_pham`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chi_tiet_don_hang`
--
ALTER TABLE `chi_tiet_don_hang`
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_1` FOREIGN KEY (`id_don_hang`) REFERENCES `don_hang` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chi_tiet_don_hang_ibfk_2` FOREIGN KEY (`id_san_pham`) REFERENCES `san_pham` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `don_hang`
--
ALTER TABLE `don_hang`
  ADD CONSTRAINT `don_hang_ibfk_1` FOREIGN KEY (`id_nguoi_dung`) REFERENCES `nguoi_dung` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `san_pham`
--
ALTER TABLE `san_pham`
  ADD CONSTRAINT `san_pham_ibfk_1` FOREIGN KEY (`id_danh_muc`) REFERENCES `danh_muc` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
