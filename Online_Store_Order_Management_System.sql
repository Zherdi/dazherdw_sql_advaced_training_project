
-- Online Store Order Management System (PostgreSQL)

-- 1. Database Creation
 CREATE DATABASE OnlineStore;


-- Drop existing tables if they exist
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;

-- Create Customers table
CREATE TABLE Customers (
    CUSTOMER_ID SERIAL PRIMARY KEY,
    NAME TEXT,
    EMAIL TEXT,
    PHONE TEXT,
    ADDRESS TEXT
);

-- Create Products table
CREATE TABLE Products (
    PRODUCT_ID SERIAL PRIMARY KEY,
    PRODUCT_NAME TEXT,
    CATEGORY TEXT,
    PRICE NUMERIC,
    STOCK INT
);

-- Create Orders table
CREATE TABLE Orders (
    ORDER_ID SERIAL PRIMARY KEY,
    CUSTOMER_ID INT,
    PRODUCT_ID INT,
    QUANTITY INT,
    ORDER_DATE DATE,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES Customers(CUSTOMER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES Products(PRODUCT_ID)
);

-- 2. Sample Data Insertion

-- Customers
INSERT INTO Customers (NAME, EMAIL, PHONE, ADDRESS) VALUES
('Alice Thompson', 'alice@store.com', '1234567890', '10 River Rd'),
('Brian Adams', 'brian@store.com', '2345678901', '22 Hill St'),
('Clara Lee', 'clara@store.com', '3456789012', '33 Ocean Ave'),
('Derek Brown', 'derek@store.com', '4567890123', '44 Sunset Blvd'),
('Emily Clark', 'emily@store.com', '5678901234', '55 Forest Ln');

-- Products
INSERT INTO Products (PRODUCT_NAME, CATEGORY, PRICE, STOCK) VALUES
('Wireless Mouse', 'Electronics', 25.99, 15),
('Laptop', 'Electronics', 999.99, 3),
('Coffee Mug', 'Home', 7.99, 0),
('Notebook', 'Stationery', 2.49, 50),
('Desk Lamp', 'Home', 19.99, 5);

-- Orders
INSERT INTO Orders (CUSTOMER_ID, PRODUCT_ID, QUANTITY, ORDER_DATE) VALUES
(1, 1, 2, '2025-01-10'),
(1, 2, 1, '2025-03-15'),
(2, 4, 5, '2025-02-20'),
(3, 5, 1, '2024-12-01'),
(3, 1, 1, '2025-04-01'),
(4, 2, 2, '2025-03-10'),
(5, 4, 3, '2025-01-20'),
(5, 1, 1, '2025-03-22');

-- 3. Order Management Queries

-- a) Orders placed by a specific customer (e.g., customer_id = 1)
-- SELECT * FROM Orders WHERE CUSTOMER_ID = 1;

-- b) Products out of stock
-- SELECT * FROM Products WHERE STOCK = 0;

-- c) Total revenue generated per product
-- SELECT P.PRODUCT_NAME, SUM(O.QUANTITY * P.PRICE) AS TOTAL_REVENUE
-- FROM Orders O
-- JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID
-- GROUP BY P.PRODUCT_NAME;

-- d) Top 5 customers by total purchase amount
-- SELECT C.NAME, SUM(O.QUANTITY * P.PRICE) AS TOTAL_SPENT
-- FROM Orders O
-- JOIN Customers C ON O.CUSTOMER_ID = C.CUSTOMER_ID
-- JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID
-- GROUP BY C.NAME
-- ORDER BY TOTAL_SPENT DESC
-- LIMIT 5;

-- e) Customers who ordered from at least two different categories
-- SELECT C.NAME
-- FROM Orders O
-- JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID
-- JOIN Customers C ON O.CUSTOMER_ID = C.CUSTOMER_ID
-- GROUP BY C.NAME
-- HAVING COUNT(DISTINCT P.CATEGORY) >= 2;

-- 4. Analytics Queries

-- a) Month with the highest total sales
-- SELECT TO_CHAR(ORDER_DATE, 'YYYY-MM') AS ORDER_MONTH,
--        SUM(O.QUANTITY * P.PRICE) AS TOTAL_SALES
-- FROM Orders O
-- JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID
-- GROUP BY ORDER_MONTH
-- ORDER BY TOTAL_SALES DESC
-- LIMIT 1;

-- b) Products with no orders in the last 6 months
-- SELECT * FROM Products
-- WHERE PRODUCT_ID NOT IN (
--     SELECT PRODUCT_ID FROM Orders
--     WHERE ORDER_DATE >= CURRENT_DATE - INTERVAL '6 months'
-- );

-- c) Customers who have never placed an order
-- SELECT * FROM Customers
-- WHERE CUSTOMER_ID NOT IN (SELECT DISTINCT CUSTOMER_ID FROM Orders);

-- d) Average order value across all orders
-- SELECT AVG(O.QUANTITY * P.PRICE) AS AVERAGE_ORDER_VALUE
-- FROM Orders O
-- JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID;
