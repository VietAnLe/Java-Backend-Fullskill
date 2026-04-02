create table products(
	id serial primary key,
	name varchar(50) not null,
	stock int not null
);

create table orders(
	id serial primary key,
	product_id int not null references products(id),
	quantity int
);



-- Trigger function
create or replace function manage_stock()
returns trigger
language plpgsql
as $$
begin
    -- INSERT
    if old is null then
        update products
        set stock = stock - new.quantity
        where id = new.product_id;
        return new;

    -- DELETE
    elseif new is null then
        update products
        set stock = stock + old.quantity
        where id = old.product_id;
        return old;

    -- UPDATE
    else
        -- nếu cùng product
        if old.product_id = new.product_id then
            update products
            set stock = stock + old.quantity - new.quantity
            where id = new.product_id;

        -- nếu đổi product_id
        else
            -- trả lại stock cho product cũ
            update products
            set stock = stock + old.quantity
            where id = old.product_id;

            -- trừ stock cho product mới
            update products
            set stock = stock - new.quantity
            where id = new.product_id;
        end if;
        return new;
    end if;
end;
$$;


-- Trigger
create trigger trg_manage_stock
after insert or update or delete on orders
for each row
execute function manage_stock();



insert into products (name, stock) values
('Laptop Dell', 10),
('Chuột Logitech', 50);

insert into orders (product_id, quantity) values
(1, 2);

update orders
set quantity = 5
where id = 1;

update orders
set product_id = 2, quantity = 3
where id = 1;

delete from orders
where id = 1;


select * from products;
select * from orders;