-- Assessment_Q4.sql
-- Calculate customer lifetime value (CLV) based on tenure and transaction volume.



SELECT 
  u.id AS customer_id,
  CONCAT(u.first_name, ' ', u.last_name) AS name,
  -- Calculate the number of months since the user joined
  TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
  -- Count total transactions per user
  COUNT(s.id) AS total_transactions,
  -- Calculate estimated CLV:
  -- (average transactions per month * 12 months * average profit per transaction)
  -- Profit per transaction assumed as 0.1% (0.001) of average transaction amount
  ROUND(
    (
      (COUNT(s.id) / GREATEST(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 1)) 
      * 12 
      * (0.001 * AVG(s.amount))
    ), 2
  ) AS estimated_clv
FROM users_customuser u
JOIN savings_savingsaccount s ON u.id = s.owner_id
-- This is an optional filter: consider only successful transactions
WHERE s.transaction_status = 'success'  
GROUP BY u.id, name
ORDER BY estimated_clv DESC;
