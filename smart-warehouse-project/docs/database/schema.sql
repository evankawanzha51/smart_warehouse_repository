-- ============================================================
-- Smart Warehouse - Database Schema
-- File    : schema.sql
-- Deskripsi: Struktur tabel untuk sistem inventory warehouse
-- Versi   : 1.0
-- ============================================================

CREATE DATABASE IF NOT EXISTS `smart_warehouse`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE `smart_warehouse`;

-- ============================================================
-- Tabel: inventory_transactions
-- Menyimpan semua transaksi barang masuk dan keluar gudang
-- ============================================================

CREATE TABLE IF NOT EXISTS `inventory_transactions` (
  `id`               INT(11)                   NOT NULL AUTO_INCREMENT,
  `transaction_time` DATETIME                  NOT NULL COMMENT 'Waktu transaksi terjadi',
  `item_code`        VARCHAR(20)               NOT NULL COMMENT 'Kode unik barang, contoh: ITM001',
  `item_name`        VARCHAR(100)              NOT NULL COMMENT 'Nama barang',
  `category`         VARCHAR(50)               NOT NULL COMMENT 'Kategori: Elektronik / Elektrikal / Mekanik',
  `transaction_type` ENUM('MASUK', 'KELUAR')   NOT NULL COMMENT 'Jenis transaksi',
  `quantity`         INT(11)                   NOT NULL COMMENT 'Jumlah barang dalam transaksi',
  `rack_location`    VARCHAR(20)               NOT NULL COMMENT 'Lokasi rak gudang, contoh: A01',
  `operator_name`    VARCHAR(50)               NOT NULL COMMENT 'Nama operator yang melakukan transaksi',
  `status`           VARCHAR(30)               NOT NULL COMMENT 'Status: Stored / Verified / Completed',
 PRIMARY KEY (`id`),

INDEX idx_transaction_time (`transaction_time`),

INDEX idx_item_code (`item_code`),

INDEX idx_transaction_type (`transaction_type`)
