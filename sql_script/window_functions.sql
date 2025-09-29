-----------------------------------------------------------
-- Window Functions Queries
-- Author: [Your Full Name]
-- File: window_functions.sql
-----------------------------------------------------------

-- 1. RANKING: Top Products per Region
SELECT c.region, p.name AS product_name,
       SUM(t.amount) AS total_sales,
       RANK() OVER(PARTITION BY c.region ORDER BY SUM(t.amount) DESC) AS rank_in_region
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN products p ON t.product_id = p.product_id
GROUP BY c.region, p.name;

-----------------------------------------------------------

-- 2. AGGREGATE: Running Monthly Sales Totals
SELECT TO_CHAR(sale_date, 'YYYY-MM') AS month,
       SUM(amount) AS monthly_sales,
       SUM(SUM(amount)) OVER(ORDER BY TO_CHAR(sale_date, 'YYYY-MM')) AS running_total
FROM transactions
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY month;

-----------------------------------------------------------

-- 3. NAVIGATION: Month-over-Month Growth
SELECT TO_CHAR(sale_date, 'YYYY-MM') AS month,
       SUM(amount) AS monthly_sales,
       LAG(SUM(amount)) OVER(ORDER BY TO_CHAR(sale_date, 'YYYY-MM')) AS prev_month,
       (SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY TO_CHAR(sale_date, 'YYYY-MM'))) AS growth
FROM transactions
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY month;

-----------------------------------------------------------

-- 4. DISTRIBUTION: Customer Quartiles
SELECT customer_id, SUM(amount) AS total_spent,
       NTILE(4) OVER(ORDER BY SUM(amount) DESC) AS quartile
FROM transactions
GROUP BY customer_id;

-----------------------------------------------------------

-- 5. MOVING AVERAGE: 3-Month Window
SELECT TO_CHAR(sale_date, 'YYYY-MM') AS month,
       SUM(amount) AS monthly_sales,
       AVG(SUM(amount)) OVER(
           ORDER BY TO_CHAR(sale_date, 'YYYY-MM')
           ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS moving_avg
FROM transactions
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY month;
