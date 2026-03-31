create table products (
    product_id serial primary key,
    category_id int,
    price numeric,
    stock_quantity int
);

insert into products (category_id, price, stock_quantity) values
(1, 100000, 10),
(1, 200000, 5),
(1, 150000, 8),
(2, 300000, 7),
(2, 250000, 12),
(2, 400000, 3),
(3, 500000, 6),
(3, 450000, 9),
(3, 550000, 4),
(4, 120000, 15),
(4, 130000, 11),
(4, 110000, 20),
(5, 700000, 2),
(5, 650000, 6),
(5, 720000, 1),
(1, 180000, 7),
(2, 350000, 10),
(3, 480000, 5),
(4, 140000, 13),
(5, 690000, 3);

-- Clustered index
create index idx_products_category
on products (category_id);

cluster products using idx_products_category;

-- Non-clustered index
create index idx_products_price
on products (price);



explain analyze
select *
from products
where category_id = 2
order by price;

/*
- Clustered Index (thông qua cluster) giúp sắp xếp dữ liệu vật lý theo category_id, làm tăng tốc truy vấn lọc theo cột này
- Non-clustered index trên price hỗ trợ việc sắp xếp dữ liệu
- Khi truy vấn WHERE category_id = X ORDER BY price, hệ thống có thể:
  + Dùng index để lọc nhanh theo category_id
  + Sau đó sắp xếp theo price (hoặc dùng index nếu phù hợp)
*/