-- 테이블 생성
CREATE TABLE ARTICLES (
  ARTICLES_ID    NUMBER,                            					 -- 게시글ID
  AUTHOR_ID      NUMBER,                            					 -- 작성자 ID (MEMBERS.MEMBER_ID와 FK)
  CATEGORY       VARCHAR2(20)		NOT NULL,                                           -- 카테고리
  TITLE          VARCHAR2(100)      NOT NULL,                            -- 제목
  CONTENT        VARCHAR2(1000)     NOT NULL,                            -- 내용
  CREATE_DATE    DATE               DEFAULT SYSDATE NOT NULL,            -- 최초등록일자
  UPDATE_DATE    DATE				NOT NULL,                                                   -- 최종수정일자
  REPLY_COUNT    NUMBER(9)          DEFAULT 0,                  		 -- 댓글수
  VIEW_COUNT     NUMBER(9)          DEFAULT 0,                  		 -- 조회수
  STATUS 	NUMBER(1) 			DEFAULT 0 NOT NULL,              	 -- 비밀글 여부 (0: 공개, 1: 비밀)

  -- 제약조건 명시
  CONSTRAINT PK_ARTICLES PRIMARY KEY (ARTICLES_ID),
  CONSTRAINT FK_ARTICLES_AUTHOR FOREIGN KEY (AUTHOR_ID)
    REFERENCES MEMBERS(MEMBERS_ID)
);

-- 시퀀스 생성
CREATE SEQUENCE SQ_ARTICLES
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-- 인덱스 생성
CREATE INDEX IDX_ARTICLES_CATEGORY     ON ARTICLES (CATEGORY);      -- 카테고리 탐색
CREATE INDEX IDX_ARTICLES_TITLE        ON ARTICLES (TITLE);         -- 제목 키워드 탐색
CREATE INDEX IDX_ARTICLES_CONTENT      ON ARTICLES (CONTENT);       -- 내용 키워드 탐색
CREATE INDEX IDX_ARTICLES_CREATE_DATE  ON ARTICLES (CREATE_DATE);   -- 등록일자 정렬
CREATE INDEX IDX_ARTICLES_VIEWS_COUNT  ON ARTICLES (VIEW_COUNT);    -- 조회수 정렬
