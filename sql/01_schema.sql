-- ============================================================
-- 01_schema.sql: Customer Churn Table Schema Definition (SQLite)
-- Database Engine: SQLite
-- Source File: data/processed/churn_clean.csv
-- ============================================================

DROP TABLE IF EXISTS customer_churn;

CREATE TABLE customer_churn (
    customerID VARCHAR(20) PRIMARY KEY,
    gender VARCHAR(10),
    SeniorCitizen INTEGER,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INTEGER,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(25),
    InternetService VARCHAR(25),
    OnlineSecurity VARCHAR(25),
    OnlineBackup VARCHAR(25),
    DeviceProtection VARCHAR(25),
    TechSupport VARCHAR(25),
    StreamingTV VARCHAR(25),
    StreamingMovies VARCHAR(25),
    Contract VARCHAR(25),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(35),
    MonthlyCharges REAL,
    TotalCharges REAL,
    Churn VARCHAR(5),
    tenure_bucket VARCHAR(20),
    num_services INTEGER,
    is_high_value INTEGER
);

-- Indexes for optimized analytical grouping and filtering
CREATE INDEX IF NOT EXISTS idx_contract ON customer_churn(Contract);
CREATE INDEX IF NOT EXISTS idx_tenure_bucket ON customer_churn(tenure_bucket);
CREATE INDEX IF NOT EXISTS idx_internet_service ON customer_churn(InternetService);
CREATE INDEX IF NOT EXISTS idx_payment_method ON customer_churn(PaymentMethod);
CREATE INDEX IF NOT EXISTS idx_churn ON customer_churn(Churn);
