create table customer (
	customer_id serial primary key,
	full_name varchar(100),
	region varchar(50)
);

create table orders (
	order_id serial primary key,
	customer_id int references customer(customer_id),
	total_amount decimal(10,2),
	order_date date,
	status varchar(20)
);

create table product (
	product_id serial primary key,
	name varchar(100),
	price decimal(10,2),
	category varchar(50)
);

create table order_details (
	order_id int references orders(order_id),
	product_id int references product(product_id),
	quantity int
);

INSERT INTO customer (full_name, region) VALUES
('Nguyen Van An', 'Ha Noi'),
('Tran Thi Bich', 'Ho Chi Minh'),
('Le Hoang Minh', 'Da Nang'),
('Pham Quang Huy', 'Ha Noi'),
('Do Thi Lan', 'Can Tho'),
('Hoang Tuan Kiet', 'Hai Phong'),
('Vo Ngoc Anh', 'Ho Chi Minh'),
('Bui Thanh Tung', 'Da Nang'),
('Dang Thi Mai', 'Ha Noi'),
('Phan Van Duc', 'Hue'),
('Nguyen Thi Hoa', 'Ha Noi'),
('Tran Van Nam', 'Ho Chi Minh'),
('Le Thi Hanh', 'Da Nang'),
('Pham Van Long', 'Can Tho'),
('Do Minh Tuan', 'Hai Phong'),
('Hoang Thi Yen', 'Hue'),
('Vo Van Phuc', 'Ha Noi'),
('Bui Thi Trang', 'Ho Chi Minh'),
('Dang Van Tai', 'Da Nang'),
('Phan Thi Thao', 'Can Tho');

INSERT INTO product (name, price, category) VALUES
('Laptop Dell', 20000000, 'Electronics'),
('iPhone 13', 18000000, 'Electronics'),
('Tai nghe Sony', 1500000, 'Electronics'),
('Chuột Logitech', 500000, 'Accessories'),
('Bàn phím cơ', 1200000, 'Accessories'),
('Áo thun nam', 300000, 'Fashion'),
('Quần jeans', 600000, 'Fashion'),
('Giày thể thao', 1200000, 'Fashion'),
('Balo du lịch', 800000, 'Travel'),
('Vali kéo', 1500000, 'Travel'),
('Sách SQL', 200000, 'Books'),
('Sách Python', 250000, 'Books'),
('Bình nước', 100000, 'Home'),
('Đèn bàn', 300000, 'Home'),
('Ghế văn phòng', 2000000, 'Furniture'),
('Bàn làm việc', 3500000, 'Furniture'),
('Máy xay sinh tố', 900000, 'Home'),
('Nồi cơm điện', 1200000, 'Home'),
('Camera an ninh', 2200000, 'Electronics'),
('Đồng hồ thông minh', 2500000, 'Electronics');

INSERT INTO orders (customer_id, total_amount, order_date, status) VALUES
(1, 2000000, '2024-01-05', 'completed'),
(2, 1500000, '2024-01-10', 'pending'),
(3, 900000, '2024-01-15', 'completed'),
(4, 2200000, '2024-02-01', 'cancelled'),
(5, 300000, '2024-02-05', 'completed'),
(6, 1800000, '2024-02-10', 'pending'),
(7, 400000, '2024-02-15', 'completed'),
(8, 750000, '2024-03-01', 'completed'),
(9, 1200000, '2024-03-05', 'pending'),
(10, 950000, '2024-03-10', 'completed'),
(11, 1300000, '2024-03-15', 'completed'),
(12, 2100000, '2024-04-01', 'pending'),
(13, 600000, '2024-04-05', 'completed'),
(14, 990000, '2024-04-10', 'completed'),
(15, 1400000, '2024-04-15', 'pending'),
(16, 1700000, '2024-05-01', 'completed'),
(17, 250000, '2024-05-05', 'cancelled'),
(18, 3000000, '2024-05-10', 'completed'),
(19, 850000, '2024-05-15', 'completed'),
(20, 1600000, '2024-06-01', 'pending');

INSERT INTO order_details (order_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 1),
(5, 5, 1),
(6, 6, 3),
(7, 7, 1),
(8, 8, 2),
(9, 9, 1),
(10, 10, 1),
(11, 11, 2),
(12, 12, 1),
(13, 13, 3),
(14, 14, 1),
(15, 15, 1),
(16, 16, 1),
(17, 17, 2),
(18, 18, 1),
(19, 19, 1),
(20, 20, 1);



/*
1. Tạo View tổng hợp doanh thu theo khu vực:
- Viết truy vấn xem top 3 khu vực có doanh thu cao nhất

2. Tạo View chi tiết đơn hàng có thể cập nhật được:
   a. Cập nhật status của đơn hàng thông qua View này
   b. Kiểm tra hành vi khi vi phạm điều kiện WITH CHECK OPTION

3. Tạo View phức hợp (Nested View):
- Từ v_revenue_by_region, tạo View mới v_revenue_above_avg chỉ hiển thị khu vực có doanh thu > trung bình toàn quốc
*/

create view v_revenue_by_region as
select 
    c.region, 
    sum(o.total_amount) as total_revenue
from customer c
join orders o on c.customer_id = o.customer_id
group by c.region;

select *
from v_revenue_by_region
order by total_revenue desc
limit 3;



create materialized view mv_monthly_sales as
select 
    date_trunc('month', order_date) as month,
    sum(total_amount) as monthly_revenue
from orders
group by date_trunc('month', order_date);

create view v_order_pending as  -- Tạo 1 view bên ngoài để có thể update status
select *
from orders
where status = 'pending'
with check option;

update v_order_pending
set status = 'completed'
where order_id = 2;

refresh materialized view mv_monthly_sales;

select * from mv_monthly_sales;



create view v_revenue_above_avg as
select *
from v_revenue_by_region
where total_revenue > (
    select avg(total_revenue)
    from v_revenue_by_region
);

select * from v_revenue_above_avg;
