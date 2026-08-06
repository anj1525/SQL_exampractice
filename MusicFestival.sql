DROP TABLE IF EXISTS ShowPerformer;
DROP TABLE IF EXISTS FestivalShow;
DROP TABLE IF EXISTS Performer;
DROP TABLE IF EXISTS Stage;

CREATE TABLE Stage (
 StageID INT PRIMARY KEY,
 StageName VARCHAR(50) NOT NULL,
 Zone VARCHAR(30) NOT NULL
);

CREATE TABLE Performer (
 PerformerID INT PRIMARY KEY,
 PerformerName VARCHAR(60) NOT NULL,
 Genre VARCHAR(30) NOT NULL,
 Country VARCHAR(30) NOT NULL
);

CREATE TABLE FestivalShow (
 ShowID INT PRIMARY KEY,
 StageID INT NOT NULL,
 ShowDate DATE NOT NULL,
 StartTime TIME NOT NULL,
 CONSTRAINT FK_FestivalShow_Stage
 FOREIGN KEY (StageID) REFERENCES Stage(StageID)
);

CREATE TABLE ShowPerformer (
 ShowID INT NOT NULL,
 PerformerID INT NOT NULL,
 Fee DECIMAL(10,2) NOT NULL,
 CONSTRAINT PK_ShowPerformer
 PRIMARY KEY (ShowID, PerformerID),
 CONSTRAINT FK_ShowPerformer_Show
 FOREIGN KEY (ShowID) REFERENCES FestivalShow(ShowID),
 CONSTRAINT FK_ShowPerformer_Performer
 FOREIGN KEY (PerformerID) REFERENCES Performer(PerformerID)
);

INSERT INTO Stage (StageID, StageName, Zone) VALUES
(1, 'River Stage', 'North'),
(2, 'Garden Stage', 'East'),
(3, 'Hall Stage', 'Indoor'),
(4, 'Sunset Stage', 'West');

INSERT INTO Performer (PerformerID, PerformerName, Genre, Country) VALUES
(101, 'Luna Echo', 'Electronic', 'Canada'),
(102, 'Marco Vale', 'Jazz', 'Italy'),
(103, 'Noor Rahman', 'Folk', 'Canada'),
(104, 'The Atlas', 'Rock', 'Spain'),
(105, 'Priya Sen', 'Jazz', 'India'),
(106, 'Evan Cole', 'Pop', 'USA');

INSERT INTO FestivalShow (ShowID, StageID, ShowDate, StartTime) VALUES
(1001, 1, '2026-08-14', '18:00'),
(1002, 2, '2026-08-14', '20:00'),
(1003, 1, '2026-08-15', '17:00'),
(1004, 3, '2026-08-15', '19:00'),
(1005, 2, '2026-08-16', '16:00');

INSERT INTO ShowPerformer (ShowID, PerformerID, Fee) VALUES
(1001, 101, 1200.00),
(1001, 103, 900.00),
(1002, 102, 1100.00),
(1002, 105, 1000.00),
(1003, 101, 1300.00),
(1003, 104, 1500.00),
(1004, 105, 950.00),
(1005, 103, 850.00),
(1005, 102, 1050.00);

SELECT 