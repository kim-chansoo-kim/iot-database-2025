-- INSERT
-- 3-44 : Book 테이블에 새로운 도서 ‘스포츠 의학’도서를 추가하세요. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 90,000원이다.
INSERT INTO Book (bookid, bookname, publisher, price)
	   VALUES(11, '스포츠 의학', '한솔의학서적', 90000);
       
SELECT * FROM Book;
       
-- 컬럼명 생략가능
INSERT INTO Book VALUES (12, '스타워즈 아트북', '디즈니', 1500000);

INSERT INTO Book VALUES (12, '어벤져스 스토리', '디즈니', 50000);

-- 다중 데이터 입력
INSERT INTO Book (bookid, bookname, publisher, price)
VALUES  (13, '기타교본 1', '지미 핸드릭스', 12000)
	  , (14, '기타교본 2', '지미 핸드릭스', 12000)
	  , (15, '기타교본 3', '지미 핸드릭스', 12000);

-- 3-46 : Imported_Book에 있는 데이터를 Book 테이블에 데이터를 모두 삽입하시오.
-- 한 테이블에 있는 많은 데이터를 다른 테이블로 복사하는 데 가장 효과적인 방법
INSERT INTO Book (bookid, bookname, publisher, price)
SELECT bookid, bookname, publisher, price
  FROM Imported_Book;
  
-- 추가 : 테이블의 숫자형 타입인 PK값이 자동으로 증가하도록 만들고 사용하려면...
CREATE TABLE NewBook (
	bookid 	  INTEGER PRIMARY KEY AUTO_INCREMENT, -- AUTO_INCREMENT 는 숫자 자동증가 조건
    bookname  VARCHAR(50) NOT NULL,
    publisher VARCHAR(50) NOT NULL,
    price     INT 		  NULL -- null생략가능
);

-- 자동증가에는 pk 컬럼을 사용하지 않음!
INSERT INTO NewBook (bookname, publisher, price)
VALUES  ('알라딘 아트북', '디즈니', 100000);

SELECT * FROM NewBook;

DELETE FROM NewBook WHERE bookid = 4;

-- PK 자동증가는 편리하지만 지워진 PK를 다시 쓸 수 없음. RDB의 규칙떄문에
-- INSERT시 자동증가 컬럼은 코드에 기입하지 않음

-- UPDATE
-- 3-47 : Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오.
SELECT * FROM Customer;

UPDATE Customer
   SET
		address = '대한민국 부산'
 WHERE custid = 5;
 
-- 3-48 : Book 테이블에서 14번 ‘스포츠 의학’의 출판사를 
--        imported_book 테이블의 21번 책의 출판사와 동일하게 변경하시오.
-- 1 Book 테이블에 14번의 기존 데이터 확인
SELECT *
  FROM Book
 WHERE bookid = 14;
-- 2 바꿀데이터의 출판사 확인
SELECT * 
  FROM Imported_Book
 WHERE bookid = 21;
-- 3 UPDATE쿼리 작성
UPDATE Book
   SET bookname = '스포츠 의학'
     , publisher = (SELECT publisher 
					  FROM Imported_Book
				     WHERE bookid = 21)
 WHERE bookid = 14;
 
-- 추가 : 데이터 수정시 조심할 것!
SELECT *
  FROM NewBook;

-- WHERE 절 없이 UPDATE 절대 하지말것(자살 및 회사에서 타살 할지도....)
UPDATE NewBook
   SET price = 100000
 WHERE bookid = 3;

-- DELETE 데이터 삭제
-- 3-49 : Book 테이블에서 도서번호가 11인 도서를 삭제하시오.
DELETE FROM Book
 WHERE bookid = '15';
 
-- 데이터를 지운 후 항상 확인필요
SELECT *
FROM Book;

-- 3-50 NewBook의 모든 데이터를 삭제하시오.
-- 어디가서도 이거 절대 하지마세요 진짜로!!
DELETE FROM NewBook;