# Sales Data Warehouse & Analytics System

A Microsoft SQL Server project focused on sales, customer, and product analytics using a star-schema-style data model and business-oriented SQL reporting.

## Project Overview

This project uses customer, product, and sales transaction data to build a small analytical database and answer practical business questions such as:

- What are the overall sales and order KPIs?
- Which products and categories generate the most revenue?
- Who are the highest-value customers?
- How do sales change over time?
- Which customers are VIP, Regular, or New?
- Which products are high, mid-range, or low performers?
- What percentage of total revenue comes from each category?
- Which customers have not purchased recently?

## Tech Stack

- **Database:** Microsoft SQL Server
- **Tool:** SQL Server Management Studio (SSMS)
- **Language:** T-SQL
- **Data:** CSV files containing customers, products, and sales transactions

## Database Design

The database follows a simple analytical/star-schema-style structure:

```text
                 dim_customers
                       |
                       |
                       v
                 fact_sales
                       ^
                       |
                       |
                  dim_products
```

### Tables

**gold.dim_customers**
- Customer information
- Name, country, gender, birthdate, customer number, etc.

**gold.dim_products**
- Product information
- Product name, category, subcategory, cost, product line, etc.

**gold.fact_sales**
- Transaction-level sales data
- Order, product, customer, dates, sales amount, quantity, and price

## SQL Analysis Covered

The project demonstrates:

- Database and schema creation
- Table and column exploration
- Data profiling
- Joins
- GROUP BY and HAVING
- Aggregate functions: `SUM`, `AVG`, `COUNT`, `MIN`, `MAX`
- CTEs
- `CASE` expressions
- Date functions such as `DATEDIFF`, `YEAR`, `MONTH`, and `DATETRUNC`
- Window functions
- `RANK()` and `LAG()`
- Running totals and moving averages
- Ranking analysis
- Time-series analysis
- Customer segmentation
- Product performance segmentation
- Part-to-whole analysis
- SQL views
- Business KPI reporting

## Project Structure

```text
sql-data-analytics-project/
├── datasets/
│   └── flat-files/
│       ├── dim_customers.csv
│       ├── dim_products.csv
│       └── fact_sales.csv
├── scripts/
│   ├── 00_init_database.sql
│   ├── 01_database_exploration.sql
│   ├── 02_dimensions_exploration.sql
│   ├── 03_date_range_exploration.sql
│   ├── 04_measures_exploration.sql
│   ├── 05_magnitude_analysis.sql
│   ├── 06_ranking_analysis.sql
│   ├── 07_change_over_time_analysis.sql
│   ├── 08_cumulative_analysis.sql
│   ├── 09_performance_analysis.sql
│   ├── 10_data_segmentation.sql
│   ├── 11_part_to_whole_analysis.sql
│   ├── 12_report_customers.sql
│   ├── 13_report_products.sql
│   └── 14_my_business_analysis.sql
├── .gitignore
├── LICENSE
└── README.md
```

## Key Reports

### Customer Report

`gold.report_customers` provides customer-level metrics including:

- Customer name and age group
- Customer segment
- Total orders
- Total sales
- Total quantity purchased
- Number of products purchased
- Last order date
- Recency
- Customer lifespan
- Average order value
- Average monthly spend

### Product Report

`gold.report_products` provides product-level metrics including:

- Product/category information
- Product segment
- Total orders
- Total sales
- Total quantity sold
- Unique customers
- Last sale date
- Recency
- Product lifespan
- Average selling price
- Average order revenue
- Average monthly revenue

## How to Run

1. Install Microsoft SQL Server and SQL Server Management Studio (SSMS).
2. Download or clone this repository.
3. Extract the project to a local folder.
4. Open `scripts/00_init_database.sql` in SSMS.
5. Enable **Query → SQLCMD Mode**.
6. Update the `ProjectRoot` variable at the top of the script to your local project folder.
7. Execute `00_init_database.sql` to create the database, schema, tables, and load the CSV data.
8. Run the analysis scripts in order.
9. Execute `12_report_customers.sql` and `13_report_products.sql` to create the reporting views.
10. Run `14_my_business_analysis.sql` for additional business-focused analysis.

> **Note:** `00_init_database.sql` drops and recreates the `DataWarehouseAnalytics` database. Do not run it against a database containing data you need to preserve.

## Portfolio Objective

The goal of this project is to demonstrate practical SQL and database skills through an end-to-end analytical workflow: loading structured data, exploring the database, analyzing business metrics, creating reusable reporting views, and extracting customer and product insights with T-SQL.

## Resume Summary

This project can be presented as a SQL/database project for entry-level roles requiring SQL, database querying, data analysis, or backend development skills.
