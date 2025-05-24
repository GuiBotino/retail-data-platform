import pandas as pd

# 1. Ler o arquivo CSV
df = pd.read_csv(r"C:\Users\guilherme.a.botino\Documents\retail-data-platform\raw_data\sales_data.csv")

# 2. Calcular Discount: (Quantity * UnitPrice) * 0.1
df['Discount'] = ((df['Quantity'] * df['UnitPrice']) * 0.1).round(2)

# 3. Salvar no mesmo arquivo CSV
df.to_csv(r"C:\Users\guilherme.a.botino\Documents\retail-data-platform\raw_data\sales_data.csv", index=False)