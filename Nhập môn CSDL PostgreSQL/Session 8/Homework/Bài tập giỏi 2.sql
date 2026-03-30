create table products(
	id serial primary key,
	name varchar(100),
	price numeric,
	discount_percent int
);

insert into products (name, price, discount_percent) values
('iPhone 14 Pro', 999.99, 10),
('Samsung Galaxy S23', 899.99, 12),
('MacBook Air M2', 1199.00, 8),
('Dell XPS 13', 1099.50, 15),
('Sony WH-1000XM5 Headphones', 399.99, 20),
('Apple Watch Series 9', 429.00, 5),
('iPad Air 5', 599.00, 10),
('Logitech MX Master 3S Mouse', 99.99, 18),
('Mechanical Keyboard Keychron K6', 129.99, 25),
('ASUS ROG Gaming Laptop', 1599.00, 7);

select * from products;

/*
1. Viết Procedure calculate_discount(p_id INT, OUT p_final_price NUMERIC) để:
- Lấy price và discount_percent của sản phẩm
- Tính giá sau giảm: p_final_price = price - (price * discount_percent / 100)
- Nếu phần trăm giảm giá > 50, thì giới hạn chỉ còn 50%
2. Cập nhật lại cột price trong bảng products thành giá sau giảm
3. Gọi thử:
*/

create or replace procedure calculate_discount(
	p_id int,
	OUT p_final_price numeric
)
language plpgsql
as $$

begin
	update products
	set price = 
		case 
			when discount_percent <= 50 then price - round((price * discount_percent/100), 2)
			when discount_percent > 50 then price - round((price * 50/100), 2)
		end
	where id = p_id;

	select price into p_final_price	from products where id = p_id;
	
end;
$$;

call calculate_discount(9, null);