CREATE DATABASE IF NOT EXISTS toko_bunga;
USE toko_bunga;

CREATE TABLE IF NOT EXISTS produk (
  id_produk CHAR(4) PRIMARY KEY,
  nama      VARCHAR(30),
  ukuran    VARCHAR(10),
  harga     INT,
  stok      INT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS karyawan (
  id_karyawan CHAR(3) PRIMARY KEY,
  nama        VARCHAR(30),
  jabatan     VARCHAR(20),
  id_atasan   CHAR(3),
  FOREIGN KEY (id_atasan) REFERENCES karyawan(id_karyawan)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS penjualan (
  id_penjualan INT AUTO_INCREMENT PRIMARY KEY,
  tanggal      DATE,
  id_produk    CHAR(4),
  id_karyawan  CHAR(3),
  jumlah       INT,
  FOREIGN KEY (id_produk) REFERENCES produk(id_produk),
  FOREIGN KEY (id_karyawan) REFERENCES karyawan(id_karyawan)
) ENGINE=InnoDB;

INSERT INTO produk VALUES
('P001','Gymnocalycium','Mini',25000,30),
('P002','Haworthia Attenuata','Mini',30000,25),
('P003','Mammillaria','Mini',35000,20),
('P004','Cereus Tetragonus','Sedang',55000,0),
('P005','Astrophytum','Sedang',75000,12),
('P006','Ariocarpus','Sedang',90000,8),
('P007','Cephalocereus Senilis','Besar',150000,5),
('P008','Ferocactus','Besar',200000,3);

INSERT INTO karyawan VALUES
('E01','Philza','Pemilik',NULL),
('E02','Technoblade','Kepala Toko','E01'),
('E03','Dream','Kepala Kebun','E01'),
('E04','Tommy','Kasir','E02'),
('E05','Tubbo','Kasir','E02'),
('E06','Evbo','Perawat Kaktus','E03'),
('E07','Ranboo','Perawat Kaktus','E03');

INSERT INTO penjualan (tanggal, id_produk, id_karyawan, jumlah) VALUES
('2026-10-03','P001','E04',4),
('2026-10-04','P005','E05',1),
('2026-10-07','P002','E04',3),
('2026-10-12','P007','E05',1),
('2026-10-18','P001','E05',5),
('2026-10-25','P006','E04',2),
('2026-11-02','P003','E04',2),
('2026-11-05','P008','E05',1),
('2026-11-09','P001','E04',3),
('2026-11-14','P004','E05',2);

show tables;
describe karyawan;
describe penjualan;
describe produk;

-- SI PEMILIK DIA MAU NGELIAT DAFTAR KAKTUS, NAMA, UKURAN, HARGA DAN STOKNYA, GA MAU KETIK QUERY NYA TERUS TERUSAN.
delimiter //
create procedure list_cactus()
begin
select nama, ukuran, harga, stok
from produk;
end // 
delimiter; 

-- TERUS TIBA TIBA ADA YANG DATENG, MAU BELI KAKTUS, MAU KAKTUS YANG UKURAN MINI ADA APA AJA, KASIR HARUS NAMPILIN SEMUA KATEORI --YANG MINI.
delimiter //
create procedure cactus_mini(in uk varchar(10))
begin
select nama, ukuran, harga, stok
from produk
where ukuran = uk;
end //
delimiter;

call cactus_mini('Mini');

-- ADA PEMBELI LAIN DATENG, TAPI BUDGET NYA DIKIT, NAH SI KASIR HARUS BISA NAMPILIN KAKTUS YANG SESUAI BUDGET PEMBELINYA, TAPI --TIDAK --BOLEH MENAMPILKAN STOK YANG NOL.
delimiter //
create procedure budget_cactus(in budget int)
BEGIN
select nama, harga, ukuran, stok
from produk
where harga <= budget and stok > 0;
end //
delimiter;

call budget_cactus(50000);

-- si kasir ada sistem yang nampilin harga kaktus setelah promo
delimiter //
create procedure promo_cactus(in promo int)
begin
select nama,ukuran,harga,stok,
round(harga * (100 - promo) / 100) as `After Promo`
from produk;
end //
delimiter;

-- si pemilik toko mau hitung berapa total hpp stok x harga, harus pake local var, dan (Rp. )
delimiter //
create procedure calculate_total()
BEGIN
declare total int default 0;
select sum(stok * harga) into total
from produk;
select concat('Rp. ', total) as calculate_total;
end //
delimiter;

--si perawat kaktus mau liat stoknya, nama stok status, 0 habis, 1-5: menipis, 6 keatas aman, kalo pas dicari idnya ga ada, tampilin langsung pesan kaktus dicuri
delimiter //
create procedure stock_status(in p_id char(4))
begin
declare status_nama varchar(30);
declare status_stock int;
declare status_avai int;

select count(*) into status_avai 
from produk 
where id_produk = p_id;

if status_avai = 0 THEN
  select 'Cactus Dicuri' as msg;
else
  select nama, stok into status_nama, status_stock from produk where id_produk = p_id;
  if status_stock = 0 THEN
    select status_nama as `Name`, status_stock as Stock, 'Habis' as `Status`;
  elseif status_stock between 1 and 5 THEN
    select status_nama as `Name`, status_stock as Stock, 'Menipis' as `Status`;
  ELSE
    select status_nama as `Name`, status_stock as Stock, 'Aman' as `Status`;
  end if;
end if;
end //
delimiter ;

call stock_status('P001'); -- Aman
call stock_status('P004'); -- Habis
call stock_status('P999'); -- Dicuri

-- while loop, stok kaktus ,ganjil genap prima
