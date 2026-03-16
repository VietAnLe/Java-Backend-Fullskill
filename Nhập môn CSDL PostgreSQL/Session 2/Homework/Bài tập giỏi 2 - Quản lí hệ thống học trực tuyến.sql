create database ElearningDB;

create schema elearning;

create table elearning.students (
	student_id bigserial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email char not null unique
);

create table elearning.instructors (
	instructor_id bigserial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email char not null unique 
);

create table elearning.courses (
	course_id serial primary key,
	course_name varchar(100) not null,
	instructor_id bigint not null references elearning.instructors(instructor_id)
);

create table elearning.enrollments (
	enrollment_id bigserial primary key,
	student_id bigint not null references elearning.students(student_id),
	course_id int not null references elearning.courses(course_id),
	enroll_date date not null default current_date
);

create table elearning.assignments (
	assignment_id serial primary key,
	course_id int not null references elearning.courses(course_id),
	title varchar(100) not null,
	due_date date
);

create table elearning.submissions(
	submission_id bigserial primary key,
	assignment_id int not null references elearning.assignments(assignment_id),
	student_id bigint not null references elearning.students(student_id),
	submission_date date,
	grade real check (grade between 0 and 100)
);

