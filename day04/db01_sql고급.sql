-- 행번호
-- 4-11 : 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오. 
   SET @seq:=0; -- 변수선언 SET시작하고 @를 붙임. 값할다이 = 이퀄이 아니고 :=이다.
SELECT (@seq:=@seq+1) AS '행번호' 
	 , custid AS '고객번호'
     , name AS '이름'
     , phone AS '전화번호'
  FROM Customer
 WHERE @seq <= 2;

-- 추가 : 더 간단하게 seq를 생략
SELECT custid AS '고객번호'
     , name AS '이름'
     , phone AS '전화번호'
  FROM Customer LIMIT 2; -- 일부 데이터만 순차적으로 추출할 떄 훨씬 탁월

-- 특정범위 추출 : 3번째 행 다음부터 2개를 추출
SELECT custid AS '고객번호'
     , name AS '이름'
     , phone AS '전화번호'
  FROM Customer LIMIT 2 OFFSET 3; 