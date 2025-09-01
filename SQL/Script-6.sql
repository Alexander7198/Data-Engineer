select * from orders o 
join people p 
on o.region = p.region
join "returns" r
on o.order_id  = r.order_id
limit 100

select * from people p 

select * from "returns" r 


select sum(sales) from orders o 
limit 100


select sum(profit) from orders o 
limit 100


select sum(profit / sales) * 100 from orders o 
limit 100


Profit per Order 

SELECT 
    order_ID,
    SUM(profit) AS Total_Profit_Per_Order,
    COUNT(*) AS Items_In_Order -- Опционально: количество товаров в заказе
FROM orders o 
GROUP BY order_id;

-- Sales per Customer (Продажи на клиента)

SELECT 
    o.customer_id ,
    o.customer_name ,
    SUM(sales) AS Total_Sales_Per_Customer
FROM orders o
GROUP BY customer_id, customer_name
ORDER BY Total_Sales_Per_Customer DESC;

-- Среднее по количеству заказов
select
	customer_id,
	round(AVG(o.discount),2)
from orders o 
group by customer_id

-- Monthly Sales by Segment (Ежемесячные продажи по сегментам).

SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS Year_Month,
    TO_CHAR(order_date, 'Month YYYY') AS Month_Name,
    Segment,
    ROUND(SUM(sales), 2) AS Total_Sales,
    COUNT(DISTINCT order_id) AS Number_of_Orders,
    COUNT(DISTINCT customer_id) AS Unique_Customers
FROM orders 
GROUP BY 
    TO_CHAR(order_date, 'YYYY-MM'),
    TO_CHAR(order_date, 'Month YYYY'),
    Segment
ORDER BY 
    Year_Month, 
    Segment;



-- Monthly Sales by Product Category (Ежемесячные продажи по категориям товаров)


SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS Year_Month,
    TO_CHAR(order_date, 'Month YYYY') AS Month_Name,
    Category,
    ROUND(SUM(sales), 2) AS Total_Sales,
    COUNT(DISTINCT order_id) AS Number_of_Orders,
    SUM(quantity) AS Total_Quantity_Sold,
    COUNT(DISTINCT product_ID) AS Unique_Products
FROM orders o 
GROUP BY 
    TO_CHAR(order_date, 'YYYY-MM'),
    TO_CHAR(order_date, 'Month YYYY'),
    Category
ORDER BY 
    Year_Month, 
    Total_Sales DESC;

--Sales by Product Category over time (Продажи по категориям товаров в динамике).

SELECT 
    EXTRACT(YEAR FROM order_date) AS Year,
    EXTRACT(MONTH FROM order_date) AS Month,
    Category,
    ROUND(SUM(sales), 2) AS Total_Sales,
    SUM(quantity) AS Total_Quantity_Sold,
    COUNT(DISTINCT order_id) AS Number_of_Orders
FROM orders 
GROUP BY 
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date),
    Category
ORDER BY 
    Year, 
    Month, 
    Category;


--Sales per region (Продажи по регионам)

select
	TO_CHAR(order_date, 'YYYY-MM') AS Year_Month,
	TO_CHAR(order_date, 'Month YYYY') AS Month_Name,
	sum(sales),
	o.region
from orders o 
join people p 
on o.region = p.region
group by
	o.region,
	TO_CHAR(order_date, 'YYYY-MM'),
	TO_CHAR(order_date, 'Month YYYY')
ORDER BY 
    Year_Month, 
    Month_Name DESC
