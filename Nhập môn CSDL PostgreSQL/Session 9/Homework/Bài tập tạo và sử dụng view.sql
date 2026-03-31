create table sales (
    sale_id serial primary key,
    customer_id int,
    product_id int,
    sale_date date,
    amount numeric
);

insert into sales (customer_id, product_id, sale_date, amount) values
(1, 101, '2024-01-01', 200),
(1, 102, '2024-01-05', 300),
(2, 101, '2024-01-02', 500),
(2, 103, '2024-01-06', 700),
(3, 104, '2024-01-03', 150),
(3, 105, '2024-01-07', 200),
(4, 101, '2024-01-04', 800),
(4, 102, '2024-01-08', 300),
(5, 103, '2024-01-05', 1200),
(6, 104, '2024-01-06', 400),
(6, 105, '2024-01-09', 700),
(7, 101, '2024-01-07', 100),
(7, 102, '2024-01-10', 200),
(8, 103, '2024-01-08', 900),
(9, 104, '2024-01-09', 300),
(9, 105, '2024-01-11', 400),
(10, 101, '2024-01-10', 1500),
(2, 104, '2024-01-12', 300),
(3, 105, '2024-01-13', 250),
(5, 101, '2024-01-14', 800);



/*
1. Tạo View CustomerSales tổng hợp tổng amount theo từng customer_id
2. Viết truy vấn SELECT * FROM CustomerSales WHERE total_amount > 1000; để xem khách hàng mua nhiều
3. Thử cập nhật một bản ghi qua View và quan sát kết quả
*/

create view customersales as
select 
    customer_id,
    sum(amount) as total_amount
from sales
group by customer_id;


select *
from customersales
where total_amount > 1000;


update customersales
set total_amount = 2000
where customer_id = 1;

/*
Không update trực tiếp từ view này được bởi vì có mệnh đề group by và toán tử sum
*/