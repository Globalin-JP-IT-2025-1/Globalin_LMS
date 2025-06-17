-- 테이블 생성
CREATE TABLE ARTICLES (
  ARTICLES_ID    NUMBER,                            					 -- 게시글ID
  AUTHOR_ID      NUMBER,                            					 -- 작성자 ID (MEMBERS.MEMBER_ID와 FK)
  CATEGORY       VARCHAR2(3)		NOT NULL,                            -- 카테고리
  TITLE          VARCHAR2(100)      NOT NULL,                            -- 제목
  CONTENT        VARCHAR2(1000)     NOT NULL,                            -- 내용
  CREATE_DATE    DATE               DEFAULT SYSDATE NOT NULL,            -- 최초등록일자
  UPDATE_DATE    DATE				NOT NULL,                            -- 최종수정일자
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


-- 테스트
-- 공지사항 데이터 삽입 (관리자 작성)
INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, REPLY_COUNT, VIEW_COUNT, STATUS)
VALUES 
(SQ_ARTICLES.nextval, 0, 'not', '서비스 점검 안내', '시스템 점검이 예정되어 있습니다. 이용에 참고 바랍니다.', SYSDATE, SYSDATE, 0, 0, 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, REPLY_COUNT, VIEW_COUNT, STATUS)
VALUES
(SQ_ARTICLES.nextval, 0, 'not', '신규 기능 추가', '새로운 기능이 업데이트되었습니다. 자세한 내용은 공지사항을 확인하세요.', SYSDATE, SYSDATE, 0, 0, 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, REPLY_COUNT, VIEW_COUNT, STATUS)
VALUES
(SQ_ARTICLES.nextval, 0, 'not', '이벤트 개최', '다가오는 이벤트에 많은 참여 부탁드립니다.', SYSDATE, SYSDATE, 0, 0, 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, REPLY_COUNT, VIEW_COUNT, STATUS)
VALUES
(SQ_ARTICLES.nextval, 0, 'not', '정책 변경 안내', '운영 정책이 일부 변경되었습니다. 자세한 사항은 공지사항을 확인해주세요.', SYSDATE, SYSDATE, 1, 0, 0);

INSERT INTO ARTICLES (ARTICLES_ID, AUTHOR_ID, CATEGORY, TITLE, CONTENT, CREATE_DATE, UPDATE_DATE, REPLY_COUNT, VIEW_COUNT, STATUS)
VALUES
(SQ_ARTICLES.nextval, 0, 'not', '서버 업그레이드', '더 나은 서비스 제공을 위해 서버 업그레이드가 진행됩니다.', SYSDATE, SYSDATE, 0, 0, 0);


-- 인덱스 생성
CREATE INDEX IDX_ARTICLES_CATEGORY     ON ARTICLES (CATEGORY);      -- 카테고리 탐색
CREATE INDEX IDX_ARTICLES_TITLE        ON ARTICLES (TITLE);         -- 제목 키워드 탐색
CREATE INDEX IDX_ARTICLES_CONTENT      ON ARTICLES (CONTENT);       -- 내용 키워드 탐색
CREATE INDEX IDX_ARTICLES_CREATE_DATE  ON ARTICLES (CREATE_DATE);   -- 등록일자 정렬
CREATE INDEX IDX_ARTICLES_VIEWS_COUNT  ON ARTICLES (VIEW_COUNT);    -- 조회수 정렬
