INSERT INTO dwh.FactSales (
    DateID,
    CustomerID,
    ProductID,
    StoreID,
    SalesRepID,
    Quantity,
    UnitPrice,
    Discount
)
SELECT
    d.DateID,
    c.CustomerID,
    p.ProductID,
    s.StoreID,
    r.SalesRepID,
    fs.Quantity,
    fs.UnitPrice,
    fs.Discount
FROM stg.FactSales fs
JOIN dwh.DimDate d
    ON d.DateID = fs.DateID
JOIN dwh.DimCustomer c
    ON c.Email = fs.CustomerEmail
JOIN dwh.DimProduct p
    ON p.SKU = fs.ProductSKU
JOIN dwh.DimStore s
    ON s.StoreName = fs.StoreName
JOIN dwh.DimSalesRep r
    ON r.FullName = fs.SalesRepName;
