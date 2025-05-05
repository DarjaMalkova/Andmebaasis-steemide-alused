CREATE DATABASE praktikabaasMalkova;
USE praktikabaasMalkova;
CREATE TABLE firma (
firmaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
firmanimi VARCHAR(20) unique,
aadress VARCHAR(20),
telefon VARCHAR(20)
);

insert into firma (firmaID, firmanimi, aadress, telefon) values (1, 'Twimbo', '297 Independence Lane', '359-418-6019');
insert into firma (firmaID, firmanimi, aadress, telefon) values (2, 'Thoughtmix', '8173 Mayfield Court', '693-624-0811');
insert into firma (firmaID, firmanimi, aadress, telefon) values (3, 'Flashset', '20 Springview Lane', '109-822-3305');
insert into firma (firmaID, firmanimi, aadress, telefon) values (4, 'Gevee', '46997 Merchant Center', '492-763-9127');
insert into firma (firmaID, firmanimi, aadress, telefon) values (5, 'Jabberbean', '01936 Fisk Trail', '509-259-9482');

create table praktikajuhendaja (
	praktikajuhendajaID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	eesnimi VARCHAR(50),
	 perekonnanimi VARCHAR(50),
	synniaeg DATE,
	telefon VARCHAR(50)
);

CREATE TABLE praktikabaas (
praktikabaasID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
firmaID INT,
praktikatingimused VARCHAR(20),
arvutiprogramm VARCHAR(20),
juhendajaID INT,
FOREIGN KEY (firmaID) REFERENCES firma(firmaID),
FOREIGN KEY (juhendajaID) REFERENCES praktikajuhendaja(praktikajuhendajaID)
);
