create table customer (
    id serial primary key,
    name varchar(100)
);

create table orders (
    id serial primary key,
    customer_id int,
    order_date date,
    total_amount numeric(10,2)
);

insert into customer (id, name) values
(1, 'Nguyễn Văn A'),
(2, 'Trần Thị B'),
(3, 'Lê Văn C'),
(4, 'Phạm Minh D');

insert into orders (customer_id, order_date, total_amount) values
(1, '2023-01-01', 10000000),
(1, '2023-05-01', 15000000),
(2, '2023-03-10', 20000000),
(3, '2023-07-15', 5000000);

-- khách hàng + tổng tiền, sắp xếp giảm dần
select 
    c.name,
    sum(o.total_amount) as total_spent
from customer c
join orders o on c.id = o.customer_id
group by c.name
order by total_spent desc;

-- khách hàng có tổng chi tiêu cao nhất
select c.name
from customer c
join orders o on c.id = o.customer_id
group by c.id, c.name
having sum(o.total_amount) = (
    select max(total_spent)
    from (
        select sum(total_amount) as total_spent
        from orders
        group by customer_id
    ) t
);

-- khách hàng chưa từng mua hàng
select c.name
from customer c
left join orders o on c.id = o.customer_id
where o.id is null;

-- khách hàng có tổng chi tiêu > trung bình
select 
    c.name,
    sum(o.total_amount) as total_spent
from customer c
join orders o on c.id = o.customer_id
group by c.id, c.name
having sum(o.total_amount) > (
    select avg(total_spent)
    from (
        select sum(total_amount) as total_spent
        from orders
        group by customer_id
    ) t
);
