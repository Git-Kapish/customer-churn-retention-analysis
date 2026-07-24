# Customer Churn & Retention Analysis

## 1. Business Problem
Subscription-based businesses lose significant recurring revenue to customer churn. This project
identifies which customer segments are most likely to churn, quantifies the revenue at risk, and
recommends targeted retention actions — presented the way a Business Analyst would pitch it to a
Customer Success leadership team, not the way a data scientist would present a model.

## 2. Dataset
**Source:** Telco Customer Churn dataset (Kaggle) —
https://www.kaggle.com/datasets/blastchar/telco-customer-churn

**Contents:** ~7,043 customer rows with:
- Demographics: gender, SeniorCitizen, Partner, Dependents
- Account info: tenure, Contract, PaperlessBilling, PaymentMethod, MonthlyCharges, TotalCharges
- Services: PhoneService, MultipleLines, InternetService, OnlineSecurity, OnlineBackup,
  DeviceProtection, TechSupport, StreamingTV, StreamingMovies
- Target: Churn (Yes/No)

## 3. Repo Structure
```
customer-churn-retention-analysis/
├── README.md
├── data/
│   ├── raw/                  # original Kaggle CSV, untouched
│   └── processed/            # cleaned CSV(s) used downstream
├── sql/
│   ├── 01_schema.sql
│   ├── 02_segmentation.sql
│   └── 03_churn_rate_by_segment.sql
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   └── 02_eda_churn_drivers.ipynb
├── excel/
│   └── churn_revenue_whatif.xlsx
├── dashboard/
│   ├── churn_dashboard.pbix
│   └── screenshots/
└── deliverables/
    └── executive_memo.md      # final business recommendation write-up
```

## 4. Build Plan (step-by-step)

### Phase 1 — Data Prep (Python)
1. Load raw CSV into `notebooks/01_data_cleaning.ipynb`.
2. Handle known data-quality issues: `TotalCharges` has blank strings for customers with
   `tenure == 0`; coerce to numeric and either impute 0 or drop these rows (document the choice).
3. Standardize categorical values (e.g. "No internet service" vs "No" — decide whether to
   collapse these into a single "No" category and document the decision).
4. Engineer features:
   - `tenure_bucket` (e.g. 0-12, 13-24, 25-48, 49+ months)
   - `num_services` (count of subscribed add-on services)
   - `is_high_value` flag (e.g. top quartile of MonthlyCharges)
5. Export cleaned dataset to `data/processed/churn_clean.csv`.

### Phase 2 — SQL Segmentation
1. Load `data/processed/churn_clean.csv` into a local SQLite/Postgres database (agent should
   pick whichever is simpler to set up locally, and document the choice in `sql/01_schema.sql`).
2. Write queries in `sql/02_segmentation.sql` to segment customers by:
   - Contract type (Month-to-month, One year, Two year)
   - Tenure bucket
   - Internet service type
   - Payment method
3. Write `sql/03_churn_rate_by_segment.sql` computing churn rate (%) and customer count for each
   segment above, ordered by churn rate descending.
4. Export the top-line results table as a CSV for use in Excel and Power BI.

### Phase 3 — EDA & Churn Drivers (Python)
1. In `notebooks/02_eda_churn_drivers.ipynb`, visualize churn rate by each segment from Phase 2.
2. Run a simple driver analysis (e.g. chi-square test for categorical variables against churn,
   or a basic logistic regression only to rank feature importance — NOT for a black-box model
   pitch, just to identify which factors matter most).
3. Identify and write down the top 3 churn drivers in plain business language (e.g. "month-to-month
   contract customers churn at 3x the rate of two-year contract customers").

### Phase 4 — Excel What-If Model
1. Build a pivot table in `excel/churn_revenue_whatif.xlsx` summarizing churn rate and customer
   count by segment (from Phase 2 SQL output).
2. Add a what-if calculation: "If churn in [highest-risk segment] drops by X%, how much monthly
   recurring revenue is retained?" Make X adjustable via a simple input cell.
3. Show the result as an annualized revenue-saved figure — this is the single number the
   executive memo should lead with.

### Phase 5 — Power BI Dashboard
1. Connect Power BI to `data/processed/churn_clean.csv` (or the SQL segment export).
2. Build these visuals:
   - Churn rate by segment (bar chart)
   - Revenue at risk by segment (bar chart, MonthlyCharges × churned customer count)
   - Churn trend by tenure bucket (line chart)
   - KPI cards: overall churn rate, total customers, total monthly revenue at risk
3. Export dashboard screenshots to `dashboard/screenshots/`.

### Phase 6 — Executive Memo
1. Write `deliverables/executive_memo.md` (or convert to PDF/Word) as a one-pager containing:
   - Top 3 churn drivers (plain language, no jargon)
   - Revenue at risk (the number from the Excel what-if model)
   - 3 recommended retention actions tied directly to the drivers
2. Audience: VP of Customer Success. Tone: decisive, quantified, no ML jargon.

## 5. Acceptance Criteria / Definition of Done
- [ ] `data/processed/churn_clean.csv` exists and is documented (cleaning decisions noted in the notebook)
- [ ] All 3 SQL queries run without error and produce a segment-level churn rate table
- [ ] EDA notebook clearly states the top 3 churn drivers with supporting numbers
- [ ] Excel workbook has a working, adjustable what-if calculation
- [ ] Power BI dashboard has at least the 4 visuals listed above
- [ ] Executive memo is under 1 page and leads with the revenue number

## 6. Tools
Python (pandas, matplotlib/seaborn, scipy or statsmodels for the driver test), SQL (SQLite or
Postgres), Excel, Power BI

## 7. Status
🚧 In progress — see Phase checklist above for current state.

## 8. Notes for AI Coding Agents
- Prioritize Phases 1-3 first (Python + SQL) — these unblock everything else.
- Do not build a complex ML model here; this is a Business Analyst project, so keep any
  statistical modeling simple and explainable (chi-square, basic logistic regression for
  ranking only — not for deployment).
- Every deliverable should be traceable back to a plain-English business recommendation, not
  just a chart or a metric.
