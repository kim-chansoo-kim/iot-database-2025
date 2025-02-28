-- 5-2 : 동일한 도서가 있는지 점검한 후 삽입하는 프로시저 
delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
  myBookID 		INTEGER,
  myBookName 	VARCHAR(40), 
  myPublisher 	VARCHAR(40),
  myPrice 		INTEGER)
BEGIN
    /* 변수선언 */
    DECLARE mycount INTEGER;
    -- 1. 데이터가 존재하는 수를 파악한 후 mycount 변수에 할당
     SELECT count(*) INTO mycount
       FROM Book 
      WHERE bookname LIKE CONCAT('%', myBookName,'%');
      
	-- 2. mycount 0보다 크면 동일 도서 존재
		 IF mycount > 0 THEN
		SET SQL_SAFE_UPDATES = 0; /* DELETE, UPDATE시 safe모드 해제 */
     UPDATE Book SET price = myPrice
      WHERE bookname LIKE CONCAT('%', myBookName,'%');
  ELSE
     INSERT INTO Book(bookid, bookname, publisher, price)
	 VALUES (myBookID, myBookName, myPublisher, myPrice);
  END IF;
END;
//
delimiter ;

-- 1번째 실행
CALL BookInsertOrUpdate(33, '스포츠의 즐거움', '마당과학', 25000);

SELECT * FROM Book;

CALL BookInsertOrUpdate(33, '스포츠의 즐거움', '마당과학', 25000);