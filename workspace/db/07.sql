-- 1, 2. 박지성 고객의 총 구매액, 총 도서수

SELECT COUNT(o.saleprice), SUM(o.saleprice) 
FROM orders o
INNER JOIN customer c
ON o.custid = c.custid
WHERE c.name = '박지성';

-- 3. 박지성이 구매한 도서의 출판사 수

SELECT COUNT(DISTINCT b.publisher)
FROM orders o
INNER JOIN customer c
ON o.custid = c.custid
INNER JOIN book b
ON o.bookid = b.bookid
WHERE c.name = '박지성';

-- 4. 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT * FROM book;

SELECT b.bookname, b.price, o.saleprice, b.price - o.saleprice AS 할인금액
FROM book b
INNER JOIN orders o
ON b.bookid = o.bookid
INNER JOIN customer c
ON o.custid = c.custid
WHERE c.name = '박지성'
ORDER BY b.bookname;

-- 5. 고객의 이름과 고객이 구매한 도서 목록

SELECT c.name, b.bookname, o.saleprice
FROM book b
INNER JOIN orders o
ON b.bookid = o.bookid
INNER JOIN customer c
ON o.custid = c.custid
ORDER BY c.name;