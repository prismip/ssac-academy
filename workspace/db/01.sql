-- 0. 데이터베이스 목록 조회

SHOW DATABASES;

-- 1. 작업 데이터베이스 선택

USE employees;

-- 2. 데이터베이스에 포함된 테이블 목록 조회

SHOW TABLES;

-- 3. 테이블 정보 조회

DESC employees;

-- 4. employees 테이블의 데이터 조회

SELECT emp_no, birth_date, first_name, last_name, gender, hire_date
FROM employees;

SELECT emp_no, first_name, last_name
FROM employees;

SELECT *
FROM employees;

-- 전체 데이터의 갯수 조회
SELECT COUNT(*)
FROM employees;

-- 범위를 지정해서 데이터 조회
SELECT *
FROM employees
LIMIT 10;

