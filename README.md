# Data Analytics SQL Assessment

## Overview
This repository contains the SQL queries addressing four data analytics questions, focusing on customer savings and investment behavior, transaction frequency, account inactivity, and customer lifetime value (CLV) estimation.

---

## Question 1: Customers with Both Savings and Investments
Approach:
- Joined the `users_customuser` table with `plans_plan` and `savings_savingsaccount`.  
- Filtered active plans (`status_id = 2`).  
- Summed flags for savings and investments to identify customers with both.  
- Calculated total deposits by summing `confirmed_amount` from transactions, converted from minor units.  
- Grouped by user and ordered by total deposits descending.

---

## Question 2: Customer Transaction Frequency Categories
Approach:  
- Calculated monthly transaction counts per customer.  
- Averaged monthly transaction counts to determine transaction frequency per month.  
- Categorized customers into 'High', 'Medium', or 'Low' frequency based on average transactions per month.  
- Aggregated counts and average transaction rates per category.

---

## Question 3: Account Inactivity Alert
Approach:  
- Focused on active plans (`status_id = 1`).  
- Considered inflow transactions only (`transaction_type_id IN (1, 2)` — IDs to be confirmed).  
- Found last transaction date per plan and owner.  
- Calculated inactivity in days since last transaction.  
- Flagged accounts with inactivity greater than 365 days.  
- Identified plan type using flags `is_regular_savings` and `is_fixed_investment`.

---

## Question 4: Customer Lifetime Value (CLV) Estimation
Approach:  
- Calculated tenure in months from user's join date to current date.  
- Counted total transactions and average transaction amount.  
- Applied simplified CLV formula:  
  `(monthly_txn_rate * 12 months) * (0.001 * avg_amount)`
- Profit per transaction assumed as 0.1% of transaction amount.  
- Sorted results by estimated CLV descending.

---

## Challenges and Resolution

1. Understanding the Data Relationships:
   It took some time to figure out how the tables were connected. I solved this by looking carefully at column names and testing simple queries to see how the data joined together.

2. Calculating Frequency Accurately:  
   Some customers only made transactions in a few months, which made their average transaction count seem too low. To fix this, I averaged transactions only for the months when they actually made transactions. This gave a fairer picture of how often they use their accounts.

3. Frequency Classification Logic:  
   Grouping customers by how often they transact involved several steps. I split the problem into smaller parts and used queries within queries to make it easier to understand and faster to run.
   
4. Inactive Plans Filter:  
   To find truly inactive accounts, I focused only on money coming in (inflow transactions). I double-checked the transaction types used and found the most recent transaction date with `MAX()` to spot inactivity correctly.

---
 

