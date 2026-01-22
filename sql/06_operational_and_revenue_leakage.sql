-- ============================================================
-- File: 06_operational_and_revenue_leakage.sql
-- Project: Revenue & Customer Segmentation Analysis
-- Purpose:
--   Identify revenue leakage caused by returns and
--   operational inefficiencies to support corrective actions.
-- ============================================================

-- Revenue impact by shipping status
SELECT
    `Shipping Status`,
    COUNT(*) AS order_count,
    SUM(`total price`) AS total_revenue
FROM revenue_and_customer_risk_analysis
GROUP BY `Shipping Status`
ORDER BY total_revenue DESC;

-- Products with highest returned revenue
SELECT
    `product name`,
    category,
    COUNT(*) AS returned_orders,
    SUM(`total price`) AS returned_revenue
FROM revenue_and_customer_risk_analysis
WHERE `Shipping Status` = 'Returned'
GROUP BY `product name`, category
ORDER BY returned_revenue DESC;

-- SECTION 3: Return rate per product
SELECT
    `product name`,
    category,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN `Shipping Status` = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        SUM(CASE WHEN `Shipping Status` = 'Returned' THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS return_rate_pct
FROM revenue_and_customer_risk_analysis
GROUP BY `product name`, category
ORDER BY return_rate_pct DESC;
