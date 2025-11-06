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