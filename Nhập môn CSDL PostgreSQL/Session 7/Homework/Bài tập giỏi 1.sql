create table post ( 
	post_id serial primary key, 
	user_id int not null, 
	content text, 
	tag text[], 
	create_at timestamp default current_timestamp, 
	is_public boolean default true 
); 

create table post_like ( 
	user_id int not null, 
	post_id int not null, 
	like_at timestamp default current_timestamp, 
	primary key (user_id, post_id) 
);

INSERT INTO post (user_id, content, tag, create_at, is_public) VALUES
(1, 'Tôi rất thích du lịch Đà Lạt', ARRAY['travel','dalat'], NOW() - INTERVAL '1 day', true),
(2, 'Ẩm thực Sài Gòn rất phong phú', ARRAY['food','saigon'], NOW() - INTERVAL '2 days', true),
(3, 'Chuyến du lịch Hà Nội thật tuyệt', ARRAY['travel','hanoi'], NOW() - INTERVAL '3 days', true),
(4, 'Học lập trình PostgreSQL', ARRAY['tech','database'], NOW() - INTERVAL '10 days', true),
(5, 'Du lịch biển Nha Trang', ARRAY['travel','beach'], NOW() - INTERVAL '5 days', true),
(6, 'Review quán cafe đẹp', ARRAY['cafe','review'], NOW() - INTERVAL '7 days', true),
(7, 'Chia sẻ kinh nghiệm du lịch tiết kiệm', ARRAY['travel','tips'], NOW() - INTERVAL '1 day', true),
(8, 'Bài viết riêng tư', ARRAY['private'], NOW() - INTERVAL '2 days', false),
(9, 'Du lịch Phú Quốc mùa hè', ARRAY['travel','phuquoc'], NOW() - INTERVAL '4 days', true),
(10, 'Học SQL cơ bản', ARRAY['tech','sql'], NOW() - INTERVAL '15 days', true),
(11, 'Du lịch Nhật Bản', ARRAY['travel','japan'], NOW() - INTERVAL '6 days', true),
(12, 'Ăn uống healthy', ARRAY['food','healthy'], NOW() - INTERVAL '8 days', true),
(13, 'Du lịch Hàn Quốc', ARRAY['travel','korea'], NOW() - INTERVAL '2 days', true),
(14, 'Chạy bộ mỗi ngày', ARRAY['fitness'], NOW() - INTERVAL '3 days', true),
(15, 'Du lịch châu Âu', ARRAY['travel','europe'], NOW() - INTERVAL '20 days', true),
(16, 'Tips học nhanh SQL', ARRAY['tech','tips'], NOW() - INTERVAL '9 days', true),
(17, 'Du lịch Singapore', ARRAY['travel','singapore'], NOW() - INTERVAL '1 day', true),
(18, 'Bài viết nội bộ', ARRAY['internal'], NOW() - INTERVAL '2 days', false),
(19, 'Du lịch Thái Lan', ARRAY['travel','thailand'], NOW() - INTERVAL '6 days', true),
(20, 'Kinh nghiệm phượt Việt Nam', ARRAY['travel','phuot'], NOW() - INTERVAL '12 days', true);

INSERT INTO post_like (user_id, post_id, like_at) VALUES
(1, 2, NOW()),
(2, 1, NOW()),
(3, 1, NOW()),
(4, 3, NOW()),
(5, 5, NOW()),
(6, 7, NOW()),
(7, 9, NOW()),
(8, 11, NOW()),
(9, 13, NOW()),
(10, 15, NOW()),
(11, 17, NOW()),
(12, 19, NOW()),
(13, 4, NOW()),
(14, 6, NOW()),
(15, 8, NOW()),
(16, 10, NOW()),
(17, 12, NOW()),
(18, 14, NOW()),
(19, 16, NOW()),
(20, 18, NOW());

select * from post, post_like;



/*
1. Tối ưu hóa truy vấn tìm kiếm bài đăng công khai theo từ khóa:
   a. Tạo Expression Index sử dụng LOWER(content) để tăng tốc tìm kiếm
   b. So sánh hiệu suất trước và sau khi tạo chỉ mục

2. Tối ưu hóa truy vấn lọc bài đăng theo thẻ (tags):
   a. Tạo GIN Index cho cột tags
   b. Phân tích hiệu suất bằng EXPLAIN ANALYZE
 
3. Tối ưu hóa truy vấn tìm bài đăng mới trong 7 ngày gần nhất:
   a. Tạo Partial Index cho bài viết công khai gần đây:
   b. Kiểm tra hiệu suất với truy vấn:

4. Phân tích chỉ mục tổng hợp (Composite Index):
   a. Tạo chỉ mục (user_id, created_at DESC)
   b. Kiểm tra hiệu suất khi người dùng xem “bài đăng gần đây của bạn bè”
*/

SELECT * FROM post
WHERE is_public = true 
AND content ILIKE '%du lịch%';

CREATE INDEX idx_post_content_lower ON post (LOWER(content));

EXPLAIN ANALYZE
SELECT * FROM post
WHERE is_public = true 
AND content ILIKE '%du lịch%';
-- Tốc độ nhanh hơn gấp 3 lần



SELECT * FROM post 
WHERE tag @> ARRAY['travel'];

CREATE INDEX idx_post_tag_gin ON post USING GIN (tag);

EXPLAIN ANALYZE
SELECT * FROM post 
WHERE tag @> ARRAY['travel'];
-- Tốc độ nhanh hơn gấp đôi



CREATE INDEX idx_post_recent_public ON post (create_at DESC)
WHERE is_public = true;

EXPLAIN ANALYZE
SELECT * FROM post
WHERE is_public = true 
AND create_at >= NOW() - INTERVAL '7 days';



CREATE INDEX idx_post_user_created ON post (user_id, create_at DESC);

EXPLAIN ANALYZE
SELECT *
FROM post
WHERE user_id IN (1, 2, 3)
ORDER BY create_at DESC;
