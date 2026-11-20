
-- P9_Q3_Monthly_Sales_Trend
SELECT
    d.year_number AS year,
    d.month_number AS month,
    d.month_name AS month_name,
    SUM(f.sales_amount) AS total_sales
FROM warehouse.fact_sales f
JOIN warehouse.dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year_number,
    d.month_number,
    d.month_name
ORDER BY
    d.year_number,
    d.month_number;;

-- P9_Q11_Regional_Contribution
SELECT
            l.region,
            SUM(f.sales_amount) AS total_sales,
            ROUND(
                100.0 * SUM(f.sales_amount) /
                NULLIF(SUM(SUM(f.sales_amount)) OVER (), 0), 2
            ) AS contribution_percentage
        FROM warehouse.fact_sales f
        JOIN warehouse.dim_location l
            ON f.location_key = l.location_key
        GROUP BY l.region
        ORDER BY total_sales DESC;;

-- P9_Q13_Rolling_Average
WITH monthly AS (
            SELECT
                d.year_number,
                d.month_number,
                d.month_name,
                SUM(f.sales_amount) AS monthly_sales
            FROM warehouse.fact_sales f
            JOIN warehouse.dim_date d
                ON f.date_key = d.date_key
            GROUP BY d.year_number, d.month_number, d.month_name
        )
        SELECT
            year_number AS year,
            month_number AS month,
            month_name,
            monthly_sales,
            ROUND(
                AVG(monthly_sales) OVER (
                    ORDER BY year_number, month_number
                    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
                ), 2
            ) AS rolling_average
        FROM monthly
        ORDER BY year_number, month_number;;

-- P9_Q15_Top_Categories_Region
WITH category_sales AS (
            SELECT
                l.region,
                p.category,
                SUM(f.sales_amount) AS total_sales
            FROM warehouse.fact_sales f
            JOIN warehouse.dim_location l
                ON f.location_key = l.location_key
            JOIN warehouse.dim_product p
                ON f.product_key = p.product_key
            GROUP BY l.region, p.category
        ),
        ranked AS (
            SELECT
                region,
                category,
                total_sales,
                ROW_NUMBER() OVER (
                    PARTITION BY region
                    ORDER BY total_sales DESC
                ) AS category_rank
            FROM category_sales
        )
        SELECT region, category, total_sales, category_rank
        FROM ranked
        WHERE category_rank <= 2
        ORDER BY region, category_rank;;

-- P9_Q17_Category_ASP
SELECT
            p.category,
            SUM(f.sales_amount) AS total_sales,
            SUM(f.quantity) AS total_units,
            ROUND(
                SUM(f.sales_amount) /
                NULLIF(SUM(f.quantity), 0), 2
            ) AS average_selling_price
        FROM warehouse.fact_sales f
        JOIN warehouse.dim_product p
            ON f.product_key = p.product_key
        GROUP BY p.category
        ORDER BY average_selling_price DESC;;

-- P9_Q19_Monthly_Growth
WITH monthly AS (
            SELECT
                d.year_number,
                d.month_number,
                d.month_name,
                SUM(f.sales_amount) AS monthly_sales,
                SUM(f.quantity) AS monthly_units
            FROM warehouse.fact_sales f
            JOIN warehouse.dim_date d
                ON f.date_key = d.date_key
            GROUP BY d.year_number, d.month_number, d.month_name
        ),
        previous_month AS (
            SELECT
                *,
                LAG(monthly_sales) OVER (
                    ORDER BY year_number, month_number
                ) AS previous_sales
            FROM monthly
        )
        SELECT
            year_number AS year,
            month_number AS month,
            month_name,
            monthly_sales,
            monthly_units,
            ROUND(
                100.0 * (monthly_sales - previous_sales) /
                NULLIF(previous_sales, 0), 2
            ) AS sales_growth_percentage
        FROM previous_month
        ORDER BY year_number, month_number;;

-- P10_Q1_Sales_Units_Category
SELECT
            p.category,
            SUM(f.sales_amount) AS total_sales,
            SUM(f.quantity) AS total_units
        FROM warehouse.fact_sales f
        JOIN warehouse.dim_product p
            ON f.product_key = p.product_key
        GROUP BY p.category
        ORDER BY total_sales DESC;;

-- P10_Q7_Category_Ranking
WITH monthly_category AS (
            SELECT
                d.year_number AS year,
                d.month_number AS month,
                p.category,
                SUM(f.sales_amount) AS monthly_sales
            FROM warehouse.fact_sales f
            JOIN warehouse.dim_date d
                ON f.date_key = d.date_key
            JOIN warehouse.dim_product p
                ON f.product_key = p.product_key
            GROUP BY d.year_number, d.month_number, p.category
        )
        SELECT
            year,
            month,
            category,
            monthly_sales,
            RANK() OVER (
                PARTITION BY year, month
                ORDER BY monthly_sales DESC
            ) AS category_rank
        FROM monthly_category
        ORDER BY year, month, category_rank;;

-- P10_Q10_Category_Yearly_Contribution
WITH category_year AS (
            SELECT
                d.year_number AS year,
                p.category,
                SUM(f.sales_amount) AS category_sales
            FROM warehouse.fact_sales f
            JOIN warehouse.dim_date d
                ON f.date_key = d.date_key
            JOIN warehouse.dim_product p
                ON f.product_key = p.product_key
            GROUP BY d.year_number, p.category
        )
        SELECT
            year,
            category,
            category_sales,
            SUM(category_sales) OVER (
                PARTITION BY year
            ) AS yearly_total
        FROM category_year
        ORDER BY year, category_sales DESC;;

-- P10_Q17_Regional_Volatility
WITH calendar AS (
    SELECT generate_series(
        DATE '2023-11-01',
        DATE '2026-10-01',
        INTERVAL '1 month'
    )::date AS month_start
),
regions AS (
    SELECT DISTINCT region
    FROM warehouse.dim_location
    WHERE location_key <> 0
      AND region IS NOT NULL
),
monthly_sales AS (
    SELECT
        DATE_TRUNC('month', d.full_date)::date AS month_start,
        l.region,
        SUM(f.sales_amount) AS monthly_sales
    FROM warehouse.fact_sales f
    JOIN warehouse.dim_date d
        ON f.date_key = d.date_key
    JOIN warehouse.dim_location l
        ON f.location_key = l.location_key
    WHERE d.full_date >= DATE '2023-11-01'
      AND d.full_date < DATE '2026-11-01'
    GROUP BY 1, 2
),
complete_months AS (
    SELECT
        EXTRACT(YEAR FROM c.month_start)::integer AS year,
        EXTRACT(MONTH FROM c.month_start)::integer AS month,
        r.region,
        COALESCE(m.monthly_sales, 0)::numeric AS monthly_sales
    FROM calendar c
    CROSS JOIN regions r
    LEFT JOIN monthly_sales m
        ON m.month_start = c.month_start
       AND m.region = r.region
)
SELECT
    year,
    month,
    region,
    monthly_sales,
    ROUND(
        STDDEV_SAMP(monthly_sales) OVER (
            PARTITION BY region
        ), 2
    ) AS sales_variability
FROM complete_months
ORDER BY region, year, month;

-- P10_Q18_Market_Share_Change
WITH monthly_category AS (
            SELECT
                d.year_number AS year,
                d.month_number AS month,
                p.category,
                SUM(f.sales_amount) AS category_sales
            FROM warehouse.fact_sales f
            JOIN warehouse.dim_date d
                ON f.date_key = d.date_key
            JOIN warehouse.dim_product p
                ON f.product_key = p.product_key
            GROUP BY d.year_number, d.month_number, p.category
        ),
        shares AS (
            SELECT
                year,
                month,
                category,
                category_sales,
                100.0 * category_sales /
                    NULLIF(SUM(category_sales) OVER (
                        PARTITION BY year, month
                    ), 0) AS market_share
            FROM monthly_category
        ),
        changes AS (
            SELECT
                *,
                LAG(market_share) OVER (
                    PARTITION BY category
                    ORDER BY year, month
                ) AS previous_share
            FROM shares
        )
        SELECT
            year,
            month,
            category,
            ROUND(market_share, 2) AS market_share_percentage,
            ROUND(market_share - previous_share, 2)
                AS share_change_percentage_points
        FROM changes
        ORDER BY year, month, category;;

-- P10_Q20_Regional_Imbalance
WITH regional_category AS (
            SELECT
                p.category,
                l.region,
                SUM(f.sales_amount) AS region_sales
            FROM warehouse.fact_sales f
            JOIN warehouse.dim_product p
                ON f.product_key = p.product_key
            JOIN warehouse.dim_location l
                ON f.location_key = l.location_key
            GROUP BY p.category, l.region
        ),
        ranked AS (
            SELECT
                category,
                region,
                region_sales,
                ROW_NUMBER() OVER (
                    PARTITION BY category
                    ORDER BY region_sales DESC, region
                ) AS best_rank,
                ROW_NUMBER() OVER (
                    PARTITION BY category
                    ORDER BY region_sales ASC, region
                ) AS worst_rank
            FROM regional_category
        )
        SELECT
            category,
            MAX(region) FILTER (
                WHERE best_rank = 1
            ) AS best_region,
            MAX(region_sales) FILTER (
                WHERE best_rank = 1
            ) AS best_region_sales,
            MAX(region) FILTER (
                WHERE worst_rank = 1
            ) AS worst_region,
            MAX(region_sales) FILTER (
                WHERE worst_rank = 1
            ) AS worst_region_sales,
            MAX(region_sales) FILTER (
                WHERE best_rank = 1
            ) - MAX(region_sales) FILTER (
                WHERE worst_rank = 1
            ) AS performance_gap
        FROM ranked
        GROUP BY category
        ORDER BY performance_gap DESC;;
