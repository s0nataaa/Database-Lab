--ORDER DATABASE--
CREATE DATABASE order_db;

use order_db;

CREATE Table `Order` (
    IDOrder VARCHAR(5) PRIMARY KEY,
    NomorMeja VARCHAR(3) NOT NULL,
    JamMasuk TIME NOT NULL,
    JamKeluar TIME NOT NULL
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

--Helping Command--
SHOW TABLES;

SELECT * FROM `Order`;
SELECT * FROM Menu;
SELECT * FROM OrderDetail;

DESCRIBE `Order`;
DESCRIBE Menu;
DESCRIBE OrderDetail;