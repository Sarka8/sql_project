WITH avg_data AS (
    SELECT 
        year,
        ROUND(AVG(avg_salary)::numeric, 2) AS avg_salary,
        ROUND(AVG(avg_price)::numeric, 2) AS avg_price
    FROM t_Sarka_Praxova_project_SQL_primary_final
    GROUP BY year
),

growths AS (
    SELECT 
        year,
        avg_salary,
        avg_price,
        LAG(avg_salary) OVER (ORDER BY year) AS prev_salary,
        LAG(avg_price) OVER (ORDER BY year) AS prev_price
    FROM avg_data
),

growths_percent AS (
    SELECT 
        year,
        ROUND(100.0 * (avg_salary - prev_salary) / prev_salary, 2) AS salary_growth_pct,
        ROUND(100.0 * (avg_price - prev_price) / prev_price, 2) AS price_growth_pct
    FROM growths
    WHERE prev_salary IS NOT NULL AND prev_price IS NOT NULL
),

roky_s_vyraznym_rozdilem AS (
    SELECT 
        year,
        salary_growth_pct,
        price_growth_pct,
        ROUND(price_growth_pct - salary_growth_pct, 2) AS rozdil
    FROM growths_percent
    WHERE (price_growth_pct - salary_growth_pct) > 10
)

SELECT *
FROM roky_s_vyraznym_rozdilem
ORDER BY rozdil DESC;