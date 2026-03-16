create database schoolDB;

create table students (
	student_id bigserial primary key,
	name varchar(50) not null,
	dob date
);

create table courses (
	course_id serial primary key,
	course_name varchar(100) not null,
	credits int
);

create table enrollments (
	enrollment_id bigserial primary key,
	student_id bigint not null references students(student_id),
	course_id int not null references courses(course_id),
	grade char(1) check (grade in ('A', 'B'	, 'C', 'D', 'F'))
);
