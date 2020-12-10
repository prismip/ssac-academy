-- 1. 작업 데이터베이스 선택
USE sqldb;

-- 2. 테이블 제거 : DROP TABLE 테이블이름
DROP TABLE testtbl2;

-- 3. 테이블 생성 : CREATE TABLE 테이블이름 ( 컬럼1, 컬럼2, ... )
CREATE TABLE testtbl2 (
  id 		INT 		NOT NULL AUTO_INCREMENT,
  username 	VARCHAR(50) NOT NULL,
  age 		INT 		NOT NULL,
  regdate	DATETIME	DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

DROP TABLE testtbl2;
CREATE TABLE testtbl2 (
  id 		INT 		PRIMARY KEY AUTO_INCREMENT,
  username 	VARCHAR(50) NOT NULL,
  regdate	DATETIME	DEFAULT CURRENT_TIMESTAMP,
  age 		INT 		NOT NULL
);

-- 4. 데이터 생성

INSERT INTO testtbl2 (id, username, regdate, age) 
VALUES (NULL, '홍길동', CURRENT_TIMESTAMP, 30);

SELECT * FROM testtbl2;

INSERT INTO testtbl2
VALUES (NULL, '장동건', CURRENT_TIMESTAMP, 40);

SELECT * FROM testtbl2;

INSERT INTO testtbl2 (username, age)
VALUES ('송강호',  40);

SELECT * FROM testtbl2;

-- 5. 데이터 수정

SELECT * FROM testtbl2;

UPDATE testtbl2
SET age = 50
WHERE id = 3;

SELECT * FROM testtbl2;

UPDATE testtbl2
SET username = '김윤석', age = 55
WHERE id = 1;

SELECT * FROM testtbl2;

-- 6. 데이터 삭제

DELETE FROM testtbl2
WHERE id = 2;

SELECT * FROM testtbl2;

INSERT INTO testtbl2
VALUES (NULL, '한석규', CURRENT_TIMESTAMP, 57);

SELECT * FROM testtbl2;

TRUNCATE TABLE testtbl2; -- DELETE FROM testtbl2;

SELECT * FROM testtbl2;

-- 7. 다중 행 생성

INSERT INTO testtbl2 (username, age) 
VALUES 	('한석규', 55),
		('김윤석', 53),
		('송강호',  40);
        
SELECT * FROM testtbl2;

-- 8. 다른 테이블의 데이터를 복사해서 삽입

CREATE TABLE testtbl3 (
  id 		INT 		NOT NULL AUTO_INCREMENT,
  username 	VARCHAR(50) NOT NULL,
  age 		INT 		NOT NULL,
  regdate	DATETIME	DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

SELECT * FROM testtbl3;

INSERT INTO testtbl3 (username, age, regdate)
SELECT username, age, regdate FROM testtbl2;

SELECT * FROM testtbl3;






