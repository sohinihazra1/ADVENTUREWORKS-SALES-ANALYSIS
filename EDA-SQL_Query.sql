# Exploratory Data Analysis (EDA) for AdventureWorks Dataset.

CREATE DATABASE adventurework_db;
USE adventurework_db;


# Creating a complete sales table.
CREATE TABLE total_sales AS SELECT * FROM
    sales_2020 
UNION ALL SELECT 
    *
FROM
    sales_2021 
UNION ALL SELECT 
    *
FROM
    sales_2022;
SELECT 
    *
FROM
    total_sales;

# Total Revenue
SELECT
    ROUND(SUM(p.ProductPrice * s.OrderQuantity),2) AS TotalRevenue
FROM total_sales s
JOIN products p
ON s.ProductKey = p.ProductKey;

# Total Profit
SELECT
    ROUND(SUM(
        (p.ProductPrice - p.ProductCost)
        * s.OrderQuantity
    ),2) AS TotalProfit
FROM total_sales s
JOIN products p
ON s.ProductKey = p.ProductKey;


CREATE VIEW monthly_sales_summary AS
SELECT
    YEAR(s.OrderDate) AS SalesYear,
    MONTH(s.OrderDate) AS SalesMonth,
    ROUND(SUM(p.ProductPrice * s.OrderQuantity), 2) AS Revenue,
    ROUND(
        SUM(
            (p.ProductPrice - p.ProductCost)
            * s.OrderQuantity
        ),
        2
    ) AS Profit
FROM total_sales s
JOIN products p
    ON s.ProductKey = p.ProductKey
GROUP BY
    YEAR(s.OrderDate),
    MONTH(s.OrderDate);
SELECT * FROM monthly_sales_summary

# Highest revenue month
SELECT *
FROM monthly_sales_summary
ORDER BY Revenue DESC
LIMIT 1;

# Highet profit month
SELECT *
FROM monthly_sales_summary
ORDER BY Profit DESC
LIMIT 1;

# Average monthly revenue
SELECT
    ROUND(AVG(Revenue), 2) AS AvgRevenue
FROM monthly_sales_summary;

# Months with revenue above the average 
SELECT *
FROM monthly_sales_summary
WHERE Revenue >
(
    SELECT AVG(Revenue)
    FROM monthly_sales_summary
);

# Profit margin by month
SELECT
    SalesYear,
    SalesMonth,
    Revenue,
    Profit,
    ROUND((Profit / Revenue) * 100, 2) AS ProfitMarginPct
FROM monthly_sales_summary;


# Total Revenue and Profit of 2020
SELECT SUM(Revenue), SUM(Profit)
FROM monthly_sales_summary
WHERE SalesYear = 2020;

# Total Revenue and Profit of 2021
SELECT SUM(Revenue), SUM(Profit)
FROM monthly_sales_summary
WHERE SalesYear = 2021;

# Total Revenue and Profit of 2022
SELECT SUM(Revenue), SUM(Profit)
FROM monthly_sales_summary
WHERE SalesYear = 2022;

# Creating a product details view
CREATE VIEW product_details AS
    SELECT 
        psc.SubcategoryName,
        ps.CategoryName,
        ps.ProductCategoryKey,
        p.*
    FROM
        product_subcategories AS psc
           LEFT JOIN
        product_categories AS ps ON ps.ProductCategoryKey = psc.ProductCategoryKey
           LEFT JOIN
        products AS p ON p.ProductSubcategoryKey = psc.ProductSubCategoryKey;
	SELECT * FROM product_details; 

# Top 3 Products by Revenue    
SELECT
    pd.ProductName,
    ROUND(
        SUM(pd.ProductPrice * s.OrderQuantity),
        2
    ) AS Revenue
FROM total_sales s
JOIN product_details pd
    ON s.ProductKey = pd.ProductKey
GROUP BY pd.ProductName
ORDER BY Revenue DESC
LIMIT 3;
    
# Top 3 Products by Profit    
SELECT
    pd.ProductName,
    ROUND(
        SUM(
            (pd.ProductPrice - pd.ProductCost)
            * s.OrderQuantity
        ),
        2
    ) AS Profit
FROM total_sales s
JOIN product_details pd
    ON s.ProductKey = pd.ProductKey
GROUP BY pd.ProductName
ORDER BY Profit DESC
LIMIT 3;

# Top 3 Product Subcategories by Revenue 
SELECT
    pd.SubcategoryName,
    ROUND(
        SUM(pd.ProductPrice * s.OrderQuantity),
        2
    ) AS Revenue
FROM total_sales s
JOIN product_details pd
    ON s.ProductKey = pd.ProductKey
GROUP BY pd.SubcategoryName
ORDER BY Revenue DESC
LIMIT 3;

#Product Categories by Revenue 
SELECT
    pd.CategoryName,
    ROUND(
        SUM(pd.ProductPrice * s.OrderQuantity),
        2
    ) AS Revenue
FROM total_sales s
JOIN product_details pd
    ON s.ProductKey = pd.ProductKey
GROUP BY pd.CategoryName
ORDER BY Revenue DESC;

# Total orders year wise
SELECT 
    YEAR(OrderDate), COUNT(DISTINCT OrderNumber)
FROM
    total_sales
GROUP BY YEAR(OrderDate);


# Top 10 customers by revenue
SELECT 
    c.CustomerName,
    ROUND(SUM(pd.ProductPrice * s.OrderQuantity),
            2) AS Revenue
FROM
    total_sales s
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
        JOIN
    product_details pd ON s.ProductKey = pd.ProductKey
GROUP BY c.CustomerName
ORDER BY Revenue DESC
LIMIT 10;

# Revenue by gender
SELECT 
    c.Gender,
    ROUND(SUM(pd.ProductPrice * s.OrderQuantity),
            2) AS Revenue
FROM
    total_sales s
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
        JOIN
    product_details pd ON s.ProductKey = pd.ProductKey
GROUP BY c.Gender;
  
# Revenue by Occupation
SELECT 
    c.Occupation,
    ROUND(SUM(pd.ProductPrice * s.OrderQuantity),
            2) AS Revenue
FROM
    total_sales s
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
        JOIN
    product_details pd ON s.ProductKey = pd.ProductKey
GROUP BY c.Occupation
ORDER BY Revenue DESC;

# Revenue by Education
SELECT 
    c.EducationLevel,
    ROUND(SUM(pd.ProductPrice * s.OrderQuantity),
            2) AS Revenue
FROM
    total_sales s
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
        JOIN
    product_details pd ON s.ProductKey = pd.ProductKey
GROUP BY c.EducationLevel
ORDER BY Revenue DESC;

# Revenue by HomeOwner
SELECT 
    c.HomeOwner,
    ROUND(SUM(pd.ProductPrice * s.OrderQuantity),
            2) AS Revenue
FROM
    total_sales s
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
        JOIN
    product_details pd ON s.ProductKey = pd.ProductKey
GROUP BY c.HomeOwner
ORDER BY Revenue DESC;

# Revenue by Mariatal status
SELECT 
    c.MaritalStatus,
    ROUND(SUM(pd.ProductPrice * s.OrderQuantity),
            2) AS Revenue
FROM
    total_sales s
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
        JOIN
    product_details pd ON s.ProductKey = pd.ProductKey
GROUP BY c.MaritalStatus
ORDER BY Revenue DESC;

# Revenue by income group
SELECT 
    CASE
        WHEN AnnualIncome < 70000 THEN 'Low Income'
        WHEN AnnualIncome < 120000 AND AnnualIncome >= 70000  THEN 'Middle Income'
        ELSE 'High Income'
    END AS IncomeGroup,
    ROUND(SUM(pd.ProductPrice * s.OrderQuantity),
            2) AS Revenue
FROM
    total_sales s
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
        JOIN
    product_details pd ON s.ProductKey = pd.ProductKey
GROUP BY IncomeGroup
ORDER BY Revenue DESC;

# Revenue by Family type
SELECT 
    CASE
        WHEN  TotalChildren < 3 THEN 'Small Family'
        WHEN TotalChildren < 5 AND TotalChildren >= 3 THEN 'Midium Family'
        ELSE 'Large Family'
    END AS FamilyType,
    ROUND(SUM(pd.ProductPrice * s.OrderQuantity),
            2) AS Revenue
FROM
    total_sales s
        JOIN
    customers c ON s.CustomerKey = c.CustomerKey
        JOIN
    product_details pd ON s.ProductKey = pd.ProductKey
GROUP BY FamilyType 
ORDER BY Revenue DESC;

# customers distribution by country
SELECT
    COUNT(DISTINCT c.CustomerKey) AS TotalCustomers,
    r.Country
FROM customers c
JOIN total_sales ts
    ON c.CustomerKey = ts.CustomerKey
JOIN regions r
    ON ts.TerritoryKey = r.TerritoryKey
GROUP BY r.Country
ORDER BY TotalCustomers DESC;

# customers distribution by Region
SELECT 
    COUNT(c.CustomerKey) AS TotalCustomers, r.Region
FROM
    customers AS c
        JOIN total_sales AS ts ON c.CustomerKey = ts.CustomerKey
        join
    regions AS r ON ts.TerritoryKey = r.TerritoryKey
GROUP BY Region
ORDER BY TotalCustomers DESC;

# Revenue and Profit by Country
WITH country_performance AS (
    SELECT
        r.Country,
        ROUND(
            SUM(pd.ProductPrice * s.OrderQuantity),
            2
        ) AS Revenue,
        ROUND(
            SUM(
                (pd.ProductPrice - pd.ProductCost)
                * s.OrderQuantity
            ),
            2
        ) AS Profit
    FROM total_sales s
    JOIN product_details pd
        ON s.ProductKey = pd.ProductKey
    JOIN regions r
        ON s.TerritoryKey = r.TerritoryKey
    GROUP BY r.Country
)
SELECT *
FROM country_performance
ORDER BY Revenue DESC;
  
  # Revenue and Profit by Region
  WITH country_performance AS (
    SELECT
        r.Region,
        ROUND(
            SUM(pd.ProductPrice * s.OrderQuantity),
            2
        ) AS Revenue,
        ROUND(
            SUM(
                (pd.ProductPrice - pd.ProductCost)
                * s.OrderQuantity
            ),
            2
        ) AS Profit
    FROM total_sales s
    JOIN product_details pd
        ON s.ProductKey = pd.ProductKey
    JOIN regions r
        ON s.TerritoryKey = r.TerritoryKey
    GROUP BY r.Region
)
SELECT *
FROM country_performance
ORDER BY Revenue DESC;

# Top products country-wise by revenue
WITH country_product_revenue AS (
    SELECT
        r.Country,
        pd.ProductName,
        ROUND(
            SUM(pd.ProductPrice * s.OrderQuantity),
            2
        ) AS Revenue,
        ROW_NUMBER() OVER (
            PARTITION BY r.Country
            ORDER BY SUM(pd.ProductPrice * s.OrderQuantity) DESC
        ) AS rn
    FROM total_sales s
    JOIN product_details pd
        ON s.ProductKey = pd.ProductKey
    JOIN regions r
        ON s.TerritoryKey = r.TerritoryKey
    GROUP BY
        r.Country,
        pd.ProductName
)
SELECT
    Country,
    ProductName,
    Revenue
FROM country_product_revenue
WHERE rn = 1
ORDER BY Revenue DESC;


# Top products country-wise by profit
WITH country_product_profit AS (
    SELECT
        r.Country,
        pd.ProductName,
        ROUND(
            SUM(
                (pd.ProductPrice - pd.ProductCost)
                * s.OrderQuantity
            ),
            2
        ) AS Profit,
        ROW_NUMBER() OVER (
            PARTITION BY r.Country
            ORDER BY SUM(
                (pd.ProductPrice - pd.ProductCost)
                * s.OrderQuantity
            ) DESC
        ) AS rn
    FROM total_sales s
    JOIN product_details pd
        ON s.ProductKey = pd.ProductKey
    JOIN regions r
        ON s.TerritoryKey = r.TerritoryKey
    GROUP BY
        r.Country,
        pd.ProductName
)
SELECT
    Country,
    ProductName,
    Profit
FROM country_product_profit
WHERE rn = 1
ORDER BY Profit DESC;

#Total Returns
SELECT 
    SUM(ReturnQuantity) AS TotalReturns
FROM
    returns;
    
# Return rate
SELECT
    ROUND(
        SUM(r.ReturnQuantity) /
        SUM(ts.OrderQuantity) * 100,
        2
    ) AS ReturnRate
FROM returns r
JOIN total_sales ts
    ON r.ProductKey = ts.ProductKey;

# Most Returned products
SELECT
    pd.ProductName,
    SUM(r.ReturnQuantity) AS ReturnedQuantity
FROM returns r
JOIN product_details pd
    ON r.ProductKey = pd.ProductKey
GROUP BY pd.ProductName
ORDER BY ReturnedQuantity DESC
LIMIT 10;

# Returns by countries
SELECT
    rg.Country,
    SUM(r.ReturnQuantity) AS ReturnedQuantity
FROM returns r
JOIN regions rg
    ON r.TerritoryKey = rg.TerritoryKey
GROUP BY rg.Country
ORDER BY ReturnedQuantity DESC;

# Returns by regions
SELECT
    rg.Region,
    SUM(r.ReturnQuantity) AS ReturnedQuantity
FROM returns r
JOIN regions rg
    ON r.TerritoryKey = rg.TerritoryKey
GROUP BY rg.Region
ORDER BY ReturnedQuantity DESC;

# profit loss from returns
SELECT
    ROUND(
        SUM(
            r.ReturnQuantity
            * (pd.ProductPrice - pd.ProductCost)
        ),
        2
    ) AS ProfitLost
FROM returns r
JOIN product_details pd
    ON r.ProductKey = pd.ProductKey;
    
    # revenue loss from returns
SELECT
    ROUND(
        SUM(
            r.ReturnQuantity
            * pd.ProductPrice
        ),
        2
    ) AS RevenueLost
FROM returns r
JOIN product_details pd
    ON r.ProductKey = pd.ProductKey;
    
# Customers who never appear in any sales table
SELECT
    c.CustomerKey,
    c.CustomerName,
    c.EmailAddress
FROM customers c
LEFT JOIN total_sales ts 
    ON c.CustomerKey = ts.CustomerKey
WHERE ts.CustomerKey IS NULL;
    
# Relation between product price and total orders
WITH PriceAndOrders AS(
SELECT 
    pd.ProductName,
    pd.SubcategoryName,
    pd.ProductPrice,
    SUM(pd.ProductPrice * ts.OrderQuantity) AS OrderPrice,
    COUNT(ts.OrderNumber) AS TotalOrders
FROM
    product_details AS pd
        JOIN
    total_sales AS ts ON pd.ProductKey = ts.ProductKey
        JOIN
    customers AS c ON ts.CustomerKey = c.CustomerKey
    GROUP BY   pd.ProductName,
    pd.SubcategoryName,
    pd.ProductPrice)
    SELECT * FROM PriceAndOrders
    ORDER BY TotalOrders DESC;
    
