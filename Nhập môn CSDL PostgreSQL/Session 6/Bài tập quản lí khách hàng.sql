create table customer (
    id serial primary key,
    name varchar(100),
    email varchar(100),
    phone varchar(20),
    points int
);

-- thêm 7 khách hàng (1 người không có email)
insert into customer (name, email, phone, points) values
('Nguyễn Văn A', 'a@gmail.com', '0123456789', 100),
('Trần Thị B', 'b@gmail.com', '0987654321', 200),
('Lê Văn C', null, '0912345678', 150),
('Phạm Thị D', 'd@gmail.com', '0934567890', 300),
('Hoàng Văn E', 'e@gmail.com', '0945678901', 250),
('Võ Thị F', 'f@gmail.com', '0956789012', 180),
('Nguyễn Văn A', 'a2@gmail.com', '0967890123', 220);

-- danh sách tên khách hàng duy nhất
select distinct name
from customer;

-- khách hàng chưa có email
select *
from customer
where email is null;

-- 3 khách hàng điểm cao nhất (bỏ người cao nhất)
select *
from customer
order by points desc limit 3 offset 1;

-- sắp xếp theo tên giảm dần
select *
from customer
order by name desc;
