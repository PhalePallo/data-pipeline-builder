-- Calculate total revenue per product, then rank them
WITH ProductSales AS (
    SELECT 
        p.product_detail,
        SUM(f.total_amount) AS total_sales
    FROM fact_transactions f
    JOIN dim_product p ON f.product_id = p.product_id
    GROUP BY p.product_detail
)
SELECT *,
       RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM ProductSales;

--Revenue per Product with Rank and Category Share
WITH ProductSales AS (
    SELECT 
        p.product_category,
        p.product_detail,
        SUM(f.total_amount) AS total_sales
    FROM fact_transactions f
    JOIN dim_product p ON f.product_id = p.product_id
    GROUP BY p.product_category, p.product_detail
),
CategoryTotals AS (
    SELECT 
        product_category,
        SUM(total_sales) AS category_total
    FROM ProductSales
    GROUP BY product_category
)
SELECT 
    ps.product_category,
    ps.product_detail,
    ps.total_sales,
    ct.category_total,
    ROUND((ps.total_sales / ct.category_total) * 100, 2) AS category_share,
    RANK() OVER (PARTITION BY ps.product_category ORDER BY ps.total_sales DESC) AS rank_in_category
FROM ProductSales ps
JOIN CategoryTotals ct ON ps.product_category = ct.product_category
ORDER BY ps.product_category, rank_in_category;

-- Peak Transaction Time Slot
WITH TimeSales AS (
    SELECT 
        DATEPART(HOUR, transaction_time) AS transaction_hour,
        SUM(total_amount) AS total_sales
    FROM fact_transactions
    GROUP BY DATEPART(HOUR, transaction_time)
)
SELECT 
    transaction_hour,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS time_rank
FROM TimeSales;
