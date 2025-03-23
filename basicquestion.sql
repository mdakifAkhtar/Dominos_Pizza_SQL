-- q1 Retrive the total number of order place
-- select count(order_id) as Total_orders from orders;

-- q2 calculate the total revenue generate from pizza sales
 /*SELECT 
ROUND(SUM(order_details.quantity * pizzas.price),2) AS Total_Sales
FROM order_details JOIN
pizzas ON pizzas.pizza_id = order_details.pizza_id;*/

-- q3Identify the highest-priced pizza.
-- select max(price) from pizzas;  only max price batyega name nhi
/*select pizza_types.name, pizzas.price from
pizza_types join pizzas
on pizza_types.pizza_type_id =pizzas.pizza_type_id
order by pizzas.price desc limit 1;*/

-- q4Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(DISTINCT order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
LIMIT 3;

-- List the top 5 most ordered pizza types along with their quantities.
/*select pizza_types.name,
sum(order_details.quantity) as quantity from
pizza_types join pizzas
on pizza_types.pizza_type_id =pizzas.pizza_type_id
join order_details
on order_details.pizza_id =pizzas.pizza_id
group by pizza_types.name 
order by quantity desc limit 5;*/
