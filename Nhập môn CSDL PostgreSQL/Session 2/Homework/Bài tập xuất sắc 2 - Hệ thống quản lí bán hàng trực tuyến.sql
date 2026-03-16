CREATE DATABASE EcommerceDB;

CREATE SCHEMA shop;



create table shop.users (
	user_id serial primary key,
	username varchar(50) not null unique,
	email varchar(100) not null unique,
	password varchar(100) not null,
	role varchar(20) check (role in ('Admin', 'Customer'))
);

create table shop.categories (
	category_id serial primary key,
	category_name varchar(100) unique not null
);

create table shop.products (
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(100) NOT NULL,
	price NUMERIC(10,2) CHECK (price > 0),
	stock INT CHECK (stock >= 0),
	category_id INT NOT NULL REFERENCES shop.categories(category_id)
);

create table shop.orders (
	order_id SERIAL PRIMARY KEY,
	user_id INT NOT NULL REFERENCES shop.users(user_id),
	order_date DATE NOT NULL,
	status VARCHAR(20) CHECK (status IN ('Pending','Shipped','Delivered','Cancelled'))
);

create table shop.orderdetails (
	order_detail_id SERIAL PRIMARY KEY,
	order_id INT NOT NULL REFERENCES shop.orders(order_id),
	product_id INT NOT NULL REFERENCES shop.products(product_id),
	quantity INT CHECK (quantity > 0),
	price_each NUMERIC(10,2) CHECK (price_each > 0)
);

create table shop.payments (
	payment_id SERIAL PRIMARY KEY,
	order_id INT NOT NULL REFERENCES shop.orders(order_id),
	amount NUMERIC(10,2) CHECK (amount >= 0),
	payment_date DATE NOT NULL,
	method VARCHAR(30) CHECK (method IN ('Credit Card','Momo','Bank Transfer','Cash'))
);