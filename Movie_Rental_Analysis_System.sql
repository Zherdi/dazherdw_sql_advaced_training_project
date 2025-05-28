
-- Movie Rental Analysis System  (Redshift and postgreSQL)

-- 1. Database Creation
CREATE DATABASE MovieRental;


-- Drop table if exists
DROP TABLE IF EXISTS rental_data;

-- Create rental_data table
CREATE TABLE rental_data (
    MOVIE_ID INTEGER,
    CUSTOMER_ID INTEGER,
    GENRE VARCHAR(50),
    RENTAL_DATE DATE,
    RETURN_DATE DATE,
    RENTAL_FEE NUMERIC
);

-- 2. Sample Data Insertion (10–15 records)

INSERT INTO rental_data VALUES
(101, 1, 'Action', '2025-03-01', '2025-03-03', 4.99),
(102, 2, 'Comedy', '2025-02-15', '2025-02-17', 3.99),
(103, 1, 'Drama', '2025-01-20', '2025-01-22', 4.49),
(104, 3, 'Action', '2025-04-10', '2025-04-12', 5.49),
(105, 4, 'Horror', '2025-02-01', '2025-02-03', 4.29),
(106, 2, 'Comedy', '2025-04-02', '2025-04-04', 3.79),
(107, 5, 'Drama', '2025-03-25', '2025-03-27', 4.69),
(108, 3, 'Action', '2025-03-10', '2025-03-12', 4.99),
(109, 1, 'Thriller', '2024-12-15', '2024-12-17', 4.19),
(110, 5, 'Comedy', '2025-03-30', '2025-04-01', 3.99),
(111, 2, 'Action', '2025-01-10', '2025-01-12', 5.29),
(112, 4, 'Drama', '2025-03-18', '2025-03-20', 4.59),
(113, 5, 'Horror', '2025-04-08', '2025-04-10', 4.39),
(114, 3, 'Action', '2025-04-12', '2025-04-14', 5.29),
(115, 4, 'Comedy', '2025-01-05', '2025-01-07', 3.89);

-- 3. OLAP Operations

-- a) Drill Down: From genre to movie level rental fees
-- SELECT GENRE, MOVIE_ID, SUM(RENTAL_FEE) AS TOTAL_RENTAL_FEE
-- FROM rental_data
-- GROUP BY GENRE, MOVIE_ID
-- ORDER BY GENRE, MOVIE_ID;

-- b) Rollup: Total rental fees by genre and overall
-- SELECT COALESCE(GENRE, 'TOTAL') AS GENRE, SUM(RENTAL_FEE) AS TOTAL_RENTAL_FEE
-- FROM rental_data
-- GROUP BY ROLLUP(GENRE);

-- c) Total rental fees across genre, rental date, and customer
-- SELECT GENRE, RENTAL_DATE, CUSTOMER_ID, SUM(RENTAL_FEE) AS TOTAL_RENTAL_FEE
-- FROM rental_data
-- GROUP BY CUBE(GENRE, RENTAL_DATE, CUSTOMER_ID)
-- ORDER BY GENRE NULLS LAST, RENTAL_DATE NULLS LAST, CUSTOMER_ID NULLS LAST;

-- d) Slice: Rentals from the ‘Action’ genre
-- SELECT RENTAL_DATE,CUSTOMER_ID,SUM(RENTAL_FEE) AS TOTAL_RENTAL_FEE
-- FROM rental_data
-- WHERE GENRE = 'Action'
-- GROUP BY CUBE(RENTAL_DATE, CUSTOMER_ID)
-- ORDER BY RENTAL_DATE, CUSTOMER_ID;

-- e) Dice: Rentals in 'Action' or 'Drama' from the last 3 months
-- SELECT GENRE, RENTAL_DATE, SUM(RENTAL_FEE) AS TOTAL_RENTAL_FEE
-- FROM rental_data
-- WHERE GENRE IN ('Action')
-- AND RENTAL_DATE >= DATE '2025-02-27'
-- GROUP BY GENRE, RENTAL_DATE
-- ORDER BY GENRE, RENTAL_DATE;

