Objective

The objective of this project is to analyze a simulated FinTech payments platform dataset to understand customer transaction behavior, merchant performance, and regional revenue distribution.

The analysis focuses on identifying high-value customers, top performing cities, merchant category performance, and platform growth trends using SQL.

The goal is to demonstrate real-world business analysis using SQL, combining joins, aggregations, window functions, CTEs, and subqueries.

Dataset Overview

The dataset simulates a digital payments platform containing the following tables:

Table	Description
customers	Customer information including city and signup data
accounts	Customer wallet/savings accounts
transactions	Payment transactions performed by users
merchants	Merchants where transactions occur
loans	Loan information for customers
Data Relationships
customers
   │
   ├── accounts
   │      │
   │      └── transactions
   │              │
   │              └── merchants
   │
   └── loans

This structure allows analysis of customer activity, merchant revenue, and credit product opportunities.

Key Questions
Transaction Revenue by City

Which cities generate the highest total transaction revenue on the platform?

High Activity Customers

Which customers perform the highest number of transactions?

Maximum Transaction per Customer

What is the largest transaction performed by each customer?

Top Spending Customer in Each City

Who is the highest spending customer within each city?

Customers Spending Above Platform Average

Which customers spend more than the average transaction value on the platform?

Top Merchant in Each Category

Which merchants generate the highest transaction revenue within their categories?

Highest Spending Customer per Day

Which customer performs the largest transaction amount on each day?

Top Customers per City

Who are the top 2 customers generating the highest spending in each city?

Customers Spending Above City Average

Which customers spend more than the average spending level in their city?

Customer Spending Rank per City

How do customers rank within their cities based on total spending?

Key Insights

After analyzing the dataset, several important business insights emerge:

Revenue Concentration

Transaction revenue is concentrated in a small number of cities, indicating stronger adoption of digital payments in those regions.

High-Value Customers

A small group of customers contributes a significant portion of total transaction volume, highlighting the importance of customer retention and loyalty programs.

Merchant Dominance

Certain merchants dominate their categories, suggesting strong customer preference and potential opportunities for merchant partnerships and promotions.

Credit Product Opportunity

Many active customers do not currently have loans, representing an opportunity for the platform to expand credit and lending services.

Customer Segmentation

Ranking customers by spending reveals high-value users within each city, which can help design targeted cashback campaigns, loyalty rewards, and premium services.

Skills Demonstrated

This project demonstrates practical SQL skills used in real analytics roles:

SQL Joins

Aggregations and Grouping

Window Functions

Ranking Analysis

Subqueries

CTE (Common Table Expressions)

Customer Segmentation

Merchant Performance Analysis

Tools Used

SQL

PostgreSQL / MySQL

GitHub

Project Outcome

This project showcases how SQL can be used to perform real-world business analysis on FinTech transaction data, helping identify:

revenue patterns

high-value customers

merchant performance

regional market opportunities

The analysis demonstrates how data-driven insights can support product strategy, marketing campaigns, and financial service expansion.