create table accounts(
    account_id serial primary key,
    account_name varchar(50),
    balance numeric
);

insert into accounts (account_name, balance) values
('A', 500), ('B', 300);


select * from accounts;

/*
1. Tạo bảng accounts:

2. Thêm 2 bản ghi vào accounts với số dư ban đầu
3. Viết một transaction:
- Kiểm tra số dư tài khoản gửi
- Nếu đủ tiền, trừ số tiền từ tài khoản gửi, cộng vào tài khoản nhận và COMMIT
- Nếu không đủ tiền, ROLLBACK
4. Thực hành chuyển tiền hợp lệ và không hợp lệ, quan sát kết quả trên bảng accounts
*/

begin;

	-- kiểm tra số dư
	do $$
	begin
	    if (select balance from accounts where account_id = 1) < 200 then
	        raise exception 'insufficient balance';
	    end if;
	end $$;
	
	-- trừ tiền A
	update accounts
	set balance = balance - 200
	where account_id = 1;
	
	-- cộng tiền B
	update accounts
	set balance = balance + 200
	where account_id = 2;

commit;



begin;

	do $$
	begin
	    if (select balance from accounts where account_id = 1) < 1000 then
	        raise exception 'insufficient balance';
	    end if;
	end $$;
	
	-- các câu dưới sẽ không chạy nếu exception xảy ra
	update accounts
	set balance = balance - 1000
	where account_id = 1;
	
	update accounts
	set balance = balance + 1000
	where account_id = 2;

rollback;
