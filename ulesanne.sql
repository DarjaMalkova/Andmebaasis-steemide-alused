create database kaubTIT
use kaubTIT

create table autod(
id int primary key identity(1,1),
kaubamärk varchar(20));
insert into autod (kaubamärk) values ('Volkswagen');
insert into autod (kaubamärk) values ('Ford');
insert into autod (kaubamärk) values ('Mercury');
insert into autod (kaubamärk) values ('Audi');
insert into autod (kaubamärk) values ('Mazda');
insert into autod (kaubamärk) values ('Toyota');
insert into autod (kaubamärk) values ('Plymouth');
insert into autod (kaubamärk) values ('Audi');
insert into autod (kaubamärk) values ('Dodge');
insert into autod (kaubamärk) values ('Acura');
select * from autod

create table telefonid(
id int primary key identity(1,1),
kaubamärk varchar(20));
insert into telefonid (kaubamärk) values ('Micromax');
insert into telefonid (kaubamärk) values ('Xiaomi');
insert into telefonid (kaubamärk) values ('Lava');
insert into telefonid (kaubamärk) values ('Samsung');
insert into telefonid (kaubamärk) values ('Lenovo');
insert into telefonid (kaubamärk) values ('Micromax');
insert into telefonid (kaubamärk) values ('Nokia');
insert into telefonid (kaubamärk) values ('BLU');
insert into telefonid (kaubamärk) values ('Ulefone');
insert into telefonid (kaubamärk) values ('YU');
select * from telefonid

GRANT SELECT, INSERT ON autod TO Darja;
GRANT SELECT, DELETE ON telefonid TO Darja;
