--Level 5 — Final Business Analysis
--Q46

--English:
--Which pizza types generate high revenue but a low number of orders?
WITH PizzaSales AS
(
SELECT PT.Name, 
SUM(P.Price * OD.Quantity) AS Total_Revenue, COUNT(DISTINCT OD.OrderId) AS Total_Orders
FROM PizzaTypes PT 
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
),
Averages AS 
(
SELECT AVG(Total_Revenue) AS Avg_Revenue ,AVG(Total_Orders) AS Avg_Total_Orders
FROM PizzaSales
)
SELECT 
P.Name, P.Total_Revenue, P.Total_Orders, A.Avg_Total_Orders, A.Avg_Revenue FROM PizzaSales P CROSS JOIN Averages A
WHERE P.Total_Orders < A.Avg_Total_Orders AND P.Total_Revenue > A.Avg_Revenue

--Q47

--English:
--Which pizza types have a high average selling price but low sales volume?
WITH PizzaSales AS
(
SELECT PT.Name, 
AVG(P.Price) AS Avg_Price, SUM(OD.Quantity) AS Sales_Volume
FROM PizzaTypes PT 
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
),
Averages AS 
(
SELECT AVG(Avg_Price) AS Avg_Price ,AVG(Sales_Volume) AS Avg_Sales_Volume
FROM PizzaSales
)
SELECT P.Name,P.Avg_Price,P.Sales_Volume,A.Avg_Price,A.Avg_Sales_Volume FROM PizzaSales P CROSS JOIN Averages A
WHERE P.Avg_Price > A.Avg_Price AND P.Sales_Volume < A.Avg_Sales_Volume

--Q48

--English:
--Which pizza types appear in the highest number of distinct orders?
SELECT PT.Name, 
COUNT(DISTINCT OD.OrderId) AS Orders
FROM PizzaTypes PT 
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
HAVING COUNT(DISTINCT OD.OrderId) > 1
ORDER BY Orders DESC

--Q49

--English:
--Which pizza categories had the strongest revenue growth from the first half of the year to the second half?
WITH PizzaSales AS (
SELECT PT.Category, DATEPART(MONTH,O.Date) AS Month_Number, DATENAME(MONTH,O.Date) AS Month_Name, 
SUM(P.Price * OD.Quantity) AS Total_Revenue
FROM PizzaTypes PT 
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
JOIN Orders O
ON Od.OrderId = O.OrderId
GROUP BY PT.Category, DATEPART(MONTH,O.Date), DATENAME(MONTH,O.Date) 
),
TotalByHalf AS (
SELECT Category, 
SUM( CASE
WHEN Month_Number BETWEEN 1 AND 6 THEN Total_Revenue
ELSE 0
END
) AS First_Half_Revenue,
SUM( CASE
WHEN Month_Number BETWEEN 7 AND 12 THEN Total_Revenue
ELSE 0
END
) AS Second_Half_Revenue
FROM PizzaSales
GROUP BY Category
)
SELECT Category, First_Half_Revenue, Second_Half_Revenue, 
(Second_Half_Revenue - First_Half_Revenue) AS Difference,
(Second_Half_Revenue - First_Half_Revenue) / First_Half_Revenue * 100.0 AS Growth
FROM TotalByHalf
ORDER BY Growth DESC

--Q50

--English:
--Which pizza types contributed the most to the change in revenue between the first and second half of the year?
WITH PizzaSales AS (
SELECT PT.Name, DATEPART(MONTH,O.Date) AS Month_Number, DATENAME(MONTH,O.Date) AS Month_Name, 
SUM(P.Price * OD.Quantity) AS Total_Revenue
FROM PizzaTypes PT 
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
JOIN Orders O
ON Od.OrderId = O.OrderId
GROUP BY PT.Name, DATEPART(MONTH,O.Date), DATENAME(MONTH,O.Date) 
),
TotalByHalf AS (
SELECT Name, 
SUM( CASE
WHEN Month_Number BETWEEN 1 AND 6 THEN Total_Revenue
ELSE 0
END
) AS First_Half_Revenue,
SUM( CASE
WHEN Month_Number BETWEEN 7 AND 12 THEN Total_Revenue
ELSE 0
END
) AS Second_Half_Revenue
FROM PizzaSales
GROUP BY Name
)
SELECT Name, First_Half_Revenue, Second_Half_Revenue, 
(Second_Half_Revenue - First_Half_Revenue) AS Revenue_Change
FROM TotalByHalf
ORDER BY Revenue_Change DESC

--Q51 

--English:
--Which month had the highest Average Order Value?
WITH PizzaSales AS (
SELECT O.OrderId, DATEPART(MONTH,O.Date) AS Month_Number, DATENAME(MONTH,O.Date) AS Month_Name, 
SUM(P.Price * OD.Quantity) AS Order_Value
FROM Pizzas P
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
JOIN Orders O
ON Od.OrderId = O.OrderId
GROUP BY O.OrderId, DATEPART(MONTH,O.Date), DATENAME(MONTH,O.Date) 
),
AverageOrderValue As (
SELECT Month_Number, Month_Name, AVG(Order_Value) AS AVO
FROM PizzaSales
GROUP BY Month_Number, Month_Name
)
SELECT TOP 1 *
FROM AverageOrderValue
ORDER BY AVO DESC

--Q52

--English:
--Which day of the week had the highest Average Order Value?
WITH PizzaSales AS (
SELECT O.OrderId, DATENAME(DW,O.Date) AS DayWeek,
SUM(P.Price * OD.Quantity) AS Order_Value
FROM Pizzas P
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
JOIN Orders O
ON Od.OrderId = O.OrderId
GROUP BY O.OrderId, DATENAME(DW,O.Date)
),
AverageOrderValue As (
SELECT DayWeek, AVG(Order_Value) AS AVO
FROM PizzaSales
GROUP BY DayWeek
)
SELECT TOP 1 *
FROM AverageOrderValue
ORDER BY AVO DESC

--Q53

--English:
--Which hours generate high order volume but relatively low revenue per order?
WITH PizzaSales AS (
SELECT O.OrderId, DATEPART(HOUR,O.Time) AS Hours,
SUM(P.Price * OD.Quantity) AS Order_Value
FROM Pizzas P
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
JOIN Orders O
ON Od.OrderId = O.OrderId
GROUP BY O.OrderId, DATEPART(HOUR,O.Time)
),
AverageOrderValue As (
SELECT Hours, COUNT(OrderId) AS TotalOrders, AVG(Order_Value) AS AVO
FROM PizzaSales
GROUP BY Hours
),
HourlyAverages AS
(
SELECT AVG(TotalOrders) AS Average_TotalOrders, AVG(AVO) AS Average_AVO
FROM AverageOrderValue
)
SELECT AOV.*, HA.Average_TotalOrders, Average_AVO
FROM AverageOrderValue AOV CROSS JOIN HourlyAverages HA
WHERE AOV.TotalOrders > HA.Average_TotalOrders AND AOV.AVO < HA.Average_AVO

--Q54

--English:
--Which pizza types perform above average in both revenue and number of orders?
WITH PizzaSales AS (
    SELECT 
        PT.Name,
        OD.OrderId,
        SUM(P.Price * OD.Quantity) AS Order_Revenue
    FROM PizzaTypes PT
    JOIN Pizzas P
        ON PT.PizzaTypeId = P.PizzaTypeId
    JOIN OrderDetails OD
        ON P.PizzaId = OD.PizzaId
    GROUP BY PT.Name, OD.OrderId
),
PizzaPerformance AS (
    SELECT 
        Name,
        COUNT(OrderId) AS TotalOrders,
        SUM(Order_Revenue) AS TotalRevenue
    FROM PizzaSales
    GROUP BY Name
),
AveragePerformance AS (
    SELECT 
        AVG(TotalOrders) AS AverageOrders,
        AVG(TotalRevenue) AS AverageRevenue
    FROM PizzaPerformance
)
SELECT 
    PP.Name,
    PP.TotalOrders,
    PP.TotalRevenue,
    AP.AverageOrders,
    AP.AverageRevenue
FROM PizzaPerformance PP
CROSS JOIN AveragePerformance AP
WHERE PP.TotalOrders > AP.AverageOrders
  AND PP.TotalRevenue > AP.AverageRevenue

--Q55

--English:
--Which pizza types perform above average in revenue, quantity sold, and order frequency?
WITH PizzaSales AS (
    SELECT 
        PT.Name,
        SUM(P.Price * OD.Quantity) AS Total_Revenue,
		SUM(OD.Quantity) AS Total_Quantity,
		COUNT(DISTINCT OD.OrderId) AS Total_Orders
    FROM PizzaTypes PT
    JOIN Pizzas P
        ON PT.PizzaTypeId = P.PizzaTypeId
    JOIN OrderDetails OD
        ON P.PizzaId = OD.PizzaId
    GROUP BY PT.Name
),
AveragePerformance AS (
    SELECT 
        AVG(Total_Revenue) AS Average_Revenue,
        AVG(Total_Quantity) AS Average_Quantity,
		AVG(Total_Orders) AS Average_Orders
    FROM PizzaSales
)

SELECT 
    PS.Name,
    PS.Total_Revenue,
    PS.Total_Orders,
    AP.Average_Orders,
    AP.Average_Revenue
FROM PizzaSales PS
CROSS JOIN AveragePerformance AP
WHERE PS.Total_Revenue > AP.Average_Revenue
	AND PS.Total_Orders > AP.Average_Orders
    AND PS.Total_Quantity > AP.Average_Quantity