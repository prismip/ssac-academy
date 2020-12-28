USE sqldb;

-- 1. 컬럼이름과 자료형으로 테이블 만들기

DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl
(
	userid char(8),
    name varchar(10),
    birthyear int,
    addr char(2), -- 서울, 경기, 부산, 인천
    mobile1 char(3),
    mobile2 varchar(8),
    height smallint,
    mdate date
);

DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl
(
	num int,
    userid char(8),
    prodname char(6),
    groupname char(4),
    price int,
    amount smallint
);

DESC usertbl;
DESC buytbl;
DESC employees.employees;

-----------------------------------

-- 2. NULL OR NOT NULL -> 컬럼의 값이 비어있을 수 있는지 설정

DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl
(
	userid char(8) NOT NULL,
    name varchar(10) NOT NULL,
    birthyear int NOT NULL,
    addr char(2) NOT NULL, -- 서울, 경기, 부산, 인천
    mobile1 char(3) NULL,
    mobile2 varchar(8) NULL,
    height smallint NULL,
    mdate date NULL
);
DESC usertbl;

DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl
(
	num int NOT NULL,
    userid char(8) NOT NULL,
    prodname char(6) NOT NULL,
    groupname char(4) NULL,
    price int NOT NULL,
    amount smallint NOT NULL
);
DESC buytbl;

--------------------------------------------------

-- 3. primary key, foreign key
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl
(
	userid char(8) NOT NULL PRIMARY KEY,
    name varchar(10) NOT NULL,
    birthyear int NOT NULL,
    addr char(2) NOT NULL, -- 서울, 경기, 부산, 인천
    mobile1 char(3) NULL,
    mobile2 varchar(8) NULL,
    height smallint NULL,
    mdate date NULL
);
DESC usertbl;

DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl
(
	num int NOT NULL AUTO_INCREMENT,
    userid char(8) NOT NULL,
    prodname char(6) NOT NULL,
    groupname char(4) NULL,
    price int NOT NULL,
    amount smallint NOT NULL,
    -- PRIMARY KEY (num),
    CONSTRAINT pk_buytbl PRIMARY KEY (num),
    -- FOREIGN KEY (userid) REFERENCES usertbl(userid)
    CONSTRAINT fk_buytbl_to_usertbl FOREIGN KEY (userid) REFERENCES usertbl(userid)
    
);
DESC buytbl;

--------------------------------------------------------

-- 4. unique key 
DROP TABLE IF EXISTS buytbl;
DROP TABLE IF EXISTS usertbl; -- usertbl을 참조하는 자식 테이블이 있는 경우 삭제 X ( 자식 테이블 삭제 후 삭제 가능 )
CREATE TABLE usertbl
(
	userid char(8) NOT NULL PRIMARY KEY,
    name varchar(10) NOT NULL,
    birthyear int NOT NULL,
    addr char(2) NOT NULL, -- 서울, 경기, 부산, 인천
    email varchar(50) NULL UNIQUE,
    mobile1 char(3) NULL,
    mobile2 varchar(8) NULL,
    height smallint NULL,
    mdate date NULL
);
DESC usertbl;

DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl
(
	num int NOT NULL AUTO_INCREMENT,
    userid char(8) NOT NULL,
    prodname char(6) NOT NULL,
    groupname char(4) NULL,
    price int NOT NULL,
    amount smallint NOT NULL,
    -- PRIMARY KEY (num),
    CONSTRAINT pk_buytbl PRIMARY KEY (num),
    -- FOREIGN KEY (userid) REFERENCES usertbl(userid)
    CONSTRAINT fk_buytbl_to_usertbl FOREIGN KEY (userid) REFERENCES usertbl(userid)
    
);
DESC buytbl;

-- 5. check 
DROP TABLE IF EXISTS buytbl;
DROP TABLE IF EXISTS usertbl; -- usertbl을 참조하는 자식 테이블이 있는 경우 삭제 X ( 자식 테이블 삭제 후 삭제 가능 )
CREATE TABLE usertbl
(
	userid char(8) NOT NULL PRIMARY KEY,
    name varchar(10) NOT NULL,
    birthyear int NOT NULL CHECK (birthyear > 1900 AND birthyear < 2021),
    addr char(2) NOT NULL, -- 서울, 경기, 부산, 인천
    email varchar(50) NULL UNIQUE,
    mobile1 char(3) NULL,
    mobile2 varchar(8) NULL,
    height smallint NULL CHECK (height > 0),
    mdate date NULL
);
DESC usertbl;

DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl
(
	num int NOT NULL AUTO_INCREMENT,
    userid char(8) NOT NULL,
    prodname char(6) NOT NULL,
    groupname char(4) NULL,
    price int NOT NULL,
    amount smallint NOT NULL,
    -- PRIMARY KEY (num),
    CONSTRAINT pk_buytbl PRIMARY KEY (num),
    -- FOREIGN KEY (userid) REFERENCES usertbl(userid)
    CONSTRAINT fk_buytbl_to_usertbl FOREIGN KEY (userid) REFERENCES usertbl(userid)
    
);
DESC buytbl;

-- 6. default value : 값을 지정하지 않으면 자동으로 저장되는 값 설정 
DROP TABLE IF EXISTS buytbl;
DROP TABLE IF EXISTS usertbl; -- usertbl을 참조하는 자식 테이블이 있는 경우 삭제 X ( 자식 테이블 삭제 후 삭제 가능 )
CREATE TABLE usertbl
(
	userid char(8) NOT NULL PRIMARY KEY,
    name varchar(10) NOT NULL,
    birthyear int NOT NULL DEFAULT -1,
    addr char(2) NOT NULL DEFAULT '서울', -- 서울, 경기, 부산, 인천
    email varchar(50) NULL UNIQUE,
    mobile1 char(3) NULL,
    mobile2 varchar(8) NULL,
    height smallint NULL DEFAULT 170,
    mdate date NULL
);
DESC usertbl;

DROP TABLE IF EXISTS buytbl;
CREATE TABLE buytbl
(
	num int NOT NULL AUTO_INCREMENT,
    userid char(8) NOT NULL,
    prodname char(6) NOT NULL,
    groupname char(4) NULL,
    price int NOT NULL,
    amount smallint NOT NULL,
    -- PRIMARY KEY (num),
    CONSTRAINT pk_buytbl PRIMARY KEY (num),
    -- FOREIGN KEY (userid) REFERENCES usertbl(userid)
    CONSTRAINT fk_buytbl_to_usertbl FOREIGN KEY (userid) REFERENCES usertbl(userid)    
);
DESC buytbl;

-- 7. 테이블 압축

DESC employees.employees;

CREATE TABLE normaltbl (emp_no int, first_name varchar(14));
CREATE TABLE compressedtbl (emp_no int, first_name varchar(14)) ROW_FORMAT=COMPRESSED;

INSERT INTO normaltbl SELECT emp_no, first_name FROM employees.employees;
INSERT INTO compressedtbl SELECT emp_no, first_name FROM employees.employees;

SHOW TABLE STATUS FROM sqldb;

-- 8. 임시테이블

USE employees;

DESC employees; 

CREATE TEMPORARY TABLE IF NOT EXISTS employees (id int, name varchar (10));
DESC employees; -- 임시 테이블이 기존의 employees테이블을 가려서 볼 수 X

DROP TABLE employees;
DESC employees;

-- 9. 테이블 삭제

DROP TABLE compressedtbl, normaltbl;








