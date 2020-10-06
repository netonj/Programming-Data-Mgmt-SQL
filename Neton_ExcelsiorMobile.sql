/*
Project 1: Excelsior Mobile Report
Jack Neton
*/

USE [20WQ_BUAN4210_Lloyd_ExcelsiorMobile];

--1--
--A

SELECT CONCAT(Subscriber.FirstName, ' ', Subscriber.LastName) AS 'Customer Name', LastMonthUsage."Minutes" AS 'Total Minutes', LastMonthUsage.DataInMB AS 'Total Data Usg', LastMonthUsage.Texts AS 'Total Texts', Bill.Total AS 'Total Bill'
FROM Subscriber, LastMonthUsage, Bill
WHERE Subscriber."MIN" = LastMonthUsage."MIN"
	AND Subscriber."MIN" = Bill."MIN"
GROUP BY  Subscriber.FirstName, Subscriber.LastName, LastMonthUsage."Minutes", LastMonthUsage.DataInMB, LastMonthUsage.Texts, Bill.Total;

--B

SELECT Subscriber.City, AVG(LastMonthUsage."Minutes") AS 'Average Minutes', AVG(LastMonthUsage.DataInMB) AS 'Average Data Usage (MB)', AVG(LastMonthUsage.Texts) AS 'Average Texts', AVG(Bill.Total) AS 'Average Bill Amount'
FROM Subscriber,LastMonthUsage, Bill
WHERE Subscriber."MIN" = LastMonthUsage."MIN" 
	AND Subscriber."MIN" = Bill."MIN"
GROUP BY City
ORDER BY City;

--C

SELECT Subscriber.City, SUM(LastMonthUsage."Minutes") AS 'Total Minutes', SUM(LastMonthUsage.DataInMB) AS 'Total Data Usage (MB)', SUM(LastMonthUsage.Texts) AS 'Total Texts', SUM(Bill.Total) AS 'Total Bill Amount'
FROM Subscriber,LastMonthUsage, Bill
WHERE Subscriber."MIN" = LastMonthUsage."MIN" 
	AND Subscriber."MIN" = Bill."MIN"
GROUP BY City
ORDER BY City;

--D

SELECT Subscriber.PlanName, AVG(LastMonthUsage."Minutes") AS 'Average Minutes', AVG(LastMonthUsage.DataInMB) AS 'Average Data Usage (MB)', AVG(LastMonthUsage.Texts) AS 'Average Texts', AVG(Bill.Total) AS 'Average Bill Amount'
FROM Subscriber,LastMonthUsage, Bill
WHERE Subscriber."MIN" = LastMonthUsage."MIN" 
	AND Subscriber."MIN" = Bill."MIN"
GROUP BY PlanName
ORDER BY PlanName; 

--E

SELECT Subscriber.PlanName, SUM(LastMonthUsage."Minutes") AS 'Total Minutes', SUM(LastMonthUsage.DataInMB) AS 'Total Data Usage (MB)', SUM(LastMonthUsage.Texts) AS 'Total Texts', SUM(Bill.Total) AS 'Total Bill Amount'
FROM Subscriber,LastMonthUsage, Bill
WHERE Subscriber."MIN" = LastMonthUsage."MIN" 
	AND Subscriber."MIN" = Bill."MIN"
GROUP BY PlanName
ORDER BY PlanName; 

/*
Part 2: No Visualizations
*/

--1--

--A

SELECT TOP 2 City, COUNT(City) AS 'Amount of Customers in City'
FROM Subscriber
GROUP BY City
ORDER BY 'Amount of Customers in City' DESC;

--B

SELECT TOP 3 City, COUNT(City) AS 'Amount of Customers in City'
FROM Subscriber
GROUP BY City
ORDER BY 'Amount of Customers in City' ASC;

--C

SELECT TOP 2 PlanName, COUNT(PlanName) AS 'Amount of Plan'
FROM Subscriber
GROUP BY PlanName
ORDER BY PlanName;

--2--

--A

SELECT Type, COUNT(Type) AS 'Amount of Device Type'
FROM Device
GROUP BY "Type"
ORDER BY 'Amount of Device Type' DESC;

--B

SELECT CONCAT(FirstName, ' ', LastName) AS 'Customer Name'
FROM Subscriber
WHERE MDN IN
	(SELECT DirNums.MDN
	FROM DirNums
	WHERE IMEI IN
		(SELECT Device.IMEI
		FROM Device
		WHERE "Type" = 'Apple'))
ORDER BY 'Customer Name' ASC;

--C

SELECT CONCAT(Subscriber.FirstName, ' ',  Subscriber.LastName) AS 'Customer Name', YearReleased
FROM Subscriber, Device, DirNums
WHERE Subscriber."MDN" = DirNums."MDN"
	AND DirNums.IMEI = Device.IMEI AND YearReleased < 2018
ORDER BY [Customer Name];

--3--

SELECT TOP 1 SUM(DataInMB) AS 'Max Data Usage', MPlan."Data" as 'Data Plan', Subscriber.City
FROM Subscriber JOIN MPlan
	ON Subscriber.PlanName = MPlan.PlanName
	JOIN LastMonthUsage
	ON LastMonthUsage."MIN" = Subscriber."MIN"
WHERE MPlan."Data" NOT LIKE 'Unlimited'
GROUP BY MPlan."Data", Subscriber.City
ORDER BY 'Max Data Usage' DESC;


--4--

--A
SELECT TOP 1 CONCAT(Subscriber.FirstName, ' ', Subscriber.LastName) AS 'Customer Full Name' 
FROM Subscriber, Bill
WHERE Subscriber."MIN" = Bill."MIN"
ORDER BY Total DESC;

--B
SELECT TOP 1 (COUNT("MIN")*Cost) AS 'Revenue', MPlan.PlanName
FROM Subscriber, MPlan
WHERE Subscriber.PlanName = MPlan.PlanName
GROUP BY Cost, MPlan.PlanName
ORDER BY Cost DESC;

--5--

--A
SELECT TOP 1 SUBSTRING(MDN,1,3) AS 'Area Code', SUM(Minutes) AS 'Minutes'
FROM Subscriber, LastMonthUsage
WHERE Subscriber."MIN" = LastMonthUsage."MIN"
GROUP BY SUBSTRING(MDN, 1, 3)
ORDER BY "Minutes" DESC;

--B
SELECT DISTINCT Subscriber.City
FROM Subscriber, LastMonthUsage
WHERE Subscriber."MIN" = LastMonthUsage."MIN"
	AND Subscriber.City IN
		(SELECT DISTINCT Subscriber.City
		FROM Subscriber, LastMonthUsage
		WHERE Subscriber."MIN" = LastMonthUsage."MIN"
		GROUP BY Subscriber.City, LastMonthUsage."Minutes"
		HAVING LastMonthUsage."Minutes" > 700)
GROUP BY Subscriber.City, LastMonthUsage."Minutes"
HAVING LastMonthUsage."Minutes" < 200;





