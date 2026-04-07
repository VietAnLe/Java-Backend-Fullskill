create table flights (
    flight_id serial primary key,
    flight_name varchar(100),
    available_seats int
);

create table bookings (
    booking_id serial primary key,
    flight_id int references flights(flight_id),
    customer_name varchar(100)
);

insert into flights (flight_name, available_seats) values
('VN123', 3), ('VN456', 2);

select * from flights;
select * from bookings;



/*
1. Tạo Transaction đặt vé thành công
- Bắt đầu transaction bằng BEGIN;
- Giảm số ghế của chuyến bay 'VN123' đi 1
- Thêm bản ghi đặt vé của khách hàng 'Nguyen Van A'
- Kết thúc bằng COMMIT;
- Kiểm tra lại dữ liệu bảng flights và bookings
*/

begin;
	-- Giảm số ghế
	update flights
	set available_seats = available_seats - 1
	where flight_name = 'VN123';
	
	-- Thêm booking
	insert into bookings (flight_id, customer_name)
	values (
	    (select flight_id from flights where flight_name = 'VN123'),
	    'Nguyen Van A'
	);
commit;



/*
2. Mô phỏng lỗi và Rollback
- Thực hiện lại các bước trên nhưng nhập sai flight_id trong bảng bookings
- Gọi ROLLBACK; để hủy toàn bộ thay đổi
- Kiểm tra lại dữ liệu và chứng minh rằng số ghế không thay đổi
*/

begin;
	update flights
	set available_seats = available_seats - 1
	where flight_name = 'VN123';
	
	-- Lỗi: flight_id không tồn tại
	insert into bookings (flight_id, customer_name)
	values (999, 'Tran Thi B');
rollback;
