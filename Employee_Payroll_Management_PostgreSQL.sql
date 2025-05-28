
-- Employee Payroll Management System (PostgreSQL)

-- Drop table if it already exists
DROP TABLE IF EXISTS employees;

-- Create employees table
CREATE TABLE employees (
    EMPLOYEE_ID SERIAL PRIMARY KEY,
    NAME TEXT,
    DEPARTMENT TEXT,
    EMAIL TEXT,
    PHONE_NO NUMERIC,
    JOINING_DATE DATE,
    SALARY NUMERIC,
    BONUS NUMERIC,
    TAX_PERCENTAGE NUMERIC
);

-- 2. Sample Data Insertion

INSERT INTO employees (NAME, DEPARTMENT, EMAIL, PHONE_NO, JOINING_DATE, SALARY, BONUS, TAX_PERCENTAGE) VALUES
('Alice Johnson', 'Engineering', 'alice@company.com', 1234567890, '2023-11-01', 90000, 5000, 20),
('Bob Smith', 'Sales', 'bob@company.com', 1234567891, '2024-01-15', 85000, 10000, 18),
('Carol White', 'Marketing', 'carol@company.com', 1234567892, '2023-06-30', 75000, 8000, 15),
('David Lee', 'Engineering', 'david@company.com', 1234567893, '2022-09-10', 95000, 12000, 22),
('Eva Green', 'Sales', 'eva@company.com', 1234567894, '2024-03-05', 70000, 7000, 18),
('Frank Wright', 'HR', 'frank@company.com', 1234567895, '2023-12-01', 65000, 3000, 12),
('Grace Kim', 'Finance', 'grace@company.com', 1234567896, '2023-05-20', 98000, 9000, 20),
('Hank Miller', 'Engineering', 'hank@company.com', 1234567897, '2023-08-25', 90000, 11000, 20),
('Ivy Brown', 'Sales', 'ivy@company.com', 1234567898, '2024-04-10', 72000, 6000, 17),
('Jack Black', 'Finance', 'jack@company.com', 1234567899, '2022-11-11', 105000, 10000, 25);

-- 3. Payroll Queries

-- a) Employees sorted by salary descending
-- SELECT * FROM employees ORDER BY SALARY DESC;

-- b) Employees with total compensation > $100,000
-- SELECT * FROM employees WHERE (SALARY + BONUS) > 100000;

-- c) Update bonus for Sales department by 10%
-- UPDATE employees SET BONUS = BONUS * 1.10 WHERE DEPARTMENT = 'Sales';

-- d) Net salary after tax
-- SELECT NAME, SALARY, BONUS, TAX_PERCENTAGE,
--        (SALARY + BONUS) - ((SALARY + BONUS) * TAX_PERCENTAGE / 100) AS NET_SALARY
-- FROM employees;

-- e) Average, min, and max salary per department
-- SELECT DEPARTMENT,
--        AVG(SALARY) AS AVERAGE_SALARY,
--        MIN(SALARY) AS MIN_SALARY,
--        MAX(SALARY) AS MAX_SALARY
-- FROM employees
-- GROUP BY DEPARTMENT;

-- 4. Advanced Queries

-- a) Employees who joined in the last 6 months
-- SELECT * FROM employees
-- WHERE JOINING_DATE >= CURRENT_DATE - INTERVAL '6 months';

-- b) Group employees by department and count
-- SELECT DEPARTMENT, COUNT(*) AS EMPLOYEE_COUNT
-- FROM employees
-- GROUP BY DEPARTMENT;

-- c) Department with highest average salary
-- SELECT DEPARTMENT
-- FROM employees
-- GROUP BY DEPARTMENT
-- ORDER BY AVG(SALARY) DESC
-- LIMIT 1;

-- d) Employees with duplicate salaries
-- SELECT *
-- FROM employees
-- WHERE SALARY IN (
--     SELECT SALARY
--     FROM employees
--     GROUP BY SALARY
--     HAVING COUNT(*) > 1
-- );
