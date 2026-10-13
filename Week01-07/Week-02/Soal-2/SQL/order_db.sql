--ORDER DATABASE--
CREATE DATABASE order_db;

use order_db;

CREATE Table `Order` (
    IDOrder VARCHAR(5) PRIMARY KEY,
    NomorMeja VARCHAR(3) NOT NULL,
    JamMasuk VARCHAR(5) NOT NULL,
    JamKeluar VARCHAR(5) NULL
);

CREATE Table Menu (
    IDMenu VARCHAR(5) PRIMARY KEY,
    NamaMenu VARCHAR(30) NOT NULL,
    Kategori VARCHAR(20) NOT NULL,
    Harga INT NOT NULL
);

CREATE Table OrderDetail (
    IDOrder VARCHAR(5),
    IDMenu VARCHAR(5),
    PRIMARY KEY(IDOrder, IDMenu),
    Foreign Key (IDOrder) REFERENCES `Order`(IDOrder),
    Foreign Key (IDMenu) REFERENCES Menu(IDMenu)
);

INSERT INTO `Order` (`IDOrder`, `NomorMeja`, `JamMasuk`, `JamKeluar`)
VALUES
    ('OD001', '1', '10.00', '11.00'),
    ('OD002', '2', '11.00', '13.00'),
    ('OD003', '1', '15.00', '15.30'),
    ('OD004', '1', '15.00', '15.30');

INSERT INTO Menu (`IDMenu`, `NamaMenu`, `Kategori`, `Harga`)
VALUES
    ('MN001', 'Nasi Putih', 'Makanan Pokok', 5000),
    ('MN002', 'Tahu Goreng', 'Lauk', 4000),
    ('MN003', 'Air Mineral', 'Minuman', 3000),
    ('MN004', 'Ayam Goreng', 'Lauk', 15000);

INSERT INTO OrderDetail (`IDOrder`, `IDMenu`)
VALUES
    ('OD001', 'MN001'),
    ('OD001', 'MN002'),
    ('OD001', 'MN003'),
    ('OD002', 'MN001'),
    ('OD002', 'MN004'),
    ('OD003', 'MN002'),
    ('OD004', 'MN004');

--Helping Command--
SHOW TABLES;

SELECT * FROM `Order`;
SELECT * FROM Menu;
SELECT * FROM OrderDetail;

DESCRIBE `Order`;
DESCRIBE Menu;
DESCRIBE OrderDetail;