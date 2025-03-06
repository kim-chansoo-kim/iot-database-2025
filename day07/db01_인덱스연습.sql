-- 기존 테이블 삭제
DROP TABLE if exists NewBook;

-- 테이블 생성
CREATE table NewBook(
	bookid INTEGER AUTO_INCREMENT PRIMARY KEY
  , bookname VARCHAR(100)
  , publisher VARCHAR(100)
  , price INTEGER
);

-- 500만건 더미데이터 생성 설정(cte_max_recursion_depth)
SET SESSION cte_max_recursion_depth = 5000000;

-- 더미데이터 생성
insert into NewBook (bookname, publisher, price)
with RECURSIVE cte(n) AS 
(
	SELECT 1
    UNION ALL
    SELECT n+1 FROM cte WHERE n < 5000000
)
select concat('Book', lpad(n, 7, '0')) -- ex) Book000001
	 , concat('Comp', lpad(n, 7, '0')) -- ex) Book000001
     , floor(3000 + rand() * 30000) AS price -- 책가격을 3000 ~ 33000 랜덤
  FROM cte;
  
-- 데이터 확인
select count(*) FROM NewBook;

-- 가격을 7개 정도 검색할 수 있는 쿼리 작성
SELECT * FROM NewBook
 WHERE price in (9377, 14567, 24500, 33000, 5600, 6700, 15000);
 
-- 인덱스 생성
create index idx_book on NewBook(price);