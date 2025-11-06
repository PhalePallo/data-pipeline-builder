-- Check current database
SELECT DB_NAME() AS CurrentDB;

-- See available databases
SELECT name FROM sys.databases;

-- See tables in your current database
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
