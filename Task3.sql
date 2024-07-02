USE DemoApp;


CREATE TABLE Movies (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    ReleaseDate DATE,
    IMDB DECIMAL(3,1)
);


CREATE TABLE Actors (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50),
    Surname NVARCHAR(50)
);


CREATE TABLE Genres (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50)
);


CREATE TABLE MovieActors (
    MovieId INT,
    ActorId INT,
    FOREIGN KEY (MovieId) REFERENCES Movies(Id),
    FOREIGN KEY (ActorId) REFERENCES Actors(Id),
    PRIMARY KEY (MovieId, ActorId)
);


CREATE TABLE MovieGenres (
    MovieId INT,
    GenreId INT,
    FOREIGN KEY (MovieId) REFERENCES Movies(Id),
    FOREIGN KEY (GenreId) REFERENCES Genres(Id),
    PRIMARY KEY (MovieId, GenreId)
);

INSERT INTO Movies (Name, ReleaseDate, IMDB) VALUES 
('Inception', '2010-07-16', 8.8),
('The Matrix', '1999-03-31', 8.7),
('Interstellar', '2014-11-07', 8.6),
('The Godfather', '1972-03-24', 9.2),
('The Dark Knight', '2008-07-18', 9.0);


INSERT INTO Actors (Name, Surname) VALUES 
('Leonardo', 'DiCaprio'),
('Keanu', 'Reeves'),
('Matthew', 'McConaughey'),
('Marlon', 'Brando'),
('Christian', 'Bale');


INSERT INTO Genres (Name) VALUES 
('Sci-Fi'),
('Drama'),
('Action'),
('Crime'),
('Thriller');


INSERT INTO MovieActors (MovieId, ActorId) VALUES 
(1, 1),  -- Inception - Leonardo DiCaprio
(2, 2),  -- The Matrix - Keanu Reeves
(3, 3),  -- Interstellar - Matthew McConaughey
(4, 4),  -- The Godfather - Marlon Brando
(5, 5);  -- The Dark Knight - Christian Bale


INSERT INTO MovieGenres (MovieId, GenreId) VALUES 
(1, 1),  -- Inception - Sci-Fi
(2, 1),  -- The Matrix - Sci-Fi
(3, 1),  -- Interstellar - Sci-Fi
(4, 4),  -- The Godfather - Crime
(5, 3);  -- The Dark Knight - Action


-- A varianti
SELECT a.Name, a.Surname, COUNT(ma.MovieId) AS RoleCount
FROM Actors a
JOIN MovieActors ma ON a.Id = ma.ActorId
GROUP BY a.Name, a.Surname
ORDER BY RoleCount DESC;


-- B varianti
SELECT g.Name AS GenreName, COUNT(mg.MovieId) AS MovieCount
FROM Genres g
JOIN MovieGenres mg ON g.Id = mg.GenreId
GROUP BY g.Name;

-- C varianti
SELECT Name, ReleaseDate
FROM Movies
WHERE ReleaseDate > GETDATE();


-- D varianti
SELECT AVG(IMDB) AS AverageIMDB
FROM Movies
WHERE ReleaseDate >= DATEADD(YEAR, -5, GETDATE());


-- E varianti 
SELECT a.Name, a.Surname, COUNT(ma.MovieId) AS MovieCount
FROM Actors a
JOIN MovieActors ma ON a.Id = ma.ActorId
GROUP BY a.Name, a.Surname
HAVING COUNT(ma.MovieId) > 1;