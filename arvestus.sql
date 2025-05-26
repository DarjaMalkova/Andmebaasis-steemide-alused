CREATE DATABASE opilaneTiT;
USE opilaneTiT;

GRANT CREATE TABLE TO opilaneDarja;
GRANT SELECT, INSERT ON SCHEMA::dbo TO opilaneDarja;

CREATE TABLE Isik(
isiku_id integer,
eesnimi varchar(50),
perenimi varchar(50) Unique,
sugu char(1),
sunnikuupaev date,
aadress varchar(100),
email varchar(50)
);

SELECT * FROM Isik;
DROP TABLE Õppeaine;

CREATE TABLE Õppeaine(
oppeaine_id integer,
eesnimi varchar(100),
vastutav_opetaja integer,
aine_keskus varchar(50)
);

SELECT * FROM Õppeaine;

CREATE TABLE Õppimine(
oppimineID int Primary Key identity(1,1),
isiku_id integer,
oppeaine_id integer,
hinne integer
);

SELECT * FROM Õppimine;

CREATE TABLE logi(
id int primary key identity(1,1),
kuupaev date,
kasutaja varchar(25),
sisestatudAndmed TEXT
);

SELECT * FROM logi;

CREATE TRIGGER tr_oppimine_update
ON Õppimine
AFTER UPDATE
AS
BEGIN
    INSERT INTO logi (kuupaev, kasutaja, sisestatudAndmed)
    SELECT 
        GETDATE(),
        SYSTEM_USER,
        'Muudeti hinne: ' + CAST(d.hinne AS VARCHAR) + ' → ' + CAST(i.hinne AS VARCHAR)
    FROM inserted i
    JOIN deleted d ON i.oppimineID = d.oppimineID
    WHERE i.hinne <> d.hinne;
END;

INSERT INTO Õppimine (isiku_id, oppeaine_id, hinne)
VALUES (1, 101, 4),
       (2, 102, 3);

SELECT * FROM logi;

CREATE TRIGGER tr_oppimine_insert
ON Õppimine
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (kuupaev, kasutaja, sisestatudAndmed)
    SELECT 
        GETDATE(),
        SYSTEM_USER,
        'Lisati hinne: ' + CAST(hinne AS VARCHAR) +
        ', isiku_id=' + CAST(isiku_id AS VARCHAR) +
        ', oppeaine_id=' + CAST(oppeaine_id AS VARCHAR)
    FROM inserted;
END;

UPDATE Õppimine
SET hinne = 5
WHERE isiku_id = 1 AND oppeaine_id = 101;

BEGIN TRANSACTION;
SELECT * FROM Isik;

INSERT INTO Isik (eesnimi, perenimi, sugu, sunnikuupaev, aadress, email )
VALUES ('Jana', 'Silm', 'N', '2001-06-25', 'kuldnoka 18', 'silm@gmail.com');

SAVE TRANSACTION MySavePoint;

ROLLBACK TRANSACTION MySavePoint;
SELECT * FROM Isik;
