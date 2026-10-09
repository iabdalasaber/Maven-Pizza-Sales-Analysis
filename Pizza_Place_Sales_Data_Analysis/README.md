# 🍕 Maven Pizza Sales Analysis

## 📌 Project Overview

This project analyzes pizza sales data from **Maven Pizza Place** to understand sales performance, customer ordering patterns, product performance, revenue trends, and business opportunities.

The analysis was performed using **SQL Server** to answer business questions and generate actionable insights from the sales data.

---

## 🎯 Business Objective

The main goal of this project is to analyze pizza sales data and answer key business questions such as:

* When are orders highest?
* Which pizza types and sizes are most popular?
* Which products generate the most revenue?
* Which categories perform best?
* How does revenue change throughout the year?
* Which products may require further business review?
* Which pizzas are strong performers based on multiple business metrics?

---

## 🗂️ Dataset

The project uses the **Maven Pizza Place Sales** dataset.

The database contains four main tables:

### Orders

Contains information about customer orders.

| Column  | Description             |
| ------- | ----------------------- |
| OrderId | Unique order identifier |
| Date    | Order date              |
| Time    | Order time              |

### OrderDetails

Contains the pizzas included in each order.

| Column         | Description                    |
| -------------- | ------------------------------ |
| OrderDetailsId | Unique order-detail identifier |
| OrderId        | Related order                  |
| PizzaId        | Related pizza                  |
| Quantity       | Number of pizzas ordered       |

### Pizzas

Contains pizza size and pricing information.

| Column      | Description             |
| ----------- | ----------------------- |
| PizzaId     | Unique pizza identifier |
| PizzaTypeId | Related pizza type      |
| Size        | Pizza size              |
| Price       | Pizza price             |

### PizzaTypes

Contains pizza type and category information.

| Column      | Description                  |
| ----------- | ---------------------------- |
| PizzaTypeId | Unique pizza type identifier |
| Name        | Pizza name                   |
| Category    | Pizza category               |
| Ingredients | Ingredients used             |

---

## 🔗 Database Relationships

```text
PizzaTypes
    │
    │ PizzaTypeId
    ▼
Pizzas
    │
    │ PizzaId
    ▼
OrderDetails
    │
    │ OrderId
    ▼
Orders
```

---

## 🛠️ Tools & Technologies

* **SQL Server**
* **SQL Server Management Studio (SSMS)**
* SQL
* GitHub

---

## 📊 Analysis Performed

The analysis was divided into five levels.

### Level 1 — Basic Analysis

Covered:

* Orders by day
* Peak ordering hours
* Most ordered pizza sizes
* Highest-revenue pizza sizes
* Bestselling pizzas
* Lowest-selling pizzas
* Best-performing pizza categories

### Level 2 — Revenue & KPIs

Covered:

* Revenue by category
* Highest-revenue pizza
* Lowest-revenue pizza
* Average Order Value (AOV)
* Largest orders by quantity
* Largest orders by revenue
* Highest-revenue category
* Lowest-revenue pizza size

### Level 3 — Deeper Business Analysis

Covered:

* Average selling price
* Average quantity by category
* Average quantity per order
* Number of distinct orders containing each pizza
* Pizza types with no recorded sales
* Orders by pizza size
* Average revenue per order
* High-revenue / low-volume products
* Monthly order volume
* Revenue by weekday
* Revenue contribution by category and pizza type
* Revenue per pizza sold
* Orders containing multiple pizza types

### Level 4 — Advanced SQL Analysis

Covered:

* Above-average pizza performance
* Performance compared with category averages
* Ranking pizzas within categories
* Top 3 pizzas by category
* Revenue comparison using `LAG`
* Month-over-month revenue changes
* Revenue contribution within categories

### Level 5 — Final Business Analysis

Covered:

* High-revenue / low-order products
* High-price / low-volume products
* Pizza types appearing in multiple orders
* First-half vs second-half revenue
* Revenue changes by pizza type
* Average Order Value by month
* Average Order Value by weekday
* Hourly order and revenue performance
* Strong products based on multiple performance metrics

---

## 📈 Key Findings

### 🕒 Ordering Patterns

The analysis identified differences in order volume throughout the day and across days of the week, helping identify periods of higher demand.

Peak hours can be used to support:

* Staff scheduling
* Operational planning
* Promotion timing

---

### 🍕 Product Performance

Pizza performance varies significantly across products.

Some pizza types generate high sales volume, while others generate stronger revenue because of their pricing.

This highlights the importance of analyzing both:

* **Quantity sold**
* **Revenue generated**

rather than relying on only one metric.

---

### 💰 Revenue Performance

Monthly revenue showed noticeable variation throughout the year.

Based on the analyzed data:

* **July** had the highest monthly revenue: **$72,300**
* **October** had the lowest monthly revenue: **$63,796**

This indicates variation in monthly sales performance.

However, because the dataset covers only one year, the analysis cannot conclusively establish recurring yearly seasonality.

---

### 📦 Product Review Opportunities

Products with relatively low sales volume were identified for further review.

However, low sales alone should not automatically lead to removing a product.

Additional information such as:

* Product cost
* Profit margin
* Preparation cost
* Customer satisfaction
* Strategic importance

would be needed before making a final menu decision.

---

### 📊 Multi-Metric Performance

The analysis also evaluated pizza types using multiple metrics simultaneously, including:

* Revenue
* Quantity sold
* Number of orders

This provides a more complete view of product performance than looking at a single KPI.

---

## 💡 Business Recommendations

Based on the analysis:

1. **Focus operational resources on high-demand periods.**
2. **Monitor high-performing pizza types and categories.**
3. **Review low-volume products before making menu decisions.**
4. **Use promotions strategically for weaker-performing categories.**
5. **Evaluate products using revenue, quantity, and order frequency together.**
6. **Track monthly performance over multiple years before making strong seasonality conclusions.**
7. **Combine sales data with cost and profit data for better product decisions.**

---

## 📁 Project Structure

```text
Maven-Pizza-Sales-Analysis/
│
├── README.md
│
├── SQL/
│   ├── 01_Data_Exploration.sql
│   ├── 02_Level_1_Basic_Analysis.sql
│   ├── 03_Level_2_Revenue_KPIs.sql
│   ├── 04_Level_3_Advanced_Analysis.sql
│   ├── 05_Level_4_Advanced_SQL.sql
│   └── 06_Level_5_Business_Analysis.sql
│
└── Dataset/
    └── README.md
```

---

## 🎓 Skills Demonstrated

This project demonstrates practical experience with:

* SQL Server
* SELECT and filtering
* Sorting and aggregation
* `GROUP BY`
* `HAVING`
* `JOIN`
* `LEFT JOIN`
* Subqueries
* CTEs
* Window Functions
* `RANK`
* `LAG`
* Date and time analysis
* KPI analysis
* Revenue analysis
* Product performance analysis
* Data-driven business thinking
* Translating business questions into SQL queries

---

## 🚀 Project Outcome

This project demonstrates an end-to-end SQL analysis workflow:

```text
Business Question
       ↓
Identify Required Data
       ↓
Select Relevant Tables
       ↓
Join Related Data
       ↓
Filter & Aggregate
       ↓
Analyze KPIs
       ↓
Identify Patterns
       ↓
Generate Business Insights
       ↓
Recommend Actions
```

The project focuses not only on writing SQL queries, but also on understanding **what the business is asking, what data is required, how to analyze it, and what the results mean from a business perspective.**

---

## 📌 Conclusion

The Maven Pizza Sales Analysis project provided a practical SQL-based analysis of pizza sales performance across products, categories, order patterns, revenue, and time periods.

The analysis demonstrates how SQL can be used to move from raw transactional data to meaningful business insights and recommendations.