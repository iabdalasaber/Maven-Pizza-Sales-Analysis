--Level 4 — Advanced Business Analysis
--Q36

--English:
--Which pizza types have a total revenue higher than the average total revenue across all pizza types?
WITH PizzaSales AS 
(
SELECT PT.Name, 
SUM(P.Price * O.Quantity) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails O
ON P.PizzaId = O.PizzaId
GROUP BY PT.Name
),
Averages AS 
( 
SELECT AVG(Total_Revenue) AS AVG_Total_Revenue
FROM PizzaSales
)
SELECT * 
FROM PizzaSales PS
CROSS JOIN Averages A
WHERE Ps.Total_Revenue > A.AVG_Total_Revenue

--Q37 — 

--English:
--Which pizza types generate more revenue than the average pizza type revenue within their own category?
WITH PizzaSales AS 
(
SELECT PT.Category, PT.Name,
SUM(P.Price * O.Quantity) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails O
ON P.PizzaId = O.PizzaId
GROUP BY PT.Category, PT.Name
),
Averages AS 
( 
SELECT Category, AVG(Total_Revenue) AS AVG_Total_Revenue
FROM PizzaSales
GROUP BY Category
)
SELECT * 
FROM PizzaSales PS
JOIN Averages A ON PS.Category = A.Category
WHERE Ps.Total_Revenue > A.AVG_Total_Revenue

--Q38 — Ranking

--English:
--What is the revenue rank of each pizza type within its category?
SELECT Category,Name,Total_Revenue,
RANK() OVER(PARTITION BY Category ORDER BY Total_Revenue DESC) AS Revenue_Rank
FROM (
SELECT PT.Category, PT.Name,
SUM(P.Price * O.Quantity) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails O
ON P.PizzaId = O.PizzaId
GROUP BY PT.Category, PT.Name ) AS Total_Orders

--Q39 —

--English:
--What are the top 3 pizza types by revenue within each category?

WITH PizzaSales AS (
SELECT PT.Category, PT.Name,
SUM(P.Price * O.Quantity) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails O
ON P.PizzaId = O.PizzaId
GROUP BY PT.Category, PT.Name 
),
RankedPizzas AS (
SELECT Category,Name,Total_Revenue,
RANK() OVER(PARTITION BY Category ORDER BY Total_Revenue DESC) AS Revenue_Rank
FROM PizzaSales
)
SELECT * FROM RankedPizzas WHERE Revenue_Rank <= 3

--Q40 

--English:
--For each pizza type, what is the difference between its revenue and the previous-ranked pizza type within the same category?
WITH PizzaSales AS (
SELECT PT.Category, PT.Name,
SUM(P.Price * O.Quantity) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails O
ON P.PizzaId = O.PizzaId
GROUP BY PT.Category, PT.Name 
),
Previous AS (
SELECT Category, Name, Total_Revenue,
LAG(Total_Revenue) OVER(PARTITION BY Category ORDER BY Total_Revenue DESC) AS Previous_Revenue
FROM PizzaSales
)
SELECT P.Name, P.Category, P.Total_Revenue, P.Previous_Revenue, 
P.Total_Revenue - P.Previous_Revenue AS Difference
FROM Previous P

--Q41

--English:
--For each month, what was the total revenue and how did it compare with the previous month?
WITH PizzaSales AS (
SELECT DATENAME(MONTH,O.Date) AS Month_Name, DATEPART(MONTH,O.Date) AS Month_Number,
SUM(P.Price * OD.Quantity) AS Total_Revenue
FROM Pizzas P
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
JOIN Orders O
ON OD.OrderId = O.OrderId
GROUP BY DATENAME(MONTH,O.Date),DATEPART(MONTH,O.Date)
),
Previous AS (
SELECT Month_Name, Month_Number, Total_Revenue,
LAG(Total_Revenue) OVER(ORDER BY Month_Number) AS Previous_Month_Revenue
FROM PizzaSales
)
SELECT Month_Name, Month_Number, Total_Revenue, Previous_Month_Revenue,
Total_Revenue - Previous_Month_Revenue AS Difference
FROM Previous 

--Q42

--English:
--Which months had higher revenue than the previous month?
WITH PizzaSales AS (
SELECT DATENAME(MONTH,O.Date) AS Month_Name, DATEPART(MONTH,O.Date) AS Month_Number,
SUM(P.Price * OD.Quantity) AS Total_Revenue
FROM Pizzas P
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
JOIN Orders O
ON OD.OrderId = O.OrderId
GROUP BY DATENAME(MONTH,O.Date),DATEPART(MONTH,O.Date)
),
Previous AS (
SELECT Month_Name, Month_Number, Total_Revenue,
LAG(Total_Revenue) OVER(ORDER BY Month_Number ) AS Previous_Month_Revenue
FROM PizzaSales
)
SELECT Month_Name, Month_Number, Total_Revenue, Previous_Month_Revenue,
Total_Revenue - Previous_Month_Revenue AS Difference
FROM Previous 
WHERE Total_Revenue > Previous_Month_Revenue

--Q43

--English:
--For each pizza type, what percentage of its category's total revenue does it contribute?
WITH PizzaSales AS (
SELECT PT.Category, Pt.Name,
SUM(P.Price * OD.Quantity) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Category, Pt.Name
),
CategoryRevenue AS (
SELECT Category, Name, Total_Revenue,
SUM(Total_Revenue) OVER(PARTITION BY Category) AS Category_Revenue
FROM PizzaSales
)
SELECT 
Category, Name, Total_Revenue, Category_Revenue,
(Total_Revenue / Category_Revenue) * 100 AS Percentage
FROM CategoryRevenue
ORDER BY Total_Revenue DESC

--Q44

--English:
--For each category, identify the highest-revenue pizza type and show its percentage contribution to the category's total revenue.
WITH PizzaSales AS (
SELECT PT.Category, PT.Name,
SUM(P.Price * OD.Quantity) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Category, PT.Name
),
CategoryRevenue AS (
SELECT Category, Name, Total_Revenue,
SUM(Total_Revenue) OVER(PARTITION BY Category) AS Category_Revenue
FROM PizzaSales
),
RankedPizzas AS (
SELECT Category,Name,Total_Revenue,Category_Revenue,
RANK() OVER(PARTITION BY Category ORDER BY Total_Revenue DESC) AS Revenue_Rank
FROM CategoryRevenue
)
SELECT 
Category, Name, Total_Revenue, Category_Revenue, Revenue_Rank,
(Total_Revenue / Category_Revenue) * 100 AS Percentage
FROM RankedPizzas
WHERE Revenue_Rank = 1

--Q45 —

--English:
--For each category, identify the top 3 pizza types by revenue and show their percentage contribution to the category's total revenue.
WITH PizzaSales AS (
SELECT PT.Category, PT.Name,
SUM(P.Price * OD.Quantity) AS Total_Revenue
FROM PizzaTypes PT
JOIN Pizzas P
ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
ON P.PizzaId = OD.PizzaId
GROUP BY PT.Category, PT.Name
),
CategoryRevenue AS (
SELECT Category, Name, Total_Revenue,
SUM(Total_Revenue) OVER(PARTITION BY Category) AS Category_Revenue
FROM PizzaSales
),
RankedPizzas AS (
SELECT Category,Name,Total_Revenue,Category_Revenue,
RANK() OVER(PARTITION BY Category ORDER BY Total_Revenue DESC) AS Revenue_Rank
FROM CategoryRevenue
)
SELECT 
Category, Name, Total_Revenue, Category_Revenue, Revenue_Rank,
(Total_Revenue / Category_Revenue) * 100 AS Percentage
FROM RankedPizzas
WHERE Revenue_Rank <= 3