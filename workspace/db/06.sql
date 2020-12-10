-- 1. 작업 데이터베이스 선택

USE sqldb;

-- 1. Join이 필요한 상황 검토 -- 하나의 테이블에서 정보를 충분히 조회 할 수 없는 경우

SELECT * FROM orders;

SELECT * FROM book WHERE bookid = 7;

SELECT * FROM customer WHERE custid = 4;

-- 2-1. INNER JOIN
SELECT * FROM buytbl;
SELECT * FROM usertbl WHERE userid = 'KBS';

SELECT
	buytbl.num, buytbl.userid, usertbl.name,
    buytbl.prodname, buytbl.price, buytbl.amount
FROM buytbl
INNER JOIN usertbl
ON buytbl.userID = usertbl.userID;

SELECT
	buytbl.*, usertbl.name
FROM buytbl
INNER JOIN usertbl
ON buytbl.userID = usertbl.userID;

SELECT
	b.*, u.name
FROM buytbl b -- 테이블에 별명 부여
INNER JOIN usertbl u -- 테이블에 별명 부여
ON b.userID = u.userID;

SELECT
	b.*, u.name
FROM buytbl b, usertbl u
WHERE b.userid = u.userid;

-- 2-2. INNER JOIN

SELECT * FROM orders;

SELECT o.*, b.bookname, c.name
FROM orders o
INNER JOIN book b
ON o.bookid = b.bookid
INNER JOIN customer c
ON o.custid = c.custid;

SELECT o.orderid, o.saleprice, o.orderdate, b.bookname, c.name
FROM orders o, book b, customer c
WHERE o.bookid = b.bookid AND o.custid = c.custid;

-- 연습용 테이블 만들기

USE sqldb;
CREATE TABLE stdtbl 
( stdName    VARCHAR(10) NOT NULL PRIMARY KEY,
  addr	  CHAR(4) NOT NULL
);
CREATE TABLE clubtbl 
( clubName    VARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo    CHAR(4) NOT NULL
);
CREATE TABLE stdclubtbl
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   stdName    VARCHAR(10) NOT NULL,
   clubName    VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
FOREIGN KEY(clubName) REFERENCES clubtbl(clubName)
);
INSERT INTO stdtbl VALUES ('김범수','경남'), ('성시경','서울'), ('조용필','경기'), ('은지원','경북'),('바비킴','서울');
INSERT INTO clubtbl VALUES ('수영','101호'), ('바둑','102호'), ('축구','103호'), ('봉사','104호');
INSERT INTO stdclubtbl VALUES (NULL, '김범수','바둑'), (NULL,'김범수','축구'), (NULL,'조용필','축구'), (NULL,'은지원','축구'), (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');

SELECT * FROM clubtbl;
SELECT * FROM stdtbl;
SELECT * FROM stdclubtbl;

-- 2-3. INNER JOIN

SELECT sc.*, s.addr, c.roomno
FROM stdclubtbl sc
INNER JOIN stdtbl s
ON sc.stdname = s.stdname
INNER JOIN clubtbl c
ON sc.clubname = c.clubname;

SELECT sc.*, s.addr, c.roomno
FROM stdclubtbl sc, stdtbl s, clubtbl c
WHERE sc.stdname = s.stdname AND sc.clubname = c.clubname;

-- 3. OUTER JOIN

SELECT DISTINCT userid FROM usertbl;
SELECT * FROM buytbl;
SELECT DISTINCT userid
FROM buytbl;

-- 고객별 주문 통계 1
SELECT u.userid, u.name, SUM(b.price * b.amount) AS 주문총액
FROM usertbl u
-- INNER JOIN buytbl b
LEFT OUTER JOIN buytbl b
ON u.userid = b.userid
GROUP BY u.userid
ORDER BY 주문총액 DESC;

-- 고객별 주문 통계 2
SELECT c.custid, c.name, IFNULL(SUM(o.saleprice), 0) AS 주문총액
FROM orders o
RIGHT OUTER JOIN customer c
ON o.custid = c.custid
GROUP BY c.custid;

SELECT DISTINCT custid FROM customer;

-- 4. SELF JOIN

USE sqldb;
CREATE TABLE empTbl (emp CHAR(3), manager CHAR(3), empTel VARCHAR(8));

INSERT INTO empTbl VALUES('나사장',NULL,'0000');
INSERT INTO empTbl VALUES('김재무','나사장','2222');
INSERT INTO empTbl VALUES('김부장','김재무','2222-1');
INSERT INTO empTbl VALUES('이부장','김재무','2222-2');
INSERT INTO empTbl VALUES('우대리','이부장','2222-2-1');
INSERT INTO empTbl VALUES('지사원','이부장','2222-2-2');
INSERT INTO empTbl VALUES('이영업','나사장','1111');
INSERT INTO empTbl VALUES('한과장','이영업','1111-1');
INSERT INTO empTbl VALUES('최정보','나사장','3333');
INSERT INTO empTbl VALUES('윤차장','최정보','3333-1');
INSERT INTO empTbl VALUES('이주임','윤차장','3333-1-1');

SELECT * FROM empTbl;

-- 사원이름, 상위직급자이름, 내전화번호, 상위직급자 전화번호

SELECT ec.emp, ec.manager, ec.emptel, ep.emptel
FROM empTbl ec
-- INNER JOIN empTbl ep
LEFT OUTER JOIN empTbl ep
ON ec.manager = ep.emp;











