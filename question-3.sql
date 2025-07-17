WITH ceny_s_lagem AS (
    SELECT 
        year,
        product,
        ROUND(AVG(avg_price)::numeric, 2) AS avg_price,
        LAG(ROUND(AVG(avg_price)::numeric, 2)) OVER (PARTITION BY product ORDER BY year) AS previous_price
    FROM t_Sarka_Praxova_project_SQL_primary_final
    GROUP BY year, product
),

rocni_rusty AS (
    SELECT 
        product,
        year,
        avg_price,
        previous_price,
        ROUND(100.0 * (avg_price - previous_price) / previous_price, 2) AS procentualni_rust
    FROM ceny_s_lagem
    WHERE previous_price IS NOT NULL
),

prumerne_rusty AS (
    SELECT 
        product,
        ROUND(AVG(procentualni_rust), 2) AS prumerny_rocni_rust_v_procentech
    FROM rocni_rusty
    GROUP BY product
)

SELECT *
FROM prumerne_rusty
ORDER BY prumerny_rocni_rust_v_procentech ASC
LIMIT 3;