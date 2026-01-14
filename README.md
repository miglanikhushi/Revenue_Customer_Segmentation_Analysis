# Revenue_Customer_Segmentation_Analysis
End-to-end revenue &amp; customer segmentation analysis with actionable product and returns insights (SQL + Power BI).

# Revenue & Customer Segmentation Insights (SQL + Python + Power BI)

## Business Problem
**Which customers and customer segments generate the most revenue, and how should the company optimize marketing, retention, and product focus?**

This project analyzes e-commerce order-level transactional data to identify revenue drivers, customer personas, product monetization levers, and operational revenue leakage (returns + in-transit risk).

---

## Project Overview
This end-to-end analysis was built with a structured workflow:

- **SQL (MySQL):** KPI creation, customer metrics, segmentation pipeline, product intelligence, operational risk analysis  
- **Python (Pandas):** data validation, cleaning checks, and EDA support  
- **Excel:** pivot table summaries for quick business-friendly reporting  
- **Power BI:** executive dashboard for stakeholder storytelling  

The project is designed to be **interview-ready** and **consulting-style**, focusing on actionable insights.

---

## Dataset Summary
- **Total Orders:** 1000  
- **Unique Customers:** 292  
- **Key Fields:** customer_id, category, product_name, total_price, quantity, shipping_status, order_date  

### Data Quality Notes
- **Missing Values:**
  - `age`: 100 missing
  - `region`: 50 missing
  - `shipping_status`: 50 missing  
- **Demographic Consistency:**
  - `gender` was inconsistent for many customer_id values, so it was **excluded from customer-level segmentation logic**
- Shipping status had **Unknown/Missing cases** which were treated explicitly in operational analysis.

---

## Key Metrics (Executive Snapshot)
- **Total Revenue:** ₹1,346,600  
- **Total Orders:** 1000  
- **Total Customers:** 292  
- **Average Order Value (AOV):** ₹1,346.60  

---

## Insights Summary

### 1) Revenue Concentration (Where the money comes from)
- Revenue is heavily concentrated in the **Electronics** category, contributing **₹1,200,500** with a high **AOV of ₹2,516.77**, indicating revenue is driven by high-ticket purchases.
- **Accessories** generate **high order volume (401 orders)** but low revenue (**₹71,900**) with a very low **AOV of ₹179.30**, highlighting strong cross-sell potential.
- **Wearables** contribute **₹74,200** with moderate AOV (**₹608.20**), sitting between premium and low-cost categories.

---

### 2) Product Intelligence (Monetization Levers)
Top revenue-driving products:
- **Laptop:** ₹696,000  
- **Smartphone:** ₹353,600  
- **Monitor:** ₹150,900  

High-value customers show strong preference for premium Electronics:
- **Laptop (high-value revenue):** ₹453,000  
- **Smartphone (high-value revenue):** ₹132,000  

**Implication:** Strategy should prioritize flagship Electronics, and use Accessories/Wearables for bundling to increase basket size.

---

### 3) Operational Risk & Revenue Leakage
Revenue by shipping status:
- **In Transit:** ₹443,560 (329 orders)  
- **Returned:** ₹415,640 (308 orders)  
- **Delivered:** ₹407,380 (313 orders)  
- **Unknown/Missing status:** ₹80,020 (50 orders)

Returned revenue loss by product:
- **Laptop:** ₹223,500  
- **Smartphone:** ₹102,400  
- **Monitor:** ₹43,800  

Return-rate analysis shows high return rates across multiple products (~29%–33%), indicating measurable revenue leakage risk.

**Implication:** Revenue growth must be paired with return reduction initiatives to protect realized revenue and profitability.

---

## Customer Segmentation Approach (SQL-Driven)
Customers were segmented into business-ready personas using:
- **Total Revenue** (percentile-based ranking)
- **Order Frequency**
- **Average Order Value (AOV)**

Example personas:
- Premium Customer  
- Loyal High-Value Customer  
- Standard Customer  
- Low-Premium Customer  
- High Churn Risk  

> Note: Excel revenue buckets were used only for executive summaries; final segmentation logic is percentile-based and implemented in SQL.

---

## Recommendations (Business Action Framework)

### Marketing (Revenue Growth)
- Prioritize acquisition and promotions around **Electronics**, since it drives the majority of revenue.
- Use **Accessories** as add-ons to improve basket value (high volume + low AOV → strong upsell opportunity).

### Retention (Protect High-Value Segments)
- Build retention programs for high-value personas (premium + loyal) such as priority support, loyalty rewards, and post-purchase engagement.

### Product Strategy (Monetization Levers)
- Promote flagship products (**Laptop, Smartphone, Monitor**) and build cross-sell ecosystems:
  - Laptop → Monitor/Keyboard/Mouse bundles  
  - Smartphone → Headphones/Smartwatch bundles  

### Operations (Reduce Revenue Leakage)
- Reduce return leakage for high-revenue products (**Laptop, Smartphone**) via improved packaging, quality checks, and clearer product expectations.
- Investigate high return-rate products (Accessories/Wearables) for compatibility or expectation mismatch issues.

---

## Power BI Dashboard
A one-page executive dashboard was built to summarize customer value, product revenue drivers, and operational leakage.

---

## Repository Structure

Revenue_Customer_Segmentation_Analysis/
│
├── data/
│ ├── raw/
│ └── processed/
│
├── sql/
│ ├── 01_baseline.sql
│ ├── 02_customer_metrics.sql
│ ├── 03_customer_segmentation.sql
│ ├── 04_demographic_analysis.sql
│ ├── 05_product_intelligence.sql
│ └── 06_operational_revenue_leakage.sql
│
├── notebooks/
│ └── 01_data_validation_and_eda.ipynb
│
├── excel/
│ └── Revenue_Customer_Segmentation.xlsx
│
├── powerbi/
│ └── Revenue_Customer_Segmentation.pbix
│
├── visuals/
│ └── dashboard.png
│
└── README.md


---

## How to Run
1. Run SQL scripts in sequence from the `/sql` folder  
2. Run the Python notebook in `/notebooks` to validate & export cleaned data  
3. Open the Power BI file in `/powerbi` to explore the dashboard  

