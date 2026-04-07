create table employees(
    emp_id serial primary key,
    name varchar(50),
    position varchar(50)
);

create table employee_log(
    log_id serial primary key,
    emp_name varchar(50),
    action_time timestamp
);

insert into employees (name, position) values
('nguyen van a', 'developer'), ('tran thi b', 'tester');




/*
- Tạo bảng employees:
- Tạo bảng employee_log:
- Viết TRIGGER AFTER UPDATE để ghi log khi thông tin nhân viên thay đổi
- Thực hiện UPDATE và kiểm tra bảng employee_log
*/

create or replace function log_employee_update()
returns trigger
as $$
begin
    insert into employee_log (emp_name, action_time)
    values (new.name, now());

    return new;
end;
$$ language plpgsql;

create trigger trg_log_employee_update
after update on employees
for each row
execute function log_employee_update();



update employees
set position = 'senior developer'
where emp_id = 1;

select * from employees;
select * from employee_log;
