WITH mzdy AS (
    SELECT 
        year,
        industry,
        avg_salary,
        LAG(avg_salary) OVER (PARTITION BY industry ORDER BY year) AS previous_salary
    FROM t_Sarka_Praxova_project_SQL_primary_final
    GROUP BY year, industry, avg_salary
)

SELECT *
FROM mzdy
WHERE previous_salary IS NOT NULL
  AND avg_salary < previous_salary
ORDER BY year, industry;