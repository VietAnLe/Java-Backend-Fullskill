create table sales (
    sale_id serial primary key,
    customer_id int,
    amount numeric,
    sale_date date
);

insert into sales (customer_id, amount, sale_date) values
(1, 200, '2024-01-01'),
(2, 500, '2024-01-03'),
(3, 300, '2024-01-05'),
(1, 700, '2024-01-10'),
(2, 400, '2024-01-15'),
(3, 600, '2024-01-20'),
(4, 800, '2024-02-01'),
(5, 1000, '2024-02-05'),
(1, 1200, '2024-02-10'),
(2, 900, '2024-02-15');



/*
1. Tạo Procedure calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC) để tính tổng amount trong khoảng start_date đến end_date
2. Gọi Procedure với các ngày mẫu và hiển thị kết quả
*/

create or replace procedure calculate_total_sales(
    start_date date,
    end_date date,
    out total numeric
)
language plpgsql
as $$
begin
    select sum(amount)
    into total
    from sales
    where sale_date between start_date and end_date;
end;
$$;

call calculate_total_sales('2024-01-01', '2024-01-31', null);