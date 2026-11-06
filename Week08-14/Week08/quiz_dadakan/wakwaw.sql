create database wakwaw;
show databases;
use wakwaw;

CREATE TABLE village (
  id_village   CHAR(3) PRIMARY KEY,
  nama_village VARCHAR(30),
  biome     VARCHAR(20)
);

CREATE TABLE player (
  id_player     CHAR(4) PRIMARY KEY,
  username      VARCHAR(30),
  peran         VARCHAR(20),
  saldo_emerald INT,
  id_village       CHAR(3),
  FOREIGN KEY (id_village) REFERENCES village(id_village)
);

CREATE TABLE item (
  id_item       CHAR(4) PRIMARY KEY,
  nama_item     VARCHAR(30),
  kategori      VARCHAR(20),
  harga_emerald INT
);

CREATE TABLE transaksi_toko (
  id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
  tanggal      DATE,
  id_player    CHAR(4),
  id_item      CHAR(4),
  jumlah       INT,
  FOREIGN KEY (id_player) REFERENCES player(id_player),
  FOREIGN KEY (id_item) REFERENCES item(id_item)
);

INSERT INTO village VALUES
('D01','Padang Rumput','Plains'),
('D02','Gurun Pasir','Desert'),
('D03','Lembah Salju','Snowy Taiga');

INSERT INTO player VALUES
('P001','Steve','Walikota',900,'D01'),
('P002','Alex','Penambang',500,'D01'),
('P003','Villager_Bob','Pedagang',450,'D01'),
('P004','Creeper_Slayer','Walikota',850,'D02'),
('P005','Enderman_X','Penambang',480,'D02'),
('P006','Pixel_Pete','Pedagang',430,'D02'),
('P007','Zombie_Hunter','Penambang',470,'D03'),
('P008','Notch_Jr','Pedagang',420,'D03');

INSERT INTO item VALUES
('I001','Pedang Besi','Senjata',18),
('I002','Busur','Senjata',28),
('I003','Trident','Senjata',30),
('I004','Elytra','Armor',32),
('I005','Apel Emas','Makanan',22),
('I006','Obsidian','Material',25),
('I007','Berlian','Material',27),
('I008','Beacon','Material',35);

INSERT INTO transaksi_toko (tanggal,id_player,id_item,jumlah) VALUES
('2026-10-01','P003','I002',2),
('2026-10-01','P003','I006',1),
('2026-10-02','P002','I001',3),
('2026-10-05','P006','I003',2),
('2026-10-05','P006','I007',2),
('2026-10-08','P008','I004',1),
('2026-10-10','P003','I008',2),
('2026-10-12','P005','I005',4),
('2026-11-01','P006','I002',3),
('2026-11-02','P003','I003',1),
('2026-11-03','P008','I006',2),
('2026-11-04','P002','I008',1);

------------------------------
show tables;
describe item;
describe player;
describe transaksi_toko;
describe village;

---------------
create view view_senjata AS
select nama_item, id_item, harga_emerald
from item
WHERE kategori = 'Senjata';

drop view view_senjata;

select * from view_senjata;

create view data_player AS
SELECT p.id_Player, p.username, p.peran, v.nama_village
from player p
join village v on p.id_village = v.id_village;

select * from data_player;

create user 'gavin'@'localhost' IDENTIFIED by 'asoy';
create user 'angel'@'localhost' IDENTIFIED by 'furry';
create user 'tenusa'@'localhost' IDENTIFIED by 'biji_ketapang';

grant select on wakwaw.item TO 'gavin'@'localhost';
grant insert on wakwaw.player TO 'tenusa'@'localhost';
grant update on wakwaw.player TO 'tenusa'@'localhost';


select username from player;

