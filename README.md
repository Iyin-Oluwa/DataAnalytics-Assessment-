# DataAnalytics-Assessment


# Data Analytics SQL Assessment

## Overview
This repository contains the SQL queries addressing four data analytics questions, focusing on customer savings and investment behavior, transaction frequency, account inactivity, and customer lifetime value (CLV) estimation.

---

## Question 1: Customers with Both Savings and Investments
**Approach:**  
- Joined the `users_customuser` table with `plans_plan` and `savings_savingsaccount`.  
- Filtered active plans (`status_id = 2`).  
- Summed flags for savings and investments to identify customers with both.  
- Calculated total deposits by summing `confirmed_amount` from transactions, converted from minor units.  
- Grouped by user and ordered by total deposits descending.

---

## Question 2: Customer Transaction Frequency Categories
**Approach:**  
- Calculated monthly transaction counts per customer.  
- Averaged monthly transaction counts to determine transaction frequency per month.  
- Categorized customers into 'High', 'Medium', or 'Low' frequency based on average transactions per month.  
- Aggregated counts and average transaction rates per category.

---

## Question 3: Account Inactivity Alert
**Approach:**  
- Focused on active plans (`status_id = 1`).  
- Considered inflow transactions only (`transaction_type_id IN (1, 2)` — IDs to be confirmed).  
- Found last transaction date per plan and owner.  
- Calculated inactivity in days since last transaction.  
- Flagged accounts with inactivity greater than 365 days.  
- Identified plan type using flags `is_regular_savings` and `is_fixed_investment`.

---

## Question 4: Customer Lifetime Value (CLV) Estimation
**Approach:**  
- Calculated tenure in months from user's join date to current date.  
- Counted total transactions and average transaction amount.  
- Applied simplified CLV formula:  
  \[
  CLV = \left(\frac{\text{total transactions}}{\text{tenure months}}\right) \times 12 \times \text{avg profit per transaction}
  \]
- Profit per transaction assumed as 0.1% of transaction amount.  
- Sorted results by estimated CLV descending.

---

## Challenges and Resolution
- **Date and time handling:** Ensured use of MySQL functions like `YEAR()`, `MONTH()`, and `TIMESTAMPDIFF()` for accurate date calculations.  
- **Transaction type IDs:** The exact `transaction_type_id` for inflows was assumed; confirmation may be needed to ensure accuracy.  
- **Null and zero division handling:** Used `GREATEST` function to avoid division by zero when tenure is less than one month.  
- **Data aggregation and joins:** Careful grouping was necessary to avoid duplication and ensure meaningful aggregation across related tables.

---

