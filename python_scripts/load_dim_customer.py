from faker import Faker
import random
from db_config import get_connection

fake = Faker('en-US')

conn = get_connection()
cursor = conn.cursor()

# Load DimCustomer
def load_customers(n=100):
    for _ in range(n):
        full_name = fake.name()
        gender = random.choice(['M', 'F'])
        birth_date = fake.date_of_birth(minimum_age=18, maximum_age=70)
        signup_date = fake.date_time_between(start_date='-2y', end_date='now')
        email = fake.email()
        phone = fake.phone_number()
        state = fake.state()
        city = fake.city()

        cursor.execute('''
            INSERT INTO dwh.DimCustomer 
            (FullName, Gender, BirthDate, SignupDate, Email, Phone, State, City)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''', (full_name, gender, birth_date, signup_date, email, phone, state, city))
    conn.commit()
    print(f"{n} customers inserted.")

# Add similar functions for other dimensions here (e.g., load_products, load_stores...)

# Main
if __name__ == "__main__":
    load_customers()