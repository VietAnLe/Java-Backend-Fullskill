create table users (
    user_id serial primary key,
    email varchar(100),
    username varchar(50)
);

insert into users (email, username)
select 
    'user' || i || '@example.com',
    'user_' || i
from generate_series(1, 10000) as s(i);

create index idx_users_email_hash
on users using hash (email);

explain analyze
select * 
from users 
where email = 'user500@example.com';

/* Kết quả:
- Thực tế thì khi chạy câu truy vấn khoảng thời gian thực hiện không khác biệt nhau quá nhiều,
phần vì đây chỉ là bài tập để thực hành, và data cũng không phải thực tế, bảng cũng không phức tạp và có nhiều thuộc tính,
câu lệnh truy vấn cũng không hề nặng nên thời gian thực thi vẫn rất nhanh.
- Còn về phần kết quả phân tích của hệ thống thì thời gian sẽ giảm được khoảng 3, 4 lần
- Đó là kết quả và sự phân tích ngắn của em