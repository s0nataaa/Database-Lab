-- Active: 1787924397092@@127.0.0.1@3306@db_krs
use db_krs;

select * from mahasiswa

alter Table mahasiswa add (
    program_studi VARCHAR(50),
    semester_mahasiswa INT
);

describe mahasiswa;

SELECT * FROM mahasiswa;

CREATE Table dosen (
    nip_dosen char(10) PRIMARY KEY,
    nama_dosen VARCHAR(50) not null
);

CREATE TABLE Mata_Kuliah (
    kode_mk CHAR(5) PRIMARY KEY,
    nama_mk VARCHAR(50) NOT NULL,
    sks INT NOT NULL,
    kuota_kelas INT NOT NULL
);

CREATE TABLE KRS (
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

ALTER TABLE mahasiswa
ADD CONSTRAINT check_semester CHECK (
    semester_mahasiswa >= 1 AND semester_mahasiswa <= 14
);


SELECT * FROM Mahasiswa;
SELECT * FROM Mata_Kuliah;
SELECT * FROM Dosen;
SELECT * FROM KRS;

INSERT INTO mahasiswa (nim_mahasiswa, nama_mahasiswa, program_studi, semester_mahasiswa) 
VALUES ('163633', 'Budi Santoso', 'Informatika', 3);

INSERT INTO mahasiswa (nim_mahasiswa, nama_mahasiswa, program_studi, semester_mahasiswa) 
VALUES ('163634', 'Siti Aminah', 'Sistem Informasi', 20);