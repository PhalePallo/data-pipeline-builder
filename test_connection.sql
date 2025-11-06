-- Check current database
SELECT DB_NAME() AS CurrentDB;

-- See available databases
SELECT name FROM sys.databases;

-- See tables in your current database
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';


SELECT name FROM sys.tables;        -- See all tables
SELECT TOP 10 * FROM fact_transactions;    -- Preview data



SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_date'; -- See columns in a specific table

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_store'; -- See columns in a specific table
