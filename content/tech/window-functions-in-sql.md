---
title: "Window Functions in SQL"
date: 2026-09-10T11:13:00
description: "Apply Aggregate Functions to Specific Data"
tags: ["tool", "tutorial"]
categories: ["Tech notes"]
---

> 🔔 **Prelude:**
>
> Boss: "I need the average sales for 7 days."
>
> Me: "Sure! Which 7 days?"
>
> Boss: "All the 7 days!"
>
> Me: "Su…Sure…?"

## 🖋️ Window Functions

Window functions are generally applied after aggregate functions like `MAX()`, `MIN()`, `AVG()` to perform calculations **across** a set of table rows(days before, days after) that are related to the current row(current day).

#### Example Table 1: `employees`

| employee_id | department_id | salary |
| --- | --- | --- |
| 1 | 101 | 5000 |
| 2 | 101 | 6000 |
| 3 | 101 | 5500 |
| 4 | 102 | 7000 |
| 5 | 102 | 7200 |
| 6 | 102 | 6800 |

#### Example 1: `OVER()` Without Partitioning

Calculate the average salary for all employees:

```sql
SELECT
    employee_id,
    department_id,
    salary,
    AVG(salary) OVER() AS avg_salary_all_departments
FROM
    employees;

```

**Result:**

| employee_id | department_id | salary | **avg_salary_all_departments** |
| --- | --- | --- | --- |
| 1 | 101 | 5000 | 6250 |
| 2 | 101 | 6000 | 6250 |
| 3 | 101 | 5500 | 6250 |
| 4 | 102 | 7000 | 6250 |
| 5 | 102 | 7200 | 6250 |
| 6 | 102 | 6800 | 6250 |

#### Example 2: `PARTITION BY`

Calculate the average salary **per** department:

```sql
SELECT
    employee_id,
    department_id,
    salary,
    AVG(salary) OVER(PARTITION BY department_id) AS avg_salary_per_department
FROM
    employees;

```

**Result:**

| employee_id | department_id | salary | **avg_salary_per_department** |
| --- | --- | --- | --- |
| 1 | 101 | 5000 | 5500 |
| 2 | 101 | 6000 | 5500 |
| 3 | 101 | 5500 | 5500 |
| 4 | 102 | 7000 | 7000 |
| 5 | 102 | 7200 | 7000 |
| 6 | 102 | 6800 | 7000 |

#### Example 3: `ORDER BY` with Ranking

Rank employees **by** salary **within** their departments:

```sql
SELECT
    employee_id,
    department_id,
    salary,
    RANK() OVER(PARTITION BY **department_id** ORDER BY **salary** DESC) AS **salary_rank**
FROM
    employees;

```

**Result:**

| employee_id | **department_id** | **salary** | **salary_rank** |
| --- | --- | --- | --- |
| 2 | 101 | 6000 | 1 |
| 3 | 101 | 5500 | 2 |
| 1 | 101 | 5000 | 3 |
| 5 | 102 | 7200 | 1 |
| 4 | 102 | 7000 | 2 |
| 6 | 102 | 6800 | 3 |

---

#### Example Table 2: `orders`

| order_id | order_date | order_total |
| --- | --- | --- |
| 1 | 2023-01-01 | 100 |
| 2 | 2023-01-03 | 200 |
| 3 | 2023-01-05 | 150 |
| 4 | 2023-01-07 | 250 |
| 5 | 2023-01-09 | 300 |

#### Example 4: `RANGE` with Date Intervals

Sum the total orders in the last 7 days for **each row**: (INTERVAL 6 because included CURRENT ROW)

```sql
SELECT
    order_id,
    order_date,
    order_total,
    SUM(order_total) OVER(ORDER BY order_date RANGE BETWEEN INTERVAL '6' DAY PRECEDING AND CURRENT ROW) AS sum_last_7_days
FROM
    orders;

```

**Result:**

| order_id | order_date | order_total | sum_last_7_days |
| --- | --- | --- | --- |
| 1 | 2023-01-01 | 100 | 100 |
| 2 | 2023-01-03 | 200 | 300 |
| 3 | 2023-01-05 | 150 | 450 |
| 4 | 2023-01-07 | 250 | 700 |
| 5 | 2023-01-09 | 300 | 950 |

#### Example 5: `ROWS` Between Preceding and Following

Calculate the sum of order totals for the current row and the 2 preceding rows:

```sql
SELECT
    order_id,
    order_date,
    order_total,
    SUM(order_total) OVER(ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS sum_last_3_orders
FROM
    orders;

```

**Result:**

| order_id | order_date | order_total | sum_last_3_orders |
| --- | --- | --- | --- |
| 1 | 2023-01-01 | 100 | 100 |
| 2 | 2023-01-03 | 200 | 300 |
| 3 | 2023-01-05 | 150 | 450 |
| 4 | 2023-01-07 | 250 | 600 |
| 5 | 2023-01-09 | 300 | 700 |

---

#### References sheet

After max()…

- **OVER(…)**: Applied **over** ...
- **PARTITION BY**: Used to **divide by** ...
- **ORDER BY** [DESC]
- **ROWS** `[BETWEEN...AND]`
    1. `n PRECEDING`
    2. `n FOLLOWING`
    3. `CURRENT ROW`
    4. `UNBOUNDED PRECEDING` All before
    5. `UNBOUNDED FOLLOWING` All after
- **RANGE** `[BETWEEN...AND]`
    1. `INTERVAL 'n' DAY`
