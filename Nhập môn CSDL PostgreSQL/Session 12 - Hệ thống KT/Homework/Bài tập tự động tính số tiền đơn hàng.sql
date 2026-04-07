alter table products
add column price numeric;

update products set price = 100 where product_id = 1;
update products set price = 200 where product_id = 2;


create table orders(
    order_id serial primary key,
    product_id int references products(product_id),
    quantity int,
    total_amount numeric
);



/*
- Tạo bảng orders:
- Viết TRIGGER BEFORE INSERT để tự động tính total_amount
- Thêm vài đơn hàng và kiểm tra cột total_amount
*/

create or replace function calculate_total_amount()
returns trigger
as $$
declare
    product_price numeric;
begin
    -- lấy giá sản phẩm
    select price into product_price
    from products
    where product_id = new.product_id;

    -- tính tổng tiền
    new.total_amount := new.quantity * product_price;

    return new;
end;
$$ language plpgsql;

create trigger trg_calculate_total
before insert on orders
for each row
execute function calculate_total_amount();



insert into orders (product_id, quantity)
values (1, 2), (2, 1);

select * from orders;
