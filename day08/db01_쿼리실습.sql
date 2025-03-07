-- 실무실습 계속

-- 서브쿼리 계속
/* 문제 1 - 사원의 급여 정보중 업무별(job) 최소 급여를 받는 사원의 성과 이름(name으로 별칭), 업무, 급여, 입사일로 출력(21행)
*/
desc jobs;
SELECT * FROM jobs;

SELECT concat(e1.first_name, ' ', e1.last_name) as 'name' 
	 , e1.job_id
	 , e1.salary
	 , e1.hire_date
  FROM employees AS e1
 WHERE (e1.job_id, e1.salary) in (SELECT e.job_id
									   , min(e.salary) AS salary
									FROM employees as e
								   GROUP BY e.job_id);

-- 집합연산자 : 테이블 내용을 합쳐서 조회

-- 조건부 논리 표현식 제어 - CASE -> if 문이랑 동일
/* 샘플문제1 - 프로젝트 성공으로 급여인상이 결정됨
			   사원은 현재 107명이며 19개 업무에 소속되어 근무중. 
               회사 업무 Distict job_id 5개 업무에서 일하는 사원
               HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%) - 5개 분야 제외 모두 동결(107행)
*/
SELECT employee_id
	 , concat(first_name, ' ', last_name) as 'name' 
     , job_id
     , salary
     , CASE job_id WHEN 'HR_REP' THEN 1.10 * salary
				   WHEN 'MK_REP' THEN 1.12 * salary
				   WHEN 'PR_REP' THEN 1.15 * salary
				   WHEN 'SA_REP' THEN 1.18 * salary
				   WHEN 'IT_PROG' THEN 1.20 * salary
				   else salary
       end AS "New Salary"
  FROM employees;
  
/* 문제3 - 월별로 입사한 사원수가 아래와 같이 행별로 출력되도록 하시오(12행)
*/
-- 형변환 함수 cast(), convert()

SELECT cast('-09' AS unsigned); -- unsigned(양수포함 함수형) 
SELECT convert('-09', signed); -- signed(음수포함숫자형) 
SELECT convert(00009, CHAR);
SELECT convert('20250307', date);

-- 컬럼을 입사일 중 월만 추출해서 숫자로 변경
SELECT CONVERT(date_format(hire_date, '%m'), signed) AS '입사월'
  FROM employees;
  
-- CASE문 사용 1월부터 12월까지 EXPAND
SELECT case CONVERT(date_format(hire_date, '%m'), signed) when 1 then count(*) else 0 end AS '1월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 2 then count(*) else 0 end AS '2월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 3 then count(*) else 0 end AS '3월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 4 then count(*) else 0 end AS '4월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 5 then count(*) else 0 end AS '5월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 6 then count(*) else 0 end AS '6월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 7 then count(*) else 0 end AS '7월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 8 then count(*) else 0 end AS '8월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 9 then count(*) else 0 end AS '9월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 10 then count(*) else 0 end AS '10월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 11 then count(*) else 0 end AS '11월'
	 , case CONVERT(date_format(hire_date, '%m'), signed) when 12 then count(*) else 0 end AS '12월'
  FROM employees
 GROUP BY CONVERT(date_format(hire_date, '%m'), signed)
 ORDER BY CONVERT(date_format(hire_date, '%m'), signed);

-- GROUP BY 오류코드 해결법
-- (Error Code: 1055. Expression #2 of SELECT list is not in 
-- GROUP BY clause and contains nonaggregated column 'hr.employees.hire_date'
-- which is not functionally dependent on columns in GROUP BY clause;
-- this is incompatible with sql_mode=only_full_group_by)
 select @@sql_mode;
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- ROLLUP
/* 샘플 - 부서와 업무별 급여합계를 구하고 신년도 급여수준 레벨을 지정 하려고함
		  부서 번호와 업무를 기본으로 전체 행을 그룹별로 나누어 급여합계와 인원수를 출력(20행)
*/
SELECT department_id
     , job_id 
     , concat('$',format(sum(salary), 0)) AS 'Salary SUM'
     , count(employee_id) AS 'COUNT EMPs'
  FROM employees
 GROUP BY department_id, job_id
 ORDER BY department_id;
 
-- 각 총계
SELECT department_id
     , job_id 
     , concat('$',format(sum(salary), 0)) AS 'Salary SUM'
     , count(employee_id) AS 'COUNT EMPs'
  FROM employees
 GROUP BY department_id, job_id
  WITH ROLLUP; -- group by의 컬럼이 하나면 총계는 하나, 컬럼이 두개면 첫번째 컬럼별로 소계, 두 컬럼의 합산이 총계로

/* 문제1 - 이전문제를 활용, 집계결과가 아니면(ALL DEPTs)라고 출력, 업무에 대한 집계결과가 아니면(ALL JOBs)를 출력
		   ROLLUP으로 만들어진 소계면 (ALL JOBs), 총계면 (ALL DEPTs)
*/
SELECT CASE GROUPING(department_id) when 1 then '(ALL DEPTs)' else ifnull(department_id, '부서없음') end AS 'Dept#'
     , CASE GROUPING(job_id) when 1 then '(ALL JOBs)' else job_id end AS 'JOBs'
     , concat('$',format(sum(salary), 0)) AS 'Salary SUM'
     , count(employee_id) AS 'COUNT EMPs'
     -- , GROUPING(department_id) -- GROUP BY와 ROLLUP을 사용할 때 GROUPING이 어떻게 되는지 확인하는 함수
	 -- , GROUPING(job_id)
     , FORMAT(AVG(salary) * 12, 0) AS 'Avg Ann_sal'
  FROM employees
 GROUP BY department_id, job_id
  WITH ROLLUP;
  
-- RANK
/* 샘플 - 분석함수 NTILE() 사용, 부서별 급여 합계를 구하시오. 급여가 제일 큰 것이 1, 제일 작은 것이 4가 되도록 등급을 나눔(12행)
*/
SELECT department_id
	 , sum(salary) AS 'Sum Salary'
     , NTILE(4) over (ORDER BY sum(salary) desc) AS 'Bucket#' -- 범위별로 등급을 매기는 키워드(NTILE)와 기능
  FROM employees
 GROUP BY department_id;
 
/* 문제1 - 부서별 급여를 기준으로 내림차순 정렬, 이때 다음 세가지 함수를 이용하여 순위를 출력하시오(107행)
*/
SELECT employee_id
	 , last_name
     , concat('$', round(salary, 0)) AS 'salary'
     , department_id
     , rank() over (PARTITION BY department_id ORDER BY salary desc) AS 'Rank' -- 1, 1, 3 1등이 둘이면 3등으로 순위매기기 rank
     , dense_rank() over (PARTITION BY department_id ORDER BY salary desc) AS 'Dense_Rank' -- 1, 1, 2 순위매기기 dense_rank
     , ROW_NUMBER() over (PARTITION BY department_id ORDER BY salary desc) AS 'Row_Number' -- 그냥 행번호 매기기
  FROM employees
 ORDER BY department_id asc ,salary desc;