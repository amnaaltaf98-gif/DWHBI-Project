# Nexora Retail Group — Data Warehouse & Business Intelligence Project

## CT-472 | Data Warehousing & Business Intelligence

## 1. Project Overview

This project develops an integrated data warehouse for Nexora Retail Group by combining data from four departmental source systems: Sales, Purchasing, Inventory, and Finance.

The project demonstrates the complete data warehousing workflow, including source data generation, data extraction, transformation, warehouse design, loading, validation, metadata management, SQL analytics, business intelligence dashboards, forecasting, and anomaly detection.

The objective is to transform data stored in separate systems into a centralized analytical environment that supports business reporting and decision-making.

---

## 2. Technologies Used

- Python
- Google Colab
- PostgreSQL — Sales and Purchasing source systems
- Supabase — Sales database hosting
- Aiven — Purchasing database hosting
- SQLite — Inventory source system
- DuckDB — Finance source system
- SQL
- Pandas
- NumPy
- Power BI
- Scikit-learn

---

## 3. Source Systems

| Source System | Department | Database Technology |
|---|---|---|
| SRC_SALES | Sales | PostgreSQL / Supabase |
| SRC_PURCHASING | Purchasing | PostgreSQL / Aiven |
| SRC_INVENTORY | Inventory | SQLite |
| SRC_FINANCE | Finance | DuckDB |

The project uses synthetic data generated with a fixed random seed of `472`, allowing the dataset to be reproduced.

### Dataset Overview

- 4 departmental source systems
- 20 source tables
- 9,470 source records
- 36 months of data
- Data coverage: November 2023 – October 2026
- 4,800 transaction-line records across Sales, Purchasing and Inventory

---

## 4. Project Execution Order

Run the project in the following order to ensure dependencies are created before they are required.

### Step 1 — Project Requirements & Business Analysis

Define the business problem, identify management questions, determine the analytical requirements, and identify the data needed to answer business questions.

### Step 2 — Source System Setup & Synthetic Data Generation

Create and populate the four departmental source systems.

- Sales database in Supabase PostgreSQL
- Purchasing database in Aiven PostgreSQL
- Inventory database in SQLite
- Finance database in DuckDB

Generate the synthetic dataset using the defined random seed and populate the source tables.

### Step 3 — Source Data Exploration

Inspect source tables, columns, data types, record counts, date ranges, keys, constraints and data quality.

Understand the structure of each source system before beginning extraction and transformation.

### Step 4 — ETL Pipeline

Extract data from all four source systems.

Transform the data through cleaning, standardization, type conversion, category normalization, identifier mapping, and other required processing.

Prepare the data for integration into the warehouse.

### Step 5 — Data Quality & Reconciliation

Perform validation checks before and after loading, including:

- Record counts
- Missing values
- Duplicate records
- Primary and foreign key validation
- Data type validation
- Source-to-warehouse reconciliation
- Amount and quantity comparisons

Resolve or document any data quality issues.

### Step 6 — Dimensional Modeling & Warehouse Design

Design the warehouse using a star-schema approach.

Create the shared dimensions:

- `dim_date`
- `dim_product`
- `dim_location`

Define fact-table grains, surrogate keys, foreign keys, measures and relationships.

### Step 7 — Warehouse Creation & Loading

Create the warehouse schema and tables.

Load dimension tables first, followed by the fact tables:

- `fact_sales`
- `fact_purchasing`
- `fact_inventory_movement`

Maintain appropriate key relationships and use the Unknown dimension key where records cannot be matched.

### Step 8 — ETL Reliability & Batch Testing

Execute and verify the ETL loading scenarios:

- Initial load
- Unchanged rerun
- Second batch of records
- Duplicate prevention
- Controlled failure
- Rollback and recovery

Maintain ETL batch records and validate that repeated runs do not introduce unintended duplicate records.

### Step 9 — Metadata, Documentation & Lineage

Capture and document the source and warehouse structures.

Create metadata for source objects, columns, data types, constraints and transformation rules.

Maintain record-level lineage to track warehouse records back to their source systems and source records.

Generate the required metadata exports, DDL documentation and ERDs.

### Step 10 — Denormalization Lab

Complete the denormalization exercises covering:

- Collapsing
- Pre-joining
- Splitting
- Redundant columns
- Derived attributes

Compare normalized and denormalized structures and understand their effects on analytical performance and data redundancy.

### Step 11 — OLAP & SQL Analytics

Perform analytical queries using the warehouse and AV schema.

Cover:

- Basic aggregations
- Grouping
- Filtering
- ROLLUP
- CUBE
- GROUPING SETS
- PIVOT
- Slice and Dice
- Ranking functions
- Running totals
- Moving averages
- Period comparisons

Use SQL to analyze sales, products, regions, time periods and business performance.

### Step 12 — Power BI Dashboard

Connect Power BI to the warehouse and build the business intelligence reports.

Create KPI cards, charts, comparisons and interactive filters to analyze performance across different dimensions.

The dashboard provides an analytical view of sales, quantities, products, locations and time periods.

### Step 13 — Forecasting

Use historical data to develop and evaluate forecasting models.

Prepare the data, train the model, generate predictions and evaluate forecasting performance to estimate future business trends.

### Step 14 — Anomaly Detection

Apply anomaly detection to identify unusual patterns in business performance.

Analyze unexpected sales variations, unusual activity and deviations from normal trends.

### Step 15 — AI Results Integration & Final Evaluation

Integrate forecasting and anomaly detection outputs into the analytical workflow.

Review the generated results, connect them to relevant business data, validate the outputs and interpret their usefulness for management decision-making.

---

## 5. Data Warehouse Architecture

The warehouse uses shared dimensions and separate fact tables to organize business measurements.

### Dimension Tables

| Table | Purpose |
|---|---|
| `dim_date` | Date, month, quarter and year analysis |
| `dim_product` | Product-level analysis |
| `dim_location` | Geographic analysis |

### Fact Tables

| Table | Purpose |
|---|---|
| `fact_sales` | Sales transactions and sales measures |
| `fact_purchasing` | Purchasing transactions and purchase measures |
| `fact_inventory_movement` | Inventory movement and quantity measures |

The fact tables reference the shared dimensions using warehouse keys, allowing business data to be analyzed consistently across multiple dimensions.

---

## 6. ETL Workflow

The ETL pipeline follows these stages:

1. Connect to source systems.
2. Extract source data.
3. Inspect and validate the data.
4. Clean and standardize records.
5. Apply transformations and mappings.
6. Load dimension tables.
7. Resolve warehouse keys.
8. Load fact tables.
9. Record ETL batches and lineage.
10. Validate and reconcile the results.

---

## 7. Data Validation & Reliability

The project includes validation and reliability checks to ensure the warehouse is loaded correctly.

These include:

- Primary key and duplicate validation
- Foreign key integrity
- Record-count validation
- Source and warehouse amount reconciliation
- Data quality checks
- ETL batch tracking
- Duplicate prevention during reruns
- Failure testing and recovery
- Record-level lineage coverage

---

## 8. Business Intelligence & AI

The completed warehouse supports:

### Business Intelligence

Power BI dashboards provide visual summaries and comparisons of business performance.

### Forecasting

Models use historical information to estimate future business activity.

### Anomaly Detection

Models identify unusual patterns that may require investigation.

### Decision Support

Integrated data, dashboards and analytical model outputs help management identify trends, evaluate performance and make data-informed decisions.

---

## 9. Project Directory

The project is maintained in Google Drive / Google Colab:

`/content/drive/MyDrive/CT472_Project/`

The project notebook contains the implementation workflow, including source setup, data generation, ETL, warehouse creation, validation, analytics and AI tasks.

The `metadata` directory contains the metadata and documentation exports generated during the project.

---

## 10. Execution Requirements

Before executing the notebook:

1. Open the project notebook in Google Colab.
2. Mount Google Drive.
3. Ensure the project directory exists.
4. Configure the required database connection credentials.
5. Verify access to Supabase and Aiven.
6. Ensure required Python packages are installed.
7. Run the notebook cells in order.

The source databases must be available before extraction. Warehouse dimensions must be created and loaded before dependent fact records are inserted.

---

## 11. Expected Outcomes

Upon successful execution, the project produces:

- Four populated departmental source systems
- A centralized data warehouse
- Shared dimensional tables
- Sales, Purchasing and Inventory fact tables
- ETL transformation and loading workflows
- Data quality and reconciliation results
- Batch tracking and recovery results
- Metadata documentation and lineage records
- SQL analytical results
- Power BI dashboards
- Forecasting outputs
- Anomaly detection outputs

---

## 12. Conclusion

The Nexora Retail Group project demonstrates how data from multiple independent departmental databases can be integrated into a centralized warehouse.

By following the complete workflow from source data generation through ETL, dimensional modeling, validation, SQL analytics, BI and AI, the project establishes a structured environment for business analysis and data-driven decision-making.

**Project:** CT-472 Data Warehousing & Business Intelligence  
**Organization:** Nexora Retail Group  
**Dataset:** Synthetic retail data  
**Random Seed:** 472
