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
SELECT AVG(fee) AS AverageFee
FROM ShowPerformer;
*/

/* Question 19
SELECT S.StageName, COUNT(FS.ShowID) AS NumShows
FROM Stage S
JOIN FestivalShow FS ON S.StageID = FS.StageID
GROUP BY S.StageName
ORDER BY NumShows DESC;
*/

/* Question 20
SELECT FS.ShowID, FS.ShowDate,
COUNT(SP.PerformerID) AS NumPerformers,
COUNT(SP.Fee) AS NumFees
FROM FestivalShow FS
JOIN ShowPerformer SP ON FS.ShowID = SP.ShowID
GROUP BY FS.ShowID, FS.ShowDate
ORDER BY NumPerformers;
*/

/* Question 21
SELECT Genre, COUNT(PerformerID) AS NumPerformers
FROM Performer
GROUP BY Genre
HAVING COUNT(PerformerID) > 1
ORDER BY NumPerformers;
*/

/* Question 22
GO

IF OBJECT_ID('StageSummary', 'V') IS NOT NULL
    DROP VIEW StageSummary;

GO

CREATE VIEW StageSummary AS 
SELECT S.StageName,
COUNT(DISTINCT FS.ShowID) AS NumShows,
COUNT(DISTINCT SP.PerformerID) AS NumPerformers,
    SUM(SP.Fee) AS TotalFees
FROM Stage S
LEFT JOIN FestivalShow FS ON S.StageID = FS.StageID
LEFT JOIN ShowPerformer SP ON FS.ShowID = SP.ShowID
GROUP BY S.StageName;

GO

SELECT * FROM StageSummary;

SELECT * FROM StageSummary WHERE NumShows > 0;

SELECT * FROM StageSummary ORDER BY TotalFees DESC;
*/

/* Question 23

SELECT DISTINCT P.PerformerName, P.Genre, S.StageName
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
JOIN FestivalShow FS ON SP.ShowID = FS.ShowID
JOIN Stage S ON FS.StageID = S.StageID
WHERE S.StageName = 'River Stage';

*/

/* Question 24

*/

/* Question 25

*/

/* Question 26

*/

/* Practice Questions from Document
QUESTION 1
SELECT P.PerformerName, P.Genre, SP.ShowID
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
WHERE SP.ShowID = '1001';

QUESTION 2
SELECT P.PerformerName, SP.ShowID, S.StageName, FS.ShowDate
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
JOIN FestivalShow FS ON SP.ShowID = FS.ShowID
JOIN Stage S ON FS.StageID = S.StageID;

QUESTION 3
SELECT   S.StageName, COUNT(FS.ShowID) AS NumShows
FROM Stage S
JOIN FestivalShow FS ON S.StageID = FS.StageID
GROUP BY S.StageID, S.StageName
ORDER BY NumShows DESC;

QUESTION 4
GO
IF OBJECT_ID('ShowLeftJoin', 'V') IS NOT NULL
    DROP VIEW ShowLeftJoin;
GO 
CREATE VIEW ShowLeftJoin AS
SELECT S.StageName, FS.ShowID
FROM Stage S
LEFT JOIN FestivalShow FS ON S.StageID = FS.StageID;
GO
SELECT * FROM ShowLeftJoin;
SELECT * FROM ShowLeftJoin ORDER BY StageName;
SELECT * FROM ShowLeftJoin ORDER BY StageName, ShowID;
*/


/* 
Question 1 
SELECT P.PerformerName, P.Genre, SP.showID
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
WHERE ShowID = '1001';

Question 2
SELECT P.PerformerName, S.StageName, FS.ShowDate
FROM Performer P
JOIN ShowPerformer SP ON p.PerformerID = SP.PerformerID
JOIN FestivalShow FS ON SP.ShowID = FS.ShowID
JOIN Stage S ON FS.StageID = S.StageID
ORDER BY FS.ShowDate, S.StageName, P.PerformerName;

Question 3
SELECT S.StageID, S.StageName, COUNT(FS.ShowID) AS NumShows
FROM Stage S
JOIN FestivalShow FS ON S.StageID = FS.StageID
GROUP BY S.StageID, S.StageName
HAVING COUNT(FS.ShowID) >= 1;

Question 4
SELECT S.StageName, S.StageID, FS.ShowID
FROM Stage S
LEFT JOIN FestivalShow FS ON S.StageID = FS.StageID
ORDER BY S.StageName, FS.ShowID;

Question 5 
SELECT MAX(SP.Fee), MIN(SP.Fee), AVG(SP.Fee)
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID;

Question 6
SELECT P.Genre, COUNT(P.PerformerID) AS NumPerformers, AVG(SP.Fee)
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
GROUP BY P.Genre
HAVING COUNT(P.PerformerID) >= 1
ORDER BY NumPerformers DESC;

Question 7
SELECT P.Genre, AVG(SP.Fee) AS AvgFee
FROM Performer P
JOIN ShowPerformer SP ON P.PerformerID = SP.PerformerID
GROUP BY P.Genre
HAVING AVG(SP.Fee) > 1000
ORDER BY AvgFee DESC;
*/


