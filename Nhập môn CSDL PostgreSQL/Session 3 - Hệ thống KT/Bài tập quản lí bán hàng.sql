create schema sales;

create table sales.products (
	product_id serial primary key,
	product_name varchar(100) not null,
	price numeric(10, 2) check (price > 0),
	stock_quantity int
);

create table sales.orders (
	order_id serial primary key,
	order_date date not null default now(),
	member_id int not null references members(member_id)
);

create table sales.orderdetails (
	order_detail_id serial primary key,
	order_id int not null references sales.orders(order_id),
	product_id int not null references sales.products(product_id),
	quantity int check (quantity > 0)
);
