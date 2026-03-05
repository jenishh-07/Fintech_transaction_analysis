
# FinTech Payments SQL Analysis

## Objective
The objective of this project is to analyze a simulated **FinTech payments platform dataset** to understand customer transaction behavior, merchant performance, and regional revenue distribution.

The analysis focuses on identifying **high-value customers, top performing cities, merchant category performance, and platform growth trends** using SQL.

The goal of this project is to demonstrate **real-world business analysis using SQL**, combining joins, aggregations, window functions, CTEs, and subqueries.

---

## Dataset Overview

The dataset simulates a digital payments platform containing the following tables:

| Table | Description |
|------|-------------|
| customers | Customer information including city and signup details |
| accounts | Customer wallet or savings accounts |
| transactions | Payment transactions performed by customers |
| merchants | Merchants where transactions occur |
| loans | Loan information associated with customers |

---

## Data Relationships

```
customers
   │
   ├── accounts
   │      │
   │      └── transactions
   │              │
   │              └── merchants
   │
   └── loans
```

This structure allows analysis of **customer activity, merchant performance, and credit product opportunities**.

---

## Key Business Questions

1. **Transaction Revenue by City**  
   Which cities generate the highest transaction revenue on the platform?

2. **High Activity Customers**  
   Which customers perform the highest number of transactions?

3. **Maximum Transaction per Customer**  
   What is the largest transaction performed by each customer?

4. **Top Spending Customer in Each City**  
   Who is the highest spending customer within each city?

5. **Customers Spending Above Platform Average**  
   Which customers spend more than the average transaction value on the platform?

6. **Top Merchant in Each Category**  
   Which merchants generate the highest revenue within their merchant category?

7. **Highest Spending Customer per Day**  
   Which customer performs the largest transaction amount on each day?

8. **Top Customers per City**  
   Who are the top customers generating the highest spending in each city?

9. **Customers Spending Above City Average**  
   Which customers spend more than the average spending level in their city?

10. **Customer Spending Rank per City**  
    How do customers rank within their cities based on total spending?

---

## Key Insights

### Revenue Concentration
Transaction revenue is concentrated in a small number of cities, indicating stronger adoption of digital payments in those regions.

### High-Value Customers
A small group of customers contributes a significant portion of total transaction volume, highlighting the importance of **customer retention and loyalty programs**.

### Merchant Dominance
Certain merchants dominate their categories, suggesting strong customer preference and potential opportunities for **merchant partnerships and promotions**.

### Credit Product Opportunity
Many active customers do not currently have loans, representing an opportunity for the platform to expand **credit and lending services**.

### Customer Segmentation
Ranking customers by spending reveals high-value users within each city, which can help design targeted **cashback campaigns, loyalty rewards, and premium services**.

---

## Skills Demonstrated

- SQL Joins
- Aggregations and Grouping
- Window Functions
- Ranking Analysis
- Subqueries
- CTE (Common Table Expressions)
- Customer Segmentation
- Merchant Performance Analysis

---

## Tools Used

- SQL
- PostgreSQL / MySQL
- GitHub

---

## Project Outcome

This project demonstrates how SQL can be used to perform **real-world business analysis on FinTech transaction data**.

The analysis helps identify:

- revenue patterns
- high-value customers
- merchant performance
- regional market opportunities

These insights can support **product strategy, marketing campaigns, and financial service expansion** for digital payment platforms.
