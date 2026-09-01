-- ============================================================
-- FILE        : db_krs.sql
-- DESKRIPSI   : Script Lengkap Pembelajaran Database KRS Universitas
-- MATERI      : DDL (CREATE, ALTER, DESCRIBE), DML (INSERT, SELECT), & CONSTRAINTS
-- ============================================================

-- 1. UTILITY & PENGECEKAN AWAL
-- Melihat seluruh database yang ada di server MySQL
SHOW DATABASES;

-- Membuat database baru jika belum ada
CREATE DATABASE IF NOT EXISTS db_krs;

-- Memilih/mengaktifkan database yang akan digunakan
USE db_krs;


-- ============================================================
-- 2. PEMBUATAN TABEL MASTER (DDL)
-- ============================================================

-- Tabel 1: Mahasiswa
CREATE TABLE IF NOT EXISTS Mahasiswa (
    nim_mahasiswa CHAR(6) PRIMARY KEY,
    nama_mahasiswa VARCHAR(50) NOT NULL,
    program_studi VARCHAR(50) NOT NULL,
    semester INT NOT NULL
);

-- Tabel 2: Mata Kuliah
CREATE TABLE IF NOT EXISTS Mata_Kuliah (
    kode_mk CHAR(5) PRIMARY KEY,
    nama_mk VARCHAR(50) NOT NULL,
    sks INT NOT NULL,
    kuota_kelas INT NOT NULL
);

-- Tabel 3: Dosen
CREATE TABLE IF NOT EXISTS Dosen (
    nip_dosen CHAR(10) PRIMARY KEY,
    nama_dosen VARCHAR(50) NOT NULL
);

-- Tabel 4: KRS (Tabel Transaksi dengan Foreign Key)
CREATE TABLE IF NOT EXISTS KRS (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    nim_mahasiswa CHAR(6),
    kode_mk CHAR(5),
    nip_dosen CHAR(10),
    tahun_akademik VARCHAR(9),
    semester_akademik VARCHAR(6),
    status_persetujuan VARCHAR(10),
    FOREIGN KEY (nim_mahasiswa) REFERENCES Mahasiswa(nim_mahasiswa),
    FOREIGN KEY (kode_mk) REFERENCES Mata_Kuliah(kode_mk),
    FOREIGN KEY (nip_dosen) REFERENCES Dosen(nip_dosen)
);


-- ============================================================
-- 3. CATATAN PELAJARAN: ALTER TABLE & CHECK CONSTRAINT
-- (Tetap dipertahankan sebagai bahan catatan belajar)
-- ============================================================

-- Menambahkan aturan CHECK constraint agar semester hanya boleh 1 - 14
ALTER TABLE Mahasiswa 
ADD CONSTRAINT check_semester CHECK (semester >= 1 AND semester <= 14);


-- ============================================================
-- 4. PENGISIAN DATA (DML - INSERT INTO)
-- ============================================================

-- Inserting data ke tabel Mahasiswa (Tabel Utama)
INSERT INTO Mahasiswa (nim_mahasiswa, nama_mahasiswa, program_studi, semester) VALUES
('163633', 'Budi Santoso', 'Informatika', 3),
('163634', 'Siti Aminah', 'Sistem Informasi', 5);

-- Inserting data ke tabel Mata Kuliah (Tabel Utama)
INSERT INTO Mata_Kuliah (kode_mk, nama_mk, sks, kuota_kelas) VALUES
('IF352', 'Linear Algebra', 3, 40),
('IF100', 'Algoritma & Pemrograman', 4, 35);

-- Inserting data ke tabel Dosen (Tabel Utama)
INSERT INTO Dosen (nip_dosen, nama_dosen) VALUES
('1234567890', 'Dr. Agus Wijaya'),
('0987654321', 'Prof. Maria Utama');

-- Inserting data ke tabel KRS (Menghubungkan Mahasiswa, MK, dan Dosen)
INSERT INTO KRS (nim_mahasiswa, kode_mk, nip_dosen, tahun_akademik, semester_akademik, status_persetujuan) VALUES
('163633', 'IF352', '1234567890', '2024/2025', 'Ganjil', 'Approved'),
('163634', 'IF100', '0987654321', '2024/2025', 'Ganjil', 'Pending');


-- ============================================================
-- 5. INTEROGASI & PENGECEKAN DATA (SELECT & DESCRIBE)
-- ============================================================

-- Melihat seluruh tabel yang ada di dalam db_krs
SHOW TABLES;

-- Melihat struktur/spesifikasi kolom tabel Mahasiswa
DESCRIBE Mahasiswa;

-- Melihat seluruh resep pembuatan tabel Mahasiswa beserta aturan constraint-nya
SHOW CREATE TABLE Mahasiswa;

-- Menampilkan seluruh isi data dari masing-masing tabel
SELECT * FROM Mahasiswa;
SELECT * FROM Mata_Kuliah;
SELECT * FROM Dosen;
SELECT * FROM KRS;

-- Contoh SELECT dengan filter/kondisi (Mahasiswa semester 3 saja)
SELECT * FROM Mahasiswa WHERE semester_mahasiswa = 3;
