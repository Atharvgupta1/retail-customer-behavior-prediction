-- ==========================================
-- Retail Customer Behaviour Analysis (MySQL)
-- ==========================================

-- 1. Create and Use Database
CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- ==========================================
-- 2. Create Table
-- ==========================================
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100),
    TotalPrice DECIMAL(10,2));

-- ==========================================
-- 3. Total Revenue
-- ==========================================
SELECT ROUND(SUM(TotalPrice), 2) AS total_revenue
FROM transactions;

-- ==========================================
-- 4. Revenue by Country
-- ==========================================
SELECT Country, ROUND(SUM(TotalPrice), 2) AS revenue
FROM transactions
GROUP BY Country
ORDER BY revenue DESC;

-- ==========================================
-- 5. Top Products by Revenue
-- ==========================================
SELECT Description, ROUND(SUM(TotalPrice), 2) AS revenue
FROM transactions
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;

-- ==========================================
-- 6. Monthly Revenue Trend (Seasonality)
-- ==========================================
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
       ROUND(SUM(TotalPrice), 2) AS revenue
FROM transactions
GROUP BY month
ORDER BY month;

-- ==========================================
-- 7. Customer Segmentation (Repeat vs One-Time)
-- ==========================================
SELECT 
    CASE 
        WHEN order_count = 1 THEN 'One-Time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT CustomerID,
           COUNT(DISTINCT InvoiceNo) AS order_count
    FROM transactions
    GROUP BY CustomerID
) AS customer_orders
GROUP BY customer_type;

-- ==========================================
-- 8. Top Customers (High-Value Users)
-- ==========================================
SELECT CustomerID,
       ROUND(SUM(TotalPrice), 2) AS total_spent
FROM transactions
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;

-- ==========================================
-- 9. Average Order Value (AOV)
-- ==========================================
SELECT ROUND(SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo), 2) AS avg_order_value
FROM transactions;

-- ==========================================
-- 10. RFM Feature Base (for ML Model)
-- ==========================================
SELECT CustomerID,
       DATEDIFF(CURRENT_DATE, MAX(InvoiceDate)) AS recency_days,
       COUNT(DISTINCT InvoiceNo) AS frequency,
       ROUND(SUM(TotalPrice), 2) AS monetary
FROM transactions
GROUP BY CustomerID;

-- ==========================================
-- 11. Customer Lifetime Value
-- ==========================================
SELECT CustomerID,
       ROUND(SUM(TotalPrice), 2) AS customer_lifetime_value
FROM transactions
GROUP BY CustomerID
ORDER BY customer_lifetime_value DESC;
