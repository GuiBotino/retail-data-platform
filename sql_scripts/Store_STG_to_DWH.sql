-- Deduplicate based on StoreName + City + State (assuming these uniquely identify a Store)
WITH DeduplicatedStaging AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY StoreName, City, State
               ORDER BY OpenDate DESC
           ) AS rn
    FROM stg.Store
)
INSERT INTO dwh.DimStore (
    StoreName,
    State,
    City,
    StoreType,
    OpenDate
)
SELECT 
    StoreName,
    State,
    City,
    StoreType,
    OpenDate
FROM DeduplicatedStaging
WHERE rn = 1;
