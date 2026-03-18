create table products (
    id serial primary key,
    name varchar(100),
    category varchar(50),
    price int,
    stock int,
    manufacturer varchar(50)
);

insert into products (name, category, price, stock, manufacturer) values
('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
('Chuột Logitech M90', 'Phụ kiện', 150000, 50, 'Logitech'),
('Bàn phím cơ Razer', 'Phụ kiện', 2200000, 0, 'Razer'),
('Macbook Air M2', 'Laptop', 32000000, 7, 'Apple'),
('iPhone 14 Pro Max', 'Điện thoại', 35000000, 15, 'Apple'),
('Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
('Tai nghe AirPods 3', 'Phụ kiện', 4500000, null, 'Apple');



-- Chèn dữ liệu mới: thêm sản phẩm “Chuột không dây Logitech M170”
insert into products (name, category, price, stock, manufacturer)
values ('Chuột không dây Logitech M170', 'Phụ kiện', 300000, 20, 'Logitech');

-- Cập nhật dữ liệu: tăng giá tất cả sản phẩm của apple thêm 10%
update products
set price = price * 1.10
where manufacturer = 'Apple';

-- Xóa dữ liệu: xóa sản phẩm có stock = 0
delete from products
where stock = 0;

-- Lọc theo điều kiện: sản phẩm có price between 1000000 and 30000000
select *
from products
where price between 1000000 and 30000000;

-- Lọc giá trị null: sản phẩm có stock is null
select *
from products
where stock is null;

-- Loại bỏ trùng: danh sách hãng sản xuất duy nhất
select distinct manufacturer
from products;

-- Sắp xếp dữ liệu: giảm dần theo giá, sau đó tăng dần theo tên
select *
from products
order by price desc, name asc;

-- Tìm kiếm: tên chứa “laptop” (không phân biệt hoa thường)
select *
from products
where name ilike '%laptop%';

-- Giới hạn kết quả: 2 sản phẩm đầu tiên sau khi sắp xếp
select *
from products
order by price desc, name asc
limit 2;
