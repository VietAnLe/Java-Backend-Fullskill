-- Câu lệnh tạo database
CREATE DATABASE LibraryDB;

-- Câu lệnh tạo schema
CREATE SCHEMA library;



CREATE TABLE library.Books (
	book_id serial primary key,
	title varchar(100) not null,
	author varchar(50) not null,
	published_year int,
	available boolean default true
);

CREATE TABLE members (
	member_id serial primary key,
	name varchar(50) not null,
	email varchar(50) not null unique,
	join_date date default now()
);