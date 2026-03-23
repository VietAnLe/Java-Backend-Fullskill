create table employee (
    id serial primary key,
    full_name varchar(100),
    department varchar(50),
    salary numeric(10,2),
    hire_date date
);

-- thêm 6 nhân viên
insert into employee (full_name, department, salary, hire_date) values
('Nguyễn Văn An', 'IT', 8000000, '2023-02-10'),
('Trần Thị Bình', 'HR', 7000000, '2022-05-15'),
('Lê Minh An', 'IT', 9000000, '2023-06-20'),
('Phạm Quốc Cường', 'Finance', 5500000, '2023-03-12'),
('Võ Thị Lan', 'Marketing', 6500000, '2023-09-01'),
('Hoàng Anh Tuấn', 'IT', 7500000, '2022-11-25');

-- tăng lương 10% cho phòng IT
update employee
set salary = salary * 1.10
where department = 'IT';

-- xóa nhân viên lương < 6000000
delete from employee
where salary < 6000000;

-- tìm nhân viên có tên chứa 'An' (không phân biệt hoa thường)
select *
from employee
where full_name ilike '%an%';

-- nhân viên có hire_date trong năm 2023
select *
from employee
where hire_date between '2023-01-01' and '2023-12-31';
