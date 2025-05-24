import pyodbc
from faker import Faker
from db_config import get_connection
import random

fake = Faker()
store_types = ['Physical', 'Online', 'Hybrid']

def generate_store():
    return (
        fake.company(),
        fake.state(),
        fake.city(),
        random.choice(store_types),
        fake.date_between(start_date='-10y', end_date='today')
    )

def insert_stores(conn, count=50):
    cursor = conn.cursor()
    for _ in range(count):
        store = generate_store()
        cursor.execute("""
            INSERT INTO dwh.DimStore (StoreName, State, City, StoreType, OpenDate)
            VALUES (?, ?, ?, ?, ?)""", store)
    conn.commit()
    cursor.close()

if __name__ == "__main__":
    conn = get_connection()
    insert_stores(conn)
    conn.close()
