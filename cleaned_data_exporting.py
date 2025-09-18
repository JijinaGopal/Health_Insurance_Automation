import pyodbc
import pandas as pd

# Connect to SQL Server
conn = pyodbc.connect(
    'DRIVER={SQL Server};'
    'SERVER=LAPTOP-2K6MH8QU\SQLEXPRESS;'
    'DATABASE=Health_Insurance;'
    'Trusted_Connection=yes;'
)

table="health_insurance_dataset"

df = pd.read_sql(f"SELECT * FROM {table}", conn)

# Overwrite the original CSV
df.to_csv('C:/Users/Administrator/Desktop/Internship/Insurance_Operations/Health Insurance Claims/Automation/health_insurance_dataset.csv', index=False)
conn.close()