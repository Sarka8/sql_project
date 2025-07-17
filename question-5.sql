WITH hdp_growth AS (
    SELECT 
        year,
        gdp,
        LAG(gdp) OVER (ORDER BY year) AS prev_gdp,
        ROUND((100.0 * (gdp - LAG(gdp) OVER (ORDER BY year)) / LAG(gdp) OVER (ORDER BY year))::numeric, 2) AS gdp_growth_pct
    FROM economies
    WHERE country = 'Czech Republic'
),

mzdyaCeny AS (
    SELECT 
        year,
        ROUND(AVG(avg_salary)::numeric) AS avg_salary,
        ROUND(AVG(avg_price)::numeric) AS avg_price
    FROM t_Sarka_Praxova_project_SQL_primary_final
    GROUP BY year
),

mzdyaCeny_growth AS (
    SELECT 
        year,
        avg_salary,
        avg_price,
        LAG(avg_salary) OVER (ORDER BY year) AS prev_salary,
        LAG(avg_price) OVER (ORDER BY year) AS prev_price,
        ROUND((100.0 * (avg_salary - LAG(avg_salary) OVER (ORDER BY year)) / LAG(avg_salary) OVER (ORDER BY year))::numeric, 2) AS salary_growth_pct,
        ROUND((100.0 * (avg_price - LAG(avg_price) OVER (ORDER BY year)) / LAG(avg_price) OVER (ORDER BY year))::numeric, 2) AS price_growth_pct
    FROM mzdyaCeny
),

combined AS (
    SELECT 
        m.year,
        h.gdp_growth_pct,
        m.salary_growth_pct,
        m.price_growth_pct,
        LEAD(m.salary_growth_pct) OVER (ORDER BY m.year) AS salary_growth_next_year,
        LEAD(m.price_growth_pct) OVER (ORDER BY m.year) AS price_growth_next_year
    FROM mzdyaCeny_growth m
    JOIN hdp_growth h ON m.year = h.year
)

SELECT *
FROM combined
ORDER BY year;
