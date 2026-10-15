create database resto;
SELECT database();
use resto;

CREATE Table Menu (
    id_menu VARCHAR(5) PRIMARY KEY,
    nama_menu VARCHAR(30),
    jenis_menu VARCHAR(20),
    id_paket VARCHAR(5)
);

create Table paket (
    id_paket VARCHAR(5) PRIMARY KEY,
    harga_paket int
);

CREATE Table employee (
    id_employee VARCHAR(5) PRIMARY KEY,
    nama_depan VARCHAR(30),
    nama_belakang VARCHAR(30),
    jabatan VARCHAR(30),
    alamat VARCHAR(30),
    email VARCHAR(30),
    nomor_telepon VARCHAR(15),
    gaji int
);

CREATE Table customer (
    id_customer VARCHAR(5) PRIMARY KEY,
    nama_depan VARCHAR(30),
    nama_belakang VARCHAR(30),
    alamat VARCHAR(30),
    email VARCHAR(30),
    nomor_telepon VARCHAR(15)
);

create Table `transaction` (
    id_customer VARCHAR(5),
    id_paket VARCHAR(5),
    id_employee VARCHAR(5),
    transaction_date DATE,
    PRIMARY KEY(id_customer, id_paket, id_employee),
    Foreign Key (id_customer) REFERENCES customer(id_customer),
    Foreign Key (id_paket) REFERENCES paket(id_paket),
    Foreign Key (id_employee) REFERENCES employee(id_employee)
);

INSERT INTO employee (id_employee, nama_depan, nama_belakang, jabatan, alamat, email, nomor_telepon, gaji) VALUES
('E0001', 'Sax', 'Fucelli', 'Manager', '04 Numero Quatro', 'sax@yahoo.com', '084-4444-4444', 10000000),
('E0002', 'Smitty', 'Werbenmanjensen', 'Customer Service', '01 Under Sea', 'smitty@gmail.com', '081-111-1111', 5000000),
('E0003', 'Maximillion', 'Pegasus', 'Cashier', '18 Duelist kingdom', 'maximillion@live.com', '083-171-1377', 2000000),
('E0004', 'Oktavia', 'Seckendorff', 'Chef', '70 Under World', 'oktavia@yahoo.com', '085-120-8753', 3000000),
('E0005', 'Frejya', 'Wion', 'Chef', '05 Walkure Space', 'freya@gmail.com', '088-237-6718', 3500000),
('E0006', 'Won', '', 'Chef', '23 Harvest Moon', 'won@live.com', '089-671-0283', 3750000),
('E0007', 'Barney', '', 'Cashier', '45 Dino Street', 'barney@yahoo.com', '087-332-9716', 2500000);

INSERT INTO customer (id_customer, nama_depan, nama_belakang, alamat, email, nomor_telepon) VALUES
('C0001', 'Santa', 'Monica', '232 Database Annex', 'santa@live.com', '083-221-8762'),
('C0002', 'Sil', 'Eighty', '80 Downhill Building', 'sil@gmail.com', '082-123-0938'),
('C0003', 'Chandra', 'Nalaar', '191 Magic Land', 'chandra@yahoo.com', '089-382-8371'),
('C0004', 'Gideon', 'Zura', '202 Indes Annex', 'gideon@live.com', '084-829-3882'),
('C0005', 'Strygwyr', '', '147 Bloody Annex', 'strygwyr@gmail.com', '081-826-2372'),
('C0006', 'Mogul', 'Kahn', '182 ex Building', 'mogul@yahoo.com', '085-562-7782'),
('C0007', 'John', 'Cena', '92 Smack Land', 'john@live.com', '086-829-9283'),
('C0008', 'Budi', '', '141 Wonder Land', 'budi@gmail.com', '087-927-8263'),
('C0009', 'Immelman', '', '220 Plane Building', 'immelman@yahoo.com', '088-283-9372'),
('C0010', 'Datboi', '', '31 Frog Annex', 'datboi@gmail.com', '081-028-0373');

INSERT INTO paket (id_paket, harga_paket) VALUES
('P0001', 3000000),
('P0002', 2500000),
('P0003', 2000000);

INSERT INTO Menu (id_menu, nama_menu, jenis_menu, id_paket) VALUES
('M0001', 'Nasi Kecap', 'Makanan', 'P0001'),
('M0002', 'Soda Mentos', 'Minuman', 'P0002'),
('M0003', 'Es Krim Panas', 'Dessert', 'P0003'),
('M0004', 'Ayam Om', 'Makanan', 'P0002'),
('M0005', 'Teh Pedas', 'Minuman', 'P0001'),
('M0006', 'Giga Pudding', 'Dessert', 'P0002'),
('M0007', 'Nasi UMN', 'Makanan', 'P0003'),
('M0008', 'Kopi Setarbak', 'Minuman', 'P0003'),
('M0009', 'Kue Rebus', 'Dessert', 'P0001'),
('M0010', 'Gudetama', 'Dessert', 'P0001');

INSERT INTO `transaction` (id_customer, id_employee, id_paket, transaction_date) VALUES
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

----show nama customer and order by ascending---
SELECT CONCAT(nama_depan, ' ', nama_belakang) as `Nama Customer` 
from customer
ORDER BY `nama Customer` ASC;

----show bulan dan jumlah dari tiap transaksi-----
SELECT MONTHNAME(transaction_date) as Bulan, COUNT(*) as Jumlah 
from `transaction`
GROUP BY MONTH(transaction_date);

----show nama dan gaji karyawan yang memiliki gaji terendah dengan email gmail----
SELECT CONCAT(nama_depan, ' ', nama_belakang) as Nama, gaji as Gaji
from employee where email like '%@gmail.com'
AND gaji = (SELECT MIN(gaji) FROM employee where email like '%@gmail.com');

---show id_employee, banyak transaksi, jadwal transaksi AND pekerja minimal 1 transaksi, order by desc---
SELECT id_employee as `Kode Pekerja`, 
COUNT(*) as `Banyak Transaksi`,
GROUP_CONCAT(
    CONCAT(DAY(transaction_date), ' ', MONTHNAME(transaction_date), ' ', YEAR(transaction_date))
    ) as `Jadwal Transaksi`
from `transaction`
group by id_employee
having count(id_employee) >= 1
ORDER BY `Banyak Transaksi` DESC;

---show jumlah penggunail email from employee---
select
COUNT(CASE WHEN email LIKE '%@gmail.com' THEN 1 END) as Google,
COUNT(CASE WHEN email LIKE '%@live.com' THEN 1 END) as Live,
COUNT(CASE WHEN email LIKE '%@yahoo.com' THEN 1 END) as Yahoo
from employee;

---show nama karyawan yang pernah bertransaksi, order by nama asc---
select DISTINCT CONCAT(nama_depan, ' ', nama_belakang) as Nama
from employee e
join `transaction` t on e.id_employee = t.id_employee
ORDER BY nama asc;  

---show trans_date, desc if trans_date < april 2016 = transaksi lama else if trans_date >= mei 2016 = transaksi baru---
select 
DATE_FORMAT(transaction_date, '%d %M %Y') AS `Waktu Transaksi`,
case 
when transaction_date < '2016-05-01' AND transaction_date >= '2016-03-01' then 'Transaksi Lama'
when transaction_date >= '2016-05-01' AND transaction_date < '2016-09-01' then 'Transaksi Baru'
end as `Kategori Waktu Transaksi`
from `transaction`
having `Kategori Waktu Transaksi` IS NOT NULL
order by transaction_date asc, `Kategori Waktu Transaksi` desc;

--show limit 1 customer dengan nama terpanjang---
SELECT CONCAT(nama_depan, ' ', nama_belakang) as Nama
from customer
order by CHARACTER_LENGTH(Nama) desc
limit 1;

---show employee name char len asc---
SELECT CONCAT(nama_depan, ' ', nama_belakang) as Nama
from employee
order by CHARACTER_LENGTH(Nama) ASC;

--- show employee, customer list, total pendapatan---
SELECT CONCAT(e.nama_depan, ' ', e.nama_belakang) as `Nama Karyawan`,
GROUP_CONCAT(
    if(
        c.nama_belakang = '',
        c.nama_depan,
        CONCAT(c.nama_depan, ' ', c.nama_belakang)
    )
    SEPARATOR ', '
) as `Nama Customer`,

SUM(p.harga_paket) as Harga

from `transaction` t
join customer c on t.id_customer = c.id_customer
join employee e on t.id_employee = e.id_employee
join paket p on t.id_paket = p.id_paket
group by e.id_employee
order BY Harga desc
limit 1;


---hashing---
SELECT
LOWER(CONCAT(i, penapple, alamatReplace)) AS Hashing
FROM (
    SELECT i, penapple, newAlamat,
        CASE
            WHEN MOD(CHAR_LENGTH(newAlamat), 3) = 0
                THEN LEFT(REVERSE(newAlamat), 4)
            WHEN MOD(CHAR_LENGTH(newAlamat), 3) = 1
                THEN newAlamat
            ELSE REVERSE(newAlamat)
        END AS alamatReplace
    FROM (
        SELECT
            REVERSE(LEFT(LOWER(nama_depan), 3)) AS i,
            CASE
                WHEN MOD(CHAR_LENGTH(CONCAT(nama_depan, nama_belakang)), 3) = 0
                    THEN 'pen'
                WHEN MOD(CHAR_LENGTH(CONCAT(nama_depan, nama_belakang)), 3) = 1
                    THEN 'apple'
                ELSE 'pineapple'
            END AS penapple,
            SUBSTRING_INDEX(SUBSTRING_INDEX(LOWER(alamat), ' ', 2), ' ', -1) AS newAlamat
        FROM customer
    ) AS data_customer
) hash
ORDER BY Hashing;


