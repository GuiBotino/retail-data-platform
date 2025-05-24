import pyodbc
import random
from faker import Faker
from db_config import get_connection

fake = Faker()

brands = ['Nike', 'Adidas', 'Apple', 'Samsung', 'Sony', 'LG']
categories = ['Electronics', 'Apparel', 'Sports', 'Home', 'Toys']

def generate_product():
    brand = random.choice(brands)
    product_name = f"{brand} {fake.word().capitalize()}"
    category = random.choice(categories)
    price = round(random.uniform(10, 5000), 2)
    sku = f"{brand[:3].upper()}-{random.randint(1000,9999)}"
    return (product_name, category, brand, price, sku)

def insert_products(conn, count=100):
    cursor = conn.cursor()
    for _ in range(count):
        product = generate_product()
        cursor.execute("""
            INSERT INTO dwh.DimProduct (ProductName, Category, Brand, Price, SKU)
            VALUES (?, ?, ?, ?, ?)""", product)
    conn.commit()
    cursor.close()

if __name__ == "__main__":
    conn = get_connection()
    insert_products(conn)
    conn.close()
