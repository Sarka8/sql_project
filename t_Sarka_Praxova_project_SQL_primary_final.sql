CREATE TABLE t_Sarka_Praxova_project_SQL_primary_final AS
WITH mzdy AS (
    SELECT 
        c.payroll_year AS year, 
        ROUND(AVG(c.value)) AS avg_salary, 
        c2.name AS industry
    FROM czechia_payroll c 
    JOIN czechia_payroll_industry_branch c2 
        ON c.industry_branch_code = c2.code
    WHERE c.value_type_code = 5958
    GROUP BY c.payroll_year, c2.name
),

ceny AS (
    SELECT 
        EXTRACT(YEAR FROM cp.date_from)::int AS year, 
        cpc.name AS product, 
        ROUND(AVG(cp.value::numeric)) AS avg_price, 
        'Kč' AS mena, 
        cpc.price_value AS mnozstvi, 
        cpc.price_unit AS jednotka
    FROM czechia_price cp
    JOIN czechia_price_category cpc
        ON cp.category_code = cpc.code
    GROUP BY year, product, mnozstvi, jednotka
),

hospodarstvi AS (
    SELECT 
        year, 
        gdp,
        gini,
        population
    FROM economies
    WHERE country = 'Czech Republic'
)

SELECT 
    mzdy.year,
    mzdy.industry,
    mzdy.avg_salary,
    ceny.product,
    ceny.avg_price,
    ceny.mnozstvi,
    ceny.jednotka,
    hospodarstvi.gdp,
    hospodarstvi.gini,
    hospodarstvi.population
FROM mzdy
JOIN ceny 
    ON mzdy.year = ceny.year
JOIN hospodarstvi 
    ON mzdy.year = hospodarstvi.year
ORDER BY mzdy.year, mzdy.industry, ceny.product;