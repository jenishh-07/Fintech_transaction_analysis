-- Explore Tables

SELECT * FROM customers;
SELECT * FROM accounts;
SELECT * FROM transactions;
SELECT * FROM merchants;
SELECT * FROM loans;



-- =====================================================
-- Reports & Data Analysis
-- =====================================================



-- Q1
-- Total Transaction Amount by City
-- Which cities generate the highest transaction revenue?

SELECT 
    cust.city,
    SUM(tx.amount) AS total_revenue
FROM transactions tx
JOIN accounts acc
ON tx.account_id = acc.account_id
JOIN customers cust
ON acc.customer_id = cust.customer_id
GROUP BY cust.city
ORDER BY total_revenue DESC;



-- Q2
-- Customers with More Than 3 Transactions

WITH transaction_count AS
(
SELECT 
    acc.customer_id,
    COUNT(tx.transaction_id) AS total_transactions
FROM accounts acc
LEFT JOIN transactions tx
ON acc.account_id = tx.account_id
GROUP BY acc.customer_id
)

SELECT *
FROM transaction_count
WHERE total_transactions > 3;



-- Q3
-- Maximum Transaction Amount per Customer

SELECT 
    acc.customer_id,
    COALESCE(MAX(tx.amount),0) AS max_transaction
FROM accounts acc
LEFT JOIN transactions tx
ON acc.account_id = tx.account_id
GROUP BY acc.customer_id;



-- Q4
-- Top Spending Customer in Each City

WITH customer_total_spend AS
(
SELECT 
    cust.customer_id,
    cust.city,
    COALESCE(SUM(tx.amount),0) AS total_spent
FROM customers cust
LEFT JOIN accounts acc
ON cust.customer_id = acc.customer_id
LEFT JOIN transactions tx
ON acc.account_id = tx.account_id
GROUP BY cust.customer_id,cust.city
),

city_rankings AS
(
SELECT 
    customer_id,
    city,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS spend_rank
FROM customer_total_spend
)

SELECT *
FROM city_rankings
WHERE spend_rank = 1;



-- Q5
-- Customers Spending More Than Platform Average

SELECT 
    acc.customer_id,
    COALESCE(SUM(tx.amount),0) AS total_spent
FROM accounts acc
LEFT JOIN transactions tx
ON acc.account_id = tx.account_id
GROUP BY acc.customer_id
HAVING COALESCE(SUM(tx.amount),0) >
(
SELECT AVG(amount)
FROM transactions
);



-- Q6
-- Top Merchant in Each Category

WITH merchant_revenue AS
(
SELECT 
    mer.category,
    mer.merchant_id,
    mer.merchant_name,
    SUM(tx.amount) AS total_revenue
FROM merchants mer
LEFT JOIN transactions tx
ON mer.merchant_id = tx.merchant_id
GROUP BY mer.category,mer.merchant_id,mer.merchant_name
),

merchant_rankings AS
(
SELECT 
    category,
    merchant_id,
    merchant_name,
    total_revenue,
    DENSE_RANK() OVER(
        PARTITION BY category
        ORDER BY total_revenue DESC
    ) AS category_rank
FROM merchant_revenue
)

SELECT *
FROM merchant_rankings
WHERE category_rank = 1;



-- Q7
-- Customer with Highest Spending per Day

WITH daily_customer_spend AS
(
SELECT 
    cust.customer_id,
    tx.transaction_date,
    SUM(tx.amount) AS daily_total
FROM transactions tx
LEFT JOIN accounts acc
ON tx.account_id = acc.account_id
LEFT JOIN customers cust
ON acc.customer_id = cust.customer_id
GROUP BY cust.customer_id,tx.transaction_date
),

daily_rankings AS
(
SELECT 
    customer_id,
    transaction_date,
    daily_total,
    DENSE_RANK() OVER(
        PARTITION BY transaction_date
        ORDER BY daily_total DESC
    ) AS daily_rank
FROM daily_customer_spend
)

SELECT *
FROM daily_rankings
WHERE daily_rank = 1;



-- Q8
-- Top 2 Customers by Spending in Each City

WITH customer_spend AS
(
SELECT 
    cust.customer_id,
    cust.city,
    COALESCE(SUM(tx.amount),0) AS total_spent
FROM customers cust
LEFT JOIN accounts acc
ON cust.customer_id = acc.customer_id
LEFT JOIN transactions tx
ON acc.account_id = tx.account_id
GROUP BY cust.customer_id,cust.city
),

city_rankings AS
(
SELECT 
    customer_id,
    city,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS city_rank
FROM customer_spend
)

SELECT *
FROM city_rankings
WHERE city_rank <= 2;



-- Q9
-- Customers Spending Above City Average

WITH customer_spend AS
(
SELECT 
    cust.city,
    cust.customer_id,
    SUM(tx.amount) AS total_spent
FROM transactions tx
JOIN accounts acc
ON tx.account_id = acc.account_id
JOIN customers cust
ON acc.customer_id = cust.customer_id
GROUP BY cust.city,cust.customer_id
)

SELECT *
FROM customer_spend cs
WHERE total_spent >
(
SELECT AVG(total_spent)
FROM customer_spend
WHERE city = cs.city
);



-- Q10
-- Customer Spending Rank Within Each City

WITH customer_spend AS
(
SELECT 
    cust.customer_id,
    cust.city,
    COALESCE(SUM(tx.amount),0) AS total_spent
FROM customers cust
LEFT JOIN accounts acc
ON cust.customer_id = acc.customer_id
LEFT JOIN transactions tx
ON acc.account_id = tx.account_id
GROUP BY cust.customer_id,cust.city
)

SELECT 
    customer_id,
    city,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS spend_rank
FROM customer_spend;



-- =====================================================
-- Final Business Insights
-- =====================================================

-- 1. Transaction revenue is concentrated in a few major cities,
--    indicating stronger platform adoption in those markets.

-- 2. A small number of customers generate a significant share
--    of total transaction volume, showing strong revenue concentration.

-- 3. Certain merchants dominate within their categories,
--    suggesting high customer preference for specific platforms.

-- 4. Several active customers currently have no loans,
--    indicating a strong opportunity for credit product marketing.

-- 5. Daily transaction leaders and top customers per city
--    highlight high-value users who can be targeted for loyalty
--    programs, cashback campaigns, or premium services.
