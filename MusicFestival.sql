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

/*
    SELECT [DISTINCT] columns
    FROM tables
    [WHERE condition]
    [GROUP BY columns]
    [HAVING group_condition]
    [ORDER BY columns [ASC|DESC]];
*/

/* Question 1
SELECT PerformerName, Country
FROM Performer;
*/

/* Question 2
SELECT *
FROM FestivalShow
WHERE ShowDate = '08-14-2026';
*/ 

/* Question 3
SELECT PerformerName, Genre 
FROM Performer
WHERE Country = 'Canada';
*/

/* Question 4
SELECT StageName
FROM Stage
WHERE Zone = 'North';
*/

/* Question 5
SELECT PerformerName, Country
FROM Performer
WHERE Genre = 'Jazz';
*/

/* Question 6
SELECT PerformerName, genre, country
FROM Performer
ORDER BY PerformerName ASC;
*/

/* Question 7
SELECT DISTINCT Genre 
FROM Performer
ORDER BY Genre; //what does this do
*/

/* Question 8
SELECT PerformerName, Genre
FROM Performer
WHERE PerformerName LIKE 'M%';
*/

/* Question 9
SELECT ShowID, StageID, ShowDate, StartTime
FROM FestivalShow
ORDER BY ShowDate ASC, StartTime ASC;
*/

/* Question 10
SELECT PerformerName, Genre, Country
FROM Performer
WHERE Genre LIKE '%ck%';
*/

/* Question 11
SELECT FS.ShowID, fs.ShowDate, S.StageName
FROM FestivalShow FS
JOIN Stage S ON FS.StageID = S.StageID
ORDER BY FS.ShowDate ASC;
*/

/* Question 12
SELECT p.PerformerName, sp.ShowID, fs.ShowDate
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
JOIN FestivalShow FS ON SP.ShowID = FS.ShowID
ORDER BY P.PerformerID;
*/

/* Question 13
SELECT FS.ShowID, FS.ShowDate, FS.StartTime, S.StageName, S.Zone
FROM FestivalShow FS
JOIN Stage S ON S.StageID = FS.StageID
ORDER BY FS.ShowDate ASC;
*/

/* Question 14
SELECT P.PerformerName, P.Genre, P.Country, S.StageName
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
JOIN FestivalShow FS ON SP.ShowID = FS.ShowID
JOIN Stage S ON FS.StageID = S.StageID
WHERE S.StageName = 'River Stage';
*/

/* Question 15
SELECT P.PerformerName, SUM(SP.Fee) AS TotalFees
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
GROUP BY P.PerformerName
ORDER BY TotalFees DESC;
*/

/* Question 16
SELECT Genre, COUNT(*) AS NumPerformers
FROM Performer
GROUP BY Genre
ORDER BY NumPerformers DESC;
*/

/* Question 17
SELECT ShowDate, COUNT(*) AS NumShows
FROM FestivalShow
GROUP BY ShowDate
ORDER BY ShowDate;
*/

/* Question 18

*/

/* Question 19

*/

/* Question 20

*/

/* Practice Questions from Document
SELECT P.PerformerName, P.Genre, SP.ShowID
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
WHERE SP.ShowID = '1001';

SELECT P.PerformerName, SP.ShowID, S.StageName, FS.ShowDate
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
JOIN FestivalShow FS ON SP.ShowID = FS.ShowID
JOIN Stage S ON FS.StageID = S.StageID;
*/
