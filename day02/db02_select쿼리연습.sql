-- 쿼리 3-1 : 모든 도서의 이름과 가격을 검색하시오
SELECT bookname, price
  FROM Book;
 
-- 워크벤치에서 쿼리 실행할 땐 편함
SELECT *
  FROM Book;
  
-- 3-2 : 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
-- 파이썬, C#등 프로그래밍언어로 가져갈땐, 컬럼이름 컬럼갯수를 모두 파악해야 하기때문에 아래와 같이 사용
SELECT bookid, bookname, publisher, price
  FROM Book;
  
-- 3-3 : 도서 테이블에 있는 모든 출판사를 검색하시오.
SELECT publisher
  FROM Book;
-- 출판사별로 한번만 출력하면 좋음  
-- ALL - 전부다, DISTINCT - 중복제거하고 하나만
SELECT DISTINCT
	   publisher
  FROM Book;

-- 3-4 : 가격이 20000원 미만인 도서를 검색하시오.
-- | > 미만 | < 초과 | >= 이하 | <= 이상 | <>같지 않다 | != 같지않다 | = 같다(프로그래핑언어와 차이)
SELECT *
  FROM Book
 WHERE price < 20000;
 
SELECT *
  FROM Book
 WHERE price < 20000 
   AND publisher = '굿스포츠';
 
-- 3-5 : 가격이 10000원 이상 20000원 이하인 도서를 검색하시오.
SELECT *
  FROM Book
 where price between 10000 and 20000;
-- 연산자 활용
SELECT *
  FROM Book
 where price >= 10000
   and price <= 20000;
 
-- 3-6 : 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE publisher IN ('굿스포츠','대한미디어');
-- 위 두 출판사가 아닌경우
SELECT *
  FROM Book
 WHERE publisher NOT
	IN ('굿스포츠','대한미디어');
    
-- 3-7 : '축구의 역사'를 출간한 출판사를 검색하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname like '축구의 역사';

-- 패턴 --
-- %     : 갯수와 상관없이 글자가 포함되는 것
-- []    : 은 Oracle, SQL Server
-- [0-5] : 1개의 문자가 일치, 한 글자 0에서 5의 숫자를 포함한다
-- [^]   : 1개의 문자가 일치하지 않는 것
-- _     : 특정위치의 1개의 문자가 일치할 때(_구% : 첫번째 글자는 뭐든지 상관없고, 두번째 글자가 구로되고 뒤에 글이 더있다.)

-- 3-8 : 도서이름에 '축구'가 포함된 출판사를 검색하시오.
SELECT bookname, publisher
  FROM Book
 WHERE bookname like '%축구%';
 
-- 3-9 : 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE bookname LIKE '_구%';

-- 추가 : 고객중에서 전화번호가 없는 사람을 검색하시오.
SELECT *
  FROM Customer
 WHERE phone IS NULL;

SELECT *
  FROM Customer
 WHERE phone IS NOT NULL;
 
-- 3-10 : 축구에 관한 도서 중 가격이 20000원 이상인 도서를 검색하시오.
select *
  FROM Book
 WHERE bookname LIKE '%축구%' AND price >= 20000;
 
-- 3-11 : 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오.
SELECT *
  FROM Book
 WHERE publisher='굿스포츠' OR publisher='대한미디어';
 
-- 3-12 : 도서를 이름순으로 검색하시오.
SELECT *
  FROM Book
 ORDER BY bookname;

-- 3-13 : 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT *
  FROM Book
 ORDER BY price, bookname;

-- 3-14 : 도서를 가격의 내림차순으로 검색하시오.(만약, 가격이 같다면 출판사의 오름차순으로 검색한다.)
-- ASC(오름차순, ending), DESC(내림차순, ending) - 평상시 오름차순은 생략
SELECT *
  FROM Book
 ORDER BY price DESC, publisher;