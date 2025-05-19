-- Assessment_Q1.sql
-- Find customers who have both savings and investment plans, with total deposits, ordered by total deposits descending.


SELECT 
  u.id AS owner_id,
  CONCAT(u.first_name, ' ', u.last_name) AS name,
  -- Sum flags to count how many savings and investment plans each user has
  SUM(p.is_regular_savings) AS savings_count,
  SUM(p.is_a_fund) AS investment_count,
  -- Sum confirmed deposit amounts (assumed in minor units), convert to major units by dividing by 100
  ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits
FROM users_customuser u
-- Join plans for users where plan is active (status_id = 2)
JOIN plans_plan p ON u.id = p.owner_id AND p.status_id = 2
-- Left join savings accounts to include all plans, even if no transactions yet
LEFT JOIN savings_savingsaccount s ON s.plan_id = p.id
GROUP BY u.id, u.first_name, u.last_name
-- Filter to only users having at least one savings plan AND one investment plan
HAVING savings_count > 0 AND investment_count > 0
ORDER BY total_deposits DESC;
