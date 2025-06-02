CREATE DATABASE opilanetit;
USE opilanetit;

GRANT CREATE TABLE TO opilaneDarja;
GRANT CONTROL ON SCHEMA ::dbo TO opilaneDarja;

GRANT INSERT, SELECT ON Isik TO opilaneDarja;
GRANT INSERT, SELECT ON Oppeaine TO opilaneDarja;
GRANT INSERT, SELECT ON Oppimine TO opilaneDarja;


CREATE TABLE Isik (
    isiku_id INTEGER PRIMARY KEY,
    eesnimi VARCHAR(50),
    perenimi VARCHAR(50) UNIQUE,
    sugu CHAR(1),
    sunnikuupaev DATE,
    aadress VARCHAR(100),
    email VARCHAR(50)
);

INSERT INTO Isik (isiku_id, eesnimi, perenimi, sugu, sunnikuupaev, aadress, email)
VALUES (1, 'Mari', 'Tamm', 'N', '2000-01-01', 'Tallinn', 'mari@example.com');


CREATE TABLE Oppeaine (
    oppeaine_id INTEGER PRIMARY KEY,
    eesnimi VARCHAR(100),
    vastutav_opetaja INTEGER,
    aine_keskus VARCHAR(50),
    FOREIGN KEY (vastutav_opetaja) REFERENCES Isik(isiku_id)
);

INSERT INTO Oppeaine (oppeaine_id, eesnimi, vastutav_opetaja, aine_keskus)
VALUES (101, 'Matemaatika', 1, 'Tallinna Kool');


CREATE TABLE Oppimine (
    oppimineID INT PRIMARY KEY IDENTITY(1,1),
    isiku_id INTEGER,
    oppeaine_id INTEGER,
    hinne INTEGER,
    FOREIGN KEY (isiku_id) REFERENCES Isik(isiku_id),
    FOREIGN KEY (oppeaine_id) REFERENCES Oppeaine(oppeaine_id)
);

SELECT I.eesnimi, I.perenimi, O.eesnimi AS oppeaine, Op.hinne
FROM Oppimine Op
JOIN Isik I ON Op.isiku_id = I.isiku_id
JOIN Oppeaine O ON Op.oppeaine_id = O.oppeaine_id;


CREATE TABLE logi(
id int primary key identity(1,1),
kuupaev date,
kasutaja varchar(25),
sisestatudAndmed TEXT
);

SELECT * FROM logi;

CREATE TRIGGER Oppimine_update
ON Oppimine
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


DROP TRIGGER Oppimine_Update

INSERT INTO Oppimine (isiku_id, oppeaine_id, hinne)
VALUES (1, 101, 4);


SELECT * FROM logi;

CREATE TRIGGER tr_oppimine_insert
ON Oppimine
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

UPDATE Oppimine
SET hinne = 5
WHERE isiku_id = 1 AND oppeaine_id = 1;

BEGIN TRANSACTION;
SELECT * FROM Isik;

INSERT INTO Isik (eesnimi, perenimi, sugu, sunnikuupaev, aadress, email )
VALUES ('Jana', 'Silm', 'N', '2001-06-25', 'kuldnoka 18', 'silm@gmail.com');

SAVE TRANSACTION MySavePoint;

ROLLBACK TRANSACTION MySavePoint;
SELECT * FROM Isik;
