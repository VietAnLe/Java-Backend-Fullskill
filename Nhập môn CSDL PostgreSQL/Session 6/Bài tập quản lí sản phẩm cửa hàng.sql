create table product (
    id serial primary key,
    name varchar(100) not null,
    category varchar(50) not null,
    price numeric(10,2) not null,
    stock int not null
);

-- thêm 5 sản phẩm
insert into product (name, category, price, stock) values
('Laptop Dell', 'Điện tử', 15000000, 5),
('Chuột Logitech', 'Phụ kiện', 300000, 50),
('Bàn phím cơ Razer', 'Phụ kiện', 2000000, 20),
('Tivi Samsung', 'Điện tử', 9000000, 10),
('Tai nghe Sony', 'Điện tử', 1500000, 15);

-- hiển thị toàn bộ sản phẩm
select *
from product;

-- hiển thị 3 sản phẩm giá cao nhất
select *
from product
order by price desc limit 3;

-- sản phẩm điện tử giá < 10000000
select *
from product
where category = 'Điện tử' and price < 10000000;

-- sắp xếp theo stock tăng dần
select *
from product
order by stock asc;
