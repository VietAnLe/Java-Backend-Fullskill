create table customers (
    customer_id serial primary key,
    name varchar(50),
    email varchar(50)
);

create table customer_log (
    log_id serial primary key,
	customer_name varchar(50),
	action_time timestamp
);



/*
Tạo bảng customers:


Tạo bảng customer_log:


Tạo TRIGGER để tự động ghi log khi INSERT vào customers
Thêm vài bản ghi vào customers và kiểm tra customer_log
*/

create or replace function log_customer_insert()
returns trigger
as $$
begin
    insert into customer_log (customer_id, name, email)
    values (new.customer_id, new.name, new.email);

    return new;
end;
$$ language plpgsql;

create trigger trg_log_customer
after insert on customers
for each row
execute function log_customer_insert();

insert into customers (name, email) values
('Nguyen Van A', 'A@gmail.com'), ('Tran Thi B', 'B@gmail.com'), ('Le Van C', 'C@gmail.com');


select * from customers;
select * from customer_log;