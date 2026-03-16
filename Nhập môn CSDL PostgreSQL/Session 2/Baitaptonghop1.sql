-- Chú thích 1 dòng
-- Mục đích của chú thích: Giải thích câu lệnh hoặc nhóm câu lệnh thực hiện để làm gì
/*
Chú thích trên nhiều dòng
*/


-- Câu lệnh tạo database
create database db_jb_ioc_pthb260310;

-- Câu lệnh xóa database
drop database db_jb_ioc_pthb260310;

-- Tạo bảng lớp học
CREATE TABLE Classes(
	id CHAR(15) PRIMARY KEY,
	class_name varchar(100) not null,
	start_date date default current_date,
	end_date date check (end_date > start_date),
	status boolean
);

-- Tạo bảng lớp học
create table classes(
	id char(14) not null primary key,
	class_name varchar(100) not null unique,
	start_date date default current_date,
	end_date date check (end_date > start_date),
	status boolean
);
-- Tạo bảng sinh viên
create table students(
	id serial primary key,
	full_name varchar(50),  -- Nguyễn Phan Đăng Quân
	gender boolean,  -- true/false
	birthday date,  -- 2005-12-29
	address varchar(200), -- 'Sóc Sơn - Hà Nội'
	class_id char(14) references classes(id)
);

-- Xoá bảng sinh viên
drop table students;

-- Thêm cột vào bảng
alter table students add avatar text default '';

-- xoá cột
alter table students drop column avatar;

-- Thay đổi kiểu dữ liệu của cột trong bảng
alter table students alter column avatar type varchar(200);
-- alter table students alter column avatar type varchar(200) set default '';


-- Thêm lại ràng buộc
alter table students alter column avatar set default '';

-- Tạo schema mới
create schema library;

create table library.users(
	user_id serial primary key,
	full_name varchar(50),
	email varchar(100) not null unique,
	phone varchar(12) default '',
	birthday date,
	address varchar(200),
	status boolean,
	date_join date default current_date
);

create table library.publishers(
	publisher_id serial primary key,
	publisher_name varchar(100) not null unique,
	address varchar(200),
	status boolean
);

create table library.categories(
	cate_id serial primary key,
	cate_name varchar(100) not null unique,
	status boolean
);
create table library.books(
	isbn serial primary key,
	title varchar(100) not null unique,
	year_publish int check(year_publish>1900),
	publisher_id int references library.publishers(publisher_id),
	quantity int check(quantity>=0),
	cate_id int references library.categories(cate_id)
);

-- tạo bảng tác giả
create table library.authors(
	author_id serial primary key,
	author_name varchar(50),
	gender boolean,
	birthday date,
	address varchar(200)
);

-- 1 sách có nhiều tác giả
create table library.author_book(
	author_id int not null references library.authors(author_id),
	book_id int not null references library.books(isbn),
	primary key(author_id,book_id)
);

-- bảng phiếu mượn
create table library.borrows(
	borrow_id serial primary key,
	borrow_date date default current_date,
	return_date date,
	return_real_date date,
	user_id int references library.users(user_id)
);

-- bảng chi tiết phiếu mượn
create table library.borrows_details(
	borrow_id int not null references library.borrows(borrow_id),
	book_id int not null references library.books(isbn),
	quantity int check(quantity>0),
	book_status text
);