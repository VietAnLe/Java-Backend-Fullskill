CREATE DATABASE UniversityDB;

CREATE SCHEMA university;

create table university.students (
	student_id bigserial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	birth_date date,
	email char not null unique
);

create table university.courses (
	course_id serial primary key,
	course_name varchar(100) not null,
	credits int
);

create table university.enrollments (
	enrollment_id bigserial primary key,
	student_id bigint not null references university.students(student_id),
	course_id int not null references university.courses(course_id),
	enroll_date date default current_date
);

-- Câu lệnh để xem các database, schema và cấu trúc bảng
SELECT datname
FROM pg_database;

SELECT schema_name
FROM information_schema.schemata;

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'university'
AND table_name IN ('students', 'courses', 'enrollments');

