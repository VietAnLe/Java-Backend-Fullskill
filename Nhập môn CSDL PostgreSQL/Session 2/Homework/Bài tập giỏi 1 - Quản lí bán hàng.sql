CREATE DATABASE SalesDB;

CREATE SCHEMA sales;

create table sales.customers (
	customer_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email char(50) not null unique,
	phone char(11)
);

create table sales.products (
	product_id serial primary key,
	product_name varchar(100) not null,
	price real not null,
	stock_quantity int not null
);

create table sales.orders (
	order_id serial primary key,
	customer_id int not null references sales.customers(customer_id),
	order_date date not null default current_date
);

create table sales.orderitems (
	order_item_id serial primary key,
	order_id int not null references sales.orders(order_id),
	product_id int not null references sales.products(product_id),
	quantity int not null check (0 < quantity)  -- note: muốn thêm điều kiện để quantity =< stock_quantity thì sau này dùng thêm trigger hoặc logic query
);