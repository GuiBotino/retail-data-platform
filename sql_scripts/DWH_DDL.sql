-- Create DWH schema if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dwh')
    EXEC('CREATE SCHEMA dwh');
GO


-- Customers dwh
CREATE TABLE dwh.DimCustomer (
	CustomerID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	FullName VARCHAR(100) NOT NULL,
	Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F')),
	BirthDate DATE NOT NULL,
	SignupDate DATETIME NOT NULL DEFAULT GETDATE(),
	Email VARCHAR(100) NOT NULL,
	Phone VARCHAR(15) NOT NULL,
	State VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL
)

-- Product dwh
CREATE TABLE dwh.DimProduct (
	ProductID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	ProductName VARCHAR(50) NOT NULL,
	Category VARCHAR(50) NOT NULL,
	Brand VARCHAR(50) NOT NULL,
	Price MONEY NOT NULL,
	SKU VARCHAR(50) UNIQUE NOT NULL
)

-- Store dwh
CREATE TABLE dwh.DimStore (
	StoreID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	StoreName VARCHAR(100) NOT NULL,
	State VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
	StoreType VARCHAR(20) NOT NULL,
	OpenDate DATE
)

-- SalesRep dwh
CREATE TABLE dwh.DimSalesRep (
	SalesRepID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	FullName VARCHAR(100) NOT NULL,
	HireDate DATE NOT NULL,
	Region VARCHAR(50) NOT NULL,
	Manager VARCHAR(100) NOT NULL
)

-- Date dwh
CREATE TABLE dwh.DimDate (
	DateID INT PRIMARY KEY NOT NULL,
	FullDate DATE NOT NULL,
	Day INT NOT NULL,
	Month INT NOT NULL,
	Year INT NOT NULL,
	Quarter INT NOT NULL,
	WeekDay VARCHAR(10) NOT NULL,
	IsWeekend CHAR(1) NOT NULL CHECK (IsWeekend IN ('Y', 'N')) DEFAULT 'N'
)

-- FactSales dwh
CREATE TABLE dwh.FactSales (
	SaleID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	DateID INT NOT NULL,
	CustomerID INT NOT NULL,
	ProductID INT NOT NULL,
	StoreID INT NOT NULL,
	SalesRepID INT NOT NULL,
	Quantity INT NOT NULL CHECK (Quantity >= 0),
	UnitPrice MONEY NOT NULL,
	Discount MONEY NOT NULL,
	TotalAmount AS ((Quantity * UnitPrice) - Discount) PERSISTED,
	FOREIGN KEY (DateID) REFERENCES dwh.DimDate(DateID),
	FOREIGN KEY (CustomerID) REFERENCES dwh.DimCustomer(CustomerID),
	FOREIGN KEY (ProductID) REFERENCES dwh.DimProduct(ProductID),
	FOREIGN KEY (StoreID) REFERENCES dwh.DimStore(StoreID),
	FOREIGN KEY (SalesRepID) REFERENCES dwh.DimSalesRep(SalesRepID)
)

-- NonClustered indexes on the Foreign Keys (good practice)
CREATE NONCLUSTERED INDEX IX_FactSales_DateID ON dwh.FactSales(DateID);
CREATE NONCLUSTERED INDEX IX_FactSales_CustomerID ON dwh.FactSales(CustomerID);
CREATE NONCLUSTERED INDEX IX_FactSales_ProductID ON dwh.FactSales(ProductID);
CREATE NONCLUSTERED INDEX IX_FactSales_StoreID ON dwh.FactSales(StoreID);
CREATE NONCLUSTERED INDEX IX_FactSales_SalesRepID ON dwh.FactSales(SalesRepID);
