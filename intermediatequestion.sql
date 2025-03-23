-- q1 Join the necessary tables to find the total quantity of each pizza category ordered.
use dominos;
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-- q2 Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(time), COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(time)
ORDER BY order_count DESC; 

-- q3 Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    pizza_types.category, COUNT(pizza_types.name) AS pizza
FROM
    pizza_types
GROUP BY category;

-- q4 Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    orders.date, SUM(order_details.quantity) AS sum
FROM
    order_details
        JOIN
    orders ON orders.order_id = order_details.order_id
GROUP BY orders.date; -- sum per day order quantity

select round(avg(quantity),0) as avg_pizza_order from
(select orders.date,sum(order_details.quantity) as quantity from  
order_details join orders
on orders.order_id = order_details.order_id
group by orders.date) as order_quantity;   -- per day avg pizza order

-- q5 Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name,
    ROUND(SUM(pizzas.price * order_details.quantity),
            0) AS total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;




