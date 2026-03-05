-- FINTECH SQL ANALYTICS PROJECT SCHEMA

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS customers;

-- Import Rules
-- 1st import customers
-- 2nd import merchants
-- 3rd import accounts
-- 4th import loans
-- 5th import transactions


CREATE TABLE customers
(
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE,
    kyc_status VARCHAR(20)
);


CREATE TABLE merchants
(
    merchant_id INT PRIMARY KEY,
    merchant_name VARCHAR(50),
    category VARCHAR(50),
    city VARCHAR(50)
);


CREATE TABLE accounts
(
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10,2),
    created_at DATE,
    CONSTRAINT fk_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE loans
(
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount DECIMAL(10,2),
    interest_rate DECIMAL(5,2),
    loan_status VARCHAR(20),
    disbursed_date DATE,
    CONSTRAINT fk_loan_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE transactions
(
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(10),
    amount DECIMAL(10,2),
    merchant_id INT,
    transaction_date DATE,

    CONSTRAINT fk_account
    FOREIGN KEY (account_id) REFERENCES accounts(account_id),

    CONSTRAINT fk_merchant
    FOREIGN KEY (merchant_id) REFERENCES merchants(merchant_id)
);

-- END OF SCHEMA
