create table orderinfo (
    id serial primary key,
    customer_id int,
    order_date date,
    total numeric(10,2),
    status varchar(20)
);

-- thêm 5 đơn hàng
insert into orderinfo (customer_id, order_date, total, status) values
(1, '2024-10-01', 600000, 'Completed'),
(2, '2024-10-05', 450000, 'Pending'),
(3, '2024-09-20', 800000, 'Completed'),
(4, '2024-10-10', 1200000, 'Processing'),
(5, '2024-08-15', 300000, 'Cancelled');

-- đơn hàng total > 500000
select *
from orderinfo
where total > 500000;

-- đơn hàng trong tháng 10/2024
select *
from orderinfo
where order_date between '2024-10-01' and '2024-10-31';

-- đơn hàng trạng thái khác 'Completed'
select *
from orderinfo
where status <> 'Completed';

-- 2 đơn hàng mới nhất
select *
from orderinfo
order by order_date desc limit 2;
