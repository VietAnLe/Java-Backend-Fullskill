create table accounts (
    account_id serial primary key,
    owner_name varchar(100),
    balance numeric(10,2)
);

insert into accounts (owner_name, balance) values
('A', 500.00), ('B', 300.00);



/*
1. Thực hiện giao dịch chuyển tiền hợp lệ
- Dùng BEGIN; để bắt đầu transaction
- Cập nhật giảm số dư của A, tăng số dư của B
- Dùng COMMIT; để hoàn tất
- Kiểm tra số dư mới của cả hai tài khoản
*/

begin;
	-- Trừ tiền tài khoản A (account_id = 1)
	update accounts
	set balance = balance - 100
	where account_id = 1;
	
	-- Cộng tiền tài khoản B (account_id = 2)
	update accounts
	set balance = balance + 100
	where account_id = 2;
commit;

select * from accounts;



/*
2. Thử mô phỏng lỗi và Rollback
- Lặp lại quy trình trên, nhưng cố ý nhập sai account_id của người nhận
- Gọi ROLLBACK; khi xảy ra lỗi
- Kiểm tra lại số dư, đảm bảo không có thay đổi
*/

begin;
	-- Trừ tiền A
	update accounts
	set balance = balance - 100
	where account_id = 1;
	
	-- Sai tài khoản nhận (không tồn tại)
	update accounts
	set balance = balance + 100
	where account_id = 999;
rollback;

select * from accounts;