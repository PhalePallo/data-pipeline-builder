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