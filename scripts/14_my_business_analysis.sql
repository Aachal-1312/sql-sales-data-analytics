/*
===============================================================================
My Business Analysis
===============================================================================
Purpose:
    Additional business questions created for the portfolio version of the
    project. These analyses go beyond the core exploration scripts.
===============================================================================
*/

-- 1. Monthly revenue and month-over-month change
WITH monthly_sales AS (
    SELECT
        DATETRUNC(month, order_date) AS sales_month,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
)
SELECT
    sales_month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY sales_month) AS previous_month_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY sales_month) AS sales_change
FROM monthly_sales
ORDER BY sales_month;

-- 2. Top 10 customers by revenue with their share of total sales
WITH customer_sales AS (
    SELECT
        c.customer_key,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    INNER JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key, c.first_name, c.last_name
)
SELECT TOP 10
    customer_key,
    customer_name,
    total_sales,
    ROUND(100.0 * total_sales / SUM(total_sales) OVER (), 2) AS sales_share_pct
FROM customer_sales
ORDER BY total_sales DESC;

-- 3. Product categories ranked by revenue contribution
WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    INNER JOIN gold.dim_products p
        ON f.product_key = p.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS revenue_rank,
    ROUND(100.0 * total_sales / SUM(total_sales) OVER (), 2) AS revenue_share_pct
FROM category_sales
ORDER BY revenue_rank;

-- 4. Customers with no purchase in the last 12 months
SELECT
    c.customer_key,
    c.customer_number,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    MAX(f.order_date) AS last_order_date,
    DATEDIFF(month, MAX(f.order_date), GETDATE()) AS months_since_last_order
FROM gold.dim_customers c
LEFT JOIN gold.fact_sales f
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.customer_number,
    c.first_name,
    c.last_name
HAVING MAX(f.order_date) IS NULL
    OR DATEDIFF(month, MAX(f.order_date), GETDATE()) >= 12
ORDER BY months_since_last_order DESC;
