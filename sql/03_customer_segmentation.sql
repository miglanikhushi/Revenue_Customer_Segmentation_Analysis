-- ============================================================
-- File: 03_customer_segmentation.sql
-- Project: Revenue & Customer Segmentation Analysis
-- Purpose:
--   Convert customer-level metrics into business-ready segments
--   and materialize them for downstream analysis.
-- ============================================================

CREATE TABLE customer_segments AS
WITH customer_base AS (
    -- STEP 1: Build customer-level metrics (one row per customer)
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
            STR_TO_DATE(`Order Date`, '%d-%m-%Y') AS parsed_date
        FROM revenue_and_customer_risk_analysis
    ) t
    GROUP BY customer_id
),

revenue_ranked AS (
    -- STEP 2: Revenue-based customer segmentation
    SELECT
        customer_id,
        total_orders,
        total_revenue,
        avg_order_value,
        first_order_date,
        last_order_date,
        active_days,

        PERCENT_RANK() OVER (
            ORDER BY total_revenue DESC
        ) AS revenue_percentile,

        CASE
            WHEN PERCENT_RANK() OVER (ORDER BY total_revenue DESC) <= 0.20
                THEN 'High-Value Customer'
            WHEN PERCENT_RANK() OVER (ORDER BY total_revenue DESC) <= 0.50
                THEN 'Mid-Value Customer'
            ELSE 'Low-Value Customer'
        END AS revenue_segment
    FROM customer_base
),

frequency_ranked AS (
    -- STEP 3: Frequency (loyalty) segmentation
    SELECT
        customer_id,
        total_orders,
        total_revenue,
        avg_order_value,
        first_order_date,
        last_order_date,
        active_days,
        revenue_percentile,
        revenue_segment,

        PERCENT_RANK() OVER (
            ORDER BY total_orders DESC
        ) AS frequency_percentile,

        CASE
            WHEN total_orders = 1
                THEN 'One-Time Buyer'
            WHEN PERCENT_RANK() OVER (ORDER BY total_orders DESC) <= 0.25
                THEN 'Frequent Buyer'
            ELSE 'Occasional Buyer'
        END AS frequency_segment
    FROM revenue_ranked
),

aov_ranked AS (
    -- STEP 4: AOV-based spending behavior segmentation
    SELECT
        customer_id,
        total_orders,
        total_revenue,
        avg_order_value,
        first_order_date,
        last_order_date,
        active_days,
        revenue_percentile,
        revenue_segment,
        frequency_percentile,
        frequency_segment,

        PERCENT_RANK() OVER (
            ORDER BY avg_order_value DESC
        ) AS aov_percentile,

        CASE
            WHEN PERCENT_RANK() OVER (ORDER BY avg_order_value DESC) <= 0.30
                THEN 'High AOV'
            WHEN PERCENT_RANK() OVER (ORDER BY avg_order_value DESC) <= 0.70
                THEN 'Medium AOV'
            ELSE 'Low AOV'
        END AS aov_segment
    FROM frequency_ranked
),

final_segmented_customers AS (
    -- STEP 5: Composite, business-ready customer personas
    SELECT
        customer_id,
        total_orders,
        total_revenue,
        avg_order_value,
        active_days,
        revenue_segment,
        frequency_segment,
        aov_segment,

        CASE
            WHEN revenue_segment = 'High-Value Customer'
                 AND aov_segment = 'High AOV'
                THEN 'Premium Customer'

            WHEN revenue_segment = 'High-Value Customer'
                 AND frequency_segment = 'Frequent Buyer'
                THEN 'Loyal High-Value Customer'

            WHEN frequency_segment = 'Frequent Buyer'
                 AND aov_segment = 'Low AOV'
                THEN 'Low-Premium Customer'

            WHEN revenue_segment = 'Low-Value Customer'
                 AND frequency_segment = 'One-Time Buyer'
                THEN 'High Churn Risk'

            ELSE 'Standard Customer'
        END AS customer_persona
    FROM aov_ranked
)

SELECT *
FROM final_segmented_customers;
