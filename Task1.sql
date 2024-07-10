CREATE DATABASE DemoApp;

USE DemoApp;



CREATE TABLE Countries (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Area DECIMAL(18,2)
);


CREATE TABLE Cities (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Area DECIMAL(18,2)
);


CREATE TABLE People (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50),
    Surname NVARCHAR(50),
    PhoneNumber NVARCHAR(20),
    Email NVARCHAR(100),
    BirthDate DATE,
    Gender CHAR(1),
    HasCitizenship BIT,
    CountryId INT,
    CityId INT,
    FOREIGN KEY (CountryId) REFERENCES Countries(Id),
    FOREIGN KEY (CityId) REFERENCES Cities(Id)
);

INSERT INTO Countries (Name, Area) VALUES 
('Azerbaijan', 86600.00),
('Turkey', 783356.00),
('United States', 9833520.00),
('Germany', 357022.00),
('France', 551695.00),
('India', 1000000000.00),
('Iceland', 375318);


INSERT INTO Cities (Name, Area) VALUES 
('Baku', 2130.00),
('Istanbul', 5461.00),
('New York', 783.8),
('Berlin', 891.8),
('Paris', 105.4);

INSERT INTO People (Name, Surname, PhoneNumber, Email, BirthDate, Gender, HasCitizenship, CountryId, CityId) VALUES 
('Ali', 'Aliyev', '0501234567', 'ali.aliyev@example.com', '1990-05-15', 'M', 1, 1, 1),
('Ayse', 'Yilmaz', '05321234567', 'ayse.yilmaz@example.com', '1985-08-24', 'F', 1, 2, 2),
('John', 'Doe', '1234567890', 'john.doe@example.com', '1975-03-10', 'M', 1, 3, 3),
('Hans', 'Muller', '0987654321', 'hans.muller@example.com', '1980-11-12', 'M', 1, 4, 4),
('Marie', 'Curie', '0678901234', 'marie.curie@example.com', '1989-07-20', 'F', 1, 5, 5);


CREATE VIEW Details AS
SELECT p.Id, p.Name, p.Surname, p.PhoneNumber, p.Email, p.BirthDate, p.Gender, p.HasCitizenship, 
       c.Name AS CountryName, ct.Name AS CityName
FROM People p
JOIN Countries c ON p.CountryId = c.Id
JOIN Cities ct ON p.CityId = ct.Id;


SELECT * FROM Details;


SELECT * FROM Countries
ORDER BY Area ASC;


SELECT * FROM Cities
ORDER BY Name DESC;

SELECT COUNT(*) AS NumberOfCountries
FROM Countries
WHERE Area > 20000;

SELECT MAX(Area) AS LargestArea
FROM Countries
WHERE Name LIKE 'İ%';

SELECT Name, 'Country' AS Type
FROM Countries
UNION
SELECT Name, 'City' AS Type
FROM Cities;

SELECT ct.Name AS CityName, COUNT(p.Id) AS NumberOfPeople
FROM Cities ct
JOIN People p ON ct.Id = p.CityId
GROUP BY ct.Name;

SELECT ct.Name AS CityName, COUNT(p.Id) AS NumberOfPeople
FROM Cities ct
JOIN People p ON ct.Id = p.CityId
GROUP BY ct.Name
HAVING COUNT(p.Id) > 50000;
