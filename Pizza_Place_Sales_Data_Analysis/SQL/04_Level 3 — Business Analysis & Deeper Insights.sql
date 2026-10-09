--Level 3 — Business Analysis & Deeper Insights
SELECT * FROM Pizzas
SELECT * FROM PizzaTypes
SELECT * FROM Orders
SELECT * FROM OrderDetails

--Q20

--English:
--Which pizza type has the highest average selling price?
SELECT TOP (1) PT.Name, AVG(P.Price) AS AverageSellingPrice
FROM PizzaTypes PT
JOIN Pizzas p 
ON PT.PizzaTypeId = P.PizzaTypeId
GROUP BY PT.Name
ORDER BY AverageSellingPrice DESC

--Q21

--English:
--Which pizza category has the highest average order quantity per pizza type?
SELECT TOP 1 Category, AVG(TotalQuantitySold) as AverageQuantityPerPizzaType FROM (
SELECT PT.Name, PT.Category, SUM(OD.Quantity) AS TotalQuantitySold
FROM PizzaTypes PT
JOIN Pizzas p 
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name, PT.Category ) AS TotalOrdersPerName
GROUP BY Category 
ORDER BY AverageQuantityPerPizzaType DESC

--Q22

--English:
--Which pizza size has the highest average quantity per order?
SELECT TOP 1 Size, AVG(TotalQuantity) as AvgQuantityPerOrder FROM (
SELECT OD.OrderId, P.Size, SUM(OD.Quantity) AS TotalQuantity
FROM Pizzas p 
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY Od.OrderId, P.Size
) AS OrderSizeTotals
GROUP BY Size 
ORDER BY AvgQuantityPerOrder DESC

--Q23

--English:
--Which pizza type is ordered in the highest number of different orders?

SELECT TOP 1 Name, TotalOrders FROM (
SELECT PT.Name, COUNT(DISTINCT OD.OrderId) AS TotalOrders
FROM PizzaTypes PT
JOIN Pizzas p 
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
) AS TotalOrders
ORDER BY TotalOrders DESC

--Q24

--English:
--Which pizza types have never been ordered?

SELECT PT.Name
FROM PizzaTypes PT
LEFT JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
LEFT JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
HAVING COUNT(OD.PizzaId) = 0

--Q25

--English:
--Which pizza sizes have the highest number of orders?
SELECT P.Size, COUNT(DISTINCT OD.OrderId) AS TotalOrders
FROM Pizzas p 
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY P.Size
ORDER BY TotalOrders DESC

--Q26

--English:
--Which category has the highest average revenue per order?
SELECT TOP 1 Category, AVG(TotalRevenue) AS ARPO
FROM (
SELECT OD.OrderId, PT.Category, SUM(P.Price * OD.Quantity) AS TotalRevenue
FROM PizzaTypes PT
JOIN Pizzas p 
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY OD.OrderId, PT.Category ) AS OrderCategoryRevenue
GROUP BY Category
ORDER BY ARPO DESC

--Q27
 
--English:
--Which pizza type generates high revenue despite having a relatively low sales quantity?
SELECT Name,TotalRevenue,TotalQuantity
FROM (
    SELECT
PT.Name,
SUM(P.Price * OD.Quantity) AS TotalRevenue,
SUM(OD.Quantity) AS TotalQuantity
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
) AS PizzaSales
WHERE TotalRevenue > ( SELECT AVG(TotalRevenue)
    FROM ( SELECT
PT.Name,
SUM(P.Price * OD.Quantity) AS TotalRevenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
) AS RevenueData
)
AND TotalQuantity < (
SELECT AVG(TotalQuantity)
FROM (
SELECT
PT.Name,
SUM(OD.Quantity) AS TotalQuantity
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
) AS QuantityData
)

 --Q28

--English:
--Which month had the highest number of orders?
WITH MonthlyOrders AS
(
    SELECT
        MONTH(Date) AS MonthNumber,
        DATENAME(MONTH, Date) AS MonthName,
        COUNT(OrderId) AS TotalOrders
    FROM Orders
    GROUP BY
        MONTH(Date),
        DATENAME(MONTH, Date)
)
SELECT TOP 1
    MonthNumber,
    MonthName,
    TotalOrders
FROM MonthlyOrders
ORDER BY TotalOrders DESC

--Q29

--English:
--Which month had the lowest number of orders?
SELECT TOP 1 Month, Number_Of_Orders
FROM(	
SELECT DATENAME(MONTH,O.Date) As Month
,COUNT(DISTINCT OD.OrderId) AS Number_Of_Orders
FROM Orders O
JOIN OrderDetails OD
ON O.OrderId = OD.OrderId
GROUP BY DATENAME(MONTH,O.Date) 
) AS DDD
ORDER BY Number_Of_Orders

--Q30

--English:
--Which day of the week generates the highest revenue?
SELECT TOP 1 Day_Of_Week, Total_revenue
FROM (
SELECT DATENAME(DW,O.Date) As Day_Of_Week
,SUM(OD.Quantity * P.Price) AS Total_revenue
FROM Orders O
JOIN OrderDetails OD
ON O.OrderId = OD.OrderId
JOIN Pizzas P
ON OD.PizzaId = P.PizzaId
GROUP BY  DATENAME(DW,O.Date)
)AS DDD
ORDER BY Total_revenue DESC

--Q31

--English:
--Which pizza types have low sales quantity but high revenue?
WITH PizzaSales AS
(
    SELECT 
    PT.Name,
    SUM(OD.Quantity) AS Sales_Quantity,
    SUM(OD.Quantity * P.Price) AS Total_Revenue
    FROM OrderDetails OD
    JOIN Pizzas P
    ON OD.PizzaId = P.PizzaId
    JOIN PizzaTypes PT
	ON P.PizzaTypeId = PT.PizzaTypeId
    GROUP BY PT.Name
),
Averages AS
(
    SELECT 
	AVG(Sales_Quantity) AS AVG_Sales_Quantity,
	AVG(Total_Revenue) AS AVG_Total_Revenue
    FROM PizzaSales
)
SELECT PS.Name, PS.Sales_Quantity, PS.Total_Revenue 
FROM PizzaSales PS
CROSS JOIN Averages A
WHERE PS.Sales_Quantity < A.AVG_Sales_Quantity AND PS.Total_Revenue > A.AVG_Total_Revenue

--Q32

--English:
--What percentage of total revenue comes from each pizza category?

WITH Category_Revenue AS 
(SELECT PT.Category, SUM(OD.Quantity * P.Price) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Category),

Total_Revenue AS (
SELECT SUM(OD.Quantity * P.Price) AS Total_Revenue
FROM Pizzas P
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
)

SELECT CR.Category,(CR.Total_Revenue / TR.Total_Revenue) * 100.0 AS Percentage
FROM Category_Revenue CR 
CROSS JOIN Total_Revenue TR 

--Q33

--English:
--Which pizza type contributes the highest percentage of total revenue?
WITH PizzaTypeRevenue AS 
(SELECT PT.Name, SUM(OD.Quantity * P.Price) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name),

Total_Revenue AS (
SELECT SUM(OD.Quantity * P.Price) AS Total_Revenue
FROM Pizzas P
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
)

SELECT TOP 1 PTR.Name,(PTR.Total_Revenue / TR.Total_Revenue) * 100.0 AS Percentage
FROM PizzaTypeRevenue PTR
CROSS JOIN Total_Revenue TR 
ORDER BY Percentage DESC

--Q34

--English:
--Which orders contain the highest number of different pizza types?
SELECT O.OrderId,
COUNT(DISTINCT PT.PizzaTypeId) AS NumberOfPizzaTypes
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails O
ON P.PizzaId = O.PizzaId
GROUP BY O.OrderId
ORDER BY NumberOfPizzaTypes DESC

--Q35

--English:
--Which pizza type has the highest revenue per pizza sold?
SELECT Top 1 Name, (Total_Revenue / Total_Quantity_Sold) AS Revenue_Per_Pizza_Sold 
FROM (
SELECT PT.Name, 
SUM(P.Price * O.Quantity) AS Total_Revenue,
SUM(O.Quantity) AS Total_Quantity_Sold
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails O
ON P.PizzaId = O.PizzaId
GROUP BY PT.Name ) AS Total_Orders
ORDER BY Revenue_Per_Pizza_Sold DESC