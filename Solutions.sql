Good — we’ll keep the same strong questions, but I will adjust the queries to follow the style you used while solving:
Your style was mostly:-- =====================================================
-- Reports & Data Analysis
-- =====================================================



-- Q1
-- Top Spending Customer in Each City

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    c.city,
    COALESCE(SUM(t.amount),0) AS total_spent
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
LEFT JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id,c.city
),

ranked AS
(
SELECT 
    customer_id,
    city,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS rnk
FROM customer_spend
)

SELECT *
FROM ranked
WHERE rnk = 1;



-- Q2
-- Customers Spending Above Their City Average

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    c.city,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id,c.city
)

SELECT *
FROM customer_spend cs
WHERE total_spent >
(
SELECT AVG(total_spent)
FROM customer_spend
WHERE city = cs.city
);



-- Q3
-- Top Merchant in Each Category

WITH merchant_spend AS
(
SELECT 
    m.category,
    m.merchant_id,
    m.merchant_name,
    COALESCE(SUM(t.amount),0) AS total_spent
FROM merchants m
LEFT JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY m.category,m.merchant_id,m.merchant_name
),

ranked AS
(
SELECT 
    category,
    merchant_id,
    merchant_name,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY category
        ORDER BY total_spent DESC
    ) AS rnk
FROM merchant_spend
)

SELECT *
FROM ranked
WHERE rnk = 1;



-- Q4
-- Daily Transaction Leader

WITH daily_spend AS
(
SELECT 
    c.customer_id,
    t.transaction_date,
    SUM(t.amount) AS total_spent
FROM transactions t
JOIN accounts a
    ON t.account_id = a.account_id
JOIN customers c
    ON a.customer_id = c.customer_id
GROUP BY c.customer_id,t.transaction_date
),

ranked AS
(
SELECT 
    customer_id,
    transaction_date,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY transaction_date
        ORDER BY total_spent DESC
    ) AS rnk
FROM daily_spend
)

SELECT *
FROM ranked
WHERE rnk = 1;



-- Q5
-- Top 2 Customers by Spending in Each City

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    c.city,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id,c.city
),

ranked AS
(
SELECT 
    customer_id,
    city,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS rnk
FROM customer_spend
)

SELECT *
FROM ranked
WHERE rnk <= 2;



-- Q6
-- Revenue Contribution by Merchant Category

SELECT 
    m.category,
    SUM(t.amount) AS total_revenue
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY m.category
ORDER BY total_revenue DESC;



-- Q7
-- Cities with Highest Average Customer Spending

WITH customer_spend AS
(
SELECT 
    c.city,
    c.customer_id,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.city,c.customer_id
)

SELECT 
    city,
    AVG(total_spent) AS avg_spent
FROM customer_spend
GROUP BY city
ORDER BY avg_spent DESC;



-- Q8
-- High Spending Customers Without Loans

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id
)

SELECT *
FROM customer_spend cs
LEFT JOIN loans l
    ON cs.customer_id = l.customer_id
WHERE l.loan_id IS NULL
ORDER BY total_spent DESC;



-- Q9
-- Monthly Transaction Growth

WITH monthly_revenue AS
(
SELECT 
    MONTH(transaction_date) AS month,
    SUM(amount) AS revenue
FROM transactions
GROUP BY MONTH(transaction_date)
)

SELECT 
    month,
    revenue,
    LAG(revenue) OVER(ORDER BY month) AS previous_month,
    ROUND(
        (revenue - LAG(revenue) OVER(ORDER BY month)) /
        LAG(revenue) OVER(ORDER BY month) * 100
        ,2
    ) AS growth_percent
FROM monthly_revenue;



-- Q10
-- Customer Spending Rank Within Each City

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    c.city,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id,c.city
)

SELECT 
    customer_id,
    city,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS rnk
FROM customer_spend;
CTE first
then window function ranking
sometimes subquery filtering
heavy use of COALESCE
LEFT JOIN when safe
aggregation inside CTE
I also changed aliases to cleaner ones (c, a, t, m, l).
Below is the clean final version matching your solving style.
Reports & Data Analysis
Sql
Copy code
-- =====================================================
-- Reports & Data Analysis
-- =====================================================



-- Q1
-- Top Spending Customer in Each City

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    c.city,
    COALESCE(SUM(t.amount),0) AS total_spent
FROM customers c
LEFT JOIN accounts a
    ON c.customer_id = a.customer_id
LEFT JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id,c.city
),

ranked AS
(
SELECT 
    customer_id,
    city,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS rnk
FROM customer_spend
)

SELECT *
FROM ranked
WHERE rnk = 1;



-- Q2
-- Customers Spending Above Their City Average

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    c.city,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id,c.city
)

SELECT *
FROM customer_spend cs
WHERE total_spent >
(
SELECT AVG(total_spent)
FROM customer_spend
WHERE city = cs.city
);



-- Q3
-- Top Merchant in Each Category

WITH merchant_spend AS
(
SELECT 
    m.category,
    m.merchant_id,
    m.merchant_name,
    COALESCE(SUM(t.amount),0) AS total_spent
FROM merchants m
LEFT JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY m.category,m.merchant_id,m.merchant_name
),

ranked AS
(
SELECT 
    category,
    merchant_id,
    merchant_name,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY category
        ORDER BY total_spent DESC
    ) AS rnk
FROM merchant_spend
)

SELECT *
FROM ranked
WHERE rnk = 1;



-- Q4
-- Daily Transaction Leader

WITH daily_spend AS
(
SELECT 
    c.customer_id,
    t.transaction_date,
    SUM(t.amount) AS total_spent
FROM transactions t
JOIN accounts a
    ON t.account_id = a.account_id
JOIN customers c
    ON a.customer_id = c.customer_id
GROUP BY c.customer_id,t.transaction_date
),

ranked AS
(
SELECT 
    customer_id,
    transaction_date,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY transaction_date
        ORDER BY total_spent DESC
    ) AS rnk
FROM daily_spend
)

SELECT *
FROM ranked
WHERE rnk = 1;



-- Q5
-- Top 2 Customers by Spending in Each City

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    c.city,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id,c.city
),

ranked AS
(
SELECT 
    customer_id,
    city,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS rnk
FROM customer_spend
)

SELECT *
FROM ranked
WHERE rnk <= 2;



-- Q6
-- Revenue Contribution by Merchant Category

SELECT 
    m.category,
    SUM(t.amount) AS total_revenue
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY m.category
ORDER BY total_revenue DESC;



-- Q7
-- Cities with Highest Average Customer Spending

WITH customer_spend AS
(
SELECT 
    c.city,
    c.customer_id,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.city,c.customer_id
)

SELECT 
    city,
    AVG(total_spent) AS avg_spent
FROM customer_spend
GROUP BY city
ORDER BY avg_spent DESC;



-- Q8
-- High Spending Customers Without Loans

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id
)

SELECT *
FROM customer_spend cs
LEFT JOIN loans l
    ON cs.customer_id = l.customer_id
WHERE l.loan_id IS NULL
ORDER BY total_spent DESC;



-- Q9
-- Monthly Transaction Growth

WITH monthly_revenue AS
(
SELECT 
    MONTH(transaction_date) AS month,
    SUM(amount) AS revenue
FROM transactions
GROUP BY MONTH(transaction_date)
)

SELECT 
    month,
    revenue,
    LAG(revenue) OVER(ORDER BY month) AS previous_month,
    ROUND(
        (revenue - LAG(revenue) OVER(ORDER BY month)) /
        LAG(revenue) OVER(ORDER BY month) * 100
        ,2
    ) AS growth_percent
FROM monthly_revenue;



-- Q10
-- Customer Spending Rank Within Each City

WITH customer_spend AS
(
SELECT 
    c.customer_id,
    c.city,
    SUM(t.amount) AS total_spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id,c.city
)

SELECT 
    customer_id,
    city,
    total_spent,
    DENSE_RANK() OVER(
        PARTITION BY city
        ORDER BY total_spent DESC
    ) AS rnk
FROM customer_spend;
Why This Version Is Good
Now the project clearly demonstrates:
✔ CTE patterns (majority queries)
✔ Window functions for ranking
✔ Subquery comparison
✔ multi-table joins
✔ real business questions
This is exactly what SQL interviewers test.
If you want, I can also show you one last extremely strong SQL question you solved (the hardest one) that will make the project look much stronger than 95% SQL GitHub portfolios.
