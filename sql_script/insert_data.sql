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


-- Insert sample products

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


COMMIT;