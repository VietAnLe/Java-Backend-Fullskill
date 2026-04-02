create table employees (
    id serial primary key,
    name varchar(100),
    position varchar(50),
    salary numeric(12,2)
);

create table employees_log (
    log_id serial primary key,
    employee_id int,
    operation varchar(10),
    old_data jsonb,
    new_data jsonb,
    change_time timestamp default current_timestamp
);



-- Trigger function
create or replace function log_employee_changes()
returns trigger
as $$
begin
    if old is null then
        insert into employees_log(employee_id, operation, old_data, new_data)
        values (new.id, 'INSERT', null, to_jsonb(new));
        return new;
		
    elseif new is null then
        insert into employees_log(employee_id, operation, old_data, new_data)
        values (old.id, 'DELETE', to_jsonb(old), null);
        return old;

    else
        insert into employees_log(employee_id, operation, old_data, new_data)
        values (new.id, 'UPDATE', to_jsonb(old), to_jsonb(new));
        return new;
    end if;
end;
$$ language plpgsql;

-- Trigger
create trigger trg_log_employee
after insert or update or delete on employees
for each row
execute function log_employee_changes();



-- test insert
insert into employees (name, position, salary) values
('Nguyễn Văn A', 'Developer', 10000000),
('Trần Thị B', 'Tester', 8000000);

-- test update
update employees
set salary = 12000000
where id = 1;

-- test delete
delete from employees
where id = 2;


select * from employees;
select * from employees_log;