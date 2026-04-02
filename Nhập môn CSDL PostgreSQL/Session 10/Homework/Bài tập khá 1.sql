create table products(
	id serial primary key,
	name varchar(100),
	price numeric(10,2),
	last_modified timestamp
);

create or replace function update_last_modified()
returns trigger
language plpgsql
as $$
begin
	new.last_modified :=  current_timestamp;
	return new;
end;
$$;

create or replace trigger trg_update_last_modified
before update
on products
for each row
execute function update_last_modified();



select * from products;

insert into products (name, price) values
('Laptop Dell XPS 13', 25000000),
('MacBook Air M1', 23000000),
('Chuột Logitech M170', 300000),
('Bàn phím cơ Keychron K6', 2500000),
('Màn hình LG 27 inch', 5000000),
('Tai nghe Sony WH-1000XM4', 7000000),
('Loa Bluetooth JBL Flip 5', 2500000),
('Ổ cứng SSD Samsung 1TB', 3200000),
('Webcam Logitech C920', 1800000),
('Router Wifi TP-Link AX55', 2700000);

update products
set price = 3200000
where id = 10;

update products
set price = price*1.5;
