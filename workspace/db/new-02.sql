USE sqldb;

-- 1. 다음과 같은 속성을 가진 NewCustomer 테이블을 생성하시오.
--    custid(고객번호) - INTEGER, 기본키
--    name(이름) – VARCHAR(40)
--    address(주소) – VARCHAR(40)
--    phone(전화번호) – VARCHAR(30)
CREATE TABLE new_customer
(
	custid int primary key auto_increment,
    custname varchar(40) not null,
    address varchar(50) null,
    phone varchar(30) null
);

-- 3. 다음과 같은 속성을 가진 NewBook 테이블을 생성하시오. 
--    bookid(도서번호)-INTEGER
--    bookname(도서이름)-VARCHAR(20)
--    publisher(출판사)-VARCHAR(20)
--    price(가격)-INTEGER
CREATE TABLE new_book
(
	bookid int primary key auto_increment,
    bookname varchar(20) not null,
    publisher varchar(20) not null,
    price int not null
);

-- 2. 다음과 같은 속성을 가진 NewOrders 테이블을 생성하시오.
--    orderid(주문번호) - INTEGER, 기본키
--    custid(고객번호) - INTEGER, NOT NULL 제약조건, 외래키(new_customer.custid, 연쇄삭제)
--    bookid(도서번호) - INTEGER, NOT NULL 제약조건, 외래키(new_book.bookid 연쇄삭제)
--    saleprice(판매가격) - INTEGER 
--    orderdate(판매일자) – DATE
-- drop table new_orders;
CREATE TABLE new_orders
(
	orderid int primary key auto_increment,
    custid int not null,
    bookid int not null,
    saleprice int not null,
    orderdate date null,
    constraint fk_orders_to_customer FOREIGN KEY (custid) REFERENCES new_customer(custid),
    constraint fk_orders_to_book FOREIGN KEY (bookid) REFERENCES new_book(bookid)
);

-- 4. NewBook 테이블에 VARCHAR(13)의 자료형을 가진 isbn 속성을 추가하시오.
ALTER TABLE new_book
ADD isbn VARCHAR(13) NOT NULL UNIQUE;

-- 5. NewBook 테이블의 isbn 속성의 데이터 타입을 INTEGER형으로 변경하시오.
ALTER TABLE new_book
MODIFY isbn INT NOT NULL;
desc new_book;

-- 6. NewBook 테이블의 isbn 속성을 삭제하시오.
ALTER TABLE new_book
DROP COLUMN isbn;

-- 7. NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오.


-- 8. NewBook 테이블의 bookid 속성을 기본키로 변경하시오.

-- 9. NewBook 테이블을 삭제하시오
--    만약 삭제가 거절된다면 원인을 파악하고 관련된 테이블을 같이 삭제하시오(NewOrders 테이블이 NewCustomer를 참조하고 있음).
DROP TABLE new_book;

-- 10. NewCustomer 테이블을 삭제하시오. 
--   만약 삭제가 거절된다면 원인을 파악하고 관련된 테이블을 같이 삭제하시오(NewOrders 테이블이 NewCustomer를 참조하고 있음).
DROP TABLE new_customer;

DROP TABLE new_orders;
DROP TABLE new_book;
DROP TABLE new_customer;

use employees;

select * from employees limit 10;
select * from salaries;

select s.*, e.first_name, e.last_name 
from employees e, salaries s
where e.emp_no = s.emp_no;









