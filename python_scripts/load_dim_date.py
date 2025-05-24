import pyodbc
from datetime import datetime, timedelta
from db_config import get_connection

def generate_dates(start_date, end_date):
    current_date = start_date
    while current_date <= end_date:
        # Generate DateID in YYYYMMDD format
        date_id = current_date.strftime('%Y%m%d')  # Example: '20230513'
        
        yield (
            date_id,  # DateID
            current_date,  # FullDate
            current_date.day,
            current_date.month,
            current_date.year,
            (current_date.month - 1) // 3 + 1,  # Quarter
            current_date.strftime('%A'),  # WeekDay
            'Y' if current_date.weekday() >= 5 else 'N'  # IsWeekend
        )
        current_date += timedelta(days=1)

def insert_dates(conn, start_date, end_date):
    cursor = conn.cursor()
    for date in generate_dates(start_date, end_date):
        cursor.execute("""
            INSERT INTO dwh.DimDate (DateID, FullDate, Day, Month, Year, Quarter, WeekDay, IsWeekend)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)""", date)
    conn.commit()
    cursor.close()

if __name__ == "__main__":
    conn = get_connection()
    insert_dates(conn, datetime(2019, 1, 1), datetime(2025, 12, 31))
    conn.close()
