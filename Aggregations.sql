-- Total sales and average sale amount per store
SELECT 
    s.store_location,
    COUNT(f.transaction_id) AS total_transactions,
    SUM(f.total_amount) AS total_sales,
    AVG(f.total_amount) AS avg_sale
FROM fact_transactions AS f
JOIN dim_store AS s ON f.store_id = s.store_id
GROUP BY s.store_location
HAVING SUM(f.total_amount) > 1000;
