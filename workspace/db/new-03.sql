USE sqldb;

-- 1. example tables
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


-- 2. 
select * from usertbl;

CREATE VIEW v_simple_usertbl
AS
	SELECT userid, name, addr 
    FROM usertbl;
    
SELECT * FROM v_simple_usertbl;

-- 3. 
SELECT u.userid, u.name, CONCAT(u.mobile1, u.mobile2) AS mobile, b.num, b.prodname, b.groupname, b.price, b.amount
FROM usertbl u
INNER JOIN buytbl b
ON u.userid = b.userid;

CREATE OR REPLACE VIEW v_user_and_buy
AS
	SELECT u.userid, u.name, CONCAT(u.mobile1, u.mobile2) AS mobile, b.num, b.prodname, b.groupname, b.price, b.amount
	FROM usertbl u
	INNER JOIN buytbl b
	ON u.userid = b.userid;
    
-- 4.
show variables like 'innodb_file_per_table';
    
