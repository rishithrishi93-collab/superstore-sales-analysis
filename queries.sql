-- =====================================================
-- Superstore Sales & Profitability Analysis
-- SQL Queries used for analysis (MySQL)
-- Dataset columns: Ship_Mode, Segment, Country, City, 
-- State, Postal_Code, Region, Category, Sub_Category, 
-- Sales, Quantity, Discount, Profit
-- =====================================================

-- 1. Sales & Profit by Region
-- Shows which regions generate the most revenue and profit,
-- and calculates profit margin % for each
SELECT 
    Region, 
    SUM(Sales) AS revenue, 
    SUM(Profit) AS profit,
    ROUND(SUM(Profit)/SUM(Sales)*100, 2) AS profit_margin
FROM orders
GROUP BY Region
ORDER BY profit DESC;


-- 2. Sales & Profit by Category and Sub-Category
-- Breaks down performance at a more granular product level
SELECT 
    Category, 
    Sub_Category, 
    SUM(Sales) AS revenue, 
    SUM(Profit) AS profit
FROM orders
GROUP BY Category, Sub_Category
ORDER BY profit ASC;


-- 3. Loss-Making Sub-Categories
-- Identifies which sub-categories are actually losing money,
-- along with their average discount rate (often the cause)
SELECT 
    Sub_Category, 
    SUM(Profit) AS total_profit, 
    SUM(Sales) AS total_sales,
    ROUND(AVG(Discount)*100, 1) AS avg_discount_pct
FROM orders
GROUP BY Sub_Category
HAVING total_profit < 0
ORDER BY total_profit ASC;


-- 4. Discount vs Profit Relationship by Category
-- Compares average discount rate against total profit per category
-- to check if heavy discounting is hurting profitability
SELECT 
    Category,
    ROUND(AVG(Discount)*100, 1) AS avg_discount_pct,
    SUM(Profit) AS total_profit
FROM orders
GROUP BY Category
ORDER BY avg_discount_pct DESC;


-- 5. Segment Performance by State (Top 10)
-- Finds the best-performing state + customer segment combinations
SELECT 
    State, 
    Segment, 
    SUM(Sales) AS revenue, 
    SUM(Profit) AS profit
FROM orders
GROUP BY State, Segment
ORDER BY profit DESC
LIMIT 10;


-- 6. Worst-Performing Cities (Bottom 10 by Profit)
-- Surfaces cities that may need pricing or operational review
SELECT 
    City, 
    SUM(Sales) AS revenue, 
    SUM(Profit) AS profit
FROM orders
GROUP BY City
ORDER BY profit ASC
LIMIT 10;
