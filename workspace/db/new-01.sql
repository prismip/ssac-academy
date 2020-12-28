USE sqldb;

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









