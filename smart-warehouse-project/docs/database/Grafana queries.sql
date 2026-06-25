-- ============================================================
-- Smart Warehouse - Query untuk Grafana Dashboard
-- File    : grafana_queries.sql
-- Deskripsi: Kumpulan query SQL yang digunakan pada panel Grafana
-- ============================================================


-- ------------------------------------------------------------
-- 1. Total Transaksi per Hari (Time Series)
-- Panel: Grafik transaksi harian
-- ------------------------------------------------------------
SELECT
  DATE(transaction_time)  AS "time",
  COUNT(*)                AS "Total Transaksi"
FROM inventory_transactions
GROUP BY DATE(transaction_time)
ORDER BY DATE(transaction_time);


-- ------------------------------------------------------------
-- 2. Jumlah Barang Masuk vs Keluar per Hari
-- Panel: Perbandingan MASUK dan KELUAR
-- ------------------------------------------------------------
SELECT
  DATE(transaction_time)  AS "time",
  transaction_type        AS "Jenis",
  SUM(quantity)           AS "Total Qty"
FROM inventory_transactions
GROUP BY DATE(transaction_time), transaction_type
ORDER BY DATE(transaction_time);


-- ------------------------------------------------------------
-- 3. Top 5 Barang Paling Aktif (Berdasarkan Jumlah Transaksi)
-- Panel: Bar chart barang paling sering dipindah
-- ------------------------------------------------------------
SELECT
  item_name,
  COUNT(*) AS "Jumlah Transaksi"
FROM inventory_transactions
GROUP BY item_name
ORDER BY COUNT(*) DESC
LIMIT 5;


-- ------------------------------------------------------------
-- 4. Distribusi Transaksi per Kategori
-- Panel: Pie chart kategori
-- ------------------------------------------------------------
SELECT
  category,
  COUNT(*) AS "Jumlah Transaksi"
FROM inventory_transactions
GROUP BY category
ORDER BY COUNT(*) DESC;


-- ------------------------------------------------------------
-- 5. Aktivitas per Operator
-- Panel: Tabel atau bar chart operator
-- ------------------------------------------------------------
SELECT
  operator_name,
  COUNT(*)        AS "Total Transaksi",
  SUM(quantity)   AS "Total Qty"
FROM inventory_transactions
GROUP BY operator_name
ORDER BY COUNT(*) DESC;


-- ------------------------------------------------------------
-- 6. Status Transaksi (Stored / Verified / Completed)
-- Panel: Pie chart atau stat panel
-- ------------------------------------------------------------
SELECT
  status,
  COUNT(*) AS "Jumlah"
FROM inventory_transactions
GROUP BY status
ORDER BY COUNT(*) DESC;


-- ------------------------------------------------------------
-- 7. Aktivitas per Lokasi Rak
-- Panel: Heatmap atau bar chart lokasi
-- ------------------------------------------------------------
SELECT
  rack_location,
  COUNT(*) AS "Jumlah Transaksi"
FROM inventory_transactions
GROUP BY rack_location
ORDER BY COUNT(*) DESC;


-- ------------------------------------------------------------
-- 8. Total Kuantitas Masuk dan Keluar per Item
-- Panel: Tabel ringkasan stok
-- ------------------------------------------------------------
SELECT
  item_code,
  item_name,
  SUM(CASE WHEN transaction_type = 'MASUK'  THEN quantity ELSE 0 END) AS "Total Masuk",
  SUM(CASE WHEN transaction_type = 'KELUAR' THEN quantity ELSE 0 END) AS "Total Keluar",
  SUM(CASE WHEN transaction_type = 'MASUK'  THEN quantity ELSE 0 END) -
  SUM(CASE WHEN transaction_type = 'KELUAR' THEN quantity ELSE 0 END) AS "Estimasi Stok"
FROM inventory_transactions
GROUP BY item_code, item_name
ORDER BY item_code;


-- ------------------------------------------------------------
-- 9. Transaksi Terbaru (10 Terakhir)
-- Panel: Tabel live feed
-- ------------------------------------------------------------
SELECT
  transaction_time  AS "Waktu",
  item_code         AS "Kode",
  item_name         AS "Nama Barang",
  transaction_type  AS "Jenis",
  quantity          AS "Qty",
  rack_location     AS "Rak",
  operator_name     AS "Operator",
  status            AS "Status"
FROM inventory_transactions
ORDER BY transaction_time DESC
LIMIT 10;
