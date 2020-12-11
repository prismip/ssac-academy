-- 1. 작업 데이터베이스 결정

USE sqldb;

-- book, customer, orders 테이블을 사용해서 아래 작업을 수행하세요.

-- 2. 가장 비싼 도서의 이름을 조회

SELECT *
FROM book
WHERE price = (	SELECT MAX(price) 
				FROM book );
                
-- 3. 도서를 구매한 적이 있는 고객의 이름

SELECT name
FROM customer
WHERE custid IN (	SELECT custid
					FROM orders );
                    
                    
-- 4. 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT *
FROM customer 
WHERE custid IN ( SELECT custid
				  FROM orders
                  WHERE bookid IN (	SELECT bookid
									FROM book
                                    WHERE publisher = '대한미디어') );

-- 5. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.

-- a 출판사 : x (10), y(20), z(30)
-- b 출판사 : x (15), y(27), z(31)

SELECT *
FROM book bp
WHERE bp.price > (	SELECT AVG(bc.price)
				    FROM book bc
                    WHERE bc.publisher = bp.publisher );-- 현재 처리 중인 도서의 출판사의 평균 가격

-- 6. 주문이 있는 고객의 이름과 주소를 보이시오.

SELECT * 
FROM customer c
WHERE EXISTS ( SELECT *
			   FROM orders o
               WHERE c.custid = o.custid );


