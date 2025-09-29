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

### Data Insertion
-- **Records inserted into Customers** 
**Query:**
```sql
INSERT INTO customers (customer_id, name, region) VALUES (10, 'Fabrice MUCYO', 'Kigali');
INSERT INTO customers (customer_id, name, region) VALUES (20, 'Emmanuel MUGISHA', 'Huye');
INSERT INTO customers (customer_id, name, region) VALUES (30, 'Frank HABIYUMVA', 'Kigali');
INSERT INTO customers (customer_id, name, region) VALUES (40, 'Fab NIYIGENA', 'Kigali');
INSERT INTO customers (customer_id, name, region) VALUES (50, 'Fiacre NTWALI', 'Gasabo');
INSERT INTO customers (customer_id, name, region) VALUES (60, 'Prince MUGISHA', 'Kicukiro');
INSERT INTO customers (customer_id, name, region) VALUES (70, 'Christian NSHUTI', 'Kicukiro');
INSERT INTO customers (customer_id, name, region) VALUES (80, 'Clement BAYINGANA', 'Nyamata');
INSERT INTO customers (customer_id, name, region) VALUES (90, 'Christian SHYAKA', 'Kicukiro');
INSERT INTO customers (customer_id, name, region) VALUES (100, 'Tomley MUGISHA', 'Kigali');

```
<p float='left'>
  <img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Sample%20customer.png" width=400>
  <img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Customers.png" width=400>
</p>

✔️ **Products**
``` sql
 CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR2(100),
    category VARCHAR2(50)
);
```
<img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Products.png" width= 650>

-- **Records Inserted into products**
``` sql
INSERT INTO products (product_id, name, category) VALUES (5, 'Coffee Beans', 'Beverages');
INSERT INTO products (product_id, name, category) VALUES (15, 'maize Flour', 'Food');
INSERT INTO products (product_id, name, category) VALUES (25, 'INYANGE Juices', 'Drinks');
INSERT INTO products (product_id, name, category) VALUES (35, 'Umukamira Milk', 'Drinks');
INSERT INTO products (product_id, name, category) VALUES (45, 'Coffee Beans', 'Beverages');
INSERT INTO products (product_id, name, category) VALUES (55, 'Fruits', 'Vegetables');
INSERT INTO products (product_id, name, category) VALUES (65, 'INYANGE Juices', 'Drinks');
INSERT INTO products (product_id, name, category) VALUES (75, 'Rice', 'Food');
INSERT INTO products (product_id, name, category) VALUES (85, 'Rice', 'Food');
INSERT INTO products (product_id, name, category) VALUES (95, 'Cassava Flour', 'Food');
```
<p float='left'>
  <img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Sample%20product.png" width=350>
  <img src='https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Products.png' width=350>
</p>

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

-- **Records inserted into Transactions**
```sql
-- Insert sample transactions
INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (1, 10, 5, TO_DATE('2024-01-01','YYYY-MM-DD') 25000);

INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (2, 20, 15, TO_DATE('2024-05-01','YYYY-MM-DD') 15000);

INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (3, 30, 25, TO_DATE('2024-08-01','YYYY-MM-DD') 20000);

INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (4, 40, 35, TO_DATE('2024-02-01','YYYY-MM-DD') 20000);

INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (5, 50, 45, TO_DATE('2024-03-01','YYYY-MM-DD') 25000);

INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (6, 60, 55, TO_DATE('2024-05-01','YYYY-MM-DD') 10000);

INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (7, 70, 65, TO_DATE('2024-05-01','YYYY-MM-DD') 10000);

INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (8, 80, 75, TO_DATE('2024-08-01','YYYY-MM-DD') 30000);

INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (9, 90, 85, TO_DATE('2024-11-01','YYYY-MM-DD') 30000);

INSERT INTO transactions (transaction_id, customers_id, products_id, sale_date, amount) 
VALUES (10, 100, 95, TO_DATE('2024-12-01','YYYY-MM-DD') 25000);

```
<p float='left'>
  <img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Sample%20transactions.png" width=350>
  <img src="https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/Transactions.png" width=350>
</p>


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

### Step 6: Results Analysis
 **1. Descriptive** – What happened?

In the ranking, Umukamira Milk and Inyange Juice came out on top in both Kigali. Other products like Fruits, coffee beans, maize flour, Rice and Cassava Flour but didn’t perform as strongly.

Looking at the running totals, sales went up steadily from January until December, where they never fell.

The month-over-month growth shows increases of +3k in March, +10k in May, and +10k in Dec, followed by a sharp drop of -5k in Feb, -15k in Aug and -5k in Dec.

From the quartile analysis, Christian SHYAKA (90) and Tomley MUGISHA (100) were the highest spenders, Fabrice MUCYO (10) was just below them, and Christian NSHUTI (70) spent the least.

The moving average confirmed that sales were gaining momentum from May to December, but March to January figures weakened the trend.

**2. Diagnostic** – Why did it happen?

> **Top products:** Umukamira Milk and Inyange Juice led sales in Kigali because of their popularity and likely higher demand compared to products like Fruits, Coffee Beans, Maize Flour, Rice, and Cassava Flour.

> **Stable running totals:** The steady rise in totals through the year suggests consistent customer purchasing behavior, with no major sales gaps month to month.

>**Growth fluctuations:** The growth increases in March, May, and December show promotional or seasonal demand spikes, while the drops in February, August, and December could point to stock shortages or reduced customer activity.

>**Customer spending patterns:** High spenders like Christian Shyaka and Tomley Mugisha are repeat buyers who drive much of the revenue, while Fabrice Mucyo and Christian Nshuti contribute less, showing a gap between top and low quartile customers.

>**Moving average trend:** The stronger averages from May to December indicate improved sales consistency, while earlier months (Jan–Mar) show weak performance likely tied to low customer activity or limited stock availability.

**3. Prescriptive** – What next?

>**Inventory focus:** Keep larger stocks of Umukamira Milk and Inyange Juice to sustain demand in Kigali, while improving marketing for weaker products like Fruits and Rice.

>**Growth stabilization:** Investigate the causes of sales drops in February, August, and December, and plan targeted promotions or stock adjustments during those months to avoid sharp declines.

>**Customer engagement:** Retain top spenders (Shyaka and Mugisha) through loyalty rewards, discounts, or exclusive offers, while encouraging low spenders (Mucyo and Nshuti) to purchase more often with bundles or price incentives.

>**Seasonal planning:** Use the sales boost patterns from March, May, and December as indicators for seasonal campaigns, aligning stock levels and promotions to maximize returns.

>**Balanced product strategy:** While milk and juice dominate, invest in awareness and offers for staple foods like maize flour and cassava flour to diversify revenue and reduce dependence on beverages.

### Step 7:
