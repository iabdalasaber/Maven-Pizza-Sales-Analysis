--Level 1 — Basic Business Analysis

--Q5

--English:
--Which day of the week has the highest number of orders?
SELECT DATENAME(DW,Date) AS Day_Of_Week, COUNT(OrderId) AS TotalOrder 
FROM Orders 
GROUP BY DATENAME(DW,Date) 
ORDER BY TotalOrder DESC

--Q6

--English:
--Which day of the week has the lowest number of orders?
SELECT DATENAME(DW,Date) AS Day_Of_Week, COUNT(OrderId) AS TotalOrder 
FROM Orders 
GROUP BY DATENAME(DW,Date) 
ORDER BY TotalOrder

--Q7

--English:
--Which pizza size is ordered the most?
SELECT P.Size, SUM(OD.Quantity) AS TotalQuantitySold
FROM Pizzas P
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY P.Size
ORDER BY TotalQuantitySold DESC

--Q8

--English:
--Which pizza size generates the highest revenue?
SELECT P.Size, SUM(P.Price * OD.Quantity) AS TotalRevenue
FROM Pizzas P
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY P.Size
ORDER BY TotalRevenue DESC

--Q9

--English:
--Which pizza has been ordered the most?
SELECT PT.Name, SUM(OD.Quantity) AS TotalQuantitySold
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
ORDER BY TotalQuantitySold DESC

--Q10

--English:
--Which pizza has been ordered the least?
SELECT PT.Name, SUM(OD.Quantity) AS TotalQuantitySold
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Name
ORDER BY TotalQuantitySold

--Q11

--English:
--Which pizza category has the highest number of pizzas sold?
SELECT PT.Category, SUM(OD.Quantity) AS TotalQuantitySold
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Category
ORDER BY TotalQuantitySold DESC