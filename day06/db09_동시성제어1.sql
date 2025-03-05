-- 동시성제어
-- 자동커밋(Auto COMMIT) 해제
SET AUTOCOMMIT=0;

START TRANSACTION;

SELECT * FROM Book;

INSERT INTO Book VALUES (98, '데이터베이스', '한빛', 25000); -- 트랜잭션이 걸린상태

UPDATE Book SET
	   price = 48000
 WHERE bookid = 98;
 
COMMIT;