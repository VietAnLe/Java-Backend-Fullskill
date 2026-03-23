create table course (
    id serial primary key,
    title varchar(100),
    instructor varchar(50),
    price numeric(10,2),
    duration int
);

-- thêm ít nhất 6 khóa học
insert into course (title, instructor, price, duration) values
('SQL cơ bản', 'Nguyễn Văn A', 500000, 20),
('SQL nâng cao', 'Trần Thị B', 1500000, 40),
('Lập trình Python', 'Lê Văn C', 2000000, 35),
('Java cơ bản', 'Phạm Minh D', 800000, 25),
('SQL cho Data Analyst', 'Hoàng Văn E', 1800000, 45),
('Demo khóa học SQL', 'Võ Thị F', 300000, 10);

-- cập nhật giá +15% cho khóa học > 30 giờ
update course
set price = price * 1.15
where duration > 30;

-- xóa khóa học chứa 'Demo'
delete from course
where title ilike '%demo%';

-- hiển thị khóa học chứa 'SQL' (không phân biệt hoa thường)
select *
from course
where title ilike '%sql%';

-- 3 khóa học giá từ 500000 đến 2000000, sắp xếp giảm dần
select *
from course
where price between 500000 and 2000000
order by price desc limit 3;
