CREATE DATABASE MalkovaTiT;
--Object Explorer on vaja pidevalt uuendada käsitsi!
USE MalkovaTiT;

--tabeli loomine
CREATE TABLE opilane(
opilaneID int Primary Key identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) Unique,
synniaeg date,
aadress TEXT,
opilaskodu bit
);
SELECT * FROM opilane;

--tabeli kustutamine
DROP table opilane;

--andmete lisamine tabelisse
INSERT INTO opilane(eesnimi, perenimi, synniaeg, aadress, opilaskodu)
VALUES ('Andrei', 'Ivanov', '2005-12-5', 'Tallinn', 1),
('Mati', 'Kask', '2003-12-5', 'Tallinn', 0),
('Peeter', 'Uus', '2000-10-5', 'Tallinn', 0);

CREATE TABLE ryhm(
ryhmID int not null primary key identity(1,1),
ryhm varchar(10) unique,
osakond varchar(20)
);
INSERT INTO ryhm(ryhm, osakond)
Values('TITpv24', 'IT'),('KRRpv23','Rätsepp');

Select * from ryhm;
--lisame uus veerg RyhmID tabelisse opilane
ALTER TABLE opilane ADD ryhmID int;

Select *  from opilane;

--lisame foreign key veergule ryhmID mis on seotud
--tabeliga ryhm ja veerguga ryhmID
ALTER TABLE opilane 
Add foreign key (ryhmID) references ryhm(ryhmID);

--foreign key kontroll
INSERT INTO opilane
(eesnimi, perenimi, synniaeg, aadress, opilaskodu, ryhmID)
VALUES ('Andrei', 'Ivanovssss', '2005-12-5', 'Tallinn', 1, 3);

SELECT * FROM opilane;
--kasutame seos tabelite vahel - JOIN
SELECT * FROM opilane JOIN ryhm
ON opilane.ryhmID=ryhm.ryhmID;

SELECT opilane.perenimi, ryhm.ryhm FROM opilane JOIN ryhm
ON opilane.ryhmID=ryhm.ryhmID;

--lihtsaim vaade
SELECT o.perenimi, r.ryhm, o.aadress
FROM opilane o JOIN ryhm r
ON o.ryhmID=r.ryhmID;

--tabel hinne 
CREATE TABLE hinne(
hinneID int primary key identity(1,1),
hinne int,
opilaneID int,
oppeaine varchar(50)
);

ALTER TABLE hinne
ADD foreign key (opilaneID) references opilane (opilaneID);

INSERT INTO hinne(opilaneID, oppeaine, hinne)
Values(3, 'andmebaasid', 3);
SELECT * FROM hinne;

CREATE TABLE opitaja(
opitajaID int Primary Key identity(1,1),
eesnimi varchar(25),
perenimi varchar(30) Unique,
telefon TEXT,
);

INSERT INTO opitaja(eesnimi, perenimi, telefon)
VALUES ('Jekaterina', 'Rätsep', '37256794678')

SELECT * FROM opitaja
