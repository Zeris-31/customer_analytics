import pandas as pd
import random
from faker import Faker
import psycopg2

fake = Faker()

conn = psycopg2.connect(
    host="localhost",
    database="customer_analytics",
    user="postgres",
    password="311206"
)

cur = conn.cursor()

customers = []
for _ in range(500):
    customers.append((
        fake.name(),
        fake.email(),
        random.choice(["Male", "Female"]),
        fake.city(),
        fake.date_between(start_date='-2y', end_date='today')
    ))

cur.executemany("""
INSERT INTO customers (full_name, email, gender, city, registration_date)
VALUES (%s, %s, %s, %s, %s)
""", customers)

conn.commit()

products = []
categories = ["Electronics", "Clothing", "Home", "Sports"]

for i in range(50):
    products.append((
        f"Product_{i}",
        random.choice(categories),
        round(random.uniform(10, 500), 2)
    ))

cur.executemany("""
INSERT INTO products (product_name, category, price)
VALUES (%s, %s, %s)
""", products)

conn.commit()

sales = []
for _ in range(5000):
    customer_id = random.randint(1, 500)
    product_id = random.randint(1, 50)
    quantity = random.randint(1, 5)
    price = random.uniform(10, 500)
    total = round(quantity * price, 2)

    sales.append((
        customer_id,
        product_id,
        quantity,
        fake.date_between(start_date='-1y', end_date='today'),
        total
    ))

cur.executemany("""
INSERT INTO sales (customer_id, product_id, quantity, sale_date, total_amount)
VALUES (%s, %s, %s, %s, %s)
""", sales)

conn.commit()

cur.close()
conn.close()

print("Datos generados correctamente 🚀")