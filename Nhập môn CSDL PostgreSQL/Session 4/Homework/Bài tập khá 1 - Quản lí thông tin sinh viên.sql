-- Đề bài

CREATE TABLE students (
	id serial primary key,
	name varchar(50),
	age int,
	major varchar(50),
	gpa decimal(3,2)
);

insert into students (name, age, major, gpa) values
('An', 20, 'CNTT', 3.5),
('Bình', 21, 'Toán', 3.2),
('Cường', 22, 'CNTT', 3.8),
('Dương', 20, 'Vật lý', 3.0),
('Em', 21, 'CNTT', 2.9);

-- Các yêu cầu của BTVN

-- Thêm sinh viên Hùng
insert into students (name, age, major, gpa) values ('Hùng',23, 'Hóa học', 3.4);

select * from students;

-- Update GPA của sv Bình
update students
set gpa = 3.6
where name = 'Bình'; -- Hoặc xóa theo id = 2

-- Xóa SV có gpa < 3
delete from students
where gpa < 3.0;

-- Liệt kê tất cả sinh viên, chỉ hiển thị tên và chuyên ngành, sắp xếp theo GPA giảm dần
select name, major
from students
order by gpa desc;

-- Liệt kê tên sinh viên duy nhất có chuyên ngành "CNTT"
select name
from students
where major = 'CNTT';

-- Liệt kê sinh viên có GPA từ 3.0 đến 3.6
select *
from students
where gpa between 3.0 and 3.6;

-- Liệt kê sinh viên có tên bắt đầu bằng chữ 'C'
select *
from students
where name like 'C%';

-- Hiển thị 3 sinh viên đầu tiên theo thứ tự tên tăng dần, hoặc lấy từ sinh viên thứ 2 đến thứ 4 bằng LIMIT và OFFSET
select *
from students
order by name asc limit 3;

select *
from students
order by name asc limit 3 offset 1; -- ở đây kp áp dụng kĩ thuật phân trang mà chỉ đơn giản là muốn lấy dữ liệu đc sx theo thứ tự nhưng bỏ bản ghi đầu tiên để đáp ứng đúng ycau đề bài
