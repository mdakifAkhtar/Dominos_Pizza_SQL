
-- q1 Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.category,
    (SUM(order_details.quantity * pizzas.price) / (SELECT 
            SUM(pizzas.price * order_details.quantity) AS total_sales
        FROM
            order_details
                JOIN
            pizzas ON pizzas.pizza_id = order_details.pizza_id)) * 100 AS total_revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY total_revenue DESC;

-- q2 Analyze the cumulative revenue generated over time
select date,
round(sum(revenue) over(order by date),0) as cum_revenue from
(select orders.date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.date) as sales;

-- q3 Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name,category,revenue from
(select category,name,revenue,rank() 
over(partition by category order by revenue desc) as rnk 
from 
(select pizza_types.category,pizza_types.name,
round(sum(order_details.quantity * pizzas.price),0) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category,pizza_types.name) as a) as b
where rnk <=3;


