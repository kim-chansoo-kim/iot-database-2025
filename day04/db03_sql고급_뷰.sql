-- 뷰
-- DDL CREATE로 뷰를 생성
-- 생성과 수정을 동시에 하는게 좋다! CREATE OR REPLACE
CREATE OR REPLACE VIEW V_orders
	AS 
SELECT o.orderid
	 , c.custid
     , b.bookid
     , c.name
     , b.bookname
     , b.price
     , o.saleprice
     , o.orderdate
  FROM Customer AS c, Book AS b, Orders AS o
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid;

-- 뷰실행 - 위의 조인쿼리 실행
-- SQL 테이블로 할 수 있는 쿼리는 다 실행가능
SELECT *
  FROM V_orders
 WHERE name = '장미란';

-- 4-20 : 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 
-- 		  뷰의 이름은 vw_Customer로 설정하시오.
CREATE VIEW vw_Customer
	AS
SELECT *
  FROM Customer
 WHERE address LIKE '%대한민국%';

SELECT *
  FROM vw_Customer;
  
-- 추가 : 뷰로 insert할 수 있음!! UPDATE 및 DELETE 가능
-- 단, 뷰의 테이블이 하나여야 함. 관계에서 자식테이블의 뷰는 insert불가
INSERT INTO vw_Customer
VALUES (7, '손흥민', '영국 런던', '010-9999-0099');

-- 뷰 삭제 - 간단 -
-- 4-23 : 앞서 생성한 뷰 vw_Customer를 삭제하시오.
DROP VIEW vw_Customer;