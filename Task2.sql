USE DemoApp;


CREATE TABLE Sellers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50),
    Surname NVARCHAR(50),
    City NVARCHAR(100)
);


CREATE TABLE Customers (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50),
    Surname NVARCHAR(50),
    City NVARCHAR(100)
);


CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE CHECK(OrderDate <= GETDATE()),
    Amount DECIMAL(18,2),
    State NVARCHAR(20),
    CustomerId INT,
    SellerId INT,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id),
    FOREIGN KEY (SellerId) REFERENCES Sellers(Id)
);


INSERT INTO Sellers (Name, Surname, City) VALUES 
('John', 'Smith', 'New York'),
('Jane', 'Doe', 'Los Angeles'),
('Ahmet', 'Yılmaz', 'Istanbul'),
('Marie', 'Curie', 'Paris'),
('Hans', 'Müller', 'Berlin');

INSERT INTO Customers (Name, Surname, City) VALUES 
('Alice', 'Johnson', 'New York'),
('Bob', 'Brown', 'Los Angeles'),
('Cem', 'Kaya', 'Istanbul'),
('Eve', 'White', 'Paris'),
('David', 'Schwarz', 'Berlin');

INSERT INTO Orders (OrderDate, Amount, State, CustomerId, SellerId) VALUES 
('2023-12-01', 1500.00, 'Tamamlanib', 1, 1),
('2024-01-05', 750.00, 'Catdirilmada', 2, 2),
('2023-11-20', 2000.00, 'Tamamlanib', 3, 3),
('2024-02-10', 300.00, 'Catdirilmada', 4, 4),
('2023-10-15', 2500.00, 'Tamamlanib', 5, 5);


-- A varianti
SELECT c.Name, c.Surname, SUM(o.Amount) AS TotalAmount
FROM Customers c
JOIN Orders o ON c.Id = o.CustomerId
GROUP BY c.Name, c.Surname
HAVING SUM(o.Amount) > 1000;

-- B varianti
SELECT c.Name AS CustomerName, c.Surname AS CustomerSurname, s.Name AS SellerName, s.Surname AS SellerSurname, c.City
FROM Customers c
JOIN Sellers s ON c.City = s.City;

-- C varianti
SELECT o.Id, o.OrderDate, o.Amount, o.State, c.Name AS CustomerName, c.Surname AS CustomerSurname
FROM Orders o
JOIN Customers c ON o.CustomerId = c.Id
WHERE o.OrderDate >= '2024-01-04' AND o.State = 'Tamamlanib';


-- D varianti
SELECT s.Name, s.Surname, COUNT(o.Id) AS OrderCount
FROM Sellers s
JOIN Orders o ON s.Id = o.SellerId
WHERE o.State = 'Tamamlanib'
GROUP BY s.Name, s.Surname
HAVING COUNT(o.Id) > 10;

-- E varianti
SELECT c.Name, c.Surname, COUNT(o.Id) AS OrderCount
FROM Customers c
JOIN Orders o ON c.Id = o.CustomerId
GROUP BY c.Name, c.Surname
ORDER BY OrderCount DESC;

-- F varianti
SELECT o.Id, o.OrderDate, o.Amount, o.State, s.Name AS SellerName, s.Surname AS SellerSurname
FROM Orders o
JOIN Sellers s ON o.SellerId = s.Id
WHERE o.State != 'Tamamlanib'
ORDER BY o.OrderDate ASC;


-- G varianti
SELECT o.Id, o.OrderDate, o.Amount, o.State, c.Name AS CustomerName, c.Surname AS CustomerSurname
FROM Orders o
JOIN Customers c ON o.CustomerId = c.Id
WHERE o.State = 'Tamamlanib' AND o.OrderDate >= DATEADD(MONTH, -1, GETDATE());