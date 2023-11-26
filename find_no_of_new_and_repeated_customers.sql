-- find no of new and repeated customers
-- below is the dataset
SELECT * FROM customer_orders;
INSERT INTO customer_orders VALUES
(1, 100, CAST('2022-01-01' AS DATE), 2000),
(2, 200, CAST('2022-01-01' AS DATE), 2500),
(3, 300, CAST('2022-01-01' AS DATE), 2100),
(4, 100, CAST('2022-01-02' AS DATE), 2000),
(5, 400, CAST('2022-01-02' AS DATE), 2200),
(6, 500, CAST('2022-01-02' AS DATE), 2700),
(7, 100, CAST('2022-01-03' AS DATE), 3000),
(8, 400, CAST('2022-01-03' AS DATE), 1000),
(9, 600, CAST('2022-01-03' AS DATE), 3000);

-- Answer
with first_visit as (
select customer_id, min(order_date) as first_time_vist
from customer_orders
group by customer_id),
visit_table as (
select co.*, fv.first_time_vist,
		case when co.order_date = fv.first_time_vist then 1 else 0 end as first_time_visit,
		case when co.order_date != fv.first_time_vist then 1 else 0 end as repeat_time_visit
from customer_orders as co
inner join first_visit fv on co.customer_id = fv.customer_id)
select order_date, sum(first_time_visit) as no_of_new_visitors, sum(repeat_time_visit) as no_of_repeat_visitors from visit_table
group by order_date