/*
===============================================================================

Description:
This script analyzes customer distribution across states and evaluates
regional order patterns to identify high-value and under-penetrated
markets for business expansion.

===============================================================================
*/

-------------------------------------------------------------------------------
-- Business Question 1
-- Find the number of customers in each state.
-------------------------------------------------------------------------------

SELECT
    customer_state,
    COUNT(DISTINCT customer_id) AS total_customers
FROM `target.customers`
GROUP BY customer_state
ORDER BY total_customers DESC;



-------------------------------------------------------------------------------
-- Business Question 2
-- Find the number of orders placed by customers from each state.
-------------------------------------------------------------------------------

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM `target.customers` c LEFT JOIN `target.orders` o ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY total_orders DESC;



-------------------------------------------------------------------------------
-- Business Question 3
-- Calculate the average number of orders per customer for each state.
-------------------------------------------------------------------------------

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(COUNT(DISTINCT o.order_id)/COUNT(DISTINCT c.customer_id),2) AS average_orders_per_customer
FROM `target.customers` c LEFT JOIN `target.orders` o ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY average_orders_per_customer DESC, total_orders DESC;