--- TASK3---
SELECT
	o.order_id,
    o.order_date,
    c.customer_id,
    CONCAT(	c.first_name," ",c.last_name) as customer_name,
    p.product_name,
    oi.quantity,
    oi.list_price,
    oi.discount,
    ROUND(oi.total_price,2) as total_price,
    o.order_status
FROM orders o 
INNER JOIN order_items oi ON o.order_id=oi.order_id
INNER JOIN products p ON p.product_id=oi.product_id
INNER JOIN customers c ON o.customer_id=c.customer_id
ORDER BY o.order_id
LIMIT 5000;

---- TASK4-----
SELECT 
	s.store_id,
    s.store_name,
    ROUND(SUM(oi.total_price),2) AS total_sales
FROM stores s
INNER JOIN orders o on s.store_id= o.store_id
INNER JOIN order_items oi on o.order_id= oi.order_id
GROUP BY s.store_id,s.store_name
ORDER BY total_sales DESC;

---- TASK5 ----

SELECT
	p.product_id,
    p.product_name,
	SUM(oi.quantity) AS total_qty
FROM order_items oi
INNER JOIN products p ON oi.product_id=p.product_id
GROUP BY p.product_id,p.product_name
ORDER BY total_qty DESC 
LIMIT 5;
    
---- TASK6 -----

SELECT
	c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) as total_orders,
    SUM(oi.quantity) as total_items,
    ROUND(SUM(oi.total_price),2) as total_revenue
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, customer_name
ORDER BY total_revenue DESC;

---- TASK7 ----
SELECT
	c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    COUNT(DISTINCT o.order_id) as total_orders,
    ROUND(SUM(oi.total_price),2) as total_revenue,
    CASE 
		WHEN SUM(oi.total_price) <10000 THEN 'LOW'
        WHEN SUM(oi.total_price) BETWEEN 10000 AND 20000 THEN 'MEDIUM'
        ELSE 'HIGH'
	END AS spending_brackets
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, customer_name;

--- Task8 ----

SELECT
	s.staff_id,
    CONCAT(s.first_name,' ',s.last_name) as staff_name,
    ROUND(SUM(oi.total_price),2) AS total_revenue
FROM order_items oi
INNER JOIN orders o ON oi.order_id= o.order_id
INNER JOIN staffs s ON s.staff_id= o.staff_id
GROUP BY s.staff_id, staff_name
ORDER BY total_revenue DESC;


--- TASK9----

SELECT 
    st.store_name,
    p.product_id,
    p.product_name,
    s.quantity AS stock_quantity
FROM stocks s
INNER JOIN stores st ON s.store_id = st.store_id
INNER JOIN products p ON s.product_id = p.product_id
WHERE s.quantity < 10
ORDER BY s.quantity ASC;

--- TASK10 --- 


USE bikestores;
CREATE TABLE customer_segment (
    customer_id INT PRIMARY KEY,
    Recency INT,
    Frequency INT,
    Monetary DOUBLE,
    Segment VARCHAR(20)
);

