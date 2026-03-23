create table products (
	product_id serial primary key,
	product_name varchar(50) not null,
	category varchar(50) not null
);

create table orders (
	order_id bigserial primary key,
	product_id int not null references products(product_id),
	quantity int,
	total_price numeric(10,2)
);

alter sequence orders_order_id_seq restart with 101; -- Câu lệnh để cho bigserial chạy bắt đầu từ 101 để phù hợp với đề bài; vì kiểu dữ liệu này là 1 dạng sequences nên dùng alter sequence


insert into products (product_name, category)
values ('Laptop Dell', 'Electronics'), ('IPhone 15', 'Electronics'), ('Bàn học gỗ', 'Furniture'), ('Ghế xoay', 'Furniture');

insert into orders (product_id, quantity, total_price)
values (1, 2, 2200), (2, 3, 3300), (3, 5, 2500), (4, 4, 1600), (1, 1, 1100);

select * from products;
select * from orders;



-- Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)
select category, sum(o.quantity) as "total_quantity", sum(o.total_price) as "total_sales"
from products p join orders o on p.product_id = o.product_id
group by category;

-- Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
select category, sum(o.quantity) as "total_quantity", sum(o.total_price) as "total_sales"
from products p join orders o on p.product_id = o.product_id
group by category
having sum(o.total_price) > 2000;

-- Sắp xếp kết quả theo tổng doanh thu giảm dần
select category, sum(o.quantity) as "total_quantity", sum(o.total_price) as "total_sales"
from products p join orders o on p.product_id = o.product_id
group by category
order by sum(o.total_price) desc;
