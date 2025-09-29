#  PL/SQL Window Functions 

### Student: Emmanuel MUGISHA  
### Course: Database Development with PL/SQL (INSY 8311)  
### Instructor: Eric Maniraguha  
### Submission Date: 29 September 2025 

---

##  Problem Definition
**Business Context:**  
A retail company in Rwanda that sells food and beverages wants to track its customers and product performance.  

**Data Challenge:**  
The management struggles to identify top products per region, analyze monthly sales, and segment customers for promotions.  

**Expected Outcome:**  
Provide insights into best-selling products, monthly growth patterns, and customer segmentation using PL/SQL window functions.  

---

## Step 2: Success Criteria

To measure the success of this analysis, I defined five clear, testable goals using PL/SQL window functions:

1. **Top 5 Products per Region / Quarter → RANK()**

Goal: Identify the highest-selling products in each region.

How we met it: Coffee Beans consistently ranked #1 in Kigali and Huye (see Ranking query + screenshot).


2. **Running Monthly Sales Totals → SUM() OVER()**

Goal: Track cumulative sales growth over time.

How we met it: Sales climbed steadily from Jan → Apr, reaching 92,000 cumulative by April.


3. **Month-over-Month Growth → LAG() / LEAD()**

Goal: Measure growth or decline in sales compared to the previous month.

How we met it: Feb (+5k), Mar (+7k), Apr (+10k) all showed growth, while May (-22k) showed decline.


4. **Customer Quartiles → NTILE(4)**

Goal: Segment customers into 4 categories based on spending power.

How we met it: Alice (1002) and Grace (1004) landed in Quartile 1 (high spenders), while Peter (1003) landed in Quartile 3.


5. **3-Month Moving Averages → AVG() OVER()**

Goal: Smooth out sales fluctuations to reveal trends.

How we met it: The rolling average showed strong momentum until April, then signaled a slowdown in May.

---

## Step 3: Database Schema

**Tables:**  
- `customers` → Customer info  
- `products` → Product catalog  
- `transactions` → Sales records
✔️ **Customers**
``` sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR2(100),
    region VARCHAR2(50)
);
```
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Customers.png" width= 600>

✔️ **Products**
``` sql
 CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR2(100),
    category VARCHAR2(50)
);
```
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Products.png" width= 650>

✔️ **Transactions**
```sql
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customers_id INT REFERENCES customers(customer_id),
    products_id INT REFERENCES products(product_id),
    sale_date DATE,
    amount NUMBER(10,2)
);
```
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Transactions.png" width= 650>

**ER Diagram:** 

An Entity-Relationship (ER) diagram is a visual representation of how entities (things, concepts, or objects) relate to one another within a system. It is a high-level data model that acts as a blueprint for designing or analyzing relational databases, outlining the logical structure before development begins. 
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/ER%20Diagram.png" width= 650> 

---

## Step 4:  Window Functions Implementation  

### 1️⃣ Ranking – Top Products per Region
```sql
SELECT c.region, p.name AS product_name,
       SUM(t.amount) AS total_sales,
       RANK() OVER(PARTITION BY c.region ORDER BY SUM(t.amount) DESC) AS rank_in_region
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN products p ON t.product_id = p.product_id
GROUP BY c.region, p.name;
```
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Rank%20In%20Region%20data.png" width= 650>

### 2️⃣ Percentage Rank
```sql
SELECT customer_id, SUM(amount) AS total_spent,
       PERCENT_RANK() OVER(ORDER BY SUM(amount) DESC) AS percent_rank
FROM transactions
GROUP BY customer_id;
```
<img src ="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/percentage%20rank.jpg" width= 650>


### 3️⃣ Aggregate – Running Totals
``` sql
SELECT TO_CHAR(sale_date, 'YYYY-MM') AS month,
       SUM(amount) AS monthly_sales,
       SUM(SUM(amount)) OVER(ORDER BY TO_CHAR(sale_date, 'YYYY-MM')) AS running_total
FROM transactions
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY month;
```
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Moving%20avg%20sql.png" width=650>

**Aggregate data**
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Moving%20avg%20data.png" width= 650>

### 4️⃣ Navigation – Month-over-Month Growth
``` sql
SELECT TO_CHAR(sale_date, 'YYYY-MM') AS month,
       SUM(amount) AS monthly_sales,
       LAG(SUM(amount)) OVER(ORDER BY TO_CHAR(sale_date, 'YYYY-MM')) AS prev_month,
       (SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY TO_CHAR(sale_date, 'YYYY-MM'))) AS growth
FROM transactions
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY month;
```
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Growth%20Data.png" width= 650>

### 6️⃣ Distribution – Customer Quartiles
``` sql
SELECT customer_id, SUM(amount) AS total_spent,
       NTILE(4) OVER(ORDER BY SUM(amount) DESC) AS quartile
FROM transactions
GROUP BY customer_id;
```
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Quartile%20sql.png" width= 650>

**Quartile data**
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Quartile%20data.png" width= 650>
