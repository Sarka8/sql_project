WITH vybrane_produkty AS (
    SELECT 
        year,
        industry,
        avg_salary,
        product,
        avg_price,
        ROUND(avg_salary / avg_price) AS amount
    FROM t_Sarka_Praxova_project_SQL_primary_final
    WHERE product IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
),

hranice AS (
    SELECT 
        MIN(year) AS prvni_rok,
        MAX(year) AS posledni_rok
    FROM vybrane_produkty
)

SELECT 
    vp.year,
    vp.product,
    ROUND(AVG(vp.avg_salary)) AS avg_salary,
    ROUND(AVG(vp.avg_price), 2) AS avg_price,
    ROUND(AVG(vp.amount)) AS kolik_si_mohu_koupit
FROM vybrane_produkty vp
JOIN hranice h ON vp.year = h.prvni_rok OR vp.year = h.posledni_rok
GROUP BY vp.year, vp.product
ORDER BY vp.product, vp.year;