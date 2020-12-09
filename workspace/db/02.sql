-- 0. 사용할 데이터베이스 선택

USE sqldb;

-- 1. 사용자 테이블의 데이터 조회

-- DESC usertbl;

SELECT *
FROM usertbl;

-- 2. 이름이 '조용필'인 사용자 조회

SELECT *
FROM usertbl
WHERE name = '조용필'; -- 문자열과 날짜 -> ' 사용

-- 3. addr '서울'인 사용자 조회
SELECT *
FROM usertbl
WHERE addr = '서울';

-- 4. birthyear가 1970 이후인 사용자 조회
SELECT *
FROM usertbl
WHERE birthyear >= 1970;

-- 5. addr은 '서울'이고 birthyear가 1970 이후인 사용자 조회
SELECT *
FROM usertbl
WHERE addr = '서울' AND birthyear >= 1970;

-- 6. addr이 '서울'이거나 '경기'인 사용자 조회
SELECT *
FROM usertbl
WHERE addr = '서울' OR addr = '경기';

SELECT *
FROM usertbl
WHERE addr IN ('서울', '경기');

-- 7. birthyear가 1970년대인 사용자 조회
SELECT *
FROM usertbl
WHERE birthyear >= 1970 AND birthyear < 1980;

SELECT *
FROM usertbl
WHERE birthyear BETWEEN 1970 AND 1979;

-- 8-1. 임씨 성을 가진 사용자 조회 -> name이 '임...'인 사용자 조회
SELECT *
FROM usertbl
WHERE name LIKE '임%';

-- 8. 이름이 '재범'인 사용자 조회 -> name이 '...재범'인 사용자 조회
SELECT *
FROM usertbl
WHERE name LIKE '_재범';

-- 9. 이름과 날짜를 날짜순으로 정렬해서 조회
SELECT name, mDate
FROM usertbl
ORDER BY mDate DESC; -- ASC : 오름차순, DESC : 내림차순

-- 10. 이름과 키를 키순 및 이름 순으로 조회
SELECT name, height
FROM usertbl 
ORDER BY height DESC, name ASC;

-- 10. 이름과 키를 키순 및 이름 순으로 조회
SELECT name, height
FROM usertbl 
ORDER BY height DESC, name ASC;

-- 11. addr 조회 ( 사용자의 출신 지역 조회 )
SELECT DISTINCT addr -- DISTINCT : 중복되 데이터는 결과에 한 개만 포함하도록
FROM usertbl;

-- 작업 데이터베이스 변경 (employees)
USE employees;

-- 12-1. 입사일자가 빠른 10명의 사원 조회 

-- DESC employees;
SELECT emp_no, first_name, last_name, hire_date
FROM employees
ORDER BY hire_date ASC
LIMIT 10;

-- 12-2. 입사일자 순위가 11번째 부터 20번째까지의 사원 조회 

SELECT emp_no, first_name, last_name, hire_date
FROM employees
ORDER BY hire_date ASC
LIMIT 10, 10; -- 시작위치, 갯수 -> 11 ~ 20

-- 작업 데이터베이스 변경 (sqldb)
USE sqldb;

-- 13. 테이블 복사 (존재하는 테이블의 데이터를 복사해서 새 테이블에 저장)
CREATE TABLE buytbl2 (SELECT * FROM buytbl);
SELECT * FROM buytbl2;

CREATE TABLE buytbl3 (SELECT num, userid FROM buytbl);
SELECT * FROM buytbl3;

-- 14. 구매 가격 평균,  구매 수량 평균 조회

SELECT AVG(price), AVG(amount) 
FROM buytbl;

SELECT AVG(price), MIN(price), MAX(price), COUNT(price) 
FROM buytbl;

SELECT AVG(price) AS '가격평균', 
	   MIN(price) '최소가격', 
       MAX(price) '최대가격', 
       COUNT(price) '개수' 
FROM buytbl;

-- 15. 고객별 거래 실적 평균

SELECT userid, AVG(price) '평균거래액', COUNT(price) '거래건수'
FROM buytbl
GROUP BY userid; 

SELECT userid, AVG(price) '평균거래액', COUNT(price) '거래건수'
FROM buytbl
-- WHERE AVG(price) > 100
GROUP BY userid
HAVING AVG(price) > 100 -- HAVING : GROUP BY 결과에 대한 조건 거맛


 
 
 
 