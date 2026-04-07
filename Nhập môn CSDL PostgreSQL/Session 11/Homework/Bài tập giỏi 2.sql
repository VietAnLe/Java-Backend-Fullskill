create table accounts (
    account_id serial primary key,
    customer_name varchar(100),
    balance numeric(12,2)
);

create table transactions (
    trans_id serial primary key,
    account_id int references accounts(account_id),
    amount numeric(12,2),
    trans_type varchar(20),
    created_at timestamp default now()
);

insert into accounts (customer_name, balance) values
('a', 500.00), ('a', 300.00);

/*
Khi khách hàng rút tiền:
- Hệ thống kiểm tra số dư tài khoản
- Nếu đủ tiền, trừ số dư
- Ghi log vào bảng transactions
- Nếu ghi log thất bại, việc trừ tiền cũng phải bị hoàn tác (rollback)
 

Yêu cầu:

1. Viết Transaction thực hiện rút tiền
- Bắt đầu BEGIN;
- Kiểm tra balance của tài khoản
- Nếu đủ, trừ số dư và ghi vào bảng transactions
- Nếu bất kỳ bước nào thất bại → ROLLBACK;
- Nếu thành công → COMMIT;
 
2. Mô phỏng lỗi
- Cố ý chèn lỗi trong bước ghi log (ví dụ nhập sai account_id trong bảng transactions)
- Quan sát và chứng minh rằng sau khi ROLLBACK, số dư vẫn không thay đổi
 
3. Kiểm tra tính toàn vẹn dữ liệu
- Chạy Transaction nhiều lần, đảm bảo rằng mỗi bản ghi trong transactions tương ứng đúng với một thay đổi balance
*/


begin;
	-- Kiểm tra số dư
	do $$
	begin
	    if (select balance from accounts where account_id = 1) < 200 then
	        raise exception 'insufficient balance';
	    end if;
	end $$;
	
	-- Trừ tiền
	update accounts
	set balance = balance - 200
	where account_id = 1;
	
	-- Ghi log giao dịch
	insert into transactions (account_id, amount, trans_type)
	values (1, 200, 'withdraw');
commit;

select * from accounts;
select * from transactions;



begin;

	do $$
	begin
	    if (select balance from accounts where account_id = 1) < 100 then
	        raise exception 'insufficient balance';
	    end if;
	end $$;
	
	update accounts
	set balance = balance - 100
	where account_id = 1;
	
	insert into transactions (account_id, amount, trans_type)
	values (999, 100, 'withdraw');
	
rollback;
