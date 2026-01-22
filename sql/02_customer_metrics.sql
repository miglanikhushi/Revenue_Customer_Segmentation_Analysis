-- ============================================
-- File: 02_customer_metrics.sql
-- Project: Revenue & Customer Segmentation Analysis
-- Purpose: Build customer-level metrics for segmentation
-- Grain: One row per customer_id
-- ============================================
SELECT
    customer_id,
    COUNT(*) AS total_orders,
    SUM(`total price`) AS total_revenue,
    ROUND(SUM(`total price`) / COUNT(*), 2) AS avg_order_value,
    MIN(parsed_date) AS first_order_date,
    MAX(parsed_date) AS last_order_date,
    DATEDIFF(MAX(parsed_date), MIN(parsed_date)) AS active_days
FROM (
    SELECT
        customer_id,
        `total price`,
        STR_TO_DATE(`order date`, '%d-%m-%Y') AS parsed_date
    FROM revenue_and_customer_risk_analysis
) t
GROUP BY customer_id order by customer_id;
