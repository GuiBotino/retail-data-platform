-- Deduplicate based on SKU (assuming these uniquely identify a Product)
WITH DeduplicatedStaging AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY SKU ORDER BY ProductName) AS rn
    FROM stg.Product
)
INSERT INTO dwh.DimProduct (
    ProductName,
    Category,
    Brand,
    Price,
    SKU
)
SELECT 
    ProductName,
    Category,
    Brand,
    Price,
    SKU
FROM DeduplicatedStaging
WHERE rn = 1;
