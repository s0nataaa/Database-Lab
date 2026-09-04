create DATABASE pemilu_db;
use pemilu_db;

create Table Calon (
    ID_Calon VARCHAR(5) PRIMARY KEY,
    nama_calon VARCHAR(50)
);

create table Pemilih (
    ID_Pemilih VARCHAR(5) PRIMARY KEY,
    nama_pemilih VARCHAR(50),
    nomor_telepon_penduduk VARCHAR(7)
);

create Table Pemilihan (
    ID_Calon VARCHAR(5),
    ID_Pemilih VARCHAR(5),
    PRIMARY KEY (ID_Calon, ID_Pemilih),
    Foreign Key (ID_Calon) REFERENCES Calon(ID_Calon),
    Foreign Key (ID_Pemilih) REFERENCES Pemilih(ID_Pemilih)
);

INSERT into Calon (`ID_Calon`, `nama_calon`) 
VALUES
    ("PR001", "Dennis Wicaksana"),
    ("PR002", "Arya Gunawan");

INSERT into Pemilih (`ID_Pemilih`, `nama_pemilih`, `nomor_telepon_penduduk`) 
VALUES
    ("PD001", "Anna", "2031203"),
    ("PD002", "Sukijah", "2301223"),
    ("PD004", "Kiri", "2033012"),
    ("PD003", "Kana", "2334059"),
    ("PD005", "Okta", "9332333");

INSERT into Pemilihan (`ID_Calon`, `ID_Pemilih`) 
VALUES
    ("PR001", "PD001"),
    ("PR002", "PD002"),
    ("PR001", "PD004"),
    ("PR002", "PD003"),
    ("PR002", "PD005");

#--Helping Command--
SHOW TABLES;

DESCRIBE calon;
DESCRIBE pemilih;
DESCRIBE pemilihan;

SELECT * FROM Calon;
SELECT * FROM Pemilih;
SELECT * FROM Pemilihan;

