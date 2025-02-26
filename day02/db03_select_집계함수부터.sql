-- 3-15 : 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice)
  FROM Orders;
 
-- MySQL 문자열은 '홑따옴표 사용("쌍따옴표 사용불가!!)
  
-- 의미 있는 열 이름 출력
SELECT SUM(saleprice) AS 총매출
  FROM Orders;
  
-- 3-16 : 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(saleprice) AS 총매출
  FROM Orders
 WHERE custid=2;
 
-- 3-17 : 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT SUM(saleprice) AS Total    	-- 합계
	 , AVG(saleprice) AS Average  	-- 평균
	 , MIN(saleprice) AS MinPrice	-- 최소
	 , MAX(saleprice) AS MaxPrice	-- 최대
     , STD(saleprice) AS StandardV  -- 표준편차
  FROM Orders;
-- 쉼표를 앞에 넣어야 한줄 지우기가 편함

-- 3-18 : 마당서점의 도서 판매 건수를 구하시오.
SELECT count(*) AS 판매건수
  FROM Orders;

-- 여러사람을 출력할 때 GROUP BY 그룹화 키워드 사용
-- 3-19 : 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
-- GROUP BY를 사용하려면 반드시 집계함수 및 GROUP BY에 포함된 컬럼이 SELECT안에 들어가 있어야함.
-- GROUP BY에 있는 컬럼만 SELECT 안에 사용할 수 있음. 그 외는 사용불가
SELECT custid
	   , count(custid) AS 구매도서수량 -- 함수의 매개변수로 *, custid 상관없이 사용가능
       , SUM(saleprice) AS 고객별총액  -- sum은 *이 불가능
  FROM Orders
 GROUP BY custid;

-- 추가 : 3-19의 내용에서 고객별 총액을 내림차순으로 출력하시오.
SELECT custid
	   , count(custid) AS 구매도서수량
       , SUM(saleprice) AS 고객별총액 
  FROM Orders
 GROUP BY custid
 ORDER BY 3 DESC; -- 고객별총액을 내림차순으로 -- 숫자 3은 고객별총액을 나타냄(1을 사용하면 custid를 내림차순으로)

-- 3-20 : 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별(GROUP BY) 주문 도서의 총 수량을 구하시오.(단, 두 권 이상 구매한 고객에 대해서만 한정합니다.)
-- COUNT() 등 집계함수는 WHERE에 넣을 수 없음
SELECT custid
	   , count(*) AS 총수량
  FROM Orders
 WHERE saleprice >= 8000
 GROUP BY custid
HAVING count(*) >= 2; -- COUNT(*)와 별명(총수량)을 사용할 수 있음.
  
-- 추가 : 고객별 구매수량과 구매총액을 출력하고, 전체를 합산하여 통계를 표시하세요.
SELECT custid
	 , count(*) AS 구매도서수량
     , SUM(saleprice) AS 고객별총액
 FROM Orders
GROUP BY custid
 WITH ROLLUP;

-- JOIN : 두개이상의 테이블을 합쳐서 출력
-- 3-21 : 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
SELECT *
  FROM Customer
 INNER JOIN Orders
	ON Customer.custid = Orders.custid; -- 커스토머의custid와 오더스의custid로 비교
    
-- 추가 : 생략형 쿼리
SELECT *
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;
 
-- 추가 : 중복되거나 필요없는 컬럼은 제거하고 출력
SELECT Customer.custid
	 , Customer.name
     , Customer.address
     , Orders.orderid
     , Orders.saleprice
     , Orders.orderdate
  FROM Customer, Orders
 WHERE Customer.custid = Orders.custid;
 
-- 추가 : 테이블명을 줄여서 별명으로 사용
SELECT c.custid
	 , c.name
     , c.address
     , o.orderid
     , o.saleprice
     , o.orderdate
  FROM Customer AS c, Orders AS o -- 별명 지어주기
 WHERE c.custid = o.custid;
 
-- 추가 : 칠요하면 테이블 조인하면 됨
 SELECT c.custid
	 , c.name
     , c.address
     , o.orderid
     , o.saleprice
     , o.orderdate
     , b.bookname
     , b.publisher
     , b.price
  FROM Customer AS c, Orders AS o, Book AS b -- 별명 지어주기
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid;
 
-- 3-22 : 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오.
SELECT c.*
	 , o.*
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
 ORDER BY c.name ASC;
 
-- 추가 : 고객번호 순 정렬
SELECT c.*
	 , o.*
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
 ORDER BY c.custid; -- ASC(오름차순) 생략

-- 3-23 : 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name, saleprice
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid;

-- 3-24 : 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT name, SUM(saleprice)
  FROM Customer AS c, Orders AS o
 WHERE c.custid = o.custid
 GROUP BY c.name
 ORDER BY c.name;

-- 3-25 : 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT c.name, b.bookname
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND o.bookid = b.bookid;

-- 3-26 : 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT c.name, b.bookname
  FROM Customer AS c, Orders AS o, Book AS b
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid -- JOIN을 위한 조건
   AND b.price = 20000; -- 나머지 조건들...

-- 외부조인 : 조건을 만족하지 않는(일치하지 않는) 데이터도 출력이 필요할 때 사용하는 조인

-- 3-27 : 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
-- LEFT OUTER JOIN 또는 RIGHT OUTER JOIN - LEFT, RIGHT는 기준이 되는 테이블 위치
SELECT *
  FROM Customer AS c
  LEFT JOIN Orders AS o -- Customer Table에 있는데 Orders Table에 없는것도 출력 -- LEFT OUTER JOIN Orders AS o
	ON c.custid = o.custid;

-- 추가 : RIGHT ORDER JOIN오르 하면??
SELECT *
  FROM Customer AS c
  RIGHT JOIN Orders AS o  -- RIGHT == Orders -- 주문이 없는 박세리는 사라짐
	ON c.custid = o.custid;

-- 서브쿼리(부속질의)
SELECT *
  FROM Book
 WHERE price = 35000 ; -- 가장 비싼이 아닌 35000원 책을 찾는 것

-- 3-28 : 가장 비싼 도서의 이름을 보이시오.
SELECT bookname AS 가장비싼도서
  FROM Book
 WHERE price = (
SELECT MAX(price)
  FROM Book
);
                
-- 3-29 : 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT name
  FROM Customer AS c
 WHERE custid IN (
SELECT distinct custid FROM Orders -- 주문을 한 고객의 중복제거정보
);
 
-- 3-30 : 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT *
  FROM Customer AS c
 WHERE c.custid IN (
					SELECT o.custid
					  FROM Orders AS o
					 WHERE o.bookid IN (
										SELECT b.bookid
										  FROM Book AS b
										 WHERE publisher = '대한미디어'
                                         )
					);
                    
-- 3-30은 JOIN으로 변경 가능(SubQuery <-> Join)
SELECT c.name
  FROM Customer AS c, Book AS b, Orders AS o
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid
   AND b.publisher = '대한미디어';
   
-- 3-31 : 출판사별로 출판사의 평균도서가격보다 비싼 도서를 구하시오.
-- 상관 서브쿼리.
SELECT *
  FROM Book AS b1
 WHERE b1.price > (
			SELECT AVG(b2.price)
			  FROM Book AS b2
		     WHERE b2.publisher = b1.publisher);

SELECT AVG(b2.price)
	 , b2.publisher
  FROM Book AS b2
 WHERE b2.publisher = '대한미디어'
 GROUP BY b2.publisher;

-- 집합연산
SELECT name
  FROM Customer
 UNION
SELECT bookname
  FROM Book;

-- 타입에 제약이 없음
SELECT name
  FROM Customer
 UNION
SELECT orderdate
  FROM Orders;
  
-- EXISTS : 상관서브쿼리에서 사용하는 키워드
-- 주문이 있는 고객의 이름과 주소를 나타내시오.
SELECT *
  FROM Customer AS c
 WHERE EXISTS(
			SELECT *
			  FROM Orders AS o
			 WHERE o.custid = c.custid -- 메인쿼리의 컬럼이 서브쿼리에 사용되고 있음
			);
  
-- 3-32 : 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 보이시오.
SELECT name
  FROM Customer
 WHERE address LIKE '대한민국%'
 UNION  
SELECT name
  FROM Customer
 WHERE custid IN (SELECT custid FROM Orders);