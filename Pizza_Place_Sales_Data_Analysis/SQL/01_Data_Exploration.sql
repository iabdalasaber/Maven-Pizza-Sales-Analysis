--01 - Data Exploration
  
--Q1. How many orders do we have each day?
--Are there any peak hours?


-- Q1.1 Number of orders per day
SELECT 
    Date,
    DATENAME(DAY, Date) AS DayName,
    COUNT(OrderId) AS TotalOrders
FROM Orders
GROUP BY Date
ORDER BY TotalOrders DESC


-- Q1.2 Peak hours based on number of orders
SELECT 
    DATEPART(HOUR, Time) AS Hour,
    COUNT(OrderId) AS TotalOrders
FROM Orders
GROUP BY DATEPART(HOUR, Time)
ORDER BY TotalOrders DESC


--Q2. How many pizzas are typically in an order?
--Do we have any bestsellers?

-- Q2.1 Number of pizzas in each order
SELECT 
    OrderId,
    SUM(Quantity) AS TotalPizzasPerOrder
FROM OrderDetails
GROUP BY OrderId
ORDER BY TotalPizzasPerOrder DESC


-- Q2.2 Average number of pizzas per order
SELECT 
    AVG(TotalPizzasPerOrder) AS AveragePizzasPerOrder
FROM (
    SELECT 
        OrderId,
        SUM(Quantity) AS TotalPizzasPerOrder
    FROM OrderDetails
    GROUP BY OrderId
) AS OrderTotals


-- Q2.3 Bestselling pizzas by quantity sold
SELECT 
    PizzaId,
    SUM(Quantity) AS TotalQuantitySold
FROM OrderDetails
GROUP BY PizzaId
ORDER BY TotalQuantitySold DESC


--Q3. How much money did we make this year?
--Can we identify any seasonality in the sales?

-- Q3.1 Total revenue for the current year
SELECT 
    SUM(P.Price * OD.Quantity) AS TotalRevenue
FROM Pizzas P
JOIN OrderDetails OD
    ON P.PizzaId = OD.PizzaId
JOIN Orders O
    ON OD.OrderId = O.OrderId
WHERE YEAR(O.Date) = YEAR(GETDATE())


-- Q3.2 Monthly revenue to identify sales patterns
SELECT 
    MONTH(O.Date) AS MonthNumber,
    DATENAME(MONTH, O.Date) AS MonthName,
    SUM(P.Price * OD.Quantity) AS TotalRevenue
FROM Pizzas P
JOIN OrderDetails OD
    ON P.PizzaId = OD.PizzaId
JOIN Orders O
    ON OD.OrderId = O.OrderId
GROUP BY 
    MONTH(O.Date),
    DATENAME(MONTH, O.Date)
ORDER BY MonthNumber


--Q4. Are there any pizzas we should take off the menu,
--or any promotions we could leverage?

-- Q4.1 Pizzas with the lowest sales quantity
-- These pizzas can be reviewed before making menu decisions.
SELECT 
    P.PizzaId,
    PT.Name,
    SUM(OD.Quantity) AS TotalQuantitySold
FROM PizzaTypes PT
JOIN Pizzas P
    ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
    ON P.PizzaId = OD.PizzaId
GROUP BY 
    P.PizzaId,
    PT.Name
ORDER BY TotalQuantitySold ASC


-- Q4.2 Sales quantity by category
-- Useful for identifying categories with stronger
-- or weaker demand and possible promotion opportunities.
SELECT 
    PT.Category,
    SUM(OD.Quantity) AS TotalQuantitySold
FROM PizzaTypes PT
JOIN Pizzas P
    ON PT.PizzaTypeId = P.PizzaTypeId
JOIN OrderDetails OD
    ON P.PizzaId = OD.PizzaId
GROUP BY PT.Category
ORDER BY TotalQuantitySold DESC