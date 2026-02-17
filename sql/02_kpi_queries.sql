/* ============================================================
   E-Commerce Sales Dashboard - KPI Queries
   File: sql/02_kpi_queries.sql
   ============================================================ */

-- 1) Total Revenue, Total Orders, Total Customers
SELECT
  SUM(revenue)                        AS total_revenue,
  COUNT(DISTINCT order_id)            AS total_orders,
  COUNT(DISTINCT customer_key)        AS total_customers
FROM fact_sales;

-- 2) Average Order Value (AOV)
SELECT
  SAFE_DIVIDE(SUM(revenue), COUNT(DISTINCT order_id)) AS aov
FROM fact_sales;

-- 3) Monthly Revenue Trend
SELECT
  d.year,
  d.month,
  d.month_name,
  SUM(f.revenue) AS monthly_revenue
FROM fact_sales f
JOIN dim_date d
  ON f.date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;

-- 4) Top 10 Products by Revenue
SELECT
  p.product_name,
  p.category,
  SUM(f.revenue) AS product_revenue
FROM fact_sales f
JOIN dim_product p
  ON f.product_key = p.product_key
GROUP BY p.product_name, p.category
ORDER BY product_revenue DESC
LIMIT 10;

-- 5) Top Customers by Revenue
SELECT
  c.customer_name,
  c.segment,
  SUM(f.revenue) AS customer_revenue
FROM fact_sales f
JOIN dim_customer c
  ON f.customer_key = c.customer_key
GROUP BY c.customer_name, c.segment
ORDER BY customer_revenue DESC
LIMIT 10;

-- 6) Category Performance
SELECT
  p.category,
  SUM(f.revenue) AS category_revenue,
  SUM(f.quantity) AS total_units_sold
FROM fact_sales f
JOIN dim_product p
  ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 7) Revenue After Discount (if revenue not net)
-- If revenue is gross, calculate net revenue:
-- SELECT SUM((unit_price * quantity) - discount) AS net_revenue FROM fact_sales;

