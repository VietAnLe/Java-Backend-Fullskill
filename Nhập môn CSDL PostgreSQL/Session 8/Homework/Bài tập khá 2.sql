create table inventory (
	product_id serial primary key,
	product_name varchar(100), 
	quantity int
);

insert into inventory (product_name, quantity) values
('Laptop Dell', 50),
('Chuột Logitech', 200),
('Bàn phím Razer', 100),
('iPhone 15', 30),
('Tai nghe Sony', 500);

/*
1. Viết một Procedure có tên check_stock(p_id INT, p_qty INT) để:
- Kiểm tra xem sản phẩm có đủ hàng không
- Nếu quantity < p_qty, in ra thông báo lỗi bằng RAISE EXCEPTION ‘Không đủ hàng trong kho’
2. Gọi Procedure với các trường hợp:
- Một sản phẩm có đủ hàng
- Một sản phẩm không đủ hàng
*/

create or replace procedure check_stock(
	p_id int,
	p_qty int
)
language plpgsql
as $$

begin
	if exists (select * from inventory where product_id = p_id and quantity >= p_qty) then
		raise notice 'Sản phẩm có đủ hàng trong kho!';
	else
		raise exception 'Sản phẩm không đủ hàng trong kho!';
	end if;
end;
$$;

call check_stock(1, 10);
call check_stock(4, 100);