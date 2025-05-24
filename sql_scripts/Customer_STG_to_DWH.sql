-- Deduplicate based on email (assuming these uniquely identify a Customer)
WITH DeduplicatedStaging AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Email ORDER BY SignupDate DESC) AS rn
    FROM stg.Customer
)
INSERT INTO dwh.DimCustomer (
    FullName,
    Gender,
    BirthDate,
    SignupDate,
    Email,
    Phone,
    State,
    City
)
SELECT 
    FullName,
    Gender,
    BirthDate,
    SignupDate,
    Email,
    Phone,
    State,
    City
FROM DeduplicatedStaging
WHERE rn = 1;
