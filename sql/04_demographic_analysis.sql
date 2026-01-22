-- ============================================================
-- File: 04_demographic_analysis.sql
-- Project: Revenue & Customer Segmentation Analysis
-- Purpose:
--   Explain observed customer value patterns using
--   regional revenue and customer distribution.
--
-- Note:
--   Gender and Age were excluded due to inconsistency
--   at the customer level.
-- ============================================================

SELECT
    region,
    COUNT(DISTINCT customer_id) AS customer_count,
    SUM(`total price`) AS total_revenue,
    ROUND(
        SUM(`total price`) / COUNT(DISTINCT customer_id),
        2
    ) AS revenue_per_customer
FROM revenue_and_customer_risk_analysis
GROUP BY region
ORDER BY total_revenue DESC;
