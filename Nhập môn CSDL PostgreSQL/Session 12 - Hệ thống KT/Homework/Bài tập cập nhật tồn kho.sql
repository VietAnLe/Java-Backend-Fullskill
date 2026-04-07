/*
- Dùng bảng products và sales từ bài tập 2
- Viết TRIGGER AFTER INSERT để giảm số lượng stock trong products
- Thêm đơn hàng và kiểm tra products để thấy số lượng tồn kho giảm đúng
*/

create or replace function decrease_stock_after_insert()
returns trigger
as $$
begin
    update products
    set stock = stock - new.quantity
    where product_id = new.product_id;

    return new;
end;
$$ language plpgsql;

create trigger trg_decrease_stock
after insert on sales
for each row
execute function decrease_stock_after_insert();

select * from products;



insert into sales (product_id, quantity)
values (1, 3);

insert into sales (product_id, quantity)
values (1, 2);
