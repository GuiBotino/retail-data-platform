-- Create staging schema if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'stg')
    EXEC('CREATE SCHEMA stg');
GO

-- Customers staging
CREATE TABLE stg.Customer (
    FullName VARCHAR(100),
    Gender CHAR(1),
    BirthDate DATE,
    SignupDate DATETIME,
    Email VARCHAR(100),
    Phone VARCHAR(15),
    State VARCHAR(50),
    City VARCHAR(50)
);

-- Products staging
CREATE TABLE stg.Product (
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    Price MONEY,
    SKU VARCHAR(50)
);

-- Stores staging
CREATE TABLE stg.Store (
    StoreName VARCHAR(100),
    State VARCHAR(50),
    City VARCHAR(50),
    StoreType VARCHAR(20),
    OpenDate DATE
);

-- Sales reps staging
CREATE TABLE stg.SalesRep (
    FullName VARCHAR(100),
    HireDate DATE,
    Region VARCHAR(50),
    Manager VARCHAR(100)
);

-- Dates staging
CREATE TABLE stg.Date (
    DateID INT,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    WeekDay VARCHAR(10),
    IsWeekend CHAR(1)
);

-- Sales facts staging
CREATE TABLE stg.FactSales (
    DateID INT,
    CustomerEmail VARCHAR(100),
    ProductSKU VARCHAR(50),
    StoreName VARCHAR(100),
    SalesRepName VARCHAR(100),
    Quantity INT,
    UnitPrice MONEY,
    Discount MONEY
);
