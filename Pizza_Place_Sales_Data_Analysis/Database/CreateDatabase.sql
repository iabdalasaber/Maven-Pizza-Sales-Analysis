CREATE DATABASE MavenPizza;
GO

USE MavenPizza;
GO


CREATE TABLE Pizzas (
    PizzaId NVARCHAR(50) PRIMARY KEY,
	Size NVARCHAR(10) NOT NULL,
	Price DECIMAL(10,2) NOT NULL,
	PizzaTypeId NVARCHAR(50) NOT NULL
)


CREATE TABLE PizzaTypes(
    PizzaId NVARCHAR(50) PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	Category NVARCHAR(100) NOT NULL,
	ingredients NVARCHAR(200) NOT NULL
)

CREATE TABLE Orders(
    OrderId INT PRIMARY KEY,
	Date DATE NOT NULL,
	Time TIME NOT NULL
)

CREATE TABLE OrderDetails(
    OrderDetailsId INT PRIMARY KEY,
	OrderId INT NOT NULL,
	PizzaId NVARCHAR(50) NOT NULL,
	Quantity INT NOT NULL
)

ALTER TABLE Pizzas
ADD CONSTRAINT FK_Pizzas_PizzaTypes
FOREIGN KEY (PizzaTypeId)
REFERENCES PizzaTypes(PizzaTypeId);
GO

ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_Orders
FOREIGN KEY (OrderId)
REFERENCES Orders(OrderId);
GO

ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_Pizzas
FOREIGN KEY (PizzaId)
REFERENCES Pizzas(PizzaID);
GO
