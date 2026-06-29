/*
===============================================================================

Description:
This script analyzes freight costs and delivery performance to identify
logistics efficiency, high-cost regions and opportunities to optimize
delivery operations.

===============================================================================
*/

-------------------------------------------------------------------------------
-- Business Question 1
-- Top 5 states with highest average freight value.
-------------------------------------------------------------------------------

SELECT
    c.customer_state,
    ROUND(AVG(oi.freight_value),2) AS average_freight_value
FROM `target.customers` c LEFT JOIN `target.orders` o ON c.customer_id=o.customer_id JOIN `target.order_items` oi ON o.order_id=oi.order_id
GROUP BY c.customer_state
ORDER BY average_freight_value DESC
LIMIT 5;



-------------------------------------------------------------------------------
-- Business Question 2
-- Bottom 5 states with lowest average freight value.
-------------------------------------------------------------------------------

SELECT
    c.customer_state,
    ROUND(AVG(oi.freight_value),2) AS average_freight_value
FROM `target.customers` c LEFT JOIN `target.orders` o ON c.customer_id=o.customer_id JOIN `target.order_items` oi ON o.order_id=oi.order_id
GROUP BY c.customer_state
ORDER BY average_freight_value
LIMIT 5;



-------------------------------------------------------------------------------
-- Business Question 3
-- Top 5 states with highest average delivery time.
-------------------------------------------------------------------------------

SELECT
    c.customer_state,
    ROUND(AVG(DATE_DIFF(o.order_delivered_customer_date,o.order_purchase_timestamp,DAY)),2) AS average_delivery_days
FROM `target.customers` c LEFT JOIN `target.orders` o ON c.customer_id=o.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY average_delivery_days DESC
LIMIT 5;



-------------------------------------------------------------------------------
-- Business Question 4
-- Top 5 states with fastest average deliveries.
-------------------------------------------------------------------------------

SELECT
    c.customer_state,
    ROUND(AVG(DATE_DIFF(o.order_delivered_customer_date,o.order_purchase_timestamp,DAY)),2) AS average_delivery_days
FROM `target.customers` c LEFT JOIN `target.orders` o ON c.customer_id=o.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY average_delivery_days
LIMIT 5;



-------------------------------------------------------------------------------
-- Business Question 5
-- Compare estimated delivery time with actual delivery time.
-------------------------------------------------------------------------------

SELECT
    ROUND(AVG(DATE_DIFF(o.order_estimated_delivery_date,o.order_purchase_timestamp,DAY)),2) AS estimated_delivery_days,
    ROUND(AVG(DATE_DIFF(o.order_delivered_customer_date,o.order_purchase_timestamp,DAY)),2) AS actual_delivery_days,
    ROUND(AVG(DATE_DIFF(o.order_estimated_delivery_date,o.order_delivered_customer_date,DAY)),2) AS average_delivery_gap
FROM `target.orders` o
WHERE o.order_delivered_customer_date IS NOT NULL;