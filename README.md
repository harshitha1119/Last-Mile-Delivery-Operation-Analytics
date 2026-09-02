# 🚚 Last-Mile Delivery Operations Analytics

### MySQL Business Analytics Project

## 📌 Project Overview

**Last-Mile Delivery Operations Analytics** is a MySQL-based business analytics project developed to analyse the delivery operations of **QuickRoute** Logistics, a fictional last-mile delivery company.

The project focuses on understanding **delivery demand, customer ordering behaviour, delivery performance, driver and vehicle utilization, and operational problems** using relational database analysis and SQL.

The analysis transforms raw operational data into meaningful business insights that can support **data-driven operational decision-making, resource allocation, capacity planning, and service improvement**.

## 🏢 Business Context

QuickRoute Logistics manages customer orders and last-mile deliveries across multiple delivery zones using a network of drivers and vehicles.

The Operations team wants to answer important business questions such as:

* Which delivery zones generate the highest demand?
* Which customers place the most orders?
* How does demand vary across service types and priorities?
* Which zones have poor delivery performance?
* Which drivers and vehicles handle the highest number of deliveries?
* How frequently do deliveries require multiple attempts?
* Are package weight and delivery duration related?
* Which areas require operational improvement?

## 🎯 Project Objectives

The project aims to:

1. Analyse overall delivery demand.
2. Understand customer ordering behaviour.
3. Evaluate delivery performance.
4. Analyse driver and vehicle utilization.
5. Identify delivery problems and operational inefficiencies.
6. Generate actionable business insights and recommendations.

## 🗄️ Database Structure

The project contains five relational tables:

* **customers** – Customer information and preferences
* **orders** – Customer orders and order details
* **deliveries** – Delivery attempts and delivery performance
* **drivers** – Driver information and ratings
* **vehicles** – Vehicle information and utilization details

### 🔗 Relationship Flow

```text
Customers
    │
    │ customer_id
    ▼
Orders
    │
    │ order_id
    ▼
Deliveries
   / \
  /   \
 ▼     ▼
Drivers Vehicles

### Primary Keys

| Table      | Primary Key |
| ---------- | ----------- |
| customers  | customer_id |
| orders     | order_id    |
| deliveries | delivery_id |
| drivers    | driver_id   |
| vehicles   | vehicle_id  |

### Foreign Keys

| Table      | Foreign Key | References            |
| ---------- | ----------- | --------------------- |
| orders     | customer_id | customers.customer_id |
| deliveries | order_id    | orders.order_id       |
| deliveries | driver_id   | drivers.driver_id     |
| deliveries | vehicle_id  | vehicles.vehicle_id   |

## 🛠️ Tools & Technologies

* **MySQL**
* **MySQL Workbench**
* **SQL**
* Relational Database Concepts
* ER Diagram Analysis
* Business Analytics

### SQL Concepts Used

* `SELECT`
* `WHERE`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `JOIN`
* `COUNT()`
* `SUM()`
* `AVG()`
* `ROUND()`
* `CASE`
* `DISTINCT`
* `UNION ALL`
* Date functions such as `YEAR()` and `MONTH()`
* Primary Keys
* Foreign Keys
* Aggregate Functions
* Conditional Aggregation

## 📊 Project Analysis

### 1. Delivery Demand Analysis

Analysed:

* Order volume by delivery zone
* Order volume by service type
* Order volume by priority
* Monthly and yearly demand trends
* Order value by delivery zone

### 2. Customer Behaviour Analysis

Analysed:

* Customers with the highest number of orders
* Customers with the highest cumulative order value
* Customer activity by delivery zone
* Business vs Individual customers
* Customer ordering patterns over time

### 3. Delivery Performance Analysis

Analysed:

* Delivery outcomes by zone
* Average delivery distance
* Average delivery duration
* Delivered, Failed, Pending, and Rescheduled deliveries
* Problem deliveries by zone
* Delivery performance trends over time

### 4. Driver & Vehicle Performance

Analysed:

* Deliveries handled by each driver
* Driver delivery outcomes
* Average delivery duration by driver
* Vehicle utilization
* Delivery performance by vehicle type

### 5. Delivery Problem Analysis

Analysed:

* Orders requiring multiple delivery attempts
* Common delivery problem statuses
* Delivery duration for single vs multiple attempts
* Problem deliveries by zone
* Relationship between package weight and delivery duration

## 📈 Key Findings

* The dataset contains **400 customers, 3,000 orders, 3,500 delivery records, 80 drivers, and 50 vehicles**.
* **ZONE0005** has the highest order volume with **240 orders**.
* **Standard** service has the highest order volume.
* **High-priority** orders represent the largest priority category with **1,035 orders**.
* Order demand increased from **608 orders in 2022 to 1,229 orders in 2024**.
* Individual customers contribute the highest overall ordering activity and order value.
* The highest-volume customer placed **19 orders**.
* **Delivered** is the dominant delivery outcome, with **2,581 delivered records**.
* **ZONE0020** shows comparatively weaker delivery performance and requires further investigation.
* **Express** service has the highest delivered percentage, while **Economy** has the highest failure percentage.
* **Cargo Bikes and Trucks** handle a large share of deliveries.
* **Motorbikes** have the shortest average delivery duration.
* **165 delivery records** required multiple attempts, representing approximately **4.71%** of delivery records.
* **ZONE0019** has the highest multiple-attempt delivery rate.
* Package weight does not appear to have a strong relationship with delivery duration in the current dataset.

## 💡 Business Insights

The analysis provides several important operational insights:

1. High-demand zones require sufficient driver and vehicle capacity.
2. ZONE0005 should be closely monitored because of its high order volume.
3. Increasing order demand indicates the need for future capacity planning.
4. High-frequency customers may represent important repeat business.
5. ZONE0020 requires investigation due to weaker delivery performance.
6. Economy service performance should be reviewed because of its higher failure rate.
7. Driver performance should be evaluated using delivery volume, success rate, duration, and rating together.
8. Vehicle allocation should consider delivery demand, distance, package requirements, and vehicle capabilities.
9. Multiple delivery attempts should be investigated to identify their underlying causes.
10. Zones with high Failed, Pending, and Rescheduled deliveries require additional operational attention.

## 🎯 Practical Recommendations

* Allocate additional resources to high-demand delivery zones.
* Closely monitor ZONE0005 for capacity planning.
* Investigate the causes of poor performance in ZONE0020.
* Review Economy service operations and failure causes.
* Monitor high-frequency and high-value customers.
* Balance driver workloads using multiple performance indicators.
* Optimize vehicle allocation based on operational requirements.
* Investigate repeated delivery attempts.
* Monitor failed, pending, and rescheduled deliveries regularly.
* Track delivery duration together with delivery outcomes.
* Monitor demand trends for future driver and vehicle planning.
* Use SQL-based operational analysis regularly for continuous improvement.

---

## 📂 Project Structure

```text
Last-Mile-Delivery-Operations-Analytics/
│
├── README.md
│
├── SQL/
│   └── quickroute_logistics_analysis.sql
│
├── Data/
│   ├── customers.csv
│   ├── orders.csv
│   ├── deliveries.csv
│   ├── drivers.csv
│   └── vehicles.csv
│
└── Documentation/
    └── Project_Documentation.pdf
```
Conclusion

This project demonstrates how **MySQL and SQL-based business analytics** can be used to analyse real-world-style last-mile delivery operations.

The analysis covers the complete workflow from **database creation and relational data modelling to SQL analysis, business insights, and operational recommendations**.

The findings can help QuickRoute Logistics improve **delivery planning, resource allocation, service performance, customer experience, and operational efficiency**.

Overall, the project demonstrates practical skills in **SQL, relational databases, data analysis, business thinking, and translating analytical results into actionable recommendations**.
