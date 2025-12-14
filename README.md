# Healthcare-readmission-sql-analysis
SQL-based healthcare readmission analysis project
# Healthcare Readmission Analysis using SQL

## Project Overview
This project presents a structured healthcare data analysis focused on understanding and quantifying
30-day hospital readmissions. Using SQL Server, the analysis follows an end-to-end analytical workflow
from data ingestion and validation to KPI computation, segmentation analysis, and join-based reporting.
The objective is to identify patient and utilization factors associated with higher readmission risk.

## Dataset
- Diabetes 130-US Hospitals Readmission Dataset
- Approximately 100,000 inpatient encounter records
- Each record represents a single hospital admission with demographic, utilization, and outcome data

## Analytical Objectives
- Calculate the baseline 30-day readmission rate
- Identify high-risk patient segments based on demographics and utilization patterns
- Distinguish between proportional risk and absolute volume
- Demonstrate practical SQL analytics skills aligned with real-world reporting use cases

## Key Analyses Performed
- Overall 30-day readmission rate (baseline KPI)
- Age-based readmission risk segmentation
- Length of hospital stay vs readmission risk
- Impact of prior inpatient admissions
- Impact of prior emergency department visits
- Join-based analysis using fact and dimension tables

## SQL & Analytics Skills Demonstrated
- Data ingestion and schema design
- Data validation and sanity checks
- Aggregation and KPI calculations (COUNT, SUM, CASE)
- GROUP BY–based segmentation analysis
- JOIN operations (fact and dimension modeling concepts)
- Analytical interpretation of healthcare metrics
- Professional documentation of findings

## Repository Structure
sql_scripts/
- 01_table_creation.sql -- Fact and dimension table definitions
- 02_data_validation.sql -- Data quality and validation checks
- 03_analysis_queries.sql -- KPI and segmentation analysis queries
documentation/
- Healthcare_Readmission_Analysis_Project.docx -- Detailed analytical report

## How to Review This Project
1. Start with this README to understand project scope and objectives
2. Review SQL scripts in the `sql_scripts/` folder to examine analysis logic
3. Refer to the Word report in the `documentation/` folder for structured insights and interpretations

## Author
Prashika
