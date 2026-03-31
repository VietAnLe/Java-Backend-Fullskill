create table orders (
    order_id serial primary key,
    customer_id int,
    order_date date,
    total_amount numeric
);

-- AI generated data mẫu
insert into orders (customer_id, order_date, total_amount)
select 
    (random() * 100)::int,
    current_date - (random() * 365)::int,
    (random() * 5000000)::int
from generate_series(1, 10000);



explain analyze
select * 
from orders 
where customer_id = 10;
-- Thời gian execure khoảng 0.7ms và tổng thời gian query là khoảng 120ms

create index idx_orders_customer_id
on orders (customer_id);

explain analyze
select * 
from orders 
where customer_id = 10;
-- Thời gian execure khoảng 0.15ms và tổng thời gian query là khoảng 90ms