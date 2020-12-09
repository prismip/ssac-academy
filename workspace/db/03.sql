-- 1. 작업 데이터베이스 선택

USE sqldb;

-- 2. 테이블 탐색

SHOW TABLES;

DESC book;
DESC customer;
DESC orders;

SELECT * FROM book;
SELECT * FROM customer;
SELECT * FROM orders;

-- 문제 1. 도서의 총 개수

SELECT COUNT(*)
FROM book;

-- 문제 2. 출판사의 총 개수

SELECT COUNT(publisher)
FROM book;

SELECT publisher
FROM book;

SELECT COUNT(DISTINCT publisher) AS '출판사수'
FROM book;

-- 문제 3. 모든 고객의 이름, 주소 조회

SELECT name, address
FROM customer;

-- 문제 4. 2014년 7월 4일~7월 7일 사이에 주문받은 도서의 주문번호

SELECT *
FROM orders
WHERE orderdate >= '2014-07-04' AND orderdate <= '2014-07-07';

SELECT *
FROM orders
WHERE orderdate BETWEEN '2014-07-04' AND '2014-07-07';

-- 문제 5. 2014년 7월 4일~7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호

SELECT *
FROM orders
WHERE orderdate < '2014-07-04' OR orderdate > '2014-07-07';

SELECT *
FROM orders
WHERE orderdate NOT BETWEEN '2014-07-04' AND '2014-07-07';

-- 문제 6. 성이 '김' 씨인 고객의 이름과 주소

SELECT *
FROM customer
WHERE name LIKE '김%';

-- 문제 7. 성이 '김' 씨이고 이름이 '아'로 끝나는 고객의 이름과 주소

SELECT *
FROM customer
WHERE name LIKE '김%아';

-- 문제 8. 주문 금액의 총액과 주문의 평균 금액

SELECT 
	SUM(saleprice) AS '주문총액',
    AVG(saleprice) AS '주문평균'
FROM orders;

-- 문제 9. 고객별 구매액 합계

SELECT 
	custid, SUM(saleprice) AS '구매액합계'
FROM orders
GROUP BY custid;
