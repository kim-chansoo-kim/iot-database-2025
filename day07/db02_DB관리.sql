-- 데이터베이스 관리
SHOW DATABASES;

-- information_schema, performance_schema, mysql 등은 시스템 DB라서 개발자, DBA 사용하는 게 아님
use madang;

-- 하나의 DB내에 존재하는 테이블들만 확인
show tables;

-- 테이블의 구조
desc madang.NewBook;

select * from V_orders;

-- 사용자 추가
-- madang 데이터베이스만 접근할 수 있는 사용자 madang을 생성
-- 내부 접속용
create user madang@localhost IDENTIFIED by 'madang';
-- 외부 접속용
create user madang@'%' IDENTIFIED by 'madang';

-- DCL : GRANT(권한 주기), REVOKE
-- 데이터 삽입, 조회, 수정만 권한을 부여
grant select, insert, update on madang.* to madang@localhost with GRANT OPTION;
grant select, insert, update on madang.* to madang@'%' with GRANT OPTION;
FLUSH PRIVILEGES;

-- 사용자 madang에게 madang DB를 사용할 수 있는 모든 권한 부여
grant all PRIVILEGES on madang.* to madang@localhost with GRANT OPTION;
grant all PRIVILEGES on madang.* to madang@'%' with GRANT OPTION;
FLUSH PRIVILEGES;

-- 권한해제
-- madang사용자의 권한중 select 권한만 제거
REVOKE SELECT on madang.* from madang@localhost;
REVOKE all PRIVILEGES on madang.* from madang@localhost;
REVOKE all PRIVILEGES on madang.* from madang@'%';
FLUSH PRIVILEGES;