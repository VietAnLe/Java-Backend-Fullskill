create table students (
    id int primary key,
    full_name varchar(100),
    gender varchar(10),
    birth_year int,
    major varchar(50),
    gpa decimal(3,1)
);

insert into students (id, full_name, gender, birth_year, major, gpa) values
(1, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
(2, 'Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
(3, 'Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
(4, 'Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
(5, 'Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
(6, 'Lưu Đức Tài', 'Nam', 2004, 'Cơ khí', null),
(7, 'Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

select * from students;

/*
Chèn dữ liệu mới: Thêm sinh viên “Phan Hoàng Nam”, giới tính Nam, sinh năm 2003, ngành CNTT, GPA 3.8

Cập nhật dữ liệu: Sinh viên “Lê Quốc Cường” vừa cải thiện học lực, cập nhật gpa = 3.4

Xóa dữ liệu: Xóa tất cả sinh viên có gpa IS NULL

Truy vấn cơ bản: Hiển thị sinh viên ngành CNTT có gpa >= 3.0, chỉ lấy 3 kết quả đầu tiên

Loại bỏ trùng lặp: Liệt kê danh sách ngành học duy nhất

Sắp xếp: Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên

Tìm kiếm: Tìm sinh viên có tên bắt đầu bằng “Nguyễn”

Khoảng giá trị: Hiển thị sinh viên có năm sinh từ 2001 đến 2003
*/



insert into students (id, full_name, gender, birth_year, major, gpa) values
(8, 'Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

update students
set gpa = 3.4
where id = 3;

delete from students 
where gpa is null;

select *
from students
where gpa >= 3.0 /* order by full_name asc */ limit 3;

select distinct major
from students;

select *
from students
where major = 'CNTT'
order by gpa desc, full_name asc;

select *
from students
where full_name ilike 'Nguyễn%';

select *
from students
where birth_year between 2001 and 2003;
