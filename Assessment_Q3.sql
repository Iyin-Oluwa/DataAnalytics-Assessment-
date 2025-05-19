-- Assessment_Q3.sql
-- Identify active savings or investment plans inactive for over 365 days.



SELECT    
  s.plan_id,   
  s.owner_id,   
  -- Determine plan type based on plan flags
  CASE 
    WHEN p.is_regular_savings = 1 THEN 'Savings'
    WHEN p.is_fixed_investment = 1 THEN 'Investment'
    ELSE 'Other'
  END AS type,
  -- Get the date of the last transaction on the plan
  MAX(s.transaction_date) AS last_transaction_date,   
  -- Calculate days of inactivity by difference from current date
  DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days 
FROM savings_savingsaccount s 
JOIN plans_plan p ON s.plan_id = p.id 
WHERE p.status_id = 1  -- Only consider active plans
  AND s.transaction_type_id IN (1, 2)  -- Filter for inflow transaction types (assumed IDs)
GROUP BY s.plan_id, s.owner_id, type
-- Only show plans inactive for more than 365 days
HAVING inactivity_days > 365
ORDER BY inactivity_days DESC;
