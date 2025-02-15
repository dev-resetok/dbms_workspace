CREATE SEQUENCE SEQ_POST;

CREATE TABLE TBL_POST(
	ID NUMBER CONSTRAINT PK_POST PRIMARY KEY,
	POST_TITLE VARCHAR2(255) NOT NULL,
	POST_CONTENT VARCHAR2(255) NOT NULL,
	MEMBER_ID NUMBER,
	CREATED_DATE DATE DEFAULT SYSDATE,
	UPDATED_DATE DATE DEFAULT SYSDATE,
	CONSTRAINT FK_POST_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID)
);