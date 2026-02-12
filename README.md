# Clinical Trial Analytics (AWS Athena + SQL + Power BI)

## Project Overview
This project demonstrates an end-to-end clinical trial analytics pipeline using AWS.
The objective is to analyze patient dropouts, completion rates, and outcome distributions
across different trial phases.

---

## Business Problem
Clinical trials are expensive and time-sensitive.
High dropout rates can increase cost, delay approvals, and reduce study quality.

This project helps answer:
- Which trial phase has higher dropouts?
- What is the overall completion rate?
- How are outcomes distributed?

---

## Data Architecture
- CSV data stored in Amazon S3 (data lake)
- External tables created in Amazon Athena
- SQL used to compute KPIs
- Power BI used for visualization

![S3 Data Lake](screenshots/s3_data_lake.png)

![Athena SQL](screenshots/athena_sql_query.png)

![Athena Results](screenshots/athena_query_results.png)

![Power BI Dashboard](screenshots/dashboard_overview.png)

![CTE KPI SQL](screenshots/athena_cte_kpi_query.png)

![CTE KPI Results](screenshots/athena_cte_kpi_results.png)

---

## Key KPIs (Athena SQL)
- Advanced phase-wise completion and dropout analysis using CTEs
  (see `kpi_phase_performance_cte.sql`)

### Dropout Rate by Phase
```sql
SELECT t.phase,
       COUNT(*) AS dropped_patients
FROM trials t
JOIN enrollments e
  ON t.trial_id = e.trial_id
WHERE LOWER(e.status) = 'dropped'
GROUP BY t.phase;
