-- Thêm cột genre (varchar) vào bảng Books
ALTER TABLE library.books
ADD COLUMN genre varchar(50);

-- Đổi tên cột available thành is_available
ALTER TABLE library.books
RENAME COLUMN available TO is_available;

-- Xóa cột email khỏi bảng Members
ALTER TABLE members
DROP COLUMN email;

-- Xóa bảng OrderDetails khỏi schema sales
DROP TABLE sales.orderdetails;
