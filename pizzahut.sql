create database pizzahut;
use pizzahut;
create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id));


create table orders_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (order_details_id));
select * from pizzas;
select*from pizza_types;
select*from orders_details;
select * from orders;

-- basic Questions 
-- Retrive the total number of orders placed
select count(order_id) as total_orders from orders;
-- Calculate the total revenue generated from pizza sales
SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id;
    
-- identify the higgest priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered. no ss
SELECT 
    pizzas.size,
    COUNT(orders_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

--  5 list the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- intermediate question
-- 6 Join the necessary tables to find the total quantity of each pizza category ordered
SELECT 
    pizza_types.category,
    SUM(orders_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.Pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- 7 Determine the distribution of orders by hour of the day
SELECT 
    HOUR(order_time), COUNT(order_id) AS order_count
FROM
    orders
GROUP BY (order_time);

-- 8 join relevent tables to find the category Wize distribution of pizzas.
SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- 9 Group the orders by date and calculate the avg number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) as avg_pizza
FROM
    (SELECT 
        orders.order_date, SUM(orders_details.quantity) AS quantity
    FROM
        orders
    JOIN orders_details ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
    
    -- 10. Determine the top 3 most ordered pizza types based on revenue.
    SELECT 
    pizza_types.name,
    SUM(orders_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;




-- Advanced question
-- calculate the percentage contribution of each pizza type of total revenue.
use pizzahut;
SELECT 
    pizza_types.category,
    (SUM(orders_details.quantity * pizzas.price) /(SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id))* 100 as revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;

-- Analyze the cumulative revenue generated over time (left)
SELECT 
    sales.order_date,
    SUM(sales.revenue) OVER (ORDER BY sales.order_date) AS cum_revenue
FROM (
    SELECT 
        orders.order_date,
        SUM(orders_details.quantity * pizzas.price) AS revenue
    FROM orders_details
    JOIN pizzas 
        ON orders_details.pizza_id = pizzas.pizza_id
    JOIN orders 
        ON orders.order_id = orders_details.order_id
    GROUP BY orders.order_date
) AS sales;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category
select name,revenue from (select category,name,revenue,rank() over(partition by category order by revenue  desc) as rn 
from
    (select pizza_types.category,pizza_types.name,
           sum((orders_details.quantity)*pizzas.price)as revenue
from 
     Pizza_types 
     join 
     pizzas
     on pizza_types.pizza_type_id = pizzas.pizza_type_id 
 join
 orders_details
 on  orders_details.pizza_id=pizzas.pizza_id
 group by pizza_types.category,pizza_types.name)as a) as b
 where rn<=3;





 