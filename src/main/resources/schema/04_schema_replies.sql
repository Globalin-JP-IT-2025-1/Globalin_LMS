-- 테이블 생성
CREATE TABLE REPLIES (
  REPLIES_ID         NUMBER,                              						-- 게시글댓글ID
  ORIGIN_ARTICLE_ID  NUMBER,                              						-- 원본 게시글 ID (ARTICLES.ARTICLES_ID)
  AUTHOR_ID          NUMBER,                              						-- 작성자 ID (MEMBERS.MEMBER_ID)
  CONTENT            VARCHAR2(500)       NOT NULL,                              -- 내용
  CREATE_DATE        DATE                DEFAULT SYSDATE NOT NULL,              -- 등록일자
  UPDATE_DATE        DATE				 NOT NULL,                              -- 수정일자

  -- 제약조건
  CONSTRAINT PK_REPLIES PRIMARY KEY (REPLIES_ID),
  CONSTRAINT FK_REPLIES_MEMBERS_AUTHOR FOREIGN KEY (AUTHOR_ID)
    REFERENCES MEMBERS(MEMBERS_ID),
  CONSTRAINT FK_REPLIES_ARTICLES_ORG_ART FOREIGN KEY (ORIGIN_ARTICLE_ID)
    REFERENCES ARTICLES(ARTICLES_ID)
    ON DELETE CASCADE
);

-- 시퀀스 생성
CREATE SEQUENCE SQ_REPLIES
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;
  
-- 인덱스 생성
CREATE INDEX IDX_REPLIES_CONTENT      ON REPLIES (CONTENT);        -- 내용 키워드 탐색
CREATE INDEX IDX_REPLIES_CREATE_DATE  ON REPLIES (CREATE_DATE);    -- 등록일 정렬
