-- Get stores with sales above the average total sales
SELECT store_location
FROM dim_store
WHERE store_id IN (
    SELECT store_id
    FROM fact_transactions
    GROUP BY store_id
    HAVING SUM(total_amount) > (
        SELECT AVG(total_amount) FROM fact_transactions
    )
);

-- best product per store

SELECT 
    s.store_location,
    p.product_detail,
    SUM(f.total_amount) AS total_sales
FROM fact_transactions f
JOIN dim_store s ON f.store_id = s.store_id
JOIN dim_product p ON f.product_id = p.product_id
WHERE f.product_id = (
    SELECT TOP 1 f2.product_id
    FROM fact_transactions f2
    WHERE f2.store_id = f.store_id
    GROUP BY f2.product_id
    ORDER BY SUM(f2.total_amount) DESC
)
GROUP BY s.store_location, p.product_detail;
