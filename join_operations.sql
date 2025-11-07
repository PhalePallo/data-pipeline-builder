-- Inner Join 
-- Join fact table with product and store to get detailed transactions
SELECT 
    f.transaction_id,
    d.date_key,
    s.store_location,
    p.product_category,
    p.product_detail,
    f.transaction_qty,
    f.unit_price,
    f.total_amount
FROM fact_transactions AS f
INNER JOIN dim_store AS s ON f.store_id = s.store_id
INNER JOIN dim_product AS p ON f.product_id = p.product_id
INNER JOIN dim_date AS d ON f.transaction_date = d.date_key;

-- Left Join
-- Get all stores and their transactions, including stores with no transactions
SELECT 
    s.store_location,
    f.transaction_id,
    f.total_amount
FROM dim_store AS s
LEFT JOIN fact_transactions AS f ON s.store_id = f.store_id;