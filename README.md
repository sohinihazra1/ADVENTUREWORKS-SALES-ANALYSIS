# ADVENTUREWORKS-SALES-ANALYSIS

## Project Overview

This project analyzes AdventureWorks sales data from 2020–2022 using SQL, Python, and Power BI. The objective is to transform raw transactional data into actionable business insights by performing data assessment, cleaning, exploratory data analysis (EDA), and dashboard development.

---

## Project Workflow

1. Data Assessment
2. Data Cleaning & Transformation
3. Exploratory Data Analysis (EDA)
4. Dashboard Development (Power BI)
5. Business Insights & Recommendations

---

## Dataset Overview

AdventureWorks is a sample retail dataset provided by Microsoft representing a fictional company selling bicycles and related products.

The dataset contains information related to:

- Sales transactions
- Customers
- Products
- Product Categories
- Product Subcategories
- Regions
- Returns
- Calendar Dates

The sales data is distributed across multiple yearly files (2020–2022) and was consolidated into a unified sales dataset for analysis.

---

## Data Assessment

Data assessment revealed several data quality issues, including date fields stored as text, customer names split across multiple columns, missing values in customer and product-related attributes, inconsistent categorical values, and placeholder values such as zeros in certain fields. 

---

## Data Cleaning & Transformation

The following cleaning steps were performed:

- Combined sales data from 2020, 2021, and 2022 into a single fact table
- Converted date columns to proper datetime format
- Standardized key fields across all tables
- Removed duplicate records
- Handled missing values and invalid entries
- Created unified customer names
- Standardized gender, marital status, and homeowner categories
- Replaced missing product descriptions where necessary
- Built a complete calendar dimension table
- Prepared cleaned CSV files for SQL and Power BI modeling

---

## Key Findings

### Business Performance

- The business generated over *$24 million in total revenue* during the analysis period.
- Overall profitability remained strong, with a *profit margin of approximately 41.8%*.
- Revenue and profit showed consistent growth throughout the three-year period, indicating healthy business performance.

### Product Performance

- *Bikes* were the highest-performing product category and contributed the largest share of overall revenue.
- The *Components* category generated little to no revenue compared to other categories, highlighting a potential opportunity for product promotion and market analysis.
- Product preferences varied across countries, suggesting opportunities for region-specific marketing and inventory strategies.

### Geographic Performance

- *North America* generated the highest overall revenue among all countries.
- At the regional level, *Australia* was the strongest-performing region by revenue.
- Revenue generation was concentrated within a limited number of key markets.

### Customer Insights

- A total of *732 registered customers* had never placed an order.
- Customer purchasing behavior varied across demographic groups such as income level, occupation, education level, and family size.
- A relatively small group of customers contributed a significant share of total revenue.

### Returns Analysis

- The overall return rate was *2.17%*.
- Product returns resulted in approximately *$765.28K in lost revenue*.
- Products such as *Tire Tubes, Bottle Cages, and Road Bikes* were among the most frequently returned items.
- Returns were concentrated within specific products and regions, indicating potential quality, product-fit, or customer expectation issues.

---

## Business Recommendations

### Product Strategy

- Continue prioritizing inventory planning and marketing efforts for the *Bikes* category, which remains the company's primary revenue driver.
- Conduct a detailed analysis of the *Components* category to identify causes of low sales performance.
- Improve visibility of Components products through targeted advertising, bundled offers, and cross-selling opportunities alongside bike purchases.

### Customer Growth Strategy

- Launch targeted email campaigns for the *732 inactive customers* who have never placed an order.
- Offer first-purchase discounts, loyalty rewards, or promotional incentives to encourage customer activation.
  
### Geographic Strategy

- Continue investing in high-performing markets such as *North America* and *Australia*.
- Replicate successful sales and marketing strategies from these regions in lower-performing markets.
- Tailor product promotions based on regional purchasing preferences and demand patterns.

### Return Reduction Strategy

- Collect customer feedback from individuals who returned products to better understand return reasons.
- Investigate recurring issues associated with *Tire Tubes, Bottle Cages, and Road Bikes*.
- Improve product descriptions, quality control processes, and customer education materials to reduce avoidable returns.
- Reducing the current *2.17% return rate* could help recover a portion of the *$765.28K revenue loss* and improve overall profitability.

---

## Conclusion

This project demonstrates a complete end-to-end data analytics workflow, including data assessment, cleaning, exploratory data analysis, and dashboard development using SQL, Python, and Power BI. The analysis revealed strong overall business performance, with Bikes serving as the primary revenue driver and North America and Australia emerging as key markets. Opportunities for future growth include activating the *732 inactive customers, improving performance within the **Components* category, and reducing the *2.17% return rate, which currently contributes to approximately *$765.28K in lost revenue**. Implementing these recommendations can support higher customer engagement, increased sales, and improved profitability.
