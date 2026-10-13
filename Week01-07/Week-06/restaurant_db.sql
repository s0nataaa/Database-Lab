-- Active: 1787924397092@@127.0.0.1@3306@restaurant
create database restaurant;
use restaurant;

create TABLE employee (
    id_employee VARCHAR(5) PRIMARY KEY,
    nama_depan VARCHAR(30),
    nama_belakang VARCHAR(30),
    jabatan VARCHAR(30),
    alamat VARCHAR (30),
    email VARCHAR(30),
    nomor_telepon VARCHAR(15),
    gaji INT
);

CREATE Table customer (
    id_customer VARCHAR(5) PRIMARY KEY,
    nama_depan VARCHAR(30),
    nama_belakang VARCHAR(30),
    alamat VARCHAR(30),
    email VARCHAR(30),
    nomor_telepon VARCHAR(15)
);

CREATE Table paket (
    id_paket VARCHAR(5) PRIMARY KEY,
    harga_paket INT
);

create Table menu (
    ID_Menu VARCHAR(5) primary KEY,
    nama_menu VARCHAR(30),
    jenis_menu VARCHAR(20),
    id_paket VARCHAR(5),
    Foreign Key (id_paket) REFERENCES paket(id_paket)
);

CREATE TABLE `transaction` (
    id_customer VARCHAR(5),
    id_employee VARCHAR(5),
    id_paket VARCHAR(5),
    transaction_date DATE,
    PRIMARY KEY (id_customer, id_paket, id_employee),
    FOREIGN KEY (id_customer) REFERENCES customer(id_customer),
    FOREIGN KEY (id_paket) REFERENCES paket(id_paket),
    FOREIGN KEY (id_employee) REFERENCES employee(id_employee)
);

INSERT INTO employee VALUES
('E0001', 'Anthony', NULL, 'Manager', '70 Coly Guy', 'anthony@umn.ac.id', '123-456-4565', 5000000),
('E0002', 'Akino', 'Archilles', 'Chef', '21 Kino Kino', 'akino@student.com', '354-124-5786', 3500000),
('E0003', 'Kevin', 'Alexander', 'Cashier', '34 Nishinoya', 'alex@yahoo.com', '098-123-7832', 3000000),
('E0004', 'Ivy', 'Marcia', 'Chef', '06 Wall Street', 'ivy@yahoo.com', '846-732-8427', 3500000),
('E0005', 'Martha', 'Saphia', 'Customer Service', '78 Ruby Fort', 'martha@umn.ac.id', '718-298-2873', 3200000),
('E0006', 'Nofiandy', NULL, 'Cashier', '03 Smooth Hair', 'nofiandy@gmail.com', '516-927-9268', 3250000),
('E0007', 'Octavany', NULL, 'Cashier', '23 Relaxing Cafe', 'octa@iseng.com', '654-876-1928', 3150000);

INSERT INTO customer VALUES
('C0001', 'Michael', 'Oswin', '125 Laugh Land', 'oswin@yahoo.com', '745-387-2874'),
('C0002', 'Anna', 'Jeane', '163 Lolita Land', 'anna@gmail.com', '982-397-4862'),
('C0003', 'Raymond', NULL, '287 Chucky Suburb', 'raymond@gmail.com', '917-376-4672'),
('C0004', 'Theodore', 'Mulia', '287 Idea Annex', 'mulia@gmail.com', '122-187-1111'),
('C0005', 'Niki', 'Emersan', '297 Cult Annex', 'niki@yahoo.com', '198-292-2223'),
('C0006', 'Christine', 'Liviani', '275 Love Annex', 'liviani@live.com', '000-198-2836'),
('C0007', 'Hermawan', NULL, '212 Tall Building', 'hermawan@yahoo.com', '192-168-1001'),
('C0008', 'Agung', NULL, '293 Short Building', 'agung@yahoo.com', '192-168-1993'),
('C0009', 'Samuel', 'Sandro', '206 Oppa Annex', 'sam@live.com', '192-168-2973'),
('C0010', 'Kennard', 'Alcander', '202 Brother Annex', 'ken@live.com', '198-782-3864');

INSERT INTO paket VALUES
('P0001', 3000000),
('P0002', 2500000),
('P0003', 2000000);

INSERT INTO menu VALUES
('M0001', 'Nasi Goreng Cinta', 'Makanan', 'P0001'),
('M0002', 'Ayam Bumbu PHP', 'Makanan', 'P0002'),
('M0003', 'Soto Daging CPP', 'Makanan', 'P0003'),
('M0004', 'Siomay Pak BoBi', 'Makanan', 'P0001'),
('M0005', 'Blue Integer', 'Minuman', 'P0001'),
('M0006', 'Mocha Float', 'Dessert', 'P0003'),
('M0007', 'Choco Banana Split', 'Dessert', 'P0002'),
('M0008', 'Es Teh Panas', 'Minuman', 'P0002'),
('M0009', 'Nasi Micin', 'Makanan', 'P0002'),
('M0010', 'Sapi Chabe', 'Makanan', 'P0003');

INSERT INTO `transaction` VALUES
('C0001', 'E0002', 'P0003', '2016-02-25'),
('C0002', 'E0001', 'P0002', '2016-03-12'),
('C0003', 'E0002', 'P0002', '2016-04-10'),
('C0004', 'E0004', 'P0001', '2016-06-28'),
('C0005', 'E0001', 'P0002', '2016-03-30'),
('C0006', 'E0003', 'P0003', '2016-03-10'),
('C0007', 'E0005', 'P0001', '2016-03-01'),
('C0008', 'E0002', 'P0002', '2016-08-30'),
('C0009', 'E0002', 'P0003', '2016-11-02'),
('C0010', 'E0005', 'P0001', '2016-08-18');

-- 7. Display Menu Table
SELECT * FROM menu; 

-- 8. Display Cashier nama depan & belakang, pake query name
SELECT nama_depan AS 'Nama Depan', nama_belakang AS 'Nama Belakang' 
FROM employee WHERE jabatan = 'Cashier';

-- 9. Display id_paket, harga_awal, harga akhir after discounted 30%
SELECT id_paket as 'ID Paket', harga_paket as 'Harga Awal', truncate(harga_paket * 0.7, 0) as 'Harga Akhir' from paket;

-- 10. Display Rp. total gaji karyawan, pake concat
select concat('Rp. ', sum(gaji)) as 'Total Gaji' from employee;

-- 11. Nama Depan, Nama Belakang, Jabatan, yahoo email
select nama_depan AS 'Nama Depan', nama_belakang AS 'Nama Belakang', jabatan as 'Jabatan', email as 'Email' 
from employee where email like '%@yahoo.com';

-- 12. Tampilkan Nama Depan, Nama Belakang, Jabatan, dan gaji < 3800000
select nama_depan AS 'Nama Depan', nama_belakang AS 'Nama Belakang', jabatan as 'Jabatan', gaji as 'Gaji'
FROM employee where gaji < 3800000;

-- 13. display nama depan, nama belakang, concat namadepan@restoswin.rs.id
select nama_depan as 'Nama Depan', nama_belakang as 'Nama Belakang', concat(lower(nama_depan), '@restoswin.rs.id') as 'Email Khusus'
from employee;

-- 14. Display nama_gabungan = left nama_depan 4, mid alamat 2 -1 where mid notelp 5, 1 in 1 or 7
SELECT concat(LEFT(nama_depan, 4), SUBSTRING_INDEX(SUBSTRING_INDEX(alamat, ' ', 2),' ', -1)) as 'Nama Gabungan' 
from customer where MID(nomor_telepon, 5, 1) in ('1', '7');
-- Display siapa aja nama yang punya digit pertama nomor tengah adalah 1 atau 7
select nama_depan, nomor_telepon from customer where mid(nomor_telepon, 5, 1) in('1', '7');

-- 15. Display Hashing, Nyoba Subquery
SELECT concat(i, REVERSE(i)) as 'Hashing' 
    from (
        select CONCAT(LEFT(LOWER(trim(nama_menu)), 2), RIGHT(lower(trim(nama_menu)), 3)) as i
        from menu where jenis_menu like 'makanan'
) as j;

-- 16. Display nama + gaji repeat($, #)
SELECT concat(nama_depan, ' ', nama_belakang)as 'Nama', 
    concat(
        repeat('$', gaji div 200000), repeat('#', (gaji mod 200000) div 10000)
        ) as 'Gaji'
from employee where nama_belakang is not NULL;

