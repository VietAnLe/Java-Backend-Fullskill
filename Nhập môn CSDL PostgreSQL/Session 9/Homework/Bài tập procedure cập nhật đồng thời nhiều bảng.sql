create table customers (
    customer_id serial primary key,
    name varchar(100),
    total_spent numeric default 0
);

create table orders (
    order_id serial primary key,
    customer_id int,
    total_amount numeric
);

insert into customers (name, total_spent) values
('Nguyen Van A', 1000),
('Tran Thi B', 2000),
('Le Van C', 1500);

insert into orders (customer_id, total_amount) values
(1, 500),
(2, 700);



/*
1. Tạo Procedure add_order_and_update_customer(p_customer_id INT, p_amount NUMERIC) để:
- Thêm đơn hàng mới vào bảng Orders
- Cập nhật total_spent trong bảng Customers
2. Sử dụng biến và xử lý điều kiện để đảm bảo khách hàng tồn tại
3. Sử dụng EXCEPTION để báo lỗi nếu thêm đơn hàng thất bại
4. Gọi Procedure với tham số mẫu và kiểm tra kết quả trên cả hai bảng
*/

create or replace procedure add_order_and_update_customer(
    p_customer_id int,
    p_amount numeric
)
language plpgsql
as $$
declare
    v_exists boolean;
begin
    -- Kiểm tra customer tồn tại
    select exists (
        select 1 from customers where customer_id = p_customer_id
    )
    into v_exists;

    if not v_exists then
        raise exception 'Customer ID % does not exist', p_customer_id;
    end if;

    -- Thêm đơn hàng
    insert into orders (customer_id, total_amount)
    values (p_customer_id, p_amount);

    -- Cập nhật tổng chi tiêu
    update customers
    set total_spent = total_spent + p_amount
    where customer_id = p_customer_id;

exception
    when others then
        raise exception 'Failed to add order for customer %', p_customer_id;
end;
$$;


call add_order_and_update_customer(1, 500);
call add_order_and_update_customer(999, 500);
