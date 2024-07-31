CREATE TABLE TBL_STUDENT(
   ID NUMBER CONSTRAINT PK_STUDENT PRIMARY KEY,
   STUDENT_NAME VARCHAR2(255) NOT NULL
);

/*TBL_STUDENT 테이블에서 ID와 STUDENT_NAME 전체 조회*/
SELECT ID, STUDENT_NAME FROM TBL_STUDENT;

INSERT INTO TBL_STUDENT (ID, STUDENT_NAME)
VALUES(1, '한동석');

UPDATE TBL_STUDENT 
SET STUDENT_NAME = '홍길동'
WHERE ID = 1;

DELETE FROM TBL_STUDENT
WHERE ID = 1;
/**********************************************************************/
CREATE TABLE TBL_ZOO(
   ID NUMBER CONSTRAINT PK_ZOO PRIMARY KEY,
   ZOO_NAME VARCHAR2(255),
   ZOO_ADDRESS VARCHAR2(255),
   ZOO_ADDRESS_DETAIL VARCHAR2(255),
   ZOO_MAX_ANIMAL NUMBER DEFAULT 0
);

CREATE TABLE TBL_ANIMAL(
   ID NUMBER CONSTRAINT PK_ANIMAL PRIMARY KEY,
   ANIMAL_NAME VARCHAR2(255),
   ANIMAL_TYPE VARCHAR2(255),
   ANIMAL_AGE NUMBER DEFAULT 0,
   ANIMAL_HEIGHT NUMBER(16, 5),
   ANIMAL_WEIGHT NUMBER(16, 5),
   ZOO_ID NUMBER,
   CONSTRAINT FK_ANIMAL_ZOO FOREIGN KEY(ZOO_ID)
   REFERENCES TBL_ZOO(ID)
);

ALTER TABLE TBL_ANIMAL MODIFY(ANIMAL_HEIGHT NUMBER(16, 5));
ALTER TABLE TBL_ANIMAL MODIFY(ANIMAL_WEIGHT NUMBER(16, 5));

/*시퀀스를 직접 만들어서 사용해야 한다.*/
CREATE SEQUENCE SEQ_ZOO;

SELECT * FROM TBL_ZOO;

/*INSERT INTO TBL_ZOO(ID, ZOO_NAME, ZOO_ADDRESS, ZOO_ADDRESS_DETAIL, ZOO_MAX_ANIMAL)
VALUES(SEQ_ZOO.NEXTVAL, '서울랜드', '서울', '랜드', 100);*/
INSERT INTO TBL_ZOO
VALUES(SEQ_ZOO.NEXTVAL, '애버랜드', '경기도', '용인', 500);

SELECT ID, ZOO_NAME, ZOO_ADDRESS, ZOO_ADDRESS_DETAIL, ZOO_MAX_ANIMAL FROM TBL_ZOO;

UPDATE TBL_ZOO
SET ZOO_MAX_ANIMAL = 5000
WHERE ZOO_NAME = '애버랜드';

DELETE FROM TBL_ZOO
WHERE ID = 1;

CREATE SEQUENCE SEQ_ANIMAL;

SELECT * FROM TBL_ANIMAL;

INSERT INTO TBL_ANIMAL
VALUES(SEQ_ANIMAL.NEXTVAL, '사자', '맹수', 3, 87.5, 70.789, 2);

INSERT INTO TBL_ANIMAL
VALUES(SEQ_ANIMAL.NEXTVAL, '악어', '도마뱀', 12, 300.5, 180.789, 2);

/*애버랜드(2) 동물원의 동물만 조회*/
SELECT ID, ANIMAL_NAME, ANIMAL_TYPE, ANIMAL_AGE, ANIMAL_HEIGHT, ANIMAL_WEIGHT, ZOO_ID 
FROM TBL_ANIMAL
WHERE ZOO_ID = 2;

/**********************************************************************/
CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE
);

CREATE TABLE TBL_PRODUCT(
   ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
   PRODUCT_NAME VARCHAR2(255) NOT NULL,
   PRODUCT_PRICE NUMBER DEFAULT 0,
   PRODUCT_STOCK NUMBER DEFAULT 0
);

CREATE TABLE TBL_ORDER(
   ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
   ORDER_DATE DATE DEFAULT CURRENT_TIMESTAMP,
   MEMBER_ID NUMBER,
   PRODUCT_ID NUMBER,
   CONSTRAINT FK_ORDER_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID),
   CONSTRAINT FK_ORDER_PRODUCT FOREIGN KEY(PRODUCT_ID)
   REFERENCES TBL_PRODUCT(ID)
);

/*각 테이블에 3개 이상씩 정보를 추가하고, 조회한다.*/
CREATE SEQUENCE SEQ_MEMBER;

SELECT * FROM TBL_MEMBER;

INSERT INTO TBL_MEMBER
VALUES(SEQ_MEMBER.NEXTVAL, 'HGD123', 'LOVEHGD', '홍길동', '경기도 구리시', 'HGD123@naver.com', 
TO_DATE('2000-01-01', 'YYYY-MM-DD'));

INSERT INTO TBL_MEMBER
VALUES(SEQ_MEMBER.NEXTVAL, 'YSM123', 'YYSSMM', '양승민', '경기도 성남시', 'YSM@gmail.com', 
TO_DATE('2001-11-11', 'YYYY-MM-DD'));

INSERT INTO TBL_MEMBER
VALUES(SEQ_MEMBER.NEXTVAL, 'CRAZYMAN', 'CRAZYZY', '도라희', '서울특별시', 'crazy@naver.com', 
TO_DATE('1989-10-31', 'YYYY-MM-DD'));

CREATE SEQUENCE SEQ_PRODUCT;

SELECT * FROM TBL_PRODUCT;

INSERT INTO TBL_PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, '연필', 1500, 121);

INSERT INTO TBL_PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, '컴퓨터', 2000000, 40);

INSERT INTO TBL_PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, '사각팬티', 20000, 100);

CREATE SEQUENCE SEQ_ORDER;

SELECT * FROM TBL_ORDER;

INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER.NEXTVAL, TO_DATE('1988-10-09','YYYY-MM-DD'), 1, 1);

INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER.NEXTVAL, TO_DATE('2010-11-12','YYYY-MM-DD'), 1, 3);

INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER.NEXTVAL, TO_DATE('2024-07-08','YYYY-MM-DD'), 2, 3);


/*수정 2회*/
/*
SELECT ID, ZOO_NAME, ZOO_ADDRESS, ZOO_ADDRESS_DETAIL, ZOO_MAX_ANIMAL FROM TBL_ZOO;

UPDATE TBL_ZOO
SET ZOO_MAX_ANIMAL = 5000
WHERE ZOO_NAME = '애버랜드';
*/

SELECT ID, MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_EMAIL, MEMBER_BIRTH FROM TBL_MEMBER;

UPDATE TBL_MEMBER
SET MEMBER_ADDRESS = '경상북도 경주시'
WHERE MEMBER_NAME = '도라희';

UPDATE TBL_MEMBER
SET MEMBER_EMAIL = '746aa1357@gmail.com'
WHERE MEMBER_ID = 'YSM123';


/*삭제 2회*/
/*
DELETE FROM TBL_ZOO
WHERE ID = 1;
*/

DELETE FROM TBL_ORDER
WHERE ID = 3;

DELETE FROM TBL_MEMBER
WHERE ID = 3;

/*중고차, 차주, 등록증 DB 생성*/

CREATE TABLE TBL_CAR(
	ID NUMBER CONSTRAINT PK_CAR PRIMARY KEY,
	BRAND VARCHAR2(255) NOT NULL,
	MODEL VARCHAR2(255) NOT NULL,
	PRICE NUMBER NOT NULL,
	RELEASED_DATE DATE NOT NULL
);

CREATE TABLE TBL_OWNER(
	ID NUMBER CONSTRAINT PK_OWNER PRIMARY KEY,
	NAME VARCHAR2(255) NOT NULL,
	PHONE VARCHAR2(255) NOT NULL,
	ADDRESS VARCHAR2(255) NOT NULL
);

CREATE TABLE TBL_REGISTRATION(
	ID NUMBER CONSTRAINT PK_REGISTRATION PRIMARY KEY,
	CAR_ID NUMBER NOT NULL,
	OWNER_ID NUMBER NOT NULL,
	CONSTRAINT FK_REGISTRAION_CAR FOREIGN KEY(CAR_ID)
	REFERENCES TBL_CAR(ID),
	CONSTRAINT FK_REGISTRAION_OWNER FOREIGN KEY(OWNER_ID)
	REFERENCES TBL_OWNER(ID)
);

/*
CREATE SEQUENCE SEQ_ORDER;

SELECT * FROM TBL_ORDER;

INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER.NEXTVAL, TO_DATE('1988-10-09','YYYY-MM-DD'), 1, 1);
*/

CREATE SEQUENCE SEQ_CAR;

SELECT * FROM TBL_CAR;

INSERT INTO TBL_CAR
VALUES(SEQ_CAR.NEXTVAL, '현대', '제네시스루', 40000000, TO_DATE('2020-01-01','YYYY-MM-DD'));

INSERT INTO TBL_CAR
VALUES(SEQ_CAR.NEXTVAL, '기아', 'K3', 20000000, TO_DATE('2018-03-04','YYYY-MM-DD'));

/*SELECT * FROM TBL_OWNER;

SELECT * FROM TBL_REGISTRATION;*/









