-- 테이블 생성
CREATE TABLE REFRESH_TOKEN (
	REFRESH_TOKEN_ID  NUMBER,					-- 리프레시 토큰 ID
	MEMBERS_ID		  NUMBER		NOT NULL,	-- 회원 정보: MEMBERS.MEMBERS_ID
	REFRESH_TOKEN     VARCHAR2(300)	NOT NULL,	-- SHA256 해싱된 리프레시 토큰 (비교용)
	EXPIRES_DATE      DATE			NOT NULL,	-- 만료시간
	-- IP_ADDRESS     	  VARCHAR2(16)	NOT NULL,	-- IP ADDRESS
	
	-- 제약조건
	CONSTRAINT PK_REFRESH_TOKEN PRIMARY KEY (REFRESH_TOKEN_ID),
	CONSTRAINT FK_REFRESH_TOKEN_MEMBERS_ID FOREIGN KEY (MEMBERS_ID) -- 회원 삭제 시 함께 삭제됨.
		REFERENCES MEMBERS(MEMBERS_ID) ON DELETE CASCADE
);

-- 시퀀스 생성
CREATE SEQUENCE SQ_REFRESH_TOKEN
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;