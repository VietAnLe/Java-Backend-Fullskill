-- Câu lệnh tạo database
CREATE DATABASE LibraryDB;

-- Câu lệnh tạo schema
CREATE SCHEMA library;


-- Câu lệnh tạo bảng Books
CREATE TABLE library.Books (
	book_id serial primary key,
	title varchar(100)	not null,
	author varchar(50) not null,
	published_year int,
	price numeric(10,0)
);

-- Câu lệnh để xem các database, schema và cấu trúc bảng
SELECT datname
FROM pg_database;

SELECT schema_name
FROM information_schema.schemata;

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'library'
AND table_name = 'books';



ALTER TABLE library.books
ALTER COLUMN price TYPE real;

