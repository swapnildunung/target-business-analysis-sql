/*
===============================================================================
Description:
This script performs initial database exploration to understand the
overall dataset structure, data availability and business coverage before
conducting detailed analysis.

===============================================================================
*/

-------------------------------------------------------------------------------
-- Business Question 1
-- What is the overall date range of orders available in the dataset?
-------------------------------------------------------------------------------

SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM `target.orders`;



-------------------------------------------------------------------------------
-- Business Question 2
-- How many unique cities and states are covered?
-------------------------------------------------------------------------------

SELECT
    COUNT(DISTINCT customer_city) AS total_cities,
    COUNT(DISTINCT customer_state) AS total_states
FROM `target.customers`;



-------------------------------------------------------------------------------
-- Business Question 3
-- How many unique customers are present?
-------------------------------------------------------------------------------

SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM `target.customers`;



-------------------------------------------------------------------------------
-- Business Question 4
-- How many unique sellers are available?
-------------------------------------------------------------------------------

SELECT
    COUNT(DISTINCT seller_id) AS total_sellers
FROM `target.sellers`;



-------------------------------------------------------------------------------
-- Business Question 5
-- How many unique products are available?
-------------------------------------------------------------------------------

SELECT
    COUNT(DISTINCT product_id) AS total_products
FROM `target.products`;



-------------------------------------------------------------------------------
-- Business Question 6
-- Total number of orders in the dataset.
-------------------------------------------------------------------------------

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM `target.orders`;



-------------------------------------------------------------------------------
-- Business Question 7
-- Order status distribution.
-------------------------------------------------------------------------------

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM `target.orders`
GROUP BY order_status
ORDER BY total_orders DESC;



-------------------------------------------------------------------------------
-- Business Question 8
-- Monthly order volume overview.
-------------------------------------------------------------------------------

SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS order_month,
    COUNT(*) AS total_orders
FROM `target.orders`
GROUP BY order_year, order_month
ORDER BY order_year, order_month;