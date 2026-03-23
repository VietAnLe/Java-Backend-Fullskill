select * from products p join orders o on p.product_id = o.product_id;

-- Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders
select p.product_name, sum(o.total_price) as "total_revenue"
from products p join orders o on p.product_id = o.product_id
group by product_name
having sum(o.total_price) = (
	select max(total_revenue)
	from (
		select sum(total_price) as "total_revenue"
		from orders
		group by product_id
	)
);

/* Cách ngắn hơn: sử dụng order by với limit, nhưng với cách này nếu có nhiều sản phẩm có total revenue bằng nhau thì ko hiển thị hết được

select p.product_name, sum(o.total_price) as "total_revenue"
from products p join orders o on p.product_id = o.product_id
group by product_name
order by total_revenue desc limit 1;
*/

-- Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
select p.category, sum(o.total_price) as total_sales
from products p join orders o on p.product_id = o.product_id
group by p.category;

-- Dùng INTERSECT để tìm ra nhóm category có sản phẩm bán chạy nhất (ở câu 1) cũng nằm trong danh sách nhóm có tổng doanh thu lớn hơn 3000

-- category của sản phẩm có doanh thu cao nhất
select p.category
from products p join orders o on p.product_id = o.product_id
group by p.product_id, p.category
having sum(o.total_price) = (
    select max(total_revenue)
    from (
        select sum(total_price) as total_revenue
        from orders
        group by product_id
    )
)

intersect

-- category có tổng doanh thu > 3000
select p.category
from products p join orders o on p.product_id = o.product_id
group by p.category
having sum(o.total_price) > 3000;



-- Cách 2
select category
from (
    select p.category, sum(o.total_price) as total_revenue
    from products p
    join orders o
    on p.product_id = o.product_id
    group by p.product_id, p.category
    order by total_revenue desc
    limit 1
)

intersect

select p.category
from products p
join orders o
on p.product_id = o.product_id
group by p.category
having sum(o.total_price) > 3000;