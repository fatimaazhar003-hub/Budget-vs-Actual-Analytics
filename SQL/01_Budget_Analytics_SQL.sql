CREATE DATABASE BudgetAnalyticsDB;
USE BudgetAnalyticsDB;
SELECT DATABASE();
CREATE TABLE budget_vs_actual (
    Date DATE,
    Department VARCHAR(50),
    Category VARCHAR(50),
    Region VARCHAR(50),
    Budget_Amount DECIMAL(15,2),
    Actual_Amount DECIMAL(15,2),
    Payment_Method VARCHAR(50),
    Transaction_ID VARCHAR(50),
    Variance DECIMAL(15,2)
);
SHOW TABLES;
DESCRIBE budget_vs_actual;

SELECT COUNT(*) AS total_rows
FROM budget_vs_actual;

SELECT *
FROM budget_vs_actual
LIMIT 10;

SELECT
    SUM(Budget_Amount) AS Total_Budget,
    SUM(Actual_Amount) AS Total_Actual,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage
FROM budget_vs_actual;

SELECT
    CASE
        WHEN Variance > 0 THEN 'Over Budget'
        WHEN Variance < 0 THEN 'Under Budget'
        ELSE 'On Budget'
    END AS Budget_Status,
    COUNT(*) AS Transaction_Count
FROM budget_vs_actual
GROUP BY Budget_Status;

SELECT
    Department,
    SUM(Budget_Amount) AS Total_Budget,
    SUM(Actual_Amount) AS Total_Actual,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage,
    COUNT(*) AS Transaction_Count
FROM budget_vs_actual
GROUP BY Department
ORDER BY Total_Variance DESC;

SELECT
    Category,
    SUM(Budget_Amount) AS Total_Budget,
    SUM(Actual_Amount) AS Total_Actual,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage,
    COUNT(*) AS Transaction_Count
FROM budget_vs_actual
GROUP BY Category
ORDER BY Total_Variance DESC;

SELECT
    Department,
    Category,
    SUM(Budget_Amount) AS Total_Budget,
    SUM(Actual_Amount) AS Total_Actual,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage,
    COUNT(*) AS Transaction_Count
FROM budget_vs_actual
WHERE Department <> 'Unknown'
  AND Category <> 'Unknown'
GROUP BY Department, Category
ORDER BY Total_Variance DESC
LIMIT 10;

SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    DATE_FORMAT(Date, '%Y-%m') AS Month_Period,
    SUM(Budget_Amount) AS Total_Budget,
    SUM(Actual_Amount) AS Total_Actual,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage
FROM budget_vs_actual
GROUP BY YEAR(Date), MONTH(Date), DATE_FORMAT(Date, '%Y-%m')
ORDER BY Year, Month;

SELECT
    YEAR(Date) AS Year,
    SUM(Budget_Amount) AS Total_Budget,
    SUM(Actual_Amount) AS Total_Actual,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage,
    COUNT(*) AS Transaction_Count
FROM budget_vs_actual
GROUP BY YEAR(Date)
ORDER BY Year;

SELECT
    Region,
    SUM(Budget_Amount) AS Total_Budget,
    SUM(Actual_Amount) AS Total_Actual,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage,
    COUNT(*) AS Transaction_Count
FROM budget_vs_actual
WHERE Region <> 'Unknown'
GROUP BY Region
ORDER BY Total_Variance DESC;

SELECT
    Region,
    Department,
    SUM(Budget_Amount) AS Total_Budget,
    SUM(Actual_Amount) AS Total_Actual,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage,
    COUNT(*) AS Transaction_Count
FROM budget_vs_actual
WHERE Region <> 'Unknown'
  AND Department <> 'Unknown'
GROUP BY Region, Department
ORDER BY Region, Total_Variance DESC;

SELECT
    Payment_Method,
    SUM(Budget_Amount) AS Total_Budget,
    SUM(Actual_Amount) AS Total_Actual,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage,
    COUNT(*) AS Transaction_Count
FROM budget_vs_actual
GROUP BY Payment_Method
ORDER BY Total_Variance DESC;

SELECT
    Department,
    Category,
    Region,
    SUM(Variance) AS Total_Variance,
    ROUND(
        SUM(Variance) / SUM(Budget_Amount) * 100,
        2
    ) AS Variance_Percentage,
    COUNT(*) AS Transaction_Count
FROM budget_vs_actual
WHERE Department <> 'Unknown'
  AND Category <> 'Unknown'
  AND Region <> 'Unknown'
GROUP BY Department, Category, Region
ORDER BY Total_Variance DESC
LIMIT 10;