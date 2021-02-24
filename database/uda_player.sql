-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 24 Feb 2021 pada 04.28
-- Versi server: 8.0.22
-- Versi PHP: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uda_player`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `recent_opens`
--

CREATE TABLE `recent_opens` (
  `id` int NOT NULL,
  `video_id` varchar(100) NOT NULL,
  `user_id` int NOT NULL,
  `created_at` date NOT NULL,
  `timestamp` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

--
-- Dumping data untuk tabel `recent_opens`
--

INSERT INTO `recent_opens` (`id`, `video_id`, `user_id`, `created_at`, `timestamp`) VALUES
(6, '3zc3cthF9kQ', 3, '2021-02-23', '16:31:11'),
(7, '809Gq5AUGQ0', 2, '2021-02-23', '16:32:22'),
(8, 'B4updpY2i1c', 2, '2021-02-23', '16:32:35'),
(9, 'B4updpY2i1c', 2, '2021-02-23', '16:32:40'),
(10, 'B4updpY2i1c', 2, '2021-02-23', '16:32:53'),
(11, 'v0cCsQzYT4A', 2, '2021-02-23', '16:52:22'),
(12, 'B4updpY2i1c', 2, '2021-02-23', '19:52:10'),
(13, 'B4updpY2i1c', 2, '2021-02-24', '01:38:23'),
(14, 'v0cCsQzYT4A', 2, '2021-02-24', '02:06:40'),
(15, 'v0cCsQzYT4A', 2, '2021-02-24', '02:06:56'),
(16, '809Gq5AUGQ0', 2, '2021-02-24', '02:09:10'),
(17, 'B4updpY2i1c', 2, '2021-02-24', '02:09:16'),
(18, 'LLDkQkL8yYQ', 2, '2021-02-24', '02:09:40'),
(19, 'v0cCsQzYT4A', 2, '2021-02-24', '02:09:53'),
(20, 'B4updpY2i1c', 4, '2021-02-24', '02:23:02'),
(21, 'B4updpY2i1c', 4, '2021-02-24', '03:03:00'),
(22, 'B4updpY2i1c', 4, '2021-02-24', '03:05:34'),
(23, 'SMCAZ8douRk', 4, '2021-02-24', '03:05:40'),
(24, 'B4updpY2i1c', 4, '2021-02-24', '03:05:51'),
(25, 'v0cCsQzYT4A', 4, '2021-02-24', '03:09:36'),
(26, 'v0cCsQzYT4A', 4, '2021-02-24', '03:30:49'),
(27, 'y4AQRZLTjKE', 4, '2021-02-24', '10:55:28'),
(28, 'SMCAZ8douRk', 4, '2021-02-24', '11:21:18'),
(29, 'y4AQRZLTjKE', 4, '2021-02-24', '11:25:34'),
(30, '809Gq5AUGQ0', 4, '2021-02-24', '11:26:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'admin', 'uda@gmail.com', '123123', '2021-02-18 15:20:51'),
(2, 'riski', 'riski@gmail.com', '4297f44b13955235245b2497399d7a93', '2021-02-18 15:26:50'),
(3, 'riskii', 'akun@gmail.com', 'a3dcb4d229de6fde0db5686dee47145d', '2021-02-20 10:08:47'),
(4, 'bindev', 'bin@gmail.com', '4297f44b13955235245b2497399d7a93', '2021-02-24 02:13:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `watch_later`
--

CREATE TABLE `watch_later` (
  `id` int NOT NULL,
  `video_id` varchar(100) NOT NULL,
  `user_id` int NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ;

--
-- Dumping data untuk tabel `watch_later`
--

INSERT INTO `watch_later` (`id`, `video_id`, `user_id`, `date`, `time`) VALUES
(16, 'SMCAZ8douRk', 4, '2021-02-24', '11:23:39'),
(17, 'y4AQRZLTjKE', 4, '2021-02-24', '11:24:49');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `recent_opens`
--
ALTER TABLE `recent_opens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_uda_player_user_id` (`user_id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `watch_later`
--
ALTER TABLE `watch_later`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_uda_player_user_idx2` (`user_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `recent_opens`
--
ALTER TABLE `recent_opens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `watch_later`
--
ALTER TABLE `watch_later`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `recent_opens`
--
ALTER TABLE `recent_opens`
  ADD CONSTRAINT `fk_uda_player_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ketidakleluasaan untuk tabel `watch_later`
--
ALTER TABLE `watch_later`
  ADD CONSTRAINT `fk_uda_player_user_idx2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
