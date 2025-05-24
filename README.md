# Retail Sales Data Engineering Project

This project simulates a real-world retail sales data pipeline, from raw data ingestion to a complete business intelligence dashboard. The solution integrates local and Azure components to represent a hybrid data platform.

---

## 🧱 Project Architecture

- **Raw Data**: CSV files representing retail sales and dimensions.
- **ETL & Data Movement**: Azure Data Factory for ingestion, transformation, and staging into a SQL Data Warehouse.
- **Data Warehouse**: Dimensional model built in a local SQL Server instance.
- **Data Visualization**: Power BI dashboard built from the data warehouse.

---

## 📁 Project Structure

repo/
│
├── ADF/ # Contains JSON assets exported from Azure Data Factory
├── sql_scripts/ # T-SQL scripts for DWH and staging table creation
├── python_scripts/ # Optional Python scripts (if used for transformation or automation)
├── raw_data/ # All original CSVs used for ingestion
└── powerbi/ # Power BI (.pbix) file and related assets


---

## 🚀 How It Works

1. **Data Ingestion**: ADF pipelines load CSV files from Azure Blob Storage to SQL Server staging tables.
2. **Transformation**: Data is cleaned and transformed in SQL before loading into the data warehouse.
3. **Data Warehouse**: Star schema with dimension and fact tables.
4. **Reporting**: Power BI dashboard connects directly to the DWH for KPIs and insights.

---

## 📊 Dashboard Features

- Total Sales and Total Quantity KPIs
- Sales by Product (Top 10)
- Sales by Region (Map)
- Monthly Trends
- Category Breakdown (Pie Chart)

---

## 💻 Technologies Used

- **SQL Server** (local instance)
- **Azure Data Factory**
- **Azure Blob Storage**
- **Power BI**
- **Git & GitHub**

---

## 📝 Author

- GitHub: [GuiBotino]
- LinkedIn: [www.linkedin.com/in/guilherme-botino]
