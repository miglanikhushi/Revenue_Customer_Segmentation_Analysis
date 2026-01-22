use revenue_analysis;
-- ============================================
-- File: 01_baseline.sql
-- Project: Revenue & Customer Segmentation Analysis
-- Purpose: Dataset sanity checks and baseline KPIs
-- ============================================

-- Basic table check
SELECT COUNT(*) AS total_rows
FROM revenue_and_customer_risk_analysis;

-- Core business KPIs
SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(*) AS total_orders,
    SUM(`total price`) AS total_revenue
FROM revenue_and_customer_risk_analysis;

-- Detect inconsistent gender per customer_id
SELECT
    customer_id,
    COUNT(DISTINCT gender) AS gender_variants
FROM revenue_and_customer_risk_analysis
GROUP BY customer_id
HAVING COUNT(DISTINCT gender) > 1;

-- Data time range coverage
SELECT
    MIN(STR_TO_DATE(`order date`, '%d-%m-%Y')) AS start_date,
    MAX(STR_TO_DATE(`order date`, '%d-%m-%Y')) AS end_date
FROM revenue_and_customer_risk_analysis;

-- Monthly revenue trend (baseline view)
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`order date`, '%d-%m-%Y'),
        '%Y-%m'
    ) AS order_month,
    SUM(`total price`) AS monthly_revenue,
    COUNT(*) AS orders
FROM revenue_and_customer_risk_analysis
GROUP BY order_month
ORDER BY order_month;


