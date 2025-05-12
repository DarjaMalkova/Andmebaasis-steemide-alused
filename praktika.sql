CREATE DATABASE praktikabaasMalkova;
USE praktikabaasMalkova;
CREATE TABLE firma (
firmaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
firmanimi VARCHAR(20) unique,
aadress VARCHAR(20),
telefon VARCHAR(20)
);

insert into firma (firmanimi, aadress, telefon) values ('Devbug', '10 Glendale Alley', '784-246-4831');
insert into firma (firmanimi, aadress, telefon) values ('Bubbletube', '37 Elmside Place', '840-265-8178');
insert into firma (firmanimi, aadress, telefon) values ('Centizu', '1 Maple Point', '101-780-9377');
insert into firma (firmanimi, aadress, telefon) values ('Skipfire', '840 Algoma Crossing', '262-773-1828');
SELECT * FROM firma

create table praktikajuhendaja (
	praktikajuhendajaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	eesnimi VARCHAR(50),
	 perekonnanimi VARCHAR(50),
	synniaeg DATE,
	telefon VARCHAR(50)
);

insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Florette', 'Ilsley', '6/10/2000', '654-351-3458');
insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Carlin', 'Corben', '9/9/2000', '384-115-1422');
insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Marie-ann', 'MacKim', '10/19/2000', '645-323-2421');
insert into praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) values ('Hermia', 'Freemantle', '9/14/2000', '945-443-6579');
SELECT * FROM praktikajuhendaja

CREATE TABLE praktikabaas (
praktikabaasID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
firmaID INT,
praktikatingimused VARCHAR(20),
arvutiprogramm VARCHAR(20),
juhendajaID INT,
FOREIGN KEY (firmaID) REFERENCES firma(firmaID),
FOREIGN KEY (juhendajaID) REFERENCES praktikajuhendaja(praktikajuhendajaID)
);

INSERT INTO praktikabaas (praktikatingimused, arvutiprogramm)
VALUES 
('turundus', 'Canva'),
('programmeerinine', 'IntelliJ IDEA'),
('andmesisestus', 'Access'),
('projektijuhtimine', 'Trello');

SELECT * FROM praktikabaas

CREATE TABLE Praktikabaas_logi(
id int primary key identity(1,1),
tegevus varchar(25),
kasutaja varchar(25),
aeg datetime,
andmed TEXT
);

CREATE TRIGGER praktikabaasLisamine
ON praktikabaas
FOR INSERT 
AS
INSERT INTO Praktikabaas_logi(kasutaja, tegevus, aeg, andmed)
SELECT 
SYSTEM_USER,
'praktikabaas on lisatud',
GETDATE(),
CONCAT (firma.firmanimi, ',' ,firma.aadress, ',' , ',' ,praktikajuhendaja.perekonnanimi, ',' ,praktikajuhendaja.eesnimi, ',' ,inserted.praktikatingimused, ',' ,inserted.arvutiprogramm)
FROM inserted
inner join firma on inserted.firmaID=firma.firmaID
inner join praktikajuhendaja on inserted.juhendajaID=praktikajuhendaja.praktikajuhendajaID;
SELECT * FROM praktikabaas;
SELECT * FROM Praktikabaas_logi;



DROP TRIGGER firmaLisamine

CREATE TRIGGER praktikabaasKustutamine
ON praktikabaas
FOR DELETE 
AS
INSERT INTO Praktikabaas_logi(kasutaja, tegevus, aeg, andmed)
SELECT 
SYSTEM_USER,
'baas on kustutatud',
GETDATE(),
CONCAT (deleted.praktikatingimused, ',' ,deleted.arvutiprogramm)
FROM deleted;
DELETE FROM praktikabaas WHERE praktikabaasID = 1;
SELECT * FROM praktikabaas;
SELECT * FROM Praktikabaas_logi;

DROP TRIGGER praktikabaasKustutamine

CREATE TRIGGER trg_Check_Juhendaja_Synniaeg
ON praktikajuhendaja
INSTEAD OF INSERT
AS
BEGIN
IF EXISTS (SELECT 1 FROM inserted WHERE synniaeg > GETDATE())
BEGIN
RAISERROR('Sünniaeg ei tohi olla tulevikus.', 16, 1);
END
ELSE
BEGIN
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
SELECT eesnimi, perekonnanimi, synniaeg, telefon
FROM inserted;
END
END;
