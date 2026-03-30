create table order_detail (
	id serial primary key,
	order_id int,
	product_name varchar(100),
	quantity int,
	unit_price numeric
);

insert into order_detail (order_id, product_name, quantity, unit_price) values
(1, 'Hop but', 1, 50000), (1, 'But chi', 3, 15000), (2, 'Snacks', 2, 10000), (3, 'Giay an', 1, 80000), (4, 'Tai nghe', 1, 150000);

select * from order_detail;



/*
1. Viết một Stored Procedure có tên calculate_order_total(order_id_input INT, OUT total NUMERIC)
- Tham số order_id_input: mã đơn hàng cần tính
- Tham số total: tổng giá trị đơn hàng
2. Trong Procedure: Viết câu lệnh tính tổng tiền theo order_id
3. Gọi Procedure để kiểm tra hoạt động với một order_id cụ thể
*/

create or replace procedure calculated_order_total(
	order_id_input int,
	OUT total numeric
)
language plpgsql
as $$

begin
	select sum(quantity*unit_price) into total from order_detail where order_id = order_id_input;
    -- Cách khác | total := (select sum(quantity*unit_price) from order_detail where order_id = order_id_input); 
end;
$$;

do $$
declare 
	total numeric;
begin
	call calculated_order_total(1, total);
	raise notice 'Tổng chi tiêu của khách hàng là: %', total;
end $$;
