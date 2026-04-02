create table customers(
	id bigserial primary key,
	name varchar(50),
	credit_limit numeric(10,2)
);

create table orders(
	id bigserial primary key,
	customer_id	bigint not null references customers(id),
	order_amount numeric(10,2)
);



-- Trigger function kiểm tra hạn mức tín dụng
create or replace function check_credit_limit()
returns trigger
as $$
declare
    v_total numeric;
    v_limit numeric;
begin
    -- lấy tổng tiền đơn hàng hiện tại của khách
    select coalesce(sum(order_amount), 0)
    into v_total
    from orders
    where customer_id = new.customer_id;

    -- lấy hạn mức tín dụng
    select credit_limit
    into v_limit
    from customers
    where id = new.customer_id;

    -- kiểm tra vượt hạn mức
    if (v_total + new.order_amount) > v_limit then
        raise exception 'Vượt hạn mức chi tiêu tín dụng!';
    end if;
    return new;
end;
$$ language plpgsql;

-- Trigger
create trigger trg_check_credit
before insert on orders
for each row
execute function check_credit_limit();



select * from customers;
select * from orders;

insert into customers (name, credit_limit) values
('Nguyễn Văn A', 20000000), ('Trần Thị B', 15000000);


-- test hợp lệ
insert into orders (customer_id, order_amount) values
(1, 5000000), (1, 7000000);

-- test vượt hạn mức
insert into orders (customer_id, order_amount) values
(1, 10000000);  



-- test khách khác
insert into orders (customer_id, order_amount) values
(2, 10000000);

insert into orders (customer_id, order_amount) values
(2, 6000000);  
