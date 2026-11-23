
CREATE OR REPLACE VIEW warehouse.vw_region_monthly_sales_anomaly_features AS
SELECT
    d.year_number,
    d.month_number,
    DATE_TRUNC('month', d.full_date)::DATE AS month_start,
    l.region,
    SUM(f.sales_amount) AS monthly_sales,
    SUM(f.quantity) AS monthly_units,
    COUNT(*) AS transaction_lines
FROM warehouse.fact_sales f
JOIN warehouse.dim_date d
    ON f.date_key = d.date_key
JOIN warehouse.dim_location l
    ON f.location_key = l.location_key
WHERE d.full_date >= DATE '2023-11-01'
  AND d.full_date < DATE '2026-11-01'
GROUP BY
    d.year_number,
    d.month_number,
    DATE_TRUNC('month', d.full_date)::DATE,
    l.region;
