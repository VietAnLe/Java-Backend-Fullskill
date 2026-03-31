create table products (
    product_id serial primary key,
    name varchar(100),
    price numeric,
    category_id int
);

insert into products (name, price, category_id) values
('Product A', 100000, 1),
('Product B', 150000, 1),
('Product C', 200000, 1),
('Product D', 120000, 2),
('Product E', 180000, 2),
('Product F', 250000, 2),
('Product G', 300000, 3),
('Product H', 350000, 3),
('Product I', 400000, 3),
('Product J', 220000, 4),
('Product K', 270000, 4),
('Product L', 320000, 4),
('Product M', 500000, 5),
('Product N', 550000, 5),
('Product O', 600000, 5),
('Product P', 130000, 1),
('Product Q', 170000, 2),
('Product R', 380000, 3),
('Product S', 290000, 4),
('Product T', 620000, 5);



/*
1. Tạo Procedure update_product_price(p_category_id INT, p_increase_percent NUMERIC) để tăng giá tất cả sản phẩm trong một category_id theo phần trăm
2. Sử dụng biến để tính giá mới cho từng sản phẩm trong vòng lặp
3. Thử gọi Procedure với các tham số mẫu và kiểm tra kết quả trong bảng Products
*/

create or replace procedure update_product_price(
    p_category_id int,
    p_increase_percent numeric
)
language plpgsql
as $$
declare
    rec record;
    v_new_price numeric;
begin
    for rec in
        select product_id, price
        from products
        where category_id = p_category_id
    loop
        -- tính giá mới
        v_new_price := rec.price + (rec.price * p_increase_percent/100);

        -- update từng dòng
        update products
        set price = v_new_price
        where product_id = rec.product_id;
    end loop;
end;
$$;

call update_product_price(1, 10);

select * from products where category_id = 1;