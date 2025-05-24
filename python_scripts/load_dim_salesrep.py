import pyodbc
from faker import Faker
from db_config import get_connection
import random

fake = Faker()
regions = ['North', 'South', 'East', 'West', 'Central']

def generate_salesrep():
    return (
        fake.name(),
        fake.date_between(start_date='-10y', end_date='-1y'),
        random.choice(regions),
        fake.name()
    )

def insert_salesreps(conn, count=30):
    cursor = conn.cursor()
    for _ in range(count):
        rep = generate_salesrep()
        cursor.execute("""
            INSERT INTO dwh.DimSalesRep (FullName, HireDate, Region, Manager)
            VALUES (?, ?, ?, ?)""", rep)
    conn.commit()
    cursor.close()

if __name__ == "__main__":
    conn = get_connection()
    insert_salesreps(conn)
    conn.close()
