-- ==========================================
-- RETAIL CUSTOMER BEHAVIOR ANALYSIS (POSTGRESQL)
-- ==========================================

-- =========================
-- 1. CREATE DATABASE
-- =========================
CREATE DATABASE retail_db;

-- =========================
-- 2. CREATING RAW TABLE
-- =========================
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    invoice_no TEXT,
    stock_code TEXT,
    description TEXT,
    quantity INT,
    invoice_date TIMESTAMP,
    unit_price NUMERIC,
    customer_id FLOAT,
    country TEXT);

-- =========================
-- 3. LOADING CSV DATA
-- =========================
COPY transactions
FROM 'D:/Datasets/Online_Retail.csv'
DELIMITER ','
CSV HEADER;

-- =========================
-- 4. CREATING CLEANED TABLE
-- =========================
DROP TABLE IF EXISTS cleaned_transactions;

CREATE TABLE cleaned_transactions AS
SELECT 
    invoice_no,
    stock_code,
    description,
    quantity,
    invoice_date,
    unit_price,
    customer_id,
    country,
    quantity * unit_price AS total_price
FROM transactions
WHERE customer_id IS NOT NULL
  AND quantity > 0
  AND unit_price > 0;


-- =========================
-- 5. BASIC DATA CHECKS
-- =========================

-- Total rows
SELECT COUNT(*) AS total_rows FROM cleaned_transactions;

-- Sample data
SELECT * FROM cleaned_transactions LIMIT 10;


-- =========================
-- 6. BUSINESS ANALYSIS
-- =========================

-- Total Revenue
SELECT ROUND(SUM(total_price), 2) AS total_revenue
FROM cleaned_transactions;

-- Total Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM cleaned_transactions;

-- Total Orders
SELECT COUNT(DISTINCT invoice_no) AS total_orders
FROM cleaned_transactions;

-- Revenue by Country
SELECT country,
       ROUND(SUM(total_price), 2) AS revenue
FROM cleaned_transactions
GROUP BY country
ORDER BY revenue DESC;

-- Top 10 Customers
SELECT customer_id,
       ROUND(SUM(total_price), 2) AS total_spent
FROM cleaned_transactions
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Monthly Revenue Trend
SELECT DATE_TRUNC('month', invoice_date) AS month,
       ROUND(SUM(total_price), 2) AS revenue
FROM cleaned_transactions
GROUP BY month
ORDER BY month;


-- =========================
-- 7. CUSTOMER SEGMENTATION
-- =========================
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (SELECT customer_id,
           COUNT(DISTINCT invoice_no) AS order_count
    FROM cleaned_transactions
    GROUP BY customer_id) AS sub
GROUP BY customer_type;


-- =========================
-- 9. AVERAGE ORDER VALUE
-- =========================
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT invoice_no), 2) AS avg_order_value
FROM cleaned_transactions;


-- =========================
-- 10. CREATING RFM TABLE (FOR PYTHON)
-- =========================
DROP TABLE IF EXISTS rfm_base;

CREATE TABLE rfm_base AS
SELECT 
    customer_id,
    DATE_PART('day', CURRENT_DATE - MAX(invoice_date)) AS recency,
    COUNT(DISTINCT invoice_no) AS frequency,
    ROUND(SUM(total_price), 2) AS monetary
FROM cleaned_transactions
GROUP BY customer_id;


-- =========================
-- 11. EXPORTING RFM DATA
-- =========================
COPY rfm_base
TO 'D:/Datasets/python_rfm_data.csv'
DELIMITER ','
CSV HEADER;