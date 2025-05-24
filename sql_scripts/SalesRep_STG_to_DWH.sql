-- Deduplicate based on FullName + HireDate (assuming these uniquely identify a Sales Rep)
WITH DeduplicatedStaging AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY FullName, HireDate
               ORDER BY Region
           ) AS rn
    FROM stg.SalesRep
)
INSERT INTO dwh.DimSalesRep (
    FullName,
    HireDate,
    Region,
    Manager
)
SELECT 
    FullName,
    HireDate,
    Region,
    Manager
FROM DeduplicatedStaging
WHERE rn = 1;
