/*
Khi khách hàng đặt hàng gồm nhiều sản phẩm, hệ thống cần:
- Kiểm tra tồn kho cho từng sản phẩm
- Giảm số lượng tồn kho tương ứng
- Tạo bản ghi trong orders
- Thêm chi tiết sản phẩm vào order_items
- Tính tổng tiền và cập nhật total_amount
 

Yêu cầu:

1. Viết Transaction thực hiện toàn bộ quy trình đặt hàng cho khách "Nguyen Van A" gồm:
- Mua 2 sản phẩm:
  product_id = 1, quantity = 2
  product_id = 2, quantity = 1
- Nếu một trong hai sản phẩm không đủ hàng, toàn bộ giao dịch phải bị ROLLBACK
- Nếu thành công, COMMIT và cập nhật chính xác số lượng tồn kho
 
2. Mô phỏng lỗi:
- Giảm tồn kho của một sản phẩm xuống 0, sau đó chạy Transaction đặt hàng
- Kiểm tra kết quả khi có và không có Transaction
*/


create table products (
    product_id serial primary key,
    product_name varchar(100),
    stock int,
    price numeric(10,2)
);

create table orders (
    order_id serial primary key,
    customer_name varchar(100),
    total_amount numeric(10,2),
    created_at timestamp default now()
);

create table order_items (
    order_item_id serial primary key,
    order_id int references orders(order_id),
    product_id int references products(product_id),
    quantity int,
    subtotal numeric(10,2)
);


insert into products (product_name, stock, price) values
('Product A', 10, 100.00), ('Product B', 5, 200.00), ('Product C', 8, 150.00);



begin;
	-- Kiểm tra tồn kho
	do $$
	begin
	    if (select stock from products where product_id = 1) < 2 then
	        raise exception 'Not enough stock for product 1';
	    end if;
	
	    if (select stock from products where product_id = 2) < 1 then
	        raise exception 'Not enough stock for product 2';
	    end if;
	end $$;
	
	-- Tạo order
	insert into orders (customer_name, total_amount)
	values ('Nguyen Van A', 0)
	returning order_id;
	
	-- Thêm order_items
	insert into order_items (order_id, product_id, quantity, subtotal)
	select 1, product_id, qty, price * qty
	from (
	    values (1, 2), (2, 1)
	) as t(product_id, qty)
	join products p using (product_id);
	
	-- Cập nhật tồn kho
	update products
	set stock = stock - 2
	where product_id = 1;
	
	update products
	set stock = stock - 1
	where product_id = 2;
	
	-- Cập nhật tổng tiền
	update orders
	set total_amount = (
	    select sum(subtotal)
	    from order_items
	    where order_id = 1
	)
	where order_id = 1;
commit;

select * from products;
select * from orders;
select * from order_items;



update products
set stock = 0
where product_id = 2;

begin;
	do $$
	begin
	    if (select stock from products where product_id = 1) < 2 then
	        raise exception 'not enough stock for product 1';
	    end if;
	
	    if (select stock from products where product_id = 2) < 1 then
	        raise exception 'not enough stock for product 2';
	    end if;
	end $$;
	
	insert into orders (customer_name, total_amount)
	values ('Nguyen Van A', 0);
rollback;
