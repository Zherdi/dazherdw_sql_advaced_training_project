
-- Library Management System SQL Script

-- 1. Table Creation
DROP TABLE IF EXISTS BorrowingRecords;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Books;

CREATE TABLE Books (
    BOOK_ID INT PRIMARY KEY,
    TITLE VARCHAR(100),
    AUTHOR VARCHAR(100),
    GENRE VARCHAR(50),
    YEAR_PUBLISHED INT,
    AVAILABLE_COPIES INT
);

CREATE TABLE Members (
    MEMBER_ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    EMAIL VARCHAR(100),
    PHONE_NO VARCHAR(15),
    ADDRESS TEXT,
    MEMBERSHIP_DATE DATE
);

CREATE TABLE BorrowingRecords (
    BORROW_ID INT PRIMARY KEY,
    MEMBER_ID INT,
    BOOK_ID INT,
    BORROW_DATE DATE,
    RETURN_DATE DATE,
    FOREIGN KEY (MEMBER_ID) REFERENCES Members(MEMBER_ID),
    FOREIGN KEY (BOOK_ID) REFERENCES Books(BOOK_ID)
);

-- 2. Sample Data Insertion
INSERT INTO Books VALUES
(10, 'Brave New World', 'Aldous Huxley', 'Science Fiction', 1932, 4),
(11, 'Educated', 'Tara Westover', 'Memoir', 2018, 2),
(12, 'Becoming', 'Michelle Obama', 'Biography', 2018, 3),
(13, 'The Alchemist', 'Paulo Coelho', 'Adventure', 1988, 5),
(14, 'Inferno', 'Dan Brown', 'Thriller', 2013, 1);

INSERT INTO Members VALUES
(10, 'Evelyn Clark', 'evelyn@example.com', '9876543210', '12 Sunset Blvd', '2022-05-12'),
(11, 'Frank Miller', 'frank@example.com', '8765432109', '45 Broadway', '2022-06-01'),
(12, 'Grace Kim', 'grace@example.com', '7654321098', '78 Market St', '2022-07-20'),
(13, 'Henry Ford', 'henry@example.com', '6543210987', '90 Industrial Rd', '2022-08-25');

INSERT INTO BorrowingRecords VALUES
(10, 10, 10, '2025-03-15', NULL),
(11, 10, 11, '2025-04-01', '2025-04-18'),
(12, 11, 12, '2025-04-12', NULL),
(13, 11, 14, '2025-03-02', '2025-03-22'),
(14, 12, 11, '2025-03-07', NULL),
(15, 12, 13, '2025-03-12', NULL),
(16, 12, 10, '2025-02-05', '2025-02-28');

-- 3. Information Retrieval Queries

-- a) Books currently borrowed by a specific member (e.g., Member_ID = 10)
-- SELECT B.TITLE, B.AUTHOR
-- FROM BorrowingRecords BR
-- JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
-- WHERE BR.MEMBER_ID = 10 AND BR.RETURN_DATE IS NULL;

-- b) Members with overdue books (>30 days and not returned)
-- SELECT DISTINCT M.NAME, M.EMAIL
-- FROM BorrowingRecords BR
-- JOIN Members M ON BR.MEMBER_ID = M.MEMBER_ID
-- WHERE BR.RETURN_DATE IS NULL AND BR.BORROW_DATE <= CURRENT_DATE - INTERVAL '30' DAY;

-- c) Books by genre with available copy count
-- SELECT GENRE, SUM(AVAILABLE_COPIES) AS TOTAL_AVAILABLE
-- FROM Books
-- GROUP BY GENRE;

-- d) Most borrowed book(s)
-- SELECT B.TITLE, COUNT(*) AS BORROW_COUNT
-- FROM BorrowingRecords BR
-- JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
-- GROUP BY B.TITLE
-- HAVING COUNT(*) = (
--     SELECT MAX(BORROW_COUNT)
--     FROM (
--         SELECT COUNT(*) AS BORROW_COUNT
--         FROM BorrowingRecords
--         GROUP BY BOOK_ID
--     ) AS SubQuery
-- );

-- e) Members who borrowed from at least 3 different genres
-- SELECT M.NAME
-- FROM BorrowingRecords BR
-- JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
-- JOIN Members M ON BR.MEMBER_ID = M.MEMBER_ID
-- GROUP BY M.MEMBER_ID, M.NAME
-- HAVING COUNT(DISTINCT B.GENRE) >= 3;

-- 4. Reporting and Analytics

-- a) Total number of books borrowed per month
-- SELECT DATE_FORMAT(BORROW_DATE, '%Y-%m-01') AS MONTH,
-- COUNT(*) AS TOTAL_BORROWED
-- FROM BorrowingRecords
-- GROUP BY MONTH
-- ORDER BY MONTH;



-- b) Top 3 most active members
-- SELECT M.NAME, COUNT(*) AS BOOKS_BORROWED
-- FROM BorrowingRecords BR
-- JOIN Members M ON BR.MEMBER_ID = M.MEMBER_ID
-- GROUP BY M.NAME
-- ORDER BY BOOKS_BORROWED DESC
-- LIMIT 3;

-- c) Authors with books borrowed at least 3 times ( it was changed to 3 to make sense with my sample)
-- SELECT B.AUTHOR, COUNT(*) AS TIMES_BORROWED
-- FROM BorrowingRecords BR
-- JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
-- GROUP BY B.AUTHOR
-- HAVING COUNT(*) >= 2;

-- d) Members who never borrowed a book
-- SELECT M.NAME
-- FROM Members M
-- LEFT JOIN BorrowingRecords BR ON M.MEMBER_ID = BR.MEMBER_ID
-- WHERE BR.BORROW_ID IS NULL;
