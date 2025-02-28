-- 내장함수
-- 4-1 : -78과 78의 절대값을 구하시오
SELECT abs(-78), abs(78);

-- 4-2 : 4.875를 소수 첫째 자리까지 반올림하시오.
SELECT round(4.875, 1) as 결과;

-- 4-3 : 고객별 평균 주문 금액을 백 원 단위로 반올림한 값을 구하시오.
SELECT custid, ROUND(sum(saleprice) / COUNT(*), -2) AS '평균금액'
  FROM Orders
 GROUP BY custid;
 
-- 문자열 내장함수
-- 4-4 : 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오.
-- REPLACE는 단지 출력할 당시만 바뀌어 보이는 것
SELECT bookid
	 , replace(bookname, '야구', '농구') as bookname
	 , publisher
	 , price
  FROM Book;
  
-- 추가
SELECT 'Hello' 'MySQL';

SELECT CONCAT('Hello', 'MySQL', 'WOW') as '문자열 합치기';

-- 4-5 : 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 확인하시오.
SELECT bookname AS '제목'
	 , char_length(bookname) as '제목의 글자 수' -- 글자 길이를 구할때 char_length
	 , length(bookname) as '제목의 바이트 수' -- 바이트 수를 구할때 length -- utf8에서 한글 한글자당 바이트 수는 3bytes
  FROM Book
 WHERE publisher = '굿스포츠';
 
-- 4-6 : 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
-- SUBSTR(자르려는 원본 문자열, 시작인덱스, 길이)
-- DB는 프로그래밍언어와 다르게 인덱스가 1부터 시작!!
SELECT SUBSTR('Hello MySQL', 7, 2); -- 연습이 필요 

SELECT SUBSTR(name, 1, 1) as '성씨 구분'
	 , COUNT(*) AS '인원수'
  FROM Customer
 GROUP BY name;
 
-- 추가 : trim(), Python strip()과 동일
SELECT CONCAT('--', TRIM('     Hello!     '), '--');
SELECT CONCAT('--', LTRIM('     Hello!     '), '--');
SELECT CONCAT('--', RTRIM('     Hello!     '), '--');

-- 새롭게 추가된 trim() 함수
SELECT TRIM('=' FROM '=== -Hello!- ===');
 


-- 날짜/시간 함수
SELECT sysdate(); -- Docker 서버시간을 따라서 GMT

SELECT ADDDATE(sysdate(), interval 9 HOUR) AS '한국시간';

-- 4-7 : 마당서점은 주문일로부터 10일 후에 매출을 확정한다. 각 주문의 확정일자를 구하시오.
 SELECT orderid AS '주문번호', orderdate AS '주문일자'
	  ,	ADDDATE(orderdate, interval 10 DAY) AS '확정일자'
   FROM Orders;
   
-- 추가 : 나라별로 날짜와 시간을 나타내는 포맷팅이 다르다.
SELECT SYSDATE() AS '기본날짜/시간'
     , date_format(SYSDATE(), '%M/%d/%Y %H:%i:%s') AS '포멧팅 미국날짜';

-- 4-8 : 마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오.
--       단, 주문일은 '%Y-%m-%d' 형태로 표시한다.
--       %Y = 년도전체(20xx), %y = 년도 뒤2자리만(14), %M = 월이름(July), %b = 월의 약어(Jul), %m = 월숫자(07)
-- 		 %d = 일(04), %H = 시간(16), %h = 오후도(04), %W = 요일(Monday), %w = 1(요일은 일요일0부터 시작)
-- 		 %p = AM/PM
SELECT orderid AS '주문번호'
	 , date_format(orderdate, '%Y/%m/%d') AS '주문일'
     , custid AS '고객번호'
     , bookid AS '도서번호'
  FROM Orders;

-- DATEDIFF: D-DAY
SELECT datediff(sysdate(), '2025-02-03') AS 'D-DAY';

-- Formatting, 1000 단위마다 (,) 넣기
SELECT bookId
	 , FORMAT(price,0) AS price
  FROM MyBook;

-- NULL = Python NONE과 동일. 모든 다른 프로그래밍언어에서는 전부 NULL, NUL 사용
-- 추가 : 금액이 null일 때 발생되는 현상
SELECT price - 5000
  FROM MyBook
 WHERE bookId = 3;

-- 레전드 핵심 : 집계함수가 다 꼬임
SELECT SUM(price)   AS '합산은 그닥 문제없음'
	 , AVG(price)   AS '평균은 NULL이 빠져서 꼬임'
	 , COUNT(*)     AS '모든 행의 갯수는 일치'
	 , COUNT(price) AS 'NULL값은 갯수에서 빠짐'
  FROM MyBook;

-- NULL값 확인 : NULL은 비교연산자 (=, >, <, <>, ...)사용불가
SELECT *
  FROM MyBook
 WHERE price IS NULL; -- 반대는 IS NOT NULL(NULL이 아닌 것을 구함)
 
SELECT *
  FROM MyBook
 WHERE bookname = '';

-- IFNULL 함수
SELECT bookId
	 , bookName
	 , IFNULL(price, 0) AS price
  FROM MyBook;
 
-- 4-10 : 이름, 전화번호가 포함된 고객목록을 보이시오. 
-- 		  단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시한다.
SELECT name AS '이름', IFNULL(phone, '연락처없음') AS '전화번호'
  FROM Customer;