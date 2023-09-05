CREATE SCHEMA kelas_sql;

use kelas_sql;

CREATE TABLE pegawai(
  id_pegawai INT,
  nama_depan VARCHAR(40),
  nama_belakang VARCHAR(40),
  tgl_lahir DATE,
  gender VARCHAR(1),
  gaji NUMERIC(10, 2),
  id_spv INT,
  id_cabang INT,
  constraint pegawai primary key(id_pegawai)
);

CREATE TABLE cabang (
  id_cabang INT PRIMARY KEY,
  nama_cabang VARCHAR(40),
  id_mgr INT,
  tgl_menjabat DATE,
  FOREIGN KEY(id_mgr) REFERENCES pegawai(id_pegawai) ON DELETE SET NULL
);

ALTER TABLE pegawai
ADD FOREIGN KEY(id_cabang)
REFERENCES cabang(id_cabang)
ON DELETE SET NULL;

ALTER TABLE pegawai
ADD FOREIGN KEY(id_spv)
REFERENCES pegawai(id_pegawai)
ON DELETE SET NULL;

CREATE TABLE klien(
  id_klien INT PRIMARY KEY,
  nama_klien VARCHAR(40),
  id_cabang INT,
  FOREIGN KEY(id_cabang) REFERENCES cabang(id_cabang) ON DELETE SET NULL
);

CREATE TABLE pj_klien(
  id_pegawai INT,
  id_klien INT,
  total_penjualan INT,
  PRIMARY KEY(id_pegawai, id_klien),
  FOREIGN KEY(id_pegawai) REFERENCES pegawai(id_pegawai) ON DELETE CASCADE,
  FOREIGN KEY(id_klien) REFERENCES klien(id_klien) ON DELETE CASCADE
);

CREATE TABLE supplier_cabang(
  id_cabang INT,
  nama_supplier VARCHAR(40),
  tipe_supply VARCHAR(40),
  PRIMARY KEY(id_cabang, nama_supplier),
  FOREIGN KEY(id_cabang) REFERENCES cabang(id_cabang) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Kantor Pusat
INSERT INTO pegawai VALUES(1000, 'Asraf', 'Rumae', '1967-11-17', 'L', 25000000, NULL, NULL);

INSERT INTO cabang VALUES(1, 'Kantor Pusat', 1000, '2006-02-09');

UPDATE pegawai
SET id_cabang = 1
WHERE id_pegawai = 100;

INSERT INTO pegawai VALUES(1001, 'Andi', 'Zulkifli', '1961-05-11', 'L', 11000000, 1000, 1);
INSERT INTO pegawai VALUES(1009, 'Fitriani', NULL, '1968-05-11', 'P', 9000000, 1000, 1);

-- Sumatera
INSERT INTO pegawai VALUES(1002, 'Fais', 'Wahid', '1964-03-15', 'L', 7500000, 1000, NULL);

INSERT INTO cabang VALUES(2, 'Sumatera', 1002, '1992-04-06');

UPDATE pegawai
SET id_cabang = 2
WHERE id_pegawai = 1002;

INSERT INTO pegawai VALUES(1003, 'Fawziah', 'Maswah', '1971-06-25', 'P', 6300000, 1002, 2);
INSERT INTO pegawai VALUES(1004, 'Dessy', 'Putri', '1980-02-05', 'P', 5500000, 1002, 2);
INSERT INTO pegawai VALUES(1005, 'Rahmat', 'Riyadi', '1958-02-19', 'L', 6900000, 1002, 2);

-- Sulawesi
INSERT INTO pegawai VALUES(1006, 'Arif', 'Nasir', '1969-09-05', 'L', 7800000, 1000, NULL);

INSERT INTO cabang VALUES(3, 'Sulawesi', 1006, '1998-02-13');

UPDATE pegawai
SET id_cabang = 3
WHERE id_pegawai = 1006;

INSERT INTO pegawai VALUES(1007, 'Abdul', 'Muin', '1973-07-22', 'L', 6500000, 1006, 3);
INSERT INTO pegawai VALUES(1008, 'Rizky', 'Hidayat', '1978-10-01', 'L', 7100000, 1006, 3);


-- BRANCH SUPPLIER
INSERT INTO supplier_cabang VALUES(2, 'Mufida', 'Kertas');
INSERT INTO supplier_cabang VALUES(2, 'Az-Zahra', 'Alat Tulis');
INSERT INTO supplier_cabang VALUES(3, 'Agung Mart', 'Kertas');
INSERT INTO supplier_cabang VALUES(2, 'Makro', 'Custom Forms');
INSERT INTO supplier_cabang VALUES(3, 'Sama Jaya', 'Alat Tulis');
INSERT INTO supplier_cabang VALUES(3, 'Toko Ira', 'Kertas');
INSERT INTO supplier_cabang VALUES(3, 'Karsa Utama', 'Custom Forms');

-- klien
INSERT INTO klien VALUES(400, 'SMK Bina Mandiri', 2);
INSERT INTO klien VALUES(401, 'Litha & Co', 2);
INSERT INTO klien VALUES(402, 'Garuda Mas', 3);
INSERT INTO klien VALUES(403, 'Polahi Adventure', 3);
INSERT INTO klien VALUES(404, 'Santika', 2);
INSERT INTO klien VALUES(405, 'Salem Jaya', 3);
INSERT INTO klien VALUES(406, 'Garuda Mas', 2);

-- WORKS_WITH
INSERT INTO pj_klien VALUES(1005, 400, 5500000);
INSERT INTO pj_klien VALUES(1002, 401, 26700000);
INSERT INTO pj_klien VALUES(1008, 402, 2250000);
INSERT INTO pj_klien VALUES(1007, 403, 500000);
INSERT INTO pj_klien VALUES(1008, 403, 1200000);
INSERT INTO pj_klien VALUES(1005, 404, 3300000);
INSERT INTO pj_klien VALUES(1007, 405, 2600000);
INSERT INTO pj_klien VALUES(1002, 406, 1500000);
INSERT INTO pj_klien VALUES(1005, 406, 13000000);
