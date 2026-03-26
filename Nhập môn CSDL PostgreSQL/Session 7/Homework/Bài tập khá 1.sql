create table book (
	book_id serial primary key,
	title varchar(255),
	author varchar(100),
	genre varchar(50),
	price decimal(10,2),
	description text,
	create_at timestamp default current_timestamp
);

INSERT INTO book (title, author, genre, price, description)
VALUES
('Clean Code', 'Robert C. Martin', 'Programming', 35.50, 'Guide to writing clean and maintainable code'),
('The Pragmatic Programmer', 'Andrew Hunt', 'Programming', 42.00, 'Best practices for modern developers'),
('Design Patterns', 'Erich Gamma', 'Programming', 50.00, 'Reusable object-oriented software patterns'),
('Refactoring', 'Martin Fowler', 'Programming', 47.00, 'Improving design of existing code'),
('Introduction to Algorithms', 'Thomas H. Cormen', 'Programming', 80.00, 'Comprehensive algorithms textbook'),

('Atomic Habits', 'James Clear', 'Self-help', 21.99, 'Build good habits and break bad ones'),
('The Power of Habit', 'Charles Duhigg', 'Self-help', 19.50, 'Why habits exist and how to change them'),
('Think and Grow Rich', 'Napoleon Hill', 'Self-help', 15.00, 'Classic book on success mindset'),
('How to Win Friends and Influence People', 'Dale Carnegie', 'Self-help', 18.75, 'Improve communication skills'),
('The 7 Habits of Highly Effective People', 'Stephen Covey', 'Self-help', 23.00, 'Personal effectiveness framework'),

('Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance', 17.99, 'Financial education and mindset'),
('The Psychology of Money', 'Morgan Housel', 'Finance', 22.50, 'Behavioral finance insights'),
('Your Money or Your Life', 'Vicki Robin', 'Finance', 20.00, 'Transform relationship with money'),
('I Will Teach You to Be Rich', 'Ramit Sethi', 'Finance', 24.99, 'Personal finance guide'),
('The Intelligent Investor', 'Benjamin Graham', 'Finance', 30.00, 'Value investing principles'),

('1984', 'George Orwell', 'Fiction', 14.99, 'Dystopian totalitarian society'),
('Animal Farm', 'George Orwell', 'Fiction', 12.50, 'Political allegory'),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 16.99, 'Racial injustice in America'),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 13.75, 'American dream critique'),
('Pride and Prejudice', 'Jane Austen', 'Fiction', 11.99, 'Classic romance novel'),

('Sapiens', 'Yuval Noah Harari', 'History', 28.99, 'History of humankind'),
('Homo Deus', 'Yuval Noah Harari', 'History', 31.50, 'Future of humanity'),
('Guns, Germs, and Steel', 'Jared Diamond', 'History', 26.00, 'Factors shaping civilizations'),
('The Silk Roads', 'Peter Frankopan', 'History', 27.50, 'New history of the world'),
('A People’s History of the United States', 'Howard Zinn', 'History', 29.99, 'History from bottom up'),

('Deep Work', 'Cal Newport', 'Productivity', 25.00, 'Focused work in a distracted world'),
('Digital Minimalism', 'Cal Newport', 'Productivity', 23.50, 'Reduce digital clutter'),
('Getting Things Done', 'David Allen', 'Productivity', 24.00, 'Productivity system GTD'),
('Essentialism', 'Greg McKeown', 'Productivity', 21.75, 'Focus on what matters most'),
('Make Time', 'Jake Knapp', 'Productivity', 20.99, 'Practical time management'),

('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 18.00, 'Adventure in Middle-earth'),
('The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 45.00, 'Epic fantasy trilogy'),
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 'Fantasy', 20.00, 'Wizarding world begins'),
('A Game of Thrones', 'George R.R. Martin', 'Fantasy', 35.00, 'Political fantasy epic'),
('The Name of the Wind', 'Patrick Rothfuss', 'Fantasy', 22.00, 'Story of a legendary wizard'),

('Dune', 'Frank Herbert', 'Science Fiction', 24.99, 'Desert planet politics'),
('Foundation', 'Isaac Asimov', 'Science Fiction', 19.99, 'Galactic empire future'),
('Neuromancer', 'William Gibson', 'Science Fiction', 18.50, 'Cyberpunk classic'),
('Snow Crash', 'Neal Stephenson', 'Science Fiction', 21.00, 'Virtual reality and hackers'),
('The Martian', 'Andy Weir', 'Science Fiction', 23.00, 'Survival on Mars'),

('Educated', 'Tara Westover', 'Memoir', 19.00, 'Journey from isolation to education'),
('Becoming', 'Michelle Obama', 'Memoir', 26.00, 'Life of former First Lady'),
('The Diary of a Young Girl', 'Anne Frank', 'Memoir', 14.50, 'WWII diary'),
('When Breath Becomes Air', 'Paul Kalanithi', 'Memoir', 18.75, 'Doctor facing mortality'),
('Born a Crime', 'Trevor Noah', 'Memoir', 20.50, 'Life in apartheid South Africa');



-- Tạo các chỉ mục phù hợp để tối ưu truy vấn sau:
select * from book where author ilike '%Rowling%'; --174ms
select * from book where genre = 'Fantasy'; --137ms


create extension if not exists pg_trgm; -- Vì ilike '%Rowling%' không dùng được B-tree nên dùng GIN + trigram

create index idx_book_author_trgm on book using gin(author gin_trgm_ops);

create index idx_book_genre on book(genre);



-- So sánh thời gian truy vấn trước và sau khi tạo Index
EXPLAIN ANALYZE
select * from book where author ilike '%Rowling%';

EXPLAIN ANALYZE
select * from book where genre = 'Fantasy';

-- Sau khi tạo index thì kết quả cho thấy 2 câu lệnh truy vấn này chỉ còn tốn khoảng 30-40% thời gian so với trước khi tạo index 


/*
Thử nghiệm các loại chỉ mục khác nhau:
- B-tree cho genre: đã làm ở trên
- GIN cho title hoặc description (phục vụ tìm kiếm full-text)
*/

create index idx_book_description_fts on book using gin(to_tsvector('english', description));

select * from book
where to_tsvector('english', description) @@ to_tsquery('magic & wizard');



-- Tạo một Clustered Index (sử dụng lệnh CLUSTER) trên bảng book theo cột genre và kiểm tra sự khác biệt trong hiệu suất
create index idx_book_genre_cluster on book(genre);

cluster book using idx_book_genre_cluster;

EXPLAIN ANALYZE
SELECT * FROM book WHERE genre = 'Fantasy';



/*
/*
5. Viết báo cáo ngắn (5-7 dòng) giải thích:
   a. Loại chỉ mục nào hiệu quả nhất cho từng loại truy vấn?
   b. Khi nào Hash index không được khuyến khích trong PostgreSQL?

- B-tree index là lựa chọn hiệu quả nhất cho các truy vấn so sánh như = hoặc order by, ví dụ là tìm theo genre như trong bài.
- Với các truy vấn tìm kiếm chuỗi có ký tự đại diện như ilike '%keyword%', gin index kết hợp với pg_trgm sẽ hợp lí hơn.
- GIN index cũng rất phù hợp cho full-text search trên các cột như description hoặc title.
- Cluster giúp cải thiện hiệu năng truy vấn bằng cách sắp xếp lại dữ liệu vật lý theo index, hữu ích khi truy vấn thường xuyên theo một cột cụ thể.
- Hash index chỉ hỗ trợ phép so sánh bằng = và không linh hoạt như B-tree, nên ít được sử dụng. Chỉ nên cân nhắc sử dụng trên các bảng rất lớn và các truy vấn
vào cột đó chỉ sử dụng toán tử bằng.

*/

