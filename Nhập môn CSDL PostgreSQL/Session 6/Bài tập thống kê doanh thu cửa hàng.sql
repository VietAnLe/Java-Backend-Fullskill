create table orders (
    id serial primary key,
    customer_id int,
    order_date date,
    total_amount numeric(10,2)
);

insert into orders (customer_id, order_date, total_amount) values
(1, '2022-03-10', 10000000),
(2, '2022-07-15', 20000000),
(3, '2023-01-20', 15000000),
(1, '2023-05-05', 25000000),
(2, '2023-10-12', 30000000),
(3, '2024-02-18', 12000000),
(1, '2024-06-25', 18000000);

-- tổng doanh thu, số đơn, trung bình
select 
    sum(total_amount) as total_revenue,
    count(id) as total_orders,
    avg(total_amount) as average_order_value
from orders;

-- doanh thu theo năm
select 
    extract(year from order_date) as year,
    sum(total_amount) as total_revenue
from orders
group by extract(year from order_date);

-- chỉ năm có doanh thu > 50000000
select 
	extract(year from order_date) as year,
	sum(total_amount) as total_revenue
from orders
group by extract(year from order_date)
having sum(total_amount) > 50000000;

-- 5 đơn hàng giá trị cao nhất
select *
from orders
order by total_amount desc limit 5;
