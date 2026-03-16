CREATE DATABASE CompanyDB;

create table departments ( 				-- Tạo bảng bên "một" trước
	department_id serial primary key,
	department_name varchar(30) not null
);

create table employees (
	emp_id bigserial primary key,
	name varchar(50) not null,
	dob date,
	department_id int not null references departments(department_id)
);

create table projects (
	project_id serial primary key,
	project_name varchar(50) not null,
	start_date date,
	end_date date check (end_date > start_date)
);

create table employeeprojects (
	emp_id bigint not null references employees(emp_id),
	project_id int not null references projects(project_id),
	primary key(emp_id, project_id)
);