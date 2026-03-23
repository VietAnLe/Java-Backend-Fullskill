create table department (
    id serial primary key,
    name varchar(50)
);

create table employee (
    id serial primary key,
    full_name varchar(100),
    department_id int,
    salary numeric(10,2),
    foreign key (department_id) references department(id)
);

insert into department (id, name) values
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

insert into employee (full_name, department_id, salary) values
('Nguyễn Văn A', 1, 12000000),
('Trần Thị B', 2, 9000000),
('Lê Văn C', 1, 15000000),
('Phạm Minh D', 3, 8000000),
('Hoàng Văn E', 1, 11000000);

-- nhân viên + phòng ban (inner join)
select 
    e.full_name,
    d.name as department_name
from employee e
join department d on e.department_id = d.id;

-- lương trung bình từng phòng ban
select 
    d.name as department_name,
    avg(e.salary) as avg_salary
from department d
join employee e on d.id = e.department_id
group by d.name;

-- phòng ban có lương trung bình > 10000000
select 
    d.name as department_name,
    avg(e.salary) as avg_salary
from department d
join employee e on d.id = e.department_id
group by d.name
having avg(e.salary) > 10000000;

-- phòng ban không có nhân viên
select 
    d.name as department_name
from department d
left join employee e on d.id = e.department_id
where e.id is null;
