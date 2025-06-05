-- 테이블 생성
CREATE TABLE JWT_BLACKLIST (
  JWT_BLACKLIST_ID   NUMBER,                                -- 차단된 토큰 ID
  MEMBERS_ID         NUMBER,                                -- 탈퇴한 회원 ID: MEMBERS.MEMBERS_ID
  TYPE               VARCHAR2(20)     NOT NULL,             -- 타입: 액세스토큰, 리프레시토큰
  TOKEN              VARCHAR2(500)    NOT NULL,             -- 토큰 문자열
  EXPIRES_DATE       DATE             NOT NULL,             -- 만료시간

  -- 제약조건
  CONSTRAINT PK_JWT_BLACKLIST PRIMARY KEY (JWT_BLACKLIST_ID),
  CONSTRAINT FK_JWT_BKLIST_MEM_MEMBERINFO FOREIGN KEY (MEMBERS_ID)
    REFERENCES MEMBERS(MEMBERS_ID)
);

-- 시퀀스 생성
CREATE SEQUENCE SQ_JWT_BLACKLIST
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;