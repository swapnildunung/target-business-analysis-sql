/*
===============================================================================

Description:
This script analyzes the financial impact of e-commerce by evaluating
order values, revenue growth, freight costs and state-wise economic
contributions.

===============================================================================
*/

-------------------------------------------------------------------------------
-- Business Question 1
-- Calculate the percentage increase in total order value from
-- January–August 2017 to January–August 2018.
-------------------------------------------------------------------------------

SELECT
    a.month,
    a.total_cost_of_orders_in_2017,
    b.total_cost_of_orders_in_2018,
    ROUND((b.total_cost_of_orders_in_2018 - a.total_cost_of_orders_in_2017)/a.total_cost_of_orders_in_2017,2) AS percentage_increase_in_orders

FROM (SELECT FORMAT_DATE('%B', a.order_purchase_timestamp) AS month,
	     ROUND(SUM(b.payment_value),2) AS total_cost_of_orders_in_2017
      FROM `target.orders` a JOIN `target.payments` b ON a.order_id = b.order_id
      WHERE EXTRACT(YEAR FROM a.order_purchase_timestamp) = 2017 AND EXTRACT(MONTH FROM a.order_purchase_timestamp) BETWEEN 1 AND 8
      GROUP BY month) a
JOIN
     (SELECT FORMAT_DATE('%B', a.order_purchase_timestamp) AS month,
	     ROUND(SUM(b.payment_value),2) AS total_cost_of_orders_in_2018
      FROM `target.orders` a JOIN `target.payments` b ON a.order_id = b.order_id
      WHERE EXTRACT(YEAR FROM a.order_purchase_timestamp) = 2018 AND EXTRACT(MONTH FROM a.order_purchase_timestamp) BETWEEN 1 AND 8
      GROUP BY month) b
ON a.month = b.month
ORDER BY PARSE_DATE('%B', month);



-------------------------------------------------------------------------------
-- Business Question 2
-- Calculate the total and average order value for each state.
-------------------------------------------------------------------------------

SELECT
    a.customer_state,
    ROUND(SUM(c.payment_value),2) AS total_order_value,
    ROUND(AVG(c.payment_value),2) AS average_order_value
FROM `target.customers` a LEFT JOIN `target.orders` b ON a.customer_id = b.customer_id JOIN `target.payments` c ON b.order_id = c.order_id
GROUP BY customer_state
ORDER BY total_order_value DESC, average_order_value DESC;



-------------------------------------------------------------------------------
-- Business Question 3
-- Calculate the total and average freight value for each state.
-------------------------------------------------------------------------------

SELECT
    a.customer_state,
    ROUND(SUM(c.freight_value),2) AS total_freight_value,
    ROUND(AVG(c.freight_value),2) AS average_freight_value
FROM `target.customers` a LEFT JOIN `target.orders` b ON a.customer_id = b.customer_id JOIN `target.order_items` c ON b.order_id = c.order_id
GROUP BY customer_state
ORDER BY total_freight_value DESC, average_freight_value DESC;