-- 1. 작업 데이터베이스 선택

USE mysql;

SHOW tables;

DESC user;

SELECT user, host, authentication_string
FROM user;

-- DBMS가 실행되고 있는 컴퓨터에서 접속하는 사용자 계정 만들기 + 권한 부여
CREATE USER ssac@localhost IDENTIFIED WITH mysql_native_password BY 'ssac';
GRANT ALL PRIVILEGES ON sqldb.* TO ssac@localhost;

-- 외부에서 접속하는 사용자 계정 만들기 + 권한 부여
CREATE USER ssac@'%' IDENTIFIED WITH mysql_native_password BY 'ssac';
GRANT ALL PRIVILEGES ON sqldb.* TO ssac@localhost;

SELECT user, host, authentication_string
FROM user;

-- 권한 조정 작업 확정
FLUSH PRIVILEGES;


