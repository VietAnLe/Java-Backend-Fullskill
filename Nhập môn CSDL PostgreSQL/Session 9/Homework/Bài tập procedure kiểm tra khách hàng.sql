create table customers (
    customer_id serial primary key,
    name varchar(100),
    email varchar(100)
);

create table orders (
    order_id serial primary key,
    customer_id int,
    amount numeric,
    order_date date
);

insert into customers (name, email) values
('Nguyen Van A', 'a@gmail.com'),
('Tran Thi B', 'b@gmail.com'),
('Le Van C', 'c@gmail.com');

insert into orders (customer_id, amount, order_date) values
(1, 500, '2024-01-01'),
(2, 700, '2024-01-02');



/*
1. Tạo Procedure add_order(p_customer_id INT, p_amount NUMERIC) để thêm đơn hàng
2. Kiểm tra nếu customer_id không tồn tại trong bảng Customers, sử dụng RAISE EXCEPTION để báo lỗi
3. Nếu khách hàng tồn tại, thêm bản ghi mới vào bảng Orders
*/

create or replace procedure add_order(
    p_customer_id int,
    p_amount numeric
)
language plpgsql
as $$
declare
    v_exists int;
begin
    -- Kiểm tra customer có tồn tại không
    select count(*)
    into v_exists
    from customers
    where customer_id = p_customer_id;

    if v_exists = 0 then
        raise exception 'Customer % does not exist', p_customer_id;
    end if;

    -- Nếu tồn tại thì insert
    insert into orders (customer_id, amount, order_date)
    values (p_customer_id, p_amount, current_date);

end;
$$;


call add_order(1, 1000);
call add_order(999, 500); -- Khách hàng ko tồn tại
