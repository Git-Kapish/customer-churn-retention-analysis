-- ============================================================
-- 02_segmentation.sql: Customer Segmentation Analysis Queries
-- Objectives: Segment customer base by key operational dimensions
-- ============================================================

-- 1. Segmentation by Contract Type
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn), 2) AS customer_share_pct,
    ROUND(SUM(MonthlyCharges), 2) AS total_monthly_revenue,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM customer_churn
GROUP BY Contract
ORDER BY total_customers DESC;

-- 2. Segmentation by Tenure Bucket
SELECT 
    tenure_bucket,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn), 2) AS customer_share_pct,
    ROUND(SUM(MonthlyCharges), 2) AS total_monthly_revenue,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM customer_churn
GROUP BY tenure_bucket
ORDER BY total_customers DESC;

-- 3. Segmentation by Internet Service Type
SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn), 2) AS customer_share_pct,
    ROUND(SUM(MonthlyCharges), 2) AS total_monthly_revenue,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM customer_churn
GROUP BY InternetService
ORDER BY total_customers DESC;

-- 4. Segmentation by Payment Method
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn), 2) AS customer_share_pct,
    ROUND(SUM(MonthlyCharges), 2) AS total_monthly_revenue,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY total_customers DESC;

-- 5. Multi-dimensional Segmentation: Contract x Tenure Bucket
SELECT 
    Contract,
    tenure_bucket,
    COUNT(*) AS total_customers,
    ROUND(SUM(MonthlyCharges), 2) AS total_monthly_revenue
FROM customer_churn
GROUP BY Contract, tenure_bucket
ORDER BY Contract, tenure_bucket;
