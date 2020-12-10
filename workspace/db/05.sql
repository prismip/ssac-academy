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

