import pyodbc
import pandas as pd
import random
from db_config import get_connection

# Connect to SQL Server
conn = get_connection()
cursor = conn.cursor()

# Load CSV data
df = pd.read_csv(r"C:\Users\guilherme.a.botino\Documents\retail-data-platform\raw_data\sales_data.csv")

df['UnitPrice'] = pd.to_numeric(df['UnitPrice'], errors='coerce').round(4)
df['Discount'] = pd.to_numeric(df['Discount'], errors='coerce').round(4)
df['Quantity'] = pd.to_numeric(df['Quantity'], errors='coerce')

for index, row in df.iterrows():
    # Look up DateID from DimDate
    cursor.execute("""
        SELECT DateID FROM dwh.DimDate WHERE FullDate = ?
    """, row['FullDate'])
    date_result = cursor.fetchone()
    if not date_result:
        print(f"Date not found: {row['FullDate']}")
        continue
    date_id = date_result[0]

    # Look up CustomerID from DimCustomer using Email
    cursor.execute("""
        SELECT CustomerID FROM dwh.DimCustomer WHERE Email = ?
    """, row['CustomerEmail'])
    cust_result = cursor.fetchone()
    if not cust_result:
        print(f"Customer not found: {row['CustomerEmail']}")
        continue
    customer_id = cust_result[0]

    # Look up ProductID from DimProduct using SKU
    cursor.execute("""
        SELECT ProductID FROM dwh.DimProduct WHERE SKU = ?
    """, row['ProductSKU'])
    prod_result = cursor.fetchone()
    if not prod_result:
        print(f"Product not found: {row['ProductSKU']}")
        continue
    product_id = prod_result[0]
    
    # Look up StoreID from DimStore using StoreName
    cursor.execute("""
        SELECT StoreID FROM dwh.DimStore WHERE StoreName = ?
    """, row['StoreName'])
    store_result = cursor.fetchone()
    if not store_result:
        print(f"Store not found: {row['StoreName']}")
        continue
    store_id = store_result[0]

    # Look up SalesRepID from DimSalesRep using FullName
    cursor.execute("""
        SELECT SalesRepID FROM dwh.DimSalesRep WHERE FullName = ?
    """, row['SalesRepFullName'])
    salrep_result = cursor.fetchone()
    if not salrep_result:
        print(f"SalesRep not found: {row['SalesRepFullName']}")
        continue
    salrep_id = salrep_result[0]
    
    # Insert row into FactSales
    cursor.execute("""
        INSERT INTO dwh.FactSales (
            DateID, CustomerID, ProductID, StoreID, SalesRepID, Quantity, UnitPrice, Discount
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """, int(date_id), 
    int(customer_id), 
    int(product_id), 
    int(store_id), 
    int(salrep_id), 
    int(row['Quantity']), 
    float(row['UnitPrice']), 
    float(row['Discount'])
)

# Commit changes and close connection
conn.commit()
cursor.close()
conn.close()

print("FactSales table loaded successfully.")
