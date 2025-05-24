import pyodbc

def get_connection():
    conn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=WINAP7LBCPYDBI7;'  # change if needed
        'DATABASE=RetailDW;'  # your DWH name
        'Trusted_Connection=yes;'  # or add UID/PWD for SQL Auth
    )
    return conn