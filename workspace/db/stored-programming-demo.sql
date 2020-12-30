-- 1. SQL Programming

USE sqlDB;
DROP PROCEDURE IF EXISTS userProc;
DELIMITER $$
CREATE PROCEDURE userProc()
BEGIN
    SELECT * FROM userTbl; -- 스토어드 프로시저 내용
END $$
DELIMITER ;

CALL userProc();

-------------------------------------------------

DROP PROCEDURE IF EXISTS ifProc; -- 기존에 만든적이 있다면 삭제
DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN
  DECLARE var1 INT;  -- var1 변수선언
  SET var1 = 100;  -- 변수에 값 대입

  IF var1 = 100 THEN  -- 만약 @var1이 100이라면,
	SELECT '100입니다.';
  ELSE
    SELECT '100이 아닙니다.';
  END IF;
END $$
DELIMITER ;

CALL ifProc();

--------------------------------

DROP PROCEDURE IF EXISTS ifProc2; 

DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE hireDATE DATE; -- 입사일
	DECLARE curDATE DATE; -- 오늘
	DECLARE days INT; -- 근무한 일수

	SELECT hire_date INTO hireDate -- hire_date 열의 결과를 hireDATE에 대입
	   FROM employees.employees
	   WHERE emp_no = 10001;

	SET curDATE = CURRENT_DATE(); -- 현재 날짜
	SET days =  DATEDIFF(curDATE, hireDATE); -- 날짜의 차이, 일 단위

	IF (days/365) >= 5 THEN -- 5년이 지났다면
		  SELECT CONCAT('입사한지 ', days, '일이나 지났습니다. 축하합니다!');
	ELSE
		  SELECT '입사한지 ' + days + '일밖에 안되었네요. 열심히 일하세요.' ;
	END IF;
END $$
DELIMITER ;

CALL ifProc2();

-------------------------------------

DROP PROCEDURE IF EXISTS ifProc3; 
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    IF point >= 90 THEN
		SET credit = 'A';
    ELSEIF point >= 80 THEN
		SET credit = 'B';
    ELSEIF point >= 70 THEN
		SET credit = 'C';
    ELSEIF point >= 60 THEN
		SET credit = 'D';
    ELSE
		SET credit = 'F';
    END IF;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;

CALL ifProc3();

----------------------------------------------

DROP PROCEDURE IF EXISTS caseProc; 
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
    DECLARE point INT ;
    DECLARE credit CHAR(1);
    SET point = 77 ;
    
    CASE 
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';
		ELSE
			SET credit = 'F';
    END CASE;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;
CALL caseProc();

----------------------------------------------

SELECT U.userID, U.name, SUM(price*amount) AS '총구매액',
	   CASE  
           WHEN (SUM(price*amount)  >= 1500) THEN '최우수고객'
           WHEN (SUM(price*amount)  >= 1000) THEN '우수고객'
           WHEN (SUM(price*amount) >= 1 ) THEN '일반고객'
           ELSE '유령고객'
       END AS '고객등급'
FROM buytbl B
RIGHT OUTER JOIN usertbl U
ON B.userID = U.userID
GROUP BY U.userID, U.name 
ORDER BY sum(price*amount) DESC ;
   
--------------------------------------------------

DROP PROCEDURE IF EXISTS whileProc; 
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE i INT; -- 1에서 100까지 증가할 변수
	DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

	WHILE (i <= 100) DO
		SET hap = hap + i;  -- hap의 원래의 값에 i를 더해서 다시 hap에 넣으라는 의미
		SET i = i + 1;      -- i의 원래의 값에 1을 더해서 다시 i에 넣으라는 의미
	END WHILE;

	SELECT hap;   
END $$
DELIMITER ;

CALL whileProc();

----------------------------------------------------

DROP PROCEDURE IF EXISTS whileProc2; 
DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN
    DECLARE i INT; -- 1에서 100까지 증가할 변수
    DECLARE hap INT; -- 더한 값을 누적할 변수
    SET i = 1;
    SET hap = 0;

    myWhile: WHILE (i <= 100) DO  -- While문에 label을 지정
	IF (i%7 = 0) THEN
		SET i = i + 1;     
		ITERATE myWhile; -- 지정한 label문으로 가서 계속 진행
	END IF;
        
        SET hap = hap + i; 
        IF (hap > 1000) THEN 
		LEAVE myWhile; -- 지정한 label문을 떠남. 즉, While 종료.
	END IF;
        SET i = i + 1;
    END WHILE;

    SELECT hap, i;   
END $$
DELIMITER ;

CALL whileProc2();

----------------------------------------------------

-- error code reference link : https://dev.mysql.com/doc/mysql-errors/8.0/en/server-error-reference.html

------------------------------------------------------

DROP PROCEDURE IF EXISTS errorProc; 
DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE CONTINUE HANDLER FOR 1146 SELECT '테이블이 없어요ㅠㅠ' AS '메시지';
    SELECT * FROM noTable;  -- noTable은 없음.  
END $$
DELIMITER ;
CALL errorProc();

--------------------------------------------

DROP PROCEDURE IF EXISTS errorProc2; 
DELIMITER $$
CREATE PROCEDURE errorProc2()
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
		SELECT '오류가 발생했네요. 작업은 취소시켰습니다.' AS '메시지'; 
		ROLLBACK; -- 오류 발생시 작업을 롤백시킨다.
    END;
    
    INSERT INTO usertbl VALUES('LSG', '이상구', 1988, '서울', NULL, 
		NULL, 170, CURRENT_DATE()); -- 중복되는 아이디이므로 오류 발생
END $$
DELIMITER ;

CALL errorProc2();

------------------------------------------------------------

use sqldb;
PREPARE myQuery FROM 'SELECT * FROM usertbl WHERE userID = "EJW"';
EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;


USE sqldb;
DROP TABLE IF EXISTS myTable;
CREATE TABLE myTable (id INT AUTO_INCREMENT PRIMARY KEY, mDate DATETIME);
SET @curDATE = CURRENT_TIMESTAMP(); -- 현재 날짜와 시간
PREPARE myQuery FROM 'INSERT INTO myTable VALUES(NULL, ?)';
EXECUTE myQuery USING @curDATE;
DEALLOCATE PREPARE myQuery;
SELECT * FROM myTable;

SELECT @curDate;

-----------------------------------------------------------------

-- 2. Stored PROCEDURE

USE sqlDB;
DROP PROCEDURE IF EXISTS userProc1;
DELIMITER $$
CREATE PROCEDURE userProc1(IN userName VARCHAR(10))
BEGIN
  SELECT * FROM userTbl WHERE name = userName; 
END $$
DELIMITER ;

CALL userProc1('조관우');

-----------------------------------

DROP PROCEDURE IF EXISTS userProc2;
DELIMITER $$
CREATE PROCEDURE userProc2(
    IN userBirth INT, 
    IN userHeight INT
)
BEGIN
  SELECT * FROM userTbl 
    WHERE birthYear > userBirth AND height > userHeight;
END $$
DELIMITER ;

CALL userProc2(1970, 178);

----------------------------------------------

DROP PROCEDURE IF EXISTS userProc3;
DELIMITER $$
CREATE PROCEDURE userProc3(
    IN txtValue CHAR(10),
    OUT outValue INT
)
BEGIN
  INSERT INTO testTBL VALUES(NULL,txtValue);
  SELECT MAX(id) INTO outValue FROM testTBL; 
END $$
DELIMITER ;

CREATE TABLE IF NOT EXISTS testTBL(
    id INT AUTO_INCREMENT PRIMARY KEY, 
    txt CHAR(10)
);

CALL userProc3 ('테스트값', @myValue);
SELECT CONCAT('현재 입력된 ID 값 ==>', @myValue);

--------------------------------------------------

DROP PROCEDURE IF EXISTS ifelseProc;
DELIMITER $$
CREATE PROCEDURE ifelseProc(
    IN userName VARCHAR(10)
)
BEGIN
    DECLARE bYear INT; -- 변수 선언
    SELECT birthYear into bYear FROM userTbl
        WHERE name = userName;
    IF (bYear >= 1980) THEN
            SELECT '아직 젊군요..';
    ELSE
            SELECT '나이가 지긋하시네요.';
    END IF;
END $$
DELIMITER ;

CALL ifelseProc ('조용필');
CALL ifelseProc('이승기');

select * from usertbl;

-----------------------------------------------

DROP PROCEDURE IF EXISTS caseProc;
DELIMITER $$
CREATE PROCEDURE caseProc(
    IN userName VARCHAR(10)
)
BEGIN
    DECLARE bYear INT; 
    DECLARE tti  CHAR(3);-- 띠
    SELECT birthYear INTO bYear FROM userTbl
        WHERE name = userName;
    CASE 
        WHEN ( bYear%12 = 0) THEN    SET tti = '원숭이';
        WHEN ( bYear%12 = 1) THEN    SET tti = '닭';
        WHEN ( bYear%12 = 2) THEN    SET tti = '개';
        WHEN ( bYear%12 = 3) THEN    SET tti = '돼지';
        WHEN ( bYear%12 = 4) THEN    SET tti = '쥐';
        WHEN ( bYear%12 = 5) THEN    SET tti = '소';
        WHEN ( bYear%12 = 6) THEN    SET tti = '호랑이';
        WHEN ( bYear%12 = 7) THEN    SET tti = '토끼';
        WHEN ( bYear%12 = 8) THEN    SET tti = '용';
        WHEN ( bYear%12 = 9) THEN    SET tti = '뱀';
        WHEN ( bYear%12 = 10) THEN    SET tti = '말';
        ELSE SET tti = '양';
    END CASE;
    SELECT CONCAT(userName, '의 띠 ==>', tti);
END $$
DELIMITER ;

CALL caseProc ('이승기');

--------------------------------------------------------

DROP TABLE IF EXISTS guguTBL;
CREATE TABLE guguTBL (txt VARCHAR(100)); -- 구구단 저장용 테이블

DROP PROCEDURE IF EXISTS whileProc;
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
    DECLARE str VARCHAR(100); -- 각 단을 문자열로 저장
    DECLARE i INT; -- 구구단 앞자리
    DECLARE k INT; -- 구구단 뒷자리
    SET i = 2; -- 2단부터 계산
    
    WHILE (i < 10) DO  -- 바깥 반복문. 2단~9단까지.
        SET str = ''; -- 각 단의 결과를 저장할 문자열 초기화
        SET k = 1; -- 구구단 뒷자리는 항상 1부터 9까지.
        WHILE (k < 10) DO
            SET str = CONCAT(str, '  ', i, 'x', k, '=', i*k); -- 문자열 만들기
            SET k = k + 1; -- 뒷자리 증가
        END WHILE;
        SET i = i + 1; -- 앞자리 증가
        INSERT INTO guguTBL VALUES(str); -- 각 단의 결과를 테이블에 입력.
    END WHILE;
END $$
DELIMITER ;

CALL whileProc();
SELECT * FROM guguTBL;

----------------------------------------------

DROP PROCEDURE IF EXISTS errorProc;
DELIMITER $$
CREATE PROCEDURE errorProc()
BEGIN
    DECLARE i INT; -- 1씩 증가하는 값
    DECLARE hap INT; -- 합계 (정수형). 오버플로 발생시킬 예정.
    DECLARE saveHap INT; -- 합계 (정수형). 오버플로 직전의 값을 저장.

    DECLARE EXIT HANDLER FOR 1264 -- INT형 오버플로가 발생하면 이 부분 수행
    BEGIN
        SELECT CONCAT('INT 오버플로 직전의 합계 --> ', saveHap);
        SELECT CONCAT('1+2+3+4+...+',i ,'=오버플로');
    END;
    
    SET i = 1; -- 1부터 증가
    SET hap = 0; -- 합계를 누적
    
    WHILE (TRUE) DO  -- 무한 루프.
        SET saveHap = hap; -- 오버플로 직전의 합계를 저장
        SET hap = hap + i;  -- 오버플로가 나면 11, 12행을 수행함
        SET i = i + 1; 
    END WHILE;
END $$
DELIMITER ;

CALL errorProc();

------------------------------------------------------------

SELECT routine_name, routine_definition FROM INFORMATION_SCHEMA.ROUTINES
    WHERE routine_schema = 'sqldb' AND routine_type = 'PROCEDURE';

SELECT parameter_mode, parameter_name, dtd_identifier
	FROM INFORMATION_SCHEMA.PARAMETERS
	WHERE specific_name = 'userProc3';

SHOW CREATE PROCEDURE sqldb.userProc3;

----------------------------------------------------------------

DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
    IN tblName VARCHAR(20)
)
BEGIN
 SELECT * FROM tblName;
END $$
DELIMITER ;

CALL nameProc ('userTBL');

-----------------------------------------------------

DROP PROCEDURE IF EXISTS nameProc;
DELIMITER $$
CREATE PROCEDURE nameProc(
    IN tblName VARCHAR(20)
)
BEGIN
  SET @sqlQuery = CONCAT('SELECT * FROM ', tblName);
  PREPARE myQuery FROM @sqlQuery;
  EXECUTE myQuery;
  DEALLOCATE PREPARE statement;
END $$
DELIMITER ;

CALL nameProc ('userTBL');

-----------------------------------------------------------

SELECT COUNT(*) FROM employees.employees;

-- 3. Stored Function

set global log_bin_trust_function_creators = 1;

--------------------------------

USE sqlDB;
DROP FUNCTION IF EXISTS userFunc;
DELIMITER $$
CREATE FUNCTION userFunc(value1 INT, value2 INT)
    RETURNS INT
BEGIN
    RETURN value1 + value2;
END $$
DELIMITER ;

SELECT userFunc(100, 200);

-------------------------------------

USE sqlDB;
DROP FUNCTION IF EXISTS getAgeFunc;
DELIMITER $$
CREATE FUNCTION getAgeFunc(bYear INT)
    RETURNS INT
BEGIN
    DECLARE age INT;
    SET age = YEAR(CURDATE()) - bYear;
    RETURN age;
END $$
DELIMITER ;

SELECT getAgeFunc(1981);
SELECT getAgeFunc(1991);

SELECT getAgeFunc(1979) INTO @age1979;
SELECT getAgeFunc(1997) INTO @age1989;
SELECT CONCAT('1997년과 1979년의 나이차 ==> ', (@age1979-@age1989));

SELECT userID, name, getAgeFunc(birthYear) AS '만 나이' FROM userTbl;

SHOW CREATE FUNCTION getAgeFunc;

DROP FUNCTION getAgeFunc;

--------------------------------------------

-- 4. cursor

DROP PROCEDURE IF EXISTS cursorProc;
DELIMITER $$
CREATE PROCEDURE cursorProc()
BEGIN
    DECLARE userHeight INT; -- 고객의 키
    DECLARE cnt INT DEFAULT 0; -- 고객의 인원 수(=읽은 행의 수)
    DECLARE totalHeight INT DEFAULT 0; -- 키의 합계
    
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; -- 행의 끝 여부(기본을 FALSE)

    DECLARE userCuror CURSOR FOR-- 커서 선언
        SELECT height FROM userTbl;

    DECLARE CONTINUE HANDLER -- 행의 끝이면 endOfRow 변수에 TRUE를 대입 
        FOR NOT FOUND SET endOfRow = TRUE;
    
    OPEN userCuror;  -- 커서 열기

    cursor_loop: LOOP
        FETCH  userCuror INTO userHeight; -- 고객 키 1개를 대입
        
        IF endOfRow THEN -- 더이상 읽을 행이 없으면 Loop를 종료
            LEAVE cursor_loop;
        END IF;

        SET cnt = cnt + 1;
        SET totalHeight = totalHeight + userHeight;        
    END LOOP cursor_loop;
    
    -- 고객 키의 평균을 출력한다.
    SELECT CONCAT('고객 키의 평균 ==> ', (totalHeight/cnt));
    
    CLOSE userCuror;  -- 커서 닫기
END $$
DELIMITER ;

CALL cursorProc();

ALTER TABLE userTbl ADD grade VARCHAR(5);  -- 고객 등급 열 추가

DROP PROCEDURE IF EXISTS gradeProc;
DELIMITER $$
CREATE PROCEDURE gradeProc()
BEGIN
    DECLARE id VARCHAR(10); -- 사용자 아이디를 저장할 변수
    DECLARE hap BIGINT; -- 총 구매액을 저장할 변수
    DECLARE userGrade CHAR(5); -- 고객 등급 변수
    
    DECLARE endOfRow BOOLEAN DEFAULT FALSE; 

    DECLARE userCuror CURSOR FOR-- 커서 선언
        SELECT U.userid, sum(price*amount)
            FROM buyTbl B
                RIGHT OUTER JOIN userTbl U
                ON B.userid = U.userid
            GROUP BY U.userid, U.name ;

    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET endOfRow = TRUE;
    
    OPEN userCuror;  -- 커서 열기
    
    grade_loop: LOOP
        FETCH  userCuror INTO id, hap; -- 첫 행 값을 대입
        IF endOfRow THEN
            LEAVE grade_loop;
        END IF;

        CASE  
            WHEN (hap >= 1500) THEN SET userGrade = '최우수고객';
            WHEN (hap  >= 1000) THEN SET userGrade ='우수고객';
            WHEN (hap >= 1) THEN SET userGrade ='일반고객';
            ELSE SET userGrade ='유령고객';
         END CASE;
        
        UPDATE userTbl SET grade = userGrade WHERE userID = id;
    END LOOP grade_loop;
    
    CLOSE userCuror;  -- 커서 닫기
END $$
DELIMITER ;

CALL gradeProc();
SELECT * FROM userTBL;

---------------------------------------------------

-- 5. trigger

CREATE DATABASE IF NOT EXISTS testDB;
USE testDB;
CREATE TABLE IF NOT EXISTS testTbl (id INT, txt VARCHAR(10));
INSERT INTO testTbl VALUES(1, '레드벨벳');
INSERT INTO testTbl VALUES(2, '잇지');
INSERT INTO testTbl VALUES(3, '블랙핑크');

SELECT * FROM testTbl;

DROP TRIGGER IF EXISTS testTrg;
DELIMITER // 
CREATE TRIGGER testTrg  -- 트리거 이름
    AFTER  DELETE -- 삭제후에 작동하도록 지정
    ON testTbl -- 트리거를 부착할 테이블
    FOR EACH ROW -- 각 행마다 적용시킴
BEGIN
	SET @msg = '가수 그룹이 삭제됨' ; -- 트리거 실행시 작동되는 코드들
END // 
DELIMITER ;

SET @msg = '';
INSERT INTO testTbl VALUES(4, '마마무');
SELECT @msg;
UPDATE testTbl SET txt = '블핑' WHERE id = 3;
SELECT @msg;
DELETE FROM testTbl WHERE id = 4;
SELECT @msg;

----------------------------------------------------

USE sqlDB;
DROP TABLE buyTbl; -- 구매테이블은 실습에 필요없으므로 삭제.
CREATE TABLE backup_userTbl
( userID  CHAR(8) NOT NULL PRIMARY KEY, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  addr	  CHAR(2) NOT NULL, 
  mobile1	CHAR(3), 
  mobile2   CHAR(8), 
  height    SMALLINT,  
  mDate    DATE,
  modType  CHAR(2), -- 변경된 타입. '수정' 또는 '삭제'
  modDate  DATE, -- 변경된 날짜
  modUser  VARCHAR(256) -- 변경한 사용자
);


DROP TRIGGER IF EXISTS backUserTbl_UpdateTrg;
DELIMITER // 
CREATE TRIGGER backUserTbl_UpdateTrg  -- 트리거 이름
    AFTER UPDATE -- 변경 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    INSERT INTO backup_userTbl VALUES( OLD.userID, OLD.name, OLD.birthYear, 
        OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
        '수정', CURDATE(), CURRENT_USER() );
END // 
DELIMITER ;

DROP TRIGGER IF EXISTS backUserTbl_DeleteTrg;
DELIMITER // 
CREATE TRIGGER backUserTbl_DeleteTrg  -- 트리거 이름
    AFTER DELETE -- 삭제 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    INSERT INTO backup_userTbl VALUES( OLD.userID, OLD.name, OLD.birthYear, 
        OLD.addr, OLD.mobile1, OLD.mobile2, OLD.height, OLD.mDate, 
        '삭제', CURDATE(), CURRENT_USER() );
END // 
DELIMITER ;

SELECT * FROM usertbl;

UPDATE userTbl SET addr = '몽고' WHERE userID = 'JKW';
DELETE FROM userTbl WHERE height >= 177;

SELECT * FROM backup_userTbl;

TRUNCATE TABLE userTbl;

SELECT * FROM backup_userTbl;

------------------------------------------------------------------

DROP TRIGGER IF EXISTS userTbl_InsertTrg;
DELIMITER // 
CREATE TRIGGER userTbl_InsertTrg  -- 트리거 이름
    AFTER INSERT -- 입력 후에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '데이터의 입력을 시도했습니다. 귀하의 정보가 서버에 기록되었습니다.';
END // 
DELIMITER ;

INSERT INTO userTbl VALUES('ABC', '에비씨', 1977, '서울', '011', '1111111', 181, '2019-12-25');

----------------------------------------------------------------------

USE sqlDB;
DROP TRIGGER IF EXISTS userTbl_BeforeInsertTrg;
DELIMITER // 
CREATE TRIGGER userTbl_BeforeInsertTrg  -- 트리거 이름
    BEFORE INSERT -- 입력 전에 작동하도록 지정
    ON userTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    IF NEW.birthYear < 1900 THEN
        SET NEW.birthYear = 0;
    ELSEIF NEW.birthYear > YEAR(CURDATE()) THEN
        SET NEW.birthYear = YEAR(CURDATE());
    END IF;
END // 
DELIMITER ;

INSERT INTO userTbl VALUES
  ('AAA', '에이', 1877, '서울', '011', '1112222', 181, '2022-12-25');
INSERT INTO userTbl VALUES
  ('BBB', '비이', 2977, '경기', '011', '1113333', 171, '2019-3-25');

select * from usertbl;

SHOW TRIGGERS FROM sqlDB;

DROP TRIGGER userTbl_BeforeInsertTrg;

---------------------------------------------------------------

DROP DATABASE IF EXISTS triggerDB;
CREATE DATABASE IF NOT EXISTS triggerDB;

USE triggerDB;
CREATE TABLE orderTbl -- 구매 테이블
	(orderNo INT AUTO_INCREMENT PRIMARY KEY, -- 구매 일련번호
          userID VARCHAR(5), -- 구매한 회원아이디
	 prodName VARCHAR(5), -- 구매한 물건
	 orderamount INT );  -- 구매한 개수
CREATE TABLE prodTbl -- 물품 테이블
	( prodName VARCHAR(5), -- 물건 이름
	  account INT ); -- 남은 물건수량
CREATE TABLE deliverTbl -- 배송 테이블
	( deliverNo  INT AUTO_INCREMENT PRIMARY KEY, -- 배송 일련번호
	  prodName VARCHAR(5), -- 배송할 물건		  
	  account INT UNIQUE); -- 배송할 물건개수

INSERT INTO prodTbl VALUES('사과', 100);
INSERT INTO prodTbl VALUES('배', 100);
INSERT INTO prodTbl VALUES('귤', 100);

select * from prodTbl;
select * from orderTbl;
select * from deliverTbl;

-- 물품 테이블에서 개수를 감소시키는 트리거
DROP TRIGGER IF EXISTS orderTrg;
DELIMITER // 
CREATE TRIGGER orderTrg  -- 트리거 이름
    AFTER  INSERT 
    ON orderTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    UPDATE prodTbl SET account = account - NEW.orderamount 
        WHERE prodName = NEW.prodName ;
END // 
DELIMITER ;

-- 배송테이블에 새 배송 건을 입력하는 트리거
DROP TRIGGER IF EXISTS prodTrg;
DELIMITER // 
CREATE TRIGGER prodTrg  -- 트리거 이름
    AFTER  UPDATE 
    ON prodTBL -- 트리거를 부착할 테이블
    FOR EACH ROW 
BEGIN
    DECLARE orderAmount INT;
    -- 주문 개수 = (변경 전의 개수 - 변경 후의 개수)
    SET orderAmount = OLD.account - NEW.account;
    INSERT INTO deliverTbl(prodName, account)
        VALUES(NEW.prodName, orderAmount);
END // 
DELIMITER ;

INSERT INTO orderTbl VALUES (NULL,'JOHN', '배', 5);

SELECT * FROM orderTbl;
SELECT * FROM prodTbl;
SELECT * FROM deliverTbl;

ALTER TABLE deliverTBL CHANGE prodName productName VARCHAR(5);

INSERT INTO orderTbl VALUES (NULL, 'DANG', '사과', 9);

SELECT * FROM orderTbl;
SELECT * FROM prodTbl;
SELECT * FROM deliverTbl;

-------------------------------------------------------------

