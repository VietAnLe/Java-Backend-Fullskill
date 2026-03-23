create table customers (
	customer_id serial primary key,
	customer_name varchar(50) not null,
	city varchar(50) not null
);

create table orders (
	order_id int primary key,
	customer_id int not null references customers(customer_id),
	order_date date,
	total_price numeric(10,2) not null
);

create table order_items (
	item_id serial primary key,
	order_id int not null references orders(order_id),
	product_id int not null,
	quantity int not null,
	price numeric(10,2) not null
);



insert into customers (customer_id, customer_name, city)
values (1, 'Nguyễn Văn A', 'Hà Nội'), (2, 'Trần Thị B', 'Đà Nẵng'), (3, 'Lê Văn C', 'Hồ Chí Minh'), (4, 'Phạm Thị D', 'Hà Nội');

insert into orders (order_id, customer_id, order_date, total_price)
values (101, 1, '2024-12-20', 3000), (102, 2, '2025-01-05', 1500), (103, 1, '2025-02-10', 2500), (104, 3, '2025-02-15', 4000), (105, 4, '2025-03-01', 800);

insert into order_items (order_id, product_id, quantity, price) 
values (101, 1, 2, 1500), (102, 2, 1, 1500), (103, 3, 5, 500), (104, 2, 4, 1000);



-- Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng
select c.customer_name, sum(o.total_price) as total_revenue, count(distinct o.order_id) as order_count
from customers c 
	 join orders o on c.customer_id = o.customer_id
	 join order_items oi on o.order_id = oi.order_id
group by c.customer_name
having sum(o.total_price) > 2000;



-- Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng
select *
from (
    select c.customer_id, c.customer_name, sum(o.total_price) as total_revenue
    from customers c
	    join orders o on c.customer_id = o.customer_id
	    join order_items oi on o.order_id = oi.order_id
    group by c.customer_id, c.customer_name
) t
where total_revenue > (
    select avg(total_revenue)
    from (
        select sum(o.total_price) as total_revenue
        from customers c
	        join orders o on c.customer_id = o.customer_id
	        join order_items oi on o.order_id = oi.order_id
        group by c.customer_id
    ) x
);



-- Dùng HAVING + GROUP BY để lọc ra thành phố có tổng doanh thu cao nhất
select c.city, sum(oi.quantity * oi.price) as total_revenue
from customers c
	join orders o on c.customer_id = o.customer_id
	join order_items oi on o.order_id = oi.order_id
group by c.city
having sum(o.total_price) = (
    select max(total_revenue)
    from (
        select sum(o.total_price) as total_revenue
        from customers c
	        join orders o on c.customer_id = o.customer_id
	        join order_items oi on o.order_id = oi.order_id
        group by c.city
    ) t
);



-- (Mở rộng) Hãy dùng INNER JOIN giữa customers, orders, order_items để hiển thị chi tiết: Tên khách hàng, tên thành phố, tổng sản phẩm đã mua, tổng chi tiêu
select c.customer_name, c.city, sum(oi.quantity) as total_products, sum(o.total_price) as total_spent
from customers c
	join orders o on c.customer_id = o.customer_id
	join order_items oi on o.order_id = oi.order_id
group by c.customer_name, c.city;
