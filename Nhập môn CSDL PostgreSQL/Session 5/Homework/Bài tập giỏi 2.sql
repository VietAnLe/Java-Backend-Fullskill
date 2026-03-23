create table customers (
    customer_id serial primary key,
    customer_name varchar(100) not null,
    city varchar(50) not null
);

create table orders (
    order_id serial primary key,
    customer_id int not null references customers(customer_id),
    order_date date not null,
    total_amount numeric(10,2) not null
);

create table order_items (
    item_id serial primary key,
    order_id int not null references orders(order_id),
    product_name varchar(100) not null,
    quantity int not null,
    price numeric(10,2) not null
);



insert into customers (customer_id, customer_name, city) 
values (1, 'Nguyễn Văn A', 'Hà Nội'), (2, 'Trần Thị B', 'Hồ Chí Minh'), (3, 'Lê Văn C', 'Đà Nẵng');

insert into orders (order_id, customer_id, order_date, total_amount) 
values (101, 1, '2024-01-01', 2200), (102, 1, '2024-01-05', 1500), (103, 2, '2024-01-03', 3300), (104, 3, '2024-01-07', 1000);

insert into order_items (order_id, product_name, quantity, price) 
values (101, 'Laptop Dell', 1, 2000),
	   (101, 'Chuột Logitech', 2, 100),
	   (102, 'Bàn phím Razer', 1, 1500),
	   (103, 'iPhone 15', 1, 3300),
	   (104, 'Tai nghe Sony', 2, 500);



select c.customer_name as customer_name, o.order_date as order_date, o.total_amount as total_amount
from customers c join orders o on c.customer_id = o.customer_id;



select 
    sum(total_amount) as total_revenue,
    avg(total_amount) as avg_order,
    max(total_amount) as max_order,
    min(total_amount) as min_order,
    count(order_id) as order_count
from orders;



select c.city, sum(o.total_amount) as total_revenue
from customers c join orders o on c.customer_id = o.customer_id
group by c.city
having sum(o.total_amount) > 10000;



select 
    c.customer_name,
    o.order_date,
    oi.product_name,
    oi.quantity,
    oi.price
from customers c join orders o on c.customer_id = o.customer_id
	 join order_items oi on o.order_id = oi.order_id;



select c.customer_name
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having sum(o.total_amount) = (
    select max(total_spent)
    from (
        select sum(total_amount) as total_spent
        from orders
        group by customer_id
    ) t
);



select city from customers
union
select c.city
from customers c join orders o on c.customer_id = o.customer_id;



select city from customers
intersect
select c.city
from customers c join orders o on c.customer_id = o.customer_id;
