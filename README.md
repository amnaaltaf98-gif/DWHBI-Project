# Nexora Retail Group — Enterprise Data Warehouse & Business Intelligence System

## 1. Project Overview

This project implements an Enterprise Data Warehouse and Business Intelligence System for a hypothetical retail organization, Nexora Retail Group.

The system integrates four departmental data sources using PostgreSQL, SQLite and DuckDB, transforms and loads the data into a central PostgreSQL data warehouse, and supports business analysis through SQL, Power BI, forecasting and anomaly detection.

All project data is synthetic and reproducible using random seed `472`.

## 2. Project Components

| Component | Description |
|---|---|
| Source Systems | Sales, Purchasing, Inventory and Finance databases |
| ETL Pipeline | Python and SQL-based extraction, transformation, validation and loading |
| Data Warehouse | PostgreSQL warehouse with three fact tables and shared dimensions |
| Metadata | Source metadata, transformation rules, column mappings and record lineage |
| Validation | Data-quality, reconciliation, key-integrity and batch-reliability checks |
| SQL Analytics | Twelve analytical SQL queries and reusable views |
| Power BI | Three-page interactive dashboard |
| Forecasting | Seasonal Naive and Prophet sales forecasting |
| Anomaly Detection | MAD and Isolation Forest methods |
| AI Results Integration | Model runs, forecast results and anomaly results stored in the warehouse |

## 3. Source Systems

| Department | Database Technology | Database |
|---|---|---|
| Sales | PostgreSQL | Supabase |
| Purchasing | PostgreSQL | Aiven |
| Inventory | SQLite | inventory.db |
| Finance | DuckDB | finance.duckdb |

The project contains 20 source tables, 9,470 source records and 4,800 transaction lines covering November 2023 to October 2026.

## 4. Execution Order

Follow this order when reproducing the project:

1. **Environment Setup:** Open the Google Colab notebook, mount Google Drive and configure the required database credentials using Colab Secrets.
2. **Synthetic Data Generation:** Execute the data generation section using random seed `472`.
3. **Source System Setup:** Create and populate the Sales, Purchasing, Inventory and Finance source databases.
4. **ETL and Standardization:** Extract source data, preserve raw snapshots, standardize values and apply crosswalks.
5. **Warehouse Setup:** Create the warehouse schema, dimension tables and fact tables.
6. **Warehouse Loading:** Load dimensions first, resolve dimension keys and then load the three fact tables.
7. **Metadata and Lineage:** Populate metadata repositories, transformation mappings, batch records and record-level lineage.
8. **Validation:** Execute data-quality, reconciliation, key-integrity and rerun-safety checks, including the controlled failure and recovery test.
9. **SQL Analytics:** Execute the twelve analytical SQL queries and generate the corresponding results and views.
10. **Power BI:** Open the `.pbix` report and refresh the report using the configured warehouse connection where available.
11. **Forecasting:** Execute the forecasting workflow and evaluate the forecasting models.
12. **Anomaly Detection:** Execute the MAD and Isolation Forest analysis.
13. **AI Results Integration:** Store model runs, forecasts and anomaly results in the warehouse and perform integrity checks.

**Important:** The main Google Colab notebook contains the integrated workflow. Execute its sections in their intended order. SQL scripts supplement the notebook and should be executed at the relevant warehouse setup, validation and analytical stages.

## 5. Project Evidence and Outputs

The project evidence should be organized into the following categories:

- **Source:** Source database structures, generated data and source snapshots.
- **ETL:** Extraction, transformation, standardization and loading evidence.
- **Warehouse:** Dimensional schema, fact tables, dimensions and warehouse outputs.
- **Metadata:** Metadata tables, source schemas, DDL, ERDs and transformation mappings.
- **Validation:** Validation reports, reconciliation results and integrity checks.
- **AI:** Forecasting, anomaly detection and AI integration outputs.
- **SQL:** Analytical SQL scripts, query results and reusable views.
- **Power BI:** Final interactive `.pbix` report.
- **Run Logs:** Evidence of the initial load, unchanged rerun, second batch and controlled failure recovery.

## 6. Reproducibility

- Synthetic data generator uses `np.random.default_rng(472)`.
- The original data can be regenerated using the same random seed.
- Database credentials must be configured separately through Colab Secrets.
- Database passwords and API credentials must never be committed to GitHub.
- Execute the notebook sections in the specified order to reproduce the workflow.

## 7. Main Deliverables

1. Google Colab notebook containing the integrated project workflow.
2. SQL scripts for warehouse operations, validation and analytical queries.
3. Source database files and supporting evidence.
4. Metadata and lineage exports.
5. Validation and batch execution evidence.
6. Power BI report (`.pbix`).
7. Forecasting and anomaly detection outputs.
8. AI results integration evidence.
