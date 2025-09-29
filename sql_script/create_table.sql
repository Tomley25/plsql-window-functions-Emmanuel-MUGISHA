CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR2(100),
    region VARCHAR2(50)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR2(100),
    category VARCHAR2(50)
);
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    sale_date DATE,
    amount NUMBER(10,2)
);