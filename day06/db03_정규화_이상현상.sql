-- 계절학기 테이블이 있는지 삭제해봄
DROP TABLE IF EXISTS Summer; -- 기존 테이블이 존재하면 삭제

-- 계절학기 테이블 생성
CREATE TABLE Summer(
	   sid INTEGER
     , class VARCHAR(20)
     , price INTEGER
);

-- 기본데이터 추가(MySQL에서만 가능, 한줄에 다중데이터 INSERT)
INSERT INTO Summer VALUES(100, 'JAVA', 20000), (150, 'PYTHON', 15000), (200, 'C', 10000), (250, 'JAVA', 20000);

-- 계절학기 듣는 학생의 학번과 수강과목
SELECT sid
     , class
  FROM Summer;

-- c강좌 수강료는?
SELECT price
  FROM Summer
 WHERE class LIKE '%C%';
 
-- 수강료가 가장 비싼 과목은?
SELECT DISTINCT(class)
  FROM Summer
 WHERE price = (SELECT MAX(price)
				  FROM Summer);

-- 계절학기를 듣는 학생 수와 수강료 총액은?
SELECT COUNT(*) AS '학생수'
     , SUM(price) AS '수강료 총액'
  FROM Summer;

SET SQL_SAFE_UPDATES = 0; -- 안전모드풀기
SET SQL_SAFE_UPDATES = 1; -- 안전모드하기
/*이상현상(abnormal)*/

/*삭제이상*/
-- 7-1 : 200번 학생의 계절학기 수강신청을 취소하시오.
DELETE FROM Summer WHERE sid=200;

-- C강좌 수강료를 찾을 수 없다
SELECT 	price
FROM 	Summer
WHERE 	class LIKE '%C%';

/*삽입이상*/
INSERT INTO Summer VALUES (NULL, 'C++', 25000);

SELECT COUNT(*)
  FROM Summer;
  
SELECT COUNT(sid)
  FROM Summer;
  
-- 수정이상
UPDATE Summer SET
 price = 15000
 WHERE sid = 100;
 
-- 끝나서 데이터 다 날림
DELETE FROM Summer;