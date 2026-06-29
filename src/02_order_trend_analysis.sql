/*
===============================================================================

Description:
This script analyzes order trends over time to identify business growth,
seasonality and customer purchasing behavior across years, months and
different time periods.

===============================================================================
*/

-------------------------------------------------------------------------------
-- Business Question 1
-- Calculate the year-on-year growth rate of total orders.
-------------------------------------------------------------------------------

SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
    COUNT(order_id) AS total_orders
FROM `target.orders`
GROUP BY order_year
ORDER BY order_year;



-------------------------------------------------------------------------------
-- Business Question 2
-- Calculate the number of orders placed each month.
-------------------------------------------------------------------------------

SELECT
    FORMAT_DATE('%B', order_purchase_timestamp) AS order_month,
    COUNT(order_id) AS total_orders
FROM `target.orders`
GROUP BYorder_month, EXTRACT(MONTH FROM order_purchase_timestamp)
ORDER BY EXTRACT(MONTH FROM order_purchase_timestamp);



-------------------------------------------------------------------------------
-- Business Question 3
-- Analyze order distribution by time of the day.
-------------------------------------------------------------------------------

SELECT
    CASE WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 0 AND 5 THEN 'Dawn'
         WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 6 AND 11 THEN 'Morning'
         WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 12 AND 17 THEN 'Afternoon'
	 ELSE 'Night' END AS time_of_day,
         COUNT(order_id) AS total_orders
FROM `target.orders`
GROUP BY time_of_day
ORDER BY total_orders DESC;