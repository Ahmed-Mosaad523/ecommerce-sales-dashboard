/* ============================================================
   E-Commerce Sales Dashboard - Star Schema Design
   ============================================================ */

-- =========================
-- DIMENSION TABLES
-- =========================

CREATE TABLE dim_date (
  date_key        INT PRIMARY KEY,
  full_date       DATE,
  year            INT,
  quarter         INT,
  month           INT,
  month_name      VARCHAR(20),
  day_of_month    INT,
  day_name        VARCHAR(20)
);

CREATE TABLE dim_product (
  product_key     INT PRIMARY KEY,
  product_id      VARCHAR(50),
  product_name    VARCHAR(255),
  category        VARCHAR(100),
  subcategory     VARCHAR(100),
  brand           VARCHAR(100)
);

CREATE TABLE dim_customer (
  customer_key    INT PRIMARY KEY,
  customer_id     VARCHAR(50),
  customer_name   VARCHAR(255),
  city            VARCHAR(100),
  country         VARCHAR(100),
  segment         VARCHAR(50)
);

-- =========================
-- FACT TABLE
-- =========================

CREATE TABLE fact_sales (
  sales_key       INT PRIMARY KEY,
  order_id        VARCHAR(50),
  date_key        INT,
  product_key     INT,
  customer_key    INT,
  quantity        INT,
  unit_price      DECIMAL(18,2),
  discount        DECIMAL(18,2),
  revenue         DECIMAL(18,2),

  CONSTRAINT fk_sales_date 
      FOREIGN KEY (date_key) REFERENCES dim_date(date_key),

  CONSTRAINT fk_sales_product 
      FOREIGN KEY (product_key) REFERENCES dim_product(product_key),

  CONSTRAINT fk_sales_customer 
      FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key)
);
