create database TiTtriger;
use TiTtriger;
-- tabel, mida automaaselt täidab triger--
CREATE TABLE logi(
id int primary key identity(1,1),
tegevus varchar(25),
kasutaja varchar(25),
aeg datetime,
andmed TEXT)

-- tabel, millega töötab kasutaja--
CREATE TABLE puud(
puuID int primary key identity(1,1),
puuNimi varchar(25),
pikkus int,
aasta int)

--Triger, mis jälgib tabeli puud lisamine
CREATE TRIGGER puuLisamine
ON puud 
FOR INSERT
AS
INSERT INTO logi(tegevus, kasutaja, aeg, andmed)
SELECT
SYSTEM_USER,
'puu on lisatud', 
GETDATE(),
CONCAT(inserted.puuNimi, ',' ,inserted.pikkus, ',' ,inserted.aasta)
FROM inserted;

INSERT INTO puud(puuNImi, pikkus, aasta)
VALUES ('kask', 22, 2000);
SELECT * FROM puud;
SELECT * FROM logi;
drop trigger puuLisamine

--

CREATE TRIGGER puuKustutamine
ON puud 
FOR DELETE
AS
INSERT INTO logi(tegevus, kasutaja, aeg, andmed)
SELECT
SYSTEM_USER,
'puu on kustutatud'
GETDATE(),
CONCAT(deleted.puuNimi,eleted.ikkus, ',' ,deleted.aasta)
FROM deleted;
DELETE FROM puud WHERE puuID=1;
SELECT * FROM puud;
SELECT * FROM logi;

--triger, mis jälgib uuendamine--

CREATE TRIGGER puuUuendamine
ON puud 
FOR UPDATE
AS
INSERT INTO logi(tegevus, kasutaja, aeg, andmed)
SELECT
SYSTEM_USER,
'puu on uuendatud'
GETDATE(),
CONCAT(
'vana puu info - ', deleted.puuNimi, ', ' ,deleted.pikkus, ', ' ,deleted.aasta,
'uus puu info - ', deleted.puuNimi, ', ' ,deleted.pikkus, ', ' ,deleted.aasta
)
FROM deleted INNER JOIN inserted
ON deleted.puuID=inserted.puuID;

