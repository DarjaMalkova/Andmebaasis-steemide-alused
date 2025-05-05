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
