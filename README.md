# 📊 PL/SQL Window Functions 

### Student: Emmanuel MUGISHA  
### Course: Database Development with PL/SQL (INSY 8311)  
### Instructor: Eric Maniraguha  
### Submission Date: 29 September 2025 

---

## 📌 Problem Definition
**Business Context:**  
A retail company in Rwanda that sells food and beverages wants to track its customers and product performance.  

**Data Challenge:**  
The management struggles to identify top products per region, analyze monthly sales, and segment customers for promotions.  

**Expected Outcome:**  
Provide insights into best-selling products, monthly growth patterns, and customer segmentation using PL/SQL window functions.  

---

## 🎯 Success Criteria
1. Identify **Top 5 products per region/quarter** → `RANK()`  
2. Calculate **Running monthly sales totals** → `SUM() OVER()`  
3. Analyze **Month-over-month growth** → `LAG()` / `LEAD()`  
4. Segment customers into **Quartiles** → `NTILE(4)`  
5. Compute **3-month moving averages** → `AVG() OVER()`  

---

## 🗄️ Database Schema

**Tables:**  
- `customers` → Customer info  
- `products` → Product catalog  
- `transactions` → Sales records  

**ER Diagram:** 
![ER Diagram](https://github.com/Tomley25/plsql-window-functions-Emmanuel-MUGISHA/blob/main/Screenshot/ER%20Diagram.jpg) 

---

## 🧑‍💻 Window Functions Implementation  

### 1️⃣ Ranking – Top Products per Region
```sql
SELECT c.region, p.name AS product_name,
       SUM(t.amount) AS total_sales,
       RANK() OVER(PARTITION BY c.region ORDER BY SUM(t.amount) DESC) AS rank_in_region
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
JOIN products p ON t.product_id = p.product_id
GROUP BY c.region, p.name;
![Top Products oer Region]()
