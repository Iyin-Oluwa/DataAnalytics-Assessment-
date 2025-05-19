-- Assessment_Q2.sql
-- Categorize customers based on average transactions per month.


SELECT 
  CASE
    WHEN avg_txns_per_month >= 10 THEN 'High Frequency'
    WHEN avg_txns_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
  END AS frequency_category,
  COUNT(*) AS customer_count,
  -- Average transaction count per month across all customers in the category
  ROUND(AVG(avg_txns_per_month), 1) AS avg_transactions_per_month
FROM (
  -- Calculate average transactions per month for each customer
  SELECT
    owner_id,
    AVG(txn_count) AS avg_txns_per_month
  FROM (
    -- Count transactions per customer per year-month
    SELECT
      owner_id,
      YEAR(transaction_date) AS txn_year,
      MONTH(transaction_date) AS txn_month,
      COUNT(*) AS txn_count
    FROM savings_savingsaccount
    GROUP BY owner_id, YEAR(transaction_date), MONTH(transaction_date)
  ) AS monthly_txns
  GROUP BY owner_id
) AS avg_txns
GROUP BY frequency_category
-- Order categories by logical frequency order rather than alphabetical
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
