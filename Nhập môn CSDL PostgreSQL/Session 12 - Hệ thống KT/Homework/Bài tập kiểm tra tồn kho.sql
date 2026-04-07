create table products(
    product_id serial primary key,
    name varchar(50),
    stock int
);

create table sales(
    sale_id serial primary key,
    product_id int references products(product_id),
    quantity int
);

insert into products (name, stock) values
('Product A', 10), ('Product B', 5);



/*
Tạo bảng products:


Tạo bảng sales:


Viết TRIGGER BEFORE INSERT để kiểm tra tồn kho
Thử thêm các đơn hàng vượt quá tồn kho và quan sát Trigger hoạt động
*/

create or replace function check_stock_before_insert()
returns trigger
as $$
declare
    current_stock int;
begin
    -- lấy tồn kho hiện tại
    select stock into current_stock
    from products
    where product_id = new.product_id;

    -- kiểm tra tồn kho
    if current_stock < new.quantity then
        raise exception 'not enough stock. current: %, required: %',
            current_stock, new.quantity;
    end if;

    return new;
end;
$$ language plpgsql;

create trigger trg_check_stock
before insert on sales
for each row
execute function check_stock_before_insert();



insert into sales (product_id, quantity)
values (1, 3);

insert into sales (product_id, quantity)
values (2, 10);
