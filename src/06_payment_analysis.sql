/*
===============================================================================

Description:
This script analyzes customer payment behavior by evaluating payment
methods, installment usage and payment trends to support financial
and business decision making.

===============================================================================
*/

-------------------------------------------------------------------------------
-- Business Question 1
-- Analyze month-wise payment method trends.
-------------------------------------------------------------------------------

SELECT
    FORMAT_DATE('%B - %Y',o.order_purchase_timestamp) AS order_month,
    SUM(CASE WHEN p.payment_type='credit_card' THEN 1 ELSE 0 END) AS credit_card_payment,
    SUM(CASE WHEN p.payment_type='boleto' THEN 1 ELSE 0 END) AS boleto_payment,
    SUM(CASE WHEN p.payment_type='voucher' THEN 1 ELSE 0 END) AS voucher_payment,
    SUM(CASE WHEN p.payment_type='debit_card' THEN 1 ELSE 0 END) AS debit_card_payment,
    SUM(CASE WHEN p.payment_type='not_defined' THEN 1 ELSE 0 END) AS not_defined_payment
FROM `target.orders` o LEFT JOIN `target.payments` p ON o.order_id=p.order_id
GROUP BY order_month, EXTRACT(YEAR FROM o.order_purchase_timestamp), EXTRACT(MONTH FROM o.order_purchase_timestamp)
ORDER BY EXTRACT(YEAR FROM o.order_purchase_timestamp), EXTRACT(MONTH FROM o.order_purchase_timestamp);



-------------------------------------------------------------------------------
-- Business Question 2
-- Analyze payment method distribution.
-------------------------------------------------------------------------------

SELECT
    payment_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(payment_value),2) AS total_payment_value,
    ROUND(AVG(payment_value),2) AS average_payment_value
FROM `target.payments`
GROUP BY payment_type
ORDER BY total_payment_value DESC;



-------------------------------------------------------------------------------
-- Business Question 3
-- Analyze installment usage.
-------------------------------------------------------------------------------

SELECT
    payment_installments,
    COUNT(*) AS total_orders,
    ROUND(AVG(payment_value),2) AS average_payment_value,
    ROUND(SUM(payment_value),2) AS total_payment_value
FROM `target.payments`
GROUP BY payment_installments
ORDER BY payment_installments;



-------------------------------------------------------------------------------
-- Business Question 4
-- Average payment value by payment method.
-------------------------------------------------------------------------------

SELECT
    payment_type,
    ROUND(AVG(payment_value),2) AS average_payment_value
FROM `target.payments`
GROUP BY payment_type
ORDER BY average_payment_value DESC;