create table customers (
	customer_id serial primary key,
	full_name varchar(100),
	email varchar(100),
    phone varchar(50)
); 

create table orders (
	order_id serial primary key,
	customer_id int references customers(customer_id),
	total_amount decimal(10,2),
    order_date date
);

INSERT INTO customers (full_name, email, phone) VALUES
('Nguyen Van An', 'an.nguyen@gmail.com', '0901234567'),
('Tran Thi Bich', 'bich.tran@gmail.com', '0912345678'),
('Le Hoang Minh', 'minh.le@gmail.com', '0987654321'),
('Pham Quang Huy', 'huy.pham@gmail.com', '0971122334'),
('Do Thi Lan', 'lan.do@gmail.com', '0962233445'),
('Hoang Tuan Kiet', 'kiet.hoang@gmail.com', '0953344556'),
('Vo Ngoc Anh', 'anh.vo@gmail.com', '0944455667'),
('Bui Thanh Tung', 'tung.bui@gmail.com', '0935566778'),
('Dang Thi Mai', 'mai.dang@gmail.com', '0926677889'),
('Phan Van Duc', 'duc.phan@gmail.com', '0917788990'),
('Nguyen Thi Hoa', 'hoa.nguyen@gmail.com', '0901112233'),
('Tran Van Nam', 'nam.tran@gmail.com', '0912223344'),
('Le Thi Hanh', 'hanh.le@gmail.com', '0923334455'),
('Pham Van Long', 'long.pham@gmail.com', '0934445566'),
('Do Minh Tuan', 'tuan.do@gmail.com', '0945556677'),
('Hoang Thi Yen', 'yen.hoang@gmail.com', '0956667788'),
('Vo Van Phuc', 'phuc.vo@gmail.com', '0967778899'),
('Bui Thi Trang', 'trang.bui@gmail.com', '0978889900'),
('Dang Van Tai', 'tai.dang@gmail.com', '0989990011'),
('Phan Thi Thao', 'thao.phan@gmail.com', '0990001122');

INSERT INTO orders (customer_id, total_amount, order_date) VALUES
(1, 250000, '2024-01-05'),
(2, 1200000, '2024-01-10'),
(3, 980000, '2024-01-15'),
(4, 2000000, '2024-02-01'),
(5, 300000, '2024-02-05'),
(6, 1750000, '2024-02-10'),
(7, 450000, '2024-02-15'),
(8, 800000, '2024-03-01'),
(9, 1100000, '2024-03-05'),
(10, 950000, '2024-03-10'),
(11, 1300000, '2024-03-15'),
(12, 2100000, '2024-04-01'),
(13, 670000, '2024-04-05'),
(14, 990000, '2024-04-10'),
(15, 1230000, '2024-04-15'),
(16, 1750000, '2024-05-01'),
(17, 200000, '2024-05-05'),
(18, 3000000, '2024-05-10'),
(19, 850000, '2024-05-15'),
(20, 1450000, '2024-06-01'),
(1, 2200000, '2024-06-05'),
(2, 400000, '2024-06-10'),
(3, 1600000, '2024-06-15'),
(4, 500000, '2024-06-20'),
(5, 2700000, '2024-07-01');

select * from customers;
select * from orders;



/*
1. Tạo một View tên v_order_summary hiển thị:
- full_name, total_amount, order_date
- (ẩn thông tin email và phone)
2. Viết truy vấn để xem tất cả dữ liệu từ View
3. Tạo 1 view lấy về thông tin của tất cả các đơn hàng với điều kiện total_amount ≥ 1 triệu. Sau đó bạn hãy cập nhật lại thông tin 1 bản ghi trong view đó nhé.
4. Tạo một View thứ hai v_monthly_sales thống kê tổng doanh thu mỗi tháng
5. Thử DROP View và ghi chú sự khác biệt giữa DROP VIEW và DROP MATERIALIZED VIEW trong PostgreSQL8
*/

create view v_order_summary as
select 
    c.full_name,
    o.total_amount,
    o.order_date
from orders o join customers c on o.customer_id = c.customer_id;



select * from v_order_summary;



create view v_high_value_orders as
select * from orders
where total_amount >= 1000000;

select * from v_high_value_orders;

update v_high_value_orders
set total_amount = 1500000
where order_id = 1;



create view v_monthly_sales as
select 
    date_trunc('month', order_date) as month,
    sum(total_amount) as total_revenue
from orders
group by date_trunc('month', order_date)
order by month;

select * from v_monthly_sales;



drop view v_order_summary;

create materialized view mv_monthly_sales as
select 
    date_trunc('month', order_date) as month,
    sum(total_amount) as total_revenue
from orders
group by date_trunc('month', order_date);

refresh materialized view mv_monthly_sales;

select * from mv_monthly_sales;

drop materialized view mv_monthly_sales;
