USE MASTER
GO 
DROP DATABASE IF EXISTS Patient_Database
GO
DROP USER IF EXISTS Ole
DROP USER IF EXISTS Niels
DROP LOGIN Niels
DROP LOGIN Ole
CREATE DATABASE Patient_Database
GO
USE Patient_Database

CREATE TABLE Occupation(
Id int identity(1,1) primary key,
"Name" nvarchar(100)
)

CREATE TABLE Doctor(
Id int identity(1,1) primary key,
FirstName nvarchar(100),
LastName nvarchar(100),
Tlf nvarchar(100),
OccupationId int foreign key references Occupation(Id)
)

CREATE TABLE Patient(
Id int identity(1,1) primary key,
FirstName nvarchar(100),
LastName nvarchar(100),
Tlf nvarchar(100),
Age int
)

CREATE TABLE Apointment(
Id int identity primary key,
PatientId int foreign key references Patient(Id),
DoctorId int foreign key references Doctor(Id)
)

INSERT INTO Occupation VALUES ('Øjenlæge')
INSERT INTO Occupation VALUES ('Radiologi')
INSERT INTO Occupation VALUES ('Kirugi')

INSERT INTO Doctor VALUES ('Peter','Hansen','12345678',1)
INSERT INTO Doctor VALUES ('Martin','Jensen','12345679',2)
INSERT INTO Doctor VALUES ('Thomas','Olsen','12345670',3)



USE MASTER

EXEC sp_configure 'backup compression default',1;
RECONFIGURE;
GO
EXEC sp_configure 'Remote admin connections',1;
RECONFIGURE;
GO

ALTER LOGIN sa ENABLE;
GO
ALTER LOGIN sa WITH PASSWORD = 'Pa$$w0rd'

CREATE LOGIN Niels
WITH PASSWORD='Pa$$w0rd'

CREATE LOGIN Ole
WITH PASSWORD='Pa$$w0rd!'

ALTER SERVER ROLE [sysadmin] ADD MEMBER [Niels]

USE Patient_Database

CREATE USER [Niels] FOR LOGIN [Niels]
ALTER USER [Niels] WITH DEFAULT_SCHEMA=[Patient_Datebase]
ALTER ROLE [db_owner] ADD MEMBER [Niels] 

CREATE USER [Ole] FOR LOGIN [Ole]
ALTER USER [Ole] WITH DEFAULT_SCHEMA=[Patient_Datebase]
ALTER ROLE [db_datareader] ADD MEMBER [Ole] 




-- Insert 

insert into Patient (FirstName, LastName, Tlf, Age) values ('Lurleen', 'Klainman', '8301074007', 23);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Stella', 'Beecheno', '2989169378', 23);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Fonz', 'Zoppo', '2858298588', 3);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Pippy', 'Davitti', '2093841989', 60);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Tiffany', 'Kennea', '2446093487', 3);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Petr', 'Dougliss', '1636707718', 33);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Andreas', 'Masters', '2965127656', 37);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Prisca', 'Mulligan', '1791200972', 36);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Gaspard', 'McCully', '1046899268', 43);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Betta', 'Hassell', '5221287927', 96);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Merissa', 'Oman', '8378759512', 99);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Shae', 'Vouls', '2009277540', 33);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Danielle', 'Kohnemann', '8172914628', 64);
insert into Patient (FirstName, LastName, Tlf, Age) values ('Lois', 'Batterbee', '7109175821', 42);

INSERT INTO Apointment VALUES (1,2)
INSERT INTO Apointment VALUES (1,1)
INSERT INTO Apointment VALUES (2,2)
INSERT INTO Apointment VALUES (2,2)

SELECT * FROM Patient
SELECT * FROM Doctor
SELECT * FROM Occupation
SELECT * FROM Apointment

select CONCAT(PT.FirstName,' '+ PT.LastName ) As Patient,
       CONCAT(DT.FirstName,' '+ DT.LastName ) As 'Læge',
        OCC.Name as 'Speciale'
from Apointment APT left join Doctor DT on APT.DoctorId = DT.Id left join Occupation OCC on DT.OccupationID = OCC.Id  left join  Patient PT on DT.Id = APT.DoctorId and APT.PatientId = PT.Id