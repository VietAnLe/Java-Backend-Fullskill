create table employees (
	emp_id serial primary key,
	emp_name varchar(100),
	job_level int,
	salary numeric
);

insert into employees (emp_name, job_level, salary) values
('Nguyễn Văn A', 0, 5000000),
('Trần Thị B', 1, 7000000),
('Lê Văn C', 2, 12000000),
('Phạm Minh D', 3, 20000000),
('Hoàng Văn E', 1, 8000000),
('Võ Thị F', 0, 5500000),
('Đặng Quốc G', 2, 13000000),
('Bùi Thị H', 3, 22000000),
('Ngô Văn I', 1, 7500000),
('Phan Minh J', 2, 14000000);

/*
1. Tạo Procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC) để:
- Nhận emp_id của nhân viên
- Cập nhật lương theo quy tắc trên
- Trả về p_new_salary (lương mới) sau khi cập nhật
2. Thực thi thử:
	call adjust_salary(3, p_new_salary);
	select p_new_salary;
*/

create or replace procedure adjust_salary(
	p_emp_id int,
	OUT p_new_salary numeric
)
language plpgsql
as $$

declare v_job_level int;

begin
    select job_level into v_job_level from employees where emp_id = p_emp_id;

	if v_job_level = 1 then
		update employees set salary = 1.05*salary where emp_id = p_emp_id; -- Update ... into là sai
	elseif v_job_level = 2 then
		update employees set salary = 1.1*salary where emp_id = p_emp_id;
	elseif v_job_level = 3 then
		update employees set salary = 1.15*salary where emp_id = p_emp_id;
	else 
		raise notice 'Hãy thăng tiến để được tăng lương!';
	end if;

    select salary into p_new_salary from employees where emp_id = p_emp_id;

end;
$$;

select * from employees;

do $$
declare 
	p_new_salary numeric;
begin
	call adjust_salary(10, p_new_salary);
	raise notice 'Lương mới: %', p_new_salary;
end $$;
