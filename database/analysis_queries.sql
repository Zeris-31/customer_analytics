-- =========================================
-- CUSTOMER ANALYTICS - CONSULTAS SQL
-- =========================================

-- 1. Top 10 clientes que más dinero generan
SELECT 
    customers.full_name,
    SUM(sales.total_amount) AS total_spent
FROM sales
JOIN customers ON sales.customer_id = customers.customer_id
GROUP BY customers.full_name
ORDER BY total_spent DESC
LIMIT 10;


-- 2. Clientes inactivos (más de 90 días sin comprar)
SELECT 
    customers.full_name,
    MAX(sales.sale_date) AS last_purchase
FROM customers
LEFT JOIN sales ON customers.customer_id = sales.customer_id
GROUP BY customers.full_name
HAVING MAX(sales.sale_date) < CURRENT_DATE - INTERVAL '90 days';


-- 3. Ticket promedio por cliente
SELECT 
    customers.full_name,
    AVG(sales.total_amount) AS avg_ticket
FROM sales
JOIN customers ON sales.customer_id = customers.customer_id
GROUP BY customers.full_name
ORDER BY avg_ticket DESC;


-- 4. Ventas totales por categoría de producto
SELECT 
    products.category,
    SUM(sales.total_amount) AS total_sales
FROM sales
JOIN products ON sales.product_id = products.product_id
GROUP BY products.category
ORDER BY total_sales DESC;


-- 5. Ventas por mes (tendencia)
SELECT 
    DATE_TRUNC('month', sales.sale_date) AS month,
    SUM(sales.total_amount) AS total_sales
FROM sales
GROUP BY month
ORDER BY month;


-- 6. Top 5 productos más vendidos (por cantidad)
SELECT 
    products.product_name,
    SUM(sales.quantity) AS total_quantity_sold
FROM sales
JOIN products ON sales.product_id = products.product_id
GROUP BY products.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;


-- 7. Número de compras por cliente
SELECT 
    customers.full_name,
    COUNT(sales.sale_id) AS total_purchases
FROM sales
JOIN customers ON sales.customer_id = customers.customer_id
GROUP BY customers.full_name
ORDER BY total_purchases DESC;


-- 8. Clientes registrados por ciudad
SELECT 
    customers.city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customers.city
ORDER BY total_customers DESC;


-- 9. Ingreso promedio por compra (global)
SELECT 
    AVG(sales.total_amount) AS avg_sale_value
FROM sales;


-- 10. Total de ingresos generados
SELECT 
    SUM(sales.total_amount) AS total_revenue
FROM sales;