-- ============================================================
-- File: 05_product_intelligence.sql
-- Project: Revenue & Customer Segmentation Analysis
-- Purpose:
--   Identify product- and category-level monetization levers
--   and understand how premium customers drive revenue.
--
-- Scope:
--   - Category revenue contribution
--   - Volume vs value product dynamics
--   - Product preferences of high-value customers
-- ============================================================


-- ============================================================
-- SECTION 1: Revenue Contribution by Product Category
-- ============================================================

SELECT
    category,
    SUM(`total price`) AS total_revenue,
    COUNT(*) AS total_orders,
    ROUND(
        SUM(`total price`) / COUNT(*),
        2
    ) AS avg_order_value
FROM revenue_and_customer_risk_analysis
GROUP BY category
ORDER BY total_revenue DESC;

-- ============================================================
-- SECTION 2: Product Volume vs Revenue Analysis
-- ============================================================

SELECT
    `product name`,
    category,
    SUM(quantity) AS total_units_sold,
    SUM(`total price`) AS total_revenue,
    ROUND(
        SUM(`total price`) / SUM(quantity),
        2
    ) AS revenue_per_unit
FROM revenue_and_customer_risk_analysis
GROUP BY `product name`, category
ORDER BY total_revenue DESC;

-- ============================================================
-- SECTION 3: Product Preference of High-Value Customers
-- ============================================================

SELECT
    o.`product name`,
    o.category,
    COUNT(*) AS purchase_count,
    SUM(o.`total price`) AS revenue_from_high_value_customers
FROM revenue_and_customer_risk_analysis o
JOIN customer_segments c
    ON o.customer_id = c.customer_id
WHERE c.customer_persona IN (
    'Premium Customer',
    'Loyal High-Value Customer'
)
GROUP BY o.`product name`, o.category
ORDER BY revenue_from_high_value_customers DESC;


