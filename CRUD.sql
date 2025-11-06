--Creation  
-- Add a new store
INSERT INTO dim_store (store_id, store_location)
VALUES (6, 'The Bronx');

SELECT * FROM dim_store;  -- Verify the new store was added

-- Add a new product
INSERT INTO dim_product (product_id, product_category, product_type, product_detail)
VALUES (13, 'Coffee', 'Coffee', 'Cappuccino RG');

SELECT * FROM dim_product;  -- Verify the new product was added

-- Add a new transaction
INSERT INTO fact_transactions (transaction_id, transaction_date, transaction_time, store_id, product_id, transaction_qty, unit_price, total_amount)
VALUES (2000, '2025-11-06', '10:30:00', 6, 12, 5, 35.50, 177.50);

SELECT * FROM fact_transactions WHERE transaction_id = 2000;  -- Verify the new transaction was added

--Reading

SELECT * FROM fact_transactions;  -- view all transactions

SELECT * FROM dim_store;       -- view all stores

--Updating

UPDATE dim_store
SET store_location = 'Lower Manhattan' -- Change store location
WHERE store_id = 6;

SELECT * FROM dim_store WHERE store_id = 6;  -- Verify the store location was updated

--Deletion

-- Delete a test transaction
DELETE FROM fact_transactions
WHERE transaction_id = 2000;
SELECT * FROM fact_transactions WHERE transaction_id = 2000;  -- Verify the transaction was deleted