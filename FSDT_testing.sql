-- Filter: Only store 8 sales
SELECT * 
FROM fact_transactions
WHERE store_id = 8;

-- Sorting: Top 10 most expensive transactions
SELECT TOP 10 *
FROM fact_transactions
ORDER BY total_amount DESC;

-- Transformation: Add a computed column
SELECT 
    transaction_id,
    transaction_qty,
    unit_price,
    (transaction_qty * unit_price) AS computed_total
FROM fact_transactions;